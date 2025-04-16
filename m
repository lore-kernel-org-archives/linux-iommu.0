Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA659FC0E
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813954; cv=none; b=hkLdPFnaouk45lGJhLywrWXxDadt05qAbuOTMYaXWIdkfJ3rP4SBWOo6CNi5O0twEMcxnCJH75eThpfBysGzKjI+5npLX/5fYcW2qn/CZeYZ5klTpzDzWMn1PguEsyMYxiLXPZJfJ+j0JoP3a6YG0psRYUiCueEmqjb2mtskcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813954; c=relaxed/simple;
	bh=nfKEV1CZBoTyuCm+1CRgpQrN6B8keBr1yk5mdRRzv7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMH6Ggoo011HoHHC4l9pyPTbV88dTz0oysGwdXfXpgqlJPZHt2Bm5uaPrHjUQoRQwUchFKtRnI6UtXk4YlPHMJleUqwkvF017TPNoB6eaHJ3BUHj6ngSrYMuTz8zAPGtdORslUd1Bx99lRC4JPykZ+a6J200d6xs4Jq1znrcAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIH7gRID; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIH7gRID"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso190925ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744813952; x=1745418752; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K91qqoCwl76A4ip+9MQxbeKYkBoLmkMTmFYXED6FVnI=;
        b=EIH7gRIDYlbwL1nl5pC6c1DXmjXwSgY1dIKgIgT8SPDO3x4jqiIfG9qCsWb8IN5W7p
         fa+NrstPz6iotX7mVuFuylN2ryknks/lndbB7Pq186GVl/TOy2AxWCSQD7aAj78ZAeh5
         Lc9ngFvaISzr6NcGrKWQlHHjpEAGFuhdhIf42TlwY8+qXhC22l3fF8Nq6xz6HOUr6bP9
         ZKC4jEuwJuK+Wjc898uoZPe1T5TyRgk7Jg1NXFvfLM0VyuTHP/NjyiyV2f0pfMcRJnTb
         9Wh13DqbkIYqF+Omi8gJY1l9VkXy1nBL2u67pBOpEibUQtQBdnimRrd7kHZqTDOhmHAc
         g65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744813952; x=1745418752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K91qqoCwl76A4ip+9MQxbeKYkBoLmkMTmFYXED6FVnI=;
        b=M1ckXcx9uhkZPYzd67DvHMmEgBXDUCVQFaiG/kYA/dlecyb1Nj2JHckH0Fs8DP3UBf
         yjv1vsGUVDFffE5F1slapqXiv2tmK3kfypXFzyS92Kq7CAFZJHeJHt3sEslujT1O9cFx
         8WV8cOgI+M3MKcO29sjObWqKIcWWS9v2/dK+WDn0wasTgZRjd6uBwImuYwh3SWvIRiNg
         08JBJI1lMiFUf+t5+gyhWZDgt51N4RSJsVKwjFLbaYa81UzqDQUZL16U611i3GtN+cnp
         NdvG5sRqtXhNqRjHtCOC6F5r1TYf2wVI4lb49UAs/YTn+23WXTYZ63feRU2gHX/E0ovS
         4XEA==
X-Forwarded-Encrypted: i=1; AJvYcCUl93BcAifAD6z151+0RHGsf8WMhDJxVzeXRxkQFn8v//CZhJdD71rCN8j4gYPEuXnW0PPMZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu9fNiljElUWUQDVssFHuLIzHNSEc9nptNXYX5u2M5YI2ycdjP
	gp+2IN7UMRahgQua6aBH/z6t39HBpz5D+i1C9yo4bEF/LtZ9UQXOK8N7Nq0+dQ==
X-Gm-Gg: ASbGncu7JrEMbr8yV+ivsz1rChR7eR+SXh+BbYt77rfsrOQueQw9DMAiNZJ7J8pCVYk
	NBTjkubShZsAf4V8RTVkJcwB8+5Dcv5xHilifiJ7Evn9pGuhHEMN4aOVQ3W6nS0YTjDyj70/36D
	rEXXlN2nqOj4kKkW2uRigF8/QrPefT1QQuxwAwSd8vre7REMvfEpwAGdZAJbeWVFMwt42mtx1OS
	4aZL/22rvd+jNSvVfObwVAOaq2YADQoA9H/9hmtzEcoMGyUlPL9ZNC6BzHGcUxE41Ua8hBPzcQS
	0CItiJWv+cYrDlrBAHbkPb3IcvZ3hEM0sJB0Mf3RJ173+xAbipcIv/2BXDa8oRDvNUkLmfsK
X-Google-Smtp-Source: AGHT+IE0XMK7R7CvdSHuKb+cKumZ9inqw6rg6QHeSrEtkwRDE31vfqJQyz84hH4PONeQs9zI6BbDeQ==
X-Received: by 2002:a17:903:1b0b:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-22c3557c68fmr1901235ad.20.1744813951497;
        Wed, 16 Apr 2025 07:32:31 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cde6sm14741685ad.88.2025.04.16.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:32:30 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:32:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_-_d-RrMliYmm6N@google.com>
References: <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
 <20250416120251.GC493866@ziepe.ca>
 <Z_-ikT2whG6ekqrN@google.com>
 <20250416124252.GD493866@ziepe.ca>
 <Z_-oDPaAgLaXcrfC@google.com>
 <20250416130711.GE493866@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416130711.GE493866@ziepe.ca>

On Wed, Apr 16, 2025 at 10:07:11AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 16, 2025 at 12:52:28PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Apr 16, 2025 at 09:42:52AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 16, 2025 at 12:29:05PM +0000, Pranjal Shrivastava wrote:
> > > > On Wed, Apr 16, 2025 at 09:02:51AM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:
> > > > > 
> > > > > > Also, this would mean that we'll have to take care if the Guest Kernel
> > > > > > ends up touching the mmio region while the SMMU is suspended?
> > > > > 
> > > > > I think this is approaching it backwards.
> > > > > 
> > > > > If power management is supported then the power should be on unless
> > > > > the VM has activated its own virtual power management. VM virtual
> > > > > power mangement would flush the cmdq from the VM side then signal the
> > > > > host that it is OK to power down the SMMU, which the host may or may
> > > > > not do
> > > > > 
> > > > > It doesn't make alot of sense to power down the SMMU while a VM is
> > > > > running...
> > > > > 
> > > > 
> > > > Exactly, that's what I meant to convey..
> > > > So.. can't we simply take a ref as soon as a VM is created (IOMMU is
> > > > assigned to it), maybe from somewhere like vfio_change_dma_owner and
> > > > keep things powered on? That way we keep the IOMMU powered ON if it's
> > > > controlled by the userspace.
> > > > 
> > > > This would also allow us to only care about the host-managed queues
> > > > while suspening because we'll be sure that if we are suspending the
> > > > IOMMU, no VM is active.
> > > 
> > > I thought we agreed VFIO already would need to do something to keep
> > > the power on as it can do DMA at any time?
> > > 
> > 
> > Yes.. but if that's the case why are the Guest-assigned vCMDQs coming
> > into the picture?
> 
> Don't know.
> 
> But the vcmdq's are used by the host too..
> 

Yea..I agree that the host-owned ones would need to be drained.

> > I assumed that there's a situation where the VMM doesn't use
> > VFIO and only uses iommufd to assign/configure the IOMMU, maybe we'd
> > need to get a pm ref there as well? Is that the case?
> 
> Right now you can't reach the iommu HW without a VFIO, so that path is
> closed off.
> 

Ack. 

> > Please tell me if I'm missing something? 
> 
> I think the issue here is the host operation of the vcmdq's
> itself. They need to be quieted just like the normal command queue
> 

YEs, I agree we'll need to handle them as well.

> cmdqs that are assigned to userspace can be ignored, but the upstream
> kernel does not support this yet.

Ack.

> 
> Jason
