From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Fri, 16 Nov 2018 11:32:10 +0200
Message-ID: <20181116093210.GK4179@lahna.fi.intel.com>
References: <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181116091804.GA4548@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116091804.GA4548@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Yehezkel Bernat <yehezkelshb@gmail.com>, ashok.raj@intel.com, Mario Limonciello <Mario.Limonciello@dell.com>, michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>, rjw@rjwysocki.net, Anthony Wong <anthony.wong@canonical.com>, LKML <linux-kernel@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, iommu@lists.linux-foundation.org, lukas@wunner.de, jacob.jun.pan@intel.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 16, 2018 at 01:18:04AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 09:10:26PM +0200, Mika Westerberg wrote:
> > FireWire is kind of different but there are connectors such as
> > ExpressCard and NVMe (over U.2 connector) which carry PCIe and are
> > relatively easy to access without need for a screwdriver. AFAIK some
> > eGPUs are also using some other proprietary (non-TBT) connector that
> > carries PCIe.
> 
> U.2 is a data center internal form factor with hot plug capability. If
> you enable an iommu for that by default you will make a lot of people
> very unhappy.

Well, it needs the other bit in ACPI DMAR table to be enabled by default
so I don't think anyone in data center domain will notice ;-)

> More importantly NVMe is now used for the current/next generation
> Compact Flash and SD cards, which contain full PCIe gen 3 links.

OK, thanks for the information - I did not know that. I guess those
belong to the "external" category as well.
