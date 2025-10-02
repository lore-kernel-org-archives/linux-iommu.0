Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDB30AD08
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406239; cv=none; b=q6IqZd+2xyFhwJzoOpQE3HKOCSJhhbQjkKF9QN1dau+9KQIYnm9mqFh7mpUS53CvWrRMl7JOlgKYNaBYFg3FyYKgc7xEXOMeGFhX46oHKme8aj3r2Y+3KKHxC3mVmL62RkLjuQIPh/1zwff/3/gGAXNU88tuHogdySrfiTEH/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406239; c=relaxed/simple;
	bh=hzlW48U3p27HalC0zjHa19nIsygs8guIlr4gM2QtnRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw9b/LAfQ06kLXuuz+gBdHc2W05Cp6N+d8Pyihey4V5BuIYOp93O1i3pU8QSClbSyTObxPPFIZcD6dS4pf55drnT7gbMyEK74Nu/2c8GresmXLeiEXw4bVm6gMoCtN9kSSr+xuevVAyDL3jwz0AsrTtw3C8T0xQ4NMlPRHJ+lPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uscqn7Wi; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uscqn7Wi"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43fac2df7d4so442089b6e.3
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759406235; x=1760011035; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lypYEd3l4ejDslQUD2xntmHuywWs1a99Jd+mtc30NnI=;
        b=Uscqn7WizG2mzyrHyQXAOeejP1GUNChQJBUF3ZLe2sIdnLK8DNhzRKV7z3QpZ7iDF7
         pvuSKFhN5+O6xRSoawlOfa1PZEZEV8lsPv+ejObHjbOWbEgpY/gvrw7jcu5aPLqRB0gO
         nfZIedK7LgHV9APzXrEmogXz5L75kKmgIhcED2VWkvL21ngvj53Dfj/m/gWE4gNtDA52
         C8+D7x7bMOhJQPyh/MubYF9Jvx6/nU6txv1Bn6SietFoqhcMKNMeYLkajfAVgd/c5FoS
         Q0ZdWYzpvUu6QMa1Bmhna+faBw/viHv+5rR5SwOyu6v5s+Mevb+f6BR6VO9jcP5svUD/
         svww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759406235; x=1760011035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lypYEd3l4ejDslQUD2xntmHuywWs1a99Jd+mtc30NnI=;
        b=MRT88saeSwJC3YFpencQiqd+ycXaCAu0aecqEUYZI2RAx73k0sqYU5EZDet42FdD44
         9yj3ManCFuzPjFmat9s7Uh9doib/1d14emvcYLhQgxMSMaNmokiFcaOGJVrt+kgsAP6g
         WnJCLwuzuJe6J4IGSOO+ykm7yyEgqP7bIjpJa011Pd4c7p/o3hnrmm6u1aLT2ojgFD2T
         2thxg6C8WDOlqJf6/63cB0qaKJbE8B9Rz7g86VrgslEumJEuRDwMmMFowu9kW8tmZUFK
         AeueYhjgO7qM7knYi8WAbhRatA31ghyEd0QJyBfgXG32d6Aj3G8zGvmIxCrozT+V4+14
         sBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3WqOU1E+ZuIxDH4XfETwJOa/IfC0kIbvCwHyUHS3vZhbO6uAT4+fSxgkqqwEmFlk8ZwQl0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1YDEZZ0wN7VelJiqfMXWqnAFWq30YnxBcZX94RFIUeIWKJRYd
	CjuFe+QQBt7iIHFEayBdgvYyxLP/rRQ3yH/P9NPTSoS3O6WI9lGnLgF63KG9MNAe5j8=
X-Gm-Gg: ASbGnct5Ebcn5x014kzpLzyY7XHAp2tJdZduGFGbpu8IAl4mnoGVbRpenEA/nA0SBMh
	GTyo4wOrIjNl1YsBF45d0UVEwLTHSqasdYy0LRCmLH8BBdcnhHONeftxRW9yLA3SgIJllew79gf
	Box8Vn83rkttBiNCEwYRg1xqQJydjFRsqfxWrp6is1yfboaYfq3rnVSXKkTo4jXuoRcFQTQX7xB
	zYSd2FzvTQ+O8Dtvbrffi/UBfHmgcFspLPP0mXkw53gHEpYn8KTPLHKfO8Juu1C+/DuKbXFCai5
	JwOujkDJNTaQif+f7ZSg8w26wsjbdq1E1DtEhbIpADCHW7LWweOH/GWd/fH+CXe7I7yqMHdk2bX
	Z3+5REarznlpDFAVr1zPl
X-Google-Smtp-Source: AGHT+IE1srVbckOdMIlenVgAWZmXaZ17xCibMpNXp1sus8P4KPWibOXVJIJ+3ZlJ9dMn/d1vo7M2dA==
X-Received: by 2002:a05:6808:4f29:b0:43b:91b7:cc2d with SMTP id 5614622812f47-43fa40d79aamr2956448b6e.18.1759406235399;
        Thu, 02 Oct 2025 04:57:15 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-64e1b7a8842sm423034eaf.12.2025.10.02.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Hvs-0000000Dh2T-2nRE;
	Thu, 02 Oct 2025 08:57:12 -0300
Date: Thu, 2 Oct 2025 08:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002115712.GA3195829@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>

On Wed, Oct 01, 2025 at 03:28:56PM -0400, Pasha Tatashin wrote:
> > > 3. On FINISH, the IOMMU core updates the context entries of preserved
> > > devices to point to the new domain.
> >
> > No, finish should never do anything on the restore path, IMHO. User
> > should directly attach the newly created HWPT when it is ready.
> 
> But, finish is our indicator that a particular session (VM) is out of
> blackout, and now we are free to do slow things, such as
> re-allocating/recreating page tables. Why start it before a VM is out
> of blackout?

Things should be paired.. The suspend side is

 start luo - "brown out" - kernel does basically nothing as the luo is empty
 add all sorts of things to sessions
 finish - kernel does last minute things

While the resume is the symmetric opposite:

 kexec boot - kernel restores the critical stuff it needs to boot to
               userspace
 userspace does all sorts of stuff and gets things out of the sessions
 finish - luo should be empty now as everything was taken out by
          userspace

I think when things come out of luo they should be fully operational
immediately.

Finish on resume shouldn't indicate anything specific beyond the luo
should be empty and everything should have been restored. It isn't
like finish on pre-kexec.

Userspace decides how it sequences things and what steps it takes
before ending blackout and resuming the VM.

Jason
