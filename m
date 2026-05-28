Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FD3BADAA
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964498; cv=none; b=fd0eBhXxzZRHNx3L4APbwLSiPYHf+QpFULbct2ij9M56Faz1gtl1aRXTHTDQkZ5aj4boxzqjWTQjtCU+e7yDeUtrzNZFkbc9CHJm5HDAqo9K+4c5OlvxquutRKT9Ok8rqZe9gySRO6PVjm+/dSwyXPgKib4Slp0K7K3WJZ7jvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964498; c=relaxed/simple;
	bh=V6dRljj8mtH+ysnS8x8G5AQIU/PLqz/rPxBSOa/Ou0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT3kHOBjs+uQD1YAyjq2vBP0dPh4U2nzLKb0D7Y2e3nFzn311esRJuwDTpgkHbgPVGq3y8sOtEnpl2JKW5Q37DHROaMLNuN8Xh8xOicozm5Gwd2m1PPDTofFsNiRExCjqaa1kb3j5coyKw12TmPdVmYU4cWhOaMq2xFYwbUepbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBlVkJcv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBlVkJcv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba180a022dso4345ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779964496; x=1780569296; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRHY8TjgLXlayczNGHNxnYXWUTLClhWO+MAQeAavDGw=;
        b=hBlVkJcvDkR9qD/wXWoq/xh5JvVJxzVfTNzqyVIl3tZ43wZ9rBwfDJqd+g52T/fz1t
         hAtGQpmIivQ+oDzbU5wZZts3wzULrdMld/ZBU4GNri7jB+1l+0Ai0fpCBhJs4fuhecrQ
         Wuwv8RAzroIipG3DdYGFQQZbsr/qzoshLYon2LQALllsS60auxme0PVw0oIuCB/so4sK
         O66DfE4fJRUtMt0kv5ijBdurFDmjh4hCsmPzN7NhFzpODQdscg1YR5vk74F6pm5UvQgE
         vP/GfqKBw2LCK+10rwlN49xgP8U0b/8mS4W6T8cqp1GxsTyIdXmwhUR79trcmO/BgMiA
         H6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964496; x=1780569296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRHY8TjgLXlayczNGHNxnYXWUTLClhWO+MAQeAavDGw=;
        b=KypV2PZ8rIp69XfaS/TtRZyPt2Hg8szR743DE5IWrVATuJQI8dsl2AiGNckRxtIzDZ
         /Voek5K3dEKC5A+WwC9FcV5Kk55/v7eT2hq5xB12jd/QmnO9bvEiP8lIq0ue3CuaJ3nR
         PGsOgmMvwLq+oUd/ePLBz/V939F6DQ3FdliS3sT1yqiN4MG8e0tDlO6OMXFZgZaAgFBh
         5ojABEi9Whm8P6r7BIOui051dMsb1qwvsklMXnJwyxDtbf1aBjXmVrlOwyxDzxnRKpnA
         1QMUwycpK7SX/YsuoSmyODnMAxOuaRoiq9WvLy+7zDMs1zc0OrH2YIklQ2M2TnOLZyA2
         4dmw==
X-Gm-Message-State: AOJu0YwklQF8ycqVFP56baSNGUK1KI4Mh0QBcYTnuV6MgvIbPmH7EJAZ
	JTBvmmrdlVeamJs2PiXIA79/rhLbocD92PFSdNSB3k8bidpezVGKsWBKLcJLVUBCVQ==
X-Gm-Gg: Acq92OFCbs+NDb0THRFE7T6ml1OIlaGkpx9CI9jt9xVu7yFPNjH0QmkHOR6GEfNMPlr
	x2jiN8+3ixUFwawl8RJPhgXt7+C/lMl1dVb7EUWfSWz+2CUkmmybAqsDcsvZucp3CK6QOqI7FuO
	L4DlX0l7+Ct2T4PkDy+GiUjWFNnR7748coyyJqUZPSSwNoEtgUZfGAezyOcOc18ec8MczBMvwm9
	VeYL+ttvaya/ImSdFDVApLs5lZtXJAasV2ekWSF1ByDD8ftSlQjNUAv6I+IZ88Dkof5i3chjbr3
	yLVrIDTa1W2uclB9vV7eWqnad12rw5VkX0rLgAJ1V5zbh4nQBXN/NPSaxJE4As7psO3wWP0lOre
	/R+BK117ozguwUgqpCRduEkWuDaDHTFX/MMaRAZcVXRJVJmskVLgkzp4++ZHn1HypW8E1WbzDRz
	2k6dWQoAivd+80x0CaBv8jQCv56745B5S8onyU5s6tHMtx27KUEmWUhXZRn00uHuJE7I8v
X-Received: by 2002:a17:902:ea03:b0:2bf:28d:87ad with SMTP id d9443c01a7336-2bf0bb751admr924255ad.0.1779964495169;
        Thu, 28 May 2026 03:34:55 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e80246sm5742507b3a.12.2026.05.28.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:34:54 -0700 (PDT)
Date: Thu, 28 May 2026 10:34:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 02/11] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ahgaQm5y_9mISKg0@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-3-praan@google.com>
 <aheb/OLd9AQO6rD8@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aheb/OLd9AQO6rD8@Asurada-Nvidia>

On Wed, May 27, 2026 at 06:35:56PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:13:58PM +0000, Pranjal Shrivastava wrote:
> > +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> 
> So, this function has a very generic name for queues but its use
> case is limited to cmdq in a suspend context, and might not work
> for other queues.
> 
> I am adding another helper for in-flight evetq and priq:
>  - Drain a queue for a detaching master; other attached masters
>    might still advance the prod, so queue wouldn't be empty.
>  - evtq and priq sets wfe=false.
> 
> So, there is a naming conflict here.
> 
> Maybe:
>   arm_smmu_drain_queue_for_cmdq()
>   arm_smmu_drain_queue_for_iopf()
> ?

Ack. Sorry about that, the earlier versions were draining the other
queues too but that has changed from the last few versions.

I'm planning to rename it to arm_smmu_drain_cmdq(), sounds good?

Thanks,
Praan
