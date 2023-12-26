Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DD4F885
	for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cvqBdOMS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42791adefa8so35506881cf.1
        for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703610912; x=1704215712; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znBescOeGDyEd/eBwZlWM7zCSH3WtYT9hTuxQY/0ciQ=;
        b=cvqBdOMS1Wr32wu95b58kMsJIZQD05fteQdkTJhKioS1VZ1JKp2KAkRP3Qs4/kbG1e
         xpqboHkCNCtJOKnabsbbqPEKUIOfru+Evjwz7P9UhAA8WljV9DPSWrdepIaBzwaC7HK1
         2B4LRjztR2EC4N5Y9jXghZWZUeM+HOVi8mLiuP7vTcjyRrjfRh1e5kUtU/fPPdfoGHZo
         jwJ1y+nsYw8tHJ+WmCrmx72NbudUuNE97pBd+bCBjDnm4Ew29qfGx7BZvoFQQkIVmDqg
         04HobwVq1OLs8bRM7nU/9YZrjqLL0bFcV0Zv3UhZ8vPPxDraJzlzwtFEUG2eWtEjm7+2
         Zehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703610912; x=1704215712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znBescOeGDyEd/eBwZlWM7zCSH3WtYT9hTuxQY/0ciQ=;
        b=NQYmxJTq50SNliTcb+ettnFro2hfs77dMiAME0M/Uxrjnslg/sBaSEYjkseJ2PPGBU
         GxtX6Fk5mK2eKPpNLWlHv/kuBmEsR42lHOR+L9s0cangO+07buCtD9h3Thue9pk1fbIj
         LDWNmGjg7jnA/vnch7/l50LoWXv6RPwsEkTHcXGe6BAzXlq0SfCPINIuix7FAirRfhay
         B6OjXmED0nnHIqqr0FvslDoSW03myRruzcSJZUtRWlg/pqu3M4sXVFOnwEQhWDsKBMYC
         XOeuzm4/GD84Sr2yvpWAtBbFsbUveHg45oaX1WjfQN7DPrn3KwLFAz3qfgApOG5/osM7
         yEPw==
X-Gm-Message-State: AOJu0YwwbXkqRlewU5lBtIgQBqbvuOO01ly5RWL9/2IOZtn8ZnyAtpUR
	sD9/eTAL3y6U/R8vjgiD5ZgZ23VP1AmzyBmyzOAiQ6p0CyIh4w==
X-Google-Smtp-Source: AGHT+IHyQ5pm+vKsp8dlt+xdHnTW6C3uPhOZpDSwoY++VClJ/nDwEbMxRN02tbeUhgBwD4pSJVi4TOSqszJhqwYmmj4=
X-Received: by 2002:ac8:5bc2:0:b0:425:a28f:ddd8 with SMTP id
 b2-20020ac85bc2000000b00425a28fddd8mr8563250qtb.137.1703610912560; Tue, 26
 Dec 2023 09:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com> <0ba8e579-2b6f-4e9f-a38c-097694f14d3c@intel.com>
In-Reply-To: <0ba8e579-2b6f-4e9f-a38c-097694f14d3c@intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 12:14:35 -0500
Message-ID: <CA+CK2bBGHv3f2AM999C5zoo018yzFdQpygUaPn0AVoJ7cX+Sbg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page allocations
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, 
	m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> >> Document the locking requirements for this?
> >
> > Thank you for the review. I will add info about locking requirements,
> > in fact they are very relaxed.
> >
> > These pages are added to the list by unmaps or remaps operation in
> > Intel IOMMU implementation. These calls assume that whoever is doing
> > those operations has exclusive access to the VA range in the page
> > table of that operation. The pages in this freelist only belong to the
> > former page-tables from the IOVA range for those operations.
>
> These pages maybe be accessed concurrently by thread contexts other than
> the IOMMU driver (such as debugfs).

Good point regarding debugfs. While, it does not change any locking
assumptions, for this series. It might change some design decisions
that we need to make when freeing pages on unmaps (a separate RFC
series that I sent). I will have to study how debugfs affect refcnt
and mapcount, and whether we could use per-page page table locking if
needed.

Thanks,
Pasha
