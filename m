Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125290;
	b=3t9O4L57jm2a1Hf/MfwrBVC5Wk9fBpe+NcjbBknNQqeRvqn9Eo+KjTCddyS9OJ5kUfzu
	 mgIisGJr+L96LJe2Loxsu9gY0j7ml/v2/mTOmqoSpwlQcCWT4uNrYkSWJhg/WmtPx4lPA
	 S96Mi7RhPHI3TS/TqBFOph0blAdhM3AzUhF4S4v1cT9fK3SVLTq4UeO4Zo0IK3x2xVZ5I
	 6NllsRtAHIViK+fYDBSaVk0AfO4nLL9oQJQSzTKo5Ca1/EUC6JMju/hC98drJ/SY2AfqB
	 g+p59+iMKFim6vZR6SyQVEukgg5mfdnPKIgvzW4Sj8TJkpwWEWfwmccXbUN4KGtvKjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
	b=V+b03SdgyWOFNcHN4n0upygXA9POAnsAWRFTy6ouGeAXXZ2BsQUTEnnau3WCV8AbIQBi
	 kkrZxhlZsqUwhLpqco630BXigGd0X8is7LVYODBwspbiUFtqYJNjue/sgOzG3wF+40vDW
	 htMkFt494Kiu1bJaN0xqicCHQVwTmxnqVvzGMOPI0/VbS35b2wP/yoNCMwroxbmZk5D5I
	 WPz9WhM8Q3/XXYce3dQptHvOl5PPp4VL+wKKtXI9PeCkuJktID8pfaa4SgqjmUr8H4Y4X
	 XSBpsuR+llXj5iS8sUpPaRHmQ3wOIsN3l9akPRzWpnmeEtGROyFPbeWc5IzERvJkjYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpAsY1N3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB71606A325
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB71606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpAsY1N3
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91f2dd5dddaso2698196d6.3
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795125289; cv=none;
        d=google.com; s=arc-20260327;
        b=hpHlW2zuBmY2yxmyvAzfMspBvJupCAeibuwUrsKXa9KfbM6oLQhrxlVMsvRUgPh5bM
         GGq+yzkMJGLWr+ANNQ6zMscaiG4BNcZTSygVpotxhFer8TkdFn7Uu6+BARBUUJ7Yb/0I
         VhT/8QXfaAoEm2DYKURD2mqRjOstMyXUs00r8IKsL55mUxhgUJeQHAgdOHnWUDY4LNGQ
         QQVg001bQD2t4ODNgBt6Lw7cBHQeyN27eycKH4pZS21RXIvC77Cc4FJy2AS+uolBqi1l
         YkncR+sfDNyTbBYmI6LRW2fBlihYhOi704qRsYfu2PtLsJQxmcR0UBfamtsXGcrqsMwt
         fq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        fh=fXyl1/isPJ62p1t1AhIwBeX+lBwmji8KB1To5sNjwR8=;
        b=Bc7/mYr11H2Y7UVgSTu1waQNzpONFJ5GwPd3V9/SMDHaHynb1jWvs9X0IDJUPW5k53
         daEwEsQOm+iIuaUxt/FyxXELcAzlO0/YHamHI9fUWX1rXWfwhqMJMTZQMvsErFsEJnq0
         YF6etWB0w+7ckqJS9c/qjTcFLI55Eg/uTBPZkByTbFjtNFBatQY2pRf7S7t+SrOlc0gX
         BaOrLINkC/Ml7AuulZXWmin72xlV+D5lTMlR0XWw1+QJ9fUSN02RZ4iw5qytP5ZUMtOY
         GNkylnu76l7LO57kVAz97m4w0gK3yAoMji+HkxHzd5Kga1rO1Bd28EgsMn4zQrG9Tsyp
         pddQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795125289; x=1795730089; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        b=fpAsY1N3FV2Of70tXyWKQWKTu6xYGYAI33A/Ihax+6lWHI/OrFOXK6YEt+6vWaOHMn
         XJm96u7gYJ0v0KdIjABIehFX608zd5QRZhyEzbWQpaEI3xG8gEIpJsda5CQQz3hAIkj1
         iFn2uGcvQFOrWsuYLJo3tcD/DmUYbRumimCuf5OZtkgjIT9yCWzGfxx9hCr6/Y/HZI6s
         S1srAQDWFGdxnjZfmulXjJeasuEyAg1fkIfUI8xazQV5JhEffhAR6RDnenCVsf9Xc3fX
         OiuspCGQDVCUEOCq77UKTbnJGc355J2QsYxzOCfEc4hrfGojM4G+Xvc3FXQLOkYq+Siw
         6hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125289; x=1795730089;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        b=Zg0buIcVusD8iTXxiuM0Gn1u9PFwhTdPreNgOm9HHuT1724HfpkZlOwQmrBECuPe8T
         YCUovbnEFj1B6lDAyitORX1UlgR0lrZ6nHVZ8bmem/ac1f91MSiNBtWID4RLjwHlOf2t
         IvXdZzvvWxTFFwcwWl3UqjmIVdYRVv0H4y1EclHCISPL8ZqeZhLVS2rTnV/iyvawa0vF
         5CtYyFAKpEM8F08npi7HwQHMkowXb4zDW5GWB6Nj+XppnLd1naW/MUq7QpZSnk29Z7JI
         C6JAzRWiIT0NR1rUB6abgM8YnNnnMDFjOvE7H/8wtrik2IOo0eTLeTHFElmGALJ5rY9x
         xH9A==
X-Forwarded-Encrypted: i=1; AL+hErH9Y5p0UEnwGQtQL7F4tK6snCLuvr/44jUWvy750g3MQqVs17egROJ/wRVccQysUn8ZLmXghg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nl8xcOduOuJ20OcWe/fYEvGboYg1FBFdgX5vEoGIKsrUaqyFj
	tLOrvsZrnWZVaV7Yx54TA3RE2oKvUcd42G0wvV5JGPlBS1q7iOhDnp2rznkEBB7U7Bu1VYOdOFV
	oglZHFSA21n0fdVHdwb0SXYPcJt77fDUicDAyO3Pz
X-Gm-Gg: AZFdTZeSj5OPe2NVvy6/xWBUqZx3hGbc+rJJbLqDUK+WhpwMzHmL4Q3GFmrrFpOxqPq
	w1Sqlo19wgcCXlDf1dCuky/LO5Am9KTa/i+xRWoDvPP2BaUyrwP/W5frL/wUZkrpisBhmLev+qI
	MJiI0Oc/ozQ2QohsIfc5mX5GdYIGr+AYS3WufLThbL3fBoVlZBTp2bi1yrI5fLx/EH0qlg1DP+H
	cuRb2Xlsx6IlP3vK98X65fDmGgR+WjzAdDQfPKbAGzwQXO2dGcTh+fUa+yOfqkCvgehp1+XcOS0
	aJ92cZLYdD5b4EhrcZn29199y2veeHOlV1GyKhMOZFmR+NzSPLRag9nV1Fb/hQsAV4g03qKuBkm
	Bu3kwQFcGZ4hWSehBLnEvTRFvrMJ5sJ1aPykwXlF78OKF5DtwUBZ31f1eqORngfGDETP5XCCIY4
	OGQDNoypZI3ydFJ0oTvtSd3A==
X-Received: by 2002:a05:6214:4018:b0:921:3369:a766 with SMTP id
 6a1803df08f44-92134a90270mr18304526d6.37.1795125287959; Thu, 19 Nov 2026
 13:54:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Nov 2026 13:54:46 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261112074120.1570072-1-aneesh.kumar@kernel.org>
References: <20261112074120.1570072-1-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 13:54:46 -0800
X-Gm-Features: Aa3M54oXacZEF20KAAo0a9xrzHva6i-aYhx3GSm4FZG9y6dnhRg5XpywqLRfWns
Message-ID: <CAEvNRgFKfGEzMzAHCqGv4T3YdkjFbLKjuHW-CR9V0OzYRzTu-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/16] KVM: guest_memfd: Add a common framework for
 device memory providers
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Confidential device assignment needs guest_memfd to manage device MMIO as
> well as RAM. Device resources such as PCI BARs supply PFNs directly, and
> their protected mappings need architecture-specific map and unmap
> operations.
>
> This series adds the common guest_memfd support needed by device memory
> providers. It builds on the resource-provider API [1] and the existing support
> for folios and RAM PFNs.
>
> The VFIO provider, IOMMUFD integration and Arm CCA implementation are
> available together at:
>
>   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-da-gmem-backend-v5
>
> This series depends on the resource-provider groundwork from:
> [1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com
>

Just a quick update. I'm still interested, just tied up with internal
work. I'll get to this as soon as I can.

>
> [...snip...]
>
