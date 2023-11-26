Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF317A52;
	Sun, 26 Nov 2023 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so3047220a12.0;
        Sun, 26 Nov 2023 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701019976; x=1701624776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OIAS+oKjJdd6CoRpr9ZkAMoaAS4BtKkFjjolg9BRqM=;
        b=IqWKhQysek/BrfwVw2QB7zkmNjM+Aqa69AIsF+4XHafo4rlBFinlr3zxz3O1OxfD7K
         qYJb3T96GeEvsb3D2FUHAt6JGKsRUt11GtpU/+c0QJf+o09A9DXy0gB/Kt/97nk4O86R
         wsRjt5o1OjmzAZeB+n1sF6t4tTdbESjA9JJ5InHZwjdX1acbd5Wrdtpf8JWXNK5ZRPVC
         MlZKRC9Iquv0GiptRplKpMVGo/Z2j29jt2t67dAm5mcnx4My3hXxmiv7MkpC8bwE5DRd
         WC1mYfc+bqcfHfef9xaAOuEIBHyMcjOSXDj6BNbFiAAFcGiMqKIMlmnrktro2Zth0mXd
         aaQA==
X-Gm-Message-State: AOJu0YxKtOZuPLuRYmh07ZNeuAyayfFlZyPOy5volbAu1mpJ7fhtP0fZ
	XUFfIZjFR+aCVwZDYw6UmIQ6hqRU1iIeq3Pg
X-Google-Smtp-Source: AGHT+IFb0Gs87iB/qk5Xex18pXgN+fHYwQOmgY8Rh0uYpv9EGf5nV9f+dbThvlhKeXGCDbqBEGO+nw==
X-Received: by 2002:a17:906:270b:b0:9fd:cc75:3393 with SMTP id z11-20020a170906270b00b009fdcc753393mr6353257ejc.20.1701019975786;
        Sun, 26 Nov 2023 09:32:55 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090673d100b009fe23c5882asm4743778ejl.97.2023.11.26.09.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 09:32:55 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so3047209a12.0;
        Sun, 26 Nov 2023 09:32:55 -0800 (PST)
X-Received: by 2002:a50:8acd:0:b0:54a:f72d:38b2 with SMTP id
 k13-20020a508acd000000b0054af72d38b2mr5271973edk.8.1701019975499; Sun, 26 Nov
 2023 09:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231126151701.16534-1-sven@svenpeter.dev>
In-Reply-To: <20231126151701.16534-1-sven@svenpeter.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 26 Nov 2023 12:32:19 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8R4hvLxFCymVhwQCbhm2fNxCeoGf+bVUe93s20R3+nNQ@mail.gmail.com>
Message-ID: <CAEg-Je8R4hvLxFCymVhwQCbhm2fNxCeoGf+bVUe93s20R3+nNQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Apple M1 USB4/Thunderbolt DART support
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, 
	asahi@lists.linux.dev, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 10:17=E2=80=AFAM Sven Peter <sven@svenpeter.dev> wr=
ote:
>
> Hi,
>
> The M1 SoCs have a second slightly different variant of the regular
> DART used for the USB4 PCIe ports. It supports 64 instead of 16 streams
> which requires a minor change to the MMIO layout.
> There seems to be no way to tell them apart from the regular DARTs by
> just looking at the DART_PARAMs register so we have to add a new
> compatible for those.
>
> Changes since v3:
>   none
>
> Changes since v2:
>   - drop the manual bypass disable
>   - added Rob's tag
>
> Changes since v1:
>   - apple,t8103-usb4-dart instead of apple,t8103-dart-usb4 as the
>     compatible
>   - collected Hector's tags
>
> Best,
>
> Sven
>
> Sven Peter (3):
>   dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
>   iommu: dart: Write to all DART_T8020_STREAM_SELECT
>   iommu: dart: Add support for t8103 USB4 DART
>
>  .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
>  drivers/iommu/apple-dart.c                    | 35 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
