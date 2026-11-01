Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498496;
	b=wok8WtIP0pPdCheEf3nRBQQKyZfXXlljnGeF9FyuHUXg8Q+ufxqBHnwwBAdh5LSVTnVx
	 ti64gh7bLp3M/qKVjiL2RA/RVqdNpe365Yt0FQfK3seli3qJ2IyeUN2jVvb3IERbVjEYi
	 zPYLBVJmLmWC3gNWQHrl3ZnSjOjNv+7PwKzeKrK0h5ODXVhzKIRJS6l9bIPhYzjo5sibh
	 fiAqvUymkxj5NaCl3BEZSJ7bfcBW6xozdbvoluYIYvTkq+qzW4ozlS3BubHbsNCfYSrAT
	 3RGVxaeRZdYXHY5L9nPJC9gBJSQefPa8tFGH7oeJf7hoUqVukH8lYOBN5ucs2hYhXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498496;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UdQIS1HV37oZzDtiilXTZRQCoWPWWjYgi85hmsTzP1I=;
	b=dzzTTtgBulSPwlDYDrE5zNLpgCn/XBMKMqheaK3Z3N5in8XCCie6jdiCnxFfq1cvUtv7
	 74fYUKGBmfTrxtvzp6P66fDLT0ei0Z63T8m2ZimOOd7s/UMFPFo1SDcqyw0Z1Q5oSL/P0
	 BFnIqSSYQFHzYDUH/i2aBk1zmPecUkUlgltoF+k4dVTXi82/a89CDwat8pfzjBOJ/Ap75
	 8FtXpHQE5mZXAISg3zaROIBJP9ihzCIUc5K/qO8wB4kVxcIkq0WglAI3bDRZzO1JW5xMQ
	 K8inRAoxZSGggUgnWLzW+cFpEgLEa3I1hUTVOxXhLQBCDPdn1rXAXDIjMUQDvUz898Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iSIQFZ1B;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E9606A324
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 02:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iSIQFZ1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793498494; x=1825034494;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eUshjmHI8nBckK7aZ5/ayCCnGvq51Zmfd4b4XqMqVPY=;
  b=iSIQFZ1BGsv7AahKvEssLh7jawwiiLuf9RVuQ9foSicQpwqY53cYb6BF
   R4WhxBGwdSSIOw01RsO8SPNNF1VDx+bnkGj8N7w7REzbomv9IDNOZk8Uj
   FzsTkj3Ye0mpKqsR4cvoptjTS0W+xeC0P3m5AKU2yqmJktDc60s4cBDFO
   WNHga+u/+Hd2X0CFvfE8etyhZdb4DDxS7wu4qqvpQS8G9we7Sw/KHTuZ9
   H5EmrnteiRB/0ESt8wq1yn9C7AiFrVS7nlOiBVDOZJAiLhvYgkeP7s6/M
   9fxNBOqm8MRbRAhZijVBvRk5m9+eYQgfkCHTE7dP8/xTPvPgXzUXSZkTW
   A==;
X-CSE-ConnectionGUID: l1c5hFwISxWL0h98gy0Yhw==
X-CSE-MsgGUID: ouHjkIPCQM2G8z+90wlwIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2246604"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2246604"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 19:01:33 -0700
X-CSE-ConnectionGUID: lkvRpUEhTVq2MeGQEmEiVg==
X-CSE-MsgGUID: kcCKM6T/SvmtifuP+8Pjdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5875867"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 19:01:32 -0700
Message-ID: <fa44bb2c-18a6-43bf-86e0-9b5f721f5421@linux.intel.com>
Date: Sun, 1 Nov 2026 10:01:29 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] iommu: Unpublish the attach handle before the
 group detach callback
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <03392b21011e9285b342488f0df233b92acc3405.1790718296.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <03392b21011e9285b342488f0df233b92acc3405.1790718296.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2026 5:51 AM, Nicolin Chen wrote:
> The group->pasid_array entry is erased only after the detach callback has
> returned, so the outgoing attach handle stays published for the whole of
> that call. iommu_attach_handle_get() reads it under the xa_lock alone, not
> under the group mutex, so a fault raised in the meantime still finds that
> handle and the domain being detached, both of which the caller frees the
> moment that detach returns.
> 
> Commit 5e9f822c9c68 ("iommu: Swap the order of setting group->pasid_array
> and calling attach op of iommu drivers") has fixed the attach path, while
> the detach path never got the symmetric change.
> 
> Erase the entry ahead of the callback instead. A missing entry reads back
> as NULL from xa_load(), so that iommu_attach_handle_get() returns -ENOENT
> and the fault gets rejected rather than delivered against a domain that is
> on its way out.
> 
> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag is no longer necessary.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..a062a84686c29 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3951,8 +3951,12 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
>   			       struct iommu_group *group)
>   {
>   	mutex_lock(&group->mutex);
> -	__iommu_group_set_core_domain(group);
> +	/*
> +	 * Unpublish the handle first, so it would not resolve to the detaching
> +	 * domain once the driver is detaching it.
> +	 */
>   	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
> +	__iommu_group_set_core_domain(group);
>   	mutex_unlock(&group->mutex);
>   }
>   EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
