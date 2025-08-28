Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9285271450;
	Thu, 28 Aug 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349961; cv=none; b=Cv07N2zzUFj3o18yYDz51aYk+gQAk9i7kUfWtceobPBM/Uv2+lxzU4jm0NS7q0li3Cp4JDhkFecPXpjh5ZM4qZimNtWCmdIQbnmAO0DbOVTAGf9WYJfNUtezE+Cp0f7CQnZMHzXGORm5zDvNJUVWkOa3zB8CTNurPbCjpUMqsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349961; c=relaxed/simple;
	bh=geOKLfB21hUl8cX2mkx9LwJO8FFlkOY6KM/rnzAVpaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHgMKPK4QuprXMWGb8hDWWz3vTMec7Y2mejbAESZgPibv9i267x++NGEi17i5/zJ01GyaQ0wU6r1GFdGzlXjyP9G5t1NdYvzSxaR75O+1CRYTJP2aP8stYZG+Q7e6Ce+U7Lt/63fjaN4ds4KgJz39kiUrw2IZkjrw2lDmaKdgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afec56519c4so52163766b.0;
        Wed, 27 Aug 2025 19:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349957; x=1756954757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpKCLLWQN5UvJoV+eBAMVrPx3wPOuNvj43v4OMEG1XI=;
        b=hs8IvLn9mdVP83eSxDcv4yWYITtMqrGyHtiWUKW+Vietv9WgKRSodfVNnCs1+uZYJe
         gAREIOLPXEVsVPo5as2xK6n9oF2Q0YpVfAa6I+8paPQm1ZSjfWwSAX6ihkJruckVWzhl
         YKrN3n77s6mYsSQtpzMpZQmxmAgq2o751D2GbyaqsorFAih8AWLoxKItd/+brvy8YaeR
         Z9o2QiKtz4MtynFcAQW+mq5gHDwndLUhtw8EgEyzSq3XpoqgTJCCTRBQAG3ddFmh8p1W
         019pUWLSxdX1nQio+iFHyaQUdHYqskGsymoSaFTmxRcR+7qoxk6e00+QGVJ3e6KZFAFl
         uMww==
X-Forwarded-Encrypted: i=1; AJvYcCWZpN4Q5dAAQRjyFCQQhuaQTY4pi6f3rx9+ejabXSTnYQM/YbxrJdtPVc4+zrjbNbcbk1WF0jU=@lists.linux.dev, AJvYcCXkq1dErMR8PfjnwrwZ2Jdum46bUlISZ+Oy5QcaocPYVE63WZCNtesMIszdh/K7tMG7LBNUUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHNj2cJbVfv2xIkY0MFIi8T+PLb9l9ViKTbGHUo98Tv2OKc25o
	JhdrdCLSAycs7TvToTkLkH6IkyzTETvsi8qI+R8pjAAfNGgnVcpSmYIdnzrHqvWEo+w=
X-Gm-Gg: ASbGncs/pRJkpPSR3FI1i+vPK7ywNafJdAr94La8KvYxEUJC0oUTKHsd/AlEow+U7pm
	/+gcbSUDBnLnfRCJ+rCaiM5J+ua3+s+KI3eUKUNq1q/feLbr+tEHOwDE/bSVhWpZHphaAPr8mNU
	oHfAIM2WCJBcNfihghXf156S/abyX5KeuUM3SzvybPYCIbF5S8EzXghGroyATMTfGObKdLaM/iJ
	qtp0jVYIvlelLBewQqalBMCSRpRXD3YNCobE8Tqg8RT8QL83NCd4G29KLBuYI5XI6UZ1gMmqOFE
	YvvzYsQvsTLkPXqkt9jpb/2qprF/ey7aCDXc1qKdUP3sFBwcx8jw3NnjCOjt68KDN5pHAIw3YS/
	342R1IGTZILKYm1WRXmDW0EZnh4bFiVrvrrdoALWdhm2bbBl0hFXCzbfVQj3fJd9f7J2X4vLNYG
	oA1B8rp4u/
X-Google-Smtp-Source: AGHT+IGw0txg8+5XSbGvgUTWsF6zYMY9NlwpMYCvhBuWW1Ano+gJ3xllHzXPE2tOb1xn9wUk434SOA==
X-Received: by 2002:a17:907:7f2a:b0:af8:fb0a:45b7 with SMTP id a640c23a62f3a-afe29019783mr1942352666b.21.1756349957251;
        Wed, 27 Aug 2025 19:59:17 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7d5553c3sm802874866b.76.2025.08.27.19.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 19:59:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afeee20b7c0so3199166b.3;
        Wed, 27 Aug 2025 19:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2YAsk2UgJtwEcf3lY7PJYBh0pQClfKsOnhZrBImNUjRuCTxjKMAumndE1iXI7egvp/KXM0A==@lists.linux.dev, AJvYcCUsGjizF1Jsy0BbEKM6vWB/dmk06v2ZjiYPC4DybIjHqX+3Rawn1ZPzt93l+YNZoep74V55HGU=@lists.linux.dev
X-Received: by 2002:a17:907:2d0f:b0:ae0:d1f3:f7f4 with SMTP id
 a640c23a62f3a-afe28fd46aamr1873427666b.13.1756349956549; Wed, 27 Aug 2025
 19:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
In-Reply-To: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Aug 2025 22:58:39 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_mgErxSHk_OaBCwzNXwPcwNsAQuAutAUNdJK2AU88w8Q@mail.gmail.com>
X-Gm-Features: Ac12FXyrolpUKa4Qy_Ohl39WRoR9hhvgyebGLIK4Y-M15o_j00lBGu62bGVkdGY
Message-ID: <CAEg-Je_mgErxSHk_OaBCwzNXwPcwNsAQuAutAUNdJK2AU88w8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/apple-dart: Four level page table support
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:16=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> The DART instances found in T602x based SoCs (Apple's M2 Pro/Max/Ultra)
> indicate an IAS of 42 bit. This results in alloc_io_pgtable_ops()
> failing as io-pgtable-dart supports at most 36-bit IAS.
> The t8110 DART design supports 4-level page tables. Implement support
> for this in io-pgtable-dart and mark DART stream with more than 36-bit
> IAS as 4-level page tables.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - simplified 4 page table level use in apple_dart_hw_enable_translation()
> - use "iommu/{apple,io-pgtable}-dart:" as commit subject prefix
> - added Sven's Rb:
> - Link to v1: https://lore.kernel.org/r/20250814-apple-dart-4levels-v1-0-=
db2214a78c08@jannau.net
>
> ---
> Hector Martin (3):
>       iommu/apple-dart: Make the hw register fields u32s
>       iommu/io-pgtable-dart: Add 4-level page table support
>       iommu/apple-dart: Add 4-level page table support
>
>  drivers/iommu/apple-dart.c      |  50 +++++++++-----
>  drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------=
------
>  include/linux/io-pgtable.h      |   1 +
>  3 files changed, 121 insertions(+), 73 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-apple-dart-4levels-8f9ae8ac1347
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
