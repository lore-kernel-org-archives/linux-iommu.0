Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA51758F
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130622; cv=none; b=BZ9mz/wYB/TSHvkAy7cEuA6kH2WLUTyZy4nKHsVSmwhtQiNzUwOeZrJwdVOPJrPw03GKv0rWRfmgE//2UydNiVc5X270rmNMJfrqSZ8EZtqDANfrRu3HpsflNC7O2F64p4BUfhZmi3G11tikzT/8HF8kZPzuM943tYWGAre4TFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130622; c=relaxed/simple;
	bh=jDCr5ifs2jFyUCR8Wlikob41awnwZSkFKxOVNboyzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofm4hPufu6uaZ7F1klJMvhN3tvKc2HVQRlZVII8SmUDOnFVNorazvg5daMWdzUa+hnVzmX5PZAP4iNArR7zS95MEEAPL1BAtyVWjWkt7J85DDQ7NrcuH3pomwGkoTqpMHeXY8i+zinORsrYr9f2QRvX5fo/Dou20Uu87I49utv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHydSbId; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHydSbId"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30e445602cso1094716766b.0
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 02:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707130618; x=1707735418; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHuHF9Obfsev/lyEPMBOyVJSSPAo2wmNIcg9snCOcj0=;
        b=PHydSbIdK7y7mHIJ1JHEi5O08egiwNHVdzPJ5bYMeXeFYTv5veApQIYZadX2ozI/K7
         rP05y6d/WZ4YFtUPLwn0157DdS0QSi5axu1B4mEWUvf1hMlYtwDb69Dyfgk5/P1J1D+H
         a4z89nEwSonKzD7SYnKR/ElIjbpZ86+H49qiRr3aI5y9BKlHhigjbV2WfpuugQHOtBkd
         J5zqYfagXD7YWcADkCpIobECsFUmiDfwoYHrgh+HT1qRFmgxyto6dez+8adSoN0iZjH4
         CmvHzsaCe73n2AMu4ep/FVUo+gfSJu0yED2KBAe8D3j33ab5o89DU2hq1PIs0ia/XlqA
         gqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707130618; x=1707735418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHuHF9Obfsev/lyEPMBOyVJSSPAo2wmNIcg9snCOcj0=;
        b=kY9AyWi6FzD0cfJm8oq68cvBb4/psV4uHi8W3tHi2AgltVujrVL6r3x/wYgsrBz1pI
         vhr2SWRTceZInfSw1eTV+EaXwhRosdhSv0fPZwTvvSrIcbFozskapM/nL22swvhzLNeO
         8uHV0zDB9lGPRDTJ2jesG3IC8HQfGYL4XW4Qzs2fSjEfgzHsbFmF/lsFG3qiIASAb540
         TmZFaaBXiFuQNxSwRbZVHG1xw+QZ6X2btOWscK1KH90IxP3z2w3ktHVlj9lIeI/rvrho
         Jn7f6QVWDxjSMG3TPDtWqyl14x4GSceIFr5ydn7JZ6fweCYQMhIUfAMSVcnXkMTCaciG
         TtOg==
X-Gm-Message-State: AOJu0YzY/dcOeXMgvhuidtngFGJNtdYJAYB86d9WDsPyu0xrNL8nfx/6
	OZz/IXBtwjlT/k6RPzKWZtVlgljGPAg6N/NUGkEUnJOgTdwRk3Yy4UgJpiR5vno=
X-Google-Smtp-Source: AGHT+IFmIPVEmAYqqtOtPZb03iOGqGY79yQzdRB9o8BeYriazP1ZzLdKyIsRE3fnekbsIPTwyMF6Dw==
X-Received: by 2002:a17:906:358e:b0:a37:e065:43be with SMTP id o14-20020a170906358e00b00a37e06543bemr1024366ejb.23.1707130618489;
        Mon, 05 Feb 2024 02:56:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU75PKw4rpfkBsBugGVg2B5XhD9EXoGKAJTguZG+EhTywKZb8TwRbdl8DXBMaJ/shIdLOEGWkHfRiZLZGkO5mvxc0u7yc9ZHohDNBxFYre2rS6E2sHvlL/TzKBhPzdtJARFxTbBN5nGWqFpDLH/n97HI26UHA==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b00a3543718f5bsm4180413ejb.221.2024.02.05.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:56:57 -0800 (PST)
Date: Mon, 5 Feb 2024 13:56:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <73295c7c-f371-4d70-8a7d-c54ca9be6cbb@moroto.mountain>
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
 <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
 <20240202133557.GR1455070@nvidia.com>
 <46d7086c-36fc-4668-b95b-454e339b94c0@moroto.mountain>
 <20240202145907.GT1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202145907.GT1455070@nvidia.com>

On Fri, Feb 02, 2024 at 10:59:07AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 02, 2024 at 05:45:43PM +0300, Dan Carpenter wrote:
> > On Fri, Feb 02, 2024 at 09:35:57AM -0400, Jason Gunthorpe wrote:
> > > It won't silence Dan's warning warning but it will correct the bug for
> > > now.
> > 
> > I could just modify the database to say that
> > arm_smmu_update_ctx_desc_devices() doesn't call arm_smmu_write_ctx_desc()
> > with preempt disabled.  I don't think it will silence any true
> > positives.  That's a one liner for me.
> 
> But it does and it found this bug :)
> 

No, it would just remove the one link between arm_smmu_update_ctx_desc_devices()
and arm_smmu_write_ctx_desc().  The other path would still warn.

Actually, I think even after you patch there is still a warning...  To
be honest, I don't normally stress about false positivives.  I report
all new warnings and everything that doesn't get fixed is a false
positive.  If this false posotive becomes an issue then I can spend time
on it at that point.

> After my series we have things like this:
> 
> 		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
> 		if (WARN_ON(!cdptr))
> 			continue;
> 
> Which indicates the paths that expect to have been pre-allocated. We
> could also have a no_alloc parameter to really make the checker happy?

I don't think so, although I could write a custom function to handle
that parameter.

You're talking about relationships between variables.  If a is foo that
means b is bar.  And there are tons and tons of possible relationships
and it's difficult to know which relationships matter.  Inside a
function Smatch tries to track everything and then at the function
boundary almost all the relationship information is lost.

regards,
dan carpenter
