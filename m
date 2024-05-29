Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7015AD99
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994310; cv=none; b=LutCT74AmZLOzmnlluMBF8vzjKv3gI+2rcjW7z9Wv+LADBwUQWQmguRU3Fb6kaESRd9trR17UQEFEmBloSIfWhdkWD33+VhY9cJWFPoKxa9oY64VR3qrUGC8Bgi6uAxe5khzOeXSpLm99YNgboGr7NNujg04E5o26inXvwL4Y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994310; c=relaxed/simple;
	bh=CarrNEQ+TFs4yVV/8dvu9OMzH178YztGvJC9hxEySos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2uCohs08sBSksEj4M6IWrMwOGDuHnFrMnAptDQO1n/8E2Ue4e2mmjNaUHJH7g5NH3OKgwEfjM7G4+tZ4WEsDB5XIbbQiMEbTanAF8YxuF8AEel6wt2GekXE971h4qtVNpxsoftWNo655OAoKgcE1lX1alglH/h3tuBKERl0REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cu6WNwWL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cu6WNwWL"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0605B40E0177;
	Wed, 29 May 2024 14:51:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DoDuhE1JYgqg; Wed, 29 May 2024 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716994301; bh=BYY7yl5Cy9AZ7D5PdaGf9ZzYi4/LFLjbCNwuYs2lzCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cu6WNwWLJzSSOr7aIaVODt4fhOfy4USYj5NvkmVSUjIJSuTosMEzrBK4IoFkKJVvX
	 HCnQQBTJ7qOXE/TH2ImThpf0YHvrv3g4r+WNe06Apa/0ZnUDYHfjs5b4Zjewcqikyt
	 qM1ExDnUs/nzGbZf+GclEV69sASl8rv0AARyyFcQTiPfuK7v6HYVRxVY0ThDWzhVII
	 EBkCrnSUO68x3RgOUnry12LtYUzVElhxK60HLVym83EKPOdfgwdslyhl4xV210lr2d
	 fT6JGqVo4dh+9vXxrEuslveIccm20OQIQ8xKX60aZ45TC27RnR9p1nenE2z/6v4cjZ
	 J5Sa16A2Y7uBRAc9ABln3V/HPAkI+M1eJnPn84JZ3o8d9Asg0tOlvFiJeOqlGIQgxz
	 MRtJMc5J1GXXiwlpdlOvqzpdpxTLG2RLOVmPrwaNGMoPkQ81loy9ozV/mpaurhS4ua
	 E1AWHLahpPhe9m556yp/AN4HKM2TN4ddHorb4oyrXmtVxUZnceFWLP0+4fYxi5FQhF
	 NORQNbthKrRYERo7hnFs3nRIx0POM4UuCZ1gIFevCmuCKOlpSPZQNMUakQZD7Gn7q2
	 T3htif3vQ9EmhCObb1jz4amB0oPYE9T76mIPCAar88vZ6P1mWGUhI4tF57aMGc+0z3
	 tCeNkHL/YNUSTUpBGzrYJmdU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 964CE40E01E8;
	Wed, 29 May 2024 14:51:37 +0000 (UTC)
Date: Wed, 29 May 2024 16:51:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Fix workqueue name
Message-ID: <20240529145128.GCZldA8NzrvRqmlC4N@fat_crate.local>
References: <20240529113900.5798-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529113900.5798-1-vasant.hegde@amd.com>

On Wed, May 29, 2024 at 11:39:00AM +0000, Vasant Hegde wrote:
> Workqueue name length is crossing WQ_NAME_LEN limit. Fix it by changing
> name format. New format : "iopf_queue/amdvi-<iommu-devid>"
> 
> kernel warning:
>   [   11.146912] workqueue: name exceeds WQ_NAME_LEN. Truncating to: iopf_queue/amdiommu-0xc002-iopf
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: 61928bab9d26 ("iommu/amd: Define per-IOMMU iopf_queue")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/ppr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index b3b690410f2a..7c67d69f0b8c 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -222,8 +222,7 @@ int amd_iommu_iopf_init(struct amd_iommu *iommu)
>  	if (iommu->iopf_queue)
>  		return ret;
>  
> -	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
> -		 "amdiommu-%#x-iopfq",
> +	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name), "amdvi-%#x",
>  		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
>  
>  	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
> -- 

Looks like it should fit, thx.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
