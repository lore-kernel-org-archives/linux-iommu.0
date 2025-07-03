Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A22F3638
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555628; cv=none; b=lVwc2AlMSwGaZ7cI4O87QHZwG4fvtF4OiNN4NgeC9hTXR707PpP/KEWsbSibfibohDzo16TnBP36d/hsE5+kPXRppo7oqBISUewro8VQAadiIJiUZLFd5trTLaFx4oIBBRUlTShiRujq57RkMKPe//dFDnZPS+MIa8N817v4jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555628; c=relaxed/simple;
	bh=ypjreYPJ7DpTt9JqUM3qZTM6pG61xK8rDbalnxcM+mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umM6Uvhch9pTjiJrFJjbhFI0UqAghARtQGXUvi0B/Grwlb9dpKiyNkaEfQl9eXLBGWXewiwC43LNs7K14u2kW7KnM66JtbeW2jXF78WDoQWAlp3CvJeZpy9BtcwGTQ0UlWv8speoxuQZmek6ZOfcyoNQj1GepCsIQLAtRkslN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3j9UWtH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3j9UWtH"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eaf96c7579so28497fac.3
        for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751555626; x=1752160426; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVPzloh1oUX1Y6h3ndP8c2+rIYKbbClu7XHnxXtmGIQ=;
        b=B3j9UWtH/DSLBbbtcnt335yDGKsbbrblSnHp6Xr52I3Q4qO+9QU/TLfwM41zjfGQ5h
         kkA4mzyEGloPzA53Mh5HJBoaXROuwqffhSz/prGVjVsFA0mgHYOiTyBx5M5GCeXp2Nbn
         0fvOIup6yEmEmyYitYaujQ/KmVxYeDMxhsD63i0O+9EQe4GS6zGH8GO0z2IdlpvtXpUI
         vClJ2SvH0ZT4pdfrknVwJtQa7oDPme+jOPTQWdrR+uANteqhERLhR+sWhlx1T3qIhTf/
         8zyA9K55MzVnQUSr1yWRCCziDTWZj+oeXQAvD+87qrodApnd8kHToHJSyyxDzSGNhsFw
         7Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555626; x=1752160426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVPzloh1oUX1Y6h3ndP8c2+rIYKbbClu7XHnxXtmGIQ=;
        b=DTMcNF4ZzLLXYSM3Mh1G8QBcTntwO7Cj85SS30qefdmBjN6CMMW1PGxNxL36zy14ru
         kb2kRXramgB0MQ1ECGzR1UJQunZCMCKTOwsYh7XWLCSi+xV3ompaCiU7mYtBUlNSZspZ
         boqfxr+i/PjekJCxr8A7sy8ryBT9eqiu/LV4D5/9zTwZi7JePLRkGLdzJI0J6AHHqnJz
         sgTo9dbwPbbzZapCB1rQSWDblqb/oyWzxwV4loAypcFB8nlFz/Y5RoyhSzlBN0Vozhun
         c/aHLJw+EcSZJTNGK090lmBGEDtE6jtrkX2UfeJWhE7zA1pxN9fsOYcgGlOagxVa+/5H
         uvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjemp6YebpxOMDpHIaot4MczKJCI0ULDGeRBNw1QoA95JkCrynawaNcwU3nBPWHQhenUMZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGzZVGg8Gx8AdxYCzVL6LNUfwLbUSxA61UNjlRTwn1T0hv3DGC
	XWrdqnG3azKjmGsghx054NUzwSP6B41b8+9oS4mBLumSSngZSAc5W3PdcSIEV/VhPkyWXDPFktn
	LzkSX1qwGFN0mqyLYp/9Zsy1ub9HIXNqhcr0aAGIf
X-Gm-Gg: ASbGnct7R5aarsCaLzCPcCjbBVSmamdzhtR6elrLF6p+LVF41D1jr6e/aEroCe82MaL
	SS8+nxDx4Cbur0vqBmNUP9ManhJhxxReU0hsyH7R9k464VELaCpxbZJQjPVMsEMVgvD2qWiCugs
	YrkxqTf/0glouQTWldIa4zL1u1kCitL0ajLN4mIERK/YCAs68KcEk=
X-Google-Smtp-Source: AGHT+IFNofYLmKV5Ky0RG07x0qI3JXTBrrZQnExq8xPcLRUNb9KWtuoW/38SR0jSXaannNWxKg0dLKoxlfAIQh14pQs=
X-Received: by 2002:a05:6870:288b:b0:2d4:e101:13ec with SMTP id
 586e51a60fabf-2f5a8d3f1b6mr6005725fac.33.1751555625656; Thu, 03 Jul 2025
 08:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de> <aGRMilWhgF4z0WOf@kbusch-mbp>
 <20250703093042.GA7387@lst.de> <aGaTw7SzermpfiD7@kbusch-mbp>
In-Reply-To: <aGaTw7SzermpfiD7@kbusch-mbp>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Thu, 3 Jul 2025 16:13:33 +0100
X-Gm-Features: Ac12FXwWdPQaun6KP1n2WG90MWR4J8ZJY7tGLBNOTSkceZgMU661bsKnTuwWQZc
Message-ID: <CAL0q8a62bcjkJdKjTUbEOXMRfaCr1eB4YWeNugdRO1GjLLQe0g@mail.gmail.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion after 06cae0e3f61c
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk, sagi@grimberg.me, 
	iommu@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 15:29, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jul 03, 2025 at 11:30:42AM +0200, Christoph Hellwig wrote:
> > I think the idea to reconstruct the dma addresses from PRPs should
> > be considered a failure by now.  It works fine for SGLs, but for
> > PRPs we're better off just stashing them away.  Bob, can you try
>
> s/Bob/Ben
>
> > something like the patch below?  To be fully safe it needs a mempool,
> > and it could use some cleanups, but it does pass testing on my setup
> > here, so I'd love to see if if fixes your issue.

I have tested it on my system and can no longer see the regression.

Happy to retest when the patch goes through.

Tested-by: Ben Copeland <ben.copeland@linaro.org>

Thank you!


Ben

>
> Thanks for confirming.
>
> While this is starting to look a bit messy, I believe it's still an
> overall win: you've cut down the vector walking in the setup path from 3
> to 1, which reduces a non-trivial amount of overhead for even moderately
> sized IO.
