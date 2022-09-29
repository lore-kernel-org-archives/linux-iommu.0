Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC10F7
	for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664438033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUWL2B4Cv64UQClT17QT1666XT/UjjPhkgsubEPyl8Q=;
	b=A8/yxBM3Xs3G2V6D2rYFFQh4ez+sKrCbcuj+BK6bi/lTcDXj5FvOocgRTUvD7kyJFrD4Nx
	viPfet6zLCSllK+Rz185baLU0mDGcdw1uSjh+P1/4YTZpCZyDTPHytbTPwxorccP50hZ5E
	75JoQV1Mj+QI2R3mJsIROdFKsg8nUU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-538-dHeBIPnFNwyZWNTJSilYeg-1; Thu, 29 Sep 2022 03:53:51 -0400
X-MC-Unique: dHeBIPnFNwyZWNTJSilYeg-1
Received: by mail-wm1-f72.google.com with SMTP id v130-20020a1cac88000000b003b56eabdf04so1536279wme.7
        for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DUWL2B4Cv64UQClT17QT1666XT/UjjPhkgsubEPyl8Q=;
        b=k7S7Inq+QnLmb+Q3ACpR0XM2EtChqwkHqg+Mmc6htqg5Xzqmeqduc9DZocuykJHRsD
         wjT6Wx9fJy/MdPCj13PSKiIAWeMaxOL+rLfHUvn5iEulZ8VacsO9eNdUcy0w/6XcNK+l
         Gkp2kltDppaLTAykVjKpLNGMHeWFS0Q/hpowO9w9k6EVmPurG1L7Tef5IEfRQigjsL46
         lbtKxftXlDBCao5gWF+BJamHzoRbpKrIBjn4SadKAi+6zISj2c8nPP+PynieE3knLQhc
         1rU0gGq5hq0YaTA0kStsO2eHY0D6Ql+CDV2XZg0FWITKb+ixBn0bNbtpsSrcp2FD4TcX
         XJLw==
X-Gm-Message-State: ACrzQf0nW0ALd1fqQsT7ZHNcJ8nJMK2u4GlxlOdU3aVH7AelP5BGM7al
	nMWlSChT3+itv1KkzPSweuSpfUe2PNxzaHBQRChc56r2hcz//bKn9JtVEN7j31NursSY//u4bFt
	PrUPwauoqrgV7WQ==
X-Received: by 2002:a05:600c:5114:b0:3b5:428:cf67 with SMTP id o20-20020a05600c511400b003b50428cf67mr9863099wms.80.1664438030892;
        Thu, 29 Sep 2022 00:53:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5S1RWv/BCBQRSJ1Re9xzrIq5uOUDVP4bGN8v8lMUdjsConOrCCFZfxndbYRYsSTtgFj2v7NA==
X-Received: by 2002:a05:600c:5114:b0:3b5:428:cf67 with SMTP id o20-20020a05600c511400b003b50428cf67mr9863091wms.80.1664438030690;
        Thu, 29 Sep 2022 00:53:50 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a319b67f64sm1988470wmb.0.2022.09.29.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:53:50 -0700 (PDT)
Date: Thu, 29 Sep 2022 08:53:49 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Charlotte Tan <charlotte@extrahop.com>
Cc: iommu@lists.linux.dev, yian.chen@intel.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, joro@8bytes.org, junichi.nomura@nec.com,
	Will Mortensen <will@extrahop.com>
Subject: Re: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
Message-ID: <20220929075349.nz2avvokkg7wm3gg@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220929044449.32515-1-charlotte@extrahop.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220929044449.32515-1-charlotte@extrahop.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed 2022-09-28 21:44 -0700, Charlotte Tan wrote:
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
> > The warnings come from arch_rmrr_sanity_check() since it checks whether the
> > region is E820_TYPE_RESERVED.  However, if the purpose of the check is to
> > detect RMRR has regions that may be used by OS as free memory, isn't
> > E820_TYPE_NVS safe, too?
> 
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
> > DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x000000006f760000-0x000000006f762fff], contact BIOS vendor for fixes
> > DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x000000006f760000-0x000000006f762fff]
> 
> This is the snippet from the e820 table:
> 
> > BIOS-e820: [mem 0x0000000068bff000-0x000000006ebfefff] reserved
> > BIOS-e820: [mem 0x000000006ebff000-0x000000006f9fefff] ACPI NVS
> > BIOS-e820: [mem 0x000000006f9ff000-0x000000006fffefff] ACPI data
> 
> There are more details at https://bugzilla.kernel.org/show_bug.cgi?id=216443
> 
> Fixes: f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
> Cc: Will Mortensen <will@extrahop.com>
> Link: https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216443
> Signed-off-by: Charlotte Tan <charlotte@extrahop.com>
> ---
>  arch/x86/include/asm/iommu.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 0bef44d30a27..0e99cc1aec08 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>  {
>  	u64 start = rmrr->base_address;
>  	u64 end = rmrr->end_address + 1;
> +	int entry_type;
>  
> -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +	entry_type = e820__get_entry_type(start, end);
> +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
>  		return 0;
>  
>  	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> -- 
> 2.17.1
> 

Hi Charlotte,

Looks good to me!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

