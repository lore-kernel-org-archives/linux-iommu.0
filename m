Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEC283FCB;
	Tue, 26 Aug 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244791; cv=none; b=TJIvkzd9l49SnUvjda73s7uSUWbFGI198hHhrcnPTfxRQ9jOIBlXHzh5LpDkuLZQXD7ztVbpL7L711mrmeVZJy5AfkDlPps4UJddrqK8jUEldhvxDWTwjLiLnDABNhN6INfCqApWNpiTaFWIFxkeRLa35pOCjYhSxyzfkPyNfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244791; c=relaxed/simple;
	bh=wxjUVhxbok5IPGUPMxHmf/MxyRnEbApTzZPax+WoJ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSoZ7TRhxA+fDRYPYUaxJ6dRYU1qXdqd9UTDlQJGO8kNVi+d8r0aBU0CIEhXRc2gVbMz8PXOrRIGoamAoptEqvpG+2URLt5etAj3wtrz1rr1DCmj8gH8jHOiCjciObCC5Mrjz3Tv/Owcjjph0mJN/NaGr55qNjuywuhrndqrDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so853908666b.1;
        Tue, 26 Aug 2025 14:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244787; x=1756849587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlR2W8sGPsNFxVXAPLkKkhjl01WcoRvDHaUyBoigeGE=;
        b=oMbdzMgDt11l+B3/OZHh+gD3iPzskyoaAnJG2uc8qT/ul27BNbADtixtPfv77M6OuY
         nWBDYvVLtupkzJoS8QxVQqjFk2xsxzqkTBIu5VS9XiX8nNht0eyjXlYuQWeg1jtU+58l
         f1Wqv6I3Bv4X0hzfiBeG1CFd5t6KxzmGSDlBVwHUTjYWi3Xqffnxj5bQsj9sWah3HRym
         pHUo/b1XsWnGpYhYRIaEEUaPv3DjXal3xy+48WOdCWrHPP6qg+z0uveMLH9Rj0mZs2FW
         66afoSRxdF9ldHAqyY+tgwIh5maBqLzRZHVpkhP8Tmrmz1dJONyeTGaJE+p4ecOFmUUn
         +fKg==
X-Forwarded-Encrypted: i=1; AJvYcCUOzD0R5QVdoBiXdeGtkijJRIvF/cOWVwZqtJ+HWTeN0VhgH4WiUXvAG6ORzBzjpBY6TUDJ82I=@lists.linux.dev, AJvYcCXX+nuw9iZV2o+qqgLqRUabs1aiIAaBkzjzSwrIMX+U4UI44dqEOuqPasKjzfnwvnGiNg0kdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoZTrhP+jrYZQtXDL4Yji63TkTBCMmyBOuoK8Qa2P2F8hyTpb6
	mwqGOeWSoNtbVmCd3gJIsQqHHe1CqCTMCISAHta7uvBgbmfFXm+7t0rT1q5khrhs
X-Gm-Gg: ASbGnctrYGs6Wq3kcA0E/McYcjSf3/km8FKuLHfkJpP5u7T5ZfE5htuI3zhtOEf8R0w
	AMdKblPCFwibZG9lrhcDJHAIAdr4dcpbghWqiv3ZX9FbB47+TXxUV/XKujwzoumPsYmsrLX4wF2
	m/+6vKVVs/2z1eDKrxk9w1Ug7q+2h2Y7Gs+MQxipP7OHOD9OVbpALUOYb46LNRLOvyRZPRfkLUO
	PKafSvFzjYoJZ039YUolc49bheHCUIrkpFZhtv/Me7EiQbp9dyEp5OFeRdSwKKZo7FJ/RRIcCc/
	qsLbvR2zV6abtH5jxfDB6HLleDdherExBDn+OmBlHVRBks92RkP5hIlfehpy/scqRT10xofZDwp
	N3hUTy8P6VkaNJQtvxrGQ56rDgwZNb+fEaxcbvI36uq9Alx6o2CRB4URsYUEteBo6T3uhRb2GJ3
	TbFApUKd24
X-Google-Smtp-Source: AGHT+IEookd3THdKas8pVR5mT3NBNJLZRBzj+FUI1HrgrQo5sunDTA+McpMw2bKjYcfHrjkshTJ5eg==
X-Received: by 2002:a17:906:f5a7:b0:afe:ad45:acf5 with SMTP id a640c23a62f3a-afead45ad78mr297050666b.34.1756244786745;
        Tue, 26 Aug 2025 14:46:26 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe81890cd7sm497689766b.109.2025.08.26.14.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 14:46:26 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cfa0so5366857a12.0;
        Tue, 26 Aug 2025 14:46:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrFIZ3XmVUuBKS5Sb1VOY00oNRcjkv+2+1ruwlW/DEd5QLvRSvx60kDoO006GwQEV+5dazf94=@lists.linux.dev, AJvYcCXr8CKYW9H538aoY6ovhqrplEMrRVUh2ECrcCjPjWF4ZQxqgUB2jGVX3D/gBVjOnuidOMjf3A==@lists.linux.dev
X-Received: by 2002:a05:6402:34d2:b0:61c:979a:e7a1 with SMTP id
 4fb4d7f45d1cf-61c979ae911mr2475028a12.16.1756244786336; Tue, 26 Aug 2025
 14:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
In-Reply-To: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 26 Aug 2025 17:45:48 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8F_n9J5aBsTBm6RgAL9DdXKTgyMNxDo_aPOR42GzGUkA@mail.gmail.com>
X-Gm-Features: Ac12FXwA-HRfgwtoditQ_gzG_vHw6fQHNUVW4nCA0dkeveZIhrlsxxZOpuqsYBc
Message-ID: <CAEg-Je8F_n9J5aBsTBm6RgAL9DdXKTgyMNxDo_aPOR42GzGUkA@mail.gmail.com>
Subject: Re: [PATCH] iommu/apple-dart: Clear stream error indicator bits for
 T8110 DARTs
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:57=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> From: Hector Martin <marcan@marcan.st>
>
> These registers exist and at least on the t602x variant the IRQ only
> clears when theses are cleared.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> I've overlooked this change for the 4 level page table / t6020 support
> series [1]. There are no dependencies to series so this can go in on its
> own.
>
> Janne
>
> 1: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79=
daa37@jannau.net/
> ---
>  drivers/iommu/apple-dart.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 190f28d76615159527649cd288df395a50d950ef..8b1272b7bb44a1ebc03ca4ddf=
3be43a1e42c97ed 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -122,6 +122,8 @@
>  #define DART_T8110_ERROR_ADDR_LO 0x170
>  #define DART_T8110_ERROR_ADDR_HI 0x174
>
> +#define DART_T8110_ERROR_STREAMS 0x1c0
> +
>  #define DART_T8110_PROTECT 0x200
>  #define DART_T8110_UNPROTECT 0x204
>  #define DART_T8110_PROTECT_LOCK 0x208
> @@ -1077,6 +1079,9 @@ static irqreturn_t apple_dart_t8110_irq(int irq, vo=
id *dev)
>                 error, stream_idx, error_code, fault_name, addr);
>
>         writel(error, dart->regs + DART_T8110_ERROR);
> +       for (int i =3D 0; i < BITS_TO_U32(dart->num_streams); i++)
> +               writel(U32_MAX, dart->regs + DART_T8110_ERROR_STREAMS + 4=
 * i);
> +
>         return IRQ_HANDLED;
>  }
>
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250826-dart-t8110-stream-error-1c2bbbf4fb63
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
