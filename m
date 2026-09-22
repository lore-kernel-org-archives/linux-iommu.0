Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEC441600;
	Tue, 22 Sep 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067252; cv=none; b=s5WQT19jlSnhD3ShFbUnqwMnnDS5pmr+GyWOMBDyFz2gTaDnS8zlcbs5s4Gs6QRuf+gnAqeU4CsFPbVohqAdjR68Qn1lNHWgV9nNg3SXY/DnuyfG1dvlibcR7Ry3ftXyoqaU7JKwjHJe2nF39Y3JuniZ9n0rct7UJMK8HFl8gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067252; c=relaxed/simple;
	bh=YLzEa2NgKc01BCihyFFvuyxmNzf4DGeagOdMFCmVpEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VyxB1Xa9eprKAhka4NbYbSYqrbC90x+ooyIPrSASAZ62K2JVyVX6Ex6FtVelVbj82ZD2Mg5aWKuz6+EQbqT7x9KGgXIYcLxumg3eZEFDBIHBaPPscBP7e89XI1JKwEfBeHFG4cLOyGlkp1QO2os5rH8fut919YAMc4jTILzoIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZBhPXfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZBhPXfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A301F000FF;
	Tue, 22 Sep 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067250;
	bh=YLzEa2NgKc01BCihyFFvuyxmNzf4DGeagOdMFCmVpEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZBhPXfeygiiU2f/pWtXEIFzdO1vnHyv9utcEzx5sCi5XdKNrN9kNs6QgfMYMO2cl
	 JHdWSJG6JobZ2aIXM0UrxDOm/Nhuzxt9hTmfLApAHw2EqHRBVimWQRaS9tAfMLmfD6
	 A28ePCpBvIfXoIdtIPyuQ1qyX5YDEPfFQzjLOLakzjCh9L9y9ITyD/W6GuRURRZhn3
	 HG3zRcy7T1ZQr4VDjrCo+Vw8XsWqteTMKv/qE9J+UYlygb4nz3aKGuC3N0t5mEbeA7
	 DD7oe4nIcp45NiurQv8bVw4Z4TwyviX22YWABtkICBG7pYIyGUvp/BPbFddhgrwRa8
	 cftqB5tqV8T7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] of: reserved_mem: add dumpable flag to opt-in
 vmcore
Reply-To: sashiko-reviews@lists.linux.dev
To: robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, m.szyprowski@samsung.com
Cc: mingo@redhat.com, saravanak@kernel.org, pjw@kernel.org, linux-riscv@lists.infradead.org, pasha.tatashin@soleen.com, kernel@xen0n.name, iommu@lists.linux.dev, ruirui.yang@linux.dev, tglx@kernel.org, devicetree@vger.kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com, dave.hansen@linux.intel.com, loongarch@lists.linux.dev, robin.murphy@arm.com, linux-kernel@vger.kernel.org, bp@alien8.de, pratyush@kernel.org, alex@ghiti.fr, chenhuacai@kernel.org, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, linux-mm@kvack.org, kexec@lists.infradead.org, mark.rutland@arm.com, x86@kernel.org, akpm@linux-foundation.org, conor+dt@kernel.org, will@kernel.org
In-Reply-To: <20260922084256.1515554-7-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-7-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:54:08 +0000
Message-Id: <20260922085409.18A301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Add a 'dumpable' flag to struct reserved_mem to decide whether a
> reserved area should be included in the kdump vmcore. Non-dumpable
> regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
> in memblock, keeping the arch kdump code independent of the DT API.
>=20
> Most reserved regions are owned by devices and do not contain data
> useful for kernel crash analysis, so dumpable default to false.
> Reusable CMA regions are different: their pages are handed back to the
> buddy allocator and may contain key data for crash analysis, so set
> dumpable to true in rmem_cma_setup().
>=20
> The dumpable flag is also used to check /memreserve/ entries for overlap
> with other dumpable regions.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D6

