Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9995C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:04:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412C02078E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMGSZ4jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412C02078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC02D86406;
	Mon,  5 Oct 2020 10:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3dUWE4MQxzg; Mon,  5 Oct 2020 10:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D4AF8610F;
	Mon,  5 Oct 2020 10:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED84CC07FF;
	Mon,  5 Oct 2020 10:04:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0988C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F25A86FA1
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXaZRYL9M9gQ for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 10:04:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 12ADB86CB6
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:04:24 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id t21so5874747eds.6
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=p3BM0kPaZyOPUQYWBvmUtL1qF+A5L+ek6VHw+7yxmPQ=;
 b=YMGSZ4jX8zZy/zJA+ymFeHemM9uTXw8KWpy+9+08a+s1kDuU+FLEHyOUFoHkq8CaJb
 VinWd4eIsN1NT7RSoqjueiIPYt6K50guGxOOeLU+hNIO3jW2Avr4mwvaXTNeVNYjOxmC
 hcx9QpFLQDk8ACHS9yPxfLlnN+JQT0Co0jVeL032FxGChFzsojq6wzwOzRB8wxws6PIg
 ThfJi+SYghZlg73IKb1qisxGHnkxezbWHSO3o0zD+9NyellUwFrg3sFVnyR2SEa+TMgo
 81W9tYs8VlPs0UiVzP25lc+0FaDu1VnKXr/Iz3BpSzBdHgv0gMArSb7ui3aSVv+LzzSU
 ssFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p3BM0kPaZyOPUQYWBvmUtL1qF+A5L+ek6VHw+7yxmPQ=;
 b=GgJX/GxfjfpvUaSYR+lOPZEEag4q4l6SDd+6oVckpCNGI7hFvoayhJTj/kZfiFU8x1
 PasEk4o3kfSrya1BMSCgYUEKibN8Jio/+X26S3urwSfDsnHyg8VfYLXN14bHBre/jWOx
 6824wghI1TRiMWpXSOKlEij3fU3EJwiS7ETnImR2C28RoNk/kTBTR3nfou9souiPDHSR
 0U26j3chEz2Yvwb17HAiY1Szd+IvNGtCPdHIGn37FC09mS3Ebo4HhVNjiwV/FGr4y0LI
 tfX8KA23+ajMt36WK17oERI6WGhIjFnlxCHFQBTcCh3YCx01KpNCkXU8eRt9XFi088QL
 m1Dw==
X-Gm-Message-State: AOAM530QFXabC9NzqKjjPyCDtC+cNTkXmCOtnQK4srpBagAHGwmVcXv/
 3qlb7/HerInFX6ulIBb2oAY=
X-Google-Smtp-Source: ABdhPJynxv4HgFVq+YzG8NngdyxhCbkuUZlkdwXEwFycADMLdau1/kA3SvY2XMssurYI9UWUoDYGZg==
X-Received: by 2002:a50:fe82:: with SMTP id d2mr15842040edt.86.1601892262334; 
 Mon, 05 Oct 2020 03:04:22 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id u9sm7675435eje.119.2020.10.05.03.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:04:20 -0700 (PDT)
Date: Mon, 5 Oct 2020 12:04:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201005100419.GK425362@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-4-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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
Content-Type: multipart/mixed; boundary="===============3957473822127680334=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3957473822127680334==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEfPc/DjvCj+JzNg"
Content-Disposition: inline


--PEfPc/DjvCj+JzNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 11:08:07PM -0700, Nicolin Chen wrote:
> This patch simply adds support for PCI devices.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Changelog
> v3->v4
>  * Dropped !iommu_present() check
>  * Added CONFIG_PCI check in the exit path
> v2->v3
>  * Replaced ternary conditional operator with if-else in .device_group()
>  * Dropped change in tegra_smmu_remove()
> v1->v2
>  * Added error-out labels in tegra_smmu_probe()
>  * Dropped pci_request_acs() since IOMMU core would call it.
>=20
>  drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 02d02b0c55c4..b701a7b55e84 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(s=
truct device *dev)
>  	group->smmu =3D smmu;
>  	group->soc =3D soc;
> =20
> -	group->group =3D iommu_group_alloc();
> +	if (dev_is_pci(dev))
> +		group->group =3D pci_device_group(dev);
> +	else
> +		group->group =3D generic_device_group(dev);
> +
>  	if (IS_ERR(group->group)) {
>  		devm_kfree(smmu->dev, group);
>  		mutex_unlock(&smmu->lock);
> @@ -1069,22 +1074,32 @@ struct tegra_smmu *tegra_smmu_probe(struct device=
 *dev,
>  	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
> =20
>  	err =3D iommu_device_register(&smmu->iommu);
> -	if (err) {
> -		iommu_device_sysfs_remove(&smmu->iommu);
> -		return ERR_PTR(err);
> -	}
> +	if (err)
> +		goto err_sysfs;
> =20
>  	err =3D bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
> -	if (err < 0) {
> -		iommu_device_unregister(&smmu->iommu);
> -		iommu_device_sysfs_remove(&smmu->iommu);
> -		return ERR_PTR(err);
> -	}
> +	if (err < 0)
> +		goto err_unregister;
> +
> +#ifdef CONFIG_PCI
> +	err =3D bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
> +	if (err < 0)
> +		goto err_bus_set;
> +#endif
> =20
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_smmu_debugfs_init(smmu);
> =20
>  	return smmu;
> +
> +err_bus_set: __maybe_unused;
> +	bus_set_iommu(&platform_bus_type, NULL);
> +err_unregister:
> +	iommu_device_unregister(&smmu->iommu);
> +err_sysfs:
> +	iommu_device_sysfs_remove(&smmu->iommu);

Can you please switch to label names that are more consistent with the
others in this driver? Notably the ones in tegra_smmu_domain_alloc().
The idea is to describe in the name of the label what's happening at the
label. Something like this, for example:

unset_platform_bus:
	bus_set_iommu(&platform_bus_type, NULL);
unregister:
	iommu_device_unregister(&smmu->iommu);
remove_sysfs:
	iommu_device_sysfs_remove(&smmu->iommu);

Thierry

--PEfPc/DjvCj+JzNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9676MACgkQ3SOs138+
s6E57BAAt0AeCX/qjGZv2yu0JoZxyVMxx2y3P3p1t8cvhgWhppRMaXErd01bAZoA
vh4HYhmi1vVbnfyDxtafYXY7jUKwwe1Kwo4zjAnNqzm1xYRTeeEtZ0f03xhMviDk
G0y7pIXOZeMUozoR0cSruq8ZF7+tVmdmTL2A9ybZBwFXIuL7f1vhizd2Fk9aprvd
lSwhz43OVmYWWPRAjM+1HBJ1R+klw3SUy/ZBg6kaQX/sBeFnQ3InmapFZ7B+iKt4
ARXioQv0Kb935t1ABIYJZu26tunTZrMcdhekIOWyn345a7VuHtCOgaUYPSoDJsX4
1Y+kDStZD9/FZ/EpvCt8saacx1gnJ+yChbiAM/gheIeK5D/42rp4GNElfxOC9Edy
6qZGXMGCAcrvfCZjozsfNTAg7yG91BshhODi0vtR/ljoKtCdc6A6gGgPb7d6454j
9KQSrgy0XdV1hI+UOhCVcCWAuY7niE57OHaLSLE58b84Y3q52kGEq8gq7eSVS2ug
86V8ywHa/NQvE9bVMpwpqIKw5EX5cp3YEHHSmDQufaUlVHHw1kqcVGsDk7YjY7wM
zJ15fJegbRpPTRKfNehb64hKemeSWjOSi+Ipgkxk8k5WirUp0PiGEUsNEozTBizL
QMxkTR/VGoott/nWoAAEV+t50W8p/zgdc/ZXbwIq755B9qskBds=
=E6uA
-----END PGP SIGNATURE-----

--PEfPc/DjvCj+JzNg--

--===============3957473822127680334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3957473822127680334==--
