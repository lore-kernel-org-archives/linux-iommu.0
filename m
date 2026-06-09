Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB21285041
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012679; cv=none; b=RRS5C5VSuVFImgv/BVXEEA0SBaCxvC7Y6P72i8aM2TNbm8nIejDrJ6uy78uIaluMnxViCreHZCmnPtYbX7YGe9u/j1D71QN8PJJr03pgdSXioeU8tNrP1lLx1GkLAAQMMGOBbHr6MoNmj3zkWihJ/LXcVp2N4Dtbn/uXv3btJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012679; c=relaxed/simple;
	bh=De9dpWLqJDkTwPqqIvLBYIkFXDqvYTvryiNP3i+XxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF3flVjWXbW2eCl9Wtztn8GdFdA7DgOGSRTzDnadvAbcjJ6r3IRXd2/yhRj4XBKHpNI49Qmp4wb8w6mH7Wgl1/klLFG7f/5CAIKhQrfdEw+9SXV2yYukGsk9wi+5gxEtB6mYqU00WcRvtJmFMBXxbpLmyBc0HqDWAHZSJiwp+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MVtSYkw6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MVtSYkw6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45efb47aa6fso534805f8f.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781012677; x=1781617477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=MVtSYkw6Bti2PLxWtUzOt8QMCPfGEiHgd+SZFHmlDz22isaz5oRF/iX5F1W6QnWrfT
         NxrVtIBWPZbyJdB5/4NJzp6Ed9833sxBZxUSCP0s5/T9krX6IEihJcU3BlZ0plsaEgIX
         lf0Ol3cvkFET/nZDdcdpiOFqq6tA8GLuRgOX5n+wIl3F0gNuDYUf2s9KoX0sqxzR4Pec
         QktDNjBg+of5Lpq1eWlVj8aOFJsvISW9f4KUARUBr9Xwvc2rGVRx7e54AvNbDOnDHCcA
         ahI7y5nhc+3/3wiLHcKaBNIrwNn6bEddezOSCA/oFdBN4lA4duygoNc0r/beb41vLc0W
         PqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012677; x=1781617477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=SL9Ujph80EgKnriSjGvqVkxLb4uXjssV5BEfmA1PePzpLRAyvLPXmJTK6pnYTmtwiz
         imZ/7zhRWFcuw0hos6IJ5ouzLg51ZUKC9aWp7VBc+3IeI69WESyhIY43ZbqGBluLJbwH
         PvQX4j+/+ZeLv1Z6hKhqklmThdm0xCqJAxMpkOtgYSYvrkU0r+ZqIZnffpdCzSaVltQO
         /uWBV31JoNOmHOgGiQknSSuUluMekut+oHhV84aBxQt2TJAuhiWG2EEaHe2x0dGoFF/B
         82bEFAzxAE4KNOz9cakekDohkMWku1sKLd/eF2t+VqoqnJFIaccgOkOR0LbfwXsEE6+B
         lzHg==
X-Gm-Message-State: AOJu0YyI3KLHI2UgEfwED2uJFhc/K0WMIY9NtBdYIquRoTiwE96htqSO
	tKWiLT1tztz2tT8n3ENRNo3Ysn1IRDLrUnw8dxWsArnnv+hWz0xTg0bL3mNe7EbHbFs=
X-Gm-Gg: Acq92OHg5Y29voX/GT3gtC6NiLZ6tTX0O5buTuATxMsCaxFnwLNjz3vzNnZiQRRG1c7
	f+IEUB54L9s7jBp035HAmyszvbxYKs/Ra6jUPvB3I8u7zMz4ei/ctWDhKpGCVabk6ijqHDpE9bl
	2PvJ2jk0aYTW5DH3piNO/GDb3n39T47mlVHgtcZh8/VmoDtIRl4zb1AnVZz++hyAHHAL7Z0jKvN
	Fzm/5OCofSycGb7mOSJzbT+aWqXYZapkfU227csHlVTwWrtH5mB1vz6CZbLJQgvUzkxNQOIKtXA
	1IokFBsoW5SihuUxLaqPUJiqWvnrAMi9if31WhMAHzS74g5gJZbTfo8YeEzYVax3bPNEXG0xtHy
	+O7J98/q1f2eQNKAyQ9AC9ceURc0xoCCWiIDL4ZLZ2U50fwcaKHBmi6C9h+k4Ls185Z96VKOdbW
	bsMo7YA6HWZpXomOfgnwMwE4gXiMiljzmLwg==
X-Received: by 2002:a05:6000:715:b0:441:1c35:4b79 with SMTP id ffacd0b85a97d-4603076f62bmr12393402f8f.8.1781012676663;
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm66805957f8f.36.2026.06.09.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:44:34 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 20/20] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260609154434.13dba7b9@mordecai>
In-Reply-To: <20260604083959.1265923-21-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-21-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:59 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 1 -
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 526f82e9da45..af88ca7182f4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,7 +15,6 @@ struct page;
>  struct scatterlist;
>  
>  #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> -#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
>  #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */

These constants are kernel-internal, so let's not leave a hole in the
bitmask... I mean, what about changing SWIOTLB_ANY to (1 << 1) after
you remove SWIOTLB_FORCE?

Other than that, LGTM.

I consider this whole series a big step towards saner handling of
encrypted/decrypted memory for DMA buffers. Thank you for your effort!

Petr T

>  
>  /*
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e4bd8c9eaeda..81cc4928e949 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>  
> -	io_tlb_default_mem.force_bounce =
> -		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
> +	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>  
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)

