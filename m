Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35B131E5D
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550497; cv=none; b=un1qLDt5o2RPdA0KktXPCxHMavNTNLKzQAtSgQPBXv3SAtqxy3BdDzjlaRTc/YkXeDsif4pWKOUSue0hLzDBDAEXytIw3/s4RQMYvcoPA1kXVaE4cHk4zvQ4Bh1lyN1/RJPN7f9bLOTKHtfM9MmPPCT70rdLA9ptxAS6mG5MiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550497; c=relaxed/simple;
	bh=Zi9+/2bZWHYcRVwbVahiNExFAIP6YNcPdIl+erVGWAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+VLKDKAGgZ/EQV6tHd6w7Tfk9v6dG+7OrerkFKJ9sisxJCpzmYW+1iTooERNJMQuHNs5pNZaGOmInFlhiAUgwxABVQp0tXK2OVkLN2mD3YuqXC9fXP7emw9pohTqe9qSx3+kiazpsETEa950COgJTotpwm10fSVcVEY8pP37Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF5whSma; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF5whSma"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dcc7c1055bso681098e0c.0
        for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713550495; x=1714155295; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57GABgAlSf9ZFESIWB58CmR4AadAHXOBwDqFNyeDfBw=;
        b=bF5whSmaaHEtoOkAGo8DhE6Pv/bHXkbz+ICqzCJ1bdedAO0o01DbsO5d5BsbFglxh7
         epHtPypo4YyMhN2PIf+82E0iaRNEw+yRM9+w9/WrMYqy/tdcnPPMeYqj9mxdF4xjKJoS
         tADA9ycMcfM1PtEYYoZJuuzOOhRi7n7Og6b0JC2RulPlJAGFOXPwR05C9uYqtWNYQchO
         hanv6I0k7hg88bjxxG0glrMVpE6LtKvWH8atRYG7g3QXWpJyYA/mgdCWUB2hmYSKYu6N
         4RCy2xyRuKszbaMhqUNJAHq1sznvv2Z1q+oVXqttQxjQJwdXEhVAY5XKJAxlzE6Qt3eD
         UV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550495; x=1714155295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57GABgAlSf9ZFESIWB58CmR4AadAHXOBwDqFNyeDfBw=;
        b=FJ26rPdiWpI7JFVqSCECd1OFYZ/JoRfJFuOB2z4iGYOxtjT7T1Adpk6/cmEEs6uKzD
         0FvTXDWx4eq3fDdQw0dERnQOYI/1OoM2QO6cfWRJ37Qde1FkrxyU/PQQaviWkeEeXRbY
         Hz2vVB/5X+XDpGl/9YG8FkPngK4bPhZqs4e/FW2gun4fRnXzvq4PT8Wz28lbtR5ImPfM
         7RNO28lKAOHnp3hEoLmE4cHIH6FOmNZ7I7zhNwTUER6RWNERu0ag3C5NxxamN3v4mqdz
         hWj+wUkkFJ3OGtQ/WW3xDZ8jiuwqgwAMEU/dAsOdm2s99Ser87G5kmYvFVcxF0Bf/u8l
         k1TA==
X-Gm-Message-State: AOJu0Yz3Y6/UkV9hKRVe49cySQEYl1zNGAgcpiCZbrEht9neBptWZ7wZ
	A0h+o0ESmNakii2mBcLuORvd0neUFLsih5ZAkKoIZ9I/uPj+hbc1+pYAgy0lHkX2PMRB4Cx/wBi
	Mfsle/1aJ3yTjJNUb3PfxAlzK10E=
X-Google-Smtp-Source: AGHT+IGVyhZzLcyKNeONoHWO5Vpd993PGCkSJRc1acyKtcNVUOAPPV3OLMlto+h5lwlOpuFmo/gfmP457fnzmr00yyc=
X-Received: by 2002:a05:6122:1810:b0:4d4:be1:8196 with SMTP id
 ay16-20020a056122181000b004d40be18196mr3118848vkb.11.1713550494947; Fri, 19
 Apr 2024 11:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240419114715.6028-1-vasant.hegde@amd.com>
In-Reply-To: <20240419114715.6028-1-vasant.hegde@amd.com>
From: Eric Wagner <ewagner12@gmail.com>
Date: Fri, 19 Apr 2024 14:14:44 -0400
Message-ID: <CAHudX3yemW5Yp32aagGPM0T34mr6RO+PqNShkn=YkXjWepP2gg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted device
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	alexander.deucher@amd.com, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:47=E2=80=AFAM Vasant Hegde <vasant.hegde@amd.com>=
 wrote:
>
> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
> untrusted device. This always took precedence over driver's
> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()") changed
> the behaviour. Current code calls def_domain_type() but if it doesn't
> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
> results in IOMMU group (and potentially IOMMU itself) in undetermined
> sstate.
>
> This patch adds untrusted check in AMD IOMMU driver code. So that it
> lets eGPUs behind Thunderbolt work again.
>
> Fine tuning amd_iommu_def_domain_type() will be done later.
>
> Reported-by: Eric Wagner <ewagner12@gmail.com>
> Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU=
5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() t=
o respect def_domain_type()")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: stable@kernel.org # v6.7+
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> @Eric,
>   Can you please test this patch?
>
> -Vasant
>
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e692217fcb28..e405714640b0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device=
 *dev)
>         if (!dev_data)
>                 return 0;
>
> +       /* Always use DMA domain for untrusted device */
> +       if (to_pci_dev(dev)->untrusted)
> +               return IOMMU_DOMAIN_DMA;
> +
>         /*
>          * Do not identity map IOMMUv2 capable devices when:
>          *  - memory encryption is active, because some of those devices
> --
> 2.31.1
>

Tested the patch and confirmed it fixes the reported issue for me.

Tested-by: Eric Wagner <ewagner12@gmail.com>
