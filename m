Return-Path: <SRS0=Q5Oi=DP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1AC43467
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:56:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CD721531
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQH4TLrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CD721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57C0A86BBC;
	Thu,  8 Oct 2020 09:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMaxKx46byQ6; Thu,  8 Oct 2020 09:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 630E486949;
	Thu,  8 Oct 2020 09:56:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0BCC016F;
	Thu,  8 Oct 2020 09:56:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DD8C0051
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C7146871E2
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lw-EJwJeHKWR for <iommu@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 09:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EB754871C5
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:56:19 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id c22so7248065ejx.0
 for <iommu@lists.linux-foundation.org>; Thu, 08 Oct 2020 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vud+Tde+jCn43K272A0b3+noi0OEELurVQ7SECSZPOY=;
 b=uQH4TLrIMlR7FlO+StJtZGH3v6i2HYIsRq6E3pAvqIqCVCxjv8v180DhoHWXYvBotS
 3yL6RA/+Im86xIYkxg0k95GyYIIUIWPRNcJtNBju3UZk8FEeaeKbowYgn8GApgxMzWoe
 vN4Ex+gFLe6EvtnuWCNDzSmUKqq1m21nBR24XLrHg4A8pEbA4jvc3pZi2mO3RxjesVpI
 fjQOe3j+lt/131osV2TZkz4o+MX8CD/S/ty7ZgomeVdeDpg5I9vBn18e4R4fctVC6fW7
 ByzwFeVHUw6y5j9tlfBbKlj4Mw8feksNeIJMc1+EmksKuQqxH0KzPEbc8aHMr1nyHgs1
 fcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vud+Tde+jCn43K272A0b3+noi0OEELurVQ7SECSZPOY=;
 b=L8g5t8As69dic2r/eQOd2xHrfouoL0Wp9N15PcwKPy98PuSN4ibDJDlHu/cBxa7ktm
 0Qt74wXij4NBJI7zuyHcXrnR+3nq7AGxxd8yQQJG7rMCqh2FGO+tWFnmPRZddBrxzBLz
 ju1ZxmOFaF8ll/v6gW8aON6u2vK7emg1siGFCjsJsB3F/C2eTwpOEKlsfA1zaLeYacxL
 fcXw8lTx6DVWey16BsCVgeHJsd8jEWpPEg9IJXh4oxsnG+G2/YAahK3cYByOvUGV684X
 8sEKUPQ8yjCVbkQBDy3Kx3hcJue3P/DtY+ADBCzSWAneFz4Wm1KWhviNQZwbYLVJoDC9
 YG6g==
X-Gm-Message-State: AOAM533jF1+bCWk9DsOKTqyF/w7xhh+HToUxmHJWHcFjmUqECi7mbq9H
 BADPHYpZArTdpX7lEo0r939qGTy57nA=
X-Google-Smtp-Source: ABdhPJwrZ4dHMXazfEMebENZYGWYwSvw5NiZ+X5aNceexc6qPbhddzUF+Vc+g5rMO3mqD7PByPK+QA==
X-Received: by 2002:a17:906:170e:: with SMTP id
 c14mr7758141eje.275.1602150978403; 
 Thu, 08 Oct 2020 02:56:18 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id b1sm3532006edr.51.2020.10.08.02.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 02:56:17 -0700 (PDT)
Date: Thu, 8 Oct 2020 11:56:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/2] iommu/tegra-smmu: Expand mutex protection range
Message-ID: <20201008095615.GC2349275@ulmo>
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200929061325.10197-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com, hch@infradead.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 digetx@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2412602474335815458=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2412602474335815458==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 11:13:25PM -0700, Nicolin Chen wrote:
> This is used to protect potential race condition at use_count.
> since probes of client drivers, calling attach_dev(), may run
> concurrently.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Changelog
> v3->v4:
>  * Fixed typo "Expend" =3D> "Expand"
> v2->v3:
>  * Renamed label "err_unlock" to "unlock"
> v1->v2:
>  * N/A
>=20
>  drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9+4j8ACgkQ3SOs138+
s6GrKxAAuQKdxk03qO0RyklzIvs/tQ4YwXAu25i2zLUTZsHePVoDX5cmHR3yMauj
QZKg81UOmUYDx2olNKqFfb6r+0cQUh1A2WXOufC4PaDDrOXTtztY6UAtjkW4subD
eASIetGdq+q+LOY46iq4iKtMMGCC50lEw7deNDcy2pGsawdVSpxk0EqSJUl+847Y
u14ZM2DseMxV6/l/ZYR+RlkwFfevKTBCe0ZiMmT4pPFQ/OvCy0tKYu9cJthZMLxZ
VKxtJ/l/tcGmZh3FEnS74jL65OXbykbuOyRujnC+tJlsB7MoaPjo+V6SKtDNbx+W
a90hcFiTCrBnEXjSDDvBeHm7NZEDKyD7s84WP3B1X3cXKJ16t9rNKCSMofj8RRVi
J/FJ4bYeBT9IGwrkEwroh2yBV3tVsv8OQkgPC1vxkB72vfDsz1FY4OsV3gz9+/Ai
k6sKVM1YyqKIDOWZT+vvleYz+mJU3cifRBl9pmktdbunjasHYIJFcfiv/+M7qkqW
lt75sN1s8H6TIKFBTb9ZEPOsfv2AbHa1+ibCwFdkcUfcNUU3n6wAuy+TO/9R65Ss
JtrbZIbhykdN6gnxVhb8FkcUn8JNx/AD+iSgkw4fx6GGaX6Wca0AcWedFRSV/6P/
QRFPkms+FTsdvN88T+PPqy6bmlV4QDxPKowfBQMyZHNj/cJKN7M=
=dNPP
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

--===============2412602474335815458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2412602474335815458==--
