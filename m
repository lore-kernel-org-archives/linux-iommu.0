From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
	mode
Date: Tue, 14 Aug 2018 09:35:01 +0100
Message-ID: <20180814083500.GA28101@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
	<1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
	<89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
	<5B597628.2020103@huawei.com>
	<04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
	<1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
	<5B7293E5.7040702@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5B7293E5.7040702-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown) wrote:
> On 2018/8/6 9:32, Yang, Shunyong wrote:
> > On 2018/7/26 22:37, Robin Murphy wrote:
> >> Because DMA code is not the only caller of iommu_map/unmap. It's 
> >> perfectly legal in the IOMMU API to partially unmap a previous mapping 
> >> such that a block entry needs to be split. The DMA API, however, is a 
> >> lot more constrined, and thus by construction the iommu-dma layer will 
> >> never generate a block-splitting iommu_unmap() except as a result of 
> >> illegal DMA API usage, and we obviously do not need to optimise for that 
> >> (you will get a warning about mismatched unmaps under dma-debug, but 
> >> it's a bit too expensive to police in the general case).
> >>
> > 
> > When I was reading the code around arm_lpae_split_blk_unmap(), I was
> > curious in which scenario a block will be split. Now with your comments
> > "Because DMA code is not the only caller of iommu_map/unmap", it seems
> > depending on the user.
> > 
> > Would you please explain this further? I mean besides DMA, which user
> > will use iommu_map/umap and how it split a block.
> 
> I also think that arm_lpae_split_blk_unmap() scenario is not exist, maybe
> we should remove it, and give a warning for this wrong usage.

Can't it happen with VFIO?

Will
