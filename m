Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BDC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 10:38:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A24920835
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 10:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A24920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 18CFA8A22;
	Wed,  1 May 2019 10:38:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E7F38A06
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 10:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 16988711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 10:38:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCEB80D;
	Wed,  1 May 2019 03:38:17 -0700 (PDT)
Received: from [10.1.37.14] (unknown [10.1.37.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9383F719;
	Wed,  1 May 2019 03:38:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v7 05/23] iommu: Introduce cache_invalidate API
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, will.deacon@arm.com, robin.murphy@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-6-eric.auger@redhat.com>
Message-ID: <a9745aef-8686-c761-e3d0-dd0e98a1f5b2@arm.com>
Date: Wed, 1 May 2019 11:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408121911.24103-6-eric.auger@redhat.com>
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501103813.at55qTbuU90LD5u6whI0XnRq1XRR7sbJjI8-5N4TwPA@z>

On 08/04/2019 13:18, Eric Auger wrote:
> +int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			   struct iommu_cache_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(!domain->ops->cache_invalidate))
> +		return -ENODEV;
> +
> +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> +
> +	return ret;

Nit: you don't really need ret

The UAPI looks good to me, so

Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
