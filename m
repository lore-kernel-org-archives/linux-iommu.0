Return-Path: <SRS0=KSvG=YF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E5C10F14
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 06:34:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E6520659
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 06:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E6520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BB2BE1DDE;
	Sat, 12 Oct 2019 06:34:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 080E21DD9
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 06:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 004E7D0
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 06:23:57 +0000 (UTC)
X-UUID: b0f39b91104846af8790ca0483b51fe1-20191012
X-UUID: b0f39b91104846af8790ca0483b51fe1-20191012
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1320974668; Sat, 12 Oct 2019 14:23:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
	(172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Sat, 12 Oct 2019 14:23:46 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 12 Oct 2019 14:23:45 +0800
Message-ID: <1570861427.19130.65.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] iommu/mediatek: Use writel for TLB range
	invalidation
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Sat, 12 Oct 2019 14:23:47 +0800
In-Reply-To: <20191011162950.yg4o77mlaicacne5@willie-the-truck>
References: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
	<1570627143-29441-3-git-send-email-yong.wu@mediatek.com>
	<20191011162950.yg4o77mlaicacne5@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0A33034A89B0C9BB9E3E78D19D549891FCC7ABDAE5C14ED4B95401F2380F2F052000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>,
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

On Fri, 2019-10-11 at 17:29 +0100, Will Deacon wrote:
> On Wed, Oct 09, 2019 at 09:19:02PM +0800, Yong Wu wrote:
> > Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > HW work. We expect all the setting(iova_start/iova_end...) have already
> > been finished before F_MMU_INV_RANGE.
> > 
> > Signed-off-by: Anan.Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > This is a improvement rather than fixing a issue.
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 24a13a6..607f92c 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -187,8 +187,7 @@ static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> >  		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
> >  		writel_relaxed(iova + size - 1,
> >  			       data->base + REG_MMU_INVLD_END_A);
> > -		writel_relaxed(F_MMU_INV_RANGE,
> > -			       data->base + REG_MMU_INVALIDATE);
> > +		writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
> 
> I don't understand this change.
> 
> Why is it an "improvement" and which accesses are you ordering with the
> writel?

The register(F_MMU_INV_RANGE) will trigger HW to begin flush range. HW
expect the other register iova_start/end/flush_type always is ready
before trigger. thus I'd like use writel to guarantee the previous
register has been finished.

I didn't see the writel_relaxed cause some error in practice, we only
think writel is necessary here in theory. so call it "improvement".

> 
> Will


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
