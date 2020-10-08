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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE4C43467
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:55:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EC72083B
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtlh2t+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EC72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9EA368745D;
	Thu,  8 Oct 2020 09:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gk96p73-OmvB; Thu,  8 Oct 2020 09:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20B6C87455;
	Thu,  8 Oct 2020 09:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 052E1C016F;
	Thu,  8 Oct 2020 09:55:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBA0C0051
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C51BF2E12C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZgcGfH-ztAb for <iommu@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 09:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 9533D203B2
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:55:54 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id lw21so7210450ejb.6
 for <iommu@lists.linux-foundation.org>; Thu, 08 Oct 2020 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YeuhPRr+8z262NbOKlojpiKbS8DIdyX4GR8PkpnezB0=;
 b=jtlh2t+5xcZBhggDN5WpgGQmepHy8x+EweLX9DghVtSzvdufoquh2mui6ZfFe8jY3R
 500ZVRB52Ufx27weClRmA1cmWfp88YjvQCmA01N4x98d2jVWTmmF1xpd19HVglO5lleG
 txj63Rmzm2d0sjosdnfsW2quBTj5qEw0wH9CD7Gwdx7MrKKhur3ndcy1zaDoZpD9XqFP
 pZaRLlfzsXd6ThyJZFqDxxIZKWRx3ZUkifdcP7EgCNQWB/ImdRQFn1ELT5/H8zgBfShA
 Vys/1xi5j+9pgEhk8TrgbdBEjBBa7Ufj/x7ZIO9d8PEYaVK9MXT9Ilk3mhODFWzGpsHH
 uJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YeuhPRr+8z262NbOKlojpiKbS8DIdyX4GR8PkpnezB0=;
 b=Y51O61lKvqpky+GMiHW4334X3+LYyisKCZAAcStbxG3NE8jKRE6kPgtmNiHD8Gct6a
 AcNAoSTE/ffxX8jWyEv/BSB5it5/mjUpYSfxOM75mZ6J9EMp9MQ/AOTP7FAm+8BwB865
 h26wvtENbkyFViocBJZzobiaiYB/ore7E/xSq2su03+10UshykZSW6MX/FBPgAIvkj56
 xEdgOhhoGZSkYCrnoD++v64lVh6mMq27RbfRZesLi5L7Ee3usYBvFvS6lc0L6lFsxkgr
 Y881nsFnt6vIMBdy9rMb8VSHivAiNAdBL5QoT2V6yk9MyRnqhlKourg8u5t6dJVQGtJi
 /fpQ==
X-Gm-Message-State: AOAM532Mm17/JNs5an1dhafNO2Rqa42uxXABQR35PffssOLJ8Kha4dF1
 F7VQ6uAnegnE7mx5jaBW+E8=
X-Google-Smtp-Source: ABdhPJy7Lbb8AaP557Gk3yqm0KpsSiddDmF/zhqYKtfCpy70LnUSpGLTwrzHGMsSA2rTJR2/MKb51w==
X-Received: by 2002:a17:906:17c6:: with SMTP id
 u6mr7920515eje.95.1602150952873; 
 Thu, 08 Oct 2020 02:55:52 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id oa19sm3711344ejb.95.2020.10.08.02.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 02:55:51 -0700 (PDT)
Date: Thu, 8 Oct 2020 11:55:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 1/2] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
Message-ID: <20201008095550.GB2349275@ulmo>
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200929061325.10197-2-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4154279351389123899=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4154279351389123899==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 11:13:24PM -0700, Nicolin Chen wrote:
> The tegra_smmu_group_get was added to group devices in different
> SWGROUPs and it'd return a NULL group pointer upon a mismatch at
> tegra_smmu_find_group(), so for most of clients/devices, it very
> likely would mismatch and need a fallback generic_device_group().
>=20
> But now tegra_smmu_group_get handles devices in same SWGROUP too,
> which means that it would allocate a group for every new SWGROUP
> or would directly return an existing one upon matching a SWGROUP,
> i.e. any device will go through this function.
>=20
> So possibility of having a NULL group pointer in device_group()
> is upon failure of either devm_kzalloc() or iommu_group_alloc().
> In either case, calling generic_device_group() no longer makes a
> sense. Especially for devm_kzalloc() failing case, it'd cause a
> problem if it fails at devm_kzalloc() yet succeeds at a fallback
> generic_device_group(), because it does not create a group->list
> for other devices to match.
>=20
> This patch simply unwraps the function to clean it up.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Changelog
> v2->v4:
>  * N/A
> v1->v2:
>  * Changed type of swgroup to "unsigned int", following Thierry's
>    commnets.
>=20
>  drivers/iommu/tegra-smmu.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9+4iYACgkQ3SOs138+
s6GPJhAAqI2OuqFHW34225nABjRPlBJmkRxEfhdWt4JMwwSTBHVoEYgPVEKK8RCf
choO2k2iA0fU0UWd5iw27tWYGf6esq4PR+n/LjH+0HjURQJJcnxNmt2iVzSnnZSl
lpCGTHsBXbXDSDQgmsxRFuqOubzqXzvOue1phB8siQIQoP6vPIDnd0ufw9GTxiFn
/dl+M7dFPUhrW1UO8ALNbYXqm4qW3TU0r1oJd0JiYuV+Pv56qScwHxjTT5fLGbWz
z5NVwpMpdahu4UuVUtVBLpJwJmyLZD2NhFlkmKViSc8jaL2+lMQrjO6H8RZ1IaXV
XWJISwJqgk6TPufmYxj69I0z1TUKpf3T42quyW6gs4laOh+xlwLiO32i/70itk3u
NulgzRRi3SA/qH+dFAICOnDfzN23YzI3Px6nMr/sbFCq7zdVKMUyGPRhbxEHmApz
gdzNtmFTYqq0QpIsrYnQACnwP0b9IJX0h831Rzx0IWxh0r5n5ENfxVTLTIPgQ+A0
Nrk3/6MSHPUi5VBuKfVgriAC6YBnuz/zKabII+kR+Eh91SkZej6zDu901djPE/KS
SwgGVyWDazm8dLqm92uC6K7xbIMlOCN9R9rLZ2ePMQVYsN1ZshAQaU/C+3308ent
aSDwfr1KjKkAF03Tflykp7Rwi8Kq3Aioq4+e6qi8lGXffkRllaU=
=nE27
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

--===============4154279351389123899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4154279351389123899==--
