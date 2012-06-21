From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/tegra: smmu: Add DMA window parser, of_get_dma_window()
Date: Thu, 21 Jun 2012 00:57:55 -0600
Message-ID: <4FE2C5F3.1010007@wwwdotorg.org>
References: <20120521124707.GC2604@amd.com><1340176620-13012-1-git-send-email-hdoyu@nvidia.com><4FE20457.8090307@wwwdotorg.org> <20120621.094611.2108645748323641310.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120621.094611.2108645748323641310.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/21/2012 12:46 AM, Hiroshi Doyu wrote:
...
> There are the following 3 users of of_parse_dma_window() as below. All
> of them are IOMMU related, but they are architecture specific ones,
> not for the standard IOMMU API. I guess that the current trend is to
> convert Arch specific IOMMU API to the standard one basically.
> 
>   arch/powerpc/kernel/vio.c 	of_parse_dma_window(dev->dev.of_node, dma_window,
>   arch/powerpc/platforms/cell/iommu.c 	of_parse_dma_window(np, dma_window, &index, base, size);
>   arch/powerpc/platforms/pseries/iommu.c 	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
> 
> I think that the common "dma-window" DT parser is necessary for the
> standard IOMMU because "dma-window" info is dealt as
> DOMAIN_ATTR_GEOMETRY in the following Joerg's patch too.
> 
>   [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
>     https://lkml.org/lkml/2012/1/19/170
> 
> If it's ok to have of_get_dma_window() in "drivers/iommu/of_iommu.c",
> I'll post that version.

Sounds sane to me.
