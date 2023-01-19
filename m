Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653133FB
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674118551; x=1705654551;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oCO75c7hpSpf7YAc/etqBp/Xdevy0oa9hctB/aBK/D8=;
  b=afjmY3KnHvcfhgLyNH+QX4Qd++bGXvLm2lRp/8TpuSxtEj2MLa8GMRyQ
   DY7e0Taohqip4u+n7ARpewvo1VoH9sVVnByFIPHlX7RqeJAO2cre8HYO3
   27vCYwVAgIMYFNJ1crO90nV5m/sQCsPQBUwhZ3gNYx/f3YTmUk+vMx9Z9
   UHloJAUzi5FRGpCdRc+7HSyD3fzAhnacZOh2vYj4IsIAtA0uYPWp2n9sE
   vqw467cAiUzj5lKAuigZEtyplW2xNT6ZnqoWeENbz0qDxRqJnEOWoEzcz
   wJHQBnP/djfIVvhRa88mSWLmwloVDDUvDCFebiL5BLKdVasVKtZW6UYAo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411472482"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="411472482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:55:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="660114044"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="660114044"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.185.248]) ([10.252.185.248])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:55:48 -0800
Message-ID: <379823f4-d1c3-8943-4afe-e33f4d21785c@linux.intel.com>
Date: Thu, 19 Jan 2023 16:55:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH V2 3/7] iommu/vt-d: Support Enhanced Command Interface
To: kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230118205006.3182907-1-kan.liang@linux.intel.com>
 <20230118205006.3182907-4-kan.liang@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230118205006.3182907-4-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/19 4:50, kan.liang@linux.intel.com wrote:
> +#ifdef CONFIG_INTEL_IOMMU
> +#define ecmd_get_status_code(res)	((res & 0xff) >> 1)
> +
> +/*
> + * Function to submit a command to the enhanced command interface. The
> + * valid enhanced command descriptions are defined in Table 47 of the
> + * VT-d spec. The VT-d hardware implementation may support some but not
> + * all commands, which can be determined by checking the Enhanced
> + * Command Capability Register.
> + *
> + * Return values:
> + *  - 0: Command successful without any error;
> + *  - Negative: software error value;
> + *  - Nonzero positive: failure status code defined in Table 48.
> + */
> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
> +{
> +	unsigned long flags;
> +	u64 res;
> +	int ret;
> +
> +	if (!cap_ecmds(iommu->cap))
> +		return -ENODEV;
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +
> +	res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
> +	if (res & DMA_ECMD_ECRSP_IP) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Unconditionally write the operand B, because
> +	 * - There is no side effect if an ecmd doesn't require an
> +	 *   operand B, but we set the register to some value.
> +	 * - It's not invoked in any critical path. The extra MMIO
> +	 *   write doesn't bring any performance concerns.
> +	 */
> +	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
> +	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
> +
> +	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
> +		      !(res & DMA_ECMD_ECRSP_IP), res);
> +
> +	if (res & DMA_ECMD_ECRSP_IP) {
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +
> +	ret = ecmd_get_status_code(res);
> +err:
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_INTEL_IOMMU */

Can we remove the "#ifdef CONFIG_INTEL_IOMMU"? Or if this is currently
only intel-iommu specific, how about moving it to drivers/iommu/intel
/iommu.c?

--
Best regards,
baolu
