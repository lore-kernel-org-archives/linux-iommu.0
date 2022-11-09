Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBB29B2
	for <iommu@lists.linux.dev>; Wed,  9 Nov 2022 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667999818; x=1699535818;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGiS8NfW0dWzCQaSqeSFNqUhg2rjl+tPtdOmaAPC458=;
  b=hteB62rpJtDJYkZwTwUpvKWX6+XutkrkOG6k8JhqaqPLA6/UKGD2GPWZ
   k01wfWI/7CXlJW46SxFBLr3a6pcR1ydJhpL39lkDmNmLF22o4YuZplW8l
   LarAoopRpCBdfZfD/65D98NRHB8o/mSdrGUqzH6TKqi+CrbENwHndAHcQ
   44vBIt7FXqgZ/JdmIv/kUtREPArvxbFgQp326HGN8k6GLciyB0/2QePH2
   p2S3yevHGBhtL25XIf4KNf1vLdC8qoMJqvGHJpuUPxa2fN97qFBBk9Viu
   klxG3zKIx1gjuQp+P4KWfDOAAuvPrZupCv3CO0oe+HOrD1seQevEHaLpD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312134310"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312134310"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:16:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881926553"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="881926553"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.213]) ([10.254.211.213])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:16:55 -0800
Message-ID: <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
Date: Wed, 9 Nov 2022 21:16:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc: baolu.lu@linux.intel.com, konrad.wilk@oracle.com,
 harshit.m.mogalapalli@gmail.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/11/9 20:16, Harshit Mogalapalli wrote:
> 
> 
> On 09/11/22 12:35 pm, Baolu Lu wrote:
>> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>>> It is likely that modern intel motherboard will not ship with a
>>> floppy connection anymore, so let us disable it by default, as it
>>> gets turned on when we do a make defconfig.
>>>
>>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> ---
>>>   drivers/iommu/intel/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>> index b7dff5092fd2..c783ae85ca9b 100644
>>> --- a/drivers/iommu/intel/Kconfig
>>> +++ b/drivers/iommu/intel/Kconfig
>>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>         option is removed in the 2.6.32 kernel.
>>>   config INTEL_IOMMU_FLOPPY_WA
>>> -    def_bool y
>>> +    def_bool n
>>>       depends on X86
>>>       help
>>>         Floppy disk drivers are known to bypass DMA API calls
>>
>> Nobody selects or depends on this. How about removing this bool? Only
>> less than 10 lines of code are impacted and are not in any performance
>> path.
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index b7dff5092fd2..5e077d1c5f5d 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>         to use physical addresses for DMA, at least until this
>>         option is removed in the 2.6.32 kernel.
>>
>> -config INTEL_IOMMU_FLOPPY_WA
>> -    def_bool y
>> -    depends on X86
>> -    help
>> -      Floppy disk drivers are known to bypass DMA API calls
>> -      thereby failing to work when IOMMU is enabled. This
>> -      workaround will setup a 1:1 mapping for the first
>> -      16MiB to make floppy (an ISA device) work.
>> -
>>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>       bool "Enable Intel IOMMU scalable mode by default"
>>       default y
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 48cdcd0a5cf3..22801850f339 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4567,7 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
>> device *device,
>>       }
>>       rcu_read_unlock();
>>
>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>       if (dev_is_pci(device)) {
>>           struct pci_dev *pdev = to_pci_dev(device);
>>
>> @@ -4579,7 +4578,6 @@ static void intel_iommu_get_resv_regions(struct 
>> device *device,
>>                   list_add_tail(&reg->list, head);
>>           }
>>       }
>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>
>>       reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>>
> 
> Hi Baolu,
> 
> I have a question:
> Shouldn't we remove the code between ifdef-endif statements?
> 
> I mean something like this:
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index b7dff5092fd2..5e077d1c5f5d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>            to use physical addresses for DMA, at least until this
>            option is removed in the 2.6.32 kernel.
> 
> -config INTEL_IOMMU_FLOPPY_WA
> -       def_bool y
> -       depends on X86
> -       help
> -         Floppy disk drivers are known to bypass DMA API calls
> -         thereby failing to work when IOMMU is enabled. This
> -         workaround will setup a 1:1 mapping for the first
> -         16MiB to make floppy (an ISA device) work.
> -
>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>          bool "Enable Intel IOMMU scalable mode by default"
>          default y
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 48cdcd0a5cf3..2c416ad3204e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
> device *device,
>          }
>          rcu_read_unlock();
> 
> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> -       if (dev_is_pci(device)) {
> -               struct pci_dev *pdev = to_pci_dev(device);
> -
> -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> -                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
> -                                       IOMMU_RESV_DIRECT_RELAXABLE,
> -                                       GFP_KERNEL);
> -                       if (reg)
> -                               list_add_tail(&reg->list, head);
> -               }
> -       }
> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> -
>          reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>                                        IOAPIC_RANGE_END - 
> IOAPIC_RANGE_START + 1,
>                                        0, IOMMU_RESV_MSI, GFP_KERNEL);
> 
> This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA 
> direct mapping region via iommu_get_resv_regions")

As long as floppy driver exists in the tree, we have to include above
code. Otherwise, floppy drivers don't work. At least we can easily find
drivers/block/floppy.c which is still maintained (check MAINTAINERS).:-)

Best regards,
baolu
