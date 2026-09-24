Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1D3AB269
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290424; cv=none; b=kVhRKQiPaF/s4Bcve5XIVUM70SDc8fNAeWPGPghcxECOwWQCnEXaiVk7cWdxGvJwvqzCkHh6Bx25jTatGt9MUSmAcIZ2Fps+vtpJyyZAJDhYaHFejIEGGFqj+9577lr67OzshiTaMi2qL+cwu5zjhZsj1z4cT1Zyk9q+N+YVjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290424; c=relaxed/simple;
	bh=iZ+xWnTaiwYqY244ouiVEpHW7Wth/ThJfp2DnzItInI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwNd4vDy4HTmFkPi+j9Ogxz3p2uTbXI3Nh2oCWcAA6Uoz0O1Cz/JZQZ4gXa1qFUDGI4Lt0va7Eb98/veVISTMMRsN0rLhaNb7KushNqsIZdHzFdZwQpiooNvPH/s7ZjvWNlgtrsBIrPdECMvcc3dLZ46L4fb4RPWaUdXt/Bug6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K8vlX5Xo; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K8vlX5Xo"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so266734eec.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790290422; x=1790895222; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HkHFg2PAsl7Q9sZ/6W2u68QBDReBA8b5w0p9gEJFVho=;
        b=K8vlX5XotywYRvE5FuPoElOi/5PXV30Q7vNGD+HS3woy4vJN8Q4Lh6pjl0EU4D/4z8
         R6So0hvPe99D4N60NjpXOon+TsG/Alc2sYDmxVKasERgOm1hKVrKIp3MPScpE7ldx7MI
         zo1Vp1xZG9jFskXFtiVZmcLxG7z5+A4Hra7ZYRXyStq/zzXxCRKzmMiDGsz6l2k+XO9V
         NXsIq5KuDhqrYVWGMeaXWhwUGf9yZ61ZPCOEvmjA8CTs/CHhXTphEHivZ2fFAXv3y+JF
         DSmDBIisKCbYvZlz8Cxy6ih53Uff9pRs3N9+hX7MlErumLtVkRf7nqPQpeYwagPyuCAc
         vFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290422; x=1790895222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HkHFg2PAsl7Q9sZ/6W2u68QBDReBA8b5w0p9gEJFVho=;
        b=2lGX73VRnjXMKvxHbGCpg4SbahapIT25CXvGkjwOPdKGmT/dB7YXw42Y4mx/oxYNbR
         tTI+knXuj4bJ9dFy1oA5HGtq2ZG6EREWq121x3RXLXWQhECwundUDSp6CncdDL7rnlXG
         VnsEU04/7NFKaTdiNqvbOX+Dylzt+LziGii2IH+0ySwog4koubbjdF2fc3dtm3BV9riL
         403HkpmNM3SJ97xXPyD6yjjUm9bTtRTO61py9qd3TTIe2y/lrvMIAYerWcUsqWtu6nmt
         tPffrIpWHipSjZfmYRGXceUJYs8CVb3WA7Gn+ohm3wUNc04SJnZxPKPCL8rQOxKHQy7c
         NFkg==
X-Forwarded-Encrypted: i=1; AKwUvBxIkhsazpw9ful6TxHM1gE8Jp+3uhi25R9wA/RW4Rwpx2yJTOwhXlKzO1svdwWRxmmklQTo5Q==@lists.linux.dev
X-Gm-Message-State: AFuF++n1KlJvOyaZHnvALrKQWxfkbDlkUU8PPu1T6crdurhJF062m3GN
	o2tf8bpxcbiJkL+dZ1zS7e5586lkMSXzZ5mCAzZsvdByqkeXKEHl/F47NmNweRITBKk=
X-Gm-Gg: AYBFou0UoR/8GQ3gqXLCY/rqQKt7xp/eBuUg2itV0TXV/v7xjaEDy+USLLVnabJ6oB4
	H9Hakd/GvjNLMLATTMByNVbdNJ4hXR5P40LOIIuzWPcWjQsnrgYUAT0NC/5HDjnHWcy6+0rufzU
	FQsbWRKkeSTWhniv8KpXa56rxe/duyVpcqtIMZe8ruMN9twr+A/Q74D6DL3vLCHH5dlUAKjx7i/
	7oqhq3+yEixQVmYC3KKgeuvEEn+gOpi3c+xXmdHvQ3PLUtb58NoxSOAHlmZ6a/yO32DS0r/C7Jq
	ZVxyl/ONFwrV6zBCxrhTM31PmNyMM74RwwEPfAVeSXmbv19eYCRtixS1tlEaxtOrFr4NwEQ/G9J
	wWosV+CoyUPDihxNoIKzh+k87Dk/5KlYmomWcST0yrN/VP/GkZAAHUcYmIm2Wbygk9lb+ptc+Dy
	AGPzZsnFIj4Lqh5w3rJwj16wJUjiGSodvoysibvGmzbIbmBA==
X-Received: by 2002:a05:693c:829b:10b0:33b:d89e:9fb2 with SMTP id 5a478bee46e88-34000f36181mr3727679eec.4.1790290422026;
        Thu, 24 Sep 2026 15:53:42 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141d2fe4bsm1631877eec.4.2026.09.24.15.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:53:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9sJw-00000000efs-2Wk8;
	Thu, 24 Sep 2026 19:53:40 -0300
Date: Thu, 24 Sep 2026 19:53:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Message-ID: <20260924225340.GC16465@ziepe.ca>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <20260924001502.GO1540250@ziepe.ca>
 <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>

On Thu, Sep 24, 2026 at 11:49:50AM -0700, Daniel Mentz wrote:
> On Wed, Sep 23, 2026 at 5:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 21, 2026 at 04:44:07PM +0530, Vijayanand Jitta wrote:
> > > From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> > >
> > > Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> > > When a set of consecutive PTEs map a naturally aligned contiguous block of
> > > memory, set CONT on every descriptor in that group so the hardware can
> > > combine translations and improve TLB reach.
> > >
> > > Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
> > > those sizes through the normal page-size selection path; io-pgtable-arm
> > > then installs the corresponding tagged descriptors directly. A partial
> > > unmap of a tagged CONT group is rejected before modifying any descriptor,
> > > so a rejected request cannot leave the group partly unmapped.
> > >
> > > The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
> > > CONT support for hardware with implementation-specific errata.
> >
> > smmuv3 has this errata, it must be disabled there too. I didn't notice
> > it in this patch?
> 
> SMMU is an architecture specification. I am not aware of errors in
> this architecture specification that would preclude the usage of the
> contiguous bit. I understand that Arm MMU-700 has the following
> erratum
> 
> 3777127 Under invalidation in TBU possible when using contiguous page
> table entries

And a neoverse one too.

> The recommended workaround is described as
> 
> "Ensure that contiguous page tables are removed using a single range
> invalidation. Arm recommends using range invalidations to remove
> contiguous entries anyway for performance reasons."
> 
> and I believe we are already doing this.

No we aren't. Go read my fix on this:

https://lore.kernel.org/linux-iommu/1-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com/

I have another patch that fixes it for iommu domain mappings too.

Jason
