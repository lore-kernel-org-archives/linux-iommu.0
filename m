From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Tue, 27 Nov 2018 17:49:53 +0100
Message-ID: <CAJZ5v0gxap5qWQTrmrTmzfvL0RerZ1T1MUPyh6b1FAHY9N0Ryw@mail.gmail.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com> <20181127001711.GC212532@google.com>
 <20181127085426.GI2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127085426.GI2296@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>ACPI Devel Maling List <lin>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 27, 2018 at 9:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
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
>
> I guess I'm trying to say here that the recent changes add such support
> to the platform BIOS that allows the OS to enable IOMMU without being
> compromised by a malicious device that is already connected. The BIOS
> sets the new ACPI DMAR bit in that case.
>
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

I think it would be fair to say that future versions of Windows will
expect the firmware to identify the "externally facing" root PCIe
ports as per the above which practically means that it is as good as a
formal standard in the Windows world.
