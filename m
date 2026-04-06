Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1814136358
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506849; cv=pass; b=cM9crHx3we5LAfcXRdWJZ+Y9AxMlgBgflO6JekZpPpimamDX+kZhAwP0/yL3k6qaXSQ4yG/aRlHT6EMCorviOvC5beq9G1Cto3DJIiy0PPAEr9JeUwNZdAyJzj0P8S6KX4maSRHsFKgAo6fQVGVbiSocJS9huKES4VwKhxph/Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506849; c=relaxed/simple;
	bh=Io1U+2H98QfGuSNNSPp+Om8lrtZl2OSidEXkxdnTsLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im40s0VTQCmhHOj/fxqwrvh4RNxbMAZuLGs6L58Uvq3qG3RB+8vDQv7DDe7gDwUF8LEczv/EXyxSAzlmbfywkAzujq0buZP8XJPLnww6qJBcYrQzHAUasKYXsxE0x60mFEIRKsPly0eMuRyG4f0rV9Y7vZiMD3BnNZ0vW5oYjrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHNWpX/I; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHNWpX/I"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so199755e9.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 13:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775506846; cv=none;
        d=google.com; s=arc-20240605;
        b=WNcFXH/6jdH8jRWyAsA/HyOWbuer0TArhN2N3CkFx7yCYC6hj8Snzf36zLgn/KxYN4
         OXGq+3F4LqI+SgirHDRL2yG+5xkbIDIOfpxFevquEU2AAsnJP8UMhg6tR4vVtemNV2ub
         48r9/qiiMfIUouqhzvZ/QqN+lwOSw+a7M7CxrzU1safA4z39H5E24MDU5b6rQLCZFmfr
         4NLJzGND1oWyfmZtoBChb0B8F4SgGQ7v5738kEcEyxUd31JoVjjrA2oM+/j16twU/aE5
         wCdtqoMMcnbyhIv0yzldjfNU2d0T6nS1bBaw5zfTPMPaL3iltw+5mCn2l+iRP26xBK9g
         oYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
        fh=nCuNE8s+9WTRgbd1O0MQYPvM37ZFnaRozb0/pFioVDo=;
        b=aFj9dYpoBVFsGnnOBl47r/eWALdqzIxn6N2rkDPu5E/PTgyK4mGMu+PDZg9TlzB1cY
         3Vt9nO7CakPo4bxmnR2jLCpHakWYizVGGet7T+ulFk8C5sAy6Rd/mgMDcuCz+zY6tMGG
         4ABjciRkETHH7B11HGGyVa1kibsV5myIArGP6tAsh0B17FvrQtlvzLSNXR6m/QrigvKY
         2GPKDZvW+ffTpjR2fOh+IoSB/eFFktuqNYmFvDX1XlT+upn88kbIbSKLF3rBKpuqSkaU
         k85lvfYLnG7zdzWVTMPmmZXdnMxPXMfqBpQ1mtDY9avopR0mvDMCUJusNRwf+mpKdZU6
         fPFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775506846; x=1776111646; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
        b=WHNWpX/II57I/OHGOky863sAzLjJHU1C7hjGlvVqP50IQpsrBUWdIKXUKSS/2vCb3P
         i6oXUGczBjHLIRFG+zE/sdyj2xXNu00aJg27DA2DV8AXyDIZ1Ud5+SbOeLEgmYx43xk4
         r8sx1ul68sa2Vuj749zi6bJeYY53Yz0svIsMvFQogpqMjgzHyi9pAB6uPejw5PpCv8RL
         ynq5uPUejdPgIZlDZN5nbc7ko2gIVDp5eSSq9d92iwLEnzs9/7tT3VZ8JB/WUYb2DqCw
         rLJJVbX8q4pJhvd4KOeP9cjAZDVIhzkkjNzNHk3u/kOV1FRbCg27oh30SUbGUM2IUs8W
         5iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506846; x=1776111646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
        b=R6D1BHo88TrFz6SzutObxhcyfPemlht8JmXdRi2nu9ZRo6mtKGNyH1n7wVIzfjAhbw
         xeYg72Xjzh4gYlzEjlyiwXOd90pJEsSZ7HPCAGGTOQGx6Ziym2xBcsrBmbADNWduxysb
         5gG1DHcxscqNFxrVPlPjivEF34StdEYE/ASyIfmRLdu6hPbFxsbNnZZ8d7iRztaq5vC6
         R5VpKuDrUab5HXnWM6kNy5Bz6rj7OSgfUHdcxvkSjpX+sMXqq8nPBAiIaMp8Cq1wC48Q
         7ADR71ZGoxq/DjAnfXqTE287rasgrVjJsn/tJOeDvTiCJxFa8EjlVYxkI2zWSf4lJSHd
         9Q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk6TOWocjcu2tODW/aZZGEZg4JsBDnrMqpVgAwblGOS4b2HW3ou59d3s+rtq4pPlPcj3FeyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+X45/BCDZSg/WufiBYYDfx+vDBxRaEMxZH4Z02Qvn9LJwWeUx
	TRk2XnXOluEOJ2Uf1/PeWiumUbdmVR7Iyknat2wV4qlJRt//vBXkTwj4j9wH2QIN4TNWhDCfqb0
	q621o9KwAnlSbWB+lLNJPdIdB1C4zIpw2ZbiVxjq9
X-Gm-Gg: AeBDieuqsjD2c5XVdRJyO3eXRD8M/WoFd9HrWTQrYgIBjowu+sR3z81xFbDWHQ4Sqa5
	l9p7KtmI8Ztcl8p2EZZoYxGLu6if23H07Ay3Vpd52krgm+ApGdcRoYf/wXUQY/nV6dt/R++BQfO
	Jdx7vtm4fC/il+OwtZzsqZOQkTatcOGoD0UXgq5BFMoBVzM7RCgPum5o6C0zDfh0gxEe2iprcUl
	MZWyzbRrpB8n9ttBNVmUHxA9bXFyreFGSHkNelDQ7PPTjR5c1CEaZq+aKYlP6pq1ON0hvwEhOEa
	NTx1aiiFrYu/GHnEmSt0WCVAu+dS+7f1F4ELTg==
X-Received: by 2002:a05:600c:6b19:b0:477:86fd:fb47 with SMTP id
 5b1f17b1804b1-4889a458061mr2963095e9.8.1775506845674; Mon, 06 Apr 2026
 13:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260402141103.598495-1-jiri@resnulli.us>
In-Reply-To: <20260402141103.598495-1-jiri@resnulli.us>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 Apr 2026 13:20:33 -0700
X-Gm-Features: AQROBzBphM-pvVrX6rS78TlEjxwdox4kg-mNa-24N1cUfIDHIUevXFcYB-smPLY
Message-ID: <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:11=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Document the system_cc_shared dma-buf heap that was introduced
> recently. Describe its purpose, availability conditions and
> relation to confidential computing VMs.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentatio=
n/userspace-api/dma-buf-heaps.rst
> index 05445c83b79a..591732393e7d 100644
> --- a/Documentation/userspace-api/dma-buf-heaps.rst
> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
> @@ -16,6 +16,14 @@ following heaps:
>
>   - The ``system`` heap allocates virtually contiguous, cacheable, buffer=
s.
>
> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheab=
le,
> +   buffers using shared (decrypted) memory. It is only present on
> +   confidential computing (CoCo) VMs where memory encryption is active
> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
> +   bit cleared, making them accessible for device DMA without TDISP
> +   support. On non-CoCo VMs configurations, this heap is

"non-CoCo VM configurations"

> +   not registered.

Doesn't seem like you need to wrap this line.

with that: Reviewed-by: T.J.Mercier <tjmercier@google.com>

> +
>   - The ``default_cma_region`` heap allocates physically contiguous,
>     cacheable, buffers. Only present if a CMA region is present. Such a
>     region is usually created either through the kernel commandline

Each paragraph starting with '-' confused me for a second there. Those
aren't part of the diff. :)
