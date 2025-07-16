Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60E2F530A
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670407; cv=none; b=BneMXYxIDm897C0tbQ61tZktiDSm1w/sqhHnV0waQ3NO71/W+7o3T4fq63qnfgXHkjSq0ZAzOzA4kNf/gWEXBwrfVy7n5jk+rwGn38au4cOwsFW5dO8CNzymWg8MmO7t5OYA7ECq/9cUQY0IY048KZ+y91HhJg96RaFWER5+K+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670407; c=relaxed/simple;
	bh=QdOz3tEAWNuTxCkKzW2JpxBybTK05dRLcUPqaukQNAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsUkYAAD3lbLdvrD67ywuhlqtn29YTbqGeAQeZldwt0ZZAAUMKSdwcRl0Jqyp4Fl8AjCB1QNCVodmDMOg9L2ceuQeuv5w9lUZpfgLklLpWgREqsB/x0vCnP1czQ3HLAU+S3Q0+TDCRxbXyQD79yLEgeim4UtGePRcC9jYmXNNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLfqm2fY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLfqm2fY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB4FC4CEFA
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670406;
	bh=QdOz3tEAWNuTxCkKzW2JpxBybTK05dRLcUPqaukQNAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VLfqm2fYUUiNuJ2HHl4dGIFcy0P3hB9I7K79gPZZcmVHwoM4jhQ04vwYyJccxwAhA
	 tbDHacL0Hwn04oxVDPVSpwqZwJvbBMMJQjCqLdvmqyJYiBWFInmThgm5mrc8pMQZec
	 p5TbMwFkJfU4bBkZBiBZAjD5SMPW2BXaQ9g+uFupBMJZfTVNztel3FRFhwnFj7ljNH
	 WM579yDFT8EVa5eTan9iheP8+XG4PZ5bLrPYYlX9Ks0ILa9S68SxlTW7LhOkf9oW1q
	 Skofol6T13wblBBdvpsVmIef5wlR83XbuS9+++89uheDVEa+kTT5y1P8KDl91zWtBY
	 6Al3dXzz6WobQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so3636155fac.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 05:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkusqPWJJE66VV5ZT+h3BTeFpoMHVBhfnG7vxTQefoqKn+XvVpQHlEM36y8EJkXHLNSf4wKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhtD5JnHc9w9WsmM02JOLe9ixTGp4hdzUD94DiinJvuUsoGOym
	fGJMFexbBkoOmYVrwPUysWBUcl6ZMRdSYGQRI7O13SBiNw512VGpdJB1AOzGIOtfPn1cHgBUT4x
	LlfkDtWjFCKVqGMa8je5R5JtSQfMcjAc=
X-Google-Smtp-Source: AGHT+IEZgdEV21lLoMS6cza5OTBftzq1imyRKZ4PP8LnvZsZ4uNFrv6GL3J1hel83DNMeKfQcpaqBIn3eNTBo2/IcX0=
X-Received: by 2002:a05:6871:741a:b0:2f3:4720:f7ca with SMTP id
 586e51a60fabf-2ffaf265e3dmr2524778fac.2.1752670405778; Wed, 16 Jul 2025
 05:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com> <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com> <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com> <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
 <aG-BC6B4R1ViEDM1@google.com> <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
 <aHDlhyPmjCT7rz-i@google.com> <CAE2F3rAPB8rVz38ygAxatdAunS9oMNJ5WvMiB+M8Am71MEHVVQ@mail.gmail.com>
In-Reply-To: <CAE2F3rAPB8rVz38ygAxatdAunS9oMNJ5WvMiB+M8Am71MEHVVQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 14:53:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gO8jDeEF84hdqhhd2U9dT78YYikQR_RW3Re1R2DKTS0g@mail.gmail.com>
X-Gm-Features: Ac12FXycSIRwdxtnsW3LAjXenyk-kclhyYRVZahkTHWsTVp2AI04aqYcZWKihH4
Message-ID: <CAJZ5v0gO8jDeEF84hdqhhd2U9dT78YYikQR_RW3Re1R2DKTS0g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
To: Daniel Mentz <danielmentz@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:52=E2=80=AFAM Daniel Mentz <danielmentz@google.co=
m> wrote:
>
> I think the underlying problem is that we need certainty as to whether
> SMMU is enabled or disabled, and if we find it in either
> RPM_SUSPENDING or RPM_RESUMING state, then we don't have this
> certainty.

Right.

Holding power.lock at that point can only defer the subsequent runtime
PM status change, but the actual state of the device is not actually
known.

> Creating certainty would require waiting for an in-progress
> rpm suspend or resume operation to finish which we can't do, because
> iommu_map and iommu_unmap can be called from atomic context where we
> wouldn't be able to wait.
>
> Before discussing suitable approaches, I think we need to agree on the
> requirements. After our discussion with Will, I believe the
> requirements are as follows:
>
> We can elide i.e. skip TLB invalidations only when SMMU is either
> disabled or powered off.
>
> At any time and even in the absence of any client transactions, SMMU
> can perform speculative translation table walks and cache the results.
> In particular, Will provided the following example (I hope I'm
> depicting this correctly here):
>
> In __arm_lpae_unmap() where it says "/* Also flush any partial walks
> */", we skip over io_pgtable_tlb_flush_walk() and subsequently free
> the page table in __arm_lpae_free_pgtable(). The memory location that
> previously contained the page table is then re-allocated for some
> different and unrelated purpose while the SMMU hardware still stores a
> pointer to this memory location in its walk cache due to the driver
> previously skipping the TLBI command. SMMU might then perform a
> speculative translation table walk and misinterpret the new data as a
> table descriptor which includes a pointer to a next level translation
> table (i.e. use-after-free). SMMU could then follow that garbage
> pointer and read from an unpredictable location. If this unpredictable
> location turns out to be read sensitive like an interrupt acknowledge
> register, we might potentially end up with very subtle types of
> misbehavior.
>
> Due to these requirements, I believe the following approach will *not* wo=
rk:
> Elide TLBI commands when device is in RPM_RESUMING state: While in
> this state, SMMU could already be enabled and perform speculative
> translation table walks.
> Elide TLBI commands when device is in RPM_SUSPENDING state: While in
> this state, SMMU could still be enabled, perform speculative
> translation table walks and run in to the use-after-free situation
> described earlier
>
> I propose a custom synchronization mechanism where we use a spinlock
> protected variable that determines whether SMMU is enabled or
> disabled. In the suspend/resume callbacks, we disable or enable SMMU
> and update this variable while holding the spinlock. In the map/unmap
> path we briefly grab the spinlock while examining this new variable.
> Only if we find that SMMU is disabled, we elide TLBI commands.

That sounds reasonable to me in principle.

> My concern with this, though, is that the additional spinlock might
> spoil the performance gains of the lockless command queue insertion
> algorithm.

It might, but it is hard to say upfront.
