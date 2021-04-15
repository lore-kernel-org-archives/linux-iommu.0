Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690CC433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:40:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259D561152
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259D561152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDC0640645;
	Thu, 15 Apr 2021 06:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyLHSMUuLnsc; Thu, 15 Apr 2021 06:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DACE740204;
	Thu, 15 Apr 2021 06:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0CE3C000C;
	Thu, 15 Apr 2021 06:40:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58A1C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC2B440204
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dCTvo25wpydu for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60909401E4
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kdup9hnwbEiPmwTx9I9NnARK4LM7lXWcWIkr+6fiOPY=; b=QMvRnHEY6v+1+1x3P9v5O1tppt
 PhAkJUgWiFuni09IbxDa4Vfn6J/XKfcCCD1/a+AMGKH+4hu22+yK89okqW8E/5LCCEvtdOZ5yVdsZ
 i3+4WIvI4x3tg0GEQR+6zXdNXAdmPjMElpRDH5aaGTA/NwhPVGMo+1ZUl5Cu8PLb8LJ1VoPdQQ9zZ
 iLMktBmorhbqIwl211yXC1BJj0xuY5JmU4lpWh/mkQvpeqmSotkM8Jf6TbjMCTbKPYbyM2aJepYJJ
 4ur57vX4Vy2k9wLGyjWWKxZbUAqULWbDQDH17DRHU0ifO4PNIC7ZLef1veT07UX4EEymYQT1g8imd
 sUW8idYA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWvg1-0089BK-MR; Thu, 15 Apr 2021 06:40:34 +0000
Date: Thu, 15 Apr 2021 07:40:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210415064033.GA1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Wed, Apr 14, 2021 at 08:27:56AM -0700, Jacob Pan wrote:
>  static int idxd_enable_system_pasid(struct idxd_device *idxd)
>  {
> -	int flags;
> +	unsigned int flags;
>  	unsigned int pasid;
>  	struct iommu_sva *sva;
>  
> -	flags = SVM_FLAG_SUPERVISOR_MODE;
> +	flags = IOMMU_SVA_BIND_SUPERVISOR;
>  
> -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> +	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);

Please also remove the now pointless flags variable.

> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)

Pleae avoid the pointless overly long line.

> -#define SVM_FLAG_GUEST_PASID		(1<<3)
> +#define SVM_FLAG_GUEST_PASID		(1<<2)

This flag is entirely unused, please just remove it in a prep patch
rather than renumbering it.

>  static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)

Same overy long line here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
