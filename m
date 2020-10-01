Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88616C4727F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 09:47:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D312087D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6AMI//Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D312087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCB9820420;
	Thu,  1 Oct 2020 09:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNqN-m3nck4A; Thu,  1 Oct 2020 09:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DE78C203AF;
	Thu,  1 Oct 2020 09:47:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C20FBC016F;
	Thu,  1 Oct 2020 09:47:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE2EDC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD0E386427
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eS2GQRVPSPgM for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 09:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A1D798621E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:47:16 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id a3so6286015ejy.11
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gykynIitEaXJG3cyYb62xJ1HXKqglX6HJKQ54gJCbHY=;
 b=n6AMI//ZYzURVN587XgWTs+NS6JY5XOmfrv0Qj1SjOpBqdQGWrKix/L60+k+TwojEj
 azucQH17Q2MZ9DUuUpPZxTbRWRqFHU1lK8ogC/8RZex6ECl8uOkF7ctmmbQKgvyqPvzi
 sqDUS4bWm4zaqUIEBQgUan2AqkkjM973TUPC8c9SUFdfpHWF7hgKE8gIxp/ZJ691gOc1
 revaWmz1b85wqlLpNobae4C9i4FcNS05e4Jtg3uijeYUcoS7KEh0RryHABEPexJfTbn1
 ATjSfhx1B0w5Atzo2GvrmvRQhmWJNJNknIQMkvVolu+fX1+lWx0JePands0AMHraWVBn
 +sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gykynIitEaXJG3cyYb62xJ1HXKqglX6HJKQ54gJCbHY=;
 b=LkJ4rlFqLeIKSEgAh42QADpFFRrGxBdurI/bCfRIUx9mTL6tgqOGACLm4HSVU14fiZ
 1ZOjpBFgNNFr8Ly3HYdiD3Mf+N109lFSEMqITT5WF0hCjA9UpPNnGSGIZmN12L6p828u
 cGvybby53zmWVKA8umoCaztT932UqDi8al4btzgX2X4BSOwxPSF2UbgNZuKKP4Q63f1U
 1GLIH5JkTy8s0pkK5sD5OkdFQsPkHRtpq2NCxEEpWaR5to2plr2iDtQB0Gu/8qUxv32X
 rlBOXINb9y5JG8Q1op9uJ2ZKFOU9MQawVxIGymwvtLkG4HsmPYDSx+QI2k+/RsmPu6x6
 prTw==
X-Gm-Message-State: AOAM533XtrXt7DresCrntOnTDf6fLFMDWPoY+/0VuWCWGx8m/Q0epUo/
 0YIC1ghwl7DuTVYpDoHdvXspSMtbOo4=
X-Google-Smtp-Source: ABdhPJzq5dWO8E0Bl4iG9rjFRf6nA0DcXFr/TdGlTYr8TOMd6ljJjs+tnEcTXFVo+mxL7yIYgOZnNA==
X-Received: by 2002:a17:906:cf9d:: with SMTP id
 um29mr7060504ejb.74.1601545634924; 
 Thu, 01 Oct 2020 02:47:14 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id v17sm3712617ejj.55.2020.10.01.02.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 02:47:13 -0700 (PDT)
Date: Thu, 1 Oct 2020 11:47:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001094712.GC3919720@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20200930203618.GC2110@Asurada-Nvidia>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============5729246142224435413=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5729246142224435413==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 01:36:18PM -0700, Nicolin Chen wrote:
> On Wed, Sep 30, 2020 at 05:31:31PM +0200, Thierry Reding wrote:
> > On Wed, Sep 30, 2020 at 01:42:57AM -0700, Nicolin Chen wrote:
> > > Previously the driver relies on bus_set_iommu() in .probe() to call
> > > in .probe_device() function so each client can poll iommus property
> > > in DTB to configure fwspec via tegra_smmu_configure(). According to
> > > the comments in .probe(), this is a bit of a hack. And this doesn't
> > > work for a client that doesn't exist in DTB, PCI device for example.
> > >=20
> > > Actually when a device/client gets probed, the of_iommu_configure()
> > > will call in .probe_device() function again, with a prepared fwspec
> > > from of_iommu_configure() that reads the SWGROUP id in DTB as we do
> > > in tegra-smmu driver.
> > >=20
> > > Additionally, as a new helper devm_tegra_get_memory_controller() is
> > > introduced, there's no need to poll the iommus property in order to
> > > get mc->smmu pointers or SWGROUP id.
> > >=20
> > > This patch reworks .probe_device() and .attach_dev() by doing:
> > > 1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
> > > 2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
> > > 3) Calling devm_tegra_get_memory_controller() in .probe_device()
> > > 4) Also dropping the hack in .probe() that's no longer needed.
> > >=20
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> [...]
> > >  static struct iommu_device *tegra_smmu_probe_device(struct device *d=
ev)
> > >  {
> > > -	struct device_node *np =3D dev->of_node;
> > > -	struct tegra_smmu *smmu =3D NULL;
> > > -	struct of_phandle_args args;
> > > -	unsigned int index =3D 0;
> > > -	int err;
> > > -
> > > -	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", ind=
ex,
> > > -					  &args) =3D=3D 0) {
> > > -		smmu =3D tegra_smmu_find(args.np);
> > > -		if (smmu) {
> > > -			err =3D tegra_smmu_configure(smmu, dev, &args);
> > > -			of_node_put(args.np);
> > > -
> > > -			if (err < 0)
> > > -				return ERR_PTR(err);
> > > -
> > > -			/*
> > > -			 * Only a single IOMMU master interface is currently
> > > -			 * supported by the Linux kernel, so abort after the
> > > -			 * first match.
> > > -			 */
> > > -			dev_iommu_priv_set(dev, smmu);
> > > -
> > > -			break;
> > > -		}
> > > +	struct tegra_mc *mc =3D devm_tegra_get_memory_controller(dev);
> > > +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >=20
> > It looks to me like the only reason why you need this new global API is
> > because PCI devices may not have a device tree node with a phandle to
> > the IOMMU. However, SMMU support for PCI will only be enabled if the
> > root complex has an iommus property, right? In that case, can't we
> > simply do something like this:
> >=20
> > 	if (dev_is_pci(dev))
> > 		np =3D find_host_bridge(dev)->of_node;
> > 	else
> > 		np =3D dev->of_node;
> >=20
> > ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
> > sure that exists.
> >=20
> > Once we have that we can still iterate over the iommus property and do
> > not need to rely on this global variable.
>=20
> I agree that it'd work. But I was hoping to simplify the code
> here if it's possible. Looks like we have an argument on this
> so I will choose to go with your suggestion above for now.
>=20
> > > -		of_node_put(args.np);
> > > -		index++;
> > > -	}
> > > +	/* An invalid mc pointer means mc and smmu drivers are not ready */
> > > +	if (IS_ERR(mc))
> > > +		return ERR_PTR(-EPROBE_DEFER);
> > > =20
> > > -	if (!smmu)
> > > +	/*
> > > +	 * IOMMU core allows -ENODEV return to carry on. So bypass any call
> > > +	 * from bus_set_iommu() during tegra_smmu_probe(), as a device will
> > > +	 * call in again via of_iommu_configure when fwspec is prepared.
> > > +	 */
> > > +	if (!mc->smmu || !fwspec || fwspec->ops !=3D &tegra_smmu_ops)
> > >  		return ERR_PTR(-ENODEV);
> > > =20
> > > -	return &smmu->iommu;
> > > +	dev_iommu_priv_set(dev, mc->smmu);
> > > +
> > > +	return &mc->smmu->iommu;
> > >  }
> > > =20
> > >  static void tegra_smmu_release_device(struct device *dev)
> > > @@ -1089,16 +1027,6 @@ struct tegra_smmu *tegra_smmu_probe(struct dev=
ice *dev,
> > >  	if (!smmu)
> > >  		return ERR_PTR(-ENOMEM);
> > > =20
> > > -	/*
> > > -	 * This is a bit of a hack. Ideally we'd want to simply return this
> > > -	 * value. However the IOMMU registration process will attempt to add
> > > -	 * all devices to the IOMMU when bus_set_iommu() is called. In order
> > > -	 * not to rely on global variables to track the IOMMU instance, we
> > > -	 * set it here so that it can be looked up from the .probe_device()
> > > -	 * callback via the IOMMU device's .drvdata field.
> > > -	 */
> > > -	mc->smmu =3D smmu;
> >=20
> > I don't think this is going to work. I distinctly remember putting this
> > here because we needed access to this before ->probe_device() had been
> > called for any of the devices.
>=20
> Do you remember which exact part of code needs to access mc->smmu
> before ->probe_device() is called?
>=20
> What I understood is that IOMMU core didn't allow ERR_PTR(-ENODEV)
> return value from ->probe_device(), previously ->add_device(), to
> carry on when you added this code/driver:
>     commit 8918465163171322c77a19d5258a95f56d89d2e4
>     Author: Thierry Reding <treding@nvidia.com>
>     Date:   Wed Apr 16 09:24:44 2014 +0200
>         memory: Add NVIDIA Tegra memory controller support
>=20
> ..until the core had a change one year later:
>     commit 38667f18900afe172a4fe44279b132b4140f920f
>     Author: Joerg Roedel <jroedel@suse.de>
>     Date:   Mon Jun 29 10:16:08 2015 +0200
>         iommu: Ignore -ENODEV errors from add_device call-back
>=20
> As my commit message of this change states, ->probe_device() will
> be called in from both bus_set_iommu() and really_probe() of each
> device through of_iommu_configure() -- the later one initializes
> an fwspec by polling the iommus property in the IOMMU core, same
> as what we do here in tegra-smmu. If this works, we can probably
> drop the hack here and get rid of tegra_smmu_configure().

I think this may have been important primarily for DMA/IOMMU integration
and may not currently exhibit because we don't enable that yet.

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl91pZ0ACgkQ3SOs138+
s6GNTQ/+NkhK7Yibt6Oym5E+J5NgLQUZlYmYY6j9jGoU93ZPrhqSVdslCbVabWlN
sxxf199yP1PlBA6Juqa1QXJVjqpWuJSRWfHypduaRJhyuBLYuv6qy6xUSuBvece8
FEvyOiIaeha3h5goVNnhyAL9I3LPwm+mBcDVNjGHNA/WlNQjaOTlVs5Envvz4E0T
WrA0usr+HYF6KiXcaA34qMQuHKLCuQf+fbM1lkjbRtUSD5Bocwaz4qdl62mDqOcK
qGcEX13IsYTqCgmmsdRpObmp0A+z264OMk4goz2k+rJif/w4V2vxBJ+c5+TUfadQ
UnA8fQ3IeUQlGfNCsg1pja6qNzigPqbjWPKhacDrDUnOVx0dO3PUyJ0rdo0iBUdR
UtS6YkeYKiOtwhCfz5qpoiOgJfQM1+88CvlmVDSe+SFcPg+0ZPNGmrM1FdXjrxly
1lc23QJ2L7/6IzhiTf3ags6S0XdY9ayz3OsBffWlGHFRtdx2S8O8eftUcvgqmSlg
3XVwTg6xBDhq8jPAyly732Wftt+tHw6BYLZgZEgy/H1XoOfmQbfLpINSSV+MblYi
rs4ZNHA1russ7OFd6IBZOBpwIaiZVivB8uvULnj7P2NuQR49UMpvQu5ngcftSn9a
Pj9sO+11LCLf9I0x6Vsun1CY+7OWWCwyjyswk7llXBxIjMpjEeA=
=SuLd
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

--===============5729246142224435413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5729246142224435413==--
