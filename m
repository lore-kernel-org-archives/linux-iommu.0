Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E630F92E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004802; cv=none; b=iY4fM+sBEP5KoEqYeHfdNwjoYRJIOOhE+wAOUdmc2iX0//q3cJZdeVnheS7VKR4hiZkBSySgitk9ukODYqFipBYT8gGj9MAp7mB4Uvjwp8GsC4BXL1UXjfgX9cW2KiGfAuIAJZtm+QPH7DuA1oUnVIhPNWIBdboxiwc7qLFFQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004802; c=relaxed/simple;
	bh=mDK46C5I3PwQkCMBLU3lLBAf/tuVaSY75zRZgypGQpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOpDHn6uPgioLG+ndEeyn6h/hY1uO+sfKtznUrEn03iprM5KVukeJ4/We5//ihQ1bXJjGRyz+HsPEK2roYO4lYLC6MaZzD8esqmPS1eItkNtF0iaTdk9gbgTNGY1xH+eC4vGwsYOBRbgYdZXUdDQtG/CIEG2P1UBzutW2bVSL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYoKfsVr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYoKfsVr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso615ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780004800; x=1780609600; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=koV0ihSYfTL2npSJwGSG73dkvB4FHzU70amYo7Uj8bs=;
        b=nYoKfsVrYqA9m4Rc6bOSHf6QmHZFQVQiE8rveTKVgcdJKyKu5yl5OaKLVjhmz6H2VX
         DavBnKIMXTsJMrAY5Vbwc0DGZJLAWxH6I6/z3fOQ5bozrVkrS6TE1pxVIH3PlY3miU+y
         ijRJM4s6pg8eeiork2v3PnFrEDCJ7cHSF2Xep4qpQ3apx13AFfJP9yGUX2a4PStVH/9m
         tSLJJo6nJBl6OIRXaa1NucqHF6c22GUYPHyw0DXGUElsvyuwgp3xgVajLMRGF9i+W0s2
         FrD9Mm+H5QbcGIxi9mPzj5uhXHhqpF+ykNaqoVjEcBlVTlB61TpwLZ7UsP4Gfz4Tu+/7
         qBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004800; x=1780609600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koV0ihSYfTL2npSJwGSG73dkvB4FHzU70amYo7Uj8bs=;
        b=lii3uIaDJFCIxCfftktr+668rUdWJ9tjNmQfzswQwWl08uhHtYYuNQCQ3plvs2eriU
         xvv2x0QQ9rHPRLcZGTz2fxxVn7J4CwAGRdL0CEX8JWDtB1CRbD14AVdr7Ne1Pkw3lrCQ
         u3uPebLFbSfzdk78g29EDr6Z0qhMn99ywQOUQcWN7xA/namKSiu2VOZu6ligEhgARXiK
         qU5240pqEK4j6bSl0/UShZkrV4WcrkkGtx9WcROES0lnN7gHaZDDz/oK6yWN62fiV+hB
         K0+zR4yYiXtvzmy4awTutABHaZTbbMutXyJjI6uRHSbX5kdv+PWg4TMfE/a7/zWHdsFx
         3g8g==
X-Gm-Message-State: AOJu0YyhyetbM7ydtc4re5tp8Q2DAW1R8Rn1MSh+yAIojAM9UUxgVOxx
	Y1CXY1Sl2bHYv0+h3V2koPB/MKTmEwrGa5jiMuvA9wBvifCmFdfRpX8cPFkZnwnglA==
X-Gm-Gg: Acq92OGRkH5D0f84AJYpPka6QxmRfNLzyfcOrddrGLL7jZ6IKnWafx3onCQFrYU8RpU
	OynWd1Txck4KKcxPM7qcslMBUJiDudGcvcKHLE9iqg19bjGGZ0YABWEQFTE+qYvWo4/gph89Pfz
	939Cnqzb90hgnts2Zh24RoBSsjxu5FiFTH86WsKB2Rxgw77fZOM/41UlhP431wQdLRPZCkefzXm
	38znMZfwdeevIsLWOS/B+bRKLEgM9Qf0WvfLxuVRSztNq5a5wvRS13eQX0p0EHhn88IEQHDQNVh
	FauN7HNIizKpG14+nvF8NFZnmxbOem+pVq1paHDXT7bvtDm7v/UTNA+O1D+fVoOKegsysPTeDvo
	g+5XVUSdOIzfFoaWioBxZdU7JuR5+sGGpEpOXNfHuyYMVGLqFj3oYXGjUTZ+XExjhZ6IU0v1x+D
	Tc/QaAyjK+6kSOWeGWOEeuaIc+qPbmE1W9FWuG9gRpgxtxAQgM6FgVLLxT1Upkd6ltzlOi
X-Received: by 2002:a17:903:3d06:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bf20d40768mr208615ad.17.1780004799794;
        Thu, 28 May 2026 14:46:39 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8575db0c37sm2454a12.31.2026.05.28.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:46:39 -0700 (PDT)
Date: Thu, 28 May 2026 21:46:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahi3uY9YZZtR1Lq5@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahilX8Za1NRCH3ik@Asurada-Nvidia>

On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > TLB and CFG invalidations are
> > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > the arm_smmu_can_elide() helper.
> 
> All the arm_smmu_can_elide() call sites here would eventually elide
> the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?

While issue_cmdlist() would eventually elide these commands, the 
can_elide() check is necessary to return early during suspension. 

This avoids unnecessary stack allocation, cmd building, and spinlock
contention on the cmdq->lock for threads that are anyway about to be 
elided. 

By dropping these requests immediately, we significantly reduce cacheline
bouncing and contention during unmap storms. Furthermore, the early check
also allows us to specifically trigger the WARN_ON_ONCE() for broken
devlinks.

Thanks,
Praan
