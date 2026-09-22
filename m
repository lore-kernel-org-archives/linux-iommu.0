Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF97526ABA;
	Tue, 22 Sep 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067421; cv=none; b=HI6dgBMU5nfnQZ88YvWice4zAnCj42BeNOxROsuJQsWvvS/jI3fD6tKEbAULKwNsoMyijeDqz994IAnUqh9gAXsiJHt/dzio17+x8y6qcp1fzj1mLpd8vU3VOuof3rPfARMWuM3WMWKw2Dkvi/ja/NUf4M8sMF/2c39waB7K8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067421; c=relaxed/simple;
	bh=mB6ArwwQWi63lnnyZnmc+lp1xXlr6Q+TPr+ON6lhHYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rHoyM5xsNXOT+7wVuE3iIVh5pOW+QGsn29tcC/319yjJTVOVDKRJP4pgZ4NxY/tjtJ7Mz6HqLRi7DhjWP/1KYbpu3HLIxs2kLSFTZp7Vl8AEJyosyC9oQZkR7olDcMSPNWt2GAEHYjH//dNG8n5sHkvqnX6fsN7jArE7IDmg+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNL3Xnb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNL3Xnb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B61F000FF;
	Tue, 22 Sep 2026 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067419;
	bh=mB6ArwwQWi63lnnyZnmc+lp1xXlr6Q+TPr+ON6lhHYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNL3Xnb6CWnvvGBDK0J3Mn0L4qOeZ5nvv4L3x8jvkBkxrp+xGTSpgMrYwk4JgC2qV
	 9snp/rxfK9DTTpliyaHgkmJRoQKO6yZng3MZ6TCOmCZ58SkJbHD1AciwzYV1jmDP9T
	 weoFRPO5s+q4kbuS/2JkjIJQyufgbbc2Rqghndy+dE0HSygszhyyhX8NNsmW9OjjAj
	 q+tsmsriKvocNa9XHt90euPbTjKxci4T0s7RA5tQyjpgnP73fjR4Hujl2c4Pj+FV14
	 8I9/nRiLjvKtECSEKKdVfBZYG4utyvcEnX34gjuFlutbaLSf/Zs2/9fYZO95zimVOh
	 hT83kc73npLCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: robh@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, rppt@kernel.org, baoquan.he@linux.dev, m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, ruirui.yang@linux.dev, loongarch@lists.linux.dev, tglx@kernel.org, mingo@redhat.com, saravanak@kernel.org, iommu@lists.linux.dev, pratyush@kernel.org, conor+dt@kernel.org, dave.hansen@linux.intel.com, chenhuacai@kernel.org, aou@eecs.berkeley.edu, pjw@kernel.org, linux-arm-kernel@lists.infradead.org, pasha.tatashin@soleen.com, x86@kernel.org, akpm@linux-foundation.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, hpa@zytor.com, palmer@dabbelt.com, alex@ghiti.fr, mark.rutland@arm.com, will@kernel.org, kernel@xen0n.name, catalin.marinas@arm.com, bp@alien8.de, robin.murphy@arm.com, linux-mm@kvack.org, devicetree@vger.kernel.org
In-Reply-To: <20260922084256.1515554-5-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:56:58 +0000
Message-Id: <20260922085658.6D2B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D4

