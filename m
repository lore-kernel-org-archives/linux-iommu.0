Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F12522F0C;
	Tue, 22 Sep 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067789; cv=none; b=WQAv7Xb//iLQM8xFiM5P1vd5ANFQMevUxFBzwrqnr4OhX/D08130Pb2tj1k4BrkMdw8vI//tUhRyB++sa301Y1CR/+EnDqIo5pblveeT8QL59giA1H4utvkq2gYx5yhBa0nIvqwjQskjMJjccpKPKuYehYTsZDBYGq7SvGWF798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067789; c=relaxed/simple;
	bh=pHgvoHnJIwe3nC5S4OY8z28uWVR9gAOlu7YWol56jKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RftEVpUc62UdVL8z5DscQYtPMxlRwu2CgPBYIPxAct5aNFDkuJBhTH0WMbl+KNt64p/cDb/QtvB4kYfRD90Q/dx425woPlU29LMWlnlV5oBXH9mXhWmEjiL62F1fY3Clm0RmSkHJSjNQeAQDxw+WDeJulBbjqKqJROSpXeLhXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+JOE4ry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+JOE4ry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542831F000FF;
	Tue, 22 Sep 2026 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067788;
	bh=pHgvoHnJIwe3nC5S4OY8z28uWVR9gAOlu7YWol56jKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+JOE4ryLKIP3w9q5Wm7pSG1JLgmDJMTih9bWxagWnLP0XhQLvugLdVxdO/i7BZ1b
	 uvX39GjRiLtbNCtIwl6kbzM07pHvNRM7sLWrfKdwu5cRDBDhhUW14JQEPxQgJCJcpo
	 zteqI1bXRF1+ErMo/W206HGKtuTl5xYGFoYzr8R+VyzOeETVbKARobUvCKiqV/1H5G
	 ZG2bS7BFom8VmX+m2cO+RlPZM8u/HRlPHtdDSKYxDCuUCo7GUN/ZasJtPMbhOvS5BW
	 mJMwC/BAeODqKEf4NJtp6Oe/JkjP/uh/PV3O0rpjhB5shaJzPxmBPBVxFXQ+Q6GbJt
	 r1KqQABQ7lA/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] crash_core: serialize crash header preparation
 against hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: m.szyprowski@samsung.com, "Wandun Chen" <chenwandun1@gmail.com>, baoquan.he@linux.dev, robh@kernel.org, rppt@kernel.org
Cc: devicetree@vger.kernel.org, ruirui.yang@linux.dev, linux-arm-kernel@lists.infradead.org, alex@ghiti.fr, pjw@kernel.org, tglx@kernel.org, aou@eecs.berkeley.edu, bp@alien8.de, hpa@zytor.com, akpm@linux-foundation.org, mingo@redhat.com, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, saravanak@kernel.org, x86@kernel.org, will@kernel.org, kexec@lists.infradead.org, linux-riscv@lists.infradead.org, linux-mm@kvack.org, chenhuacai@kernel.org, iommu@lists.linux.dev, mark.rutland@arm.com, loongarch@lists.linux.dev, robin.murphy@arm.com, kernel@xen0n.name, pratyush@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com, conor+dt@kernel.org, pasha.tatashin@soleen.com
In-Reply-To: <20260922084256.1515554-4-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-4-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:03:05 +0000
Message-Id: <20260922090306.542831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> crash_prepare_headers() counts memory ranges before populating the
> allocated crash_mem array. The weak implementation used by ARM64,
> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
> two-pass operation over system RAM resources. Concurrent memory hotplug
> can change range source between the two walks and make the populate
> pass overflow cmem->ranges.
>=20
> Take device_hotplug_lock when preparing crash headers during
> kexec_file_load(). The x86 memory hotplug path already takes
> device_hotplug_lock, so call __crash_prepare_headers() directly
> to avoid recursive locking.
>=20
> Sashiko reported this issue in [1].
>=20
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system =
call")
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D3

