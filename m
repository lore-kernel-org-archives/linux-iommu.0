Return-Path: <SRS0=QH76=F4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3919AC433DB
	for <iommu@archiver.kernel.org>; Thu, 24 Dec 2020 11:28:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C790C20C56
	for <iommu@archiver.kernel.org>; Thu, 24 Dec 2020 11:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C790C20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7922B861F9;
	Thu, 24 Dec 2020 11:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxFZV-n-snPc; Thu, 24 Dec 2020 11:28:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A755C861F1;
	Thu, 24 Dec 2020 11:28:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0B03C1787;
	Thu, 24 Dec 2020 11:28:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2585EC0893
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 11220861F9
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YJQ_hCpmTwc for <iommu@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 11:28:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DF7E861F1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:28:06 +0000 (UTC)
X-UUID: ebeceb543e594724afb82df797d9e1e0-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=DiOcFw9Kf9pbbQaIqyaauDc19jifokyiHRLy79w4/TI=; 
 b=jwcGv8V43FrvfSVlCDjy+v1PddpLpwqrdatyeFgTUsxMHZ7DOEIRDg2rNsyMywODMyJqp2ornAd8rbcdfkf1vZFL67YGqgwLiZiOuEdFuMXUIG8PFhCPJEhu1ZWbk55eAxZurHzXOvaE5Cn5k3dm+9z3iaBYw8glN8H0Q1qe2Jo=;
X-UUID: ebeceb543e594724afb82df797d9e1e0-20201224
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 626282406; Thu, 24 Dec 2020 19:27:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 24 Dec 2020 19:27:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 19:27:36 +0800
Message-ID: <1608809257.26323.259.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/7] iommu: Move iotlb_sync_map out from __iommu_map
From: Yong Wu <yong.wu@mediatek.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Thu, 24 Dec 2020 19:27:37 +0800
In-Reply-To: <20201223085153.GA30643@infradead.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-2-yong.wu@mediatek.com>
 <20201223085153.GA30643@infradead.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FBCE9ED43BF43E3D7C20C416E2E03E98E6E841E4758068BCA32988C6FE2A5E212000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, Greg Kroah-Hartman <gregkh@google.com>, Robin
 Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 2020-12-23 at 08:51 +0000, Christoph Hellwig wrote:
> On Wed, Dec 16, 2020 at 06:36:01PM +0800, Yong Wu wrote:
> > In the end of __iommu_map, It alway call iotlb_sync_map.
> > This patch moves iotlb_sync_map out from __iommu_map since it is
> > unnecessary to call this for each sg segment especially iotlb_sync_map
> > is flush tlb all currently.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> What about adding a little helper that does the NULL check and method
> call instead of duplicating it all over?

Thanks for the review. Of course OK.

Then the code like below. 
(If the helper name "_iommu_map" is not good, please tell me.)

+static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
+	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
+	if (ret == 0 && ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+	return ret;
+}
+
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
 	might_sleep();
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	return _iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
 int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
+	return _iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
