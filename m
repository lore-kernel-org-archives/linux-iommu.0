From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Fri, 9 Oct 2015 19:19:29 +0100
Message-ID: <20151009181929.GU26278@arm.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	<1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
	<20150916155824.GM28771@arm.com>
	<1442501662.8145.151.camel@mhfsdcap03>
	<1442931167.17514.39.camel@mhfsdcap03>
	<20151009155750.GS26278@arm.com> <5617FC5F.60505@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5617FC5F.60505-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz@goo>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 09, 2015 at 06:41:51PM +0100, Robin Murphy wrote:
> On 09/10/15 16:57, Will Deacon wrote:
> >On Tue, Sep 22, 2015 at 03:12:47PM +0100, Yong Wu wrote:
> >>      I would like to show you a problem I met, The recursion here may
> >>lead to stack overflow while we test FHD video decode.
> >>
> >>     From the log, I get the internal variable in the error case: the
> >>"size" is 0x100000, the "iova" is 0xfea00000, but at that time the
> >>"blk_size" is 0x1000 as it was the map of small-page. so it enter the
> >>recursion here.
> >>
> >>     After check the unmap flow, there is only a iommu_unmap in
> >>__iommu_dma_unmap, and it won't check the physical address align in
> >>iommu_unmap.
> >
> >That sounds like a bug in __iommu_dma_unmap. Robin?
> 
> Isn't it just cf27ec930be9 again wearing different trousers? All I do is
> call iommu_unmap with the same total size that was mapped originally.

I don't think it's the same as that issue, which was to do with installing
block mappings over the top of an existing table entry. The problem here
seems to be that we don't walk the page table properly on unmap.

The long descriptor code has:

	/* If the size matches this level, we're in the right place */
	if (size == blk_size) {
		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg);

		if (!iopte_leaf(pte, lvl)) {
			/* Also flush any partial walks */
			tlb->tlb_add_flush(iova, size, false, cookie);
			tlb->tlb_sync(cookie);
			ptep = iopte_deref(pte, data);
			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
		} else {
			tlb->tlb_add_flush(iova, size, true, cookie);
		}

		return size;
	} else if (iopte_leaf(pte, lvl)) {
		/*
		 * Insert a table at the next level to map the old region,
		 * minus the part we want to unmap
		 */
		return arm_lpae_split_blk_unmap(data, iova, size,
						iopte_prot(pte), lvl, ptep,
						blk_size);
	}

why doesn't something similar work for short descriptors?

Will
