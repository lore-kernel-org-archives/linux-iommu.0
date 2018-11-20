From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Tue, 20 Nov 2018 22:43:35 +0100
Message-ID: <35089177.HEBOdrcs2c@aspire.rjw.lan>
References: <20181113112700.GT2500@lahna.fi.intel.com> <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM> <20181116105738.GA21277@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116105738.GA21277@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com, lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, jacob.jun.pan@intel.com, andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, ckellner@redhat.com, anthony.wong@canonical.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Friday, November 16, 2018 11:57:38 AM CET Lorenzo Pieralisi wrote:
> On Thu, Nov 15, 2018 at 07:33:54PM +0000, Mario.Limonciello@dell.com wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Thursday, November 15, 2018 1:01 PM
> > > To: Lorenzo Pieralisi
> > > Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> > > Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob jun Pan;
> > > Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonciello,
> > > Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
> > > 
> > > 
> > > [EXTERNAL EMAIL]
> > > 
> > > On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > > > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> > > 
> > > Yes, we need to parse it one way or another. dev->is_thunderbolt is
> > > based on heuristics which do not apply anymore when the thing gets
> > > integrated in the SoC.
> > > 
> > > The _DSD is there already (on existing systems) and is being used by
> > > Windows so I don't understand why we cannot take advantage of it? Every
> > > new system with Thunderbolt ports will have it.
> 
> We have different opinions on this, there is no point in me reiterating
> it over and over, I am against the approach taken to solve this problem
> first in defining the bindings outside the ACPI specifications and
> second by acquiescing to what has been done so that it will be done
> over and over again.

Arguably, however, we are on the receiving end of things here and even if
we don't use this binding, that won't buy us anything (but it will introduce
a fair amount of disappointment among both users and OEMs).

If Windows uses it, then systems will ship with it regardless of what Linux
does with it, so your "acquiescing to what has been done" argument leads to
nowhere in this particular case.  It's just a matter of whether or not
Linux will provide the same level of functionality as Windows with respect
to this and IMO it would be impractical to refuse to do that for purely
formal reasons.

> I will raise the point in the appropriate forum, it is up to Bjorn
> and Rafael to decide on this patch.

For the record, my opinion is that there's a little choice on whether or not
to use this extra information that firmware is willing to give us.  It could
be defined in a better way and so on, but since it is in use anyway, we really
have nothing to gain by refusing to use it.

Now, where the handling of it belongs to is a separate matter that should be
decided on its own.

Thanks,
Rafael
