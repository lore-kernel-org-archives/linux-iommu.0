Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B82C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 23:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 060CA40CD8;
	Fri, 29 Apr 2022 23:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rs89xtqZJpJT; Fri, 29 Apr 2022 23:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C03D640142;
	Fri, 29 Apr 2022 23:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB26C0032;
	Fri, 29 Apr 2022 23:52:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73ADAC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 23:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CA7760ABE
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 23:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cRCokGSw7BEj for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 23:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAF8260A8A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651276323; x=1682812323;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9sesrm2gYifuyn6d/cuWZ/1m6KGJBn/VDXU17Jgc6ws=;
 b=GuZ6zgoR3RQE7sfspYX/zcJ+W/o9jxR+PQbr423Q6KcFfB2f0hgP+BDE
 wF0D1tEFX07saV+navsgCDPXdVrAf+THjp1UIjJ9wQkrO5m5X3WpKvRX1
 mUWrJ+xnXtqD5V5G5A4VygBJRVixdc34SJ+jlkkWB/mTm0WA5e5xLEevA
 kCo3Lm2AvR1khVETkXm41Q24KbSWxtCMgwweLdBo0V4uZilk2yeOInPsX
 bZaSGax82O5E0cgJgPsGbyQlKHMvwCdgpw040jkeHxXfMbkSjZGF0VY3R
 g1qXQZhMOU5Xnz6PKIPpF3leVaQfi+kE44XOEsCi1eUEraa6DwcmMd9Sa g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266630996"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; d="scan'208";a="266630996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 16:51:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; d="scan'208";a="582480232"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71])
 ([10.255.30.71])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 16:51:43 -0700
Message-ID: <0e2b2a3f-1fbd-ff81-d846-eb7091de53e8@linux.intel.com>
Date: Sat, 30 Apr 2022 07:51:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 02/19] iommufd: Dirty tracking for io_pagetable
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-3-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220428210933.3583-3-joao.m.martins@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/4/29 05:09, Joao Martins wrote:
> +int iopt_set_dirty_tracking(struct io_pagetable *iopt,
> +			    struct iommu_domain *domain, bool enable)
> +{
> +	struct iommu_domain *dom;
> +	unsigned long index;
> +	int ret = -EOPNOTSUPP;
> +
> +	down_write(&iopt->iova_rwsem);
> +	if (!domain) {
> +		down_write(&iopt->domains_rwsem);
> +		xa_for_each(&iopt->domains, index, dom) {
> +			ret = iommu_set_dirty_tracking(dom, iopt, enable);
> +			if (ret < 0)
> +				break;

Do you need to roll back to the original state before return failure?
Partial domains have already had dirty bit tracking enabled.

> +		}
> +		up_write(&iopt->domains_rwsem);
> +	} else {
> +		ret = iommu_set_dirty_tracking(domain, iopt, enable);
> +	}
> +
> +	up_write(&iopt->iova_rwsem);
> +	return ret;
> +}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
