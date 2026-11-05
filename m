Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853274;
	b=HLbjNiOBn1jitlklgvSNBIGHcc9nLVndIxLe15EQYKdmsh1Su23PcjGeOd72ha5bl4/8
	 +hIzMDx7drH8PDJtJd1CKrhWu04ARme6cWgJjG7fFQfbMSYHObID1SDbGv4ObIc2GdEm7
	 64yB1HmCaHkO0uR12bP79L4i5Oc0A5UsRkvytsmW3yTA1ynY47Tgipb2FeKVewYw6BwL5
	 44VwynLxkeDSXB5wK1NJL3/1t53sMfd/PRXHQSPPNG4TIisXbUaUgDcNVN3yKY4M3DNBI
	 WJTcvykD+OhTHS9Jy1hRj/7wDBhooDVVt4zZgl5CmoQ9xyHcqd+SvoR9Zk7Dr6LEGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853274;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=uybwsAJQuB7JYpjUDH4A7OxDLSrNrGRSbd7CyU7FLoA=;
	b=sJXZCTnE2cfSy6LlhkfAzdfs/SpO9Mf5kpFEtDkHbG8XH81jda16CTspncMuhJYA1Vi9
	 QxRCOQW9Uk/kSA1CipE14NpCIpHZh0AojzD+oZ2ldTCP5tDq+NXs3OEPXXG9Gz074zd1k
	 kOXkfIXRqup50DbZ1QFBkVy+c7E4b5hEONABmh830Ru0ZJdcN47BlKdnEdqn5Ls60XR/t
	 X/vehcwOKd8ghKC7zo/TfP0yTZymwX9A6bWI0FWGxAFdQe/9jdjGUzRHVZo6vH1GcI65/
	 V938TNLw+xm4zCI9kfPsZ9d2jyo8WabHXwQWdRd8vtbbTDKk0BuXrC/NYEC5DC5bILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBI1fbuT;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E7606A334
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 041E7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBI1fbuT
Received: from [192.168.166.159] (unknown [67.168.101.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26DFC20B7168;
	Wed,  4 Nov 2026 20:34:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26DFC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793853257;
	bh=uybwsAJQuB7JYpjUDH4A7OxDLSrNrGRSbd7CyU7FLoA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IBI1fbuTwD+Mh2OnOY0JrkHzfSgXQNIRc7sEUtfZifblMLrC5P0ImROdvMimnb8/s
	 r2jdnbTxTYBTdXcVgT4dWaIYMd6ZJ90dyFGZ2pfZkk+CKtaXbSyHV+aJvfL5HOBW0G
	 MTD+MmvCwofQHLzmOMtERvlFNs55y3S0+4P2RqwE=
Message-ID: <9558730f-42d5-4d90-8fe8-f6d1c150164f@linux.microsoft.com>
Date: Wed, 4 Nov 2026 20:34:32 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V4 4/5] iommu/hyperv: Only call pviommu init on non-root
 VMs
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-5-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105020106.3496339-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 18:01, Mukesh R wrote:
> Next patch introduces root iommu init. Since both can co-exist, set
> x86 iommu_init to pviommu init only on non-root VMs. Also, rename
> hv_iommu_init() to hv_pviommu_init().

[...]Lastly, check for null iommu_init
> before assignement as suggested by one of the pviommu authors.

You no longer do this below. Also, please wait a week or so before spinning
a new revision to collect additional comments.

With that fixed,

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c             | 3 ++-
>  arch/x86/include/asm/mshyperv.h       | 2 +-
>  drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b90e6f487533..ea50708c3ae6 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -580,7 +580,8 @@ void __init hyperv_init(void)
>  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
>  
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -	x86_init.iommu.iommu_init = hv_iommu_init;
> +	if (!hv_root_partition())
> +		x86_init.iommu.iommu_init = hv_pviommu_init;
>  #endif
>  
>  	hv_apic_init();
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 24b19cd28a05..c95d75ae645e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -320,7 +320,7 @@ static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>  #endif
>  
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -int __init hv_iommu_init(void);
> +int __init hv_pviommu_init(void);
>  #endif
>  
>  #include <asm-generic/mshyperv.h>
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index 876a22f21f1e..a40a8ceb3261 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -601,7 +601,7 @@ hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
>  	hv_iommu_device = hv_iommu;
>  }
>  
> -int __init hv_iommu_init(void)
> +int __init hv_pviommu_init(void)
>  {
>  	u64 status;
>  	int ret = 0;

