Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FEEEA8
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983593; cv=none; b=aqgx85fTeO9zR2azbHnLErYj/PgaNk6wmffuKoFKnVwGy4ZWRs+TJ7aXOPgFWv9uB46tOXIVoonAgVic3gzLXDeEmkuKMsBiP1fd8yeVDgm9Z650u1YwJ/fi1SqijlS2rIT+mcCGHPMAylyCuFGz47KZNBa08yeyQ/Kk9j5G5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983593; c=relaxed/simple;
	bh=BINVLnRgyb20mtAp5cKy1Cm5MJUnIiU9I4ytjoEXwOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPgTg5bi6kIWB7deZBSN3/VZAoVbbZYkb2fXwJ/OETRzN4xmricToIyLsSA6hWguKHnOIuPiu0uf5SX2nBMRIkpShm4xafSVtya6rJX33qhgLy3diGL5lTvmxhgR3bGIF8l0PuGNvxZAJJRPfZwwdTP3FRg6ahLVkkkAE/QySk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gzsk9cMF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gzsk9cMF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d45f5fde50so404809185a.2
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751983591; x=1752588391; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi7H4e9g21Nfu25Zqs4l/n2K5Xp4dE24U9jx1txkOqM=;
        b=gzsk9cMFyhNqKyxVlbQnp/hKXiKWaLZb9C9fyyrgvzdClcIDYhxexdshmHFdaTYLEQ
         bKfkDoR5HO5iBxGMoYg7kA0qK5gorb03O+DQJOhdPUgLeR5R/P86Bl6XQ2ubbWxdyJfk
         KO+Cbe64gYt7Yn0OQ1Oguh9w63+MTORIIY56xAwTGrMxGAEqQ8b64IUkzh0r8nLeVtdY
         v66sI3SzJdSVM/vLbt31Y30bUy3oHo5EV8/cxOdEweoihq5HhZ4z6B2ZazBEThThwFbh
         LSUk+t3yEkmmtXNLcvLSG7SYRD50QO8w52vMQQNjMolvQebdK45zcongk80BVDXmLPtg
         UlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983591; x=1752588391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi7H4e9g21Nfu25Zqs4l/n2K5Xp4dE24U9jx1txkOqM=;
        b=VlHkLQjksG3v+QRL9IpCbbX7OyyZu49prEICkaHXCe+WrOz1+1om6Io8A2W7XJIVtu
         ioOTVTvXFy3Z4smGBahPgMrhVAY10QqDeXvWr7H9xS6fL6PPr+HrN7m333B8uE+IvpoE
         XcytnLENStTaJWc7LGOybHKzLRB2/HKal1KqM8HLN9rBBDONvB+boXB40ibR0qd3ItCr
         59jn9/AARUDq4sSi0bW33egpZenR7g3PzSoeOnDxC6X4VeWEUYw5pFbKf952iBcudrAZ
         0pM5/Zsc9J6vB4OYZPYDyid5HS/USCfoFXJCeaH/AP4QKGWpM1Ln7hyRU7EjoXfQ/Axh
         X8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTRQKQspJMp+ACZiOb4CZ8NSpTe9IxMijnAgMrvd70Ika52B3IwZK2Ei17MhC23ZpgrySxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzF4fk0clEhdz5ipdT0cq/nKxC9km8DLtt9rVCT/RaezvxtJ9I
	/TBs8nBx+oL5qCfGF+WeOw9X4s+7b0ONLM1r0/V2zVFp4nxobhscg+PQMa3dhc0iJXA=
X-Gm-Gg: ASbGncvN/h8dloY9ejfJBVuWtKQqyvUd9Du/RnBnsSKwjI2fVUZKW6jTLBBaAywTJg/
	DUsO0RkV8HNI2NJEmhlrGUuq8I3XQGFpyLeuYGDjibbVlC5ckvmXR/BXt+uFB4lkMB1wybgrjGi
	nXAs9fYEup1BPgOGFK1LIk95BeqIaaZFUGPZ33n7QpgQcexFDAl7DJlg/Lzoa2L67Qt2yzhd6dw
	CKaWR2vhTxFtSmNc0b9S6ODANfcrU5ByrLXwIwMuApQ7vUzwMifkwcmvsmnuqM+m0z7XA9Cu1FS
	jmzH2GWGKqQgfZP6hlg23iYCnLkzlzjAtl4qqskPmkqJPtKzYRjAJ8ohvrHPnIEvPHQ8Vp8rbwY
	Ygq7WjQwZH/hUQU4g9mHTWfU1cF9/ivd4QiKQdw==
X-Google-Smtp-Source: AGHT+IE/cztazeqpYwjRDoFWW5gJZRO8uoDuF7N/tMta0ZaCg/Nk+lDvQEF/OVmMyutYglTV2SlC/w==
X-Received: by 2002:a05:620a:8009:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7da01a8a1e3mr539517585a.8.1751983590756;
        Tue, 08 Jul 2025 07:06:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb67f2sm781455285a.111.2025.07.08.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:06:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZ8xp-00000006iCd-3LhG;
	Tue, 08 Jul 2025 11:06:29 -0300
Date: Tue, 8 Jul 2025 11:06:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250708140629.GQ904431@ziepe.ca>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
 <20250708122755.GV1410929@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708122755.GV1410929@nvidia.com>

On Tue, Jul 08, 2025 at 09:27:55AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 08, 2025 at 01:42:53PM +0800, Baolu Lu wrote:
> > > +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> > > +{
> > > +	struct iommu_mm_data *iommu_mm;
> > > +
> > > +	might_sleep();
> > 
> > Yi Lai <yi1.lai@intel.com> reported an issue here. This interface could
> > potentially be called in a non-sleepable context.
> 
> Oh thats really bad, the notifiers inside the iommu driver are not
> required to be called in a sleepable context either and I don't really
> want to change that requirement.

Actually, I have got confused here with the hmm use of notifiers.

The iommu drivers use arch_invalidate_secondary_tlbs so they are
already in atomic contexts.

So your idea to use a spinlock seems correct.

Jason
