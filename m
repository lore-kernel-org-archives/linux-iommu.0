Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326690;
	b=qXXVr5ounRsyfSJH1q2l8/TYpg3eHDtkZqFiXT7BYrVF4uFX0c2XO3u2iED+7nYAQDv5
	 bbXkZzY/YT73ZUqHQA3nr2acIuO51QJpVgtxvjHsAkkHM7vrov9U1ddrOvbxyqwuvktc4
	 1gMyc+mr5+erhfOImlK0QOkV9X1PaO0JG6yC6vNNGu7Eqk4qkzhU0FDKYQMzq3D50sZQT
	 xq3V775GMrYoHM75pjDNxTNNFK5iic7ioeeNNQcoEQJpUpE2UTtjphAGU0foSLBhnfnob
	 ky1Ho3nHQKVEoHPJy/AlCN0iljF1e8cX+j9nVkDfqioXbuWHKZKMwdcfG0Vjpu14lyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=2ZJ90WMhfR0YfvdBTSjmWuZ2Dnb3Sle3TRFQ/lQ57LQ=;
	b=dW94Er1/jTTGUSVOhCafO3BdJfvrhVHXn7sqPUc+sp8srWFrPcRZPlbAmRGYWAWXDoSx
	 MAUJIGGhrzwJAVV+DcOdr+g+p6ma3BBg8tmvLjb4iY7u4ZvsOK+Y7qSSVFLAqq1G0p84c
	 3KzreHl6yTWiDU+1flL15FQ3ozpeDrWZwTsWrFcDajqMMiTQ0LUXiXVHMoLcCL4LIq5nr
	 c48xgxKBHz0u+dDDmx2wmrBvELeMDPdrFf0Sqgngl75OLP/5r2iyPUd2ORSKqjz0WLeaR
	 YkY5STSR4ysspvnTn4ncYNCMS7ExW2MiHiyInLzRMiZUlMZ2gL+q6Q/1pZ1OvPTSMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cED0imNk;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8F606A331
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB8F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cED0imNk
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c445c95d553so299695366b.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326688; x=1794931488; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ZJ90WMhfR0YfvdBTSjmWuZ2Dnb3Sle3TRFQ/lQ57LQ=;
        b=cED0imNk7iE8EQmAP3mUsBkRyjcfTZSlKOyanOo1CDPNzZE0QO+rLErrVLHO2l0XxA
         wR4pxyro5rWm4R0PSiFGcCbyUl3vvBGasIWaISolQP10s9kW3ToZuc7CjXqhIg8jII+W
         TNpIDTZrdXal7DBKMTYbZVGQQ2IR01AyD+oc/3ogpjJ5qFiaAiNeE9t6YzY5qSzHeN0g
         oSIFyo5UzpzQ52j/omFPL2ik7EPmhl+eSDwM9DP8gFqz6kKT7QlpQd3KwnAFCzrAHDJT
         23WQXA3BqkI7DfR6DmGOo5QrypOSh+qoCul2Ha1i/6oqqiY5tiO4aDrI44LJ5XZdqDeL
         ZXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326688; x=1794931488;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZJ90WMhfR0YfvdBTSjmWuZ2Dnb3Sle3TRFQ/lQ57LQ=;
        b=q1gIBP+2jO/sfe/YJQM8ZlkSeLsAwoHn411Z+0L6EwdxohXLbpYBWP8Jhu4IaNUT6j
         hci/YpRGO5MdtNvf+jhpVODCINNYfzpECFOPVk1zuhihkshZLtoE3odJwRz3hlNfN9+k
         +AN5EXw9MOFQ8GcCM79ZQlGvgYAs5zgI/dg11JgCIf3wyt8PbvblqoXBn8yZrobjmG9b
         neg342TMNuqjQ502x2csoCGh2pQHy2Z7Bnw+iU9mA5ian2CvOiNl8L+QMwGzvMQeHezG
         99r8VShuoFS4XLL0O9ZQDzx/aXDb9z8JbyJWT9FU4XiQxvc0FQ59pJEomTLGhZYdTbeW
         86KQ==
X-Gm-Message-State: APuU4Z/Bubej9de3kncajiucLawOLoWLP+2/ZkQY7bV+BBvOSKl/XvpE
	FnmnV3ShY8nAgGgn09ZKO+jpv0fdJPkqKndOnhbJ2RQCyu6pEB09F17j
X-Gm-Gg: AYBFou0+T/L6z9Gac2nL9K0JRT1eF1+g7PU+D1cG9bncn5evKb2oIJ8NgHJ18Y24ASZ
	cInUJwX8k7CFWaBoTIW5Bv/OWrq5ic/ZmudiqqTP+WMkagWT80s3lv4ML5vNdifUsZXYW5OUycV
	y+qyZAHMSiphTsa1Z4UzccJFE6Gt3J5xJVpM7ACH96sTpMWY3nZwtN1sS5omfxUKrEym7Lk3vpr
	YtEofZxqFgdY01zm4FSG3odmW0i4Q5mIV77RrkH3gNL+3b7iOKTkVxqsv48WnbFkc2O8yMqXWO/
	6bRrEFpx8YOpIltXP/wNF9ZXD/ObKeN1VFW/SidvBfh77GDqtBYP7zRuImBtPEWO3bH7wW3rTxw
	aRjPLuvi3zpMOJgL4VHF2+nlNphUyMpEWB3Fw9fCa5IlaZBdUmuqmCOKCJ3sZREvhD9x3jAfRJR
	iwp5S3/M3reAnb8gr4nR4s6btnxbkbN58JvDunYtBtenAqXMB05/In2O/yke81/lLxAoJobRkrO
	9XXgC/tqOwXLSG/fLQ3YP7XDnCYWqMAFg4H37xQBafGL302JQ5+mQFDtpbp08CrRRkisi/BBX99
	Q9zlqHQdskeKT4/I6KLQKSYYOl+zZ4yN55DG77EeKoye86E/C4ZxiNT8sqcig+JA43PPtrr4HT6
	z1BYJYFa28yyN2Vtx9bHBgGZNT7eJK4/AOH6V5lx7ihQTOBlRJSd/zwgjgNpuupbXc41yddg1P3
	i2fEicgiDsO3Hw8iNOqjDxy7kJnHyrIx/VUeQeUstBv5A+NglTt5wzcNvuMwiO5sxy2SCmx9Qqc
	rP3vS1GJXGjp4XursIMlesj54df5szAbMILJ/PYAzQnAAMPu7SQiNE+etTAoN0=
X-Received: by 2002:a17:907:6d01:b0:c49:8f1e:af0a with SMTP id a640c23a62f3a-c50491bd4d4mr262123366b.7.1794326687814;
        Tue, 10 Nov 2026 08:04:47 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-12-36.dynamic.telemach.net. [86.58.12.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a643f12sm127127266b.62.2026.11.10.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:04:47 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 aiyengar1990@gmail.com
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 0/2] iommu/sun50i: Don't report TLB prefetch walks as page faults
Date: Tue, 10 Nov 2026 17:04:46 +0100
Message-ID: <XuGVSzNrS7KQLWfGI0rB-w@gmail.com>
In-Reply-To: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
References: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 10. november 2026 ob 07:05:16 Srednjeevropski standardni =C4=8Da=
s je Arun Iyengar via B4 Relay napisal(a):
> On an H616 with a display scanning out, the IOMMU reports page faults
> with master -1 at the IOVA right after the end of the framebuffer: once
> at the first fbcon frame, and then once per frame for a while after
> each TLB flush, e.g. while a video decoder frees its buffers. They are
> failed walks of the TLB prefetcher, which the hardware flags with bit 31
> of the page table interrupt registers and no master bit. Patch 1 stops
> reporting them. Patch 2 makes the remaining fault messages say which
> walk failed and what the interrupt register held.
>=20
> Tested on an Orange Pi Zero2 (H616) with HDMI forced on at 1024x768 and
> three 4K H.264 decodes through cedrus, on 7.3 kernels with and without
> the patches:
> - without: 214 "Page fault ... (master -1, dir rd)" lines;
> - with: none, no "Page fault" line at all, and no decode errors or
>   timeouts.
> Since the patched kernel prints every fault that is not a masterless
> prefetch walk, this also shows that the hardware sets bit 31 for these
> walks.

=46irst off, display engine isn't in merged yet. Second, I don't observe any
such issues with my wip H616 code.

I think it's best to wait until driver is merged and can be retested and
merged then, if needed.

Best regards,
Jernej

>=20
> These patches were developed with Claude (Anthropic) as a coding
> assistant. It investigated the problem and wrote the code and the commit
> messages; I reviewed them, and they were tested on an Orange Pi Zero2
> (H616) as described above.
>=20
> ---
> Arun Iyengar (2):
>       iommu/sun50i: Don't report TLB prefetches of unmapped pages as faul=
ts
>       iommu/sun50i: Print the page table level and status of a fault
>=20
>  drivers/iommu/sun50i-iommu.c | 50 ++++++++++++++++++++++++++++++++++----=
=2D-----
>  1 file changed, 39 insertions(+), 11 deletions(-)
> ---
> base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
> change-id: 20261110-sun50i-iommu-prefetch-85cc9ecff559
>=20
> Best regards,
> -- =20
> Arun Iyengar <aiyengar1990@gmail.com>
>=20
>=20
>=20




