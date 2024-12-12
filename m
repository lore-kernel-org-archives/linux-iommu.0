Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBC17BB34
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032679; cv=none; b=eiDC8y3eXom8iDV49V8q+dhOKxtz53rHinjA6plvhJi6X5jcPWL870uCTrSOlqJTo60ozgMH4naYbILpkYMYng/kMZWQjXyiMRmACC4zfAwUIVexBEe1XiWv+2G2TxYxqCQsbZt9S9hMhM/fh9d2YMZKGRciHD6T6fwt+FA8NVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032679; c=relaxed/simple;
	bh=45Ud0Mn2aNdFEQLclVcWubuH1Q8UAhrJeGlwWksFBLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz7pQcKOaWDkjpii4eOE8i3Tt+1JZSLiKYg/wd0g6M6WYuh/BwOtJ5qIMHU/BLYIsFsUdhZeKf9/vo6PBi2txqCG0iuX9EWr1OvrPJIj4ZsRnwI8NYmi+kg2AkZ0QEo9C3uw0tl93YAl/CBIrShIjUkKsenHt6sqMl7pJAmGXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VgGQt2FV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VgGQt2FV"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4675feed835so8669891cf.1
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1734032677; x=1734637477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtig8lXsoUwLD51T1aq3aT1xZ4mrN3No+06U1nAA6eA=;
        b=VgGQt2FVgYubZ3Ke51YqBmIbTKU0ikl8bHTrYfIkjUghdWGFXBHw2s34LkExgNM2E2
         YGfVWhoaRdoaXav0ywccchACKOSBVLco5DvoyIiCHiecH2G4H2ctIOG8sMoQgXtEDShN
         pxz1wlAZrxf44MqSNxIc0w0eWIZ5/9wRabn4d9aZPNwk/6jfNvy/72/XAqUdlQo3oJ2O
         KWhpEsQOfr8FXZt7PeUe6kLSjscNdCvR5JIvDz/W19zoOsdAP8hWdfET8fYU5TPR9T6W
         QSS5imnGv0HJG99l7BBcoviYzxE5Bk2yQksoujO7dpw4H9VxumnZLYdEA4gVEbnJGNt9
         H7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032677; x=1734637477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtig8lXsoUwLD51T1aq3aT1xZ4mrN3No+06U1nAA6eA=;
        b=Zvg+LAXvdB+8ECW2blHeHP4Susp4j5HdcuhkxZWMdAxOiA4ANeJjZ3uVrsB+V237ZV
         rb3Eqgqb2l0S9YRynR5xeWQFstMGTEjJkC0PDYJ1iB+vBAarVV2j2H9sbZYtBdFny3uM
         n07MCdqyGeET628DOGcX1o7xWgVqB9YdRxp6qa942s0MUzMsXqW7tMQbB4qe3/ACt6SV
         L5uor7KHpqo7NwErFsCATeiiL2S01oBTRG4oBUk3UcSRkily//eKWvbdxyuyBpp3RxKW
         Kbu/nJvlAIqFLTtMGB1U7KXj7vyn2QmRc6FPHHyPrLoVcImupgU0gcs9yAoVC8IIx0dp
         ieUw==
X-Gm-Message-State: AOJu0YxgDAEZW6LXVPuJqL+KdSqo0JVXr9M0c+nrqe/L+h/ALVB+O21a
	yi6wBvvUWKExyVOACxrrXHEbrqtyxM8bg3pwNgi6nzQ//fq3QVYrOZJXyVPE2U8=
X-Gm-Gg: ASbGncvp37ajITn7DOmdovZpbg/JmKzS24HHbJu8LaDsbgVHvXBCBapz5tdn83Ggrog
	h0wKjno7tkIjfjJn8eqL8a/BZppU2aJqqossH384YIFCshFJMD3rc+vhdYcOFfjdXSyzjh2uOpA
	Nb1C4ZX/Hae8srFBMyybOwb/gHd2Ih55g8Qy9EDhBJw6TVQ15j76JRF55yomh0G8pS3w4fuIfzl
	pOnP+DBZa4aSkc3o4fGiGzpS0FgaYoMPBIlEaoOsW2OvN5QZGlfXkAPMn0GgNNjTNWquqCyHf6Z
	rDJgkfGzkXCxZCMCUFzN66ISa1Jm4g==
X-Google-Smtp-Source: AGHT+IE1sxaWouFki1wTNuqW4Mldx9O5wExQbsXpYwJ4pEsT62nJIL+C/8F//xL6ak8oICXCgpkwJg==
X-Received: by 2002:a05:622a:1114:b0:466:9f89:3d6b with SMTP id d75a77b69052e-467a156ffb2mr26650471cf.24.1734032676656;
        Thu, 12 Dec 2024 11:44:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46783eb0d91sm28376531cf.63.2024.12.12.11.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:44:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLp6x-000000001Zr-0B7D;
	Thu, 12 Dec 2024 15:44:35 -0400
Date: Thu, 12 Dec 2024 15:44:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 40/58] KVM: arm64: smmu-v3: Add map/unmap pages
 and iova_to_phys
Message-ID: <20241212194435.GA5484@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-41-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180423.1578358-41-smostafa@google.com>

On Thu, Dec 12, 2024 at 06:04:04PM +0000, Mostafa Saleh wrote:
> Add map_pages and iova_to_phys HVC code, which
> mainly calls the io-pgtable.
> 
> For unmap_pages, we rely on IO_PGTABLE_QUIRK_UNMAP_INVAL, where the
> driver first calls unmap_pages which invalidate all the pages as
> a typical unmap, issuing all the necessary TLB invalidations.
> Then, we will start a page table with 2 callbacks:
> - visit_leaf: for each unmapped leaf, it would decrement the refcount
>   of the page using __pkvm_host_unuse_dma(), reversing the what IOMMU
>   core does in map.
> - visit_post_table: this would free any invalidated tables as they
>   wouldn't be freed because of the quirk.

I don't know if the timelines will work out, but the pagetable stuff
I'm working on will let you write a much more appropriate
implementation for pkvm's usage than trying to hack it into the
iopgtable code like this.

Even the iommu focused routines I have got now would solve this
problem because they allways spit out a linked list of all the memory
to free after map/unmap and never internally free it..

Jason
