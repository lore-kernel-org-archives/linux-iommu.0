Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596985208D7;
	Tue, 22 Sep 2026 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067734; cv=none; b=WAtGmCPl6kee6FVcYioUHBdj5boLVIkHMhSNHv9O7Q9C/UflJsiTnUbaaZAHLs5QnPB+dYKmvXJ4G98BtTVdaBew3qfZpFs/y5CH+HId3WZGHbPiHG6vOZriODoDkCtGPOFxouMKu0G+Mp3pB1HJfbAWiQWmnEwi78dGsfBEk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067734; c=relaxed/simple;
	bh=+hsnJ4j4rBIXKKH9ChIwWElTHO5VrNa39QD6tMI8Gqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqLg9KxDSUhGnVSD8JWaxgyctFIsLHiOcrzdZfltkWLWZPRgjaJe+ydZAqFzS8C9YtgFGmQzVDnXoFW/RQL8Ep4PBwHMKsSp92s++H+u4NgQ7kl+wgXqURpwtVEUjqu7+/pp/maIIY48tUerG9uEE+7RWMmLnvLgVxO4NoyvA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho1NxTfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho1NxTfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505F1F000FF;
	Tue, 22 Sep 2026 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067731;
	bh=+hsnJ4j4rBIXKKH9ChIwWElTHO5VrNa39QD6tMI8Gqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ho1NxTfYbdGdeqfpz5XyJWNcpb+7YT6deUPOb7e/Es4jmHjJWSyriPfAAGuVspsae
	 6LKxXVdN1I2udTK271j3pFm2GMHS0XZV8KVHkUGVtsYFv5r2COfiRTH2Y6ht/kxwzI
	 5S7K5mqn5YCKOuNg/yGFFk0fqstHlUc6g6O3EF7XYzAKKBM6Nc/Wql66LhlQ47+4db
	 cKexdcycBQ4ogjwH9iqe0dPw02bHXTGuz5lPnWXYIFrVHZPotADEAFLZn7OCXa8iEW
	 al36CmxULEHPX1q79eXSdQseKONK2FXJbwliGmrP2a2xZ+pxm9/S+EEg+twlKbQ1yZ
	 0wPGdhtnaVu7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] crash_core: skip MEMBLOCK_NODUMP regions when
 building vmcore ELF header
Reply-To: sashiko-reviews@lists.linux.dev
To: baoquan.he@linux.dev, m.szyprowski@samsung.com, "Wandun Chen" <chenwandun1@gmail.com>, rppt@kernel.org, robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, chenhuacai@kernel.org, palmer@dabbelt.com, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, conor+dt@kernel.org, kernel@xen0n.name, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, will@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, iommu@lists.linux.dev, tglx@kernel.org, pasha.tatashin@soleen.com, dave.hansen@linux.intel.com, x86@kernel.org, pjw@kernel.org, bp@alien8.de, mark.rutland@arm.com, ruirui.yang@linux.dev, catalin.marinas@arm.com, hpa@zytor.com, alex@ghiti.fr, pratyush@kernel.org, robin.murphy@arm.com, mingo@redhat.com, kexec@lists.infradead.org, linux-riscv@lists.infradead.org
In-Reply-To: <20260922084256.1515554-10-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-10-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:02:09 +0000
Message-Id: <20260922090209.E505F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Reserve regions (for GPU, DSP, ...) carry no data useful for crash
> analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
> reduce vmcore size and capture time. crash_should_skip_region() now also
> returns true for MEMBLOCK_NODUMP.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D9

