Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940A364D5
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810550; cv=none; b=uMBkX4pFRSbtCiYPOiHmhf8C84XnE0ZHa3eGBCIXVY9iEfwM8Lw1xcZTLyKpINqlke/maL3I8N9JpEQvwv2vfMgsbR9Px0wYd4NmTcuSSfFeMy0ZyqLvk1qWOuyetMccSGDqJwHr0Cq2yPG6m2xsiY7q114sS7iZW5f0OBP1oiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810550; c=relaxed/simple;
	bh=LjUvzK38BjXgqC9AEEPWhEc68CiG1UUjHeslwXrZX9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn6WmySQzHIzey1c/RrDAFuajsnC4OJm63ss1DeAyHgt7ZFC9elB4uzvKWrJCI9ikwwThp7oQwLYHC7qDFftmZj0o7rEXR8GQN0VCVxEcuJtJSpehLtizAMJIUWj8WUm19zxN/rg+pUs7PW1oFcShj9Rls5LnL/FZftiwn0xk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R6z9qPhU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R6z9qPhU"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783f49812aeso53527385a.2
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706810547; x=1707415347; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1LEFP848wI0Z7rMsRyDSzKHhkYnEw1rfZ/5sroHKA4=;
        b=R6z9qPhU45XP79xky3hCub3Yc+CvSVV8xj6z5zWW+4gnDyMNkwjQpbLOGxvm+lxZse
         NS+sSXKJCoO9M2CuwIzguja/D/2/XvKKoXaC6Z+9mkV1tcnjFW9qDEpwVfG5uuf1tSug
         ZMb3IebUJ1yywhpD0StvupWgwZmK+xArIrUvH9ZeW3NxDYhK/OcKVvYroBInryeQGPJS
         Ef2FE9G8O13NjhZxhogQh3a81+a9fXwrfTMSROUFthffxLtm14Dj6bxGVKx7Wnwlf9DH
         LkzmJSW/S7JZvPyfbQlqxBGfRBpzufdbhm2Cs8wfX5PCZsXtbSm7x2IZidIndWZxmyxH
         D9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810547; x=1707415347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1LEFP848wI0Z7rMsRyDSzKHhkYnEw1rfZ/5sroHKA4=;
        b=JNZs0tIxqjrWANWNYcMoV3QO1f+XZqRvAje5ZLbuSKZF1Byr67h092j770oVxuXjCi
         zvVRtPPzbmAOssyi6q+yx4VV3RqwmafzctaDOJae2TIBaaX4sAsrWGYb6aYoRDuv6Gyj
         uvIYfWKReE2Y8PcwPYt3aU/SpwLLISVYtj6k0yRksGSR/LLqur7EPvzAkeP5SlQooA/y
         tlzylLCwv+28Xf1nrU1sQmXsojeygZPERJzjeIrgPf4yeDKKJLCmc0Xpl2resDIJWNKd
         dsxc3oTXBUIgISanNeRKECgKqi79nQmiuemo5PI0ltJIhTh3TSsx70BHEHMvfImZpIOV
         MKFA==
X-Gm-Message-State: AOJu0YziKELjazalS/QA8QKf+c292676cszY3NOunQp7C2YSakgnZRCY
	FBjU3x0voVXHLtKe8TpPD1zEtSVGnG11SomXRuc3Jb4EdYaNkXaVIzOSS4G4APo=
X-Google-Smtp-Source: AGHT+IHqqb+uF8uGy8haT3Z4vsF5/DJRnR3yfWDt/MUTRiULykvAyIpvRx/e48WvhJ2Ux4q7P0kdyg==
X-Received: by 2002:ae9:e905:0:b0:785:3b47:ffd0 with SMTP id x5-20020ae9e905000000b007853b47ffd0mr3589854qkf.53.1706810547710;
        Thu, 01 Feb 2024 10:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWdKnNd5CZ8/r1mLM1p+fQb2hVxxJPuxOZmhBRczdZGaBUAAHCJkkVaTJIlmkjZtfmKUKtRzo9NP6kpA/hQJ9LfwJAghIY1EbpNsdmVcrIio6AmYK6eqnCOVZxTEE7alSR2gAPt7Tw3PRfWWUx9ji2oXkukwhzZb4kOgut3hKqN6KSNrseWW/c=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a120200b00783de6b5ccfsm16145qkj.88.2024.02.01.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:02:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVbOM-00AnPT-Mo;
	Thu, 01 Feb 2024 14:02:26 -0400
Date: Thu, 1 Feb 2024 14:02:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 13/17] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240201180226.GN50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-14-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:31PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
> instead of GFP_ATOMIC for GCR3 table allocation. Also modify
> set_dte_entry() to use new per device GCR3 table.
> 
> Also in free_gcr3_table() path replace BUG_ON with WARN_ON_ONCE().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 53 +++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 22 deletions(-)

The code looks OK after this so

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1924,14 +1933,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  	/* Init GCR3 table and update device table */
>  	if (domain->pd_mode == PD_MODE_V2) {
>  		/* By default, setup GCR3 table to support single PASID */
> -		ret = setup_gcr3_table(dev_data->domain, 1);
> +		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
>  		if (ret)
>  			return ret;

But the patch order is off here. The above showing this was using
dev_data->domain for a few patches is not perfectly bisection-correct.

Patches 11/12/13 are all sort of entangled together so I can see how
it ended up like this. You could probably squash them together and be
fine if someone prefers to be sticky on this.

Jason
