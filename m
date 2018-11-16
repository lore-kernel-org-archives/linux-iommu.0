From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Fri, 16 Nov 2018 10:57:38 +0000
Message-ID: <20181116105738.GA21277@red-moon>
References: <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
 <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: mika.westerberg@linux.intel.com, lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com, andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, ckellner@redhat.com, anthony.wong@canonical.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 07:33:54PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Thursday, November 15, 2018 1:01 PM
> > To: Lorenzo Pieralisi
> > Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> > Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob jun Pan;
> > Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonciello,
> > Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> > 
> > Yes, we need to parse it one way or another. dev->is_thunderbolt is
> > based on heuristics which do not apply anymore when the thing gets
> > integrated in the SoC.
> > 
> > The _DSD is there already (on existing systems) and is being used by
> > Windows so I don't understand why we cannot take advantage of it? Every
> > new system with Thunderbolt ports will have it.

We have different opinions on this, there is no point in me reiterating
it over and over, I am against the approach taken to solve this problem
first in defining the bindings outside the ACPI specifications and
second by acquiescing to what has been done so that it will be done
over and over again.

I will raise the point in the appropriate forum, it is up to Bjorn
and Rafael to decide on this patch.

Lorenzo
