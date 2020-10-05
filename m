Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B87C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:53:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C18F207F7
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCC2gEff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C18F207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B56CB86FCC;
	Mon,  5 Oct 2020 09:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqfdTpiPGIJe; Mon,  5 Oct 2020 09:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E62486FA1;
	Mon,  5 Oct 2020 09:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A7E5C07FF;
	Mon,  5 Oct 2020 09:53:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E3EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0020220430
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdLI6hYetRnk for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 09:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 763FB20021
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:53:55 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id md26so10973859ejb.10
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tSNvIJ6n/8PydPpekJ3sBZyLSmyQXmedjUmwZXMurMo=;
 b=WCC2gEffyxEhzVrQNJMtnmNTSoUUlpfjFkvf9eRqLzEJ9LA0ehw10XSgqvJx76A3ip
 kUazxGYkWWM0N7bRnnWYWQlXKslfVFRf4wvmPEK2JSFJIEfYoHnv9wlqtT/5h8h1KDEj
 qkxF1atxUk2xVIUzKvp0v+ORc4LYFEihJ+chWpuQtb3nFFQYZ8Lv1REbPLvp8jPlSM/o
 JjTJyceLbPgYy3s3ae88L6ngca5cL88GCs6eBAVJ8+DatuXO6dQYoZkO8ksmKthOuA8k
 d+wBWlESELfkIhwLFeIJYwRskd3V37LRuVyNmc5+OwBWpFN3r+vcYjH2eiMyniU4/PuM
 hLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tSNvIJ6n/8PydPpekJ3sBZyLSmyQXmedjUmwZXMurMo=;
 b=KQiH3AL4YK8/YN544zaO/saIxu5K/Ec46FE8qw0WcTkEt1mv/tLUWi8Iv8+XqHF4yM
 6UGAYtUFsk3nkW3YFK6tM8GzlNGwr6ICkuboZ5S+XJK+Rgv2uFOcKWCybLmGmOW5T8vS
 1iTrdVfnozmSw+aWyhN2E5t9I3eYHbOCZ98GxIvaZNJ2PWLR+bGH6v1nR9vmdT1vAgxk
 n4aacl3i7HWWjtPjj4gb7fF7cOr7uZ7HAdTFMsiD3Rp1hyaLxEzvqfvJ/A4GZAC5gN0T
 bMd67KBLQHK2CXGMl5I9mrc7c1bvZApKkAUikfVWoHrdmdDlzm3nA/8GaWIQes2MeADW
 w+ew==
X-Gm-Message-State: AOAM532T26nFMNXCV9bMschjQeQ13V4ataK5YrJnZmz95cHsRf/84w5u
 xshFHAfSv33FaFXrA1N0RTM=
X-Google-Smtp-Source: ABdhPJxgzAOZ4Qeah+nCeFuiSWn88H4ILEdKN/5a6C7QNL1MKO0q6rEqKvyjihuNnGDqmUMjqS+F8g==
X-Received: by 2002:a17:907:7215:: with SMTP id
 dr21mr14431042ejc.239.1601891633938; 
 Mon, 05 Oct 2020 02:53:53 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id x2sm8286307edr.65.2020.10.05.02.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:53:52 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:53:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201005095351.GI425362@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
 <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
MIME-Version: 1.0
In-Reply-To: <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5395928575945298107=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5395928575945298107==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 05:50:08PM +0300, Dmitry Osipenko wrote:
> 02.10.2020 17:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>  static int tegra_smmu_of_xlate(struct device *dev,
> >>  			       struct of_phandle_args *args)
> >>  {
> >> +	struct platform_device *iommu_pdev =3D of_find_device_by_node(args->=
np);
> >> +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> >>  	u32 id =3D args->args[0];
> >> =20
> >> +	of_node_put(args->np);
> >> +
> >> +	if (!mc || !mc->smmu)
> >> +		return -EPROBE_DEFER;
> > platform_get_drvdata(NULL) will crash.
> >=20
>=20
> Actually, platform_get_drvdata(NULL) can't happen. I overlooked this.

How so? It's technically possible for the iommus property to reference a
device tree node for which no platform device will ever be created, in
which case of_find_device_by_node() will return NULL. That's very
unlikely and perhaps worth just crashing on to make sure it gets fixed
immediately.

Thierry

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl967S8ACgkQ3SOs138+
s6G50A/8CC2aziQWFWKu9/zGjy1UbL+zP8uXbPn3wZVQnWQ8kjRE5ip/HSI1QS+i
sgafB0As25F0ajenDbidZFp0nJiZvFRlD3VQT6bj+5XwoxI7vA0Uzu5UiXLmxCXU
CYA2NJZ/g6uCJ3ptk52YbG2gt1J49/GhgFuCPCaBxV2c8gIwo0eVs4daocjvK1mQ
XqL7Nci3UcsY1oDgNnzzQAyUQ4ZEpEHdFzLUd9CSNZBxGDXA26d3J+RgJGXlnXbv
eus6PtalK5okgodgvY60KLzyci/3Ph3k1aHJFNou0lmNxyJYW0PXTOVk5fn/wxY4
E8rcGiUyNSmYxcZ9KVYr/EXhYW+ECM9drCGL1pM6InKeDtxa67vhOeW4RdbiGdzt
/RjoUqPTUB4JYihBxpvkhUtYVZe4vtM+E3clPdKAqVig6pfZk5nacAPXj7KeJmNz
2QNydAPLaBNiOclO7x1hneV9xHf0UBmp/Gp1P1OmaRe/eJ9bk8uymQVyG4QiX4MS
dGPNMhW0lYgwy+a0K9omgh5RIInTaJpjIC5A9Z5N1um3sByGsk5HavPQHlZSqNjN
CytLUR5MaSs0Zsfn/1OxszZtr1J/Kor3CC8Qxlv0pxQN1xSidAT7sWwL5ObEgHKt
FoXOhaIeBvMp1DxmN6BHUDxA/p+Luf1GxGgZjsWIp4WUzw6XNNc=
=0Ryz
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--

--===============5395928575945298107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5395928575945298107==--
