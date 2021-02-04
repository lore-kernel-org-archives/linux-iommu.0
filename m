Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD187C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 13:32:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F7564F4E
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 13:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F7564F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDF9586ACE;
	Thu,  4 Feb 2021 13:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6PJhfMSWgL4; Thu,  4 Feb 2021 13:32:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A6EE868D4;
	Thu,  4 Feb 2021 13:32:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9246C07FD;
	Thu,  4 Feb 2021 13:32:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F986C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 380048712E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JYjDjTSc29tz for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 13:31:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E0A1587118
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:31:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8F0DE387; Thu,  4 Feb 2021 14:31:55 +0100 (CET)
Date: Thu, 4 Feb 2021 14:31:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Message-ID: <20210204133148.GA27686@8bytes.org>
References: <20210203135936.23016-1-colin.king@canonical.com>
 <20210204092558.GA20244@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204092558.GA20244@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Anan sun <anan.sun@mediatek.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin King <colin.king@canonical.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Feb 04, 2021 at 09:25:58AM +0000, Will Deacon wrote:
> On Wed, Feb 03, 2021 at 01:59:36PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the check for domid < 0 is always false because domid
> > is unsigned.  Fix this by making it signed.
> > 
> > Addresses-CoverityL ("Unsigned comparison against 0")
> 
> Typo here ('L' instead of ':')
> 
> > Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0ad14a7604b1..823d719945b2 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
> >  				       struct list_head *head)
> >  {
> >  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> > -	unsigned int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> > +	int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> 
> Not sure if it's intentional, but this also makes 'i' signed. It probably
> should remain 'unsigned' to match 'iova_region_nr' in
> 'struct mtk_iommu_plat_data'.

Yes, 'i' should stay unsigned. Colin, can you please fix that up and
re-send?

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
