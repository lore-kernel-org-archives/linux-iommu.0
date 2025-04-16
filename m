Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578F29B0
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807959; cv=none; b=bmqR2D4Ah2OgHJEAu7vptPjB/aTnOd4xtR0SjV+c4S8q0YHIm1gL24CrTD7epoYq++Bg6hncUAC8Gilz53dVkCLkdCGtQ8hMgHM1jPeMI1nAWOxe722KkrKQUwCH1WC7ZLCGrhNvxQuZUozdBwFp4SBw/jTCu7mxJuG+2G81i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807959; c=relaxed/simple;
	bh=dm87c7PIMVvIR9Wh8rZaHcjvj7KpsIyq6ilOa68fAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIKO69gCGWouMek6qrLxTnzT/V6E2HeQEtFF2Cmm/mTJC9EbBC9eN1Unr5eBAekIy+RlU8lU81paXYuLi1+XwT/TFKYtlZdwEMXL7ks3mZv5Y+nNWLiM2fUuI6zNYnziCfSSCWslqasJK+cEbwgbYz2zeVt7fORXaGvvyRVyplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxU84PV3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxU84PV3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242ac37caeso147545ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744807957; x=1745412757; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqydLuhsHd9kmUVZtGeVb3bCQQ4PgWLmu0jvRRsa5LQ=;
        b=BxU84PV3z2YHHZhSlvIkTnUn8xJEwwN4DTjbOHxGRvFuTstePWThzfb8Up2GUsdxUy
         cnyhvcI73U6fXGDgPLM7opBuhFtOaCaYFBRyK1fzS8E3DxG6y0yz2Qroec7/GLved7tF
         I5pCe0sLTF6T2eSIcjxk7Pm+gCxDppxan6acJxdOjIAaXY1uRPPR8IWDpuVpIBgjFblq
         X613OqPQiIQCiJ7uVGwJHYJ5kzliDDKtcKv3cEKHO4Ft4B+EGy8aE5xGvX9YmSStzCCn
         EGY5FzealOnQPUgOHQJ2x3vsswr7yINed+9zDkJJbQyN7S9YhRB5WExHCUf+TElZKvBI
         2PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744807957; x=1745412757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqydLuhsHd9kmUVZtGeVb3bCQQ4PgWLmu0jvRRsa5LQ=;
        b=rAYua8xg+r7xJ8ocO0AevCn/aL/0tSBgi1vXP7XwvoDoI23S1dWqLM0Hnumf+7cNqh
         5XXkXd3mF1Y5hGOCFCeGEOvNVyNrzfyyjsoIjv/bU2IlKKQyNsz6hsjcx0QbaWBZWbYG
         5E6qpCl99eb8nf0+/GVFquIcX3WviLzeMh7aXh3F3CTM3/IDSPIXToA/xBzwCSqV3dG4
         rHGvrSQnf+mYEPfRJjmT8N6DXfP4eJszpfJFiV02Ma+IvRQFF23YtGz+12WYoao1V84C
         eqWozGXvDbnjLmbwA/FYdlBku+C7pYrbheovTa4GJSCP7eS/7knfsWSg7ynHQZ4GWeeH
         QNGg==
X-Forwarded-Encrypted: i=1; AJvYcCULSePb7Ja7IWX59ilcwpQvP33rTj6AeYJwGAMaLpbFB/hyUDWuIGDdLPnuTwitr16yU5mJfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsf5ws6ShVkdvLzulcLOLvQlvS6JSQh5oRuufmuo62iPYaLPQD
	dICiZyuIiJDIVGfh0DK0duOWCINiu21paZKyQ1TxGYGh5gPW9rbpqcYI9guetw==
X-Gm-Gg: ASbGncsgVJd/v/1vjDLfRO3sxcnd1xCtoWVv15OA7fPIkqlS+PBzWnkAGE9E/Hf0uh6
	AV3MLyzqcdX5r28Jxdjojgrl9F9xUCq2vYn21sWn5I399/qnm9E9s472i+G8giKqYmo1HYxvnvF
	VJm9Mf4y0RUAvmhRrDQVqfjPj95r4rlii7d1JzCY1imE+U0EYCR0v9ccyjjhtrGCuOawARyD+nk
	JkDYQBiJ6yoGVXCPQaqma9wo8wNpyvOdzSJcPHgR8BwJZfMKmVNRRr659OhRYTeUbswDjRFdtCW
	We2rW0ndZHCZU0qrjXlj6Z5RKWRnHWGtwjyWIvyGG1XRTanQRF0X44Frh5Rl9xK4hkzp3HBU
X-Google-Smtp-Source: AGHT+IGDIwYmMkYiMahjn+apKDb1+v4S7SXIxwKxjWL8lS754lfocv+ub5AQaB/i7V0QQWqQ5mwSkA==
X-Received: by 2002:a17:902:f649:b0:216:4d90:47af with SMTP id d9443c01a7336-22c3551c474mr1377745ad.29.1744807956981;
        Wed, 16 Apr 2025 05:52:36 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1150389a12.68.2025.04.16.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:52:36 -0700 (PDT)
Date: Wed, 16 Apr 2025 12:52:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_-oDPaAgLaXcrfC@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
 <20250416120251.GC493866@ziepe.ca>
 <Z_-ikT2whG6ekqrN@google.com>
 <20250416124252.GD493866@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416124252.GD493866@ziepe.ca>

On Wed, Apr 16, 2025 at 09:42:52AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 16, 2025 at 12:29:05PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Apr 16, 2025 at 09:02:51AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > Also, this would mean that we'll have to take care if the Guest Kernel
> > > > ends up touching the mmio region while the SMMU is suspended?
> > > 
> > > I think this is approaching it backwards.
> > > 
> > > If power management is supported then the power should be on unless
> > > the VM has activated its own virtual power management. VM virtual
> > > power mangement would flush the cmdq from the VM side then signal the
> > > host that it is OK to power down the SMMU, which the host may or may
> > > not do
> > > 
> > > It doesn't make alot of sense to power down the SMMU while a VM is
> > > running...
> > > 
> > 
> > Exactly, that's what I meant to convey..
> > So.. can't we simply take a ref as soon as a VM is created (IOMMU is
> > assigned to it), maybe from somewhere like vfio_change_dma_owner and
> > keep things powered on? That way we keep the IOMMU powered ON if it's
> > controlled by the userspace.
> > 
> > This would also allow us to only care about the host-managed queues
> > while suspening because we'll be sure that if we are suspending the
> > IOMMU, no VM is active.
> 
> I thought we agreed VFIO already would need to do something to keep
> the power on as it can do DMA at any time?
> 

Yes.. but if that's the case why are the Guest-assigned vCMDQs coming
into the picture? 

I assumed that there's a situation where the VMM doesn't use
VFIO and only uses iommufd to assign/configure the IOMMU, maybe we'd
need to get a pm ref there as well? Is that the case?

Otherwise, if we have any user-space entity controlling a device behind
the IOMMU, we'd grab a pm ref and not power down. And hence, we won't
need any special handling for Guest-assigned vCMDQs because the IOMMU is
powered on.

Please tell me if I'm missing something? 

> Jason

Thanks
Praan
