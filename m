From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Tue, 13 Nov 2018 10:56:36 +0000
Message-ID: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112160628.86620-2-mika.westerberg@linux.intel.com>
	<20181112180203.lx72gjfplb6xlur7@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181112180203.lx72gjfplb6xlur7-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:02:03PM +0100, Lukas Wunner wrote:
> On Mon, Nov 12, 2018 at 07:06:25PM +0300, Mika Westerberg wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > +static void set_pcie_external(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *parent;
> > +
> > +	/*
> > +	 * Walk up the device hierarchy and check for any upstream
> > +	 * bridge that has is_external_facing set to true. This means
> > +	 * the hierarchy is below PCIe port that is exposed externally
> > +	 * (such as Thunderbolt).
> > +	 */
> > +	parent = pci_upstream_bridge(dev);
> > +	while (parent) {
> > +		if (parent->is_external) {
> > +			dev->is_external = true;
> > +			break;
> > +		}
> > +
> > +		parent = pci_upstream_bridge(parent);
> > +	}
> > +}
> > +
> 
> This looks pretty much like a duplication of the is_thunderbolt bit
> in struct pci_dev and the pci_is_thunderbolt_attached() helper.
> 
> Why constrain the functionality to ports with the _DSD property
> instead of making it available for *any* Thunderbolt port?

I assume it is because this is just not needed for Thuderbolt ports but
rather for all PCIe devices that are "external" (whatever that is
supposed to mean), ie it is valid also for PCIe slots.

To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
and not thoroughly defined and I would question its detection at
PCI/ACPI core level, I would hope this can be clarified at ACPI
specification level, at least.

Thanks,
Lorenzo
