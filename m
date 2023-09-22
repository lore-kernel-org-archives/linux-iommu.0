Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AF3CD0D;
	Fri, 22 Sep 2023 16:40:52 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9adb9fa7200so615284566b.0;
        Fri, 22 Sep 2023 09:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400850; x=1696005650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLMEZvzr2hDeQFoHwg/p7D4qUJztpTY+iNBV1OWqyi4=;
        b=uueiCGULXR25DTMVnxHQz/KrUt+waBcqMuxzyLghi4pqYFlnACJWfm6q3c3vjGNoLI
         08SAsHQhwGlJCyvo50afpwElcilljOQ7OIJKYLfwbsvirajHdlsBoJiGeJOrG5Uzm1JQ
         Xl/xk9ZDp4Go9wzGUKbpLbp6eJ+klFc045rJlYYTS69uvc3YyJV4EAPBsbTtAOFjDBSa
         OVWLPqHlmFNS5k6mHv3X4xi0FxtxfDAEsnss2IQaLQe2P1T653WEDai2z3mPvmQ75l0k
         +DAluUiX9ywquVEyO0qp+nn8YQkQIoMJlzbM9TScpgZgqDYo6UwfnW07u/U8Wpvtb4e4
         iC6A==
X-Gm-Message-State: AOJu0Yw3v9hZWY7jXJ4yxAshh/LMMMTYucqb6RXUPHwQc+ZU1gpy+nNI
	ZuYT1vhsAulFbYoCyMVR6uX+P2EMzsese8Ip
X-Google-Smtp-Source: AGHT+IF+uA/lvlIQ8HKaL+Q5zwugz/95vPcBBSZwkjDZiBIj332DZvt1MLzRZ0U1NEh46WhufivKVQ==
X-Received: by 2002:a17:907:75c4:b0:9a2:143e:a070 with SMTP id jl4-20020a17090775c400b009a2143ea070mr347123ejc.20.1695400850283;
        Fri, 22 Sep 2023 09:40:50 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906564c00b0099ddc81903asm2939889ejr.221.2023.09.22.09.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:40:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8611313a12.1;
        Fri, 22 Sep 2023 09:40:49 -0700 (PDT)
X-Received: by 2002:a05:6402:5c4:b0:530:8fdb:39c8 with SMTP id
 n4-20020a05640205c400b005308fdb39c8mr4374304edx.15.1695400848925; Fri, 22 Sep
 2023 09:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 22 Sep 2023 12:40:12 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8b-gJZDs5Q6n=XgU5xyPWiJ3utX9yf0DPN5bfLqUx4PA@mail.gmail.com>
Message-ID: <CAEg-Je8b-gJZDs5Q6n=XgU5xyPWiJ3utX9yf0DPN5bfLqUx4PA@mail.gmail.com>
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in attach_dev()
To: Hector Martin <marcan@marcan.st>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	"Justin M. Forbes" <jforbes@fedoraproject.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 10:55=E2=80=AFAM Hector Martin <marcan@marcan.st> w=
rote:
>
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and apple-dart's attach_dev() callback does not expect
> IOMMU_DOMAIN_DMA_FQ domains.
>
> Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
> instead of explicitly enumerating all types.
>
> Fixes an apple-dart regression in v6.5.
>
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1=
-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2082081402d3..0b8927508427 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain =
*domain,
>                 return ret;
>
>         switch (domain->type) {
> -       case IOMMU_DOMAIN_DMA:
> -       case IOMMU_DOMAIN_UNMANAGED:
> +       default:
>                 ret =3D apple_dart_domain_add_streams(dart_domain, cfg);
>                 if (ret)
>                         return ret;
>
> ---
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> change-id: 20230922-iommu-type-regression-25b4f43df770
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
