From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Tue, 13 Nov 2018 13:27:00 +0200
Message-ID: <20181113112700.GT2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lukas Wunner <lukas@wunner.de>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 10:56:36AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 12, 2018 at 07:02:03PM +0100, Lukas Wunner wrote:
> > On Mon, Nov 12, 2018 at 07:06:25PM +0300, Mika Westerberg wrote:
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
> > >  	}
> > >  }
> > >  
> > > +static void set_pcie_external(struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *parent;
> > > +
> > > +	/*
> > > +	 * Walk up the device hierarchy and check for any upstream
> > > +	 * bridge that has is_external_facing set to true. This means
> > > +	 * the hierarchy is below PCIe port that is exposed externally
> > > +	 * (such as Thunderbolt).
> > > +	 */
> > > +	parent = pci_upstream_bridge(dev);
> > > +	while (parent) {
> > > +		if (parent->is_external) {
> > > +			dev->is_external = true;
> > > +			break;
> > > +		}
> > > +
> > > +		parent = pci_upstream_bridge(parent);
> > > +	}
> > > +}
> > > +
> > 
> > This looks pretty much like a duplication of the is_thunderbolt bit
> > in struct pci_dev and the pci_is_thunderbolt_attached() helper.
> > 
> > Why constrain the functionality to ports with the _DSD property
> > instead of making it available for *any* Thunderbolt port?
> 
> I assume it is because this is just not needed for Thuderbolt ports but
> rather for all PCIe devices that are "external" (whatever that is
> supposed to mean), ie it is valid also for PCIe slots.

Yes, that was the idea. We could have other "external" devices that are
not using Thunderbolt as the interconnect.

We could do so that we automatically set "is_external" for devices with
"is_thunderbolt" so it should cover those as well.

> To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
> and not thoroughly defined and I would question its detection at
> PCI/ACPI core level, I would hope this can be clarified at ACPI
> specification level, at least.

I guess that is the way they envision to use _DSD. Instead of having
single UUID that covers all properties (like what we have with device
properties) they have one UUID per property "class". I certainly hope we
don't need to keep extending prp_guids[] array each time they invent
another "class" of properties.
