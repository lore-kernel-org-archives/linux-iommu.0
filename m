Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795653217;
	b=SyaNwuZdeXcb+0tfihr1beRcGT6JdS66InoNgKqvkTt8z0Ntnu4HrFv4hvTVtIZzYXvt
	 uokQSZkhNcg3NOi/7PooBJHkBQRqEgAsyQoUSeRUYwFTF47YHq7OoryUezfFbWnic7kBU
	 GQJryZj8RMz/Ba0txsaoPWhnIvPFQ7J9abrMZ28hwCF/hH1x6mi2rBKgHE0abuoTkyXOD
	 Csd1t62xxTjdmnKrKNTcUlVD+gkoZ1sA366U1LmVnHuYMtYkhZVAGAgcR6giQ3A1U5aON
	 OrKt6EBrnxLPCOFfyKB5ApBRXvbiokKUH95+jNbAZsepg1qpnP2BzT9B8h4I31WbFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
	b=QU23qsvoVsR2X0BQo2RJWylK6+1qTiicrFfAbQnxK0wdzkPoxbRxxyYbGF5U/3q/MYwu
	 iKvPGc8s07BF7TSKpL4bIxcukrziskXaYQjOyHhXL/fa+kG6zs4B1FqZ/zGVaT2CcDuFP
	 UYaxz2udSR9Quv7Xb6EdfavMa3NS/LW8aPXzLuVu2dF2u2KkF/khb2iSiGgV8MIMjWHzG
	 1Q7WYd3fGAAx0EetYBtVNWIIlQMGLKUtnv21uH68Blr6K5DMKrNAMsY1de1l3oNfaG93T
	 OZYlEWsuTV1oduwSHT/5pVFOcR9UpqMhRqFLB7hboZTqYCSRBC9wWny5om0wNABUjbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iFRO19YM;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8109606A326
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 00:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8109606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iFRO19YM
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f046b0adc0so37256675ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 16:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653216; x=1796258016; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
        b=iFRO19YM0Tac6Z6LV7kSliffCwl7Wx3vJoLJZOieP0XvlvGjpo+/U0MtrxGYrfKGT8
         wSddWer8b4w8l1PhNc9lWuqySjNEYFrM4GYRDwRpBS7VXF3Lw6IRLINuHM6xp5k8oR4G
         V/ZxWzEZgQbVE+sHCG0rtXUVj7W4Oq1VmrTI5d7eqFFMJZrp5P5K/A0pldZTBiXz7RFt
         Y7+4PiSlG8MP84tZdT0Tp4Tr0wofdntu6F4h6S8C7KPy8RBUUxeE/lO01SQ9lryFMMiO
         VVKL7L17u4F60ffIOPIqweEQHnAXGUmlPBZ0u+xQ1rrCmkMWN7WmMI8JgQdrYRYSUoMV
         eRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653216; x=1796258016;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
        b=r/sbNNNtWBxOjSHhun2RoqwWRPTeSpTxHXwjZ7Q2QjjGCYfGx6FgqgiEi1xoWVpviQ
         shUwHKjZsZJCC0xtfw3k/pV6tEd2QV7qAnlCFUJ2IN8Vbs99dPjwP3rR66Il8UkFXHy3
         CJb9q1SvoQVGojvSuhi5J1pi4hxsp2NMayJ1UTdbVcrCxoIKceU5eax6dJk8f88I9yqZ
         3VwZSDZm+zxdZ+r9Vbc64nU/Cf81K4Rg9KhydrN0+cYL+Z9AUf7rntIAkHkHv3HcUeOy
         SSyQCv+ffyDGYLxliRpsbpvF6Bry786hixb6OR3AnoPuA0cD397SYJwqiyZgk5uKS5KA
         tjEg==
X-Forwarded-Encrypted: i=1; AL+hErE8LcUU/k4PV7HFEP5bsHOY3EIhPpj66TLwJk03U0i509xH7Q2vuxU+gpncVYMezmzvgEJjTQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+WqfZupaFj5yVvkBnAx4oUVTdpAvNEkFrS8PZGtUpF/EKC7P2D
	J5nDlKcI8LuvITC5TM5UaxaZy3EQJ9OY3RfVHGmQs0MctGhVzqP2/J/LvzKQuPNR6w==
X-Gm-Gg: AZFdTZckrnQIHX/Irjxxx7ccYJq+nIUwwDs6Ggt/m/bKNHR1s+a9+8xRm8W0zi6dHMs
	Qb+paTX4lqX+tlUT6cHfKXLu1xbCrlHlyKaiAPyhLxR3uW58AcJhB3eGL2B9vgEjcNOGyW5yccK
	a0OR34Bg4ehyOXvkdabs8H06QrvJChojkCffyakDUpv5X5W+yIQHh49sWsHeucxzb9+o2OpcSi4
	i5bH0itF0ApN02j+stxTFlSVaglCrNrJEGZf+xJklJBwfR4q/N6pMRLPHd6LEQ1NDuCMPZqIXYl
	17K0LFOV9CqDYwJAlryxHpDIkNdHzStal33EATISBVTcGHbmAbngfrxQzcHIWdMcPR2vyEVISQ1
	UcEfalT51+jB7dlsFaXcqZ/42pv4I2+qn85l+li45nUFDjBbjXQshNpvM9GhdlHRowEqVnmOgjp
	qUXpFsAEzLQE8dbmCdcUBlHE3GbXmeV/wS5jTTFzb8ZMC3wfw62AEyQaoG045Wu38N+GHldR4Hq
	S6T6mBRB/lw24VIsvF0pMQ+1Hd/Bn7XFb3D0y0gu4U/jMH2Ckkpp5eV1FEzlJsCKB7LTTDLm/Le
	JNK8RA+SKbdN9ZlHaCSVlcZeYdiibhJovO5sx4jH0y6AywO9YvBJDsFJwspIjTg0
X-Received: by 2002:a17:902:e80b:b0:2e9:9a19:c43 with SMTP id d9443c01a7336-2f03f118277mr192264515ad.15.1795653215229;
        Wed, 25 Nov 2026 16:33:35 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm95165955ad.75.2026.11.25.16.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:33:33 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:33:32 -0800
Message-Id: <DN4PXTY768YS.3I99BQYLC8VXI@google.com>
Cc: "Mostafa Saleh" <smostafa@google.com>, "Daniel Mentz"
 <danielmentz@google.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Logan
 Odell" <loganodell@google.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 7/7] vfio/selftests: Add observability test for IO
 page table usage
From: "David Matlack" <dmatlack@google.com>
To: "Pranjal Shrivastava" <praan@google.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian"
 <kevin.tian@intel.com>, "Alex Williamson" <alex@shazbot.org>, "David
 Matlack" <dmatlack@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>
X-Mailer: aerc 0.21.0
References: <20261001224531.765278-1-praan@google.com>
 <20261001224531.765278-8-praan@google.com>
In-Reply-To: <20261001224531.765278-8-praan@google.com>

On Thu Oct 1, 2026 at 3:45 PM PDT, Pranjal Shrivastava wrote:
> Add a new selftest, vfio_nr_pages_test, to validate the iommu-nr-pages
> fdinfo metric across all IOMMU backends (Type 1 and IOMMUFD native/compat=
).

What's the status of this series? Should we expect another version
(e.g. after the discussion on the shrinker RFC and at LPC)?

nit: Please use "vfio: selftests:" as the shortlog prefix for VFIO
selftests (see Documentation/driver-api/vfio-selftests.rst).

I gave this a try in QEMU with an emulated Intel IOMMU (which uses
generic_pt, so it reports iommu-nr-pages), on top of this series. It
fails in every mode except iommufd, which skips. Details below.

[...]

> +static long read_nr_pages(struct iommu *iommu)
> +{
> +	char path[256];
> +	char line[128];
> +	FILE *f;
> +	long val =3D -1;
> +	int fd =3D iommu->container_fd !=3D -1 ? iommu->container_fd : iommu->i=
ommufd;

In iommufd mode container_fd is 0, not -1, so this reads the fdinfo for
stdin, never finds the key, and the test skips with "iommu-nr-pages not
reported by this IOMMU". libvfio uses a non-zero iommufd to mean
iommufd mode, so:

	int fd =3D iommu->iommufd ? iommu->iommufd : iommu->container_fd;

Also, consider moving this into the VFIO selftests library (lib/iommu.c
and libvfio/iommu.h), e.g. as iommu_nr_pages(), so other tests can use
it and the library can hide which fd to read.

[...]

> +FIXTURE_SETUP(vfio_nr_pages_test)
> +{
> +	self->iommu =3D iommu_init(variant->iommu_mode);
> +	if (!self->iommu)
> +		SKIP(return, "IOMMU mode %s not supported", variant->iommu_mode);
> +
> +	self->device =3D vfio_pci_device_init(device_bdf, self->iommu);
> +	if (!self->device) {
> +		iommu_cleanup(self->iommu);
> +		SKIP(return, "Failed to initialize VFIO device");
> +	}
> +}

iommu_init() and vfio_pci_device_init() assert on failure and never
return NULL, so these checks (and the matching ones in the teardown) can
be dropped. Please follow the setup in the other VFIO selftests, e.g.
vfio_dma_mapping_test.c.

[...]

> +	if (!self->iommu || !self->device)
> +		SKIP(return, "Fixture setup failed");

This can be dropped too. On top of the above, the harness doesn't run
the test body at all if FIXTURE_SETUP() skips or fails.

[...]

> +	/* Map a page at start */
> +	region1.size =3D SZ_4K;
> +	region1.vaddr =3D mmap_reserve(region1.size, region1.size, 0);
> +	ASSERT_NE(MAP_FAILED, region1.vaddr);
> +	region1.iova =3D 0x100000;
> +	iommu_map(self->iommu, &region1);

mmap_reserve() returns a PROT_NONE reservation (it's meant for reserving
aligned virtual address space, e.g. for mapping BARs), so there's
nothing for VFIO or iommufd to pin, and iommu_map() fails with -EFAULT:

  #  RUN           vfio_nr_pages_test.vfio_type1_iommu.sparse_mapping_stick=
y_reclamation ...
  # .../libvfio/iommu.h:42: Assertion Failure
  #   Expression: __iommu_map(iommu, region) =3D=3D 0
  #   Observed: 0xfffffffffffffff2 =3D=3D 0
  #   [errno: 14 - Bad address]

Please mmap() real anonymous memory instead (PROT_READ | PROT_WRITE,
MAP_PRIVATE | MAP_ANONYMOUS). With that and the fd fix above, the test
passes in all 5 modes.

Also, please allocate the IOVAs with iova_allocator rather than
hardcoding them, so the test doesn't trip over reserved IOVA ranges on
other platforms. e.g. allocate SZ_2G and use the start and start +
SZ_1G.

[...]

> +	nr_pages_final =3D read_nr_pages(self->iommu);
> +
> +	/* Page tables should remain allocated */
> +	ASSERT_EQ(nr_pages_final, nr_pages_mapped);

This asserts the behavior that the cover letter describes as the
problem, and that the IO page table shrinker (or the clean(gap) approach
Jason suggested on that thread) is meant to change. The test will break
as soon as empty tables get freed.

I think it would be more useful to check that the accounting tracks the
page table in both directions. e.g. also map and unmap a range that
covers an entire table with a single unmap, which generic_pt frees
today, and check that iommu-nr-pages goes back down. For the sparse
case, ASSERT_GE(nr_pages_final, nr_pages_initial) would still catch
underflow without depending on when tables get freed.
