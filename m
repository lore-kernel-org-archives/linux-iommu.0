Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB88C433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 06:58:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2273220715
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 06:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ptpOJFQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2273220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC98A8784F;
	Mon, 18 May 2020 06:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKIRq5IqX9lK; Mon, 18 May 2020 06:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 916D9877DC;
	Mon, 18 May 2020 06:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3F2C0881;
	Mon, 18 May 2020 06:58:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3BFFC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 06:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D057D8618F
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 06:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PCUiNSop7_yF for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 06:58:02 +0000 (UTC)
X-Greylist: delayed 00:05:03 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 239AC85F66
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 06:58:01 +0000 (UTC)
X-UUID: 50de2994ee194d24be05a64da9dcc874-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=BE27p8cgAXdiOJaTc4rLjiLgh00VCcwZpGfoS4OOzsM=; 
 b=ptpOJFQJPFBPL0cXkOqi5XQq0/yJTcAYzd6Xd1kQWwUg4VdHh2mnbGPt0mbD9ULSgjuY9RuCQsxe6WDM+RcppeVDqP5klDWQdDGAiu8iiqef6Im9IPnivLimwGbVBzh1ZnPdTsfZL3fSYtLAJ1PlFQquB/C2sLu1OEw+FwOZ+Sc=;
X-UUID: 50de2994ee194d24be05a64da9dcc874-20200518
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1666374242; Mon, 18 May 2020 14:52:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 18 May 2020 14:52:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 14:52:46 +0800
Message-ID: <1589784680.15083.19.camel@mhfsdcap03>
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Mon, 18 May 2020 14:51:20 +0800
In-Reply-To: <20200515100718.GS18353@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-24-joro@8bytes.org>
 <1589528699.26119.9.camel@mhfsdcap03> <20200515100718.GS18353@8bytes.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 645326C83BAFED16ABAF80B4AAC8D7BA842597586DFE9CAF78B92A85A256ADAF2000:8
X-MTK: N
Cc: Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
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

On Fri, 2020-05-15 at 12:07 +0200, Joerg Roedel wrote:
> Hi,
> 
> On Fri, May 15, 2020 at 03:44:59PM +0800, Yong Wu wrote:
> > On Tue, 2020-04-14 at 15:15 +0200, Joerg Roedel wrote:
> > > -	return iommu_device_link(&data->iommu, dev);
> > > +	err = arm_iommu_attach_device(dev, mtk_mapping);
> > > +	if (err)
> > > +		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
> > 
> > 
> > Hi Joerg,
> > 
> >      Thanks very much for this patch.
> > 
> >      This arm_iommu_attach_device is called just as we expected.
> > 
> >      But it will fail in this callstack as the group->mutex was tried to
> > be re-locked...
> > 
> > [<c0938e8c>] (iommu_attach_device) from [<c0317590>]
> > (__arm_iommu_attach_device+0x34/0x90)
> > [<c0317590>] (__arm_iommu_attach_device) from [<c03175f8>]
> > (arm_iommu_attach_device+0xc/0x20)
> > [<c03175f8>] (arm_iommu_attach_device) from [<c09432cc>]
> > (mtk_iommu_probe_finalize+0x34/0x50)
> > [<c09432cc>] (mtk_iommu_probe_finalize) from [<c093a8ac>]
> > (bus_iommu_probe+0x2a8/0x2c4)
> > [<c093a8ac>] (bus_iommu_probe) from [<c093a950>] (bus_set_iommu
> > +0x88/0xd4)
> > [<c093a950>] (bus_set_iommu) from [<c0943c74>] (mtk_iommu_probe
> > +0x2f8/0x364)
> 
> Thanks for the report, is
> 
> 	https://lore.kernel.org/lkml/1589530123-30240-1-git-send-email-yong.wu@mediatek.com/
> 
> The fix for this issue or is something else required?

No. That patch only adjust the internal flow to satisfy the latest
framework, it's not for fixing this mutex issue. 

Here I only reported this issue.

below is my local patch. split "dma_attach" to attach_device and
probe_finalize. About attach_device, Use the existed
__iommu_attach_group instead. Then rename from the "dma_attach" to
"probe_finalize" to do the probe_finalize job. And move it outside of
the mutex_unlock.

I'm not sure if it is right. and of course I will test if you have any
other solution. Thanks.


--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1665,26 +1665,20 @@ static void probe_alloc_default_domain(struct
bus_type *bus,
 
 }
 
-static int iommu_group_do_dma_attach(struct device *dev, void *data)
+static int iommu_group_do_probe_finalize(struct device *dev, void
*data)
 {
 	struct iommu_domain *domain = data;
-	const struct iommu_ops *ops;
-	int ret;
-
-	ret = __iommu_attach_device(domain, dev);
-
-	ops = domain->ops;
+	const struct iommu_ops *ops = domain->ops;
 
-	if (ret == 0 && ops->probe_finalize)
+	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
-
-	return ret;
+	return 0;
 }
 
-static int __iommu_group_dma_attach(struct iommu_group *group)
+static int iommu_group_probe_finalize(struct iommu_group *group)
 {
 	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_attach);
+					  iommu_group_do_probe_finalize);
 }
 
 static int iommu_do_create_direct_mappings(struct device *dev, void
*data)
@@ -1731,12 +1725,14 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_attach(group);
+		ret = __iommu_attach_group(group->default_domain, group);
 
 		mutex_unlock(&group->mutex);
 
 		if (ret)
 			break;
+
+		iommu_group_probe_finalize(group);
 	}
 
 	return ret;
-- 

> 
> 
> Thanks,
> 
> 	Joerg
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
