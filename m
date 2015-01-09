From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 2/4] of: move of_dma_configure() to device,c to help re-use
Date: Fri, 09 Jan 2015 01:05:11 +0100
Message-ID: <2405706.Bhe0GramZJ@wuerfel>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com> <2083932.v1GzgAfexK@wuerfel> <54AF165F.7070909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54AF165F.7070909-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 08 January 2015 18:44:31 Murali Karicheri wrote:
> The grep of dma-ranges for arch/arm shows the size used is mask + 1 as
> 
> ./boot/dts/keystone.dtsi:               dma-ranges = <0x80000000 0x8 0x00000000 
> 0x80000000>;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/r8a7790.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/integratorap.dts:    dma-ranges = <0x80000000 0x0 0x80000000>;
> ./boot/dts/r8a7791.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> 
> So for ARM 32 the below case doesn't seem to apply.
> 

Ah, I guess that is because an empty dma-ranges property serves the same
purpose.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
