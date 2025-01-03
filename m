Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12661FAC23
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923171; cv=none; b=fUQTVKGP73UNAv8QuNqTPNVrrBCFWc2HkYy/s+Czq2X0IkB6rnGjzLV/Ih7DZ+dvsbAaJxAgnipMWPsp169vnmgb09lXQkY+TukQJ2oeaFqVkCcWAyErYny457zq8885GNzejzfEC19oTKSKsYd0nwVlZrmBl5MLTfhmN5w7vVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923171; c=relaxed/simple;
	bh=PEHIG9ohURHAR96qiOtWNGl0nFkYJc+mtPLR7plfDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0n8Fm5KFb1kateYhKF4+lKBoPa0YR3j90SbqAh5ED+9BpDF5B6J6eowqmoegQHCyOyfx/TmgKPX+Nz2tVhytwGbWlRD4ZM5kB5v9Jp1SV4Mw98hhALspyoSineNZ1U7ut0dsktsElfxN7Mp4V6sC+9VheIgrLb099eoq1/gvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=n7T10g9K; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="n7T10g9K"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TkmAtFMc3Pkq2TkmDt6jxY; Fri, 03 Jan 2025 17:44:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735922641;
	bh=klF7J8SE9bGSUAOSRQxXVFURwTU25T0w4t0V+YKbRzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=n7T10g9K3+M/9dj9dfjzAmh1UIQGQcOOAcEvYcwCFkvLPa5hcFvUM3x2mG9tXiaGp
	 xrxEACc03qXqX38ZLOccpK9qnHd5Hh1C5lwXuKrI/K9D2OEiRJ/d4VhcCVWWM+1rpa
	 lmV0F4bF062BA1W0sMlImhVSgK8M4hr+wC8Qhj04l25wCvxFbOuTmR1hYEGKh1FfPN
	 0IWLhLdHSsudVBbAm9GHK3MdhoHSodEfhAtmx+8+k4VzA3OQeE77ilTnQI0xFOQ6HQ
	 fnjH8WvYXEL6khA48yd9TROysmAI9COC1oJ7Tx6R1nl3iODkmdfYE3VLr7xiItwiyY
	 Qa2EQOiyoAPjA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 03 Jan 2025 17:44:01 +0100
X-ME-IP: 90.11.132.44
Message-ID: <a311b6b9-a475-43b6-bb88-3e3d623ea2b3@wanadoo.fr>
Date: Fri, 3 Jan 2025 17:43:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: remove return value of amd_iommu_detect
To: Gao Shiyuan <gaoshiyuan@baidu.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250103163842.79259-1-gaoshiyuan@baidu.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250103163842.79259-1-gaoshiyuan@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/01/2025 à 17:38, Gao Shiyuan a écrit :
> The return value of amd_iommu_detect is not used, so remove it and
> is consistent with other iommu detect functions.
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>   drivers/iommu/amd/init.c  | 10 +++++-----
>   include/linux/amd-iommu.h |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 0e0a531042ac..98a42f3f9e53 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3398,25 +3398,25 @@ static bool amd_iommu_sme_check(void)
>    * IOMMUs
>    *
>    ****************************************************************************/
> -int __init amd_iommu_detect(void)
> +void __init amd_iommu_detect(void)
>   {
>   	int ret;
>   
>   	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
> -		return -ENODEV;
> +		return;
>   
>   	if (!amd_iommu_sme_check())
> -		return -ENODEV;
> +		return;
>   
>   	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
>   	if (ret)
> -		return ret;
> +		return;
>   
>   	amd_iommu_detected = true;
>   	iommu_detected = 1;
>   	x86_init.iommu.iommu_init = amd_iommu_init;
>   
> -	return 1;
> +	return;

This return is not needed any more.

CJ

>   }
>   
>   /****************************************************************************
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 2b90c48a6a87..062fbd4c9b77 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -31,11 +31,11 @@ struct amd_iommu_pi_data {
>   struct task_struct;
>   struct pci_dev;
>   
> -extern int amd_iommu_detect(void);
> +extern void amd_iommu_detect(void);
>   
>   #else /* CONFIG_AMD_IOMMU */
>   
> -static inline int amd_iommu_detect(void) { return -ENODEV; }
> +static inline void amd_iommu_detect(void) { }
>   
>   #endif /* CONFIG_AMD_IOMMU */
>   

