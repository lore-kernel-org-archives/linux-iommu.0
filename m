Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA13469F
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 06:52:03 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so636771e87.2
        for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689231122; x=1691823122;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjioKYAE1CabhlLXtOYpTpcQpvMCu8spfeCxR4rurZ0=;
        b=Ub0AcfBwr4qZaN1b5EuddxfYLDiavFGhJgnnzehpRCG54rbfHFjK0NRWs22HqazOg/
         7+USN0vVUzA7Rm5rIFKqNJ00fuQo3us8YG17i668XQBAPDKxp8jI3yUhWyA7xdFQ8OSc
         031+iKbTtvrhYCHXbDq1PL/u4w3CR8ri3mGDIID9OORzmvt+r9vbWCNOBZc/VFmYBzej
         aVozqoCEafC5HdbU13p9oBV+8R4ngGCwVC834Y5BnHYxUxuCyjM1CzwqqQenRlzjahxl
         x+NKv4nuPGCkbApOe4bFvORgRT+ER8BiRgXxwyKWSw9ugFEfXU3zayaK81GOU0eM/a69
         hj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231122; x=1691823122;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjioKYAE1CabhlLXtOYpTpcQpvMCu8spfeCxR4rurZ0=;
        b=ajav0NRNtsSJXx8LqgrF+TgY6htsi2ifUX0X4HdgXw681uOyz1zuz7grczSDZyTyCF
         SPFKlXnfjlvChkqaKP/8mo1ZRNyqBdYfA6y7VdNqN2g/kIA0F6ViNBuTtgcWaBOiquzJ
         S5ADJHJjlpQLEs3iWU40ctVzQF9AVLWiddA22ZoXXAhkOZiGvcUotCgSqadicPMmjfhW
         5XkKpTQAaaVdP3pJF7NSSD6R89ivx+IBiWZ3CGMm1TO5v2DBOp7BQw79TCKtMYSQPtcg
         nP6hntiAc9n5kXRrpzwHsVH/3mxc25XlitscctuxyUVMeGhGquZfbMYxCwiWNElFmMWj
         niUg==
X-Gm-Message-State: ABy/qLatuGSFhlOW5AL1XQZj43LVYJ0UKhJdPIroCv3nL2OLS/zV/oVa
	HLPVadufceaDGre81BeAVko=
X-Google-Smtp-Source: APBJJlF9RwSK0SfzuOclhMfYGva33E1IsP+9+wjEV6a2OCouK3ZdXv2iGFDIuCWeHAJ2t3hZiTg4/g==
X-Received: by 2002:a05:6512:3f5:b0:4fb:758c:74ed with SMTP id n21-20020a05651203f500b004fb758c74edmr406388lfq.35.1689231121362;
        Wed, 12 Jul 2023 23:52:01 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u8-20020a056402064800b0051e2549c4f9sm3899928edx.47.2023.07.12.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:52:00 -0700 (PDT)
Date: Thu, 13 Jul 2023 08:51:59 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Minjie Du <duminjie@vivo.com>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Message-ID: <ZK-fD7inmxjwPyL5@orome>
References: <20230713025653.1540-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyxSMOb3u6QlwA/"
Content-Disposition: inline
In-Reply-To: <20230713025653.1540-1-duminjie@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--xgyxSMOb3u6QlwA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 10:56:53AM +0800, Minjie Du wrote:
> debugfs_create_file() will simply return early if
>  smmu->debugfs is an error pointer.

The formatting is a little weird here.

> Make smmu->debugfs check delete in tegra_smmu_debugfs_init().

I think something like this is better:

  Delete smmu->debugfs check in ...

Or perhaps combine both sentences:

  debugfs_create_file() will return early if smmu->debugfs is an error
  pointer, so an extra error check is not needed.

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--xgyxSMOb3u6QlwA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSvnwwACgkQ3SOs138+
s6FbVA/9FLgDdG1LKZ0l03k73D7pZ4qnDFuB6IVJdEl+WnEIIbuytEtjgVi3Qu3A
+5DGHteJ8CZAiBVtZit97kUvHSlWFvBV4Nk0wi2JMNtCZ4zhAoysEWwhlDuHqVGP
S6cDWlLP9mJqKV+K6TwONKbO1SeqcKiWPiFVuO+aqORu4KAQ2Yf71YmvaxfsTawk
UN6Fd/uLsTwnVv5/LJqJ1IUr6UbfRXbKTvlJAgcwncRE73bvI8zxt6dgFwl1WpIV
mmR9e5TPCo78r5qogRaUZPE8t8DkbRBJ4BSE/KMRyq4qxwrfAHwmJCCI3aPMHscw
Vp6QRO92vta0c/UxEIbyCvyMEG+2usGxlsYzjJNXWKXwi2MTZL/+GEhqO+FASnBL
xzRpd+3kKsoKDyTwBtN6HRrJfqtwjvYCAtq1EuZZMMXpNEZgnt5/Skt1Wo0QwYyo
UDotUuoUGECDlA/GP98R2htx7c+hIytmKV88WLK3NOL1QpnPiXHeR4h6obH7h9oc
MfgaSBN39KwsdKACFqSANMjhgJcO65apgelD0/OZDm1MHSkOsT5cPz9S4qpwtsUg
1T//VsYjA+lLfZNvoE+trCeIHqatZpAkouzJEqacc5vVGE0WqpAuDa9gvYa/MKcZ
s20oZW/FydwDx0IGCWyr3296bglGsmSicACaCVugDj5/OtuMHxs=
=oFY6
-----END PGP SIGNATURE-----

--xgyxSMOb3u6QlwA/--
