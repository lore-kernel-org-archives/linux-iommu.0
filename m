Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05982C0018C
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 02:26:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABAE2371F
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 02:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABAE2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA3E986FCF;
	Thu, 17 Dec 2020 02:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8LBFGX2csfi; Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3684878D4;
	Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89EC0C088E;
	Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 749A7C013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64BD687740
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMDBjrm+kQKb for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 02:26:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id BA84287736
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:32 +0000 (UTC)
X-UUID: a26dd9353d1e42208dd961d29e96f238-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=cZkhfVbBy8ld8Co+Td0lutxPr2qax5e+8H5edX0I4Es=; 
 b=S5a/E9Sk262fUlpl4jWNxK94BAjz664cJCG0HUUB1v2v25iDGDSFH/8uu1Gi9Tyj2Xu5RqvzesFBWYBH1a6ArvjIjljorRyDmS9RFcuiLJ64m0VOZTC5zLTuj9c5iOgv4DiJfaV0E0y5uvDKIneqOugHQgLudjmA04GUtiIKaNo=;
X-UUID: a26dd9353d1e42208dd961d29e96f238-20201217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 972562059; Thu, 17 Dec 2020 10:26:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 17 Dec 2020 10:26:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 10:26:01 +0800
Message-ID: <1608171961.26323.210.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 17 Dec 2020 10:26:01 +0800
In-Reply-To: <16a9565e-5b01-e1c2-0f4a-d06db7f3b093@arm.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-5-yong.wu@mediatek.com>
 <16a9565e-5b01-e1c2-0f4a-d06db7f3b093@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AB5FD0512F263D6A017B73D1545892F0A3880C0205E3ADED95904F3CF6FAB3A82000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, Will Deacon <will@kernel.org>,
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

On Wed, 2020-12-16 at 12:10 +0000, Robin Murphy wrote:
> On 2020-12-16 10:36, Yong Wu wrote:
> > Currently gather->end is "unsigned long" which may be overflow in
> > arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> > Although it doesn't affect the size(end - start), it affects the checking
> > "gather->end < end"
> 
> This won't help the same situation at the top of a 64-bit address space, 
> though, and now that we have TTBR1 support for AArch64 format that is 
> definitely a thing. Better to just encode the end address as the actual 
> end address, i.e. iova + size - 1. We don't lose anything other than the 
> ability to encode zero-sized invalidations that don't make sense anyway.

Thanks for the suggestion. "iova + size - 1" is better. Also I will
change the "size" to "gather->end - gather->start + 1" in the iotlb_sync
of arm-smmu-v3.c and mtk_iommu.c.

> 
> Robin.
> 
> > Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   include/linux/iommu.h | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 794d4085edd3..6e907a95d981 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -178,7 +178,7 @@ enum iommu_dev_features {
> >    */
> >   struct iommu_iotlb_gather {
> >   	unsigned long		start;
> > -	unsigned long		end;
> > +	unsigned long long	end;
> >   	size_t			pgsize;
> >   };
> >   
> > @@ -537,7 +537,8 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
> >   					       struct iommu_iotlb_gather *gather,
> >   					       unsigned long iova, size_t size)
> >   {
> > -	unsigned long start = iova, end = start + size;
> > +	unsigned long start = iova;
> > +	unsigned long long end = start + size;
> >   
> >   	/*
> >   	 * If the new page is disjoint from the current range or is mapped at
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
