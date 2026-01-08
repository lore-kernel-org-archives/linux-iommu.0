Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA046700C
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878866; cv=pass; b=uiiKH1aqF9GFwjqHbWjlSv79cxDpKUYSdhqI/Gv8yjA1px8f2uO4vcxpvOafSjYMGlJ17nd4QdS5xUx6QTrugrs4dx0/lQPT1FpMcrsFnp9fIfOQiyPXZwd/lrpTczqJbJBEj2n3/OlL90jfmmmY0wVBai+7ujh2RJ1VAZafMUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878866; c=relaxed/simple;
	bh=rUg45kZKXdAkqMBdmgTwXnVyU+lC99m/pLl1VS0vvmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb80sIOGIhY9OSCsGN6FK/ga/K5oQ91ECoMfSsDtY3foahKANJQHZ+GVnvr0xTPypvt01JI8Ln6iNGXz95tEflmTJVOS+Z4k2BkvBbmcgaMERUDYYTUZbFRzt5/1TFBAUQQdr/yM927Z2Bk4bHx/SoLeCaKQafgh44x/sSVZcqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eao2INzT; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eao2INzT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ffbaaafac4so726761cf.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 05:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767878863; cv=none;
        d=google.com; s=arc-20240605;
        b=B+Ljo1fJ+VohVx0FF298IPELEwhYhGFe1CDCpWAPswqt8EbyO/xhRBZD+qBPBn0wdJ
         mMb0QGFssxCOWTwbAYlE2VaRIspXCAOQW6EII5qudI91iiUbAy4KCiwYh6IHlkJ4t99d
         sCd1OL6P83tVKudZeTUnSm7gmA7a/kppOv/FCcILx7CpnJbj6dZnBOauFdmF9CaU6bvF
         E8+gJcCWSWujrJ5MNUqhhcXDZJT68+Vn3u7jOh29cN5SRq+86sZ1DXiTh0OhTjM3bQUJ
         PTr6cCOVKssl8wBWN7ZHSvH6Yc3Nhcmi8HcT4nxgf7z3dsVsBSTjd1aSA1y9e1jIOfaN
         5Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUg45kZKXdAkqMBdmgTwXnVyU+lC99m/pLl1VS0vvmM=;
        fh=QdQdILWvlLc2hQqnp0n/8wdU4F3LkmOj3Hx2ZzpVSAk=;
        b=BJ7zIev2ViemHCHfybjTUspo78hm3/Z7Dr8NuW5c6gjH3AElDU7Kk/PkNOGFRR5R9/
         KweHPHBCOu4uC9MM1se9BGr2R1X4K2T4He6S4uDgdJilTpojDp59Fv8VVFRht0qcer9Y
         TEFFXfvT8B/7mkVrmYASWJ+4sX06rI6XpmygrMrUE2Q9/J58WRA95ZE1xJwYQFimNZAB
         USqOHICeykbhiHVD7xkU9AUMhcvw7Ds7tqkvlciyhJqjfz0oiiYqczRp8K+PL9oJXxkQ
         gVy6njrfCG2/fvAAAenjMo6A5j2fmHvQ/1ZguKZVoCZOAPnd2GltA1KwiXUvdnK6cJe3
         D1PQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767878863; x=1768483663; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUg45kZKXdAkqMBdmgTwXnVyU+lC99m/pLl1VS0vvmM=;
        b=eao2INzTS30XMUWAqNTiXbQPbWq51qws0lF5Wbd2uWKOOHMqWJqyy6rolqzRD5+ezN
         JtTLuc7eI/hdpME0/OlRptMQdLMw0KEcVX8A4GFUOVL5oAgMjXI9AjW14mfzqjLBwUcu
         Tq2Cnht13IoAbOpfsW/Q+YEBXg1WsfoFeM5ULo4+ASfTdcSqDNZH25cNyKBZZIxv3HOu
         c48f1fTNW7s49dh4DZH9NKGWlJoNx9j0bxfQqzMNAjL3uD4cKrfizb4pMrcmeRPXt0Vz
         tK+MSa/M+HDikk+pxFkEHFGPp9WA5I4APnmpf56ipHSLfDMm0HTfi0pp+t06pfKBLJvx
         B6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767878863; x=1768483663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUg45kZKXdAkqMBdmgTwXnVyU+lC99m/pLl1VS0vvmM=;
        b=WkdKpsij7nhACB4XljCqNsEGYyBj5G4F0qyqjIaRAsmIiKheTZegYHKlmco465FmGR
         LL4/Xl9xb33GBNEQZfcZmklmoiY3Ik3eIPjZoFcb4F3yJ6eo1d2gA41rCuZoNrSW0g0K
         GEeD99WfgKaiaru5mgzTx4jKJ1yNiI3eOexBpKZqBz44zIN+pBtQ+Iw5Pe1hNEpvMdf7
         SDoX7Aj2bn++mSEMR0Tw7tlNfFLVV3RBw9ry3EUdu5kfcleUpynfMqfF0CW86SaUxBTo
         m+bhUHWcBO8g0/16VLNOs5p/BYRqaNO8H6NKzNMUrhmfGlKE30S6c5W8I/aHwR4cq3B/
         CtPA==
X-Gm-Message-State: AOJu0YxCctjpYM/lJB1yIjjthwifKObhq4VmGKouxUvGjRPqeS6kcMOU
	4/3xNkwQlp+pLR5BUf/eOg6y8Udee8MLMzTsEwFoAYPAJD5PO2U3n6ASAjA6EZeTh5oKNCHUWE9
	64AtFXKOKTHc9o7RWdg5CJJoFGmDBbou0sHMWNfnIIolXcy0CuDPmVKYapNw=
X-Gm-Gg: AY/fxX6JtAUL16+Yh7cb+U/jkVt5ENMNCmvFb4iM4AwNDGNYsJsllcVAeapn2HIHP7X
	ZajyEtSBGvRiA0t9yBz/dlhGBQjn87CY0lsF1v29XCkD0foqbeSvqiGeQosAY4XL3nBYtmD5+T1
	4NB1eD1fDCpnOKNtpcm4niZS0jCIRKkgF7jQWT/+YoGJambMVZJfCKEroH0OuASSxrmPTV5b0M4
	X+BC05LaaGGrw4xgUOt3A1+mDdyrWbfB4SMSCrkTUq/CbyampaLKUHidP1CTpWp6zGH0X9NHXX2
	TwrmuJHcpw0rtPRXjsWCPz+9Lp1LXg==
X-Received: by 2002:a05:622a:120d:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-4ffc094eecemr8503661cf.11.1767878862613; Thu, 08 Jan 2026
 05:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260108113846.56179-1-smostafa@google.com> <20260108125934.GB545276@ziepe.ca>
In-Reply-To: <20260108125934.GB545276@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 8 Jan 2026 13:27:30 +0000
X-Gm-Features: AQt7F2o_Qbifizn2oH0tHC8NOTIpDkZD__WQsOdMvWghmYJtGdKDy7Vhh49RAqA
Message-ID: <CAFgf54ocNybHR_Mp1+i7cff-jkeMUV1QxBCt04jnKxwfwnyUfQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:59=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jan 08, 2026 at 11:38:46AM +0000, Mostafa Saleh wrote:
> > Jason pointed out that the DMA-API calls are not really needed [2].
> >
> > Looking more into this. Initially, the io-pgtable API let drivers
> > do the CMOs using tlb::flush_pgtable() where drivers were using the
> > DMA API (map/unmap_single) only to do CMOs as the low-level cache
> > functions won=E2=80=99t be available for modules.
>
> This isn't what I ment at all, the iommu-pages.h could do the flush
> inside itself using the already existing
> iommu_pages_flush_incoherent() instead of open coding the dma api
> calls everwhere, and maybe that could directly call the arch function
> on arm (as x86 does) which would be easier to implement in pkvm's
> hypervisor.
>

I see, so basically, we add the check for IOMMU_PAGES_USE_DMA_API in
iommu_pages_flush_incoherent() with the DMA-API stuff and call it from
the io-pgtable-arm instead.

> Then it is reasonable to have a pkvm version of the iommu-pages api
> for the page table and drive rto use.
>

That makes sense, I will look it over and send another version if
Robin is Ok with it.

Thanks,
Mostafa

> Jason
