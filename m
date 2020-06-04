Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70986C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:49:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEF3206C3
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l5cznZQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEF3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 080D123B88;
	Thu,  4 Jun 2020 09:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUQA-8ibuiKs; Thu,  4 Jun 2020 09:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 08F32203CF;
	Thu,  4 Jun 2020 09:49:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9A26C0881;
	Thu,  4 Jun 2020 09:49:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0EBC016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A0148796B
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33LU4x9J1tm8 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 09:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0962087968
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:49:39 +0000 (UTC)
X-UUID: 579acaf2148b49c6b7566c730229f003-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=lBI82O8bEEPgYlNHvOkibX3qdLSsdkxzL1E3PQQA8b0=; 
 b=l5cznZQyeF0t8PUXtBPHL8pk3AnSmztorPMyyTSrjhlLqv1+LiJ4TE/ssnITNp2aCsHzYTShTvLxmFL0OjobwAJ8z1zHj8Y1J53i/m96VhNfj5XrWfF2BAQKrUi1kO3GNsTfxg+SvQTp5toCtYcObnVp8pue0TxUoz4GFTToRcM=;
X-UUID: 579acaf2148b49c6b7566c730229f003-20200604
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1162007422; Thu, 04 Jun 2020 17:49:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 17:49:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 17:49:32 +0800
Message-ID: <1591264174.12661.17.camel@mtkswgap22>
Subject: Re: [PATCH] iommu/mediatek: Use totalram_pages to setup enable_4GB
From: Miles Chen <miles.chen@mediatek.com>
To: David Hildenbrand <david@redhat.com>
Date: Thu, 4 Jun 2020 17:49:34 +0800
In-Reply-To: <55820901-430b-14c4-9426-7a4991ca0eed@redhat.com>
References: <20200604080120.2628-1-miles.chen@mediatek.com>
 <55820901-430b-14c4-9426-7a4991ca0eed@redhat.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AE948E482C29CD5898F27E00F7D8367EA04E36796E3DBBED3FBA94C5849F28092000:8
X-MTK: N
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
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

On Thu, 2020-06-04 at 10:25 +0200, David Hildenbrand wrote:
> On 04.06.20 10:01, Miles Chen wrote:
> > To build this driver as a kernel module, we cannot use
> > the unexported symbol "max_pfn" to setup enable_4GB.
> > 
> > Use totalram_pages() instead to setup enable_4GB.
> > 
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 5f4d6df59cf6..c2798a6e0e38 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -3,7 +3,6 @@
> >   * Copyright (c) 2015-2016 MediaTek Inc.
> >   * Author: Yong Wu <yong.wu@mediatek.com>
> >   */
> > -#include <linux/memblock.h>
> >  #include <linux/bug.h>
> >  #include <linux/clk.h>
> >  #include <linux/component.h>
> > @@ -626,8 +625,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> >  
> > -	/* Whether the current dram is over 4GB */
> > -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> > +	/* Whether the current dram is over 4GB, note: DRAM start at 1GB  */
> > +	data->enable_4GB = !!(totalram_pages() > ((SZ_2G + SZ_1G) >> PAGE_SHIFT));
> 
> A similar thing seems to be done by
> drivers/media/platform/mtk-vpu/mtk_vpu.c:
> 	vpu->enable_4GB = !!(totalram_pages() > (SZ_2G >> PAGE_SHIFT));
> 
> I do wonder if some weird memory hotplug setups might give you false
> negatives.
> 
> E.g., start a VM with 1GB and hotplug 1GB - it will be hotplugged on
> x86-64 above 4GB, turning max_pfn into 5GB. totalram_pages() should
> return something < 2GB.
> 
> Same can happen when you have a VM and use ballooning to fake-unplug
> memory, making totalram_pages() return something < 4GB, but leaving
> usable pfns >= 4GB

Yes. Yingjoe also told me that this patch is not correct.

Thanks for pointing this out. totalram_pages() does not work 
for some cases:

e.g., DRAM start @0x4000_0000 and DRAM size is 0x1_0000_0000 but we
reserve large amount of memory, which makes totalram_pages() < 3GB but
it is possible to allocate a pfn >= 4GB.

I will discuss this internally.

Miles
> .
> 
> but
> ... I don't know if I understood what "enable_4GB" needs/implies
> ... I don't know if this is applicable to VMs
>  at all (on real HW such
>     memory hotplug setups should not exist)
> ... I don't know how this code would react to memory hotplug, so if the
>     condition changes after the driver loaded and enable_4GB would
>     suddenly apply. Again, most probably not relevant on real HW, only
>     for VMs.
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
