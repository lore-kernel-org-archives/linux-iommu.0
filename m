Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A44432F2;
	Tue, 22 Sep 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067399; cv=none; b=OnmC7+TYM4RENfm0ZB7P41XEkHJYz3+TPccZ1EH+RIp6m6g4IzaB2zYk7uXZWdglTs4EpivHEEXb1FAZWplyJpBX7vbYMtqGMnJcTWEyWWwHfD7YV8umsJY4A+/wZLFDJ+K1wQY0WJpSgHaZ4/Xln4Ptuk3tlPjUH1Q86tsFWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067399; c=relaxed/simple;
	bh=pTlfKzJ0Vr6DSRpLT6CuScs/v+wf5LCST8fvQa+xTPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LukgZOciic02+mKnUpEwenTzosW5Hq5e6guLon6jKrqS6tl9c4Y4EB8U50tCx4sb+hD5z9WiSpTZ1WerkfvV87cenIBk+M/+E8tRz1KKmEBBs/RGS1DmAiTxD7el+2pgss8q3GlXVN3SdbtdZLMVPVek5vjDhbg2i6nlXs59qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjMMkTL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjMMkTL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C21F000FF;
	Tue, 22 Sep 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067397;
	bh=pTlfKzJ0Vr6DSRpLT6CuScs/v+wf5LCST8fvQa+xTPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjMMkTL3IajEia8updhKDn0B0sN4uZ+B51lBn49hz7hBmJ7MzWBYI5EcEuEfwLN1o
	 4jfNijR50BmzKGvcn4d3dOkVX34YzyVllzamWislCB7YlbrZGEahwe4J+IwHJKC6N+
	 1iHed7xRRr8Ru9DsDsXeS3ulEnbHJ7mRbt9vy/crzJg0ktncs3zhFh3LbWpiZPc+44
	 4UnH7475pFNCOVwqBQNdH8sjwnNDLUk/7fK7JR1SNGnthWoIVt6fcSbAzIpSdigwMw
	 lla9CdSpA7/mRiWzZ1SLBxmWzFq0xLxG5qwc+iTmamJ1wxAjXz1oC/erw2cD0LGg4j
	 xiUpRSRlL0knw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] crash_core: fold duplicated memblock arch hooks
 into the weak default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wandun Chen" <chenwandun1@gmail.com>, m.szyprowski@samsung.com, robh@kernel.org, rppt@kernel.org, baoquan.he@linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, tglx@kernel.org, will@kernel.org, bp@alien8.de, mark.rutland@arm.com, pjw@kernel.org, ruirui.yang@linux.dev, hpa@zytor.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, mingo@redhat.com, pasha.tatashin@soleen.com, linux-riscv@lists.infradead.org, conor+dt@kernel.org, pratyush@kernel.org, alex@ghiti.fr, x86@kernel.org, loongarch@lists.linux.dev, devicetree@vger.kernel.org, chenhuacai@kernel.org, linux-kernel@vger.kernel.org, saravanak@kernel.org, kexec@lists.infradead.org, robin.murphy@arm.com, linux-mm@kvack.org, catalin.marinas@arm.com, iommu@lists.linux.dev, kernel@xen0n.name
In-Reply-To: <20260922084256.1515554-3-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-3-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:56:35 +0000
Message-Id: <20260922085636.324C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> arm64, loongarch and riscv open-code the same memblock walk in
> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
> the __weak defaults in kernel/crash_core.c and delete the arch copies.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D2

