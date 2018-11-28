From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Wed, 28 Nov 2018 14:31:28 -0600
Message-ID: <20181128203128.GA178809@google.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <20181127001711.GC212532@google.com>
 <20181127085426.GI2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181127085426.GI2296@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 27, 2018 at 10:54:26AM +0200, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 06:17:11PM -0600, Bjorn Helgaas wrote:
> > Hi Mika,
> 
> Hi,
> 
> > On Mon, Nov 26, 2018 at 02:15:23PM +0300, Mika Westerberg wrote:
> > > Recent systems with Thunderbolt ports may support IOMMU natively.
> > 
> > This sentence doesn't make sense to me.  There's no logical connection
> > between having an IOMMU and having a Thunderbolt port.
> > 
> > > This means that the platform utilizes IOMMU to prevent DMA attacks
> > > over externally exposed PCIe root ports (typically Thunderbolt
> > > ports)
> > 
> > Nor this one.  The platform only uses the IOMMU to prevent DMA attacks
> > if the OS chooses to do that.

I think by "platform" you're referring to the system firmware; I was
only thinking of the hardware, so the IOMMU wouldn't be used unless
someone (the OS) enabled it.  But your cover letter talks about the
BIOS enabling some IOMMU functionality.

> I guess I'm trying to say here that the recent changes add such support
> to the platform BIOS that allows the OS to enable IOMMU without being
> compromised by a malicious device that is already connected. The BIOS
> sets the new ACPI DMAR bit in that case.

Ah, there's useful info to this effect in your [0/4] cover letter.
That info and the URL should be in the changelog of one of the patches so
it doesn't get lost.

> > > The system BIOS marks these PCIe root ports as being externally facing
> > > ports by implementing following ACPI _DSD [1] under the root port in
> > > question:
> > 
> > There's no standard that requires this, so the best we can say is that
> > a system BIOS *may* mark externally facing ports with this mechanism.
> 
> There is no standard but I'm quite sure this is something that will be
> required to be implemented properly by the OEM by Microsoft hardware
> compatibility suite.

Sure.  Your statement suggests that all external ports will be marked
with the _DSD.  I'm just pointing out that the OS can't assume that
because there are probably systems in the field that predate the _DSD.

Bjorn
