Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2421219F
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989997; cv=none; b=LcZrVXBqfgTll23/5vSGYidJ+fIASZe0U+NdVxfEkXBjkwU4l20kRkuZ7PGyKjAFGp1a86mbcrV8mfjVCYU6jx/lmFHCxLgeJgfI9q3sKSfWc7/qYWwvDqqXoW8nCqwiGWWrvgdbsSusAQBciy2EbNTxLrWSH1NmunLTXJ/eMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989997; c=relaxed/simple;
	bh=RlQhDO3A3auk/wf/IjuOvwaDuJJ+cY79fntWS45tsOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFPZH9csnNzL3vllMVBbIJIyN6RYQ6e7NyzKNby1uPGDVcHoEKzmYbZLbkMdjvBUULlYueD4kzCbFlS3Nn1XHfkqjUT/TCdkbVsN8m3WSIaK/sF56UW9pGmsn3BNTQj55LX0Yin4OEI7paBrklXX3+7ynGC8yGVP4hvGaH/Pj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yWc7vj2/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yWc7vj2/"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso243735ab.0
        for <iommu@lists.linux.dev>; Thu, 07 Nov 2024 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730989995; x=1731594795; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xrC35+dPTONwxeIJAnI/GjqFOojtHsaVXwn/8nzoDM=;
        b=yWc7vj2/kmTkwSID42HZSXXAdXNCoPeFsNAXJQk9n+MVcS9oYjcJQsEd9MAuxLfLYe
         Iee0cIlnsszN6pC1ej3YgMlmJiZ/FTv6Yvs+lTC+zIZj7BCMx46MfFnefp1hHVTdiCMB
         SHY6PmeJESN1X3Nxf/qIdVt5gPFcNydkiDlfj0EOuL82Dwh3ascPQR+kICq04FGRZedA
         7BXTXHwFDBZhSh5R3VIC7enBAIoAq3KqYn1r+Prm7rtC8wJ6ZVG7NFngyRoyqJMOYS0e
         N0i1JlRxd9ctJWvBFXb5pkQr4c3ZMXoWX8QQcbD3eax/Zka8o4K1H5/kAIYGjig4Q4n2
         XAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989995; x=1731594795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xrC35+dPTONwxeIJAnI/GjqFOojtHsaVXwn/8nzoDM=;
        b=tBBUS9fS6ypvQ9M9UeahF8/WRfFZefqrh8m8+5JUCaIE+WrVZeiOVB+UV7HmKCU8A5
         ltiPbDwgHebD4ACG80nvw2SUC13umD/H9tGgmG+dTCcKdha8rhnDZFOzHRK2ZCbITRcB
         nwJ28RswUb7km/CMDMbLipdOijGFzJLprSfRLmQJD1Rjog/U0u/3Uj57gvYBaZ9CBYFy
         GXvJmZQ3mxR1q8HfOgtYAzS9TUJHbHXlBRJ1FNgwOOllYmkLQr8raQzga8/2FrqXQh92
         qdDvY4eW/X5bw0DhM1aRtknjBy/vl0GKy3ZnUV8vdde+5TPpGuY4EBsYOOzPxHcMQXb6
         kXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/tUgAib2GrrJ1ZTXvKLjDo1jhLk+bMWRr0fR08r6DMymgPe6ulwlwPd8pyjKuJ5A8XNI9lg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZLC+5YjB3UMj04ExG0DyzbYNwZF2oyK0/X34daMJtWUJRND5L
	rSFdHOENi2s8SERvVEUIz0NLDJZvSy61oq9hYjuuPxe/Et26N0yJMDlH3SHpEQ==
X-Gm-Gg: ASbGnctg7lHnTb418t1XiRjMFB3Yw05yRFVs9qWh0s4z961LgvZ8RWw+V8+9WSC5hgh
	s73Vyp7Gx7cgTQXfRLrrdRk+56eXMbexjKc7p5yEBMKuF4PMTbbBe7E5ZyjVYml1PHxGREQfImf
	Y675U4vfLvhqmZxTq37Qh4UULqo5hLVhzuCRtcLMmKmdWw9SCSeDoy/oUd574rW0CXKm1/mOU2G
	BFpTTbfvMXK28/suHFx+01BlSpUemSnz1V0TDMal+0Qpq2wVLG7k3585pWCNmCgUsPgWJxRY9Vh
	pQhhH5ZrBZ8=
X-Google-Smtp-Source: AGHT+IHP6hZbsSJIz/2Cj7JCXhqtQYzFssFqQvCUhY93Dnmzbzgh4Aa7xiXNxqOjsJmVMcea+343fw==
X-Received: by 2002:a92:c24f:0:b0:3a0:a233:caf8 with SMTP id e9e14a558f8ab-3a6e7a6e097mr4516385ab.26.1730989995053;
        Thu, 07 Nov 2024 06:33:15 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f6cacsm3574856a91.10.2024.11.07.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:33:14 -0800 (PST)
Date: Thu, 7 Nov 2024 14:33:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZyzPogS9yxgE6jSH@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com>
 <ZyTu6tNO8gaSqKSy@google.com>
 <CAE2F3rCWV76hfU06SCZoA3HW90YBQZVcXaDD0P-beDtTaJhKGA@mail.gmail.com>
 <ZyiGa0sC1MfCu17r@google.com>
 <CAE2F3rCVJgM8q2_k66UkQQf8UpouMdPaEd6V6Lj_O_gM+_ti6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCVJgM8q2_k66UkQQf8UpouMdPaEd6V6Lj_O_gM+_ti6g@mail.gmail.com>

On Wed, Nov 06, 2024 at 04:10:01PM -0800, Daniel Mentz wrote:
> On Mon, Nov 4, 2024 at 12:31 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Sun, Nov 03, 2024 at 09:25:52PM -0800, Daniel Mentz wrote:
> > > > > >   #define EVT_ID_TRANSLATION_FAULT  0x10
> > > > > >   #define EVT_ID_ADDR_SIZE_FAULT            0x11
> > > > > >   #define EVT_ID_ACCESS_FAULT               0x12
> > > > > > @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> > > > > >   #define EVTQ_1_RnW                        (1UL << 35)
> > > > > >   #define EVTQ_1_S2                 (1UL << 39)
> > > > > >   #define EVTQ_1_CLASS                      GENMASK_ULL(41, 40)
> > > > > > +#define EVTQ_1_CLASS_TT                    0x1
> > >
> > > Remove this if it's not used anywhere.
> > >
> >
> > We're using it in `arm_smmu_get_event_from_raw` function for TTRnW:
> >
> > +       if (event->id == EVT_ID_PERMISSION_FAULT)
> > +               event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> >
> 
> The #define for EVTQ_1_CLASS_TT should be added in your second patch
> with title "iommu/arm-smmu-v3: Log better event records" where it's
> used for the first time.

Ahh, yes! Apologies. Will move it to the right patch.

Thanks,
Praan
