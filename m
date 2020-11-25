Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B9CC56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 11:04:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545F120665
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 11:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vy5FClWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545F120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9FB987541;
	Wed, 25 Nov 2020 11:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wovocPaBo3G4; Wed, 25 Nov 2020 11:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DA1487534;
	Wed, 25 Nov 2020 11:04:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63AC9C0891;
	Wed, 25 Nov 2020 11:04:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCDC1C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BBD5186E5A
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RuD96B+2nMI5 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 11:04:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 77FBD86A00
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:03:45 +0000 (UTC)
X-UUID: 0772767d57e343e6891beb8ab16b4e8e-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=xI/ceqZKKONm10j9fLWN04WfsGQ+Y6PfpXlP79ucbtc=; 
 b=Vy5FClWJFnjQyR2mZzAmi3S6inaTOenZU3qhbvrxlXtKflmvFTy6blSm+77b7dpHtGZ3iPP21cHe4J/o2+EYEqhFX0NXMoKAj5iRO99L8uhKXaq/X7K1aZ1sCha+O5L0PmBAPQyTnynkabuPPr2SCqhXMSHQDL3iZHpLJkfkkY4=;
X-UUID: 0772767d57e343e6891beb8ab16b4e8e-20201125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 617537765; Wed, 25 Nov 2020 19:03:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 25 Nov 2020 19:03:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 19:03:33 +0800
Message-ID: <1606302214.26323.141.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Wed, 25 Nov 2020 19:03:34 +0800
In-Reply-To: <20201124110520.GA12980@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
 <1606209884.26323.132.camel@mhfsdcap03>
 <20201124110520.GA12980@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3E37F2948B73A16F8990BEF5FB644CD56B780219D1EF19A777FBD0308C48F13A2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, chao.hao@mediatek.com,
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

On Tue, 2020-11-24 at 11:05 +0000, Will Deacon wrote:
> On Tue, Nov 24, 2020 at 05:24:44PM +0800, Yong Wu wrote:
> > On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> > > On Fri, Nov 20, 2020 at 05:06:28PM +0800, Yong Wu wrote:
> > > > +				unmapped_sz = 0;
> > > > +			}
> > > > +			start += pg_size;
> > > > +		}
> > > > +		if (unmapped_sz) {
> > > > +			ret = iommu_map(domain, start, start, unmapped_sz,
> > > > +					entry->prot);
> > > 
> > > Can you avoid this hunk by changing your loop check to something like:
> > > 
> > > 	if (!phys_addr) {
> > > 		map_size += pg_size;
> > > 		if (addr + pg_size < end)
> > > 			continue;
> > > 	}
> > 
> > Thanks for your quick review. I have fixed and tested it. the patch is
> > simple. I copy it here. Is this readable for you now?
> > 
> > 
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -737,6 +737,7 @@ static int
> > iommu_create_device_direct_mappings(struct iommu_group *group,
> >  	/* We need to consider overlapping regions for different devices */
> >  	list_for_each_entry(entry, &mappings, list) {
> >  		dma_addr_t start, end, addr;
> > +		size_t map_size = 0;
> >  
> >  		if (domain->ops->apply_resv_region)
> >  			domain->ops->apply_resv_region(dev, domain, entry);
> > @@ -752,12 +753,21 @@ static int
> > iommu_create_device_direct_mappings(struct iommu_group *group,
> >  			phys_addr_t phys_addr;
> >  
> >  			phys_addr = iommu_iova_to_phys(domain, addr);
> > -			if (phys_addr)
> > -				continue;
> > +			if (!phys_addr) {
> > +				map_size += pg_size;
> > +				if (addr + pg_size < end)
> > +					continue;
> > +				else
> 
> You don't need the 'else' here  ^^^
> 
> > +					addr += pg_size; /*Point to End */
> 
> addr = end ?
> 
> That said, maybe we could simplify this further by changing the loop bounds
> to be:
> 
> 	for (addr = start; addr <= end; addr += pg_size)
> 
> and checking:
> 
> 	if (!phys_addr && addr != end) {
> 		map_size += pg_size;
> 		continue;
> 	}
> 
> does that work?

It works but I think we can not check iommu_iova_to_phys(domain, end).
We should add a "if", like:

for (addr = start; addr <= end; addr += pg_size) {
...
	if (addr < end) {
		phys_addr = iommu_iova_to_phys(domain, addr);
		if (!phys_addr) {
			map_size += pg_size;
			continue;
		}
	}
...


If you don't like this "if (addr < end)", then we have to add a "goto".
like this:


for (addr = start; addr <= end; addr += pg_size) {
 	phys_addr_t phys_addr;
 
	if (addr == end)
		goto map_last;

	phys_addr = iommu_iova_to_phys(domain, addr);
	if (!phys_addr) {
		map_size += pg_size;
		continue;
	}

map_last:
	if (!map_size)
		continue;
	ret = iommu_map(domain, addr - map_size,
			addr - map_size, map_size, entry->prot);
	if (ret)
		goto out;
}

Which one is better?

> 
> Will
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
