Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794557151;
	b=oNkv08FJwIoyqPkfeG/54xS4RlF9WUOqEYMs9+2lNeEcHfzRwGBCh/zHbL9NruSnBpwC
	 3RLiROVRSEPQYY4LHcy5EdJy2o6LRyamQrYkkws+LoKgsWI4maAUNoqX8kpI+y82sMqrh
	 NJ2wTV3WVeSVXNIjbnFrQ7MBPMYJfOOh07mAe4MvQF9jUEcTmetx3I3KyubY3sg06t+yB
	 3JbQ0LS4JL1IdBXsobBOXzWeVknD2c3g4kcqb/8Lu6FWoYMBXpRVZR3undknsks3wJ3iJ
	 z20BSECOEsviRvMlfjwSVjEa+peAx7AmLz9nxQ79vWqPWiUGS29lqXlR9oVT9/ieMdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
	b=zPOLjCo4pd3oK0Zbj+EIdn4HwXHVsHYBiqyZApEbivpA0ty8wIoGCzDgxkE35vuT/Hpy
	 ONl+GQ2Jh/FHinYHqWgW4RFljAfG8dy2XasssOMitx3ZnI6fEll7s1NdpmKER3fLSipDU
	 AnXMvM2VhQyMa71miFSpugZfoubV7Rl3BUmxZDao+XpT7pqF0FR5dXgASh0sTjGTd4oHF
	 +eLVVTJA774Oy1+VqAca8F0GCEM34ax+WSsbn95wuI6Y74AVgr+EyFiVjPJoXelPtAexW
	 2jEskvDG3zWWNdB6tpvPo7HiEHD/jbd4eneSTqrIOYnCm6EGbgroLstrXby5G/oho+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CIbCNa7m;
	arc=fail smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA145606A323
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 08:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA145606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CIbCNa7m
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c09e2ed679so61778e87.3
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 00:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557149; cv=none;
        d=google.com; s=arc-20260327;
        b=WM0Yj+ycQ/3LzHgcc6D8H/AJTo30FPYGQjwcfXpq0ri5v7sO3vUlfgoCwbyRWpkH4B
         DzTdINX5qSTaa+Uajh4xzBQIiRCViUmkZzKNGqebch0BFnm6PKULRvpSsxfbtJyUOCov
         LzEH3JGcC2DGyC2McyOdbKJSUzD+RWREDHnzoRsHFsdmSFgg97/QRPwpOyDUV/2abLlI
         AaMshu8uPVwU0uqbwmI7Ob4lZy8KC4PMk+gPDZhXFCAutRdMYqgjTKbKmpX4DyA+UdA3
         Essr76PwK5ThGgZrkxIlPuVZMuEnIKeOR/q0xqoK3gc+a5QOoWWH/JWHwc3CFdIuvoq7
         adnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        fh=ByVCUsV5ZWY7watlsIuNSPi0Nvqnn+adE7JP16siueI=;
        b=dkzVbUZiZpdhATpUUNVS8H4030BOsAtAy7BUSill30eyrYQUyEWzGiIdvomYwWXVBe
         YMAEimh0Us/OiZSjvv78ZMWnYopwLnQf7VTLl1IJ/0O207pVgxuMgVtmldVWeX9Yei1m
         lcJeM5dWEblH9qhDVF5soRA7DShVwFWDwEhIzC9eMCWZRKQM/jo+/pax+nT2frE28pMN
         Et2ITbqchY3pmtum6Iwbom4yGKLLO5aH6TTweb3rds2LcyKLESDLWTy8bLVHvkchzVNw
         8JiHzrmmT3cY/SD9Pm+xfSzOjuwPLTSanvbK6/Ohy0Y+hZvJfTh/+hrOdxXzNpUPkogI
         J2qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794557149; x=1795161949; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        b=CIbCNa7mVzPROCTYtjFnjjXEHftHWfX1iIHZpu8r7udAc7OXU8Jz1/f3FFXvJ+x/MU
         S1Z90xR5hlF4Te9P1R6I4I1XUkx+14fX2hAO9AgZyPDYI9EkeFTIkqEg5SOSsLBFAxqr
         s/SQggO0/HmEdGUe5O8hay8pJWHDRQXdsJpm/SDs0UrjXa1cokvfAzchA137XjjFaZwI
         R+6GLLfAfAd0EX9jjenozD/vUP62JB3P48KExE1gPjrhq+oiFLSx60PLNR6va+CTHJA1
         Pf9vNzkDJJog/NEn9OFfZ0JoM1agOLQhgV53l+G7f9qrBmuBcLjvp0O4kEG3DrawLClT
         AHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557149; x=1795161949;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        b=xZtrwmw2R1Ep0bYHaf6MyFZASD+Ha8R/Y+wl/oRg5J6iYhvMfB9sfZbwUYucLivmJ2
         +vXWOo5Hyv/R7OgcgrtpeWA/NECs8PBOEb4+M27LBXKdvrX3VbKc349jvJvhgweOVJB8
         GE3mYGUs6X0W/4HNygxJTicY1xl1jzPHMMyy1kCZ2+FMlCCsJX8hQuH1eqLRQ8DJWPuG
         Htzr8zT5FNW3gl0K0DYpsiIQUpOIh0pR7huz2qUjAM8dvkzy16wwszvgiqeAk9uM/G1X
         2vLl9TJPNHJRZnl4qgvEdYLKZ9PH8uj4BEqsAqaK/79Sq+huEg4Iu+s/upJCQy9EBB+9
         0DdA==
X-Forwarded-Encrypted: i=1; AL+hErGN8VerZdvQV7DOcbGLYGxV94t/YRwY7K7du/hZnRf7mvWDKIsfh3+dOQaPGqfFKx91YY7cyQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wWTkUalcbQ8GMouclntcZ13vqKDTViwsL0UCEIY5To/rQ8oEl
	Hn3l1x+HOXMXLgS2Jw8jZ0USIQ+WTXol8DafRzEqM9yVd9czewTMYWMu0Bt0f7v1xz8B+K9lig1
	og4FPBAZE4qhMEtVn8Cem31xYR6AdZfI=
X-Gm-Gg: AYBFou2ehkuL+Q8HfV1O8OGXr1AqsjBUNEGO/MYMMiAoljA0tBxUzAOddwzcUqCC5Z6
	OXH4ewZTmwj2bDgOAPpAuJAAmdb+yaOXfDIg144iLxEP1eich1nKv7EthTZteAi/3UjWIaxdeeZ
	VaS046787HMJmMZK6wp0QEeOXeVse6ApdYW+sjN0BzAZJWWo9LOZAO7UqXz7GKUl+NLOsx6OmOn
	gnhKeQ5iXU0RDRgty+T5jvxUG/cUrcraOpRGqQhl9GagELC4x3QyZnc6stFZkcRzDfa+b3keiN+
	G/pjy1/yK9fSHAgL1iqxGKRu9ENdMCopOR0/KBmppoj3pStorhfEcqSDsYDujV4cXYWf+Ql1O66
	t7IwjvcI6lK+ebRp16gtqM7hCcMHB97W4qj3sacoKMjMcm3FI6chw3nVj6ItMDJY8359KuVc=
X-Received: by 2002:a05:6512:402a:b0:5bf:b65b:8598 with SMTP id
 2adb3069b0e04-5c1709b1f34mr794456e87.3.1794557149007; Fri, 13 Nov 2026
 00:05:49 -0800 (PST)
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
 <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com> <472df1c1-e1fb-454a-96bf-4a01dcd383aa@arm.com>
In-Reply-To: <472df1c1-e1fb-454a-96bf-4a01dcd383aa@arm.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 00:05:35 -0800
X-Gm-Features: AclHuK_Zihm1Bupd39qxey-TRk2fUNcW0Um962FEVnw_RYjI9CzqXZG7YgfHzoU
Message-ID: <CAEy9hNUW+o_6jN8=7RB7e-6afyiZOzLZ9DQpFOKTQCoPfvDD9w@mail.gmail.com>
Subject: Re: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [...] What we could really do
> with - which might now be viable with the recent atomic device flags -
> is a specific indicator that a device has got far enough into binding a
> driver to be past the point of waiting or an IOMMU. The
> BUS_NOTIFY_BIND_DRIVER call is in fact in more or less the right place
> for that, so we could potentially do the flag management from
> iommu_bus_notifier() rather than clutter up the driver core with yet
> more hooks, but the flag itself can't be in dev->iommu [...]

Thanks, that makes sense. v2 will add a device flag that
iommu_bus_notifier() sets on BIND_DRIVER and clears on
DRIVER_NOT_BOUND and UNBOUND_DRIVER, and test it instead of
dev->driver.

The flag alone doesn't keep the binder out, though. Its dma_configure
runs before BIND_DRIVER, and while the replay has dropped the lock it
finds the replay's dev->iommu or fwspec and goes on to probe. So I'd
also defer the binder in of_iommu_configure() and
acpi_iommu_configure_id() while a replay runs, using a separate "probe
in progress" mark in dev->iommu that is set only during the replay.

Does that match what you have in mind?

Arun
