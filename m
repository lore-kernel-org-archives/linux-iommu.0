From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Tue, 4 Dec 2018 10:57:35 +0200
Message-ID: <20181204085735.GR3078@lahna.fi.intel.com>
References: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
 <20181129155153.35840-2-mika.westerberg@linux.intel.com>
 <20181204002800.GB85090@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204002800.GB85090@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 03, 2018 at 06:28:00PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 29, 2018 at 06:51:50PM +0300, Mika Westerberg wrote:
> > A malicious PCI device may use DMA to attack the system. An external
> > Thunderbolt port is a convenient point to attach such a device. The OS
> > may use IOMMU to defend against DMA attacks.
> > 
> > Recent BIOSes with Thunderbolt ports mark these externally facing root
> > ports with this ACPI _DSD [1]:
> 
> I'm not 100% comfortable with the "Recent BIOSes" wording because that
> suggests that we can rely on the fact that *all* BIOSes newer than
> some date X mark these ports.
> 
> Since this _DSD usage is Microsoft-specific and not required by either
> PCIe or ACPI specs, we can't rely on it.  A BIOS that doesn't
> implement it may not be Windows-certified, but it's perfectly
> spec-compliant otherwise and we have to keep in mind the possibility
> that ports without this _DSD may still be externally visible and may
> still be attack vectors.

OK.

I will change it to "Some BIOSes .." following what you suggested
earlier. That should make it clear not all BIOSes are required to
implement this.

> >   Name (_DSD, Package () {
> >       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
> >       Package () {
> >           Package () {"ExternalFacingPort", 1},
> > 	  Package () {"UID", 0 }
> >       }
> >   })
> > 
> > If we find such a root port, mark it and all its children as untrusted.
> > The rest of the OS may use this information to enable DMA protection
> > against malicious devices. For instance the device may be put behind an
> > IOMMU to keep it from accessing memory outside of what the driver has
> > allocated for it.
> > 
> > While at it, add a comment on top of prp_guids array explaining the
> > possible caveat resulting when these GUIDs are treated equivalent.
> > 
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
