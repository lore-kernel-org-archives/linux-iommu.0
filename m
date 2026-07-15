Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB83CB2CF
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150440; cv=none; b=QQkafGhpwMDIQBZmVQTv+Xn0UNlW4v/Eynf7WSFVdkYsUC5kWUSp/AiyyZLpft85I+n572ABeHMVSy0wMSN4djRDitoaJRqD4DNydDgC1YB0GIsvwtast/WKYHxZJ44xNkDgxP7hJxnmJTLzqweHSttXfK0BodwUA3SNctijLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150440; c=relaxed/simple;
	bh=JF5L/01d+U8TRMfJr4PhJNK5TqgM6rTRPXGecgTdUnI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL3qgMYdGxxrJtFl0ZQYt1eNW1htWXzaCgi91kPxsUl/iRoKyICs/Vw7c89tIXqr1IjTu8Y10FJESySsqq8bTvlanXMgf8nQQnTBvqG6QslrkLZ464781bhqoNznOhE5DXNZmM4geGKxVuh8ATztwDpL2c8nhkyLPm1z81RmlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=eLfH487C; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="eLfH487C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1784150430; x=1784409630;
	bh=H/ZH1jIZHpyF6Chr6IwVrkgx+DUg//7CYU1Mql7/Q+g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eLfH487CKb7X4ejAlG4rJcMZcoOHh9r1rFJs9nZFNSgD8d7kk5+xT3GVL3LDkyRO/
	 YZYf7pnVXDhVT1tiCSh1G7C/FTK30aKkrW8I062/W6Df0u43YG4CHrL9+6AMfP3Yuc
	 rpgDGLouMXPyjZo+k5xeyC3O8AyL0PV3IsCVe0m2uk4WE35BXBNSYqyvGIuDNSA+WV
	 lUGBWpLPM2eGHZC+kN7XFe/STG5ZCGZ696pxRHolGN7hgqqQwQ0YE5T5rnbNc+/ruc
	 bns7IVPeLdB+AEgKSZD8N55HoHDwHXw4xETnmHKpCRRYJOz31Qft7F84SdUU0MBvS9
	 MRF5y8bQFKGpw==
Date: Wed, 15 Jul 2026 21:20:23 +0000
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: 70sp <70sp@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "regressions@leemhuis.info" <regressions@leemhuis.info>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <X7nc9tQqVxmuR76GYNJnMRkqUTwNVlXTWpH0wGvJeiAHlcLaibPZHRN037p0359GpdmopB_wI2tF2x6EqZF4oY9J697tcTGYwfYMK96FcUs=@protonmail.com>
In-Reply-To: <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com> <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com> <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com> <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com> <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: d0f33c660aa3b72aef5ea1abbea21fda3d488817
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

this regression thread became abandoned unfortunately.

In case there's anybody who would like to help me (or generally) solve this=
 regression, I am sending all information about what I've found out.

I had a private conversation with Lu Baolu regarding this issue and we foun=
d out several new facts about this. I am currently working on creating and =
testing my own patches to add backward compatibility for hardware affecting=
 this issue with my limited knowledge of C and IOMMU.

This issue consists of improper GPU passthrough into VM on a specific platf=
orm (Haswell) or a specific GPU (NVIDIA Maxwell - GTX 970). I personally be=
lieve (could be incorrect), that it is caused by the GPU being too old and =
becoming unsupported by referenced commits. The GPU doesn't seem to be usin=
g all levels of PTE properly and some data need to be trimmed for proper pa=
ssthrough but the patches seem to remove (or alter) the trimming functional=
ity.

The issue is caused by one of these commits:
a98db518dde246e01ead53617dc0a30d6aaa3752
c376a3456d8bef43ec556a98c0a04c35086c2737

The IOMMU code changed a lot since these commits were merged.

With IOMMU DebugFS enabled these messages appear in dmesg on affected kerne=
ls:
[  107.365019] DMAR: DRHD: handling fault status reg 3
[  107.365021] DMAR: [DMA Read NO_PASID] Request device [01:00.0] fault add=
r 0x37fff1000 [fault reason 0x0c] non-zero reserved fields in PTE
[  107.365023] DMAR: Dump dmar1 table entries for IOVA 0x37fff1000
[  107.365024] DMAR: root entry: 0x00000004034fc001
[  107.365025] DMAR: context entry: hi 0x0000000000000202, low 0x000000008b=
da5001
[  107.365026] DMAR: pte level: 4, pte value: 0x00000000846ce403
[  107.365027] DMAR: pte level: 3, pte value: 0x00000003c0000883

I would be grateful for any useful information or help so I can finally for=
get about this and freely use newer kernels. I also know that there are sev=
eral other people experiencing this issue, and I would be happy if we solve=
d this for everybody affected.

Thanks to everybody,
70sp
