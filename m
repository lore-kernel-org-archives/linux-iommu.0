Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F818871F
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755481014; cv=none; b=QW5oqA2b6gJVuS56tfGjdnds1c12H+YXimJJk/v1LMb53G8RcRsGAGsAXVYlzhGgb3pbcLq4G2vDQj+TSrSgijRnWOHFFF9r066GE8QiZyeweDkCI8dbPfHkQ/GaJANjfSa8hPvUMbDtW+zbe41QEE8wDuFv0kaor8IKt517JtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755481014; c=relaxed/simple;
	bh=InyrvjXOENBGSKCdzMBpByyBC9uvIFGLRxeOFxuiCMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KihXgis44QRxI+8CZty9qBcmoknb2XNDE1QDVEkyS0+bFci+XJguyoC1djM+IIeTZEl6UHHgLmnRzszVICF1ZSTBrTEbfbVFSCWOAo1BcuZdpiN4ONzkkuIoBrXC6YpB3nfSAsUoLK2zuIz1i9CDwcM4IDDLUh6XKww5HNGC+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBt5Hng+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBt5Hng+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755481013; x=1787017013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=InyrvjXOENBGSKCdzMBpByyBC9uvIFGLRxeOFxuiCMU=;
  b=DBt5Hng+VvWMN14Q0XiYogCDb3bipBXkmomiRuMMGNMgoAG9bzW/2iZI
   DWBELYX0HxteiDHkdxD20Ae+yazaEmPbHHIbKiCZ55ryxR70+P+Yr7h+b
   g9RxFAD+zkgulX/LKn+mZCMO75pkwTLYLWZbb9+2wE/eYUpVpBlP2x37b
   b59rPDVhe8HGXsY9h5sB6IDFVe7DNsvvZ16F3q8DPE8plKZMpUu0/9G7z
   dCtdLgTmYBDtFWulg8cYYKfMuSr4eHulPjKZKnd5E3KWHywbgYFi0sCPf
   pnReWiIKA5vRebPMv/C9IvzW+nBFFZBnWL8FUSUg9rHEMrVga5/5Ri/TC
   g==;
X-CSE-ConnectionGUID: 14bsLEY4QtmU1DtFbJd7Vg==
X-CSE-MsgGUID: Di8SHSceSbC5zvhmnia2bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68301434"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68301434"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 18:36:52 -0700
X-CSE-ConnectionGUID: lj1rSDdOTqy7O6aMoh8Hxw==
X-CSE-MsgGUID: KRx9Xue4Rkqd6ii6zXe1Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171890354"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 18:36:48 -0700
Message-ID: <4cc2ef88-19e6-4d96-9ccf-6485d5e489c5@linux.intel.com>
Date: Mon, 18 Aug 2025 09:34:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <20250811125753.GT184255@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250811125753.GT184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 20:57, Jason Gunthorpe wrote:
> On Fri, Aug 08, 2025 at 01:15:12PM +0800, Baolu Lu wrote:
>> +static void kernel_pte_work_func(struct work_struct *work)
>> +{
>> +	struct ptdesc *ptdesc, *next;
>> +
>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>> +
>> +	guard(spinlock)(&kernel_pte_work.lock);
>> +	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
>> +		list_del_init(&ptdesc->pt_list);
>> +		pagetable_dtor_free(ptdesc);
>> +	}
> Do a list_move from kernel_pte_work.list to an on-stack list head and
> then immediately release the lock. No reason to hold the spinock while
> doing frees, also no reason to do list_del_init, that memory probably
> gets zerod in pagetable_dtor_free()

Done.

Thanks,
baolu
