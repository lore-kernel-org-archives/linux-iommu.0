Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0163CA9EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:22:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD8621655
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 123A3B9E;
	Thu, 24 Oct 2019 07:22:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8FFD0B6D
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 56726831
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:22:41 +0000 (UTC)
X-UUID: c00efe6b6a6b490a8ec249bb5f663775-20191024
X-UUID: c00efe6b6a6b490a8ec249bb5f663775-20191024
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 222561763; Thu, 24 Oct 2019 15:22:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 24 Oct 2019 15:22:31 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 24 Oct 2019 15:22:30 +0800
Message-ID: <1571901752.19130.135.camel@mhfsdcap03>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Use gather to achieve the tlb
	range flush
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Thu, 24 Oct 2019 15:22:32 +0800
In-Reply-To: <20191023165543.GB27471@willie-the-truck>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
	<1571196792-12382-4-git-send-email-yong.wu@mediatek.com>
	<20191023165543.GB27471@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B3428B34711F9D4340351C5FBF71C7D9A7707DD264962EFF9A5C5A10E427B3F82000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	edison.hsieh@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 2019-10-23 at 17:55 +0100, Will Deacon wrote:
> On Wed, Oct 16, 2019 at 11:33:08AM +0800, Yong Wu wrote:
> > Use the iommu_gather mechanism to achieve the tlb range flush.
> > Gather the iova range in the "tlb_add_page", then flush the merged iova
> > range in iotlb_sync.
> > 
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index c2f6c78..81ac95f 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -245,11 +245,9 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> >  					    void *cookie)
> >  {
> >  	struct mtk_iommu_data *data = cookie;
> > -	unsigned long flags;
> > +	struct iommu_domain *domain = &data->m4u_dom->domain;
> >  
> > -	spin_lock_irqsave(&data->tlb_lock, flags);
> > -	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> > -	spin_unlock_irqrestore(&data->tlb_lock, flags);
> > +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> 
> You need to be careful here, because iommu_iotlb_gather_add_page() can
> call iommu_tlb_sync() in some situations and you don't hold the lock.

The mtk_iommu_iotlb_sync below already has the lock in it, so I delete
the lock here.

> 
> >  static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> > @@ -469,9 +467,15 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >  				 struct iommu_iotlb_gather *gather)
> >  {
> >  	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> > +	size_t length = gather->end - gather->start;
> >  	unsigned long flags;
> >  
> > +	if (gather->start == ULONG_MAX)
> > +		return;
> > +
> >  	spin_lock_irqsave(&data->tlb_lock, flags);
> > +	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> > +				       false, data);
> >  	mtk_iommu_tlb_sync(data);
> >  	spin_unlock_irqrestore(&data->tlb_lock, flags);
> 
> Modulo my comment above, this fixes my previous comment. Given that mainline
> is already broken, I guess the runtime bisectability isn't a problem.

As the reply in [2/7]. the mainline is not broken after [2/7], it only
go to the previous status before commit(4d689b619445).

After using the iommu_gather, the iova will be the merged range in this
iotlb_sync, it is just fit to do the tlb-flush/tlb-sync. then it fixes
our potential issue(No tlb-sync for the previous tlb-flush range).

> 
> Will


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
