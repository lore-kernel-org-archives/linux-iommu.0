Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DD35F5F2
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278759; cv=none; b=g73kkIL3u/nQEbJ67wT/BxlzZQiJqi4pe6moL6M0W7NNQxnqCOcXfHqGpaxLdq95rjhuewIrIb6PKX24lQyJbRdbbFhkOAsM424wzyHarr2ZltcYSXjC28ERNb/xCIQ6TY21roB4IgULpA+Jh1cR+doItI1JE6nWk0ZGSRdEnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278759; c=relaxed/simple;
	bh=ewvA0suYpvwf/+1eG6MBS6wEeTmlhYKNq/xnWnOB02w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjzmOfsxMe+CLxGyCcOUKwi5Ebazv7TbhYD6xjoEaYeTPZUnpHzj2n08S5gDY45vnaoqhT/lqjFeRGoc87QnIT1OW2wmeIzI4gTdeQgDwtFM5YuqiWBrYrJ9j3w1m+8VHhOxPZJTM9ERmsMBeoVGHezMN47bWogjD5xQW/hAmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpQNnpXO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpQNnpXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278759; x=1808814759;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ewvA0suYpvwf/+1eG6MBS6wEeTmlhYKNq/xnWnOB02w=;
  b=HpQNnpXOy2KScR/5JCEa04mELSsre7bnP5AnD/DjRdT5RJrFvvesKyIc
   BKafetQSA+Rq2/wX9RDGL1FyFFjbS/xU2SWZgoN6+mrSwPcJMYorflMxK
   oGt07JpsfDBuQ4XTwvVWy9SY10ifjOGySGhEuy2cZibQ3R8c7yRJsAtyM
   vtT2qRYtJzaMx+Kdi1Ht+5Bn07aht6o8jWB0dAxSEe5XypRyIirywT6Cp
   PaeqfMyBWYSWIn7xykbEuEiKTAx7ekznQgnddzWksXY+/eGqbDWOuwYav
   dDEzsYHftn5UzdKwJSk1oFlOOnlZaRS1dBzoFzx+rx2EkFXnefkE4xFaU
   Q==;
X-CSE-ConnectionGUID: 0ITTmI1fRaOxOvqkDsyG9w==
X-CSE-MsgGUID: W0iRg+oIRpiUdn3fLHNvhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88853879"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88853879"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:32:38 -0700
X-CSE-ConnectionGUID: gAvjHFv8TYK4it1lSdJPqA==
X-CSE-MsgGUID: WAGCvf+XQm6ZlFR6cjXizg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237902767"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:32:35 -0700
Message-ID: <19cb7a81-9eb4-4792-a102-de94e008f4c7@linux.intel.com>
Date: Mon, 27 Apr 2026 16:32:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v8 1/8] iommu: Fix NULL group->domain dereference in
 pci_dev_reset_iommu_done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
References: <cover.1777074513.git.nicolinc@nvidia.com>
 <c5bc84ee72651ce22b69bce3cb731a721a3d057a.1777074513.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c5bc84ee72651ce22b69bce3cb731a721a3d057a.1777074513.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2026 9:15 AM, Nicolin Chen wrote:
> Local sashiko review pointed it out that group->domain could be NULL when
> a default domain fails to allocate during the first probe, which can crash
> at domain->ops->attach_dev dereference in __iommu_attach_device() invoked
> by pci_dev_reset_iommu_done().
> 
> pci_dev_reset_iommu_prepare() is fine as an old_domain pointer can be NULL.
> 
> Skip the re-attach in pci_dev_reset_iommu_done() to fix the bug.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
