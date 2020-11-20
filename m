Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326CDC2D0E4
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D35722470
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2o07a2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D35722470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0EE8D87258;
	Fri, 20 Nov 2020 16:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mRvjFsrVjKUm; Fri, 20 Nov 2020 16:23:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D36A187247;
	Fri, 20 Nov 2020 16:23:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1E43C163C;
	Fri, 20 Nov 2020 16:23:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0083FC0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DFC2487247
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uP05E+AKZNjx for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 16:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B4498722F
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:23:19 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id u12so10672757wrt.0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yHfeIxBJqcIQLqbSFekxP2bhgtIneNef2F2uGZEaThw=;
 b=e2o07a2T9OSAxDeX4I/1z6g9ibw9Gy0obCn8RRtJuzq4u2XrIuiNnV6hIhEgjJ9S4M
 JuHlfFrOAlqlL4zMWH983aWA13ktsrWDBpldk1v0TjRlzQp2X95CGMJzVNUbYpaSz4n1
 Xi6IrH72Gd7nLOqz3j7ph6cKGp8Rv55M6fK+fFDs1UntFOgBNSMuKKSmBi1grDDpszrq
 QN8j1LexweGr3RwMrGR8RKcMgl7FbtjQslHeqdald5ExV7JgzZ8R+yNmYsuL2smcvqJ4
 2oO1Ofh7eyi034AjBUGC3WylG86za0VrMblrHgDTUb/Nau2/d/4ZL1Npt7QGSz70Lnhd
 TQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yHfeIxBJqcIQLqbSFekxP2bhgtIneNef2F2uGZEaThw=;
 b=tuIK/r/QCYTvhJHX8KY/mK0gJWNGJykCluOTgkhYRprXq2XfmW3OC4NIOt14i0brD0
 1eZZULOqdni/i6AKgHVSxw5Ly029J0cvEwfkO3vSqLlIu+tpXN4UqIEspsCnIz8IxiEI
 rEutc3phgCfguhkSK7RTs2lEwJ50DZVeDQs5nhOhznRXAyOcsxwhm1DRv5xXiUcAfjBN
 xFRxH+XA0+yOeSyoSwQTk/bzMfRtAecevcwoMW/n10J+rDuVs6LiCmsXsgAjOPjRo5OD
 8dhvn+2+azpVnpLuE7fBmTRbficK8s+avLZDV+hb/tlVk5uqgdgL5CL4HBAEQ88LozTX
 4GVw==
X-Gm-Message-State: AOAM532y8CBZ47GIYbNORe2qIQ+jPeR1lNI88lVoPe4gbf8mDYTCzeMC
 vbmSRT6ZVu/FgQgLosit5v8=
X-Google-Smtp-Source: ABdhPJwqVFIZSU2xiJMP87lpzeIrFX5wbv+om0zrwEh/pjd29rWqubeEaNs9Dbyszc5cxdnJBQoOkg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr16314771wrs.377.1605889397585; 
 Fri, 20 Nov 2020 08:23:17 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id r9sm6163644wrg.59.2020.11.20.08.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 08:23:16 -0800 (PST)
Date: Fri, 20 Nov 2020 17:23:15 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RESEND 3/5] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
Message-ID: <20201120162315.GE3870099@ulmo>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201111222129.15736-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201111222129.15736-4-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============0578954389983887790=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0578954389983887790==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 02:21:27PM -0800, Nicolin Chen wrote:
> In tegra_smmu_(de)attach_dev() functions, we poll DTB for each
> client's iommus property to get swgroup ID in order to prepare
> "as" and enable smmu. Actually tegra_smmu_configure() prepared
> an fwspec for each client, and added to the fwspec all swgroup
> IDs of client DT node in DTB.
>=20
> So this patch uses fwspec in tegra_smmu_(de)attach_dev() so as
> to replace the redundant DT polling code.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 56 ++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+37XIACgkQ3SOs138+
s6HAkw/+PmjgJPEKxh6qnbdjpnubraymvfGZhEjp6Kv2WsQ2tWhzOjxjFf4jWFg8
Wi/o7uMwaKQuvuynTDiY8MrOBCuZCYaQVNGlJA9eEPxUbn+EF4VM2rM2LnDcy15s
jjlIQkXgaFoHZrOzUkzRCmZ+lwkCjHvtB+t4IFrUQd4lUxHxHU8uNcJOReTmYrd0
qajHrMgQDm2jyu+rnYz4LtGqy77ThyV6nvBs77wwz94lMbEZ6k5TlV21VeL4Wnbs
EQWADpM9rDO1MhMJbuKhq1wGDHqwzD4vLlMZ0/jJ1rBpvMH+0X112atPFiQQ5ccO
e0TJ48vP8maiq8h//J5wqOXJ17qUP7eDkrExl6jUUjMc0CKO/qsJqYsGAj770vn3
iD0Wq1ceQD17Dt7x5HUmjASmXEShaKVHZwsJh7YSvfx4tyZATcVgMvC4/DUm7SWI
sMvT02aHnRVEsFbM3CQv6ijmqJK7/2QLHZ2UE+YUpJTzySTQ/WyDe4qD6XgE94Gn
VgZfpAuoWd02z/Kj9qQYyFd3m+yHpwgoFpkTIgliJp9jVI93q4hNGjGaeUJsnemN
FMvWuZleGcxA21lVYcAsYstEvcjA6MtdL0J6N/Z+yfwgDo/Q051UmA4CSbw0kpT1
D+cZjGmt7tdVUaql85FHHTxW6hP3mRD+eQjQG8wf2Eci0ZahJBA=
=OvbI
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--

--===============0578954389983887790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0578954389983887790==--
