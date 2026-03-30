Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2213E315C
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909735; cv=none; b=TGhVlPSH7wbzwEek1vwa+trfnqxIxwG2R23CD2U2ig5xRjiDCP0vY6LprUhghZVfGHy30pE0wXxdfQZCn4q271S44nFpfkzM3Ht8xY+4g38xsAGBYOs0xbjg06jNohOiTZbyLcLAPNmFHrYfips4f3WHSH6xzNnizZgG9YvbyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909735; c=relaxed/simple;
	bh=p+8Uupnt4d/+fum8lNUjSILa9EMDBoZzvWnUvrHfUyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvh23zBbQfbemlKdGhTuQtiUUYcwu6TrLoNxWpEfnchJdHCkJ54juKaHLzvVqX9g+ZN3ERsOJ+OUaApqOkaCPcdTS3eE3K+6ABDLeaIG1CrsDCcSFnb6O0ZyWxrv/MbqXAxWyCz/fm812BAQpncRLDupHJjhYvMNgSaorK/yq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iD23KFdk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iD23KFdk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506362ac5f7so44689621cf.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774909726; x=1775514526; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UUV3PEcejCNm1YkzvFVS2EpjraVSJNH9BjQE9qLyas=;
        b=iD23KFdkfiaihzJQ1KIhRftdlibex7QB3YgUbFuCq6bQaD9rbXV9utZDWLVA0jJ5lV
         nHCKI1Nz85btkUv4wo4PqIqx9wKqJgBDGf1v3rRwSRqonyL/IPE2fu0H9MWv6wd8fmxO
         Ay20V7EdJiApR6wRdnjpEkl9uzkqfBn/3MRsRjel36iv4qYmQToiGPQdTwZmjDv76dh9
         e1kmV7WCK9ewisf6iRNZIlz52dL/ALwvujgs0yXfTFXRXjRMV+FUmuqhHEk1sm4fnLxs
         I1Nr53ww/VuazZ9u9xBGGK0ixKcPs4KePoCjtrK1kI1TWrfgYxIDKXiR2mD1j6oe0cBX
         qykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909726; x=1775514526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UUV3PEcejCNm1YkzvFVS2EpjraVSJNH9BjQE9qLyas=;
        b=QueFQC070Y9Q25tE1g7av9O6tUXETWCKlAXKY20GSO1DqBbXgpt65LgtOi4A6GqeYq
         1cm9mRqbdBKbCuLWqS49wNnai4kmMvn+ZegX3hWUFJYYh2zUQhKR9sY8XHU5vtQtwf/e
         /S/E7R+yfR4hC1ELTzrBf3Y5AUo4DPUa/rVcEU6jEoGJrpRv6AOnNbR68xuB0J51xJ3a
         L+q5iz/lq5HDt7Vmm3d60MsaJK2qzxRfZ6y2zBL50lGA3uAU86luW/1ZERSxfhPBuGt4
         Jq4JpC/KsDeD0icFK5GZFPxsSgLDR5JR1CnAlbHbl2XgxjeeQTXbTqqEdhHawMFgTDBV
         0DgQ==
X-Gm-Message-State: AOJu0YxowyJppK01qTaV/AeyjZAxVEZARIV87uM712VLOUS5IwwsUto+
	yMIwFKctHRUi260k0Z+W968nEfssR2YoVRB4IHyY86yLDTiXA6pVgapoBCPXO1N05rk=
X-Gm-Gg: ATEYQzwo7eJ88+0Adj2TOYXNxDp4/F7dWDqggYwF3u2dUNn+xwL/zqFKVIMS5tqAy4O
	/qtnklKjh19F/poP0Sr15VCgNjlIRh7aHk/CXivu1TA3ZKbM87BZrfCnwOmW4Ks5xNJutLNnYVC
	pLMzRZGZooFJCh3SInAM6SVGLjlhhrvZRmd95XFcqZ+KcSv66WhFNJv4c3yAwjw29pEg1MrPagK
	WQGYufqcbDkrBLAWKvxtGGxJvRMH1Tlv/MaQfMOge95csVIVtw0WotUVYEne4Bl1bvb3zzCtmEo
	eJ80ZXZ2NoBW5wpLOo+Tm4FJFR+tSL8d2ZDqbpW+Za9/o3lsG83peJO0DutBD/nVlthoHEioHJ/
	BTpLGxKw7G6VnaP3/b5//kd9fDLhZaFKbcupcaKA+VhnaeuOVSQSUGZcvE1UnLjOvtfxwAd6dN7
	Y9yEAKcGJWE9LbK56hOYSpb9ybS+yDH7kxW4TfVPKCVcjyztPAgz/yE2I4ViEutNAHaks60K+yR
	8HgXsgd
X-Received: by 2002:ac8:7d04:0:b0:509:20de:4acc with SMTP id d75a77b69052e-50ba38b218emr197186911cf.47.1774909726005;
        Mon, 30 Mar 2026 15:28:46 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2ddb083sm73544731cf.15.2026.03.30.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:28:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L6C-00000005Hhd-0RZG;
	Mon, 30 Mar 2026 19:28:44 -0300
Date: Mon, 30 Mar 2026 19:28:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
Message-ID: <20260330222844.GG246076@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
 <20260330150903.GB809900@ziepe.ca>
 <acrhbYo1tbiaugyJ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrhbYo1tbiaugyJ@google.com>

On Mon, Mar 30, 2026 at 08:47:41PM +0000, Mostafa Saleh wrote:
> > The force_dma_unencrypted() should only be done way up the call chain
> > where we decide to get a phys that is decrypted. Once we have a
> > decrypted phys it should be carried with an annotation throughout all
> > the other places.
> 
> Can you please clarify what you mean by annotation in this context?
> As I believe any tracking in the vmemmap is a big NO.

It would have to be a flag pass along the phys, or phys & flag in a
struct or some kind of approach like that.

> As replied to the first patch I can attempt to implement this approach
> (by passing a flag around) and see how intrusive it would be.

I'm less concerned about intrusive and more about making this
understandable.

When we reach a function with a phys it should know what that phys is,
not call a bunch of random helpers to hopefully correctly guess what
it is, that's unmaintainable spaghetti even if it is fewer changes.

Jason
