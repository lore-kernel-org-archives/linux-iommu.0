Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF626A0C5
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426640; cv=none; b=TRjSwJxCvYSnrHtsU11oXGq1quSlAcm4XiT5oEtpRaVZSfjW24+kdc7ssvu7i5UKIZeJ02fMyNhoCtPY6x4KpfvWtUZlmXOUb/9MoyqkbeeGsAsKfHKWFESGP/g6XBUg/djMUORgAhgE3xvAm4P//82gwaYHRhvE34tYaSQ3Z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426640; c=relaxed/simple;
	bh=zfljy4Rm2gxAbHAU4BzNBsIV17zBOVvWrtlgKwNOXgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7gHskor8QT/K8F8vVQQr7k2rhTZwTnJ7+wu4HDKPmXPxI5LZmqGqugoAA72k5BQT0Fl5vKl2HDi72oXLd93qAX1TdoXH5lxuaUOeKdfpCI5oOKzFYblq+CgBBCN3AOFbI6GV9foxjltllgkWA3LFL0lhQ3Az0jRdRWqPZ71B/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPRyq2xO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPRyq2xO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso9005241cf.1
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759426637; x=1760031437; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usaTapTx1sgKpFrU7r+u4hDXdRvsxq3M0Se42L8y/9c=;
        b=pPRyq2xOQnSku5Y1VG8n6KS2njdgtFUEw/jUoNZL5RR5XaKkvoxqR590jx1ngkllOj
         H01CwTZ3bSB7VgJ2ZdCf2zDkL6vz130iOfEFhzdLcmOlCaSKuZENVtUvuoD7EqBQE6zM
         uV443fYyAohpNBKofBGe+DtwOCPvAdYKATTRmG6XZqX9pNVYyfIJz9Y4FQ70lJJB06a/
         8PFmE3bQKQkEaDXiu21K3fOcDl06uaNph5x2xmed4meBNTXSVs/P9IGDbibBIUtT4TgD
         5fTFXD5VxCBI5sjaBiljW8GC6Pe6lOWCLazYdJhBu0wdWt8Rz4B2lnrKqtY1pNGggdsi
         X/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426637; x=1760031437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usaTapTx1sgKpFrU7r+u4hDXdRvsxq3M0Se42L8y/9c=;
        b=AHY1TfQ8Bfx8eJ4q3TAv1FlvEWuJQFGnewylgTlvdpWgQw5+DzrME4u0cS1s9wQwh0
         UxjUvgYsRsymHQcBNsq5jrmASNX426CvoWZH9caCQiYwk14HB/lkUBB/UnbMmwdhvl+1
         GgdX3iORbGcjQ1LPqCxSo1zWb9ErFMnVi6ii6B/ZLP/AJpN2XxfhnlWbLXPaX0MtX6Dy
         9lDo6D1x6yodATYXf4LI2Wd2htmKUuRZvoTx+hZDlEbHgRpb+lSZis4gzDzTdYr3pRmp
         Ly68U7SOMn5qjDqBKNj4FZecPn70jgCmohuNLZ0+2pslIEUj7o62l79lKtG7sgDrp5SH
         bh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkRKziBrAb/LOuAh6ZZCuvTUTlcien3KYlCa/Mgaeta9prfWHA8vV4GY5RoHeUHEHqXdUByg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTEIsUTf2G06Bz4LAkFN3BZ8O4heyQ/RQ1ld+iqncIi+IdQydN
	2CAgSa0hNFSJHsKP1L17mVhxyP2/QLj0NLzfaqrM+MqBaoP/2oNndO1jmQEnYGCreTQ=
X-Gm-Gg: ASbGncv6lHeQT2SsnVTWW050D5YnAUjYLbFcJLvHewhC3q2OtLKygkELCXkZUuAa9uC
	x1ylVrax4hXnl73u28RDNTIb8P9d4o/SZLzCnedLtYBofP0wrPY024bJsxoIvNkf9hlYmnc9LNt
	u9WBrMPX/5s1FuMqbbN6Pscd5J47lgMo0k/tZ6v0YMw6mea2leAQ87rubKYM9AIkvz6gRSQKNE7
	on8e+yeHyPndhuaU3GgflLTyCHHQLAId25bwX2DMeiDPoB9iUD+LaaJ6moWLvbvKnFeNDUkccfs
	ZaCt1tfbOgJrlUpeohAJyGhaqJFnlo7IroT5Ou8XNJPLt5iaUtXQAZnT4G1PYC1PmoDUv4wbRXB
	CZKXwKlJNWg+dxbA6COhnHcrhBhaXzH96UH2lEvhueoPEPCN0JKbGBo4+GhyT9L80qU7rAjCFvP
	1dzow1gjpWTLW4lqTy
X-Google-Smtp-Source: AGHT+IGqv29Dy0T8wGzWH5+5dxVX2ZhsX0Xz1O+fH669dX+huNL5ezHyqYOUT+Lon2w+sCCyknNBWA==
X-Received: by 2002:a05:622a:2616:b0:4e4:6b32:697a with SMTP id d75a77b69052e-4e576a7c166mr1990251cf.29.1759426637208;
        Thu, 02 Oct 2025 10:37:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55d0cb42dsm24306201cf.39.2025.10.02.10.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:37:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4NEx-0000000Dr5o-3d9u;
	Thu, 02 Oct 2025 14:37:15 -0300
Date: Thu, 2 Oct 2025 14:37:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
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
Message-ID: <20251002173715.GH3195829@ziepe.ca>
References: <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
 <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > I think the simplest thing is the domain exists forever until
> > userspace attaches an iommufd, takes ownership of it and frees it.
> > Nothing to do with finish.
> 
> Hmm.. I think this is tricky. There needs to be a way to clean up and
> discard the old state if the userspace doesn't need it.

Why?

Isn't "userspace doesn't need it" some extermely weird unused corner
case?

This should not be automatic or divorced from userspace, if the
operator would like to switch something out of LUO then they should
have userspace that co-ordinates this. Receive the iommufd, close it,
install a normal kernel driver.

Why make special code in the kernel to sequence this automatically?

> session manager (VMM or LUOD) decides that the finish needs to happen
> and the iommufd (or the underlying HWPTs) are not restored, it means
> that LUOD has decided that the VM is not going to come up and the
> preserved state and resources (domain, device, memory) need to be
> freed/released. 

I've been assuming if luo fails so catastrophically the whole node
would reboot to recover.

Is there really a case where you might say a kexec happens and a
single VM out of many doesn't survive? Seems weird..

So to repeat above, if this is something people want then the
userspace should complete luo restoring the failed vm and then turn
around and free up all the resources. Why should the kernel
automatically do the same operations?

Maybe userspace needs some contingency flow where there is a dedicated
reaper program for a luo session. The VMM crashes during restore, OK,
we pass the luo FD to a reaper and it cleans up the objects in the
session and closes it.

> > Maybe the HWPT has to be auto-created inside the iommufd as soon as it
> > is attached. The "restore" ioctl would just return back the ID of this
> > already created HWPT.
> 
> Once we return the ID, do we make this HWPT mutable? Or is this
> re-created HWPT just a handle to keep the domain ownership?

That's a bigger question..

For starting I was imagining that the restored iommu_domain was
immutable, eg it does not have map and unmap operations. It never
becomes mutable.

As I outlined this special luo immutable domain is then attached
during early boot, which sould be a NOP, and gets turned into a HWPT
during iommufd restoration. The only thing userspace should be able to
do with that HWPT handle is destroy it after replacing it.

Jason
