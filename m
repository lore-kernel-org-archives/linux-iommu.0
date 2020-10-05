Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56612C4727D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:31:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8972078E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb5qqgpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8972078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B0A020495;
	Mon,  5 Oct 2020 09:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tOQU3stQVTHD; Mon,  5 Oct 2020 09:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D565820010;
	Mon,  5 Oct 2020 09:31:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2421C07FF;
	Mon,  5 Oct 2020 09:31:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0B9AC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B53B7855DF
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3kRDc_XhY2X for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 09:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB7B5855CB
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:31:43 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id u8so10928842ejg.1
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CDBSCw/dwEmizewDqX87tKG9xgvP2y2FDr8FFl+3O+s=;
 b=Jb5qqgppnEg5esvTmnjvx2cF+ktWMPxiP6OA5aA7haFtXeLNxIvey5VubZSAHGBbTH
 oRSQfKRDiEw3zkdZ+XfIH9z432vGDxHXMwQOMAx4cuJ5PrJKj+bPKstJH7i5Lnm4ltxm
 DPyVquaRraQepZw9fI8vL6iseDr9hME7eElE2A6zEZmyrVsd7+7M7/183BjLSEzwm46K
 6fiVj2iAmV06ZkQw8jAQhlSaAlX5CNPdmrXioRss0XUJg5hhEY1M4sxW4iQwqw8lq8vy
 XpfyfS7OoSt8mOBQ4lZC1ndRhrnZPdmIad69rOj+PY4RVWq77lGE6pze6ksaeclxwbtb
 YBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CDBSCw/dwEmizewDqX87tKG9xgvP2y2FDr8FFl+3O+s=;
 b=uBgvPtpcKL6MejA4+jMS67YRoTeuAIDBTTvr2Rw3uidpXs9xZC3e+fpyTPoMsPJ7rq
 NldAnXpFB/BsLYH3GIvqTEaEBrfZ3u0+W1Tnizkn8gckQYPiKoAw5GegiJW76B0WcKPK
 /TEXFRgT+k14SuvxkAhfIRyV/EArB4XsZJOHcDdAsoAS0NFn7s9YKmOxn9jsp9g7+G3G
 1rIa2hDIBvVr5f4e3W3taeL+sbFj9JvKZ015xnNpYKnk8A4prcpVjP4tZVmDL83BinZ8
 SYKFqhS/feWVNvRDDwkcWjtAtHUpu3hKkX7575/7bh9PTThE6JZfjmFS3ItpootK3Tzw
 nHow==
X-Gm-Message-State: AOAM531BOVqqqMbbT8JWPKsB5fQG0JgfhxT3B87Z7bC32UgH/wJVMRjb
 xdEHKBTZaxIRrBdrqxRrBOs=
X-Google-Smtp-Source: ABdhPJyOeeTdT4b07HWzaez6e/FZ0RcFdYx9UMsdVh4lZAM7C0PUGmjkimG+7tVa1MP6EVOIQT/POQ==
X-Received: by 2002:a17:906:fcdc:: with SMTP id
 qx28mr13484353ejb.52.1601890302309; 
 Mon, 05 Oct 2020 02:31:42 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id d6sm367396edr.26.2020.10.05.02.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:31:41 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:31:39 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201005093139.GE425362@ulmo>
References: <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo> <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
 <20201005071338.GA425362@ulmo>
 <2b1a3ee6-d556-4172-3314-0c852d3c6916@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2b1a3ee6-d556-4172-3314-0c852d3c6916@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============5387412467994292586=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5387412467994292586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 11:14:27AM +0300, Dmitry Osipenko wrote:
> 05.10.2020 10:13, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> > Have you also seen that sun50i-iommu does look up the SMMU from a
> > phandle using of_find_device_by_node()? So I think you've shown yourself
> > that even "modern" drivers avoid global pointers and look up via
> > phandle.
>=20
> I have no problem with the lookup by phandle and I'm all for it. It's
> now apparent to me that you completely missed my point, but that should
> be my fault that I haven't conveyed it properly from the start. I just
> wanted to avoid the incompatible DT changes which could break older DTs
> + I simply wanted to improve the older code without introducing new
> features, that's it.
>=20
> Anyways, after yours comments I started to look at how the interconnect
> patches could be improved and found new things, like that OPPs now
> support ICC and that EMC has a working EMC_STAT, I also discovered
> syscon and simple-mfd. This means that we won't need the global pointers
> at all neither for SMMU, nor for interconnect, nor for EMC drivers :)

Well, evidently discussion on mailing lists actually works. =3D)

Thierry

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl965/sACgkQ3SOs138+
s6HJGRAAildbg4PihpvPPfkO7Ax8XISE/H4Kp0fUaQE9N3ozrQkK1thMGB8lf5r8
tVPRP4qiX5qhVBWV/6KVrVR8i+dtC7b3dPPyufYh1u9AWQa2K6HqGhp5rfQboLOU
9AdkcVuAhN76AUxFC+nQBqFrx6gZ+O0Iuw6jktebl0fu66WgrjIR5EM2tt2aNcrH
rQloZxPYrBJ02x1ODjZF0Jl6rriN+VffPW2Aa6945pMl3c8/DGPpmPWOTs25NZFI
CHvUyO4tooyJ2rHH/c3FYCxGXqxsm7MPzs+GR7CZPLFJO6yvMdUzyGUYiODJRIK6
XvNxm8Rhy7GHDVVvG2PwTgTc5BckkMgU9mxJE/NDNpNApKM7a4RTowPCNjbPRHRD
RvrasRd6mP9IUzms5sJot3ifmmb0RIR0QBpwFUKL0crNlC+nH168cBkHu7AQP+Q+
sUGG+qCjlc0ZGGJhdEVQW5whWeJ1T3ZFWRHGrEssiJgOVRFZgwcvG+fDMjTHqkEx
+T5rcsNzhYepv0/smRTvcQZpVBaOYZGcdqjxLhwPo3KIHYZ6bb5LD9hO/pG0OGuU
uLuActO5ESJY/Y7mE2mlXuBKplcDnqw8p1TzOzlDJg+RcBOdN3cDbgK60dCWKS+k
jk6yd2aG2dgkJzbqYsb2hHicrguVq44boiF0/xrJCjwVRA34tSk=
=YBNF
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

--===============5387412467994292586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5387412467994292586==--
