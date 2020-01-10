Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9961C33CA3
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12DF2077C
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEi0dKiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12DF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D26C875E0;
	Fri, 10 Jan 2020 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8QTG9ewnvAG; Fri, 10 Jan 2020 14:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADE928756D;
	Fri, 10 Jan 2020 14:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93AE6C1796;
	Fri, 10 Jan 2020 14:34:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED79C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8CC7288496
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7W4y5jVKBJLP for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 14:34:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C64D38846B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:34:40 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c14so2017520wrn.7
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZMNQJdAFaOKSoBirJdfDDp1ez5wjioL8ZApZUPhDZGA=;
 b=PEi0dKiUVGpgkbyvtn6TmoyBcrbk7DV/nGOvh2MXlE4dpi790wSCeUvat1J1ODbDVa
 1T1pfyL5N1i/0ADA7w0TEzdb/vZ0GeJhKwbCmc1xPphzWSnZvlc5yyFz+33d0z8EnHDl
 q0+1cx3xc4lsoVJY34OsuhrlPguKYeAs+UOvlvsg4YS2fp0nZhfE5hlYfSePQ5wHxups
 VgSul/x6p2+AqLu/UgnBf5Sp7oyHbebfFu3pFN+seZyMhxcWfYP0VoTKfdlotqFZY0kQ
 mMhh7s1so0SXdEcDGDRQ7zic3DEJc/K/shgxmvY22HPRfZxey2mGmt/TL4fFV6mQH3sl
 S+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZMNQJdAFaOKSoBirJdfDDp1ez5wjioL8ZApZUPhDZGA=;
 b=CVkDpKL6CC2FZ+mSj9MmG0DAUTUUrmjptnbjCx16Uivd8hC8NlGPv7FauKo7w6t+k2
 jpDxdvBOc2Q1ACRBEf/Jyczb5qiuShLQgMIlI85VUyJ26Xb4qqqsUMROysxA7UDUFDiL
 QCYlBL8ZRpHEUQytXz1ajDKkwzbxwZpKRLaLvZwisJ5aY497qyBhaAbl7BK3dx+XkWSi
 e/MaMn8HqUxAvjC6rMA/KPrx92+kgHsHenbxDUvEzbrIIXidPg3kgUC1ty3iNazWQw7h
 J6MPPLNG06vg4tln2LW7rvACUnQesGZon9lJHECq9EyfHCPXLxPCgSjOAQsyKgYiBA3W
 Oc9w==
X-Gm-Message-State: APjAAAUuZHiLuSPtwIjpFARsQjHVFFEjBFr2X3db3vOCt2/ynnaOtm64
 jXbTd4/vUisxa+QJ1qCL9a8=
X-Google-Smtp-Source: APXvYqydmYwjuRWpEnJW7zDkNndZMMKDmmNZQ/qF/g6CupwAPvWiwlhDNfoY0qM9c/h1uUKnpFpfEA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr3821479wrn.251.1578666879258; 
 Fri, 10 Jan 2020 06:34:39 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id h66sm2536850wme.41.2020.01.10.06.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 06:34:38 -0800 (PST)
Date: Fri, 10 Jan 2020 15:34:37 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/4] memory: tegra: Correct reset value of xusb_hostr
Message-ID: <20200110143437.GE2233456@ulmo>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
 <20191220002914.19043-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191220002914.19043-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============2162662091129265723=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2162662091129265723==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 04:29:11PM -0800, Nicolin Chen wrote:
> According to Tegra X1 (Tegra210) TRM, the reset value of xusb_hostr
> field (bit [7:0]) should be 0x7a. So this patch simply corrects it.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-5.6/memory, thanks.

Thierry

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4Yi30ACgkQ3SOs138+
s6HnChAAlH9Yv1ffvGQBL7EGN1kk3CBGC5ioxvxbPHjtk7tQhpESolBHMLLsAGIO
a8MT248f+xIhyJ1KIcr2KBatN7OHkpDzwbUjqEY/YkpVtaFv+OtZiTLGFOHXF/IV
r+NdozdY0wYbcNr84AGJoIjGzUP4yxreQ5k+MeZhZiUlSAwuSqGBaXgNJO3ILwP9
MkvWIWF0qdIJaFr9TnekBxusLdjkk+5+S8wWkgBT8t3VQidLDJwcrbvFeey6+zSm
G6cfuLKRPUxnh0mjrhptz+ykE0ew4mDoN1KcmYRu0pdz3Em9SAfg0bFUiuZXhz+w
gsEsc/DWhsTzG2zbSuO82oTes1u66rwSz6LzUNWX+isAbUazd3MpN8Ff4xwuSDHk
7wQYbG9514z60MXQQ8DFvoKaRikQXF2TcTESvOZRcaUxOcEqDrhIYSif+cFHiYfU
hWVv1YU6RIH6oQO4gtVbJbNPMYrNxwbifLm46fHkiylkc5VOFelXRd4roXdhNZBX
uqmSY0sa/7xUNmXaCvS7N1tOrfmVSXKWBzRB1waCZyhEkFnkreWfa1KCQh0KMxLT
GsLAw6ICzF7cgR0WWMd4hc04bEU8wG+eWgDZkysK2hVRl3sG7hyCnhahT6OugCpv
4jDTUd2qR7tScl63x4t0yM8WiWgeRia7K8S4L7GIwXpvjWjYVUU=
=PM99
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--

--===============2162662091129265723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2162662091129265723==--
