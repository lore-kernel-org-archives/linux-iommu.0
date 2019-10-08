Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE535C10F14
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 08:09:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D03206B6
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D03206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7F922B65;
	Tue,  8 Oct 2019 08:09:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DEA1B49
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 08:09:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3FDF0604
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 08:09:30 +0000 (UTC)
X-UUID: 3e5410620a494d17a6c364524d63feb3-20191008
X-UUID: 3e5410620a494d17a6c364524d63feb3-20191008
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 47123943; Tue, 08 Oct 2019 16:09:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Tue, 8 Oct 2019 16:09:22 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Tue, 8 Oct 2019 16:09:22 +0800
Message-ID: <1570522162.19130.38.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 8 Oct 2019 16:09:22 +0800
In-Reply-To: <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 82114C9AC7CB423FF7956E35FA57BC2C3DF7DB806D08CD08C9D9B0F7A6FF2AAB2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, Nicolas
	Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream <srv_heupstream@mediatek.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	"list@263.net:IOMMU DRIVERS
	<iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>,
	" <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, "list@263.net:IOMMU DRIVERS
	<iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>,
	" <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Tomasz,

Sorry for reply late.

On Wed, 2019-10-02 at 14:18 +0900, Tomasz Figa wrote:
> Hi Yong,
> 
> On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > lacked the dom->pgtlock, then it will cause the variable
> > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > log randomly:
> >
> 
> Thanks for the patch! Please see my comments inline.
> 
> > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > full flush
> >
> > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > And when checking this issue, we find that __arm_v7s_unmap call
> > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > this also is potential unsafe for us. There is no tlb flush queue in the
> > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > and we don't care if it is leaf, rearrange the callback functions. Also,
> > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > iotlb_sync_all is unnecessary.
> 
> Performance-wise, we could do much better. Instead of synchronously
> syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> beginning, if there was any previous flush still pending. We would
> also have to keep the .iotlb_sync() callback, to take care of waiting
> for the last flush. That would allow better pipelining with CPU in
> cases like this:
> 
> for (all pages in range) {
>    change page table();
>    flush();
> }
> 
> "change page table()" could execute while the IOMMU is flushing the
> previous change.

Do you mean adding a new tlb_sync before tlb_flush_no_sync, like below:

mtk_iommu_tlb_add_flush_nosync {   
   + mtk_iommu_tlb_sync();
   tlb_flush_no_sync();
   data->tlb_flush_active = true;
}

mtk_iommu_tlb_sync {
	if (!data->tlb_flush_active)
		return;
	tlb_sync();
	data->tlb_flush_active = false;
}

This way look improve the flow, But adjusting the flow is not the root
cause of this issue. the problem is "data->tlb_flush_active" may be
changed from mtk_iommu_iotlb_sync which don't have a dom->pglock.

Currently the synchronisation of the tlb_flush/tlb_sync flow are
controlled by the variable "data->tlb_flush_active".

In this patch putting the tlb_flush/tlb_sync together looks make
the flow simpler:
a) Don't need the sensitive variable "tlb_flush_active".
b) Remove mtk_iommu_iotlb_sync, Don't need add lock in it.
c) Simplify the tlb_flush_walk/tlb_flush_leaf.
is it ok?

> 
> >
> > Besides, there are two minor changes:
> > a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > HW work. We expect all the setting(iova_start/iova_end...) have already
> > been finished before F_MMU_INV_RANGE.
> > b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> > is so long that affect the multimedia performance.
> 
> By definition, timeout is something that should not normally happen.
> Too long timeout affecting multimedia performance would suggest that
> the timeout was actually happening, which is the core problem, not the
> length of the timeout. Could you provide more details on this?

As description above, this issue is because there is no dom->pgtlock in
the mtk_iommu_iotlb_sync. I have tried that the issue will disappear
after adding lock in it.

Although the issue is fixed after this patch, I still would like to
reduce the timeout value for somehow error happen in the future. 100ms
is unnecessary for us. It looks a minor improvement rather than fixing
the issue. I will use a new patch for it.

> 
> >
> > Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > This patch looks break the logic for tlb_flush and tlb_sync. I'm not
> > sure if it
> > is reasonable. If someone has concern, I could change:
> > a) Add dom->pgtlock in the mtk_iommu_iotlb_sync
> > b) Add a io_pgtable_tlb_sync in [1].
> >
> > [1]
> > https://elixir.bootlin.com/linux/v5.3-rc1/source/drivers/iommu/io-pgtable-arm-v7s.c#L655
> >
> > This patch rebase on Joerg's mediatek-smmu-merge branch which has mt8183
> > and Will's "Rework IOMMU API to allow for batching of invalidation".
> > ---
> >  drivers/iommu/mtk_iommu.c | 74 ++++++++++++-----------------------------------
> >  drivers/iommu/mtk_iommu.h |  1 -
> >  2 files changed, 19 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6066272..e13cc56 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -173,11 +173,12 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> >         }
> >  }
> >
> > -static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> > -                                          size_t granule, bool leaf,
> > -                                          void *cookie)
> > +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> > +                                   size_t granule, void *cookie)
> >  {
> >         struct mtk_iommu_data *data = cookie;
> > +       int ret;
> > +       u32 tmp;
> >
> >         for_each_m4u(data) {
> >                 writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > @@ -186,25 +187,15 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> >                 writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
> >                 writel_relaxed(iova + size - 1,
> >                                data->base + REG_MMU_INVLD_END_A);
> > -               writel_relaxed(F_MMU_INV_RANGE,
> > -                              data->base + REG_MMU_INVALIDATE);
> > -               data->tlb_flush_active = true;
> > -       }
> > -}
> > -
> > -static void mtk_iommu_tlb_sync(void *cookie)
> > -{
> > -       struct mtk_iommu_data *data = cookie;
> > -       int ret;
> > -       u32 tmp;
> > -
> > -       for_each_m4u(data) {
> > -               /* Avoid timing out if there's nothing to wait for */
> > -               if (!data->tlb_flush_active)
> > -                       return;
> > +               writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
> >
> > +               /*
> > +                * There is no tlb flush queue in the HW, the HW always expect
> > +                * tlb_flush and tlb_sync one by one. Here tlb_sync always
> > +                * follows tlb_flush to avoid break the sequence.
> > +                */
> >                 ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
> > -                                               tmp, tmp != 0, 10, 100000);
> > +                                               tmp, tmp != 0, 10, 1000);
> >                 if (ret) {
> >                         dev_warn(data->dev,
> >                                  "Partial TLB flush timed out, falling back to full flush\n");
> > @@ -212,36 +203,21 @@ static void mtk_iommu_tlb_sync(void *cookie)
> >                 }
> >                 /* Clear the CPE status */
> >                 writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
> > -               data->tlb_flush_active = false;
> >         }
> >  }
> >
> > -static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> > -                                    size_t granule, void *cookie)
> > +static void mtk_iommu_tlb_flush_page(struct iommu_iotlb_gather *gather,
> > +                                    unsigned long iova, size_t granule,
> > +                                    void *cookie)
> >  {
> > -       mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
> > -       mtk_iommu_tlb_sync(cookie);
> > -}
> > -
> > -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
> > -                                    size_t granule, void *cookie)
> > -{
> > -       mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
> > -       mtk_iommu_tlb_sync(cookie);
> > -}
> > -
> > -static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> > -                                           unsigned long iova, size_t granule,
> > -                                           void *cookie)
> > -{
> > -       mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> > +       mtk_iommu_tlb_add_flush(iova, granule, granule, cookie);
> >  }
> >
> >  static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> >         .tlb_flush_all = mtk_iommu_tlb_flush_all,
> > -       .tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> > -       .tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
> > -       .tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
> > +       .tlb_flush_walk = mtk_iommu_tlb_add_flush,
> > +       .tlb_flush_leaf = mtk_iommu_tlb_add_flush,
> > +       .tlb_add_page = mtk_iommu_tlb_flush_page,
> >  };
> >
> >  static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> > @@ -445,17 +421,6 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
> >         return unmapsz;
> >  }
> >
> > -static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > -{
> > -       mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> > -}
> > -
> > -static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> > -                                struct iommu_iotlb_gather *gather)
> > -{
> > -       mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> > -}
> > -
> >  static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >                                           dma_addr_t iova)
> >  {
> > @@ -574,8 +539,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >         .detach_dev     = mtk_iommu_detach_device,
> >         .map            = mtk_iommu_map,
> >         .unmap          = mtk_iommu_unmap,
> > -       .flush_iotlb_all = mtk_iommu_flush_iotlb_all,
> 
> Don't we still want .flush_iotlb_all()? I think it should be more
> efficient in some cases than doing a big number of single flushes.
> (That said, the previous implementation didn't do any flush at all. It
> just waited for previously queued flushes to happen. Was that
> expected?)

I will keep the flush_iotlb_all.

Thanks.

> 
> Best regards,
> Tomasz


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
