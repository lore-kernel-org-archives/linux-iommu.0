Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6819CCA482
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 06:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E6760D89;
	Fri,  1 Jul 2022 06:53:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53E6760D89
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZUkDxaDS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2wNyB1JOYx9D; Fri,  1 Jul 2022 06:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DE8060864;
	Fri,  1 Jul 2022 06:53:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DE8060864
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5C7C0035;
	Fri,  1 Jul 2022 06:53:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 736DEC002D;
 Fri,  1 Jul 2022 06:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E54940442;
 Fri,  1 Jul 2022 06:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E54940442
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZUkDxaDS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lyeFxybbPKp8; Fri,  1 Jul 2022 06:53:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3D77403D8
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3D77403D8;
 Fri,  1 Jul 2022 06:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656658409; x=1688194409;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lT6Q657TSg/9MG9w0C8hYZ86wxuoFIRctv6pNkUIO7Y=;
 b=ZUkDxaDSPbzQrs4p6Q1qJvS4QVJen/A81DykF4yFuH23/Z1ajQPQuS5d
 6mTEUs1o4ZqQEdWLtNRZA3hGgTqFfYuh14m8NPJuS07kWuxOLbsPXGeib
 Ka2giPzDzrTfk7LLpIjuyfJHFofUcTSHUQ6uc6l3tHbZd1uKg9/YbmkIz
 wImFEMLUfg8dATxpULN+s4VrK4FTIDoxlDxag/YtOA0ejYWksTkxexMHV
 IThk2xkeIF73S2trfEcJFEKE/T2OACVottlAhPz5PIFfMJWHfJMK6sMlm
 B0kj+uSORQimi17hE+st6+o3Y1YCVb2l63Ekd5hKF0AuYU1vWl9g6LCyt w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265601218"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="265601218"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 23:53:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="596134247"
Received: from pchai-mobl.ccr.corp.intel.com (HELO [10.249.171.241])
 ([10.249.171.241])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 23:53:15 -0700
Message-ID: <0db46319-30c9-5d78-4467-79246ac454e4@linux.intel.com>
Date: Fri, 1 Jul 2022 14:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
 marcan@marcan.st, sven@svenpeter.dev, robin.murphy@arm.com,
 robdclark@gmail.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
 zhang.lyra@gmail.com, jean-philippe@linaro.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com
References: <20220630203635.33200-1-nicolinc@nvidia.com>
 <20220630203635.33200-2-nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220630203635.33200-2-nicolinc@nvidia.com>
Cc: virtualization@lists.linux-foundation.org, thierry.reding@gmail.com,
 alyssa@rosenzweig.io, linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 jonathanh@nvidia.com, iommu@lists.linux.dev, yangyingliang@huawei.com,
 gerald.schaefer@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org
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

On 2022/7/1 04:36, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno from the IOMMU driver during attach that the
> reason attached failed is because of domain incompatability. EMEDIUMTYPE
> is chosen because it is never used within the iommu subsystem today and
> evokes a sense that the 'medium' aka the domain is incompatible.
> 
> VFIO can use this to know attach is a soft failure and it should continue
> searching. Otherwise the attach will be a hard failure and VFIO will
> return the code to userspace.
> 
> Update all drivers to return EMEDIUMTYPE in their failure paths that are
> related to domain incompatability. Also remove adjacent error prints for
> these soft failures, to prevent a kernel log spam, since -EMEDIUMTYPE is
> clear enough to indicate an incompatability error.
> 
> Add kdocs describing this behavior.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
