Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D8279911
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861340; cv=none; b=W8/hoELyYMz8Xc16t6ILqgxvvVqhjn80yydRkrM8lxEGL+k5HPOATKT7GZughmmrMClOnVD28Jy3xpehBCUKQsFmo54ye2u21QEEbluQmQFu9iQIOpiegrTfELdIfcMMFCDAquCbK5n4Ge5Bkn7j1osDHPTC+HrWjiurKCCx1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861340; c=relaxed/simple;
	bh=hvj8x3HVmp9P+1p1D0eDo1pbK3RjBLaMP05027S3Y0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt3hQcQ57pAdPi8fQVnWBVhLY/pjVw8ou5hNHIndXdbIs9RXAjXOHk9HEgWTm3XSim0TVLMwcVHEIaBanS52fn5/Z4varY8xMHPT28gR2+8YAf555e/EGSId2YP62pA5ot1XN4wq0/Iqx1mp/ilFMmyOvTzi7/mTxPnfKrKHQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaBN/XtW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaBN/XtW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240aad70f2so15585ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745861338; x=1746466138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0r7+wCllJmaKxCe01hHV/d2aOrZfvhrAsuNMyHCgYc=;
        b=zaBN/XtWQQ8O2zKJUMkuAhCYqOxBjopEQdXBG6lnc+ENsRWmHlR/sf0/TRDLKCbB9U
         gZm0MDLzOBHlkSQsRpILV9Kpv26xYRljtWQTD6Dgs/rMD0A+4PZ0csBDN5BcGUqWLYty
         29iQpsKQPsH7r3xl3XFjG74r+oOeo2o26gXseLgI9uhC8atdli3lVFxWFnM73OKEwD/U
         Gz+B7XLpRSzJZJmEY/WlkYVgeMhI43p5GL5SoiHeDprcx+f+bkfGfxgLKylSlf+Uzcsf
         R/N6v545gWu+vlG6E39xnYWqmIR5qlQYYCAE4pyhsKgPZQH5Nw/RANDII2TNT46tdvL9
         k6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861338; x=1746466138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0r7+wCllJmaKxCe01hHV/d2aOrZfvhrAsuNMyHCgYc=;
        b=Sa4iIc8DSd9Js7ksfj/aUHsf0B2Ks4PQ7Gs50zuLzVJD1PqNgXx0JpluOAgRLde/HF
         ZP74j6Hz+b4uwQmUNGi7FFRsehTXyFdM2u1gut3Ish7taEncPQ9aw0wBRjYoihBAIQLG
         Jqvsq3OyRm2SYR1Z44V3Hii8UqZEVBh5FrF6BE6tUPFz3VteWmqLnf2CzNNJSBsaVtDR
         CD6Adf0TYYXMJaILjAr4s0+4ggtXAC9SlxI5NHoAKNb9xJnlj0GB97bMDnFa2Iqf02s2
         t9BPaWVllgc90Y7cndgLw3jcTvBD7iyEXFpcItEccDdx/Dc7hGpeygJ4wFHn/0dSACz/
         0wEw==
X-Forwarded-Encrypted: i=1; AJvYcCV1EQW4ERF9NTLMUyLURgr+NFep67o1kDzQHZnDcyBFuzNbWjM6pLOdi3tU+PckzQy/ewFwRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNxAjhs+2L70F1N/xo/GQ3Waa+CS4rWhcEKqGpxroZejTR+IwK
	rclkbRDp5DqvJhz+tj2JpuUz9tRcT1f30TcRDC6/4uSLimnmua8E9DXWXG7+rw==
X-Gm-Gg: ASbGncupRS0RFBH/M4kHPsdF0wPBclBuzrD53AeB2mP/uOwZfDe1BlNQ8Kojc2COZnJ
	Wf0SZ6gx3PKZ9J+LAdiw3bwNWegZbZ0EGZunZrlYkr3DS1NEUN58cKEmY/SAT+8mkBngMrN70yk
	BTFglRY5elDc8vEhbqYTZlcmkKdV0w2Hq6xmM8grI6KZuO4nc+l9bVqfYrgqJwaf//S0IjEknLX
	qZsDyXjZIrKDJ7gbHlZmVbOWned4iLioue0+RyjpnHM/WiUII3q0sZmx641lAW5bQjJqUn9iGsf
	gk8qZqAfE3J0/D1zmamUdiRROxmrYhB3TeA72MAIk4ODZQq5jCJioRsb62u6PtuCr5zVYogD
X-Google-Smtp-Source: AGHT+IFvvbXqVLW7M7K4eTP2s1tq5nZj/xJsE94cw7osWMiH1XhKOhdmN98bqT0YcPcDS66bSCITtg==
X-Received: by 2002:a17:902:ea01:b0:21f:2ded:bfa0 with SMTP id d9443c01a7336-22de586f035mr708455ad.25.1745861337961;
        Mon, 28 Apr 2025 10:28:57 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef061bccsm9296497a91.18.2025.04.28.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:28:57 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:28:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 02/22] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
Message-ID: <aA-6zlZNQ6NsrUqw@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
 <e569c927-65ff-4c0f-8922-45e404fefc5e@linux.intel.com>
 <aA+4mRrGuUnpG/dB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA+4mRrGuUnpG/dB@Asurada-Nvidia>

On Mon, Apr 28, 2025 at 10:19:21AM -0700, Nicolin Chen wrote:
> On Sun, Apr 27, 2025 at 02:31:54PM +0800, Baolu Lu wrote:
> > On 4/26/25 13:57, Nicolin Chen wrote:
> > > The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
> > > data structure from user space via iommufd, so add a user_data to the op.
> > > 
> > > Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> > > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > 
> > It would be better to add some words explaining what kind of user data
> > can be passed when allocating a vIOMMU object and the reason why this
> > might be necessary.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Sure. Will do something like this:
> 
> The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
> of its virtual command queue HW resources exclusively. This requires user
> space to mmap the corresponding MMIO page from kernel space for direct HW
> control.
> 
> To forward the mmap info (vm_pgoff and size), iommufd should add a driver
> specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
> to output the info (during the allocation) back to user space.
> 
> Similar to the existing ioctls and their IOMMU handlers, add a user_data
> to viommu_alloc op to bridge between iommufd and drivers.
> 

Ack, with this change (addressing Lu's nit).

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin
