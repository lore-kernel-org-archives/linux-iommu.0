Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865F880C
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673619176; x=1705155176;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bgR5ummVsveUjZeTs1DpxvmSSGDvw4EF1HbWfjVN/8A=;
  b=oEBG1DsWYBjKL1ZxXpz0Ohw6A0Bu4DvFT5CxSBISrUAM3KDugHd1P/oO
   RCXr+ag+fbRBonCIK/XQL+vnYJ29HzZpmNNXsv/3XCO3uKrkXNc/NQiXf
   qgFvZY5MNLAqZjzmP9s7sdJU/qMGiF5bpkBsycqnVSAvUUdJZhbzRVstM
   v2HHHeog+oGZvJNR2Uuz6Wicaf/puyqImGf4VUPyVCeozlzK/3F1CPmtx
   EOiINtAoFMEF2rcd4MjK4aCH2NJCJEWFeTsvRSYbxHU7vJ2EvmxotiLDn
   Z+1bis0TjCxXU8QwVh3XKKnvkvXQYDOmak0OqhgedSSWaTiJyBW2hXEQo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324057608"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324057608"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:12:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="832078121"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="832078121"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.190.181]) ([10.252.190.181])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:12:51 -0800
Message-ID: <a84ac37c-2b03-35f2-2275-442b448cf6b5@linux.intel.com>
Date: Fri, 13 Jan 2023 22:12:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 3/7] iommu/vt-d: Support Enhanced Command Interface
To: kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-4-kan.liang@linux.intel.com>
 <6783f737-2701-77e3-ce83-8d287be51cf6@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6783f737-2701-77e3-ce83-8d287be51cf6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/1/13 21:55, Baolu Lu wrote:
>> +/*
>> + * Function to submit a command to the enhanced command interface. The
>> + * valid enhanced command descriptions are defined in Table 47 of the
>> + * VT-d spec. The VT-d hardware implementation may support some but not
>> + * all commands, which can be determined by checking the Enhanced
>> + * Command Capability Register.
>> + *
>> + * Return values:
>> + *  - 0: Command successful without any error;
>> + *  - Negative: software error value;
>> + *  - Nonzero positive: failure status code defined in Table 48.
>> + */
>> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
>> +             u64 oa, bool has_ob, u64 ob)
>> +{
>> +    unsigned long flags;
>> +    u64 res;
>> +    int ret;
>> +
>> +    if (!cap_ecmds(iommu->cap))
>> +        return -ENODEV;
>> +
>> +    raw_spin_lock_irqsave(&iommu->register_lock, flags);
>> +
>> +    res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
>> +    if (res & DMA_ECMD_ECRSP_IP) {
>> +        ret = -EBUSY;
>> +        goto err;
>> +    }
>> +
>> +    if (has_ob)
>> +        dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
> 
> The ecmds that require a Operand B are statically defined in the spec,
> right? What will it look like if we define a static ignore_ob(ecmd)?

Or simply remove has_ob parameter? The least case is an unnecessary
write to a register. It's fine as far as I can see since we should avoid
using it in any critical path.

--
Best regards,
baolu
