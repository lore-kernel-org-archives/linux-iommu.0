Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06453C10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:25:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F882089C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F882089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 948A7CC7;
	Tue, 15 Oct 2019 05:25:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B213FCC3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:25:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B16ED5D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:25:27 +0000 (UTC)
X-UUID: b4cbd657f3384a4d9f398a13e478d426-20191015
X-UUID: b4cbd657f3384a4d9f398a13e478d426-20191015
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 420262602; Tue, 15 Oct 2019 13:25:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
	(172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Tue, 15 Oct 2019 13:25:17 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Tue, 15 Oct 2019 13:25:16 +0800
Message-ID: <1571117118.19130.81.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Delete the leaf in the tlb flush
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 15 Oct 2019 13:25:18 +0800
In-Reply-To: <20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
	<1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
	<20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1320629692F0D088FC9AD967C2A18864D2766ABDB9AA66C650AFFE4EBC49898F2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, edison.hsieh@mediatek.com,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org
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

On Mon, 2019-10-14 at 15:22 +0100, Robin Murphy wrote:
> On 14/10/2019 07:38, Yong Wu wrote:
> > In our tlb range flush, we don't care the "leaf". Remove it to simplify
> > the code. no functional change.
> 
> Presumably you don't care about the granule either?

Yes. I only keep "granule" to satisfy the format of "tlb_flush_walk",
then it's no need add a new helper function.

> 
> Robin.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8712afc..19f936c 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -174,8 +174,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> >   }
> >   
> >   static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> > -					   size_t granule, bool leaf,
> > -					   void *cookie)
> > +					   size_t granule, void *cookie)
> >   {
> >   	struct mtk_iommu_data *data = cookie;
> >   
> > @@ -219,14 +218,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
> >   static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> >   				     size_t granule, void *cookie)
> >   {
> > -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
> > -	mtk_iommu_tlb_sync(cookie);
> > -}
> > -
> > -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
> > -				     size_t granule, void *cookie)
> > -{
> > -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
> > +	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
> >   	mtk_iommu_tlb_sync(cookie);
> >   }
> >   
> > @@ -245,7 +237,7 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> >   static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> >   	.tlb_flush_all = mtk_iommu_tlb_flush_all,
> >   	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> > -	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
> > +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
> >   	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
> >   };
> >   
> > @@ -475,7 +467,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >   		spin_lock_irqsave(&dom->pgtlock, flags);
> >   
> >   	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> > -				       false, data);
> > +				       data);
> >   	mtk_iommu_tlb_sync(data);
> >   
> >   	if (!is_in_gather)
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
