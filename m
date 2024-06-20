Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C371A8C05;
	Thu, 20 Jun 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878672; cv=none; b=esZU3cO31QyY7lXtlhVTb2Nrng4JY8PyvwjTsGmwx7J0h6qsrEIyIT7xOn+PZHz6xsZJKOA1RjXgfi1HDGyzOtgBtdW0+FFLzjk0vKH7Yr6kgYfnRm2da9C059s5AZlBBkSR4YeYES6SplaOTlex0plwWhDQOI9lwt8RRpGK2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878672; c=relaxed/simple;
	bh=iFWLkh/WpGhcD6WT3wvg3mHpb2fRwPOwZJyeCqo8YKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZ3RpuoEl/G8Y44k35gsVQzV5T/jlj5z6Z7KNtT/zDRziKGHBHhAcp648YhByBJ3zQDvH51QDTyPnz/glykERtPc+0W/LPPZ5ud/jfvfQZprsg+ifwWeyu9xwzlLgpTVQ3pOg8Ab8qKELmuHn+mXBVfQEl8WVP1bHtYMKyWKTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1610984e87.0;
        Thu, 20 Jun 2024 03:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878666; x=1719483466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1YNyE70SoDdHcH7gkxf765fOcuuSZVUTW9WZEWS85U=;
        b=PrXqvFCbYw6/h+CWcwvDwMVWZZWZWAc/pspyv6gA/j/5JCKlKqHzSaHXN3S/abJI5q
         BEwi118cWQku5+axtlcsjMjR3bH8r7tAx2tLuTM32ElfJV64667AuOQ3DiWkzZpjFDNf
         meQ0tUNhY0qYUYIyhrwgvj1GEew7CcmRrlmWMVZdWKSBTqom5hfL5xzYG50WpzGSsTS1
         LtWe7l/jz5e9+BLr7GeGzXolTXahQnMllLAHthe3T4nfSbpT8Pp+kzEfk/TcKIYLUE5u
         /HOaTsDaz5pArbaySHkonz/VeGNx7SzU2y1amxMXtuT002lPO8KuVZJVvrakwRtovEoZ
         zFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0r6C64zA6wEz4xSkWemaHtl0gM4JaUjQLZFvECmQH8ZWJ8mF5FKqd3UFTqnBUG6jiHS+EC+Ru2JoU2H3Y14Na5qwMlZu5acu78caSisu4FNBAOiU5gm7vWtwqWoownmy+g==
X-Gm-Message-State: AOJu0YztuVdDVoMBM/kp9LpysFTWT6UwxIK99tsv2j41bvMB+0m7Smlg
	QBL1feZ18VRn7pJBJmrHq/TkIiMA6qxtwXfYzYkEEqrtb+K6unB65n3FQxvrhto=
X-Google-Smtp-Source: AGHT+IFqAHzZXg/joIzsTdOo0VGRk5WC7eQaNyR5KCZ8bUFSVZWi7mc3V354zwWY80i9BQ2hZ8GWjg==
X-Received: by 2002:a05:6512:3ca1:b0:52b:c2b8:b1d9 with SMTP id 2adb3069b0e04-52cca1ea2c0mr1799800e87.26.1718878666504;
        Thu, 20 Jun 2024 03:17:46 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca30928aasm1991162e87.283.2024.06.20.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:17:46 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1610940e87.0;
        Thu, 20 Jun 2024 03:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULCOU4pE/4eyvWR4+J/lweqrZ+xsJ6RToIGaw1bUHjGl2tsb15G4THDpwoHm5JW8zMVIuck70JlqZ/3wh4jSOQxv9OrjmKB/cTVjhQVM6SPj9rj4eUVVI4qbp3jVVENc+d5A==
X-Received: by 2002:a05:6512:234f:b0:52b:c140:5d5 with SMTP id
 2adb3069b0e04-52cc47cb6d9mr2302277e87.2.1718878666095; Thu, 20 Jun 2024
 03:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240616224056.29159-1-andre.przywara@arm.com> <20240616224056.29159-5-andre.przywara@arm.com>
In-Reply-To: <20240616224056.29159-5-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Jun 2024 18:17:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v66E50bHCoYpkkcdfd=i57aLGi6Sa+HJMzEzjpYJL3bVOg@mail.gmail.com>
Message-ID: <CAGb2v66E50bHCoYpkkcdfd=i57aLGi6Sa+HJMzEzjpYJL3bVOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iommu: sun50i: Add H616 compatible string
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>, 
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:42=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The IOMMU IP in the Allwinner H616 SoC is *almost* compatible to the H6,
> but uses a different reset value for the bypass register, and adds some
> more registers.
>
> While a driver *can* be written to support both variants (which we in
> fact do), the hardware itself is not fully compatible, so we require a
> separate compatible string.
>
> Add the new compatible string to the list, but without changing the
> behaviour, since the driver already supports both variants.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/iommu/sun50i-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 20a07f829085d..8d8f11854676c 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -1067,6 +1067,7 @@ static int sun50i_iommu_probe(struct platform_devic=
e *pdev)
>
>  static const struct of_device_id sun50i_iommu_dt[] =3D {
>         { .compatible =3D "allwinner,sun50i-h6-iommu", },
> +       { .compatible =3D "allwinner,sun50i-h616-iommu", },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);
> --
> 2.39.4
>
