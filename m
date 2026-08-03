Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90133A71B
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754449; cv=pass; b=Kxq036G3bKt8ZjPytKoz6Mmro4Tcm+wLUEDmM/H4wKWTA9aalXblQ+QgPpObsat/7o+3M1oFQrC/Oz81ZRL/qS3RDmnAfuDanme8G8DNhfo+8jGryYmURKyiV/ohB2unuS2v3qefje/LYe9JXdi5eKU30RSTBVX4ZznryBKBk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754449; c=relaxed/simple;
	bh=xzCairU6IJG5sPtRT7A/BsD2wq9hPxLyZpXhYTWkbGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdLo67v89UwqgS8OrnscgNoNz83ueq5zAQkkdAp9BkScXHRCMArTZhox/YGQ4+fPIyWCEOJrtb1r35OYCurw/k2e1N0RgzK4gDszo8gCT45dNC0KiwG30Pd467kkMZS9z9Nm0CIaypRX9S2Lto5hRBmFIttEPr8IkhnhuKjIjfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=aVPZ/jvl; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="aVPZ/jvl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4ab70b882c5so1859034b6e.2
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 03:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785754446; cv=none;
        d=google.com; s=arc-20260327;
        b=NeEqURIPEbN0Hp9hVACE1cHX6CxEZW8nPPRT6Lrjq9Tuas0w197q8tWk3OixOQ/4zt
         FDdsNzb60XPPy6bkFjiWGIUXo5+0GPnh/K4XS5qAfi9ZpV6YrXai9AJtqJvvE9vuSjCO
         a3f3rJNxvmMFdYYXl8SuaNv2YOnqKNAa/kmQEYO332kiTmp0kbT28id3QQ/7OHawyFG3
         3JJlpVXGS96MKwcIsJDGWJr+9u8CJO/GQwnJVPUuvtk3oPjtEZOTLqZzMJUCA7tRSL5d
         ytezwFU/h6ShOUIzlOcV3kYyzM284PvoqM7tIihKZZxZ27kxa9p1T18v2dGsghCzO7gI
         UCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WkMM4gx2K8iT6OacR97bokA0kWNfszhjDnUN6+5+1Tg=;
        fh=K8PojrLRzZKq/N+fZ1qU1KTZX16pZ5fcNhA6VewAHNU=;
        b=ZH9qn9Kyhy1BlQbgHcFGH6XjKOlzZtjFPL6QPfBRMC+K8DMs91hzFvqrvkYT+HZEn2
         4MToWKiXJuF3pC3aXME8v7mqvHrCqeahBubAtW7uGGkGIIbd/O4bGPUEOAbfGvEKvOK1
         pEHVcOW4gHByUz/uIQCi2n3qtlkUS/QcPtfOCXV1j/MiSRipHGSjWvD2b4ZF2nuhFWxk
         5TXSFGrDvL3ZuiiFlN37/9fBEZT2pywtPOdj9Zk+xL6oO69nm3HJvDAp8DMx/GQ3l0Sx
         vYCEt5xbwkMaVjteRbxelZOeole5pHhYgM7MK4g2UtoR4q4yXarft8qVnSZI7gQDGRr6
         0qXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1785754446; x=1786359246; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkMM4gx2K8iT6OacR97bokA0kWNfszhjDnUN6+5+1Tg=;
        b=aVPZ/jvlBu4p7QPskWdBb5k866vh7QyQUVgQ7Dhd7y6aqeekj0aQjx59oDhiN1IBR5
         rJ7AzuqmyzMSpyPvkLxwmyivRTAo8RcEhwQogdb7ldgMorF1n4PM1YjJgi7MGLfFM4Vx
         eOT6hIlK9+DAxwqBz6Ighc09SKfHpmZDpvqL1fITQ5Ew99L1keQFk3saZAeP7vcI7Npz
         mLQRattYemsLOnMozzfO6vDYgt4o9bKQIN8yotsPLmX3Ffle8Z3YQt3f7s1Jj+6U/Xql
         SapKpQ0kNJv6Od6tk1lzORLPQC4SzZo3XxRKoV1xFrf7+RcjDUqDHmN9k/ImvYMSk09N
         ksWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785754446; x=1786359246;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WkMM4gx2K8iT6OacR97bokA0kWNfszhjDnUN6+5+1Tg=;
        b=DKwZAXm2YbxjeLfOLNqeg4BANDVX818m6XIKQF0EvzXSjZAiqaUPokG/Xq7ESd8Hux
         ePkMm+xjw18fhXWKDvmo6H2+enu3q79cP5nFgJ77F9W7S12rL0TVt6JHAggOoS6QssYd
         /3AzRrzl/rXW6e7WIBS9bGhm8abRuixtNKrOMEVKHZjPPKPk7NQfG7BmB0hGYU2os9MQ
         TnAmW1+LwXLVXD6A1VTA+gEKdRQNiaXdUvJnDFKmqkiBiYev5a/PFGSvYIM4nvfbmuE6
         EeFZpxnJaea6ahOrN2ypgf8dO1KwYdkY2kLDpjaQGPJTkjT911paKXUR136D1YkNlsJL
         XEhw==
X-Forwarded-Encrypted: i=1; AHgh+RpqZR7WCy4GdZ44jqakMBFOw26j/uEj4CZbNz/5we7sgIR492EzKxu4fTjYZmWsBl+zoZdtOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YykGplewLnEce24wYHPilGOZS/K/hyUe+VS0IPR+OARW8nqkPyT
	fRt1yreXr6AE0sGkkuPAVswQDyjTPgRDXhcenYMonLUM9lSRJDG1D1tRMkUbajQSQbLKkSD1Gnq
	e8AEnGq0qvQcd07Q0+QBcIZpZsH8agEgMA8XDgC1WHA==
X-Gm-Gg: AR+sD13I8CcFuOt8hTcoUSMayFrvpvm9dJbAi6lqsrDE93ANJSUO8nRYxnQJV2L/ten
	zGzDubNWKoC9NY9eVCvALNGLPEbTtrLOVbyP3Yob3stgYaMvgxgYUMFPQltL5bawmiQtX8Di6sv
	WD4DQwBJijkOtWqlWeakeguArdChS7v/Jr1YmS7rSt3fSshZ2V347v4aqmCUkOUErmS2dQI62VZ
	KdX1GCm1gB+/YQcUSw387CIOni5lT4Rv91zeRY5S0imkjY9Lf7aKpbeOgQpCIJv97VFwJXN+9aK
	fW8jG4u9/2L7frvJSknmFHYw7u5Lg4tjMlg8NwQX6F/4Yv5lVt5KVtqiScVUDDRET1jfFwDY/4U
	F
X-Received: by 2002:a05:6808:159c:b0:489:a387:1e29 with SMTP id
 5614622812f47-4af5e3016cemr15807503b6e.20.1785754446430; Mon, 03 Aug 2026
 03:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <20260730-small-solid-spoonbill-8a8bbd@quoll> <6d9b28ec-0905-4cb0-9a62-980c7fa69572@reactivated.net>
 <e4dece11-ef3d-42e1-b179-cb710c501622@kernel.org>
In-Reply-To: <e4dece11-ef3d-42e1-b179-cb710c501622@kernel.org>
From: Nick Hollinghurst <nick.hollinghurst@raspberrypi.com>
Date: Mon, 3 Aug 2026 11:53:54 +0100
X-Gm-Features: AUfX_mytTkO-AkNzCG_mHrIojcRJSCw-VpYldbwKB1TRQ_LSnTcKOsfcIgvxdHU
Message-ID: <CAPhyPA5K6nBAoSiUOyx3EF7mu7AHP6pEo5u72Jr+r5WiLo7cNg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Drake <dan@reactivated.net>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Sat, 1 Aug 2026 at 10:15, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 31/07/2026 22:34, Daniel Drake wrote:
> > On 30/07/2026 08:00, Krzysztof Kozlowski wrote:
> >> On Mon, Jul 27, 2026 at 09:43:59PM +0100, Daniel Drake wrote:
> >>> +static int bcm2712_iommu_init_cache(struct bcm2712_iommu *mmu,
> >>> +                               struct platform_device *pdev)
> >>> +{
> >>> +   struct device *dev = &pdev->dev;
> >>> +   struct platform_device *cache_pdev;
> >>> +   struct device_node *cache_np;
> >>> +
> >>> +   cache_np = of_parse_phandle(dev->of_node, "brcm,iommu-cache", 0);
> >>> +
> >>> +   /* Fall back on 'cache' property used in old/downstream firmware */
> >>> +   if (!cache_np)
> >>> +           cache_np = of_parse_phandle(dev->of_node, "cache", 0);
> >>
> >> NAK.
> >>
> >> You cannot have undocumented ABI. I asked you to drop this at v1.
> > Is there any approach I should consider here in order to support
> > existing shipped firmware versions that use the 'cache' property, or
> > should I simply break compatibility?
>
> Kernel is being shipped with DTB for Rpi, because firmware is not
> embedded into some lower fixed storage, so there is no problem of
> compatibility with some out of tree, unsupported DTB.
>
> And no, you cannot use argument of undocumented, unreviewed ABI in
> downstream forks as reason to add such ABI. This defeats the very
> purpose of having upstream.

The IOMMU cache is a separate block, shared between multiple IOMMU
instances. This ought to be described in DT, one way or another.

Of course, there's no need for back-compatibility with any downstream
DTS, which can easily be updated.

Regards,

 Nick
