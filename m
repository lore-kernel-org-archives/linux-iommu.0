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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF11C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 07:14:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAEF2080C
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 07:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVueCi8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAEF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B9A0B84030;
	Mon, 28 Sep 2020 07:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5j9sNM4VkUI; Mon, 28 Sep 2020 07:14:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1CF6380D34;
	Mon, 28 Sep 2020 07:14:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E75E7C016F;
	Mon, 28 Sep 2020 07:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC4BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB2C320030
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwOvy+CLYB8e for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 07:14:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 47D8F20028
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 07:14:01 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id z4so11038127wrr.4
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dKVXsIoVUAuhSPTXKz6orVntDM81DbNac5gyHMzAPn0=;
 b=QVueCi8XQiMhkjOzIKmaTIysaN6WlOZE2WfLd9SNZ5wlmdtIVcuNGiYUTgd5NPAOo9
 hi0/5KDd4YUjJbJT8RWlpYw//5248xsoPdhCkIxJ/yCMVJnV4EZpXw045OWTrPehnP7D
 WYgFexBGVJN5OKD/8rFXsmQYtJIpanOjg0myKVLKFLmGWxe/L9Aa9pEE6C+ocaeut3sh
 V4+qB1XJuh/JcJy49H9yyECjtXLR+Ik0M6DGifAVousD2WiH7oQNK84LM8DYvwZMI9vG
 pfvYmgeCxdkt3UV6URosdCh3QNZ8m9hiwSIWfiGZ+7fTX4hD1q7mSZQdN+HcRD4b58Qi
 isyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dKVXsIoVUAuhSPTXKz6orVntDM81DbNac5gyHMzAPn0=;
 b=XBgeQTwddgiIEBND7dhnp90DBMA5RlJNc7rLL+Gv7N88BSzvshL4gGgJwQlGziJGmR
 6e86no5IOgtI3r354X5Ji4+Q7RJKjKASn8AjOoVz1k17q1Cl94Zq9ymio397ksnB3Nmi
 edU8wbwRB+QI6UbSgo9lFmBdSjhPaEUP95ELKfrqUBs8QUyB3Qix9eFPKya4ZRoUQnNP
 eqEpH700uOUVhdVE/I3zguKvywugm+8EsEVjMjXpJ1I5W/PJYo8kdwWiQhO1dyhGU7UI
 a4kdgoSJBcdWLjCCiJCc0RsN4SJD4OAN03tnr9cvygltfcVee9Lx5HzHvcb80iYrgMos
 kmSA==
X-Gm-Message-State: AOAM532JSB9ofIn6EMDhBylxs5iKTTqLfXwxMDMxddxNYPyTFtCdWtZT
 iYq5Lp+BfK69Uc4whJM9HQQ=
X-Google-Smtp-Source: ABdhPJy63S7ozLyrXRI/kPxuSL7jEKLDY06CuO93Ngie1sFy4hxUh9/wyXJfm5BoikfaZt0zwSFrag==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr31038wrh.192.1601277239454;
 Mon, 28 Sep 2020 00:13:59 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id n10sm27928wmk.7.2020.09.28.00.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 00:13:57 -0700 (PDT)
Date: Mon, 28 Sep 2020 09:13:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/5] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
Message-ID: <20200928071356.GD2837573@ulmo>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-2-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6618093926150305670=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6618093926150305670==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 01:07:15AM -0700, Nicolin Chen wrote:
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
>  drivers/iommu/tegra-smmu.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 0becdbfea306..6335285dc373 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -903,11 +903,13 @@ static void tegra_smmu_group_release(void *iommu_da=
ta)
>  	mutex_unlock(&smmu->lock);
>  }
> =20
> -static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
> -						unsigned int swgroup)
> +static struct iommu_group *tegra_smmu_device_group(struct device *dev)
>  {
> +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);
>  	const struct tegra_smmu_group_soc *soc;
>  	struct tegra_smmu_group *group;
> +	int swgroup =3D fwspec->ids[0];

This should be unsigned int to match the type of swgroup elsewhere.
Also, it might not be worth having an extra local variable for this
since it's only used once.

Thierry

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9xjTEACgkQ3SOs138+
s6Hb3BAAmlSBf17eRIqR2c2OKS3u6J4Gm8+F2mKHd+5sC0MgnQVSzME9EJCuuiMb
oPvGwcxTnuabt/CvTD+s7O9dRsDP9vfmYADkWhpvfF5fY+QEbaRdmy7H8dECi7Wp
0UqfdEY99sE5Tj2z+mtywlTFrcHPzHuKPrOEYyjorIY2Fi569yRERhB8Bbs9Rkgc
QRrB2R3rel+1aL7gYauQvkEJOoBFAT2i6Ebg6qaVFl4yPtHmRwALHgyEmV6SRT7D
3CUIaW8g8pEulOoM1YzKyAThO1NKH2GTp/+3/+cjFl7qK654a0J5inAQrYp0fF7+
L/GcJbflazVj766H4nQYdE6PbwEBfNt8BDUDDeIAAasBgiJ+I9/97DnJodt0Q5Kq
Jkdg0OO+q050bjutL5+QYLpHQPaykZzIIGQhIqXw/VKum26Zj4ETzT6u4sqO0PVG
gHPiUmN3ioC3UEfvzHd/xJz1a+nBN6LgHXH4rQEsuu7ZfbWmVIiWY/aEB13jUj3l
i4IrXLTt05GnspNSeoVkeXpMaJfovn/ocESIXmxL3Yz4yf09rNzBxZlypFhCbq7q
GUk7WKpXG2i0gtvCMXIzPTGcC0ewhAfI/bzz2FsfYX20e7a2ao7Qg9DqvO4QmXR1
loq35HGpMRSodtzvSeuEQJMV1uwebJgHq1EnitQvP3X9JVKwLJs=
=UiGV
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--

--===============6618093926150305670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6618093926150305670==--
