Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903993403F2
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635810; cv=none; b=mKbFcb/hJFkTA04uw7L4HKFCvO2C+MOprWmXpgROYi1UyFTtI0h9XvgmJBbR3R++ckiaJB0LjAfOARZa2upXhslwtFyK1vzJb+jt4t87jIvEWjO7U83ffqAo8dIVbvDgugDewvPlwKrSysz4/URKsDDNPlOTAvQqbFdBvFZZqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635810; c=relaxed/simple;
	bh=MQ70GUo6Al8lXOJcr2PlWC8uCB3dRhogRoP/FLW6/Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl0m2ZPTPAkTyfqLluOx/WUZoeZmMVgBlhvO2NwmLjwmqbAphnqx8EtBfUpmeGUL0jsb8+pzythh9Fsiefses+bY65hVL0inoWZZTazkS0RIAxtmP+p0xUIWOUaiYrPrS6rfK5R5TI8RF0cc6mGgQkMxMTPzS2dxQAztqIw8O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm6SyDb2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm6SyDb2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso20266415ad.2
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788635799; x=1789240599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4Ym2Cy/+2xCx8lotVDxU3Xy1r3ogvpZwKy3EYgHfC4=;
        b=Qm6SyDb2MeRqQN/H5vhutPkURRShRii0GgrhRF15OgS/zKQ4RGtvAB9T7x/hYGNrgG
         bRzNzLchmLont4GgVWbLxOq76MO9sB4YemnyaB5JKkhPkmmsRHPMDVNYbSFpq+RHCws8
         nap8lotzE2lYp1MRLlmRuyIg3NKeW4Uud6Q1AxS6B9uTpuY/wkGKk7ZwPuK3x7Mp7m6/
         e+eS30UaV6BEjPDmDtF07/lbS7ZWaDWQkfr01cKcvgiDBAZcHd6RFZuXsyn/4vS7pu2H
         F0LjwRNbR7eJTdOflxYw+602nhFy0XIzaN4cRBrGlGFWDIx/IfGEwloGUQCuVkA6PghI
         P/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788635799; x=1789240599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4Ym2Cy/+2xCx8lotVDxU3Xy1r3ogvpZwKy3EYgHfC4=;
        b=PDmp8IRxRtDsvvGj/DAkRPcekZE1D4EFqNJoS4UCrxhoRZ8e9LOuzIHrLY1OQJO0X9
         ihdOn6WE5LuwfoYIUGoxGPz88Bxkjb4+eDrIFtiZmXEwpGraAou2C2YhbuHxRFouaGfg
         GZo6r5P8DGbeIySohqWjtE1R3pWk6vACqPW8+d35bupcFku42V15wN48SHR9V6ivd+U3
         R1cVsBVYfT8KR1g+xmO6wFPx3ABQRnQIa5PASoN2E2jD1g4aD1+JIY9THNESh0P739dg
         iOWRX0wcYCTvnc62HjBvoSHZn1g+Emz4Rl9emzWKYnsaak4zdjeMTGSf/ILSyEhmFZTN
         jWdw==
X-Forwarded-Encrypted: i=1; AKwUvBwXB9z0dik58mUBUOOSA1rYkH7sYfuKzWMRwGqvaQ8QlIFU1fhrFcjR1jF6k9dxPjuf6nokKA==@lists.linux.dev
X-Gm-Message-State: AFuF++nSf37oHQP6lWOn3dI7NgqNXQNigmLEwi0HzzRh9iFTERRX4PEl
	VOWoz/yeIdED8gVwaCNWuvbZeEo5dQl/R//n5Sr9+B70HGyJoSmEyQk=
X-Gm-Gg: AYBFou2Ke0itzcYcP/N0yswk+9u0zu0rFImfZCJleT66D1jd1QD+71MT30tga2mqf/g
	iOb86mhHhraa6vH9hlPj7GMXmzhJMCDQtRLXwJcQC38eBFDaTG9R9dRpIbepPoZtBbFWM6cQqCV
	GPD3tAf6vUWtgx/q5iC5sbGqJeMFpfCwC2iTth+bv9SLmiMLmMEkg1i5IkUb9YKlZmG16kR65an
	VoIx5koXyTq2+rTdjj2wwQEnjAQfkEUR0T2MurrbtRxatVqSj5d5cTFhLvXOY4rWdaXZcmmCjKV
	iNPrSdq7hX58q91veGcdZOvpZRuIbUDK/noYqiaP2/vU+VsqU4GHyvo/cNrERaWlVd1o9opOR0Y
	a9AwQayveCJWRw/kVgXtn1ibTkBovOFxAp2ku1QrnRRbrrF1gzELA3kDJOoqjWx499ZwRPp4Ft8
	OeFPSVbHCGVVWTpDcAEe8MFmcN9GXROC8L6I9IeRjTUaP+8fbe7UI99sa6P2Uwf0J5DbcP/5W2b
	SfrjKqxvX9l0+E=
X-Received: by 2002:a17:902:ebc3:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2db20fa96d6mr142156685ad.13.1788635798877;
        Sat, 05 Sep 2026 12:16:38 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499dad4sm24859645ad.55.2026.09.05.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:16:38 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the allocation fails
Date: Sun,  6 Sep 2026 04:16:34 +0900
Message-ID: <20260905191634.179897-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b36f40ac-cd77-a480-d558-139334334b16@linux.dev>
References: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com> <568a4f04-e0db-342a-13a8-886cf6b2a8ab@linux.dev> <20260905172650.158565-1-donggeunyoo.kernel@gmail.com> <b36f40ac-cd77-a480-d558-139334334b16@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/5/26 14:37, Sean Anderson wrote:
> Ah, I see what you mean. TBH I would just do something like
> 
> cpu_handle ? *dma_handle : NULL
> 
> to make it clear what we're doing

It would have to be 0, dma_handle being a dma_addr_t, and
debug_dma_alloc_coherent() reads *dma_handle too -- it drops the value
when virt is NULL, but the read is still there -- so the conditional ends
up written three times.

68b6dbf1f441 gave dma_alloc_pages() and dma_alloc_noncontiguous() the
if/else split rather than a guarded argument, and I kept dma_alloc_attrs()
in that shape so that the three read the same way.

I don't feel strongly about it. Say the word and I'll respin with the
conditional inline.
