resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "challenges_certmanager_k8s_io" {
  metadata {
    labels = {
      "controller-tools.k8s.io" = "1.0"
    }
    name = "challenges.certmanager.k8s.io"
  }
  spec {

    additional_printer_columns {
      json_path = ".status.state"
      name      = "State"
      type      = "string"
    }
    additional_printer_columns {
      json_path = ".spec.dnsName"
      name      = "Domain"
      type      = "string"
    }
    additional_printer_columns {
      json_path = ".status.reason"
      name      = "Reason"
      priority  = 1
      type      = "string"
    }
    additional_printer_columns {
      json_path   = ".metadata.creationTimestamp"
      description = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
      name        = "Age"
      type        = "date"
    }
    group = "certmanager.k8s.io"
    names {
      kind   = "Challenge"
      plural = "challenges"
    }
    scope = "Namespaced"
    validation {
      open_apiv3_schema = <<-JSON
        {
          "type": "object",
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "properties": {
                "authzURL": {
                  "description": "AuthzURL is the URL to the ACME Authorization resource that this challenge is a part of.",
                  "type": "string"
                },
                "config": {
                  "description": "Config specifies the solver configuration for this challenge. Only **one** of 'config' or 'solver' may be specified, and if both are specified then no action will be performed on the Challenge resource. DEPRECATED: the 'solver' field should be specified instead",
                  "type": "object"
                },
                "dnsName": {
                  "description": "DNSName is the identifier that this challenge is for, e.g. example.com.",
                  "type": "string"
                },
                "issuerRef": {
                  "description": "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed.",
                  "properties": {
                    "group": {
                      "type": "string"
                    },
                    "kind": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "name"
                  ],
                  "type": "object"
                },
                "key": {
                  "description": "Key is the ACME challenge key for this challenge",
                  "type": "string"
                },
                "solver": {
                  "description": "Solver contains the domain solving configuration that should be used to solve this challenge resource. Only **one** of 'config' or 'solver' may be specified, and if both are specified then no action will be performed on the Challenge resource.",
                  "properties": {
                    "selector": {
                      "description": "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.",
                      "properties": {
                        "dnsNames": {
                          "description": "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                          "items": {
                            "type": "string"
                          },
                          "type": "array"
                        },
                        "dnsZones": {
                          "description": "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                          "items": {
                            "type": "string"
                          },
                          "type": "array"
                        },
                        "matchLabels": {
                          "description": "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.",
                          "type": "object"
                        }
                      },
                      "type": "object"
                    }
                  },
                  "type": "object"
                },
                "token": {
                  "description": "Token is the ACME challenge token for this challenge.",
                  "type": "string"
                },
                "type": {
                  "description": "Type is the type of ACME challenge this resource represents, e.g. \"dns01\" or \"http01\"",
                  "type": "string"
                },
                "url": {
                  "description": "URL is the URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge.",
                  "type": "string"
                },
                "wildcard": {
                  "description": "Wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'",
                  "type": "boolean"
                }
              },
              "required": [
                "authzURL",
                "type",
                "url",
                "dnsName",
                "token",
                "key",
                "wildcard",
                "issuerRef"
              ],
              "type": "object"
            },
            "status": {
              "properties": {
                "presented": {
                  "description": "Presented will be set to true if the challenge values for this challenge are currently 'presented'. This *does not* imply the self check is passing. Only that the values have been 'submitted' for the appropriate challenge mechanism (i.e. the DNS01 TXT record has been presented, or the HTTP01 configuration has been configured).",
                  "type": "boolean"
                },
                "processing": {
                  "description": "Processing is used to denote whether this challenge should be processed or not. This field will only be set to true by the 'scheduling' component. It will only be set to false by the 'challenges' controller, after the challenge has reached a final state or timed out. If this field is set to false, the challenge controller will not take any more action.",
                  "type": "boolean"
                },
                "reason": {
                  "description": "Reason contains human readable information on why the Challenge is in the current state.",
                  "type": "string"
                },
                "state": {
                  "description": "State contains the current 'state' of the challenge. If not set, the state of the challenge is unknown.",
                  "enum": [
                    "",
                    "valid",
                    "ready",
                    "pending",
                    "processing",
                    "invalid",
                    "expired",
                    "errored"
                  ],
                  "type": "string"
                }
              },
              "required": [
                "processing",
                "presented",
                "reason"
              ],
              "type": "object"
            }
          },
          "required": [
            "metadata",
            "spec",
            "status"
          ]
        }
        JSON
    }
    version = "v1alpha1"
  }
}