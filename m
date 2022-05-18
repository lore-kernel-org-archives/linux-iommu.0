Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B083DC433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D7B541030;
	Wed, 18 May 2022 18:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpAfLheYOe8X; Wed, 18 May 2022 18:46:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44D9D40374;
	Wed, 18 May 2022 18:46:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 292F1C0032;
	Wed, 18 May 2022 18:46:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A94DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26F1D61253
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:46:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ekt5s3FKR5U7 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:46:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82C5460F6D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:46:07 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-e656032735so3952403fac.0
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pKIi5KmcpwiUvvttWh4e21qCKlHTXQLcc0WGZMCMfyo=;
 b=KC5johW0ZJ2ortk1/UvUtZEfK+HgcFOZVHswd/CqZtTNidTwfegTZ8LEv4fKDlJjsh
 VVknYv3E1/3yQly4TxFhb6dgWyZhZ0vEBEdqS5AsGgx5GpDDpuuM/dDlgWyYn3ZHvsq6
 +Ndl9GZ6P+ZjZdMWva0KUrRXhgbjl6C/3pWzQQebmIe0xcvXKhsqZ3H7Ouqm00kVe4Mv
 WMBM0krkJaubSVpp645HkzhfXNhe9kCPDi/BVs97NEfL5wqggBSObTEZAU1z+fXymP09
 ckLE2IkumWItts9nRx89HK01/gaxcAKn7R910V1yeNaG0azXOMXo48F7rmTpq2EG1dne
 pzqQ==
X-Gm-Message-State: AOAM5331+jkxKuJte/03Iv7jq3HKtP3dFxexH5PEmyuJunk3VAyxj4UO
 0ad/tnIsJ5s4C0ZNmJbsUQ==
X-Google-Smtp-Source: ABdhPJzCbZpysYPkJ/ZU+Q27by+oDlv1fIMc02MZVxt6o5neKQP74ZuGayT1T/hdza+xq9Rr6yMpGw==
X-Received: by 2002:a05:6871:69e:b0:f1:cbce:6ac4 with SMTP id
 l30-20020a056871069e00b000f1cbce6ac4mr889356oao.286.1652899566551; 
 Wed, 18 May 2022 11:46:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 e21-20020a9d63d5000000b00605da994088sm1030657otl.2.2022.05.18.11.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 11:46:05 -0700 (PDT)
Received: (nullmailer pid 3673824 invoked by uid 1000);
 Wed, 18 May 2022 18:46:04 -0000
Date: Wed, 18 May 2022 13:46:04 -0500
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to infracfg
Message-ID: <20220518184604.GK3302100-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-3-angelogioacchino.delregno@collabora.com>
 <16fb07d9-28d8-5c73-1eb5-ec13544d22e5@arm.com>
 <b003c37c-0f2d-31f6-6a74-4e1f0f4a1ccb@collabora.com>
 <a063199a-72dd-d2ab-10bb-7130697c5611@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a063199a-72dd-d2ab-10bb-7130697c5611@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, will@kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 18, 2022 at 12:07:58PM +0100, Robin Murphy wrote:
> On 2022-05-18 09:29, AngeloGioacchino Del Regno wrote:
> > Il 17/05/22 16:12, Robin Murphy ha scritto:
> > > On 2022-05-17 14:21, AngeloGioacchino Del Regno wrote:
> > > > This driver will get support for more SoCs and the list of infracfg
> > > > compatibles is expected to grow: in order to prevent getting this
> > > > situation out of control and see a long list of compatible strings,
> > > > add support to retrieve a handle to infracfg's regmap through a
> > > > new "mediatek,infracfg" phandle.
> > > > =

> > > > In order to keep retrocompatibility with older devicetrees, the old
> > > > way is kept in place, but also a dev_warn() was added to advertise
> > > > this change in hope that the user will see it and eventually update
> > > > the devicetree if this is possible.
> > > > =

> > > > Signed-off-by: AngeloGioacchino Del Regno
> > > > <angelogioacchino.delregno@collabora.com>
> > > > ---
> > > > =A0 drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++-------=
-------
> > > > =A0 1 file changed, 26 insertions(+), 14 deletions(-)
> > > > =

> > > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > > index 71b2ace74cd6..cfaaa98d2b50 100644
> > > > --- a/drivers/iommu/mtk_iommu.c
> > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > @@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct
> > > > platform_device *pdev)
> > > > =A0=A0=A0=A0=A0 data->protect_base =3D ALIGN(virt_to_phys(protect),
> > > > MTK_PROTECT_PA_ALIGN);
> > > > =A0=A0=A0=A0=A0 if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MOD=
E)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 switch (data->plat_data->m4u_plat) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 case M4U_MT2712:
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p =3D "mediatek,mt2712-infracfg";
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > -=A0=A0=A0=A0=A0=A0=A0 case M4U_MT8173:
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p =3D "mediatek,mt8173-infracfg";
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > -=A0=A0=A0=A0=A0=A0=A0 default:
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p =3D NULL;
> > > > +=A0=A0=A0=A0=A0=A0=A0 infracfg =3D
> > > > syscon_regmap_lookup_by_phandle(dev->of_node,
> > > > "mediatek,infracfg");
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(infracfg)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "Cannot find phand=
le to mediatek,infracfg:"
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 " =
Please update your devicetree.\n");
> > > =

> > > Is this really a dev_warn-level problem? There's no functional
> > > impact, given that we can't stop supporting the original binding any
> > > time soon, if ever, so I suspect this is more likely to just annoy
> > > users and CI systems than effect any significant change.
> > > =

> > =

> > The upstream devicetrees were updated to use the new handle and this is
> > a way to
> > warn about having outdated DTs... besides, I believe that CIs will
> > always get the
> > devicetree from the same tree that the kernel was compiled from (hence
> > no message
> > will be thrown).
> > =

> > In any case, if you think that a dev_info would be more appropriate, I
> > can change
> > that no problem.
> =

> If there's some functional impact from using the old binding vs. the new =
one
> then it's reasonable to inform the user of that (as we do in arm-smmu, for
> example).
> =

> However if you change an established binding for non-functional reasons,
> then you get to support both bindings, and it's not the end user's problem
> at all. There seems to be zero reason to update an existing DTB for this
> difference alone, so TBH I don't think it deserves a message at all.

It's also not the kernel's job to validate the DT. It's horrible at it =

and we have something else now.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
