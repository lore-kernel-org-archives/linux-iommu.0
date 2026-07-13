Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B386334
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942440; cv=none; b=cK1aQcT1RRNy9gusDhWtmTnY0LHs+MQG+AXmAcrBogaHn2JacTfos+EvN/gdzcJIII7AG/3pZ7TFsFER0P7vIxlhNlWDfKxt7c4tL7P24JgWLHr+9ckmK7Lya6rQWpNRbwT9DeF/XVu8/2tUw0dOWSdHlX6Cn8BOvu4u5wVwPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942440; c=relaxed/simple;
	bh=+lptIfgeVXQLlQ5OkctL8r2FHuEGfqk72D2JF8GX+Qg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O5Evk93Zp/ON+VDrIarYcsB5pkIpX7az04Wd/3wGuSgyf1LMx/h9v66GvOOP9731eedG1QIDR9jSKJJKcdzHNdL4v14Grb/EX5XrvmPmAaRGfNvv4jrlikMXi1oYNW4V3/1LQFmkp8lmF1lL+Vx6zxRW3IG2oSexO4+YJEDSSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8LPlih/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8LPlih/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783942439; x=1815478439;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+lptIfgeVXQLlQ5OkctL8r2FHuEGfqk72D2JF8GX+Qg=;
  b=g8LPlih/ymSL/LxRpl9xqj4G/Q4UXfa91gglOQmn7eGCyHLOYOHKvf5Y
   HDtd/0VrPWTo7MgNTJ7myMMQxBbhlRYhmkLFc4IMG0qewUdTTiqiOcVao
   zIL+ccfk87DXYEyZaYbmz1hoN9EZ4u6KBvjkCEWdXRrajO1f7rSahofIz
   m8WzI0HDMwyWlJ6qxy6NESPBV85NYryADQTghpnfo90xC2ya4hmaoUFyq
   sVohx6eUcPKHIVMOui4Ady4H04VzP03uN+45S5/NIS7d4wT9pHIHY9cLH
   KVILhs3QcPVcQmUA6EVKa1dcf67IRBfkv+kA5cwZ+X3y3KkL0Chmw2AlZ
   A==;
X-CSE-ConnectionGUID: VU4JG7C6RzetOCwJTBGqVQ==
X-CSE-MsgGUID: s0xABeO3QNi8jNAwOLGP7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83526343"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83526343"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:33:59 -0700
X-CSE-ConnectionGUID: ODUx+IIuR4+c/4wF4/vwxQ==
X-CSE-MsgGUID: 7YtRABSKREm+ZfsaP/Kn/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260419355"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:33:54 -0700
Message-ID: <05ffe5f1-0d88-40b1-bef9-e9633d618ce5@linux.intel.com>
Date: Mon, 13 Jul 2026 19:33:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 04/18] iommu: Convert gdev->blocked from bool to enum
 gdev_blocked
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/2026 12:06 PM, Nicolin Chen wrote:
> The gdev->blocked flag tracks whether a device is individually being held
> in the group->blocking_domain while group->domain is retained. Up to now,
> a PCI reset in flight is the only producer, so a bool suffices.
> 
> Subsequent changes will add more reasons to keep a device blocked, e.g. a
> failed-reset case that must not auto-unblock, or a driver-side quarantine
> for a hardware fault. These reasons are cleared by different events, which
> a single bool cannot encode.
> 
> Convert "bool blocked" into "enum gdev_blocked blocked", provisioned with
> two initial values: BLOCKED_NO and BLOCKED_RESETTING, for the existing use
> cases. All readers keep the "if (gdev->blocked)" form, as BLOCKED_NO == 0.
> 
> This is a pure type change with no behavior change. Follow-on changes will
> add new enum values along with their producers.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e8f13dcebbde5..342e8a5ad628c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -73,16 +73,20 @@ struct iommu_group {
>   	void *owner;
>   };
>   
> +enum gdev_blocked {
> +	BLOCKED_NO = 0, /* Not blocked */
> +	BLOCKED_RESETTING, /* PCI reset in flight */
> +};

Nit: Would it be more readable if we rename this to 'enum
blocked_reason'? Something like:

enum blocked_reason {
	BLOCKED_NONE = 0,
	BLOCKED_RESETTING,
};

[...snip...]

Anyway, this looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
