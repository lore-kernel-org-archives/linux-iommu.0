From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH - v7] of: Move of_dma_configure() to device.c to help re-use
Date: Mon, 2 Mar 2015 21:43:48 -0600
Message-ID: <CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g@mail.gmail.com>
References: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425333548-8802-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 2, 2015 at 3:59 PM, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> Move of_dma_configure() to device.c so it can be re-used for PCI devices to
> obtain DMA configuration from DT.  Also add a second argument so that for
> PCI, the DT node of root bus host bridge can be used to obtain the DMA
> configuration for the slave PCI device.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> (AMD Seattle)
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> CC: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
>  - Based on the existing patch applied to arm-pci/pci/iommu for pci next (Bjorn)
>  - Fixed the build issue reported on ARCH=x86_64

Hi Murali,

Can you please repost the entire series with fixed patches?  It's
easier for me to reapply the whole thing at once than it is to keep
track of and fiddle with individual patches.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
