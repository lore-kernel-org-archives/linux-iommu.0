From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Mon, 12 Nov 2018 19:02:03 +0100
Message-ID: <20181112180203.lx72gjfplb6xlur7@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-2-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:06:25PM +0300, Mika Westerberg wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	}
>  }
>  
> +static void set_pcie_external(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +
> +	/*
> +	 * Walk up the device hierarchy and check for any upstream
> +	 * bridge that has is_external_facing set to true. This means
> +	 * the hierarchy is below PCIe port that is exposed externally
> +	 * (such as Thunderbolt).
> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	while (parent) {
> +		if (parent->is_external) {
> +			dev->is_external = true;
> +			break;
> +		}
> +
> +		parent = pci_upstream_bridge(parent);
> +	}
> +}
> +

This looks pretty much like a duplication of the is_thunderbolt bit
in struct pci_dev and the pci_is_thunderbolt_attached() helper.

Why constrain the functionality to ports with the _DSD property
instead of making it available for *any* Thunderbolt port?

Thanks,

Lukas
