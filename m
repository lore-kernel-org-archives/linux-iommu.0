Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909028EF
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665403415; x=1696939415;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TyNjrbZfyOe4Dr8bZxsISMhbXDxYv5B56lcDl9+sfF0=;
  b=eZyXtgpqQY9On9JflZg7zqTk6Zeq1nklJn97SmeX+WJA+WE7c2VwAvI6
   3ltwN/FE18E3Tgau1l6Sptg+NguztMpSioYnHQUr8rTB/I4OXlzDw+TBB
   y8vFPGwiy/zTR16maN8VCKvNEGJXb1SS4fM6+gcjHwl65Ze0g2wZbucA5
   I/9Evt4jlZ2rxQr3ll/veA/G3aJd05jXGmEjux7PUbnMx5eBYqJW+6XpW
   S7FM7zUJAs41ObwL6zkKyG7a1WMs1jSQ6bcDRxyui5jjPjExz/+rgjFsH
   ZNtMaskdTItKN/wJRyyi9LkvuVnudpiMvr/vccAtoJslqRwrJWDyCAIlY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="305803191"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="305803191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:03:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="688762502"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="688762502"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.42]) ([10.254.211.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:03:18 -0700
Message-ID: <b03d2ce8-739a-ad53-9cb2-ff09c4ce6f2d@linux.intel.com>
Date: Mon, 10 Oct 2022 20:03:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
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

On 2022/9/29 12:44, Charlotte Tan wrote:
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 0bef44d30a27..0e99cc1aec08 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>   {
>   	u64 start = rmrr->base_address;
>   	u64 end = rmrr->end_address + 1;
> +	int entry_type;
>   
> -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +	entry_type = e820__get_entry_type(start, end);
> +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))

Thank you for the patch.

scripts/checkpatch.pl complains:

CHECK: Unnecessary parentheses around 'entry_type == E820_TYPE_RESERVED'
#71: FILE: arch/x86/include/asm/iommu.h:31:
+	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))

CHECK: Unnecessary parentheses around 'entry_type == E820_TYPE_NVS'
#71: FILE: arch/x86/include/asm/iommu.h:31:
+	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))

No need to send a new version. I will remove the unnecessary parentheses
(if you agree).

I will also refine the commit message to avoid long lines.

Best regards,
baolu
