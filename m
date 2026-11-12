Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504756;
	b=duEWw4tGNB90fvXUNfJ1IbNKr6RlgC9bZo4YggY+5d0zfMxyncHZUNdVicEYjMrG3TzZ
	 bN2jA7sKUrI0FFcITUfFQKVh3uPVsvbCwi3Q/XxIIIPyrsBipqa2fg7pojXs02OEdP3yW
	 54xYkAYYlWyDjSAZz3MJwz4pn9+Do2ttf8VzDCwVJa5mlh2BXnyQJLScDFIMnAn6NUi7p
	 hmeg0UG2SM55gixuMWZ9DicXEOv4sI+5DELJhRy616dudhBB6W07kclFOtNQ2J5k7RWDO
	 t0yiwnDGsFavDza6mkt1qE38WGnnLJDm5JWnSmMHNx/zNqvJcUH9l8M/2gWFWWrIi4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
	b=b4ySBjdZL9GWMtE/WTKyBjOlfjjMbjwn754yYXD4NwBRaqKaVJaYd93fVjjOIWYPjZfS
	 HN6SYExq6SpdTrJNyHpgXmQlPPQZkL2f/XCdAiY0pxSZyTps9QjTRvNgWyEvBnOChPWVG
	 hsqbC2mUmDb4hEZluwIpJuCcVcSTi2jxMMZfKSdn5zSqHLjuWOXD/C743NS+pNPwXMYEY
	 0eQ4iqnhymw/MeTadZxau7CBlmhH6ePAkxXMk8TwqfJPT6XUoC1Xr+YvVUdDiueGYdnsJ
	 F81m0zFE9+DbZE/kbZamHI/aju45+92Ibj3CMwVXBOayHorz9UbaOkWQzl+bJRRxjKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iiv9HM0j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93868606A33B
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93868606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iiv9HM0j
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab1e5a01a1so1745451fa.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:32:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794504755; cv=none;
        d=google.com; s=arc-20260327;
        b=BOieNPBzy7yl3sVLvI2dHQWkAXSdN71avOpR7C3T02wliTBjQg9rfOx8adB74iKeiS
         vE0hbBwF64J2I0hWHFmG39lxaSGOx0FMwwG7YPbWMKHTCIVQJXuJ96BQ1NsZCQ4+7iE2
         8tmlg+mIH4DPnG1D+5EnRuVbePocWGxD275B6zONERkrABvMPAuhFjrA4ki1U8x9RGyt
         Z623B/4435C+WkYh7QvBSGsCWZXbb93+mu3nWFntvfmkCXSA2JJfbBppOQWwMy3prAvV
         vnBF2HLtHK17dBe9oR2hvZAWYPVLnXow4AbwUhKGp1MuSqYvYFO5iI/3LtLNSyXZ7mKp
         2h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        fh=TfCXli6OCBktpBGOOy1pPOF0PJuAHfpmOPF3SubxCsw=;
        b=l9f13BqzIPmHcsjAjoFWwkOU9Y4iZshn1nmyNsNaiJZ2aRJ+HQT3H7sfo9jc4FCatG
         c54ZE9cj2nP9069kCdvea2VuULP9YMJvPf2WGrdgCFQt7e1Ia2RoB1nUBxJZy2ZFoQ2x
         v76E+Xb7kYPZY7brb9HyI/KanHhU/c3zKz1FlnWWRAGbXBQ6efhzDCFZFcpg7cwN3/Wy
         mBLOrIykrc6e9lAS1lAtB0n2HEgFjjsMo1llAkIW4wPBQg+hjgk3x0g4vD3IjikZgPtg
         V57OeyZCBm/6CGmLLmaFcu2VTkugH31WDrDfVJIXwC5C+APPRltd24DmkLoxBx4k/Sx2
         puLQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504755; x=1795109555; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        b=Iiv9HM0jESYULxQyWtEAG2Cg0eZaTSPIi4WAOxkXuohNDvuKoMoGKcuc4qgU2SIKaD
         2uVRgwBKu86qayJChe9yCgJzkJfWjNLfb5GAugMYHk8JJRemUcq3kVLZxCgDJw1gRgXz
         4Cn0tUUzQ/Q3LEKJyKC3jtx7284x3fHSqoL10sBGlyvd5PyKIoIdCMWGGDXMlDy4Q46T
         bspTnmqnF1qBeScLZTJzHkc4uCyEnC6q5IE6KW7z4NMadYtIX06/4PWEOfxF5S4EfKxH
         YP6j9JAj9ffF/oq2Tl+6qVpC5K4jqMXEKbkEY32AGBNKRm6PCDwNVjYxtcTWmoo7EkNt
         MLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504755; x=1795109555;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        b=2IC3zNXx+UgfVp4FjpDv/UwxUzXvB/G13gIMmI2pPKmVm18e1P45GCONFFIOQmynd8
         mN1dOQvZ1UWm5Nbzi4k5CziK5dH2jZd29JFtQ8IEsvVusYygZfkShomFbh5VNi6vprlu
         0cr+ngdzAxb4fltsemXNbKz2C3OjThVkH1Q8MmaJjxpr79QHsB9KLz5IaEUfi1ENSVwL
         WIB3P53/JY1hWj7fw9i91x/j5z8DwIoJge/PbM+/dvX8P+sCI4cueCiywfwerrkXgzVK
         QOO22/ht2tCbEzTYfOdImCI44CUk4/pEabERZmdTucWRt45s1JUDCUHr/IQkJlLz6VGh
         3o4Q==
X-Forwarded-Encrypted: i=1; AL+hErFLyAHn2eCSl793cSsR9+RwHHLWssGXC/ZaMTdGiszOX6t61ZUOkroqEQs6kDPpX57DikcfNw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IMbd7Sv2wXrkC6/moeCshSw5Hiv7ASKuT4DLDsCgg/hDDNbhO
	PAiTWeq0BdUSQmpO8oEgRm5YEfIrrt4qAbkK2eQmJvq+GFaFIAlpNeBNr5aFtfKEwY7dGkOAJ4z
	wxm74XlQPLULnMOfIxNCJa2hYHZi/rMw=
X-Gm-Gg: AYBFou3HsyyioDvo37wspR1SgY91QGSZC3fr79MAM+y++cDdKamamE3HKeq5PMKiwnk
	FUAWvthdNJ3qO1uOgtsg6x/aDn76ElOwV+5Ba9xZqK3s1HnKtaqxU3hs7avbZ9Y0l8j+2Kc/z+r
	Q0iOI4oX+ebDPznWuEEfrDqgpWKyHlpPBVFWJywbk57VsOP7lEGFAXSiSTNpONxabJqOeCZpVFp
	H9Y5RlbSqXeTNnrGj+6aZkQcpWnFZ97X4Uw1Np3Pjg1Fkb17ZDMai2hr7xDSXP1QfuyhK4Entku
	ND1gpNc0iM8tBlKSbM7H/3xEWsvOGB4NUQRFIQ7UIN0h9S2HJdi1Kq0NaXutyoX4cCTRoJfZO4N
	fVTR74lnVyPyNQA+46wdIS3UzH6v0gS+fztHHXyyKWImfh9HbQ5KTK8yrHP1WX3ULtDVHi+I=
X-Received: by 2002:a05:6512:1288:b0:5c1:5703:46ed with SMTP id
 2adb3069b0e04-5c170a00a41mr22428e87.6.1794504754625; Thu, 12 Nov 2026
 09:32:34 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
In-Reply-To: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 09:32:23 -0800
X-Gm-Features: AclHuK9Z7jBSZWw9Fn8TnUnk2iUH3q-Sin-aeWc7hO6RSzhS2Undt4qpZ9_1474
Message-ID: <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
To: aiyengar1990@gmail.com
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please don't apply v1, and it should not go to stable. On re-reading
I found three problems:

1. "A fwspec without a group means a probe is in progress" does not
   hold on ACPI. On the driver bind path acpi_iommu_configure_id()
   creates a fwspec, and nothing there probes the device or frees the
   fwspec. So a device whose IOMMU probe failed earlier would get
   -EPROBE_DEFER from iommu_device_use_default_domain() on every bind
   attempt, where today it binds without the IOMMU. OF does not have
   this, because of_iommu_configure() either probes or frees.

2. Drivers with driver_managed_dma never call
   iommu_device_use_default_domain(), so the window stays open for
   them (e.g. pcieport with a modular IOMMU driver), and the changed
   WARN condition can then hide it.

3. Replaying dma_configure for a device whose driver is inside probe()
   is wider than I described. It applies to every such device on the
   bus that has no group yet, including a client that went ahead
   without its IOMMU after the deferred probe timeout; that client
   would get its group and default domain while its driver is probing,
   without a warning.

The race itself is as in the commit message: the client's dma_configure
sees the dev->iommu or fwspec of a concurrent bus_iommu_probe() replay
while iommu_probe_device_lock is dropped.

For v2 I intend to mark the in-progress probe explicitly in dev->iommu,
have of_iommu_configure() and acpi_iommu_configure_id() defer any caller
other than the replay while the mark is set, and leave the replay
condition and iommu_device_use_default_domain() alone. The other
ordering in the commit message (the client sets dev->driver before the
replay check) would then still warn, although nothing is wrong there
besides the warning; I would look at that separately. If you would
rather see this solved another way, please say so.

Tudor: you are on Cc because this is the same "!dev->iommu" gate on the
readiness check as in your thread
<20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>, for a
different case (one IOMMU, concurrent bind).
