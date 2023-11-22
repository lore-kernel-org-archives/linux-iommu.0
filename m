Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C17477
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLqYvVCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700618150; x=1732154150;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gxF+z61IXTXTtbMXeR8K2hgpRdKrIDL/R0Zmx7ml8xo=;
  b=VLqYvVCK+LL14J3A3/smk6bgddKufGGDW/bI3h5GtGbzNt9+XX8aqqBU
   jX2JW+H+6CoybZs18Zs0cdQ6lNzo58UuVOykwod1CztfSeV0BEDHT0sYL
   o6PVh0NilEC6s5asfamfeqCpPdFTtZkY24TGXMGMzBmA1k/thmzc7iMK2
   GHE89znc7A0P81E2lJvs1un1QX34URuRuQbM1qjeO36Shut2rukFcm5dv
   KvK5udqBAY40HxR8xs/QOvdZ6KAoN7FMVelnia1DsqOT76pcMs5xkIcyg
   /FDfb8VpuDHWQUUeBEkjqm4QKZl1MYmke6tb3+gPfwshqqKY8cinhXgZZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458459144"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="458459144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098231951"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="1098231951"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 17:55:46 -0800
Message-ID: <719ab0c1-e2a8-4446-8b3f-ba751db0ce27@linux.intel.com>
Date: Wed, 22 Nov 2023 09:51:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, jgg@nvidia.com,
 linux-kernel@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: [PATCH v6 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1700589539.git.robin.murphy@arm.com>
 <6c7313009aae0e39ae2855920990ebf85af4662f.1700589539.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6c7313009aae0e39ae2855920990ebf85af4662f.1700589539.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 2:04 AM, Robin Murphy wrote:
> As the final remaining piece of bus-dependent API, iommu_domain_alloc()
> can now take responsibility for the "one iommu_ops per bus" rule for
> itself. It turns out we can't safely make the internal allocation call
> any more group-based or device-based yet - that will have to wait until
> the external callers can pass the right thing - but we can at least get
> as far as deriving "bus ops" based on which driver is actually managing
> devices on the given bus, rather than whichever driver won the race to
> register first.
> 
> This will then leave us able to convert the last of the core internals
> over to the IOMMU-instance model, allow multiple drivers to register and
> actually coexist (modulo the above limitation for unmanaged domain users
> in the short term), and start trying to solve the long-standing
> iommu_probe_device() mess.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Jerry Snitselaar<jsnitsel@redhat.com>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> 
> ---
> 
> v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
>      as the existing code.
> ---
>   drivers/iommu/iommu.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
