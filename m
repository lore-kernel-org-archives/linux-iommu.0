Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50097C
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 01:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668476861; x=1700012861;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ovi/VmSAYJnOBJbFxvjxwoJcbVjnPzCjFbHOIGCRmSQ=;
  b=U1Jmo0BsRTxh/2T9cyfaNoNc1+0MMVLtIxmeAgNcrQHbD223yJhfhy2r
   COq4nndk2y+AeLDjUuR8T0FvBg7nJ6hHIlPTa+gd/djDCYV3FioJRO+Vq
   bJ4olGKFNfAvtIzhjSn70Nu3wL4ENMfuepgnEkki7ljKaQWa9OHsIgCnj
   QyzSGv94CKnDohgQJx+lvWFbxP5bIMaB1P3kpySyS2gQtO2sQyDK9eG97
   LMI2swGDXrXsDj9qC8LzJVXKulcWyDcBIOb+TYnXnkHL2nlOURsXVJP9S
   LCpkJZ6Ps3z9oTC651AFW8bwe8s05WHzqfNMXQ7V23v1EDO0cwR5I+tYM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313939729"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313939729"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:47:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="641010982"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="641010982"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2022 17:47:39 -0800
Message-ID: <c063e57d-6703-911a-4042-2e58fd91e3b2@linux.intel.com>
Date: Tue, 15 Nov 2022 09:40:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Set SRE bit when hardware has SRS cap
Content-Language: en-US
To: "tina.zhang" <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20221114085514.1105039-1-tina.zhang@intel.com>
 <6a34aa78-17d2-bb44-1e50-76239cd1ffbb@linux.intel.com>
 <adfe9835-2a05-95d8-5506-5fb6163bed43@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <adfe9835-2a05-95d8-5506-5fb6163bed43@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/22 7:55 AM, tina.zhang wrote:
> 
> On 11/14/22 20:00, Baolu Lu wrote:
>> On 2022/11/14 16:55, Tina Zhang wrote:
>>> SRS cap is the hardware cap telling if the hardware IOMMU can support
>>> requests seeking supervisor privilege or not. SRE bit in scalable-mode
>>> PASID table entry is treated as Reserved(0) for implementation not
>>> supporting SRS cap.
>>>
>>> Checking SRS cap before setting SRE bit can avoid the non-recoverable
>>> fault of "Non-zero reserved field set in PASID Table Entry" caused by
>>> setting SRE bit while there is no SRS cap support.
>>>
>>> Currently, both intel_pasid_setup_first_level() and
>>> intel_pasid_setup_second_level() implicitly take care about of it. The
>>> only missing SRS cap checking is in intel_pasid_setup_pass_through().
>>>
>>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table 
>>> interface")
>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>
>> Nice catch! Tina.
>>
>> Can you please double check  intel_pasid_setup_second_level()? Its seems
>> that we missed such check there as well.
> Hi Baolu,
> 
> Yes, I thought about it.
> 
> In current kernel code, the intel_pasid_setup_second_level() is called 
> only in one place and value of the pasid parameter is PASID_RID2PASID. 
> In the body of intel_pasid_setup_second_level, the pasid_set_sre() won't 
> be called if pasid == PASID_RID2PASID, see:
> 
> intel_pasid_setup_second_level(..., pasid) {
>      ...
>      if (pasid != PASID_RID2PASID)
>          pasid_set_sre(pte);
>      ...
> 
> }
> 
> IIUC, in the current kernel code we don't have the case which can test 
> pasid_set_sre(pte) for second_level PASID_ENTRY_PGTT_SL_ONLY. But in 
> feature, if we add more points to invoke 
> intel_pasid_setup_second_level(), we may need to checkout this SRS cap.
> 
> So, do you think we should include the checking in 
> intel_pasid_setup_second_level() as well in this patch?

I guess the purpose of this patch is to make sure that software never
sets the pasid entry fields that are treated by the hardware as
Reserved(0). If so, let's make it explicit in all places. :-)

Best regards,
baolu
