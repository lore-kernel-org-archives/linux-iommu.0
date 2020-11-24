Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B993C56202
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:24:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CACA2073C
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m2MMLnmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CACA2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BCB98639B;
	Tue, 24 Nov 2020 09:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lDb6BKq4Ue60; Tue, 24 Nov 2020 09:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 556D28601E;
	Tue, 24 Nov 2020 09:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 119ACC163C;
	Tue, 24 Nov 2020 09:24:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45DFBC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4008A8639B
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id obVDNZvVh6Ef for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:24:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F1808601E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:24:53 +0000 (UTC)
X-UUID: 1173a46cb11f40ad99644152fce63674-20201124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=wruLeV1VxmJT3h8u8aTdJS9aBT3lPk6fj9q+96T1tpA=; 
 b=m2MMLnmti+zD9v0lImNo8ElL5aR2YjwrH071EJaqDUgT7ZPCb9jIYWxOaEMU3HpRQDtoYc1rFHCBGeoEoiR1IHGVPXI4SzkmEIxuOXmv21BV1LLiQrDx/6AVdlNnU/eVSsK4TLIfWOu3BNRFFkonQJv5OQeceN6vpL8HCzPIPTI=;
X-UUID: 1173a46cb11f40ad99644152fce63674-20201124
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1399213662; Tue, 24 Nov 2020 17:24:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 24 Nov 2020 17:24:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 Nov 2020 17:24:43 +0800
Message-ID: <1606209884.26323.132.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Tue, 24 Nov 2020 17:24:44 +0800
In-Reply-To: <20201123123258.GC10233@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EBCB8F6C7AAB7CEFD384B30FE7D298E2FA4811C473B599035C7F59E811168DC42000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> On Fri, Nov 20, 2020 at 05:06:28PM +0800, Yong Wu wrote:
> > Currently direct_mapping always use the smallest pgsize which is SZ_4K
> > normally to mapping. This is unnecessary. we could gather the size, and
> > call iommu_map then, iommu_map could decide how to map better with the
> > just right pgsize.
> > 
> > From the original comment, we should take care overlap, otherwise,
> > iommu_map may return -EEXIST. In this overlap case, we should map the
> > previous region before overlap firstly. then map the left part.
> > 
> > Each a iommu device will call this direct_mapping when its iommu
> > initialize, This patch is effective to improve the boot/initialization
> > time especially while it only needs level 1 mapping.
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/iommu.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index df87c8e825f7..854a8fcb928d 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> >  	/* We need to consider overlapping regions for different devices */
> >  	list_for_each_entry(entry, &mappings, list) {
> >  		dma_addr_t start, end, addr;
> > +		size_t unmapped_sz = 0;
> 
> I think "unmapped" is the wrong word here, as this variable actually
> represents the amount we want to map! I suggest "map_size" instead.
> 
> >  		if (domain->ops->apply_resv_region)
> >  			domain->ops->apply_resv_region(dev, domain, entry);
> > @@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> >  			phys_addr_t phys_addr;
> >  
> >  			phys_addr = iommu_iova_to_phys(domain, addr);
> > -			if (phys_addr)
> > +			if (phys_addr == 0) {
> > +				unmapped_sz += pg_size; /* Gather the size. */
> >  				continue;
> > +			}
> >  
> > -			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
> > +			if (unmapped_sz) {
> > +				/* Map the region before the overlap. */
> > +				ret = iommu_map(domain, start, start,
> > +						unmapped_sz, entry->prot);
> > +				if (ret)
> > +					goto out;
> > +				start += unmapped_sz;
> 
> I think it's a bit confusing to update start like this. Can we call
> iommu_map(domain, addr - map_size, addr - map_size, map_size, entry->prot)
> instead?
> 
> > +				unmapped_sz = 0;
> > +			}
> > +			start += pg_size;
> > +		}
> > +		if (unmapped_sz) {
> > +			ret = iommu_map(domain, start, start, unmapped_sz,
> > +					entry->prot);
> 
> Can you avoid this hunk by changing your loop check to something like:
> 
> 	if (!phys_addr) {
> 		map_size += pg_size;
> 		if (addr + pg_size < end)
> 			continue;
> 	}

Thanks for your quick review. I have fixed and tested it. the patch is
simple. I copy it here. Is this readable for you now?


--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -737,6 +737,7 @@ static int
iommu_create_device_direct_mappings(struct iommu_group *group,
 	/* We need to consider overlapping regions for different devices */
 	list_for_each_entry(entry, &mappings, list) {
 		dma_addr_t start, end, addr;
+		size_t map_size = 0;
 
 		if (domain->ops->apply_resv_region)
 			domain->ops->apply_resv_region(dev, domain, entry);
@@ -752,12 +753,21 @@ static int
iommu_create_device_direct_mappings(struct iommu_group *group,
 			phys_addr_t phys_addr;
 
 			phys_addr = iommu_iova_to_phys(domain, addr);
-			if (phys_addr)
-				continue;
+			if (!phys_addr) {
+				map_size += pg_size;
+				if (addr + pg_size < end)
+					continue;
+				else
+					addr += pg_size; /*Point to End */
+			}
 
-			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
-			if (ret)
-				goto out;
+			if (map_size) {
+				ret = iommu_map(domain, addr - map_size, addr - map_size,
+						map_size, entry->prot);
+				if (ret)
+					goto out;
+				map_size = 0;
+			}
 		}

> 
> Will

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
