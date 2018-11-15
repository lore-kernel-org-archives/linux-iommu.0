From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 13:07:36 +0100
Message-ID: <20181115120736.pscly6zwd3k2tvd2@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115113737.GW2500@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 01:37:37PM +0200, Mika Westerberg wrote:
> On Thu, Nov 15, 2018 at 11:13:56AM +0000, Lorenzo Pieralisi wrote:
> > I have strong objections to the way these bindings have been forced upon
> > everybody; if that's the way *generic* ACPI bindings are specified I
> > wonder why there still exists an ACPI specification and related working
> > group.
> > 
> > I personally (but that's Bjorn and Rafael choice) think that this is
> > not a change that belongs in PCI core, ACPI bindings are ill-defined
> > and device tree bindings are non-existing.
> 
> Any idea where should I put it then? These systems are already out there
> and we need to support them one way or another.

I suppose those are all Thunderbolt, so could be handled by the
existing ->is_thunderbolt bit?

It was said in this thread that ->is_external is more generic in
that it could also be used on PCIe slots, however that use case
doesn't appear to lend itself to the "plug in while laptop owner
is getting coffee" attack.  To access PCIe slots on a server you
normally need access to a data center.  On a desktop, you usually
have to open the case, by which time the coffee may already have
been fetched.  So frankly the binding seems a bit over-engineered
to me and yet another thing that BIOS writers may get wrong.

Well, just my 2 cents anyway.

Lukas
