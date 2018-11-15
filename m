From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 21:10:26 +0200
Message-ID: <20181115191026.GE4179@lahna.fi.intel.com>
References: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yehezkel Bernat <yehezkelshb@gmail.com>
Cc: lorenzo.pieralisi@arm.com, lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, baolu.lu@linux.intel.com, ashok.raj@intel.com, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 07:58:13PM +0200, Yehezkel Bernat wrote:
> From what I know, there are more devices that suffer from similar security
> issues like Thunderbolt, e.g. FireWire [1].
> My assumption is that the same protection may be applied to such devices too,
> even if currently it sounds like vendors care mostly about Thunderbolt (probably
> because it removes the need for user approval for device connection; it becames
> a simple plug-and-play experience).

FireWire is kind of different but there are connectors such as
ExpressCard and NVMe (over U.2 connector) which carry PCIe and are
relatively easy to access without need for a screwdriver. AFAIK some
eGPUs are also using some other proprietary (non-TBT) connector that
carries PCIe.

I was thinking we could cover all these with is_external filling them
based on the _DSD or some other means in the kernel.

We would then deal all such devices as "untrusted" by default.

> Thus, I don't think binding it with dev->is_thunderbolt is the correct
> thing to do.

One option that I suggested already is that we keep both and mark all
is_thunderbolt devices as is_external as well. But I guess this is up to
Bjorn and Rafael to decide :-)
