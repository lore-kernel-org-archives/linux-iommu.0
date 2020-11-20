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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58AC2D0E4
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:26:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BAB22269
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od9jxWni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BAB22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC8C286F0C;
	Fri, 20 Nov 2020 16:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNbW9ui9C5QD; Fri, 20 Nov 2020 16:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 51AAB86EA1;
	Fri, 20 Nov 2020 16:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36288C163C;
	Fri, 20 Nov 2020 16:25:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCBC1C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A2A828725D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2KgkTChcbxo for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 16:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E0E0D871D2
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:25:55 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id 23so10599424wrc.8
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+I1reH5dk/J0zuxIjf6wcrh4BTrYoN3pbioJgAhPBb4=;
 b=od9jxWniPkZlg4ZjNeoy1USoirRl+VQDuMn8CBqwJUr3RjUFMw6IYKU5NVRrERjb1S
 MSrNqC1JuKXXY84nA2K7CJ/OYqlJfvLpzhPPQmG0Fvd6tT8ygTaY9ulUxtrBiwdGfRID
 8jo72lDNw09dCqurXT3tRMbRJrw62PXiAn6qa9u4w05EQ+FQEcVKSXFZvtu1Sn2noIjJ
 hjlISL+bsVS7nCl6pDnlQA+DYQfcFnXaqFVKMRphnGsYUq3tXXOJhcRSiJftG/BrTXxQ
 vtdXzc7bprfhSI7Nx/bysg2cEL31kAThVzD329hiJThrH6d/RpQ9UbPFLW1oNbNUObKi
 MgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+I1reH5dk/J0zuxIjf6wcrh4BTrYoN3pbioJgAhPBb4=;
 b=HJ8+Cej4CB1Mc2HNbvPi3XtGNUgLZXQvqPOXP5tTgefvVd52mAop0+PrwjjXdA78/U
 RmUfPlH0uJgHnXj3PfQuHHeR/kLNKTVSOZj8w1zTb1OPvgFWzbfyCFDutFhre6TW7uB3
 WP1wVXLcVulMBxDTrwxsRF8lXSBKC+cgZ7MUdfiGRhrYM57N50kCr7jnuVk0BVw/zVA4
 soZ7SCcjrnljRkYGF5GEhy6AwIRqow2uxhHc2lzS5NuI4+0ksgmKLvU02cVLxluaeOP9
 ZeHE1zXTyXGKzqghCkVFDHHNWcPwXSb2ZsWs7mN2yjnbgT6pZ0azoHr3EwnURY7U+2mL
 7ljA==
X-Gm-Message-State: AOAM530iRDFC2+LmReglTZfaCYuqBR3XFpvZhA/Tmor337tZRRdIYiVD
 owuqRyG5XNnUw7Wt9a5+wBM=
X-Google-Smtp-Source: ABdhPJxo4f8mmsFXziLvnJPXu9y9Yj0jsO0+b0yoNx/HAIHBZxZgz+v+KbU54gAUz+t00cArAmRE3A==
X-Received: by 2002:adf:a551:: with SMTP id j17mr18557697wrb.217.1605889554442; 
 Fri, 20 Nov 2020 08:25:54 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id g186sm2809119wmf.2.2020.11.20.08.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 08:25:53 -0800 (PST)
Date: Fri, 20 Nov 2020 17:25:51 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RESEND 4/5] iommu/tegra-smmu: Rework
 tegra_smmu_probe_device()
Message-ID: <20201120162551.GF3870099@ulmo>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201111222129.15736-5-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201111222129.15736-5-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0573158393079329080=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0573158393079329080==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 02:21:28PM -0800, Nicolin Chen wrote:
> The bus_set_iommu() in tegra_smmu_probe() enumerates all clients
> to call in tegra_smmu_probe_device() where each client searches
> its DT node for smmu pointer and swgroup ID, so as to configure
> an fwspec. But this requires a valid smmu pointer even before mc
> and smmu drivers are probed. So in tegra_smmu_probe() we added a
> line of code to fill mc->smmu, marking "a bit of a hack".
>=20
> This works for most of clients in the DTB, however, doesn't work
> for a client that doesn't exist in DTB, a PCI device for example.
>=20
> Actually, if we return ERR_PTR(-ENODEV) in ->probe_device() when
> it's called from bus_set_iommu(), iommu core will let everything
> carry on. Then when a client gets probed, of_iommu_configure() in
> iommu core will search DTB for swgroup ID and call ->of_xlate()
> to prepare an fwspec, similar to tegra_smmu_probe_device() and
> tegra_smmu_configure(). Then it'll call tegra_smmu_probe_device()
> again, and this time we shall return smmu->iommu pointer properly.
>=20
> So we can get rid of tegra_smmu_find() and tegra_smmu_configure()
> along with DT polling code by letting the iommu core handle every
> thing, except a problem that we search iommus property in DTB not
> only for swgroup ID but also for mc node to get mc->smmu pointer
> to call dev_iommu_priv_set() and return the smmu->iommu pointer.
> So we'll need to find another way to get smmu pointer.
>=20
> Referencing the implementation of sun50i-iommu driver, of_xlate()
> has client's dev pointer, mc node and swgroup ID. This means that
> we can call dev_iommu_priv_set() in of_xlate() instead, so we can
> simply get smmu pointer in ->probe_device().
>=20
> This patch reworks tegra_smmu_probe_device() by:
> 1) Removing mc->smmu hack in tegra_smmu_probe() so as to return
>    ERR_PTR(-ENODEV) in tegra_smmu_probe_device() during stage of
>    tegra_smmu_probe/tegra_mc_probe().
> 2) Moving dev_iommu_priv_set() to of_xlate() so we can get smmu
>    pointer in tegra_smmu_probe_device() to replace DTB polling.
> 3) Removing tegra_smmu_configure() accordingly since iommu core
>    takes care of it.
>=20
> This also fixes a problem that previously we could add clients to
> iommu groups before iommu core initializes its default domain:
>     ubuntu@jetson:~$ dmesg | grep iommu
>     platform 50000000.host1x: Adding to iommu group 1
>     platform 57000000.gpu: Adding to iommu group 2
>     iommu: Default domain type: Translated
>     platform 54200000.dc: Adding to iommu group 3
>     platform 54240000.dc: Adding to iommu group 3
>     platform 54340000.vic: Adding to iommu group 4
>=20
> Though it works fine with IOMMU_DOMAIN_UNMANAGED, but will have
> warnings if switching to IOMMU_DOMAIN_DMA:
>     iommu: Failed to allocate default IOMMU domain of type 0 for
>            group (null) - Falling back to IOMMU_DOMAIN_DMA
>     iommu: Failed to allocate default IOMMU domain of type 0 for
>            group (null) - Falling back to IOMMU_DOMAIN_DMA
>=20
> Now, bypassing the first probe_device() call from bus_set_iommu()
> fixes the sequence:
>     ubuntu@jetson:~$ dmesg | grep iommu
>     iommu: Default domain type: Translated
>     tegra-host1x 50000000.host1x: Adding to iommu group 0
>     tegra-dc 54200000.dc: Adding to iommu group 1
>     tegra-dc 54240000.dc: Adding to iommu group 1
>     tegra-vic 54340000.vic: Adding to iommu group 2
>     nouveau 57000000.gpu: Adding to iommu group 3
>=20
> Note that dmesg log above is testing with IOMMU_DOMAIN_UNMANAGED.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 96 ++++++--------------------------------
>  1 file changed, 15 insertions(+), 81 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+37g8ACgkQ3SOs138+
s6F+xw/+N+OMe3ACQDL5/QRhFeyaUKtsuCJFjxb7c6AlhlBT475F5YLjBaIqbwrU
UvFbg9Vh6tvRKNWcimrZ1pRQlMPWVTaEchDjSSZkN1cbJS+Q2bTohKgivBnaGkz7
BI2CiJ1JWiUutJgLDmaDi9OvppXhpQf47Y9kqb72I537w6VLe6YFD9lc1EeF5TSL
fYOqXc/vYPsSyhZHRhtI5RK1XBpFpZg6JtBla509oPMT35VrV3CylM0LPsqiqBMS
CqkiH7j2/NNTDefyKwDdSU5fO6YMAIJH4des3q1ZlN4eF4g2g0t1ulPvbo1NX3Q7
xAPVzVYZM8Yf7Wouds03SosVi1A8SnezELNdmx98afFEoFyEkTq9cqTQXL9frbzF
OLmc158lDF0QOkYB408NIVEmjrkr//yIIq6Ed8WAqlLWoVcfGPwpcF87AV22yPBx
r+umfpgazSNfX0XKR6uwqcZ6oE0s6OGuB+JMAHgTWgocJsiNYH2+tiGxn/avf1TL
Iw/mOhzwVVBSe7r9InbFN2abEG3m3Z8yQeXfEKJ7SgD3kdfKRMsgceXT6owCfeGZ
5WQGyzKyPW16VirmQXqoU4uAxHqxy+9wbL3j1SjEfUgKOS8MSFRBYlroQ+epmhQN
BBzC4mfQzN0xZYpobqlxI3VczQFEygcC2JVtlZlXTF/L6Lxq+ko=
=PXrQ
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--

--===============0573158393079329080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0573158393079329080==--
