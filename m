Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B6ACA9EBB
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:22:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FCA20684
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FCA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFA82ACD;
	Thu, 24 Oct 2019 07:22:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB5E7499
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4262687B
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:22:42 +0000 (UTC)
X-UUID: d19484b7065342aa99b1cf23ca602cb3-20191024
X-UUID: d19484b7065342aa99b1cf23ca602cb3-20191024
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 6435572; Thu, 24 Oct 2019 15:22:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
	(172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 24 Oct 2019 15:22:26 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 24 Oct 2019 15:22:25 +0800
Message-ID: <1571901746.19130.134.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/7] iommu/mediatek: Add a new tlb_lock for tlb_flush
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Thu, 24 Oct 2019 15:22:26 +0800
In-Reply-To: <20191023165252.GA27471@willie-the-truck>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
	<1571196792-12382-3-git-send-email-yong.wu@mediatek.com>
	<20191023165252.GA27471@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A424D45C3762AE65D19C9E0D6AC3052D0F4FDCA255F395DA386AC98B86DDEC702000:8
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

On Wed, 2019-10-23 at 17:52 +0100, Will Deacon wrote:
> On Wed, Oct 16, 2019 at 11:33:07AM +0800, Yong Wu wrote:
> > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > lacked the lock, then it will cause the variable "tlb_flush_active"
> > may be changed unexpectedly, we could see this warning log randomly:
> > 
> > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > full flush
> > 
> > The HW requires tlb_flush/tlb_sync in pairs strictly, this patch adds
> > a new tlb_lock for tlb operations to fix this issue.
> > 
> > Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB
> > sync")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 23 ++++++++++++++++++++++-
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> [...]
> 
> >  static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> >  					    unsigned long iova, size_t granule,
> >  					    void *cookie)
> >  {
> > +	struct mtk_iommu_data *data = cookie;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&data->tlb_lock, flags);
> >  	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> > +	spin_unlock_irqrestore(&data->tlb_lock, flags);
> 
> Given that you release the lock here, what prevents another nosync()
> operation being issued before you've managed to do the sync()?

This patch can not guarantee each flush_nosync() always followed by a
sync().

The current mainline don't guarantee this too(Current v7s call
flush_nosync 16 times, then call tlb_sync 1 time in the
supersection/largepage case.). At this situation, it don't guarantee the
previous tlb_flushes are finished, But we never got the timeout
issue(Fortunately our HW always work well at that time. Maybe the HW
finish the previous tlb flush so quickly even though we don't polling
its finish flag).

We got the timeout issue only after this commit 4d689b619445. This patch
only fixes this issue via adding a new lock in iotlb_sync.(It don't
adjust the sequence of flush_nosync() and sync()).

> 
> Will


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
