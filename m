Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A103C47423
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:42:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3EC207DE
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezLB0wHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3EC207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F50E869C7;
	Thu,  1 Oct 2020 10:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nRev-QEyPYJ; Thu,  1 Oct 2020 10:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E51C9869CF;
	Thu,  1 Oct 2020 10:42:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC6DC0889;
	Thu,  1 Oct 2020 10:42:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAE1EC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CA1F6869CF
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRAFKCjAcGPs for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 10:42:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B30D4869C7
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:42:49 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id md26so1653356ejb.10
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9FRk996kXmbCzurLgfmc69GteLgu6w7P0PxV4KREbKU=;
 b=ezLB0wHeQycBgR4B82GsRYhJdyRuIrQO/bEY3AK0zylTRyV9jk2lLGCNi0FcqQUX0m
 lwJPqOXwFyCNTQ4N/riLCvrDypHNnX3ilv8IdIUIRKWLsoCUdu0qoERi6ysmWkBMcyeX
 SuZlS/ML3/Pa72QDt8aBVVtAcxHjnwg46fEG+86CrFJnqGmj3ERUiclv9x9VDAMQBoJ0
 143cpVYXeOyUJ2nhX/ehvjnV/DtF74zqg+lWyDMAtlajyFg+MfDe7zWKEUwbKO+aeX2t
 KA89WAedtn6M6JqElCbDhz96UV2/2/YAmu+rVRH5//Nnp8w7ZYjO+o0QQIAj3PdSTYx1
 resQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9FRk996kXmbCzurLgfmc69GteLgu6w7P0PxV4KREbKU=;
 b=psIsRdtLxMPCSetlTKtTGQUQWBiD4ddegkja8ZezZ7fFxZmhwOU59t9czc60bLAn2E
 Xgbdy1RLuHv57WHqT7o1SgPGvPB6PfFkfynSjLA4syl5HSJ+Bxv5NMsEGc3VOqLNGMUY
 OyWylMIlDT3Nb9+xm8VByZjZSoqdhCuVz8g3IfSeZfBU+JFB6i9yx6QxJ9XVl+GjTHgV
 /zu3Zkvg0+PlewpP/XWuvFcaWmUfi9UoVP8IWS9xB26ufuvGKXejgMgl0H5+V5Um1rBA
 avmqMi1LS11HYPWJV3IAGiCDO6egLeEQwsd2BTL6BjIRm4Vesq257gDKHDL7rdODHPAW
 rXMg==
X-Gm-Message-State: AOAM5319WMwVNnmrF07zVIdIWHaRSQJkmIZJqWdIEPWdtxU3h4ury53G
 2VZZEfZIYj4LTooI2b/cTOc=
X-Google-Smtp-Source: ABdhPJztC9jjH9+YEmm5LclGKIWab3URIaKWAnjYnPTVujhZMKa5c1lry+BELJRJ6vyR4iX/Kt2SKg==
X-Received: by 2002:a17:906:5490:: with SMTP id
 r16mr7088359ejo.222.1601548968063; 
 Thu, 01 Oct 2020 03:42:48 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id p10sm3879845ejy.68.2020.10.01.03.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 03:42:46 -0700 (PDT)
Date: Thu, 1 Oct 2020 12:42:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001104245.GA3939583@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <20201001095152.GD3919720@ulmo> <20201001103318.GA1272@Asurada>
MIME-Version: 1.0
In-Reply-To: <20201001103318.GA1272@Asurada>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6926208301361562021=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6926208301361562021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 03:33:19AM -0700, Nicolin Chen wrote:
> On Thu, Oct 01, 2020 at 11:51:52AM +0200, Thierry Reding wrote:
> > > > >> ...
> > > > >>>> It looks to me like the only reason why you need this new glob=
al API is
> > > > >>>> because PCI devices may not have a device tree node with a pha=
ndle to
> > > > >>>> the IOMMU. However, SMMU support for PCI will only be enabled =
if the
> > > > >>>> root complex has an iommus property, right? In that case, can'=
t we
> > > > >>>> simply do something like this:
> > > > >>>>
> > > > >>>> 	if (dev_is_pci(dev))
> > > > >>>> 		np =3D find_host_bridge(dev)->of_node;
> > > > >>>> 	else
> > > > >>>> 		np =3D dev->of_node;
> > > > >>>>
> > > > >>>> ? I'm not sure exactly what find_host_bridge() is called, but =
I'm pretty
> > > > >>>> sure that exists.
>=20
> > > @@ -814,12 +815,15 @@ static struct tegra_smmu *tegra_smmu_find(struc=
t device_node *np)
> > >  }
> > > =20
> > >  static int tegra_smmu_configure(struct tegra_smmu *smmu, struct devi=
ce *dev,
> > > -				struct of_phandle_args *args)
> > > +				struct of_phandle_args *args, struct fwnode_handle *fwnode)
> > >  {
> > >  	const struct iommu_ops *ops =3D smmu->iommu.ops;
> > >  	int err;
> > > =20
> > > -	err =3D iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> > > +	if (!fwnode)
> > > +		return -ENOENT;
> > > +
> > > +	err =3D iommu_fwspec_init(dev, fwnode, ops);
> > >  	if (err < 0) {
> > >  		dev_err(dev, "failed to initialize fwspec: %d\n", err);
> > >  		return err;
> > > @@ -835,6 +839,19 @@ static int tegra_smmu_configure(struct tegra_smm=
u *smmu, struct device *dev,
> > >  	return 0;
> > >  }
> > > =20
> > > +static struct device_node *tegra_smmu_find_pci_np(struct pci_dev *pc=
i_dev)
> > > +{
> > > +	struct pci_bus *bus =3D pci_dev->bus;
> > > +	struct device *dev =3D &bus->dev;
> > > +
> > > +	while (!of_property_read_bool(dev->of_node, "iommus") && bus->paren=
t) {
> > > +		dev =3D &bus->parent->dev;
> > > +		bus =3D bus->parent;
> > > +	}
> > > +
> > > +	return dev->of_node;
> > > +}
> >=20
> > This seems like it's the equivalent of pci_get_host_bridge_device(). Can
> > you use that instead? I think you might use the parent of the host
> > bridge that's returned from that function, though.
>=20
> I noticed that one when looking up one of the of_ functions, yet
> also found that this pci_get_host_bridge_device() is privated by
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/pci/pci.h?id=3D975e1ac173058b8710e5979e97fc1397233301f3
>=20
> Would PCI folks be that willing to (allow to) revert it?

Yeah, sounds like that would be useful. If you do, perhaps also take the
opportunity to replace open-coded variants, such as the one in arm-smmu.

Either that, or open-code this in tegra-smmu, like arm-smmu does.

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl91sqIACgkQ3SOs138+
s6FgMxAAkIAlSJhQY18t0HvstNKYU9tcVJ3N3mpV2YgENuKOh2v4DOxfKpIIbHLL
WvIce8RTWXwiSuC76X2fIaYOVU4PrgN1vfeXuL41bB0bVancNgSbRbnERWUIamgx
N60bL5sA4HDU8nJ4nqpqWzrGwqVmFArMyF75AypIfc83rMDyjXJ2tEQJjS2tO9nb
tZk5Prg0Yjy/2AOYjoZJjp1rpWkcW4lNTPnTopzWM9GJCbDs/Vr39Lii3zo0iOMS
Mvwb7GPpr7yAwTtslusaXbpd2Zi+GLvwvirP7dx8u7fPu9CMMsznLgzkGhK/Qh9G
xNNCv36GREUS0jMJ3ft5D/1+rnYg+xrCbHywkJGoELIRqZdlb6SHGGD2sF+/uR5y
6R3WSnHA9PPWoFBhpoGGChC7CjyN/RynCDnbnFlCPJ2RaC75K6uAWHQO4GhBWRK5
ldtE+H6p9vRLEvnz6tYwNjKj0dnRYRGoPnmn7WPm/j1dvWzLYpoK+DDjZtQnXLWH
+mUbOIP0z1Ih8WWaM/MIaMOpFWJZqxUz/A3J0ztuJU+7ltZUVHnNGWkHsF4ozZGA
k0UHLN7PJMyjAaUnrMW7KRUjExQimv3jOoMWW4PhJdcnI3rj5yl+HhJVVJUXfSbl
8KsU91Fevsot/r2oxL8zOXUy1FsuTaN2EWEWIi/Zk+Cafblog98=
=znw9
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============6926208301361562021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6926208301361562021==--
