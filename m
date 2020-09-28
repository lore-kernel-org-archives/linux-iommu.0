Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F1EC2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 07:55:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA5A22262
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 07:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRujn+aH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA5A22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 619C42002F;
	Mon, 28 Sep 2020 07:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1rmgKmmEHiS; Mon, 28 Sep 2020 07:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BD16C203E1;
	Mon, 28 Sep 2020 07:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B646CC016F;
	Mon, 28 Sep 2020 07:55:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44578C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 402728531D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LV_792d49KIs for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 07:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7911685258
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:55:49 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id m6so141667wrn.0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BVbwN/81blpncprCv+IQkG3sKzMlIpUh26oS8WcgK8I=;
 b=qRujn+aHOdYZcvhWNaNFfmvq+59z5zN/g2Fh/iOS9naiOmJIprb6+8FsHaN3yqhR9T
 SoAU+PMlakBl+lBe97YnRYnM/OB/19efDFQ8ktrGQX3N07B6EJCB/Kir+biySDR863SJ
 dTbZ2BQ0H34vyZ/DXDCQyApKxVbzMUBGGXLqB5TUCmYh0AAAPCM+R7NtbjM6R4touMcO
 e4L2xhzhAQE73/+uJl4zakcF8QIsLu5NGpUNNm/pYMJikHjYye1HfW4b9JV3tIXtVWDH
 i66gptHNIvs+jPlVPC43JE6/ymJ5yogiuKMnm3oMgbwuEsyibTm7IapjvfpZxZ/l5JcL
 2ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BVbwN/81blpncprCv+IQkG3sKzMlIpUh26oS8WcgK8I=;
 b=TFoumCkCWxm7XiU1F32zwFlHdj7pXHvxQky1a+uRB7GFWlx5lJB6JyXyafOy44WiwF
 ORxk54nQFVlnMnAfqy5fy0YVHdzNhhZ+zFj0ZM1yjPwntNLRfJad6xfsDNXTw0w4c/+F
 LA9io9NYFJVHW7hhZUXGwR8C8xlhOA4byqcc8OpOmopH33ivsd1CoyVJu6vmeKF2DKmv
 hNq5GLH3gWe5JkNGzm0UmaECDz9KaEmk6WmxJCRhfmKi7j+FokaRHSrGlnhx8GHEH56p
 aui3pLYIOTlpLRqh0j1H49YWI4JqosvMUyrG09k7502WUHXOL/pubX/B+88sSYiiAj0k
 RVaQ==
X-Gm-Message-State: AOAM530oOWEzo+RpjvwiRf+uUxMi2npzP1ZFTJvHRiVVfgpqAns4r36m
 8vGDrVDodHerSiorAl+HXZE=
X-Google-Smtp-Source: ABdhPJy6kBIrePaHTqKmGmBsQEtVR0qF/zVySEmGZbhinj1US60HRDWY2xrvuJPy9tDSyZv8oXAWqA==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr197900wrr.402.1601279747992; 
 Mon, 28 Sep 2020 00:55:47 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id m10sm182221wmi.9.2020.09.28.00.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 00:55:46 -0700 (PDT)
Date: Mon, 28 Sep 2020 09:55:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
Message-ID: <20200928075545.GG2837573@ulmo>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-5-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-5-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============0039820311742153348=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0039820311742153348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 01:07:18AM -0700, Nicolin Chen wrote:
> This patch simply adds support for PCI devices.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 97a7185b4578..9dbc5d7183cc 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -15,6 +15,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pci.h>
> =20
>  #include <soc/tegra/ahb.h>
>  #include <soc/tegra/mc.h>
> @@ -935,6 +936,7 @@ static struct iommu_group *tegra_smmu_device_group(st=
ruct device *dev)
>  	const struct tegra_smmu_group_soc *soc;
>  	struct tegra_smmu_group *group;
>  	int swgroup =3D fwspec->ids[0];
> +	bool pci =3D dev_is_pci(dev);
>  	struct iommu_group *grp;
> =20
>  	/* Find group_soc associating with swgroup */
> @@ -961,7 +963,7 @@ static struct iommu_group *tegra_smmu_device_group(st=
ruct device *dev)
>  	group->smmu =3D smmu;
>  	group->soc =3D soc;
> =20
> -	group->group =3D iommu_group_alloc();
> +	group->group =3D pci ? pci_device_group(dev) : iommu_group_alloc();
>  	if (IS_ERR(group->group)) {
>  		devm_kfree(smmu->dev, group);
>  		mutex_unlock(&smmu->lock);
> @@ -1180,6 +1182,19 @@ struct tegra_smmu *tegra_smmu_probe(struct device =
*dev,
>  		return ERR_PTR(err);
>  	}
> =20
> +#ifdef CONFIG_PCI
> +	if (!iommu_present(&pci_bus_type)) {
> +		pci_request_acs();
> +		err =3D bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
> +		if (err < 0) {
> +			bus_set_iommu(&platform_bus_type, NULL);
> +			iommu_device_unregister(&smmu->iommu);
> +			iommu_device_sysfs_remove(&smmu->iommu);
> +			return ERR_PTR(err);

It might be worth factoring out the cleanup code now that there are
multiple failures from which we may need to clean up.

Also, it'd be great if somehow we could do this without the #ifdef,
but I guess since we're using the pci_bus_type global variable directly,
there isn't much we can do here?

Thierry

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9xlwEACgkQ3SOs138+
s6HuvQ/+KWpcgdZCbKXXhl1yRvr0vAWBpqSaSn2kW0gf5hn9sHoalZ9dqV3sKXYy
ECgw+sJS/AxESl7W6nUW6yvmcB4XPZSArF5kohfzNo1EKjTO22zqdB/QCWv6k+Yv
ilWSOnpbLf93QAzkeYXgPYdC0iMMRZaREWktp4Qys/cx8CvuwHWuVGaXJwuo/7yx
5hfxPUI4GCtYpNllg+QhNJuaLr9GsG49g8HQjpzex5hIC5Q0Io6R6ExQaE0Cdr+o
op5oiJwx/Mb4DTvo58T79Y+yCdMDC6z0AscXMtRjtevSXEsD9m+04LMG2qYGwhwv
f4raAIOp/0iJ8izvdN3U7TuuJY6tIypySz30tgwQ5ekxEY/3uWJyTf+foCN3xoMt
s5lrAdS2/1EELM5YXqNjHZEBHSFCgjD4TvVtrWv1XZdtObaxmquBjoRlDfUhqHGN
2oHhVcPvGGolbgDqwIJZqnxr13GXfIcthhwUxh+FWWqKtBVsWwGgf2nPQ4tMeWla
9mMKMSKRDKF1TRoMlYW7iucqEmWETRTJY2bUBOrzK2llKYUdJMXrfIrTw29jyDJP
v/XNMXjUJzzlLAMnz7Oup7PQyzZWPzWmEUK3y5Sx5JIj00PIbVsLwPpFs25D2V67
kDwMOwzFrXmIKb606G0PUobcjid45leY99xzDN6QFH/RsUYrb60=
=8eZB
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--

--===============0039820311742153348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0039820311742153348==--
