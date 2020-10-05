Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68EC46466
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 14:22:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98912078A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 14:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBz8kZzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98912078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7579D204CC;
	Mon,  5 Oct 2020 14:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMqhcmPUo+tD; Mon,  5 Oct 2020 14:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 656652034C;
	Mon,  5 Oct 2020 14:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39A9BC016F;
	Mon,  5 Oct 2020 14:22:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB17DC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 14:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D721185722
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 14:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMjymGucHrK3 for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 14:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DE8FD85631
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 14:22:41 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id a3so12222549ejy.11
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=e/lZhaxCRr5BovF0A1Nmo/njVQx8pABrvOL8ijbfSPk=;
 b=MBz8kZzFan8wo1BK+ir1/+F+2M4mk77f4qpC5OzgVCnub564dYUiB0OFBm+IafOyBA
 2EL/OKsv1KEe7plP6id+uPtrxMZQKR3cCmZkRQysULFs5WTlWwmhRXd1eIFZIeyPcIs2
 pmP4ivSVfIpE8UqHnJ95BgapkT+0npSie7s1y26fbPATovMxC/By3MFOTGngAYOYoeeX
 9RnwDuHg31sibSbnGTcRbTY2MCecsbT2Cjw6OR5dyh63fskNA3xSHVBztDATv/UhZlo8
 o//2v1W0opCe1aAtlXn0bShrFiGeZGqbRMIfGxWzN+4zL9JCUd/SKqoaIVv4AQ9LKgXC
 oxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=e/lZhaxCRr5BovF0A1Nmo/njVQx8pABrvOL8ijbfSPk=;
 b=ol15SSSukMrpm7BpLWaurkSfO3YKmXbejtYru4CNWP2XNopQum163AlQxj2M/Q/NcR
 cn3r+Rg4dvVQvzMTuej/7ODvnzOvWkU1KiNJl5smQ4Y9gyj0Ls2znIrzG9BOManR7fT5
 beZQfj+Z10voaH2cEsJf5kWc6zeuIOdTGZ5UI482EzBzeGYeAxUaumOTL7AKUtCbca3y
 CN0XQcLlnUvKU+amyJhA0BBEBUfVyTbbZWAWGvaxouXDqm+wKmcJQ4a6calr2PE/lW0R
 fgmoxmUOLG5IcXLaFiyhtNG6DDd+wBI20yAIzajT470j6IWP0JeO43im1hrIOrvn+bOy
 4g4Q==
X-Gm-Message-State: AOAM5324DqcQqaoqayUMNuQpBG889ap8vhDv0XOXekLPkR2FNbiZWbXZ
 SvvUaI/27eBNhYIGEIbDwss=
X-Google-Smtp-Source: ABdhPJyq2WAXeuWpH0EsM0A11GYqoWFcHmHPoW6C+LT7kuXTUkDowJ9pc1oN4eOI24q0fsaT1wRkwQ==
X-Received: by 2002:a17:906:5fc6:: with SMTP id
 k6mr5709468ejv.494.1601907760363; 
 Mon, 05 Oct 2020 07:22:40 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id i7sm8566566ejo.22.2020.10.05.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 07:22:38 -0700 (PDT)
Date: Mon, 5 Oct 2020 16:22:37 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201005142237.GA628746@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
 <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
 <20201005095351.GI425362@ulmo>
 <ae48aaaf-fe10-6de4-06bb-2afbde799168@gmail.com>
 <20201005111547.GQ425362@ulmo>
 <39cb0056-1447-2232-d33c-adb17114740a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <39cb0056-1447-2232-d33c-adb17114740a@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3901969745417140946=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3901969745417140946==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 04:28:53PM +0300, Dmitry Osipenko wrote:
> 05.10.2020 14:15, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, Oct 05, 2020 at 01:36:55PM +0300, Dmitry Osipenko wrote:
> >> 05.10.2020 12:53, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Fri, Oct 02, 2020 at 05:50:08PM +0300, Dmitry Osipenko wrote:
> >>>> 02.10.2020 17:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>  static int tegra_smmu_of_xlate(struct device *dev,
> >>>>>>  			       struct of_phandle_args *args)
> >>>>>>  {
> >>>>>> +	struct platform_device *iommu_pdev =3D of_find_device_by_node(ar=
gs->np);
> >>>>>> +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> >>>>>>  	u32 id =3D args->args[0];
> >>>>>> =20
> >>>>>> +	of_node_put(args->np);
> >>>>>> +
> >>>>>> +	if (!mc || !mc->smmu)
> >>>>>> +		return -EPROBE_DEFER;
> >>>>> platform_get_drvdata(NULL) will crash.
> >>>>>
> >>>>
> >>>> Actually, platform_get_drvdata(NULL) can't happen. I overlooked this.
> >>>
> >>> How so? It's technically possible for the iommus property to referenc=
e a
> >>> device tree node for which no platform device will ever be created, in
> >>> which case of_find_device_by_node() will return NULL. That's very
> >>> unlikely and perhaps worth just crashing on to make sure it gets fixed
> >>> immediately.
> >>
> >> The tegra_smmu_ops are registered from the SMMU driver itself and MC
> >> driver sets platform data before SMMU is initialized, hence device is
> >> guaranteed to exist and mc can't be NULL.
> >=20
> > Yes, but that assumes that args->np points to the memory controller's
> > device tree node. It's obviously a mistake to do this, but I don't think
> > anyone will prevent you from doing this:
> >=20
> > 	iommus =3D <&{/chosen} 0>;
> >=20
> > In that case, since no platform device is created for the /chosen node,
> > iommu_pdev will end up being NULL and platform_get_drvdata() will crash.
>=20
> But then Tegra SMMU isn't associated with the device's IOMMU path, and
> thus, tegra_smmu_of_xlate() won't be invoked for this device.

Indeed, you're right! It used to be that ops were assigned to the bus
without any knowledge about the specific instances that might exist, but
nowadays there's struct iommu_device which properly encapsulates all of
that, so yeah, I don't think this can ever be NULL.

Although that makes me wonder why we aren't going one step further and
pass struct iommu_device * into ->of_xlate(), which would avoid the need
for us to do the look up once more.

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl97LCkACgkQ3SOs138+
s6GUWxAAwst4IWu/G106iJ18+V0k/VEU3oYZtPoGitMHGJworwYhaqmAocTs2CJ5
6QftbaeJtFwiYhpWjhm+u79QgtKtYHMQH162UjeGDiXVM9fjIMf0+1oBnmd8LKkw
MxzaiYSvm5QzFQe4Ib/KzpNutCzgLncuf2VDPpG2XvUtAPDaj25hRQH89orrbbVG
RzfcHQ0p4fsz4t2IQgJf7aeMzU+NrvvFBRD/FEI8LfqMfuGehLecbjEi1LKnrjbR
coz/2Kn+fjkjdC8H24XLvSK3U5ifRd0Ck3xdo6OAe8WE+wXdXlPqY40JzNLjfoDw
PBnp4YGw2Qy1fQ/oFwEyyW5MeBUMe7IcoAAGES7p8Z/KuMNvEDa86n6qoEZn8/fx
P7J5jyT3L1fJAnASD5P+L3I5TwTENOrdG0XxZMUVCH64GgkrdtN0lL/QIlEx3mJe
Xr2VAauFsQgqFw1f8PrFQFiXX/0RU+vFE7ucF81okFKpvuqZdouwc8ye+AKf//pF
+iNxHmcRePB4GSe6hqO84EpgTcvpQo6RfA1ECG5J84cXOE4TIcefy7WT1K3vatWv
l+U/4Z+B8HCP5P2Bo0BsOO27/nOdkv7pMKe2XvrsAuwWSGZsxJRSYlA+Rr1vE/fy
nFrCH8cy94ewqryTQqz7MplvRG7CnQtivYdgSPG5BxYbHxJHmR4=
=IQAU
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--===============3901969745417140946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3901969745417140946==--
