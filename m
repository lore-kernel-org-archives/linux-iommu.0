From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH - v7] of: Move of_dma_configure() to device.c to help
 re-use
Date: Thu, 19 Mar 2015 10:02:24 -0500
Message-ID: <20150319150224.GB26935@google.com>
References: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
 <CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g@mail.gmail.com>
 <54F5F59C.5000603@ti.com>
 <CAErSpo5gPVqRrzZ3LbWvLRchr6SjxN0eve62dTJamfz+=O882Q@mail.gmail.com>
 <54F63BA1.8030708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F63BA1.8030708-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 03, 2015 at 05:54:25PM -0500, Murali Karicheri wrote:
> On 03/03/2015 03:53 PM, Bjorn Helgaas wrote:
> >[+cc linux-pci]
> >
> >On Tue, Mar 3, 2015 at 11:55 AM, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>  wrote:
> >>On 03/02/2015 10:43 PM, Bjorn Helgaas wrote:
> >>>
> >>>On Mon, Mar 2, 2015 at 3:59 PM, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
> >>>wrote:
> >>>>
> >>>>Move of_dma_configure() to device.c so it can be re-used for PCI devices
> >>>>to
> >>>>obtain DMA configuration from DT.  Also add a second argument so that for
> >>>>PCI, the DT node of root bus host bridge can be used to obtain the DMA
> >>>>configuration for the slave PCI device.
> >>>>
> >>>>Tested-by: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>   (AMD
> >>>>Seattle)
> >>>>Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
> >>>>Signed-off-by: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >>>>Reviewed-by: Catalin Marinas<catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> >>>>Acked-by: Will Deacon<will.deacon-5wv7dgnIgG8@public.gmane.org>
> >>>>CC: Joerg Roedel<joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> >>>>CC: Grant Likely<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>>CC: Rob Herring<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>>CC: Russell King<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> >>>>CC: Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>
> >>>>---
> >>>>   - Based on the existing patch applied to arm-pci/pci/iommu for pci next
> >>>>(Bjorn)
> >>>>   - Fixed the build issue reported on ARCH=x86_64
> >>>
> >>>
> >>>Hi Murali,
> >>>
> >>>Can you please repost the entire series with fixed patches?  It's
> >>>easier for me to reapply the whole thing at once than it is to keep
> >>>track of and fiddle with individual patches.
> >>>
> >>>Bjorn
> >>
> >>Bjorn,
> >>
> >>Ok. I have just posted v8 of the series including all patches.
> >
> >Thanks, I put them on a pci/murali-v8 branch for now.  I'm assuming
> >you want them to go through my tree.  In the cover letter, you
> >mentioned the "arm-pci iommu branch", so if that means you want them
> >via an ARM tree instead of mine, just let me know.  I assume the build
> >will be clean and I'll rename it back to pci/iommu.
> 
> My bad. It should have beem pci/iommu. My remote was named arm-pci
> and hence the confusion. Please apply it to the pci/iommu branch.

Applied to pci/iommu for v4.1, thanks!

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
