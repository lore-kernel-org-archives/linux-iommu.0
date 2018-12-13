From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Don't check PHYS_OFFSET if
 RAMDOMIZE_BASE is enabled
Date: Thu, 13 Dec 2018 10:24:15 +0800
Message-ID: <1544667855.8755.7.camel@mhfsdcap03>
References: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
         <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-12-12 at 13:39 +0000, Robin Murphy wrote:
> On 12/12/2018 13:02, Yong Wu wrote:
> > If CONFIG_RANDOMIZE_BASE is enabled, the "memstart_addr" will be updated
> > randomly, then the PHYS_OFFSET may be random.
> 
> Oh, I hadn't ever realised that, good catch. However, since 29859aeb8a6e 
> I think we should probably just remove this check altogether.

Thanks the hint. It looks that I only need revert 82db33dc5e49.

> 
> > Fixes: 82db33dc5e49 ("iommu/io-pgtable-arm: Check for v7s-incapable
> > systems")
> 
> Note that this alone wouldn't be sufficient for stable prior to 4.18, 
> since CONFIG_RANDOMIZE_BASE would then allow the original crash to 
> happen again.

Yes. the problem always exist. Nicolas is fixing this. I will delete the
tag here.

> 
> Robin.
> 
> > Reported-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 445c3bd..70941e6 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -709,7 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >   {
> >   	struct arm_v7s_io_pgtable *data;
> >   
> > -#ifdef PHYS_OFFSET
> > +#if defined(PHYS_OFFSET) && !defined(CONFIG_RANDOMIZE_BASE)
> >   	if (upper_32_bits(PHYS_OFFSET))
> >   		return NULL;
> >   #endif
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
