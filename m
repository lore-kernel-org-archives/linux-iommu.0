Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CBAD2C
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298271; cv=none; b=PaVoZ3dg+fRMnfPtDdrKVZ5Fc4wb0yi/11rsWiVUkhJuMdLR396OQE0xapYvox9CKkVJkpCScMjcItjQakUXuJ1LKJeyqvv2sbmPqM6NKkBVhlERtcTeWZpKB2O8MMiW6hXesOqiCchWnBWNqF0O1bpUM8kS5wl8fOWQEttlyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298271; c=relaxed/simple;
	bh=7fOREhmgPGHni1gljSJExDQiVXEWe4TOmHfhELJedlU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gag8I4auu74aGfLfpUwg826Uqurjkto0/AuPfVUgen+fbGdjR+todePQ+B2REKBM9ZAMKGeitAP8LX5cjmnsmvNr2v5XTCo4oLmlEst4M+rJ92KcmLsSrKoxei6SyEnzNZizzi5A42U96qa+yvAAGh28m26tAg9Nrno3BuCbkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZPeVfzP2; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZPeVfzP2"
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5C483F7C1
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 23:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762298260;
	bh=MieDiTn7THEoDLo56I7CJ2MsB1+PBRPE6P2QhMPLZHs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ZPeVfzP2T+thGdJGcDL6AgmWD4BsTEvodsrV2ts8gy2sNHdhoj0uNe802xwANkbnu
	 YHpP94D6aOOqoJs/jWkE5YYqv0Z2U4hEvHDEmmtweGa9yQCvnWLB7pZ0amSTjFxxA9
	 OC4XDjSBokRTvmD0XhbRSKObH4sOQA6ipCd1VDJQKlkEP+NVFhqWDNYQ5JZo4ryT1K
	 /i4IBZIQOBUvzgVmqOzae+vNd08XXp3tF3tVTVy6bu6Hrpax/SLI/rTyj4zKrOPsBq
	 IDWA8OJFwbGr6ED29WBS5zTHENaBzArD/Lx4cnFCoM3v4iSBuXvKWDy7fDuFemTCTm
	 m43kUIqbx/Av4njcUUG6+toW5r2i6vr412iI6o744g+lNHkFyeEhZKdyijp3la9+Ve
	 5l90UiQz5/MDeBBsTtAhxylt4twzr6PYPxg0EgkzBBzCQj8lYvx1tTb3qUhCBc4/fJ
	 npgua2sTHSyvk/dn5uj6Njyi3Ujker/cGYmYp6sFIcI2Qivfm3W/Hmkdu7S7Zt8zUi
	 jVxCdf3EKJboIaIFrmwKRGy9mx7oWDlzVYfmyWTh4HYCDJsM4+1jMcJreST+p1bsmS
	 Jpo77n7diT9md2YjxkWck2mR3IRZVu3p+8tKLHZWzloKPPUgfhAy2NhM7KvmHHoY0B
	 uFZSMUFpgR4tUh5RdTB0rTSY=
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5d5eb99cf08so14091445137.2
        for <iommu@lists.linux.dev>; Tue, 04 Nov 2025 15:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298260; x=1762903060;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MieDiTn7THEoDLo56I7CJ2MsB1+PBRPE6P2QhMPLZHs=;
        b=ds4Bz+7W+F6nLTcUBo/823SUvrtCGLFxPdpeKf4ab25MoBEpwXoSDTG7HtM+YILNiZ
         xGC3FRmMwYASsb79mnzC8C/6ChoqC1kdou0wScen9psuv2pEFv0WWR8hAOD5Y2U38jO6
         1uIGyKGOzULVzxpuYyRxZM6DKdfeUnyAfTISdCUSQo13HMkr9HlIko8+EzGRMvlJZcF1
         pKvNDE5LdfvotLArDLj3/Ns108UbCAJghfzYQotBEaBOzPzJbyeeP5DZXCqNXOZbYX6N
         RKH3SwF8uVSIvdf9DjX7cKGgUOwovt1kxYKFtyHUnuEtDgIvMqFmfQZSc2Bh7OpgZW/4
         h8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUofq4aOa+uRf3rmGVJGT8sDkmvFG2Eg66/QiCmWU1+zNhObNe0lL99c4tDMw+BAzcAlcnJrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK1yP8xWsOgQcXe0Umgu+iBliDq7sf38xUBoTxOAP6F+jRGlj0
	G2H24CQwQN/QG8JDpdfS1RlwEGzzzUldW78FhHfS8aJ3hdPGsl+EPDycwalLMEf2bU2zNnUAZ4x
	uXJj1SnvwawA3l5yIZiTI7gMaK03BDG6OmBCaxLGUp2wxM/6xzAZcWdySITIU7Ak6Ni/wkhMJqd
	0qIlttHTrNCcDwjLYtZvv+5DEksmoC1soAQVDLid6l0Us0ipI=
X-Gm-Gg: ASbGnctenX09R8oTo9xbmytgzKUIPzLnUtOYInquUYfYMIy7SI33Hs9eT/VCDRiv+Kl
	61X9ZLyBhQi8PUMEMKAn7r1SZlWoNCOWbpFNMKV0gaYqdoYOQKABLDXumATKI4Qzf9REzR3QW15
	Uz+UMhT6CYHjNfgJdPqfbatgVmfDIEVs3FxrQ4Pa6V+6tOUe1JNWPl/Aue9UMU+TMTj0o8loyqG
	YhFYMdFb5dXjr4b
X-Received: by 2002:a05:6102:cd4:b0:5db:f615:1821 with SMTP id ada2fe7eead31-5dd88eeef01mr457166137.10.1762298259789;
        Tue, 04 Nov 2025 15:17:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoHJV28+m0O+BSg3fXLgJ4lIxTta5GR6qyYEyZXdo/8e+k0QHarJS9aGAH8XnODBhuWUXhpivbkMok0TRUXPk=
X-Received: by 2002:a05:6102:cd4:b0:5db:f615:1821 with SMTP id
 ada2fe7eead31-5dd88eeef01mr457147137.10.1762298259304; Tue, 04 Nov 2025
 15:17:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 08:17:38 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 08:17:38 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1-v1-d3317b0ee398+50-iommu_pt_riscv_jgg@nvidia.com>
References: <1-v1-d3317b0ee398+50-iommu_pt_riscv_jgg@nvidia.com>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 5 Nov 2025 08:17:38 +0900
X-Gm-Features: AWmQ_bk2LB2NgRroD72443NwkSJ3-qzEbig-zU0asUuN_-pMFocKpMUHzSTaoCs
Message-ID: <CAJM55Z8SyipTBG8G2wU2euvJhzcjJDp4B8fjm2Djwoonz8xf-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] iommupt: Add the RISC-V page table format
To: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Cc: lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>, 
	patches@lists.linux.dev, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Quoting Jason Gunthorpe (2025-11-04 20:00:40)
> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
> index 96f8a6a7d60e10..10b8250659b98b 100644
> --- a/include/linux/generic_pt/common.h
> +++ b/include/linux/generic_pt/common.h
> @@ -151,6 +151,21 @@ enum {
>         PT_FEAT_AMDV1_FORCE_COHERENCE,
>  };
>
> +struct pt_riscv_32 {
> +       struct pt_common common;
> +};
> +
> +struct pt_riscv_64 {
> +       struct pt_common common;
> +};
> +
> +enum {
> +       /*
> +        * Support the 64k contiguous page size following the Svnapot extension.
> +        */
> +       PT_FEAT_RSICV_SVNAPOT_64K = PT_FEAT_FMT_START,

Is RSICV (not RISCV) on purpose?

/Emil
