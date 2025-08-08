Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77161E32DB;
	Fri,  8 Aug 2025 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630468; cv=none; b=jz2ordmZn7BWR4muj/qKDnsnUI8CKc37WCpCRCTQwT/BigS8Ck5P5WXbShc1ViVZ9tnwkvkZP49fMG90PZTgkMnGiTxYh3hJM0CAHyFa6gXAxsETzkwJUCz5xnZEyJB+10l+7ezDN68E4ugYAJ5x4X47QaYNMXwHKlfBEoLolVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630468; c=relaxed/simple;
	bh=XqBTmWBIyYrPkYwvSHX2UtS0QV8n7iP1YLBKlvO2zt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osd1hY1H0WCkDUptpESRshaN/TRMmwPpQMJaEGXxTJygdQj82RuDdpvuBwLW1U/Le7SSuzn7s52Cfc60teGtfSn8gGKJnpHNn6TmTdpihmYlLHMAbR8XLHwiACGxrjGX4aVJnZxHXDAPv2cnySMEloML4xkYo+2LmqNBR/OXdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBLtq523; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBLtq523"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754630466; x=1786166466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqBTmWBIyYrPkYwvSHX2UtS0QV8n7iP1YLBKlvO2zt0=;
  b=JBLtq523HeSXn6mvzZr19TVzIfQU8Dw372wYEmxh1W/cbG736U/MY/Z7
   o/pTD+3yuPRMTMDIW9PBox2VbWy9u7CKGCJo6H8VRnuIZ0xRGdgZEsfsh
   FPPBLIaYdjDOpnojZDuo+MY00z4y+lNTvNviLfkBzePBynqbcyws4Hbzt
   Mg0cbd5sv2kN8CrhQvI/wwKnXRCOF1atskMP7jGwuipN4aSAqhztBYPcE
   rxg8h+v2vk0KgR9JH9tqxLWWvHG7+iRyasyGGxyzxNDDi+DKdRjsNiqW2
   ZzvPgJW9hiSkjmyAElPEnHQ5qF0spKm+zDjSzPQMIs8k4keBRFpQAegiI
   g==;
X-CSE-ConnectionGUID: tQ4NivhURUm1LSrANh09UQ==
X-CSE-MsgGUID: gADYzcn3RYu7GDHH9mRzhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57054972"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57054972"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:21:06 -0700
X-CSE-ConnectionGUID: DGIrCofRQG+fIzfWUwj3jg==
X-CSE-MsgGUID: ZhH4djwBSReZ1rSSroaHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169454052"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:21:03 -0700
Message-ID: <57b135c3-228a-48cc-8dbe-ff8aa0249f9f@linux.intel.com>
Date: Fri, 8 Aug 2025 13:19:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
To: Seyediman Seyedarab <imandevel@gmail.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250731225048.131364-1-ImanDevel@gmail.com>
 <h6impubmygtakszk7t6ffknvtje72c4ovknjgme5xletglkl5g@4lpcs22onyqi>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <h6impubmygtakszk7t6ffknvtje72c4ovknjgme5xletglkl5g@4lpcs22onyqi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 17:00, Seyediman Seyedarab wrote:
> On 25/07/31 06:50PM, Seyediman Seyedarab wrote:
>> snprintf() returns the number of bytes that would have been
>> written, not the number actually written. Using this for offset
>> tracking can cause buffer overruns if truncation occurs.
>>
>> Replace snprintf() with scnprintf() to ensure the offset stays
>> within bounds.
>>
>> Since scnprintf() never returns a negative value, and zero is not
>> possible in this context because 'bytes' starts at 0 and 'size - bytes'
>> is DEBUG_BUFFER_SIZE in the first call, which is large enough to hold
>> the string literals used, the return value is always positive. An integer
>> overflow is also completely out of reach here due to the small and fixed
>> buffer size. The error check in latency_show_one() is therefore unnecessary.
>> Remove it and make dmar_latency_snapshot() return void.
>>
>> Signed-off-by: Seyediman Seyedarab<ImanDevel@gmail.com>
>> ---
>> Changes in v4:
>> - Removed 'ret' in latency_show_one() since it is not being used anymore:
>> https://lore.kernel.org/oe-kbuild-all/202508010632.WB0CM5Bz-lkp@intel.com/
>>
>> Changes in v3:
>> - Restored return type of dmar_latency_enable() back to 'int'. It was
>>    mistakenly changed to 'void' in the previous version.
>>
>> Changes in v2:
>> - The return type of dmar_latency_snapshot() was changed based on the
>>    discussion here:
>> https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/
>>
>>
>>   drivers/iommu/intel/debugfs.c | 10 ++--------
>>   drivers/iommu/intel/perf.c    | 10 ++++------
>>   drivers/iommu/intel/perf.h    |  5 ++---
>>   3 files changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
>> index affbf4a1558d..65d2f792f0f7 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -648,17 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
>>   static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
>>   			     struct dmar_drhd_unit *drhd)
>>   {
>> -	int ret;
>> -
>>   	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
>>   		   iommu->name, drhd->reg_base_addr);
>>   
>> -	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
>> -	if (ret < 0)
>> -		seq_puts(m, "Failed to get latency snapshot");
>> -	else
>> -		seq_puts(m, debug_buf);
>> -	seq_puts(m, "\n");
>> +	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
>> +	seq_printf(m, "%s\n", debug_buf);
>>   }
>>   
>>   static int latency_show(struct seq_file *m, void *v)
>> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
>> index adc4de6bbd88..dceeadc3ee7c 100644
>> --- a/drivers/iommu/intel/perf.c
>> +++ b/drivers/iommu/intel/perf.c
>> @@ -113,7 +113,7 @@ static char *latency_type_names[] = {
>>   	"     svm_prq"
>>   };
>>   
>> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>>   {
>>   	struct latency_statistic *lstat = iommu->perf_statistic;
>>   	unsigned long flags;
>> @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>>   	memset(str, 0, size);
>>   
>>   	for (i = 0; i < COUNTS_NUM; i++)
>> -		bytes += snprintf(str + bytes, size - bytes,
>> +		bytes += scnprintf(str + bytes, size - bytes,
>>   				  "%s", latency_counter_names[i]);
>>   
>>   	spin_lock_irqsave(&latency_lock, flags);
>> @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>>   		if (!dmar_latency_enabled(iommu, i))
>>   			continue;
>>   
>> -		bytes += snprintf(str + bytes, size - bytes,
>> +		bytes += scnprintf(str + bytes, size - bytes,
>>   				  "\n%s", latency_type_names[i]);
>>   
>>   		for (j = 0; j < COUNTS_NUM; j++) {
>> @@ -156,11 +156,9 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>>   				break;
>>   			}
>>   
>> -			bytes += snprintf(str + bytes, size - bytes,
>> +			bytes += scnprintf(str + bytes, size - bytes,
>>   					  "%12lld", val);
>>   		}
>>   	}
>>   	spin_unlock_irqrestore(&latency_lock, flags);
>> -
>> -	return bytes;
>>   }
>> diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
>> index df9a36942d64..1d4baad7e852 100644
>> --- a/drivers/iommu/intel/perf.h
>> +++ b/drivers/iommu/intel/perf.h
>> @@ -40,7 +40,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
>>   bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
>>   void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
>>   			 u64 latency);
>> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
>> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
>>   #else
>>   static inline int
>>   dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
>> @@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
>>   {
>>   }
>>   
>> -static inline int
>> +static inline void
>>   dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>>   {
>> -	return 0;
>>   }
>>   #endif /* CONFIG_DMAR_PERF */
>> -- 
>> 2.50.1
>>
> Hi there,
> 
> Just following up on this patch. Please let me know if there's
> anything else needed from my side.

It just missed the v6.17 merge window, I'll queue it for v6.18.

Thanks,
baolu
