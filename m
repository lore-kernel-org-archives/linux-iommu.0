Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5C2E3376
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598840; cv=none; b=pbekHL2MF+d7glv3DdJIO6G9/NRf8/3McOzsVby+Uqh11Iz5E2Y31WbvqoDL7uoYN2HYfzFn9VRQfZIs6JDVU37ZHET4RyyoL+x75/WJI6ce661QItRl7wmK7QskZyOmpCN3ZKB0nMxTGzAvSeXjQ9Rw9ms02pkOTZArzsTec28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598840; c=relaxed/simple;
	bh=x+IoBLuVA0H/up1jHiIASga2/T/EYTYb7rDbGXD9P0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXicCNSyEwh28ugIrvxCKc3No4f2f+zvhvy/RTlJoM5pGPXZul60dA/4Xlbu+x/4n1iFM2B5u6ftt3LcVybgmNk4npyDqO3BZdjKH2RRqNCjLiqR4f1HisUbzoPPzN7Ah8GHp2uEtj44BSw6x11fGbmKt1erBJPXE44idKqcmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIThX6af; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIThX6af"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so68168965e9.2
        for <iommu@lists.linux.dev>; Wed, 02 Apr 2025 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743598837; x=1744203637; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngxDFq1nGLdsrKZFLcmh45jEs49yfqhaJP1grV4jxpE=;
        b=KIThX6af0vHQKTte3K2hkporPhPpQo8GnUIloYI2V+yRDA5jgp34BCOgbIKVZeapsc
         51+xwKv9mFtMcpOLBblcdcNbmOWghRYDYMO4kMK2NOfEqlBtckrXd3TPXJy9ARrjsv1E
         NZE0Nci4YJDxc/vBAS8O0KLwwphXlYEjx4A2Y5bVatGfgMZbSjBt34tn7IUfaMbz8CXo
         3VtD7s5210vzSKJSMmoGzdjow4Bik9Jue67xCj/mYLtQQprst+f9POpZFfIAAb8SXp33
         OLEnoV2UoCS5KD9N15pTdANizgAezYbbjwAZf2UfrLziT2OlUt888JAtFXBgZ5uQ88fO
         1eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743598837; x=1744203637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngxDFq1nGLdsrKZFLcmh45jEs49yfqhaJP1grV4jxpE=;
        b=EOPu5FeK2Zp+9LmtWH9LCusvZOgS6piI2GAx55mz0yBIswdP3330pomTsDoglEtAyR
         p6FnXyS+NHZ73+KwpQBPvGrHr+rIX6o16WUV6+oUEBAQSAqV+zeYDjiIUQB1bV1H8m5Y
         XqL3a0Bp5hFWUhSa//9c9QD6hrPei9FsLM/XMXhPGXpoPUx1JfLqk9bCGUhjB7quuX6j
         /97bjdESP12NqDDqR7uWRGsDstxsG71rLyuvXwkVNiM/ypiyoXVEaNwssN+GkyG0Kgsx
         nKGJ5yCWYxG1g6EnpSjst3UYUr/71aVD2XbVXOHvA9Pdcovidr44AQ4hdybSJR6HoRsH
         7i+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXQH6nRTEIZ6y0g3Ves4vyxOBIuZlseS750OKAArseEESqV4nSEsxxQsoXWR2cK6RCN00VUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwClJ2n1ef7goXK+Y8a11ialtceMxBz7fLOdsuiCAAxAdSqwB6d
	jy8V1yZxZHJkqAPlW5i+hMcr7OJRDLaM4mhyRrafNIMOURQl3hl9
X-Gm-Gg: ASbGncstlbWUuhDV3gzT3Sl37p+mI7Ja/t7kqgEPsP+e9q3UxCw3CGxZnqqECBMVBKL
	QchTmADsgO6vsZ3oAaR9YXfzAHkh8cJnRwE2NjAZ2xgiES5pWIqmHjz/6BO1NKZMyyF2Rcv1Wzv
	1KZUOHw3jtpiXkNMh9ljQy7FGQUf+j3rZkww8Xwph81xZsvd39yZU18cHMTaSadIA02CKgFI6yB
	Ierdy27lXxFhxP8LC8ANbTmiY327GUMt7x194fH2foMfq03M9++SDwJfroPl3+eumAiP/3tiDA3
	Aygk7pZA7BNeGLxI9wU5NWjg8Bl3PDF3F7O1j7Im/N5zgT4n2tPoo6Sw50LCMOSMTlkbeSlsbMm
	gTzwxjzw=
X-Google-Smtp-Source: AGHT+IEicv5KsZA/zLNoahNekdHnYAFlpnVcWaBREtvGIuqd11qcLb81th3r38X1cJ6IPJ8qdCPrVA==
X-Received: by 2002:a05:600c:4f43:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43db62b77acmr152520745e9.24.1743598836578;
        Wed, 02 Apr 2025 06:00:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea8d1673dsm41466725e9.0.2025.04.02.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:00:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:00:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>, tjeznach@rivosinc.com,
 joro@8bytes.org, will@kernel.org, alex@ghiti.fr, lihangjing@bytedance.com,
 xieyongji@bytedance.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus
 platform
Message-ID: <20250402140034.0fc4cbac@pumpkin>
In-Reply-To: <8cfe938f-5eff-483e-95a1-c4029993e287@arm.com>
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
	<8cfe938f-5eff-483e-95a1-c4029993e287@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 12:28:54 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

...
> It is not, in general, safe to do a split write to a running counter 
> either way - low-high vs. high-low just moves the problem around, 
> changing *which* combinations of values are problematic and capable of 
> overflowing into each other between the writes. If the PMU driver can't 
> write counters atomically, it will need to ensure that it only ever 
> write them while stopped (at which point the order surely shouldn't 
> matter). Conversely, though, reading from running counters is a bit more 
> reasonable, but it needs more than just hi_lo_readq to guarantee it's 
> not got a torn result.

Or have hardware that latches a value waiting for the following cycle.
That could be done in the bus interface logic.
In which case the cycle better come from the same cpu, not another
cpu accessing an entirely different register.
That requires a global lock for the device.

	David
