Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65511F7076
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512097; cv=none; b=N8sElyTog1MdJMUR6t7iyWHybkUq3VJlb3moModTQx9SIwzGqump34T1Uz8EIXHes2D7FF7TXFIbYEc/0hAwlpy2+4sDBLzoNgWWIkfJskKralfSbsZDIKHEz2XdEgs/Jr5yooieUUfacfT96t2jLxAkjiyYc7noqTqvi+aUbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512097; c=relaxed/simple;
	bh=ijAlDtHRXcf+DsBSIvIy0rT4ohGmoawudrz/PXFpqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxQruL4SEnsbFxRAy6fic3QqyedtbbeSMBEQZp5g1c/m2MNVvwPxd+6KXZxAX/3lyJqJsCbBDMG6zxC0OnmeioxK4dMDqz2I/XFt46gsFYNXu8rOkGYroLr3u9xJwMwbRUvLumFXevgn5fudSWsEqxWU1C3CFAK2wRCn9557Mp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I8nQMd0Y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I8nQMd0Y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5675dec99so158918985a.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742512095; x=1743116895; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3Ji2KwOWzeE2CNnnyHXjPQLmYK9JZ5UH2C/frH3wYU=;
        b=I8nQMd0Yc2t3TM7Gg0C7Z+GTmT0qlMpd3Y9SamSeeDA/4kLzdrmqEdSk21M3DcVIhS
         03oIUsDehAIjSc7vcOwk3aObQumBl2osJshdPtSCTA0JxrpH1xLOc4GmWppvvGjgXyZF
         TjO5mvrrLxNDAv0PzW+9KNrYAS0em1AveJ4SvR2m2na11fq4sAb8M5RDhn0IyHPmNJcA
         NkIcxlHMjLtPB9VQ6xhEOQPRsUDwDtFa28VhGsOY3NTuMCB/XaAYtULaahU/Hhwdkcl5
         5oG1YySi9oI8BqF83Z9Lp4rAOp0YIOzYhPUgK327V7UBRqFPUVq/EnpxsqVObxxEfZ2b
         oOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512095; x=1743116895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3Ji2KwOWzeE2CNnnyHXjPQLmYK9JZ5UH2C/frH3wYU=;
        b=sJICKrgJWPagEmBZbGDbtuI6eSo0caDwrXEKDRTNwOKd/7z8ZGju0JLtaDs2MfU34s
         LmE59lvcltdtRngCSimls1r7Lp0Fle/cT8Opk4rYoc7AeHklwCAZDaxCKomWOEz9duJs
         p+fKs5sXOPqTen6pS3LQkY4qEeonGSBAHd8vp3oHfq1B1xt0cQkl4PVUeJf2IRon2f5l
         nStovZgZtQZkEZX1x1oSVaZbv5f3mFaECorAMnsUQqL3hDR2VYIRDJW4HM01fT6CVcPT
         rbtYJnqJfymArau+nEwPJEZ/RPnIhfDM+2/cL7fnpXNhhbUiioSPLfsPRQkZsn8XCmbW
         Rnkw==
X-Forwarded-Encrypted: i=1; AJvYcCU4n7soHJ43gHZKBJOAPJAgOiQAV2mek30KTsW6gdK93cMbdvo/MJSmkfSqtIBtpGLQMOagAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMhFSAUtNEAwSzaEIbca0ItiPkCt9XDg+HWCsjnVo0V8dryPce
	AY8AamVpYQw6wGtV2542oDNtwTSubBfAYSTl9W8ipbncPbwegqDiBKLgI0So5jM=
X-Gm-Gg: ASbGncvB4wHp+stS7B7Rx8JY1GR6r7lw5kJJp/+xegH1jYciWNktjoo5MH+PjeyF2iN
	gDxOov7Xa2vkFM18nuRuLBDj/6pMQTCFMH6pxeHU2yp+aw/nzsAPPzQ0Idy2Rwa8dIKn4z/gjAC
	IrvjCFPABgfy2sxiURjIzJBYRuKueiY0+s2wQa4DF1kFTZWzT3ACvbPi3VML6rnKmD2UrK15ajL
	Ci5Zg+EcAL1pRs2AXRHBB09wC93eVWXSkV1AL2lq0pWwzvxMnYC98baBO9hXj/QDvQKHloO/x1z
	fAUbb5BiKZSU54+fXzQyiJBVJv3CpE9+wBSoO143496VBbqkusEbeemGj/3Z9obVOe38KzH903W
	qB8sQy3thb5rlhPBOyzvwjCA=
X-Google-Smtp-Source: AGHT+IE1RS53PxLFB6eLgiNLwTXqfoun3k6xYT/3AZgGG6gRhPnmwdPiLO7qmGgoNRaUG0xOXVQhqQ==
X-Received: by 2002:a05:620a:1b83:b0:7c5:6299:3da with SMTP id af79cd13be357-7c5ba1e422bmr155468685a.39.1742512094750;
        Thu, 20 Mar 2025 16:08:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b3f97sm45108685a.13.2025.03.20.16.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:08:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvOzl-00000000x5F-1MHw;
	Thu, 20 Mar 2025 20:08:13 -0300
Date: Thu, 20 Mar 2025 20:08:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250320230813.GM126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yCCe1mRTr-4dTx@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yCCe1mRTr-4dTx@google.com>

On Thu, Mar 20, 2025 at 09:00:57PM +0000, Pranjal Shrivastava wrote:
> On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > > I don't see SVA and VFIO needing any special considerations, so it might
> > > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > > lifetime of things exposed to userspace.
> > 
> > Are you expecting that the VFIO driver, and whatever driver is
> > managing the SVA will keep the power turned on as necessary then?
> > 
> > VFIO is not going to work if the SMMU power goes off unexpectedly
> > while the VFIO FD is open.
> > 
> 
> In that case, why not hold a ref till the FD is closed? When all the
> refs are dropped, we can safely power it down?

I assume VFIO is already doing that?? It must be keeping the PCI
device powered up, doesn't that automatically keep the SMMU powered
too?


> > I suppose VFIO also can power off on-demand via userspace asking
> > it. In that case the VM would be co-operating.
> > 
> 
> I'm wondering if user-space / VMM would be willing to control runtime
> power at this point? Maybe we could have n VMMs vote when they need
> power and drop the votes later and we can simply rpm_get if votes > 0

Yeah, I imagine that is how it would have to work. 

> > viommu I think will only uses STE fields so it should be OK?
> > 
> 
> What about IOMMUFD stuff like the Get HW info IOCTL?

Isn't that all from SW caches?
 
> > SVA.. Is similar to VFIO, if the power goes off while the SVA is
> > working that is bad. The SVA requesting driver would have to manage
> > this. HW with userspace command submission probably can't allow the
> > power to go off while command submission is possible.
> 
> Hmm.. maybe then rpm_get() 

Again mostly assuming the SVA using driver is already doing this
somehow?

Jason
