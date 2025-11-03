Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9314F9D6
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160179; cv=none; b=mdNYSN8+wRwz0/TEsFhCyR4rHbv18ISaW+TS3rhKgL6lV9IZmxbrVGBJeTeD8BZlOuEtGvKrqVb5It6rq1HDO79n1wh/WYnkm3NqvwD5JdgenfLy+n2WtxnhvNOfBd2Deq/97Af9NdPtQSoXu6ptKPeMDMx0DACox6zCHVdtKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160179; c=relaxed/simple;
	bh=cdG/2GNESlbUp6+q1QrgnV9FBjJKweM3wcW1s9bN0Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2dPpMpx7U1Tb3F6gdF5qbJa8Q7rRtukpP9Ul6uNJmM950BJQ34oBfQnSttkPn5tx7C1m/eD2UK4zqUChFuTo8GViOGBpMQ6noTVDq9O4W50+zp5rZG5m0+dHi4n5Dz5QP6MN5WvFoTbjyrzu3qv5ed11mXk6Hf4gTNy9MYwwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqOP/nRr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqOP/nRr"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b593def09e3so2964495a12.2
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 00:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762160177; x=1762764977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqNH2TcSY0Cf3Gw2Gm7ueN4cQjJXED+OmhcKafNVeF4=;
        b=fqOP/nRr6VXxDn86Opr2PTHGdZZdbJPGYT5yX3Qy+HaKUcJkrOkRsjh3cTWPy5vQv2
         jUWJVMqHH9SuA3h9TDnkn3oMvwdfCgWuEb3+raDFMaifz2oeS3lSizY90fl2LPhERBDu
         iMAntFxVdSdtP3LG+hurBXtNml7YYZnaQnRVoGlroxRfUZCicTuG5a6B55oYzI/oIeI+
         17tM9dRemcPmAVw+PprM3T2XAiq8VKsLHgPQrIz/3He9KQ6opwECChmLs5mvkI+zd/0D
         FAhAmyU+N2myoKF8XWhac8nkvtzX4sUbXZLr1jn20ORrThrjiKsH0ItBGBhS/uaubj/z
         TmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160177; x=1762764977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqNH2TcSY0Cf3Gw2Gm7ueN4cQjJXED+OmhcKafNVeF4=;
        b=qq99BisjrZxEt2Wa0dqpaCDsKl/hdha2TulVJiSU4CLu/ypqTvYor3fqpPJpRg1BFN
         Stm0DaLP1DPWWK1VXC2M2yOthBvg/tHzX7+cbJCLi8BnlC4R8a5TEFduEwUIBmownq0d
         7AVXiy6lHQBFTVk2gUCa1/DvAm16R0d+wzxNOoi9+cHboFOsi3fiagyKOA2m5dOffHgi
         qbzbjjDn2A6H15XQEMhr+E1l1ytVLGkFhhGbY8m2JSVAuRV7NxMWWWS7TrGvfOeRymQY
         Kyof19Q2/vIbTGS9pjYymoHfDP7aEyMCab9rHRZhzbHssrpCAyCi76Wa69xfQoSSkihk
         p1MA==
X-Gm-Message-State: AOJu0Yxm29IWzPtdjxJwmQP+ll7q2cMRohhCgNFtsmqE+/klu5TAZSlc
	sGC4Pz57t2MB2Kc+/dnLZmjThFdy2eUcDpch7qFR+ME7nkCP9rEhBpkS
X-Gm-Gg: ASbGnctxE2BvHrDQO3nWQwnx0/hviuiEBZ0vQZWuEzw8yeC8ALnKprCysrvB/D+WKH+
	0uAKdNuQCW0HmjdGco3FnsLikWJisSQZLrekXlIo0XxOX9i0ftRGqtA+QHEjHZhBKmWslmVhTjx
	xstkTk/XStdqAL1uNYZUSiJrEzMrZyYgDRUDpT0Dmwqu4Kqmub99/uINLP7eaZDAcO0q/7Ij49w
	gtRU6mUV6zkN5YqAFeW6GVcbMUp7YaisjIQtRbJM4yE2534iBLQ9nu2IKcBL1vmZ44ipnF1VBES
	dORUQJHj8soU/Fw0oVY/nqENfb/pmQ6rsLreDF3XPb/Rns1OnHsb8/pMOItCE8X54MPtXmBpk2T
	YqIebWxtxY4KY6NQ3YUpX2lHH1bj6FEqs0jPFpJKeiBSp2feTIO/3vVTUDknHMdeExHw4eyqsrK
	D71NRa+WR6rrcC9rY=
X-Google-Smtp-Source: AGHT+IGkgEsePzXxOC8diAv/i5Np1XTP2RcGbYFduDEBYKr/iatAaBQiTbvcgvvKRavZB/+3psCtUw==
X-Received: by 2002:a17:902:c405:b0:295:426a:77a6 with SMTP id d9443c01a7336-295426a786amr114478515ad.32.1762160176891;
        Mon, 03 Nov 2025 00:56:16 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a0e1:7d00:af43:dc37:28a7:37db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295586482c6sm75414465ad.22.2025.11.03.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:56:16 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: geert@linux-m68k.org,
	den@valinux.co.jp
Cc: iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH] iommu: ipmmu-vmsa: Add DMA controllers to devices_allowlist
Date: Mon,  3 Nov 2025 17:56:12 +0900
Message-ID: <20251103085612.42134-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
References: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Geert!

I'm helping out Den-san a bit on the issue.

On Wed, 29 Oct 2025 17:08:07 +0100, Geert Uytterhoeven wrote:
>On Mon, 27 Oct 2025 at 02:26, Koichiro Den <den@valinux.co.jp> wrote:
>> Add Renesas DMA controller devices to the devices_allowlist to enable
>> their use with the IPMMU. This allows DMA channels to operate through
>> the IOMMU when enabled.
>>
>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>
>Thanks for your patch!
>
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -741,7 +741,9 @@ static const char * const devices_allowlist[] = {
>>         "ee100000.mmc",
>>         "ee120000.mmc",
>>         "ee140000.mmc",
>> -       "ee160000.mmc"
>> +       "ee160000.mmc",
>> +       "e7350000.dma-controller",
>> +       "e7351000.dma-controller"
>
>While your change looks correct to me, it causes DMA mapping failures on
>Gray Hawk Single and Sparrow Hawk when IPMMU support is enabled
>(on renesas-drivers-2025-10-28-v6.18-rc3 with renesas_defconfig
>+ CONFIG_IPMMU_VMSA=y):
>
>    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
>    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor
>
>0xe656000c = HSCIF2 Transmit FIFO data register.

Thank you for sharing.
I was able to reproduce the issue on Gray Hawk Single(r8a779h2).

>With "#define DEBUG" added to drivers/dma/sh/rcar-dmac.c:
>
>    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
>    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor
>    rcar-dmac e7351000.dma-controller: chan2: map 1@0x00000000e6560014
>to 0x00000000fff82014 dir: DMA_TO_DEVICE
>    rcar-dmac e7351000.dma-controller: chan2: chunk
>00000000e5110c20/000000005e0ede90 sgl 0@000000000d8c5440, 256/256
>0x00000000fff82014 -> 0x00000000ffed6000
>    rcar-dmac e7351000.dma-controller: chan2: submit #2@000000005e0ede90
>    rcar-dmac e7351000.dma-controller: chan2: chunk
>0000000025f2f66c/00000000e5f0dd15 sgl 0@0000000064f1067f, 256/256
>0x00000000fff82014 -> 0x00000000ffed6100
>    rcar-dmac e7351000.dma-controller: chan2: submit #3@00000000e5f0dd15
>    rcar-dmac e7351000.dma-controller: chan2: queue chunk
>00000000e5110c20: 256@0x00000000fff82014 -> 0x00000000ffed6000
>
>0xe6560014 = HSCIF2 Receive FIFO data register

Does IPMMU support handling FIFO registers?
(Forgive me the question... I'm still trying to learn how it works.)

If not, with now dma-controller backed with IPMMU, maybe what
we need is to map FIFO register directly like it used to do?

>Comparing to the CONFIG_IPMMU_VMSA=n case:
>
>    rcar-dmac e7351000.dma-controller: chan1: map 1@0x00000000e656000c
>to 0x00000000e656000c dir: DMA_FROM_DEVICE
>    rcar-dmac e7351000.dma-controller: chan1: chunk
>0000000096396eb4/00000000f35357b6 sgl 0@0000000013546bf6, 74/74
>0x0000000489ab5000 -> 0x00000000e656000c
>    rcar-dmac e7351000.dma-controller: chan1: submit #2@00000000f35357b6
>    rcar-dmac e7351000.dma-controller: chan1: queue chunk
>0000000096396eb4: 74@0x0000000489ab5000 -> 0x00000000e656000c
>
>This confuses me even more: why no DMA_TO_DEVICE mapping in the
>latter case?

I believe the DEVICE being reffered in DMA_FROM_DEVICE is
DMAC rather than FIFO TX register.
So from DMAC's point of view, the dma of DMAC->FIFO TX register
should be think of it as DMA_FROM_DEVICE. 

>>  };
>>
>>  static bool ipmmu_device_is_allowed(struct device *dev)
>
>Gr{oetje,eeting}s,
>
>                        Geert

Sincerely,
Ryo Takakura
