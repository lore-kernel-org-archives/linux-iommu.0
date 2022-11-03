Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EA6FD6
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:01:20 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id bj12so5394680ejb.13
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8KBHFKCCV98EGQ0XNAh6f+GyuIELNYOs9+rs4Vjisk=;
        b=PM3sDavtwmpBa9SzVwuAW8ocUuLOyw5n79S3/pdi6Ss0i09waaIpEaRLPCKx476mWk
         jycWA5LjGory2a2IFrwpWs1mokSxWnq/icf6U733EkfykpxMP3vD/2MKn+vj5NaxCbL8
         +vehfKEcSsL9bQm5gE3IsSj5Pyh+RDhDb5+n/dWmVdcxXxPpRL4u9Q/ibFB7OJdaWVv0
         aLBIH4tqG/VxSvbh54Z1wMiXnv0zwo5g9baojtcukDUE2ANtVPDl9enFgNtcpAA7B26c
         9hZM4cn3Z1Ppf3ngatHbl51+oH9nxo5u5wNYYu2NzeHt9Y3mqOwzDyxN7Ue41IxVqWyH
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8KBHFKCCV98EGQ0XNAh6f+GyuIELNYOs9+rs4Vjisk=;
        b=Ro4ZS0zxmcyP6WNROGn21nRoBLkKa4LANTkOyY6KIMchyBsKq+KEI2P+QXvLfe6CtV
         jlh3mhmudK/Y2SAKSjGI940UDzMjoKyeXxnXb1paoHs6WKPnnS/Z/hMdKB/arN6ODZr9
         gu9IBjh2fKcU/sJteH1UKXyZ+2X0R9CdwZufp10b4JFQCGGv87ubXH8UFq8udsMMJxht
         jm3YZPnI3i4Rpm5vf1OVNNEEgIdKAbnZZ90NiScvC5Ogc/TFYX1rA43jUhNNRx/A/M5J
         40VJIj6Urjxwquztwc4Bdt2B4KJReSeEBotstEMuu/vJTmVDagRzLlRDlyvg/yOcFT0Q
         fJOQ==
X-Gm-Message-State: ACrzQf27iFWYXLOlpmjH8e6et70LAILYV7ltuClHCNovZJpBCpko2aRG
	inotwcm5eU87NhVZttV2rgA=
X-Google-Smtp-Source: AMsMyM7XJXH2PC/t6FNCsEX7I+z1C4W2HQEJ9aLW8fkd/ImJ/OKSmZBl8druoW65YOOMfmSOa1gqqg==
X-Received: by 2002:a17:907:b07:b0:7a8:beb3:aa2a with SMTP id h7-20020a1709070b0700b007a8beb3aa2amr28968653ejl.459.1667484078436;
        Thu, 03 Nov 2022 07:01:18 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b00722e50dab2csm534317ejb.109.2022.11.03.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:01:17 -0700 (PDT)
Date: Thu, 3 Nov 2022 15:01:15 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
	adrian.hunter@intel.com, ulf.hansson@linaro.org,
	jonathanh@nvidia.com, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	iommu@lists.linux.dev, anrao@nvidia.com, smangipudi@nvidia.com,
	kyarlagadda@nvidia.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Message-ID: <Y2PJq27wkVwPg6rp@orome>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cJiVwhbrNzxCoobg"
Content-Disposition: inline
In-Reply-To: <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
User-Agent: Mutt/2.2.7 (2022-08-07)


--cJiVwhbrNzxCoobg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> On 2022-11-03 04:38, Prathamesh Shete wrote:
> > In order to fully make use of the !IOMMU_API stub functions, make the
> > struct iommu_fwspec always available so that users of the stubs can keep
> > using the structure's internals without causing compile failures.
>=20
> I'm really in two minds about this... fwspecs are an internal detail of t=
he
> IOMMU API that are meant to be private between individual drivers and
> firmware code, so anything poking at them arguably does and should depend=
 on
> CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was o=
nly
> added for the sake of one driver that was misusing it where it really wan=
ted
> device_iommu_mapped(), and has since been fixed, so if anything my
> preference would be to remove that stub :/

Tegra has been using this type of weak dependency on IOMMU_API mainly in
order to allow building without the IOMMU support on some old platforms
where people may actually care about the kernel size (Tegra20 systems
were sometimes severely constrained and don't have anything that we'd
call an IOMMU today).

We have similar stubs in place for most other major subsystems in order
to allow code to simply compile out if the subsystem is disabled, which
is quite convenient for sharing code between platforms that may want a
given feature and other platforms that may not want it, without causing
too much of a hassle with compile-testing.

> I don't technically have much objection to this patch in isolation, but w=
hat
> I don't like is the direction of travel it implies. I see the anti-pattern
> is only spread across Tegra drivers, making Tegra-specific assumptions, so
> in my view the best answer would be to abstract that fwpsec dependency in=
to
> a single Tegra-specific helper, which would better represent the nature of
> what's really going on here.

I don't see how this is an anti-pattern. It might not be common for
drivers to need to reach into iommu_fwspec, so that might indeed be
specific to Tegra (for whatever reason our IP seems to want extra
flexibility), but the general pattern of using stubs is wide-spread,
so I don't see why IOMMU_API would need to be special.

Of course we could get rid of the stubs and make these hard
dependencies, but I suspect some people may then get mad that they can
no longer disable the IOMMU dependency.

Thierry

--cJiVwhbrNzxCoobg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjyagACgkQ3SOs138+
s6HGYxAAh6pI7eahKNv7gYp1al3CnXjMWsTEFnZEfgGUoTtGAXTOdR4I7jLa2ZiH
aywKvhMZ5Jn/C5uwx+ylsElQNkmsmwJAusICnt+iJaYxGndYyQWndaUaGJrOa2b6
mFDi6xpxykGuJwLdz2Y0hvGprBZc5y5d9j6SiuUjWYGqGSddGAvXe2QzvLeZTwYf
mmzO01+KdOshRJItVefZCEM1shmzUu1wfS8I+JT/iKSM4GL1vPtGsq6Z3H2vb5h3
gnapMRTmZZKiPwJCjykuSOcZ8++HFjA+LA8EZ5peVtMkwaRaXicdhs0ymwettr/x
PxlDnsuhPbMxxLz71RRoCaHqN+83ow9opGOKhdaiztyf4AKlXc8koGg1x1wBgn8c
jKcff0GCs3D7QAHIoOqsHSIIMK6NfxBcNViOybyR5ffqRo3SY2NYWO8bp9h/dJiM
SDobn0DUMOgYcLomqBDwTqQqc1Lcu+hvQexA6sBRP8pvIpJ19IWzfnPtH/NaExbV
KfuTqtXscsX/8YG/oiCjVfa6fOS1tb7ftygdxWGgmRRZl3T/mswU67UbNMmiHhkC
VY1e4tQx5IKdiP1BRk0wBe4rIguA2F2xtImJpakSRJnxCYoFInFrYXBhXSeEG3ys
L3NiAeBplKi2ZGAPAnp/w0wsq9tjT9svzmIdjzWdeGmIU/Lx1qc=
=WjKJ
-----END PGP SIGNATURE-----

--cJiVwhbrNzxCoobg--
