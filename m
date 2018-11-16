From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Fri, 16 Nov 2018 09:01:25 +0200
Message-ID: <20181116070125.GG4179@lahna.fi.intel.com>
References: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115190054.GD4179@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lukas Wunner <lukas@wunner.de>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 09:00:54PM +0200, Mika Westerberg wrote:
> On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> 
> Yes, we need to parse it one way or another. dev->is_thunderbolt is
> based on heuristics which do not apply anymore when the thing gets
> integrated in the SoC.
> 
> The _DSD is there already (on existing systems) and is being used by
> Windows so I don't understand why we cannot take advantage of it? Every
> new system with Thunderbolt ports will have it.

Just to clarify a bit. We can use is_thunderbolt in place of is_external
if we don't want to deal with other possible "external" devices right now.

However, we still need to parse the _DSD and based on that fill the
is_thunderbolt for these devices (same way we do for is_external in this
series). So basically we just get rid of the is_external flag and use
is_thunderbolt instead.
