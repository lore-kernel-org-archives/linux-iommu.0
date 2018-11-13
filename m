From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Date: Tue, 13 Nov 2018 12:36:16 +0200
Message-ID: <20181113103616.GQ2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com, andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, lukas@wunner.de, ckellner@redhat.com, anthony.wong@canonical.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 04:22:25PM +0000, Mario.Limonciello@dell.com wrote:
> > +DMA protection utilizing IOMMU
> > +------------------------------
> > +Recent systems shipping with Windows 10 version 1803 or later may support a
> > +feature called `Kernel DMA Protection for Thunderbolt 3`_.  This means that
> 
> Keep in mind there will be systems that ship with Linux that enable this feature too ;)

Yes, you are absolutely right. I sometimes forgot that fact ;-)

> It might be better to make it time frame and platform  firmware oriented as it's
> entirely possible for an OEM to have a field firmware upgrade that may enable this
> functionality from the platform and allow an end user to upgrade to a sufficiently
> protected kernel or Windows OS to take advantage of it.

I agree. I will update this in the next version.
