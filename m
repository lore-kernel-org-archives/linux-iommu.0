Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC625C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:45:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F676113D
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F676113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0383040645;
	Thu, 15 Apr 2021 06:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aODL_WjbGdF7; Thu, 15 Apr 2021 06:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD72C401E4;
	Thu, 15 Apr 2021 06:45:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B422BC000C;
	Thu, 15 Apr 2021 06:45:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2DBC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75371846D2
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxUzz70Ootnd for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:45:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF92C83DB8
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sLaSZVd4EBbrRjPoUQruAkWH+BL8bWgNXBPCwZ3fiOg=; b=uyED9tbYrz+aBtUW6B18Iw8opP
 D0Wt982bXVbzBHSIbZU/Wg0JbrJiPc+os266qo2mrhEm8u5K+gh3ot8uHm9MG1Nm0nV/6ALtH0yz0
 TI5Q5XLe7/NM0YACY1eRihJ8dXEAlyfE554IyG0NDtJOvPwxx//zZilRu2xCTG8xOPR9NgnOedHuF
 n1O0FycpE7bVWtR/B9/e5tt9dDvBv8lxdy7aNsWPtYX0/XBg33IVRXlw1tLIJ0/pz/VYVVYijLB3k
 VVwxP42xMt2coTBqPalf/P6Al+VLBBjuIDCdmmspoSeSiz+kbbtDE0zEVeEzw5h1U7kqxY5G3jWTq
 b+ffu2Ig==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWvkJ-0089Pg-T4; Thu, 15 Apr 2021 06:45:01 +0000
Date: Thu, 15 Apr 2021 07:44:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210415064459.GB1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
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

>   *
>   * Returns 0 on success and < 0 on error.
> @@ -28,6 +28,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	int ret = 0;
>  	ioasid_t pasid;
>  
> +	if (mm != current->mm)
> +		return -EINVAL;
> +

Why not remove the parameter entirely?

> @@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
>  		return ERR_PTR(-ENODEV);
>  
>  	/* Supervisor SVA does not need the current mm */
> -	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
> -		return ERR_PTR(-EINVAL);
> +	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
> +		mm = get_task_mm(current);
> +		if (!mm)
> +			return ERR_PTR(-EINVAL);
> +	}

I don't see why we need the reference.  I think we should just stop
passing the mm to ->sva_bind and let the low-level driver deal with
any reference to current->mm where needed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
