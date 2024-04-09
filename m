Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C3158DCD
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706484; cv=none; b=n3K4H18y+hKJowNH1VpC1X4LGKi4en3IKi0LmPzh7aS+Gs8TTD2OhoHQyYCAHxfzjTz9REqIdoiurGWG8yrp4dDeIbpijPFsOjIk/G9KaTwRDStuTz7iEiZ4f9xRseBMBZgsXcZ9RPcpR2v/GovHe+jS+N4s5c48UMeCQ07q8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706484; c=relaxed/simple;
	bh=08qq5HCWlZ+kc23Un20MVp8h4gAK+quDdzQ4miFER2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZHHIdjPbZXbgVSF1QF3NRX/6qWUOUMG5iAEGJAUe4qaPoFUSxsK18U4iTEHAI/v2wNDqT/02CoKQh+NmneNTx6nnocxtNi1viBxf4oDcbgbIq9ZpJMyayyqGYW5mkXv1Arr3DOASINK88fNpBXrcAjz/1dMdL/aPpid8lN3RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jLtwv090; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jLtwv090"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d555254b7so292624285a.1
        for <iommu@lists.linux.dev>; Tue, 09 Apr 2024 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712706482; x=1713311282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhYxjqqqLEZ4NmXo+SZfv1SY139w6T7h5FSNcRUkNNQ=;
        b=jLtwv090u1/uRFHigKJne97B0Hz6SMOBiPsdnVzGG28cJByeeWcjTK/zp3lWHd4xZ+
         +vKyCIwKoy8TNmH7KeApmqkZqOLO5k+aibl5LAMzSC4x3UMP7Vo70U/m2bYYIn+OXv9F
         Ma4fnybGHi+OTg0qSnq+xf9MpEyUSk+v0JdaOS++TNHrg6HOQUqGrGmpld341v89B5+Z
         n34pIgbEj0L/Tnz7GOj1NzzJxJTlA4Exe5PCUBsq1pih2gwHAw3mGym08mr1z7wL+Dte
         wqpmOpDwhNr2J/5Hh75Wog1/P4AQeEt5/Euo/w7LE7IZPh346cAO6p0yC+p25GSJqtCq
         evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706482; x=1713311282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhYxjqqqLEZ4NmXo+SZfv1SY139w6T7h5FSNcRUkNNQ=;
        b=VqTQW2pam00lJXiOy98GlprHSeFn2SdybqudBiALAHsxd7YRw4kii7kjK0v0aLT0K0
         IjfRmWGjrFoMK8x5/O00lgojxbQGKvG4i8iCqjDayDL6dsl5315hDRvhAEEDLVxp7r3Q
         TviGNI6uQZG0KW5H6cupl67BZQBcZFJVKiI51oYB54z9tzw0qRftUBvdm1Do9pwskJYx
         Kc/fs5dUiAsBOTZPXT2h2vQLni4zR8a2705L5iGaDdxuo81Dt9UAHvwac/Yv2/dvjvMw
         gfrGRMpSauF8tPMQrdinVC4aY1VC3hMX9aJJfv71mZplsIHyOzb8FyoH+rcLF+MtRXa8
         WPyw==
X-Forwarded-Encrypted: i=1; AJvYcCUhI4OtcIwW+pdsqxw8RrzXKXdxrWuGyMVnaDEMAG4Kgsq4cQXOKKpzELuQkB0uYGwG76r7sNABF1lXAOlMFnxesPrOWm4=
X-Gm-Message-State: AOJu0YzapX5+RwXoZ/VgLcsXmWaTqeHEOjBgfkNg1V+oYHXWgdJo8IpK
	YHStaTBE1BA+GjbHu7m2F8Q5HAS9IvZ+eY2ZWnkaa5w8ZpFe+nB7Em+tCA8wSfQ=
X-Google-Smtp-Source: AGHT+IF1pNgXaBW/Yn6UlU21y660oCrae0FfmY/a+9BPxXzGL3pwhOQklD3p33dxkbP8tOGj4Kgh6A==
X-Received: by 2002:a05:620a:370b:b0:78d:37bf:74cf with SMTP id de11-20020a05620a370b00b0078d37bf74cfmr6318076qkb.5.1712706481980;
        Tue, 09 Apr 2024 16:48:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j26-20020ac84c9a000000b00434f880039asm428978qtv.70.2024.04.09.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:48:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruLC4-007GFW-Ju;
	Tue, 09 Apr 2024 20:48:00 -0300
Date: Tue, 9 Apr 2024 20:48:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240409234800.GD223006@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>

On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
> > On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
> > > On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> > > > On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> > > > > +	/* A bond already exists, just take a reference`. */
> > > > > +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> > > > > +	if (handle) {
> > > > > +		mutex_unlock(&iommu_sva_lock);
> > > > > +		return handle;
> > > > >    	}
> > > > At least in this context this is not enough we need to ensure that the
> > > > domain on the PASID is actually an SVA domain and it was installed by
> > > > this mechanism, not an iommufd domain for instance.
> > > > 
> > > > ie you probably need a type field in the iommu_attach_handle to tell
> > > > what the priv is.
> > > > 
> > > > Otherwise this seems like a great idea!
> > > Yes, you are right. For the SVA case, I will add the following changes.
> > > The IOMMUFD path will also need such enhancement. I will update it in
> > > the next version.
> > The only use for this is the PRI callbacks right? Maybe instead of
> > adding a handle type let's just check domain->iopf_handler  ?
> > 
> > Ie SVA will pass &ommu_sva_iopf_handler as its "type"
> 
> Sorry that I don't fully understand the proposal here.

I was talking specifically about the type field you suggested adding
to the handle struct.

Instead of adding a type field check the domain->iopf_handler to
determine the domain and thus handle type.

> The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
> sure that the attach handle is really what it has installed during
> domain attachment. The context code needs some mechanism to include some
> kind of "owner cookie" in the attach handle, so that it could check
> against it later for valid use.

Right, you have a derived struct for each user and you need a way to
check if casting from the general handle struct to the derived struct
is OK.

I'm suggesting using domain->iopf_handle as the type key.

Jason
