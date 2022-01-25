Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFE6C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 05:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4042740204;
	Tue, 25 Jan 2022 05:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sowsWaD6i0Mj; Tue, 25 Jan 2022 05:06:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 14C6B4016C;
	Tue, 25 Jan 2022 05:06:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF224C0039;
	Tue, 25 Jan 2022 05:06:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C48C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B2FD401DF
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FoOdaPJpstQm for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 05:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67B804016C
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643087159; x=1674623159;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=V9CYJ2kCUBsupqpOKFqBBwFqKIJsJUlTvgIb6c/puoE=;
 b=Rh3JZVRi1ZPgN+IflH68WdaGkAf+Qzni6Vz6HddECzCxK3mKdnr/rhJe
 iVXzo4sfaXXoDifOryJDyrfCssrA+pRG1BBkXMb8BKlfgwe/5Ymi6Tcv0
 fafrtaTh6qdVB8kc75ubgh1yUdb4avV10zpq09/WExY9Nc65oEr7IqxuJ
 iwc42K62HZ+i2nWhM+kO8P/JpRMd6CqsaEoj0j7VxTbrVliX85kPdg1VL
 HF4jqagqN2i2JDxURXRwICeAO2J3vPibKcrH1T6DC97yL96Y3FbxK39rY
 JxktWmJw6jZ6uC2PTfukv+YzkMQYcp0IWmlMbBj984gYDr7vFTxC6qgcm g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246438483"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="246438483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 21:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534564947"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 21:05:43 -0800
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <20220124175542.GA987164@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6fd81c95-6fd6-d678-b7df-f2f747e2b10c@linux.intel.com>
Date: Tue, 25 Jan 2022 13:04:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124175542.GA987164@nvidia.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/25/22 1:55 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>> -	int (*enable_nesting)(struct iommu_domain *domain);
> 
> 
> Lu, there is an implementation in the Intel driver here, is it usable
> at all?

It's useless and I have cleaned it up in this series.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
