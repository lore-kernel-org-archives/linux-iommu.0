Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CA385CD3
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979967; cv=none; b=aobOJEATNCzU5Qqf6rSs66iXXzCjGL42SbKp1jL3QHnNyYQHk6ePoX3AizxTF0uKRfGzxQlhlfk1kmMW/V68cyNtOr5W9RY2rX95CgK0N9eGSJX1CEFNdpmFdTUrztnU6liGGXBdT1F+CdS7kooEeTy+GhZsRk6zXtOzRnewoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979967; c=relaxed/simple;
	bh=BpihFFLfYFP7NquDRCAtsdSMpFO21CfRjAdn8MUNOXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBR39ruRyS+Vha1USAlmbiuXBLvCEiJsAD1zNPKMnL7cDIL2Zx3YWfkseMSwvXHAA5gLuMPmNR9aPa7XeOsXPvZOl+L0EHmnRPN4WrZuD7JQcvm8EY9C8RCOMmu2+T2Yainw12Uu1X2x0IU7McFO96BvNu9gVkpv5lsxBtyr654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DheoynTu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DheoynTu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2ed01b95dso594346985a.0
        for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765979964; x=1766584764; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNTY0Sqhk7+o+eguXb21G06qwMJTDsQYPt8jfcBPUac=;
        b=DheoynTujK3c3QV/xF4tLEdv9rwVlLWDELQeAoNDyvxpUeXf0dpudOmTBXUgRbBv6P
         zlHIjGpMnpYhpRddIQ+RB/1pUE494aXQ1rRLoVlO1BSVz5empR3cfXmrigKLK666MzaA
         yA2dfjG785uG5rgq8gniP0UtglUPZpcXEw7MpYaSWnt/K2Dx0d7mhgce88jxCKLjxqNr
         wUbq8su7KDA8dXtEN5NJ0VmPPRY+gS1ZdpxCZcVp3N92VcN4Tti69xRrCDxg4zwh7fQo
         EGzIz1W8jax2KxeTf8QDSFONhLLF3snbycUfCslikpRjAbgqrZTEnRjGRVSB/8a3i728
         b0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979964; x=1766584764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNTY0Sqhk7+o+eguXb21G06qwMJTDsQYPt8jfcBPUac=;
        b=d12XMIZ+1YjtxATGGNkiNmWnG/O82YSp8bS23ChmxFx48rlP2xCXUSa3rG2MENwak6
         M0CWsgiLXtsmwigerRGQeAjH4iPLWBVH9VVdU9hpWSwa2btmgNlIIL49oc/dtHasrqLv
         Mb+ox77cNV32ptGbwCEVNGwPgOkesR7Sml1nn2j509jcZcCQOVY4S7tIR2mbysBNuXoS
         ybIQwS1fpG1RHbnEFv8OFezvlobe6wGQw79tBfPc/wwQnLVx+Xykj0WWYPSsxrARpzai
         Q1X+6LVgEr1hm1k/huj3JpgFrxSnTxT1CucJkliUAMEXhEGoHxwHNMO4tRO9Rq1rJ96O
         7SOw==
X-Forwarded-Encrypted: i=1; AJvYcCXTLq6V9bMt0Egw65gcGjxPbDBcTQkopqb3AXTxxTSyr8zxbyw6edZsOgAvoqnKCQSG3HCKpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxexNL6IDpRClyarwXEpWjr9ztxrGcx0ZeF2LTyGhOViWpEYTTI
	9+0OoQlQuHvp9s8Nd5EbvFksAQrAKxgTQpdL8shIyKfVn5fOkaXsTi5n5sMwVTC/U+I=
X-Gm-Gg: AY/fxX7TjzPAUV/WJonfoNhHx9s8f9jkEdhssBC6kBXExmGL3CVIfUIMjcnzjQPCSA2
	Qq2g++Z4YHbPrHuJE4bxA4XhLn2l4vQORVT689Ar0B+wYQPGM0kOag7wEsoTMaZzAUMKvRxznSt
	lvYjFfXwXnkac07zCA1mcJLwtpFfvDyQyJ6MC17D6KQbw0N+EPUg1hSHbofw5W93Foi97Kp+OA3
	n4/hnv2vpKMfxv/iCKSmpCAJPFxB8cTNwxHvIfvhqBCpCp8zztqTHTncNAl6Jwu3m1MBK/8w6Lq
	KmfAgJ8eYI0jLsTP+Lp3KLTmDKtCwF0+qC3goFxRJBppr2+xDtbfD/Svdvo+eUPZ3sK91Mwqe9r
	ORNqF3JcENmrMSz8OXaTY4mHdnWLyXZfquEUqPbcZKfh7mrlP7YTUtaxwOB7tVPcVRkfJBc16rl
	mkUXv150Nv5ziySCpIrcc3H8zJjyYIW6e7U2FWbsART1wCNkdwnW1I8QDWkYoKrmIWZk4=
X-Google-Smtp-Source: AGHT+IExCGpmH3xSn76tDpf9mlwCNxEI0+dX+XnOw8fqnvLy+nODc5UF85vOKaQi2smq9F8P/d+5hQ==
X-Received: by 2002:a05:620a:7108:b0:883:9b33:f6b6 with SMTP id af79cd13be357-8bb3a39bb23mr2288717785a.84.1765979964213;
        Wed, 17 Dec 2025 05:59:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b559cdsm418416585a.30.2025.12.17.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:59:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVs3m-00000000fU1-385b;
	Wed, 17 Dec 2025 09:59:22 -0400
Date: Wed, 17 Dec 2025 09:59:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 07/27] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <20251217135922.GE31492@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-8-smostafa@google.com>
 <20251128164816.GC812105@ziepe.ca>
 <aTw31-mh8z81yi4Y@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTw31-mh8z81yi4Y@google.com>

On Fri, Dec 12, 2025 at 03:42:15PM +0000, Mostafa Saleh wrote:
> On Fri, Nov 28, 2025 at 12:48:16PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 17, 2025 at 06:47:54PM +0000, Mostafa Saleh wrote:
> > > Move parsing of IDRs to functions so that it can be re-used
> > > from the hypervisor.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 112 +++-----------------
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 111 +++++++++++++++++++
> > >  2 files changed, 126 insertions(+), 97 deletions(-)
> > 
> > I don't see that this slow path stuff needs to be inlined?
> > 
> > +10 to my prior remark to not dump all the huge inlines in the main
> > header.
> 
> They are inline as they are defined in the header file, otherwise they
> get defined multiple times.

Put them in a shared C file

Jason
