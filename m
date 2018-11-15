From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 21:32:01 +0200
Message-ID: <20181115193201.GF4179@lahna.fi.intel.com>
References: <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181115192741.4ugt6usmsemokxle@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115192741.4ugt6usmsemokxle@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Yehezkel Bernat <yehezkelshb@gmail.com>, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, baolu.lu@linux.intel.com, ashok.raj@intel.com, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 08:27:41PM +0100, Lukas Wunner wrote:
> On Thu, Nov 15, 2018 at 09:10:26PM +0200, Mika Westerberg wrote:
> > I was thinking we could cover all these with is_external filling them
> > based on the _DSD or some other means in the kernel.
> > 
> > We would then deal all such devices as "untrusted" by default.
> 
> Tinfoil hat on, even internal devices could be malicious.
> What's the downside of enabling the feature for everything?

Mostly performance, I think. That's the main reason we put all non
external devices to passthrough IOMMU mode.
