Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0E21325A
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935508; cv=none; b=thvGWeEqnMSCwn/ZZcq+lYx7t+7IYq2hJ8MYcFaVGC4ZOQXfq1xwwROEH/ltcRFoUYfm6lu76CSsDgKcK39DOszXFmLWXe+tjTyq0jvOQfff6ukUM8O4V5q0BpUJhp0tpSzQBHJr6IpRBuWIs1ouALNiC/CW5T3k//8MR21/zoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935508; c=relaxed/simple;
	bh=JUMj7m/qxM07+AHCqs/esGILKaVryMIC6qrAPwaDYSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtkz/yAYzl4XD9zarHCL/NFSyn5rZUyhsdkPW3g7BK3zt6/cQf+/PR9JWKTsCUQZobHHhRwklCC/EDmzLHC+JYHd3IusYNP4I5LHTOHe7k5ZXaG9a6rE4lfVo0z8Z0yQitA9wagb0n8Gf1t39ijDdkw2p+jurka4pg6ffYNiu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O00kvMDN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O00kvMDN"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so84491416d6.1
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745935506; x=1746540306; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=67ZN/XRJXAlmBnQmnjPx+NwiyFFUpfzzQma2UEWB8yw=;
        b=O00kvMDNa0U1WiKnnbwazpi/bGWZXEDlvlYgODIVLjKkALrataMRaGFRA7GYWPyb7F
         4aV8WiRoIO5tcPo3yTyXGTM5nNrV2EQEEtYlbkCtxvFITrxoNb9ns4B7i3S6diphLvaJ
         AilEukSBGUcS9Zj3x2Olng/yJWRVZgO4peJ4dbgk2sFw8zrI2L+EjFdP7VsRDhIGza6w
         l9QsnpmYRwogyW9YgWrdM8/ES7bm0G726WMPm6N/uWY840nkhiLfMLYVbCNzsWKRLIyZ
         T/+ELph9Ep8nZ08dTiBOHUuNiyzGZlPZzey/qHE1GRYY63fbLy+vR5TqvmmhCbdvpW0/
         JhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935506; x=1746540306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67ZN/XRJXAlmBnQmnjPx+NwiyFFUpfzzQma2UEWB8yw=;
        b=QN2Q26nd3OsDE4KnIti8Pkdq5jVcYWpqOMgJ8ChqBHHKF2MjsSsWWYyEz3aARZZ4L5
         scOEvERsNc2D3V/modh21XNZCruDt7Ye9eWeFI0bHVIsSWMfclOY+ahXnJE1z9hcqaMd
         HWtpY3o6abDYHM+GDDFEeUu2UCaCr4C9w/ATtRTPu+bYATIBdTR9oTveW8boqweU8RQw
         oV4IF0DzTQwonD91jddStBODChTd/eOzbITYW8jxIkiZOUWIH+FJAsFiaFC+JyaBxxc2
         XBPevH8x4+G4nJsp06LrYRRWAqCqMZ5FCZRQpSbRR7Rt2o8ikqq8bOjaxDyzmcUq2WOd
         HzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv84Cmm7igkJweJNweXW3M8Cd+pL6XA9F0SOhJWFujgPsqxVIBaYlYAgtX6lhsSr/a8F2zLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL1F4YF4xcycB9zvmrpXoSS2kpWxaH0fjtXKX8XlvQz/LbuqRE
	HOVFnl19I6Ri0q/xSMaBw0CZ7VF4uBLiQBNsJOCg+V300mbrEBFi7bmG0w5T3wo=
X-Gm-Gg: ASbGnctzjO/QxO4B56wgU+DyAHNEwhx7ifDBt+3M8fIe3KYrVA7BTobcvbvpVG+ZiHb
	JYwo82annT5l/7EtH2jAoa6v3G/yoaXnAESHmybMHByo4tJCd2uIc9ZQ9XT/tYRRT20kdTlLYZR
	ZCu8ONT43IMDd7XJw6AmBVi8Go9PjLwLeItwnQpMs7Euy+qyvGE6Jo/s/4Qvl6IUhvwpPQmU4mS
	SSbduYD3MFtQIVO7sVKG2ktxBz+e/HdW6l1EFhi6hv0m0l7Glrdv2XdDjvfEinYxvKa534WFljT
	tVtHN7oCEf4ZfdQPtqtF4SdJ+V6nJD7Cg8z2mCM//+2iS2+DOi+E+w2DT4yJF5h5U0GsHRYc4OH
	vQXnXUoza3kFqq680Fuw=
X-Google-Smtp-Source: AGHT+IEGHHMBFCeWwt68ed4umDEC8R1Cxg2x3qg5I1VMmEylqtVgAx6JEUyqfbECn9olvSAU7wat3w==
X-Received: by 2002:a05:6214:5005:b0:6f4:c939:a3f5 with SMTP id 6a1803df08f44-6f4f1bcfe99mr47285726d6.17.1745935505592;
        Tue, 29 Apr 2025 07:05:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4e0d8495asm30959186d6.18.2025.04.29.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:05:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9la4-0000000AAyC-2M6z;
	Tue, 29 Apr 2025 11:05:04 -0300
Date: Tue, 29 Apr 2025 11:05:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/33] iommu/io-pgtable-arm: Add quirk to quiet
 WARN_ON()
Message-ID: <20250429140504.GD2260621@ziepe.ca>
References: <20250428205619.227835-1-robdclark@gmail.com>
 <20250428205619.227835-4-robdclark@gmail.com>
 <20250429122834.GA2260621@ziepe.ca>
 <CAF6AEGt+5cg1CRb4ZSm9poWhq6LGh=N2axfRyKOvKP5PNpVucg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGt+5cg1CRb4ZSm9poWhq6LGh=N2axfRyKOvKP5PNpVucg@mail.gmail.com>

On Tue, Apr 29, 2025 at 06:58:32AM -0700, Rob Clark wrote:
> On Tue, Apr 29, 2025 at 5:28 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 28, 2025 at 01:54:10PM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > In situations where mapping/unmapping squence can be controlled by
> > > userspace, attempting to map over a region that has not yet been
> > > unmapped is an error.  But not something that should spam dmesg.
> >
> > I think if you want to do something like that using the iommu API the
> > expectation is for the caller to do a iova_to_phys to check what is
> > mapped first? That seems kind of lame..
> >
> > Maybe page table driver should not not be doing these WARNs at all. If
> > we want to check for that the core iommu code should have the WARN_ON?
> >
> > eg iommufd already has a WARN_ON around iommu_unmap failures so having
> > one in the ARM page table is a double WARN.
> >
> > Don't really like using a quirk to change the API contract.
> 
> I'd also be ok to have the WARN_ON instead in the iommu code.  In the
> case where this quirk is needed, I'm using the io_pgtable helpers
> directly, not going via the iommu layer.

Yes, that was my thought

Then all the iommu_map/unmap() calls behave consistently here..

Jason
