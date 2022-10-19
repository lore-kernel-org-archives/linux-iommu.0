Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A491FA8
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 00:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666141115; x=1697677115;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y6VwoXWH+0YTxCvR+5Ng1vSC+O9GoPcGr+YuXC1tYKo=;
  b=CYR7Q/Uq9q8iLJi8/JmSpZEmIhBAiaA5eRuuUfutXvsac50kHLvRBizS
   fDPyGUyFe57IW4mTFShDHu/YirBi7PuWHQD4pDZ299CX7SG4Cz31ZB3xP
   hxwWbXU8G/A+DHq0S41EzsJ047JjjL+leKVus8nwz9HFhSdz6f24H3Lug
   Yx82/kwxjOxuHLZJtDUDFiXbrCwXhPevywkm/bkkJHeUnx88XoeRt3++l
   ikiZcmqBR5SatQDqVj4QUdtldTCpvecqdujrP52HXvfwT0vaESRIQG6yw
   NEfep7JBjgWtjqA0xdcuZlp+VzO/BpxRmxkNRnl/x6pBlCWXG8Vt2dJpj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303889472"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="303889472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660078396"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660078396"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 17:58:32 -0700
Message-ID: <4a5f0d61-cc25-33bf-b29b-7f62b2424c4c@linux.intel.com>
Date: Wed, 19 Oct 2022 08:52:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, yian.chen@intel.com, dwmw2@infradead.org,
 joro@8bytes.org, junichi.nomura@nec.com, atomlin@redhat.com,
 Will Mortensen <will@extrahop.com>
Subject: Re: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
Content-Language: en-US
To: Charlotte Tan <charlotte@extrahop.com>, iommu@lists.linux.dev
References: <20220929044449.32515-1-charlotte@extrahop.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220929044449.32515-1-charlotte@extrahop.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/22 12:44 PM, Charlotte Tan wrote:
> arch_rmrr_sanity_check() warns if the RMRR is not covered by an ACPI Reserved
> region, but it seems like it should accept an NVS region as well. The ACPI spec
> https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html
> uses similar wording for "Reserved" and "NVS" region types; for NVS regions it
> says "This range of addresses is in use or reserved by the system and must
> not be used by the operating system."
> 
> There is an old comment on this mailing list that also suggests NVS regions should
> pass the arch_rmrr_sanity_check() test:
> 
>> The warnings come from arch_rmrr_sanity_check() since it checks whether the
>> region is E820_TYPE_RESERVED.  However, if the purpose of the check is to
>> detect RMRR has regions that may be used by OS as free memory, isn't
>> E820_TYPE_NVS safe, too?
> https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/
> 
> This patch overlaps with another proposed patch that would add the region
> type to the log since sometimes the bug reporter sees this log on the console
> but doesn't know to include the kernel log:
> 
> https://lore.kernel.org/lkml/20220611204859.234975-3-atomlin@redhat.com/
> 
> Here's an example of the "Firmware Bug" apparent false positive:
> 
>> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x000000006f760000-0x000000006f762fff], contact BIOS vendor for fixes
>> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x000000006f760000-0x000000006f762fff]
> This is the snippet from the e820 table:
> 
>> BIOS-e820: [mem 0x0000000068bff000-0x000000006ebfefff] reserved
>> BIOS-e820: [mem 0x000000006ebff000-0x000000006f9fefff] ACPI NVS
>> BIOS-e820: [mem 0x000000006f9ff000-0x000000006fffefff] ACPI data
> There are more details athttps://bugzilla.kernel.org/show_bug.cgi?id=216443
> 
> Fixes: f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
> Cc: Will Mortensen<will@extrahop.com>
> Link:https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=216443
> Signed-off-by: Charlotte Tan<charlotte@extrahop.com>

Thanks for the patch. It has been queued for v6.1.

https://lore.kernel.org/linux-iommu/20221019004447.4563-1-baolu.lu@linux.intel.com/

Best regards,
baolu
