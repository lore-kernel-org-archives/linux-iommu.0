Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660888;
	b=3aI245yibsuoI6I1IqnYzzWTwtY0Vi7VzhCjoH6VFZKKCMhe+XYgM/sIrFNv7ZLStIY4
	 QLxVraN8ln3kEnSowTCsLoYK/W5S/hb8PGV/W5MKajXAmQkVU7DL79O5IQUCQEjvD4/ku
	 qANDisYIouy+Wn/3OsEvvzIbe/vwV8m5V6GkInY5C1qSZ8JGI+4t6a/Vs2dUgi8EiM73i
	 wt8hyCSkfKmn0h+moCoisIvnzVAJ2WMfWyBQhvPB8ZXDxECgSuCcEg6xV2RmVhGnZkp/K
	 we/AZZaAs1UO2Ex4ZMbw9U7KWVg8i6rMjL6TC8NBoc0AfH3jeF0N6RU2kimLJbVIa7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kzZ572SYqNYS7AFbKEhSpyO0POmges/XmCJlcN/iV2Y=;
	b=3Z8E6weNxYWvTM/xm3fxusKSJDNbXNo1Lced3QjXTAcrR5HqCT7wDgOtoApguV0P6O9Y
	 byqOGFknL2tQkebBLap/0XrAViXr1vaFE4PeLRBZtlmLAR76YsaKpBoQyR6Hg30y/7ZYG
	 R39GBx1fMHR+mxYRD/q/woA+ZwHbGKfaZTc2Qni/Fuzzfk5CqKLwuNqAKgI0Ythx4DSbA
	 RdAYZ5NT8WvHN/Sf0x1UTMrSFVpZJ3v8AOCOEON7T0t7XzSWwHt+2uGomJFglSzRZrwqO
	 cXIOLo0VlfV/K+dYsyeEJPm+lm0AFPHzY0BNC6VkFXW5laEZjR9PFXy0SXuY8Ui9f4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=furiosa.ai;
	spf=none smtp.mailfrom=furiosa.ai;
	dkim=pass header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=cjChzqPE;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9D606A33B
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 12:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC9D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=cjChzqPE
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1756509c88.0
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 04:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1794660887; x=1795265687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzZ572SYqNYS7AFbKEhSpyO0POmges/XmCJlcN/iV2Y=;
        b=cjChzqPE4FP4aHx6uU/X7PlZuRIbuYzA/Z7GupMYkEQvxlVM7q0ToM8QWx2OJg2B9Q
         pvEB1+LY9k6/4oVZWPUBdkOHR3NRDceY7ZBX2wQmHZ4eWZh8vOgsL4GNbCcikQ3OZ/x8
         u0UnnLy3hZrFvyAWAT3W0eM66S9sKOSpnLPgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660887; x=1795265687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzZ572SYqNYS7AFbKEhSpyO0POmges/XmCJlcN/iV2Y=;
        b=rwBa7rNKiHyVsqOYq9q5C34eNUmJKmpbthESYToqxG/CxRd0mYnIP9pcxiE2Aph0uN
         wKKSE1Xl9bANzNR3IAkwKIvMLqsl4c4IS1pew4Hu6inmdb8FdpMrIOoUxfPRDb+QUE3Y
         ke6WeS2OreRh10KYulgQDK92ina5iSRsuFB6dRFJXQLkqDchzI8phwV2v5Huk6fUVsVb
         MYgfh2Ga++XrpPt2lLwg2KHOklgEHNpaRtDOlsOmC05DC4CX404zlBmlQGjrZ3sO1nCh
         XCAsFcM6MBBNZFsXp6f5OuSWLiqS+nLTlACjrmeDJ9G8yw9dDHVpDloAsHgslovbIEcm
         1Umg==
X-Forwarded-Encrypted: i=1; AL+hErFx9ZFw4uLnzJhuRW8TYHncDeoH+8+aaMLqz58m8wyktI9kJ8stq1MEAwgPJ7MmZxMPcOPe3Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Jkgdmv/z1c8SQ/UvaVXB/n04z27lOOY1x9bFl46WMWmQlZQ19
	LO5O1ENYyzVrw2W3QhB3VZOHdO3Zf6Biz03W3dTEJasHAudwpnPyn8XzN8F+y5mKZ/g=
X-Gm-Gg: AYBFou1p/zWTUE4FVLXC6tpS8IKH2uZ3ZR6BFlCTtf3V9VJycuUwxKN5eUXPMcpJuAI
	s6FNW6UoJksKpVjEsibcQKDfpelWXoFhsCAWPxaXE8JQdPEI2MFDoWYNQRXt4UhVOVmgGLTuRGK
	YbqbztI7hWH5Y3FBtN11mnrOMyzRjaQt824TNGn+nWAfatV0NrdmKWvjTDffihQftv2zbqOPbAB
	L+28PGUhvZHwfcgJx04HR1a4Tk+EyC/WY8B6820OtNT7teRhWThHjsP5TSgGkGvXUsgjbM2hmVH
	Q4rdpAqApjS3VeWi42bgWkZC7nfr9aF7I1U9nfKN637nJIydl6+8s/Uh8Mm3kzw1pX+EQsfSe3l
	M6xZGLo39BWLwoOxTmvJCoDhJep2VdKfV9RlbtGj5duMP8lVE7fNYXsCNdImde+Wrppaf+XKsqw
	GA7j8MkhC/9TcoVkIiqeTDcSysgX4rbxobLmNY3xPspLDCM+SnTK9kfmp0UqN5Gtvpmpq7dp7tT
	FxvvRiQonmfNu9b1xJCOIqWYiyJDtPGtad1hN1js7YeU7hsFHnsuFFE1WMCnToHIi0zBy8tpGPM
	tkRtf/Anii6CGCpe3PKtzrmo2HUmNom3TyKt+fKXDWIvCiemx93Ej4TZUfBblKNgg8ISGm9Fsx1
	qR2MYSxKRYdJT
X-Received: by 2002:a05:701b:2706:b0:1b2:4c54:d976 with SMTP id a92af1059eb24-1b50311d3e0mr5111198c88.31.1794660886535;
        Sat, 14 Nov 2026 04:54:46 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm15468097c88.12.2026.11.14.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:54:46 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com,
	royalnet026@gmail.com,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 00/12] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 14 Nov 2026 21:54:35 +0900
Message-ID: <20261114125437.9986-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Nov 14, 2026 at 04:05:17PM +1300, Jiaxing Hu wrote:
> This series adds RK3576 NPU (RKNN) support to the mainline DRM rocket
> driver.

I checked the accel/rocket patches for regressions on a ROCK 5B+
(RK3588): MobileNet inference with up to 6 concurrent clients, runtime
PM cycling, core unbind/rebind, GET_PARAM (returns 1) and recovery from
93 forced job timeouts all pass, with no warnings.

For patches 2-5 and 8-10:

Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, ROCK 5B+

Thanks,
Sidong
