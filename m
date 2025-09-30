Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CA23AB8A
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249876; cv=none; b=fv+doRChC/uR3zlpXJLzeltbx61SZZQkuFqR2JX5nSvcIbQ/85ewCR8N7+gnwZGCpcaxBqKDF2mkLwwdG8qOTPvUhZ3sGjJbNyrDhIM6Xp73iihuQ4KQIqCVczAfI8/+0jsZ9i9LUJY+ZSZVqb1wi95Rsw5GXnpLBTKGS+Be+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249876; c=relaxed/simple;
	bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9WRgptWz4rt4gQLmUOi9kAEsd02Y47j6xKBatueFcWMwbo0WhC11iaZIUm5Gkiq6P6DRd5ON/gy1ie+HyBFd2SlSvb0s2a9WXpRdxK4GHDAi9dqxq+BegTBO0VnYxEwJYFIRRrPd32tVI8IOxCMKIKD/y/4kSqveS/DMQ2OTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D8E9Gvgh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D8E9Gvgh"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8275237837fso694092985a.2
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759249874; x=1759854674; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
        b=D8E9GvghIFFOvw69bVCTK/osvueg3c92lEx7X0+6p4HzEt0nnafa9S5ZdlIuLr0lh+
         SFoV1k0sim+HtQqTCd1ImAUIYIJ/WcHXfok6tE6oFmOP+0AMZ3k1rhX8WOx46ywl2XUL
         Ic5H3jhRQQqyhRKODu2MkIQ5NA1wxC4rkpeNFDY7Z1HZcL7IefN+EueACG1TpTB9fF87
         dPvaaDo9iqMeUxqREggi+EKQ5UyGB08am9tpmTR4JF9x9GmzwugoicfpmgXwWDV3RH5n
         UVzQZe+p39DZpINtjegmDIPcCv3IWeuX/JC0H1gV9He0nPd+AUJrpCvPb8YreVBrj9CP
         KJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759249874; x=1759854674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
        b=rBhaRDac5MwWgzGp202NwzVf9gV124MzoQHgekg7zsgRZbWSp6FnOe4srrzmKIVWPM
         QNuTJZVwFyuvebZZE/COUHqm+ziat75Ff+57ZajAHnCskVq3nxXeYRVQK1Ns7tsMcB+c
         t5TPLwBL4gPhmUt/eoo9EcwAQDN3Hkv5GbgHvo+XzSpThb/ShXWo2MxS+VIxlbz/f9sc
         hvJDYuU06Fxr2rH0L49B7RqV2WROXd0abyFeTnihVYMvk2SHsZX0PDcKGBzteSGa4IRf
         9sRIX27/WtnJZqsLhwGYOInTtTEAaSejgvAimJaCXapx64Qt8iqtGMyXduMIQxQcT5ce
         0Lbw==
X-Forwarded-Encrypted: i=1; AJvYcCUTGTcjmvIFvzCJX4xPUyZVbAZYMUVsObMuLKMe3Sb6/ij07nxP0+f8mXV7dkLqYuOyl7dk/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7gJrsSmFIRvfKpcaAxN3sL5pJCcRQPxz+EW55QD53z6ok6pbi
	7fIHdfkyEDPaag7vGkBuz4VupWi4ZxxEV85Mo0fQ9ziVh7ryttrrxrkHxBNPxY91Tyw=
X-Gm-Gg: ASbGncvpVSZN34O8Zi4yNxqy+TSixJ5mTIRSrHxbo6C2SYnl6lLAMilIYj54391jXDq
	nYJE5ov0k5MoKjJEdENF/byZg2XJtN0pQm+shZK8ECztdHyH69iIET//lwLvij1Q8KiKyU8OUnQ
	yslIp7+C6EcruGM8Y0K5RSuim9bke/tz1myaCoOWbgDIS2XE0TNwN7o4N8yXygscwwmJCFoDdxo
	h5UiYLjm3FznFS7UIwyeW/fig+6F5MjLfevU69gQ9Bt5endKJp7czJ8PIlZXsrAGTTnaAWkVC+E
	0emLup98YQIFjhIiuN6mv1/MONvyE6se4atFMQ8BnsiGIFpB1y7a3OMdqVUgB+Wdax4i4uK+VR6
	9jkDXT0ZNamtcfZ/AYMQDByR/AOYjodw=
X-Google-Smtp-Source: AGHT+IH3hKfQMkGyBhWJplHqI/wO+SMQBBmIDfXW13DSmBhYOOBjbfVAPIN5KYq98JehJB0mqC4QEw==
X-Received: by 2002:a05:620a:178c:b0:849:2a77:5612 with SMTP id af79cd13be357-8737021aba9mr61213585a.17.1759249873639;
        Tue, 30 Sep 2025 09:31:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c27564344sm1068086185a.10.2025.09.30.09.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:31:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dFv-0000000Cbak-3AGw;
	Tue, 30 Sep 2025 13:31:11 -0300
Date: Tue, 30 Sep 2025 13:31:11 -0300
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
Message-ID: <20250930163111.GO2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>

On Tue, Sep 30, 2025 at 11:09:59AM -0400, Pasha Tatashin wrote:
>
> The way LUOv4 is implemented, "LUO sessions" are always participating
> LU. Once a user adds file descriptors to a session, that session and
> its contents are automatically carried across multiple consecutive
> live updates. The user only needs to act if they explicitly want to
> remove an FD and opt-out of preservation, or close session. This is
> consistent and convenient for long-running VM that should survive by
> default.

I don't think this is a good idea. Each kernel should decide on its
own what and how things get included and manage the labels, from
scratch.

If you do this then alot more stuff becomes ABI and I think it will
turn into a huge PITA.

The userspace already has to have the code to setup the luo if it is
on a clean reboot - what is the point of not running that every time?

Jason
