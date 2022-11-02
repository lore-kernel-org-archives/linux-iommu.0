Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E41EA01
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 17:29:09 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so3765695pjh.1
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XngaLyoddCmH4VlYM2PfyFy1z8QIlSHJsQqMTNSL+fY=;
        b=LFmDcNdVJo4K4/FarOGyy+iYSahg3fpZVoW20EDjy0GMIKfgTNw8fvtAhQ15msH1Qk
         VHt/frVwIRzA+95aTCRBawF42Gjwv69pcfAiYAtFa+IxWw2c0L81a72SzNLI/zhYVV0t
         K0ZHQnNrJhHrs41sUlChWL8od2BcBx7+xb65Sk1Jcosp5Emqdq+E1yeRQzcf4I9RGVys
         8ZCwtkteD0c7nGMW6HOZLCT7XbRkNkFFlndsU3/uIegcdYqiHKLssHEw65pubDMfcOz6
         H3vQiqJ9dW6NCjeFtTBEAmTHFWCogGMbqctU+cPtFHx9OfivrJ2DvIF1PBdYIYi7VXf1
         hMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XngaLyoddCmH4VlYM2PfyFy1z8QIlSHJsQqMTNSL+fY=;
        b=YcDVCrHGuAWnGI9DHk9cRHcxs79q4dFMOuNyoq0jgRLp+sR3WzhfIjd9Lj8Pqjx2bt
         Vdl2QEn5bZX+RrmhUgnMtBaEIEON+yNEDmKse1rVEgKbQTR+XwBiRl5GRh6Ll+9h4mih
         ZAADCmfRdFVGQxmpF6p0+ynj6P5l+mG1fjlknLnYJbe2aC3PyDAmezD3eZbLNd+uWlht
         CW8StPOPyt3CuvVz1CyeAy7vI7HPZRsZDG8gU+alprZ4LgP9VK7nie6gH2X7AG7hyvdg
         9CvDd480Bs11JQFFo3Ixu69n9aVq9x07RBQe8NWm+UdQ94DumLcTfIKncUWFeixGVCam
         k3UQ==
X-Gm-Message-State: ACrzQf22BDbcQeuwFZVbVfBliC8axqS1vsNc/eztIat2NeBNSMJWyrEs
	Kz0Ggna92MhnPjHio35HecY=
X-Google-Smtp-Source: AMsMyM468ueCiGPw9Rp6pG6tj4yCN+Kg/96HSi3gaDaAY7Jy/SDnxCyzS2YodJhnzcubFb/rCwO4cw==
X-Received: by 2002:a17:902:ab89:b0:186:7cfc:cde8 with SMTP id f9-20020a170902ab8900b001867cfccde8mr26293355plr.9.1667410149118;
        Wed, 02 Nov 2022 10:29:09 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0016f196209c9sm8651878plh.123.2022.11.02.10.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:29:08 -0700 (PDT)
Message-ID: <b0aa0d72-d3f3-93a9-1fa9-553c1c0351ee@gmail.com>
Date: Thu, 3 Nov 2022 01:28:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 03/12] x86/hyperv: Reorder code in prep for subsequent
 patch
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
 peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org,
 kw@linux.com, bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Tianyu.Lan@microsoft.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 ak@linux.intel.com, isaku.yamahata@intel.com, dan.j.williams@intel.com,
 jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev
References: <1666288635-72591-1-git-send-email-mikelley@microsoft.com>
 <1666288635-72591-4-git-send-email-mikelley@microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1666288635-72591-4-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2022 1:57 AM, Michael Kelley wrote:
> Reorder some code as preparation for a subsequent patch.  No
> functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   arch/x86/hyperv/ivm.c | 68 +++++++++++++++++++++++++--------------------------
>   1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 1dbcbd9..f33c67e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -235,40 +235,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
>   EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
>   #endif
>   
> -enum hv_isolation_type hv_get_isolation_type(void)
> -{
> -	if (!(ms_hyperv.priv_high & HV_ISOLATION))
> -		return HV_ISOLATION_TYPE_NONE;
> -	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
> -}
> -EXPORT_SYMBOL_GPL(hv_get_isolation_type);
> -
> -/*
> - * hv_is_isolation_supported - Check system runs in the Hyper-V
> - * isolation VM.
> - */
> -bool hv_is_isolation_supported(void)
> -{
> -	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> -		return false;
> -
> -	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> -		return false;
> -
> -	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
> -}
> -
> -DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> -
> -/*
> - * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> - * isolation VM.
> - */
> -bool hv_isolation_type_snp(void)
> -{
> -	return static_branch_unlikely(&isolation_type_snp);
> -}
> -
>   /*
>    * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>    *
> @@ -387,3 +353,37 @@ void hv_unmap_memory(void *addr)
>   {
>   	vunmap(addr);
>   }
> +
> +enum hv_isolation_type hv_get_isolation_type(void)
> +{
> +	if (!(ms_hyperv.priv_high & HV_ISOLATION))
> +		return HV_ISOLATION_TYPE_NONE;
> +	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
> +}
> +EXPORT_SYMBOL_GPL(hv_get_isolation_type);
> +
> +/*
> + * hv_is_isolation_supported - Check system runs in the Hyper-V
> + * isolation VM.
> + */
> +bool hv_is_isolation_supported(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +		return false;
> +
> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		return false;
> +
> +	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
> +}
> +
> +DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +
> +/*
> + * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> + * isolation VM.
> + */
> +bool hv_isolation_type_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_snp);
> +}
