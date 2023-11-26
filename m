Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA4A52;
	Sun, 26 Nov 2023 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-507a29c7eefso4569735e87.1;
        Sun, 26 Nov 2023 09:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701019914; x=1701624714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmBLcu5qy11F4jhHivQd10kXFKmqA7ke47zHNPeSxzo=;
        b=Pq4YJ5kmm/m8u+N+ULz7GNkQEyvYaXtJOCq4xQiQjwB9KM9cnRSHoenp8jF63fwH1C
         glvya+T79FzvF4jIhBaTGAq2X1QPa+juEMZ+C0w8yrrC2IKSo7KyKHDRZUSxyltmX3WA
         jzvzXchb2U28SJob05ItHbDgpuYGl9Pmv+DpBFqaN+sBF4LkKhcgED9gSOhLBLBOvu4+
         fBhqPfydMG8SE8G7QL9adn5mJQIxy6ifZWReykbzio9L+zVHOOfCFeR7MROPo0KmmxTz
         ykmc7G8cCSW0UUnswjxjL7SYNkGwHiphP2lvnaopzSPPAWbX8C2ElSJ45vFE0Hnp00Na
         1cPQ==
X-Gm-Message-State: AOJu0YxfC5fS747zrkZW5lAWmXL1UthP/VJKunp86Cp1yxXM9yN3gEO9
	n39RELK6xn9xb0lh+cbMOCAqpKaC14OJ3Ej7
X-Google-Smtp-Source: AGHT+IGTtqAdJOIYi3ST/HxdNrOGX27HKW04jv9/dM1z6DH3+n5vjsBsF9xLlM0gRpKSrWtuDIP9cA==
X-Received: by 2002:a05:6512:e88:b0:509:46fe:b002 with SMTP id bi8-20020a0565120e8800b0050946feb002mr3655185lfb.5.1701019913248;
        Sun, 26 Nov 2023 09:31:53 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709063f8a00b009f8af454d0dsm4736395ejj.112.2023.11.26.09.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 09:31:52 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54afd43c83cso2750214a12.0;
        Sun, 26 Nov 2023 09:31:52 -0800 (PST)
X-Received: by 2002:a05:6402:31e5:b0:54a:f8e9:a9a8 with SMTP id
 dy5-20020a05640231e500b0054af8e9a9a8mr6153886edb.20.1701019912624; Sun, 26
 Nov 2023 09:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231126162009.17934-1-sven@svenpeter.dev>
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 26 Nov 2023 12:31:15 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_v78nLMYwH4RzZPE__HDc3T9=uu4hVw4wRDDM7A+RFCw@mail.gmail.com>
Message-ID: <CAEg-Je_v78nLMYwH4RzZPE__HDc3T9=uu4hVw4wRDDM7A+RFCw@mail.gmail.com>
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for consistency
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 11:20=E2=80=AFAM Sven Peter <sven@svenpeter.dev> wr=
ote:
>
> While the readl_relaxed in apple_dart_suspend is correct the rest of the
> driver uses the non-relaxed variants everywhere and the single
> readl_relaxed is inconsistent and possibly confusing.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 59cf256bf40f..c7f047ce0a7a 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -1272,7 +1272,7 @@ static __maybe_unused int apple_dart_suspend(struct=
 device *dev)
>         unsigned int sid, idx;
>
>         for (sid =3D 0; sid < dart->num_streams; sid++) {
> -               dart->save_tcr[sid] =3D readl_relaxed(dart->regs + DART_T=
CR(dart, sid));
> +               dart->save_tcr[sid] =3D readl(dart->regs + DART_TCR(dart,=
 sid));
>                 for (idx =3D 0; idx < dart->hw->ttbr_count; idx++)
>                         dart->save_ttbr[sid][idx] =3D
>                                 readl(dart->regs + DART_TTBR(dart, sid, i=
dx));
> --
> 2.34.1
>
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
