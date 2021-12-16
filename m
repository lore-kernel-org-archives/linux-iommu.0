Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8337C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 08:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7215240AE9;
	Thu, 16 Dec 2021 08:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHfhMt3SOICV; Thu, 16 Dec 2021 08:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E53440AE1;
	Thu, 16 Dec 2021 08:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6B92C001E;
	Thu, 16 Dec 2021 08:54:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B72FFC0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91B6383280
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ZhQ44UbTc14 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 08:53:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E50E283276
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:53:58 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id t26so6487637wrb.4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 00:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zuHdQz/z1bGX+waW3JEYSIB/zdyPyOGdaMILzn7AVeU=;
 b=gEikQ5mxHFrS7IzxE+OyQ9FYSv5Kf/JcXXN/MV/+vG6gMeY7N1OsufMvV9yejt05SF
 VWdnbu4ueBAReGotImQgOEex9xyCYevoN+jQH6PFDvBJBtEnfH6SazBe8aR9aMe84WCZ
 gPIxoS7dRE2AHEl3ppk22yPQ5dfqqQdQ/R8y1iZXDPelmu81kayXQeborMW2wrX3s6lR
 7DA44a0IpA4d2j3uLgdZ0q4ddItDszzSJSm5ogoQg3vXhd+5glJJICPzCEyvWJlK6dNH
 rz+zYOb753blMWsvTe4+LmFJI+3bDiGcnnaHuN+C1xIAyrvbRNl0Lbjb5mrRTz7vnhUb
 oq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zuHdQz/z1bGX+waW3JEYSIB/zdyPyOGdaMILzn7AVeU=;
 b=QOsVCj9SHjv3Hgp+Axas/yXuuLC/8vB+pPdw8liUqI12yZM3Jmzm2hJwFrWziz7yzH
 UaRMXQnJabrdWoRoOUOKV8DhsUaimXhAgKe1nJDJKtolxIwgni1Xb1S8tF7wizs/8ew8
 S8AW/qOHlvtBD6GYeELN+S280FvF9DkvV35Qhkbc2l8LaUMdqUFLpHpkzeGCF6mJxsX5
 86qfunHIP6AiXIftV8rpJZ72apzDbv/1RQkJWVKUH0r188bZ+8/wAmHKxxxOD8y0pNAD
 kj9ufP4Ace1p3ohYMY6cX/aaL7Qmc1SOase4Ry5v/jJy2f0pfDTCwzv/eiNKmbOQtslG
 a4hg==
X-Gm-Message-State: AOAM532PH6U3ytHrooWexsrmD0G3Nscw/Z+U+56mJ4eNjtDRpQ3lpWdh
 W2BaeBiOlUiebQTms2ewWMk=
X-Google-Smtp-Source: ABdhPJwp3BTifW88zZDU6LbdmwMYSvHsNSURwVnejLkm7vfmNtvhg0HU0qUIrf076ZzxB+YENumPSg==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr8387009wrr.492.1639644837026; 
 Thu, 16 Dec 2021 00:53:57 -0800 (PST)
Received: from orome ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id n33sm7435943wms.46.2021.12.16.00.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 00:53:56 -0800 (PST)
Date: Thu, 16 Dec 2021 09:53:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 02/11] gpu: host1x: Add missing DMA API include
Message-ID: <Ybr+oM8B+yxbwAiK@orome>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <cba5353b636117835512fab7646788d89db033bf.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <cba5353b636117835512fab7646788d89db033bf.1639157090.git.robin.murphy@arm.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============5723638550356140076=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5723638550356140076==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sSiHttHjd4ANYL++"
Content-Disposition: inline


--sSiHttHjd4ANYL++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 05:54:43PM +0000, Robin Murphy wrote:
> Host1x seems to be relying on picking up dma-mapping.h transitively from
> iova.h, which has no reason to include it in the first place. Fix the
> former issue before we totally break things by fixing the latter one.
>=20
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Mikko Perttunen <mperttunen@nvidia.com>
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> v2: No change
>=20
>  drivers/gpu/host1x/bus.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--sSiHttHjd4ANYL++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6/qAACgkQ3SOs138+
s6En1A//d/JxdmfP3y/UDoHH5rwtaLTrTkSeujiv36BK7vPY9dIVpiB/Up/FgTw0
Exwl6pOwajQybixpbZUFw5ySCyPNza1WYKPOLe+/Trv4kd2G2OMCTJK7dc7AakXR
X8vWNlyxwRvgnbtA2rV61uNaBXUjAVFLQsFIiJ0yCvt+Rn0MKXKfpvDDEVzOtsmI
e2vGdgHf2Xk4EJaPO2GQGrY2Vb3K2tJN/OHw606y4OhMrSldKzEtGpSMR39k3QW4
Isulh0KpOgzDTwUuKSID/K1tz/aYhOuE1XCnET84NU6ieuPyNGmHksaqH8KCHceF
mE1G+AAVlD5Pf82CN2hOYw1GelRZYLZ2e3i6XrESu6uAxhQZKTA15hyYNbr2ZI7v
b0S6KIhNHH90FJqbzxYGwwETk2xt0DTUIAImfWqITb8SSW6fEMh6h98vzfFig3/u
0RfZVjJ8TTe5S5COkCg/Rfp+20djtHsihBzxS/FifpUW8FGJsD3InMqxNJX0PFps
gmvusybT5Th0b2B1n3JOSitVfV/za5rfSoBDcnlDlbTDYcmTq+ufTEKi3yKyjZW/
r5StmSJaNy6QwZesRAzaYgNlnFZ4QD5ihmr9f0lUXA0nwyRGOsRS+DOTmZuX0I/c
AShLEMm79+cBTwIhugsweG/Ehr1dSmqznnHfmuA+LJlw2jBMJ7M=
=aG+K
-----END PGP SIGNATURE-----

--sSiHttHjd4ANYL++--

--===============5723638550356140076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5723638550356140076==--
