From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Mon, 16 Apr 2012 15:34:19 +0000
Message-ID: <201204161534.20089.arnd@arndb.de>
References: <20120413.143104.1310879848248152784.hdoyu@nvidia.com>
	<4F887DA0.8030103@wwwdotorg.org>
	<20120416.141238.381304581863200083.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120416.141238.381304581863200083.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 16 April 2012, Hiroshi Doyu wrote:
> What about using "dma-window" property to specify IOVA range in dtsi as below?
> 
> arch/powerpc/platforms/cell/iommu.c:
> 
> 698 static int __init cell_iommu_get_window(struct device_node *np,
> 699                                          unsigned long *base,
> 700                                          unsigned long *size)
> 701 {
> 702         const void *dma_window;
> 703         unsigned long index;
> 704
> 705         /* Use ibm,dma-window if available, else, hard code ! */
> 706         dma_window = of_get_property(np, "ibm,dma-window", NULL);
> 707         if (dma_window == NULL) {          ^^^^^^^^^^^^^^
> 708                 *base = 0;
> 709                 *size = 0x80000000u;
> 710                 return -ENODEV;
> 711         }
> 712
> 713         of_parse_dma_window(np, dma_window, &index, base, size);
> 714         return 0;
> 715 }
> 

Yes, that's the right way to do it, but I would use the more generic
"dma-window" name rather than "ibm,dma-window", which was originally
introduced for pseries and for some reason copied into the cell qs2x
firmware.

	Arnd
