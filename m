Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49A45BD5E
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828535; cv=none; b=HpbwOcEc8DwyN9YdJSWhNpFmgrb7hlNS4aOY7i4Ta2cfWPtP/hggQNTOI+pg28xqNM4cJF1vx+snQ5D5YjH5Splx0a5NvUzFO1b6K/lWxDphtZ+sqbZpw4xckS7j6ZCLqeoDKHYdbbxiHJZKz0Zlm/Kbtbl15Y1O+TMpbq8PQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828535; c=relaxed/simple;
	bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7VrOaG1EKIkD3/yxG7QhdxGTClZFxSmhr+pG5FpNZoRM2l9Yo3SiVmn+HlaBh1sX+ZcZtEvc4EsWhuSGDv241hlWtlbg5E+hZrIfZYet6xztAVgQ8CO5InNzIs5AyNHfM/yepEkuN+stssPFeJBCiyMXYqnnnBNCUjgMKhSo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVDOpG+o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVDOpG+o"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae3f822163so13505ad.0
        for <iommu@lists.linux.dev>; Fri, 06 Mar 2026 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772828534; x=1773433334; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=dVDOpG+oSre0uzNAh68vapV9+wPvKjhWdYLxkxQ1VqEqGB50DZyxiEi2Hxo6smudfZ
         NBAX0aBx7QfB/XhFB6Et3nxPl9WNLq2U3BpK8W7OdupLKS9YiW1hL4mOKKPD4s08/1WD
         lBayYwW+sxM9PMWqmBg3Hf1Nag2AMvoLfgXczPapKJVfr1gKFoX2nNOqTymgNLPBdlam
         VzsLyZIfi0t7AUfeF/LWJjOyWRtW+f7qGl+SzrlKdf8mqXBeRJYdpE2hhBXaeBunla8S
         I72IlYCFb+csiRhsLWfgxwNZMSdjXSscCiM15u8geWMG7Oj7zlRfIHpIr1t3XYZmEBff
         WsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772828534; x=1773433334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=gTXPYUD1686iT6dRhcWSX6W2Lnb4yKe9SSLcr3ONB15PPXP4d1cZM8M+FQR8PbkXTx
         o8SOBycXgB2v/CH5JJm+n2TwIjrhcmYK/aCpxEx+zl4if0tTUbz9sreL+TL7KyiO6Xny
         Wdv5qj2n6BzTE1lvz0kcG7Ab1Vt61Tzxntd9RtTtwTZV4hKhrECLD7cAbwICR2zgk/YF
         wEjtlxB3jCF+P7I+hExr5oPoVkvbtkLKmAn7rHBtZ2lvD92KJaLgmjoXLLnAToboY+Qb
         GJTsPFC7kWvqM3x7aRD2+eyCnwO1matmvqyn5+4UAgeXpJZ1if4EtWrRE8ntpnGOEnW9
         /rRA==
X-Forwarded-Encrypted: i=1; AJvYcCVI5Dk6XQ+Q9Td7P8JwT1Yt2BG0W7rxkVHn0GwJztgzoc8LDFQomwTlTYDYCLZI6toleWcwpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZjzadrIvURaQsAifRE8b7SJoFrsJvSi4ygg31nTyacJLgO1xC
	cgqbYPvFTshyMINk3orL0fanlq1zFtDfC33B+edtay4BqDQOck/jsbhZL0GHaUTFyw==
X-Gm-Gg: ATEYQzwsjLZM6e9lgR+wtvue/YeNHqg6fIoOiC3ayfdHiKGyzqg88fbUo2XlfA41+IZ
	Xn3lNFgQ4yTSo2U61g+UxxFdPdM7jlhkDfCa5fRdrDnjfAlFdS5hUR+TYksi9XJ2KCAqU7hZOIe
	wZSJElKJvchF3/JKtBBc/KLH18O9v3nmEva3SZCsyME9WEEFSaYuBjeNzaczDEvIOjbQ6Eq01z4
	IdJTKM8dap1rSjKj3MbcCPayMACNcB+b6M27zk6eQlkUAb7svMFLHKhRUiVb1ALgTvHv9uNS5sb
	AINp4w0d350462ygKsxTbFnDadkzUOKNW/9QgO/KzgDx6+jTet4hEsqO5SR3UIqcqmAY6zcqxLy
	FH6r1bMBUkRT8ssC1zq4Y1YGV2VWQP3wkhMVqkv3kr8F9iaiJJ17fUEh+p7uSXyj4SrnweLRI9Q
	0+HK1mYF+U9v8ao5JP0qeOYT8sptthkhZERUJMnjmoZYfZOqIOBhWpafOzana5ZA==
X-Received: by 2002:a17:902:e84b:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2ae8ad1ceb3mr443415ad.10.1772828533274;
        Fri, 06 Mar 2026 12:22:13 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7837bsm28280845ad.48.2026.03.06.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:22:12 -0800 (PST)
Date: Fri, 6 Mar 2026 20:22:08 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aas0dLwKmZyL_iOL@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306200321.GN1651202@nvidia.com>

On Fri, Mar 06, 2026 at 04:03:21PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:59:33PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> > > On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > > > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > > > invalidation timeout is a generic challenge across all IOMMU
>> > > > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > > > IOMMU drivers could benefit?
>> > > >
>> > > > I think yes, for parts, but the driver itself has to do something deep
>> > > > inside it's invalidation to allow the flush to complete without
>> > > > exposing the system to memory corruption - meaning it has to block
>> > > > translated requests before completing the flush
>> > >
>> > > Yes and currently the underlying drivers have software timeouts
>> > > (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> > > before the actual ATC invalidation timeout occurs. Do you think maybe
>> > > the timeout needs to be propagated to the caller (flush callback) so the
>> > > memory/IOVA is not allocated to something else?
>> >
>> > No, definitely not, that's basically impossible, so many callers just
>> > can't handle such an idea, and you can't ever fully recover from such
>> > a thing.
>> >
>>
>> Agreed.
>> > > Or blocking translated requests for such devices should be enough?
>> >
>> > Yes, we have to fence the hardware and then allow the existing SW
>> > stack to continue without any fear of UAF from the broken HW.
>>
>> And this applies to software timeout also I think, since both have same
>> end result.
>
>Any situation where the ATC flush doesn't get a positive response from
>the HW must fence the HW before continuing to avoid UAF bugs.
>
>Obviously today we just succeed the flush anyhow and hope for the
>best, and I think that is a good starting point for VT-d. We need at
>least that to build anything more complex on to.
>
>Fencing the device also has to come with a full RAS flow to eventually
>unfence it, so I wouldn't do it in isolation.

But do you think doing the timeout logic without fencing would be good
enough? Currently VT-d blocks itself, until it gets an Invalidation
Timeout from HW, and system ends up in a hardlockup since interrupts are
disabled.

Are you concerned that if fencing is done without an RAS flow, the
device might not be able to detect the failure (if it really needs ATS
to work)?

I am thinking, we can do translated fence and timeout change for VT-d.
And the device can use existing RAS mechanism to recover itself. This
way we atleast make sure that caller of flush can reuse the memory/IOVAs
without UAFs.
>
>I would like the unfence to be done with a fresh domain attach (or
>re-attach I guess) that just rewrites the context entry with the
>correct one.

Agreed.
>
>For VT-d that probably also means it will need all the domain attach
>fixing we've talked about as a precondition too.
>
>Jason
