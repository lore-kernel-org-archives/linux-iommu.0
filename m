From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 11:13:56 +0000
Message-ID: <20181115111356.GA599@e107981-ln.cambridge.arm.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115102239.GU2500@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 12:22:39PM +0200, Mika Westerberg wrote:
> On Tue, Nov 13, 2018 at 11:45:36AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Nov 13, 2018 at 01:27:00PM +0200, Mika Westerberg wrote:
> > 
> > [...]
> > 
> > > > To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
> > > > and not thoroughly defined and I would question its detection at
> > > > PCI/ACPI core level, I would hope this can be clarified at ACPI
> > > > specification level, at least.
> > > 
> > > I guess that is the way they envision to use _DSD. Instead of having
> > > single UUID that covers all properties (like what we have with device
> > > properties) they have one UUID per property "class". I certainly hope we
> > > don't need to keep extending prp_guids[] array each time they invent
> > > another "class" of properties.
> > 
> > It is even worse than that. This is a unilateral/obscure change that
> > won't be part of ACPI specifications (I guess it was easier to add a
> > UUID than add this to the ACPI specifications through the AWSG) but it
> > is still supposed to be applicable to ACPI PCI bindings on any
> > platforms/arches; this way of adding bindings does not work and it
> > has to be rectified.
> 
> I agree.
> 
> For the existing property "classes" such as the one here I don't think
> we can do anything. There are systems already with these included in
> their ACPI tables.
> 
> I wonder if you have any objections regarding this patch?

I have strong objections to the way these bindings have been forced upon
everybody; if that's the way *generic* ACPI bindings are specified I
wonder why there still exists an ACPI specification and related working
group.

I personally (but that's Bjorn and Rafael choice) think that this is
not a change that belongs in PCI core, ACPI bindings are ill-defined
and device tree bindings are non-existing.

At the very least Microsoft should be asked to publish and discuss
these bindings within the ACPI and UEFI forums.

Lorenzo
