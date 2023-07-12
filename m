Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5727726
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 15:06:28 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso4601901a12.2
        for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174387; x=1691766387;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAqFn71nQK08Pou4CkH2NPss/L+GdIam9CN05EpYNIc=;
        b=nbPWlgxXJOL4dI/TWjZZjGA881ecooijeYaa7A59TAFTu/7ta/1ak2mJE9y30ofkmD
         BF0htwPneL0XL668CZnRYbjrnohya/FgUg56ZWDNHSrhQ3U6+33z2rk8dDUwytaUo45v
         X6LDtKebsMYqIAkb3r1UtkzXvOmUr8TNpdbGDBnbWmvx7KUW+lz08RMp6fvXqsXvwdQ5
         P4XUslTE0drDqqHRszRMq0nobpy8CZKt7VhHdhXJyO4TGGjzZ5GfJXi8bm6tcxS23OFd
         0JmHdJ7OeEPnhcY6RnP4dLC69iXK7LyrHq3l/7MBqpK4E+hQs0mii/Rcf5PnYxfCDjN4
         1Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174387; x=1691766387;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAqFn71nQK08Pou4CkH2NPss/L+GdIam9CN05EpYNIc=;
        b=Y/j+lNT/cbGB3L+70ZBE0DzwOg38EDMuW2tS3Jz7cwTN35E4Q+Vk49WZOUWrKWNtuW
         GHqch6M3Iq12GuDuLeqPshmtq6HeLR4M/3uC3mGtx8B/V7ZDh44AWeo3krB0eff/ovuP
         xhCIRgWBkgqHZuAuhnFj59jMDEwVoOKuDDULWe6eE1qz/6HftWtJ/dhXurY6S3LY7yFX
         hEgGd8unlhXW6bFmO5Ug5i3BER+9hxlG5IUbSuwBp5HHXSKSBCRwI32GQORZAgPBSpHw
         o3rqRr0PO7LkokZF5CnvY6rs29kr5hISSGv86/Bp2SFUv05DGfm9fYwQtbBE3tuHxaX8
         zKAQ==
X-Gm-Message-State: ABy/qLaakOLBZEQ18B6Ql1mNYThYP/QytRgsrM6bvMtjGiPVUyUmEHrz
	SEJ48EPMMRaj1HfqFronmP8=
X-Google-Smtp-Source: APBJJlHzve3iZeeHXb7AehNG/sB9CJPZqJqrxjdvooUQ5HMbOUXlUSt1k7mAHBZEmhTvmDOtPcDrew==
X-Received: by 2002:aa7:d90c:0:b0:51e:57ba:cb8e with SMTP id a12-20020aa7d90c000000b0051e57bacb8emr5468311edr.5.1689174386710;
        Wed, 12 Jul 2023 08:06:26 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7d618000000b0051df1797222sm2905904edr.11.2023.07.12.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:06:26 -0700 (PDT)
Date: Wed, 12 Jul 2023 17:06:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v1] iommu: fix
 parameter check in tegra_smmu_debugfs_init()
Message-ID: <ZK7BcFc-sdm15Sv9@orome>
References: <20230712113145.12888-1-duminjie@vivo.com>
 <ZK6a-f2Se3HWjU7D@orome>
 <SG2PR06MB52889E70309210CD49400A64AE36A@SG2PR06MB5288.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cuXJAWyeTLyXBBIi"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB52889E70309210CD49400A64AE36A@SG2PR06MB5288.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--cuXJAWyeTLyXBBIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 12:37:02PM +0000, =E6=9D=9C=E6=95=8F=E6=9D=B0 wrote:
> Hi Thierry!
>=20
> >I think we can just drop the error check altogether since
> >debugfs_create_file() will simply return early if smmu->debugfs is an er=
ror pointer.
>=20
> So do you mean maybe delete the smmu->debugfs check is better?
> Maybe I can resubmit a new patch.

Yes, I think that would be preferable.

Thierry

--cuXJAWyeTLyXBBIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSuwXAACgkQ3SOs138+
s6H0PA//VLaQAJjH3N7V9v3NLx9PQULtmoSXBfL5JfIIoc9cexTsdngBqR8wR7ZG
ZNZWra1q34gXlc+zLW7gEqfku+pAb+WX//IMr9GuiRPjch49lW+xRILJBFuv09mx
yEakEvaJ9XvewOVUTwbJZnVKCJokTtwK5U1RJ+BiYHLa318AXZmZsKANETHBULeS
OzMaeHHqWmUKC9ESB/Rj3gNQBbk250UxpMa7GGJfvF/ZQ51qXAHOBIZFbeYVpixK
itr1RHkQvcAiA3MMMkJFxw/iK07ArPnHffDUoB3KPpICWXAsnOjwcLtxwdj09sMx
7e3P7kCywGlP9k9T4kvuE+z7Kl0GTN8y51miEwzOI0s3pcROjKciU5EstRXuaM8T
juKVO/62dYDhDFSwKM8g1xDuhV1+Cr+zbdLKO2EFOHeXXTfVGeC4HuIEoytVKt39
KFXgi0v530JUuQeZVHGmBxd68HTAcEzH/cVjVkxWnnLv/SBWV4bUK2uEZBWgrBrj
IlGK5kZTC5ozeOcZ2h9aOvhEL5p1DHsOd9stFLUri9xlrlITYjhklFUkLIk5nTxi
hiyyZ1YI8De9H3YGSh3N5JDuR12uxvGcyyORg8du8pio/ZPl886VRnv5TAlM/2n8
7t1KWPrnt9Kq1smEiU9aG3cOXe4Xd7hgunNrvCtD9Xiq73/sNwo=
=4eXe
-----END PGP SIGNATURE-----

--cuXJAWyeTLyXBBIi--
