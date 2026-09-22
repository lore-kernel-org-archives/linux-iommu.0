Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0043DEB8;
	Tue, 22 Sep 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067594; cv=none; b=QVW8tqOcZ2bCMbM0fNUFSQ7cDSEkZDwpF603s+Jv8O1IuGufeN/aVg8XmONINj1QNkj39DEf429Wyna5nOg20+cs4tQMWhwzPrryq0P9QkywvLFes1/BEcmoFk0+YUpFGBHk8ynT3Dy+/YT6vwG2hu9xl3FLmbQYXKVxfzIPtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067594; c=relaxed/simple;
	bh=+cpSLdx5G86GAiYEa1KiKUdyGr9Hwx+hUdwakbZPe5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lYWBw0o5MZ88ejk5XOYXmJ1RKDgh35YHHgWbBvgsaKmLaEIWc00LmXv5z6ur+hO85k9mTI2MI3Osxz14DPmLGmIjFrzrD6nrZR4FFAwi/ZvHRH3ls0o8kc9zsUlFi/7Qz16xT9zdL6jjPnqEksS/SKVopc4mRYjkaiYvubxL3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izvJYf3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izvJYf3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB051F000FF;
	Tue, 22 Sep 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067593;
	bh=+cpSLdx5G86GAiYEa1KiKUdyGr9Hwx+hUdwakbZPe5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izvJYf3wx7OMx8dtyK2bPgV4goHzPpSwGkfqbgOp88Z2f384iep3os6cqHBe6ioCo
	 IipTl+Y06tX741Ho3LXMdE8qTZBy6i3kW/AG2fyAak47hFXgIbhMztEc/AjEfWJ3gO
	 tR/TutUOUAWlWalvbKQpWlAlEN8YL3e5y5N7pjthg/ab5xsU3bbMXVoOIgsjkQruj1
	 OyekninqCRr4y32dIPdT5Bd+44BDIJNM8eGAdEaSR4P5Xn3uC66ReBLFcE1ilJjyVa
	 Vp4PDuJDDdxPnmrmh8vGIIpx5tDJkTvYEYN2OU5Kmw3iEXQ1oXLsmHDVUD/8g0E2hX
	 zd2wbQtt6yspg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] riscv: build crash_mem ranges from memblock
 instead of resource tree
Reply-To: sashiko-reviews@lists.linux.dev
To: robh@kernel.org, rppt@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, baoquan.he@linux.dev, m.szyprowski@samsung.com
Cc: pasha.tatashin@soleen.com, aou@eecs.berkeley.edu, linux-mm@kvack.org, conor+dt@kernel.org, mark.rutland@arm.com, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, bp@alien8.de, catalin.marinas@arm.com, mingo@redhat.com, ruirui.yang@linux.dev, iommu@lists.linux.dev, kexec@lists.infradead.org, saravanak@kernel.org, pjw@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, alex@ghiti.fr, chenhuacai@kernel.org, x86@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kernel@xen0n.name, will@kernel.org, palmer@dabbelt.com, pratyush@kernel.org, tglx@kernel.org
In-Reply-To: <20260922084256.1515554-2-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:59:51 +0000
Message-Id: <20260922085951.DAB051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
>=20
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D1

