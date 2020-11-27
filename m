Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CBCC2D0E4
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 06:21:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC4C221FF
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 06:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qLRFbRuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC4C221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5EFD187BC9;
	Fri, 27 Nov 2020 06:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8BlLvwNJ1X0; Fri, 27 Nov 2020 06:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37DE987BB8;
	Fri, 27 Nov 2020 06:21:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1575BC163C;
	Fri, 27 Nov 2020 06:21:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70828C0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 541F42E2C6
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAn2oElpbWRn for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 06:21:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by silver.osuosl.org (Postfix) with ESMTP id 4C7B9203ED
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:21:19 +0000 (UTC)
X-UUID: 7fd33999d69d4e238b17a63a32a1ba34-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=gWFqjIgZJcUQlxaxqF4KJOYrIr+kx5lZqVQTXm3WVxc=; 
 b=qLRFbRucTIUtSK5qJesPIKLwZiHsaN99MkV2RYurS1zhc5QWY7DsLjpZMeuS/DB85ANJPnOsrh0znFKHjm/pqP3zHCeBD7e6JTJrKMXSWnDnYC3//8MlK/anA2zdoHztR+9m/jKPHelTrVkZQ8jOJ8i6ZujvRXTiCUBJET99jUw=;
X-UUID: 7fd33999d69d4e238b17a63a32a1ba34-20201127
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 510553537; Fri, 27 Nov 2020 14:21:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 27 Nov 2020 14:21:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:21:02 +0800
Message-ID: <1606458063.26323.190.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 27 Nov 2020 14:21:03 +0800
In-Reply-To: <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8385ECAE0D6D3223BDD513D2FBE4AE4F466D2488E98D903708BC01BA7A1574042000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Thu, 2020-11-26 at 15:19 +0000, Robin Murphy wrote:
> On 2020-11-20 09:06, Yong Wu wrote:
> > Currently direct_mapping always use the smallest pgsize which is SZ_4K
> > normally to mapping. This is unnecessary. we could gather the size, and
> > call iommu_map then, iommu_map could decide how to map better with the
> > just right pgsize.
> > 
> >  From the original comment, we should take care overlap, otherwise,
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
> >   drivers/iommu/iommu.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index df87c8e825f7..854a8fcb928d 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> >   	/* We need to consider overlapping regions for different devices */
> >   	list_for_each_entry(entry, &mappings, list) {
> >   		dma_addr_t start, end, addr;
> > +		size_t unmapped_sz = 0;
> >   
> >   		if (domain->ops->apply_resv_region)
> >   			domain->ops->apply_resv_region(dev, domain, entry);
> > @@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> >   			phys_addr_t phys_addr;
> >   
> >   			phys_addr = iommu_iova_to_phys(domain, addr);
> > -			if (phys_addr)
> > +			if (phys_addr == 0) {
> > +				unmapped_sz += pg_size; /* Gather the size. */
> >   				continue;
> > +			}
> 
> I guess the reason we need to validate every page is because they may 
> already have been legitimately mapped if someone else's reserved region 
> overlaps - is it worth explicitly validating that, i.e. bail out if 
> something's gone wrong enough that phys_addr != addr?

I'm not sure the history about why to validate every page. this
direct_mapping is called very early, normally after alloc_default_domain
and _attach_device. the "phys_addr != addr" looks impossible.

If there is a normal flow that may cause "phys_addr != addr", then
something go wrong, Could we give a warning like adding a
WARN_ON_ONCE(phys_addr != addr)? and it should be in a another patch.

> 
> Other than the naming issue (I agree that map_size is a far, far better 
> choice), I don't have any strong opinions about the rest of the 
> implementation - I've written enough variations of this pattern to know 
> that there's just no "nice" way to do it in C; all you can do is shuffle 
> the clunkiness around :)

:). I will send a v2.
Thanks.

> 
> Robin.
> 
> >   
> > -			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
> > +			if (unmapped_sz) {
> > +				/* Map the region before the overlap. */
> > +				ret = iommu_map(domain, start, start,
> > +						unmapped_sz, entry->prot);
> > +				if (ret)
> > +					goto out;
> > +				start += unmapped_sz;
> > +				unmapped_sz = 0;
> > +			}
> > +			start += pg_size;
> > +		}
> > +		if (unmapped_sz) {
> > +			ret = iommu_map(domain, start, start, unmapped_sz,
> > +					entry->prot);
> >   			if (ret)
> >   				goto out;
> >   		}
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
