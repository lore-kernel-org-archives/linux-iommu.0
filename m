Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A9C43462
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 12:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E550761090
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 12:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E550761090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71C36402C1;
	Mon, 26 Apr 2021 12:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTmEpQLGmjSJ; Mon, 26 Apr 2021 12:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA29C40290;
	Mon, 26 Apr 2021 12:12:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A967C000F;
	Mon, 26 Apr 2021 12:12:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3A05C000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A46A3608C5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNmtRQnLgzrD for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:12:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89585608C2
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:12:21 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id n127so18034550wmb.5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MrlReh/WX6qo4U8D9LK/tX/mH8/Z9L4VeYpldmEJXH4=;
 b=VP3AL3REFR85ZV7/yViRrvU2cU45MXn5J46DyOZOH+crwLhUggM3B6eGJ0P5LTUkK6
 kPWSaDMRdfxOrRxw2PEjsHgqtUYgkAzOXg4619jmqpHnUdeGI4YYQ345+tsbRT2Ctcm6
 zpkyXcIiPbDo1T+UgE6UUPtCaFKBymPnUaCHWcJy8ju4YAo1C9tDL396XFUs4KNF1m6O
 S/RH+2XQNDw3O9Ukqs+LeMsLgqGgzPVqOVhFenSjPVPXBqGab2oyvXLvW+W9Meb5sn/w
 MRhvYPWdB70Ivz4a6Xlw6S8aypkINA4KX/roxEUU+Wl6GuvW5906L3Bw8G8btqmI8xP3
 BzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MrlReh/WX6qo4U8D9LK/tX/mH8/Z9L4VeYpldmEJXH4=;
 b=jdxFhw7Z8ixaoet4+b1PQ6o5uKjF79zfLNP6pGXM+9u6DrPLDLrnTLapyCqNdv3JIX
 4VIpiAzG/oSwejiZelA9RLcWJL5hTfR5qrejQVNeMf5PDHRNjX8irIXElN3wcOxXOt1V
 zcTMXk5pgbMMvyhND4yTfEAINmcML+SGmmicef8T1x79zMXwddYHxunq2ic8GXufiRv5
 2P5kecxkEGL8j9zMnwJXQntHuWntZJXGqELm5LkzIIi7npSUInQmqcTo/uPKJxMITAwf
 OCnpwpCaeavswLCjovD0pdK3nWBK4baFdN7RzupiRMFfYdzGOEv4LtQ7r3P7c1kWe9ft
 Iy9A==
X-Gm-Message-State: AOAM533ohz6sTKTtynI1vD9QLOii2w4P3KFD/3TDJVw0/o87EpXH3YWj
 0/vzjxKAqFqKBRMhVn54aBY=
X-Google-Smtp-Source: ABdhPJxQU4xd93S56GKttGf74GIFQ1RCOkZXNCIBi4JNdCPipk903zx0hdDifDNRYeOnwTOv256Fzg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr20360558wmi.160.1619439139750; 
 Mon, 26 Apr 2021 05:12:19 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id p13sm23662377wrt.0.2021.04.26.05.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 05:12:18 -0700 (PDT)
Date: Mon, 26 Apr 2021 14:13:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 01/10] memory: tegra: Implement SID override programming
Message-ID: <YIauV/BgPCZSZ8u2@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <20210420172619.3782831-2-thierry.reding@gmail.com>
 <03e2a655-7dbf-a729-75f6-98db353e2b91@canonical.com>
MIME-Version: 1.0
In-Reply-To: <03e2a655-7dbf-a729-75f6-98db353e2b91@canonical.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============3703758589916755284=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3703758589916755284==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="exGO0SlXbaQVEgpj"
Content-Disposition: inline


--exGO0SlXbaQVEgpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 26, 2021 at 10:28:43AM +0200, Krzysztof Kozlowski wrote:
> On 20/04/2021 19:26, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Instead of programming all SID overrides during early boot, perform the
> > operation on-demand after the SMMU translations have been set up for a
> > device. This reuses data from device tree to match memory clients for a
> > device and programs the SID specified in device tree, which corresponds
> > to the SID used for the SMMU context banks for the device.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/memory/tegra/mc.c       |  9 +++++
> >  drivers/memory/tegra/tegra186.c | 72 +++++++++++++++++++++++++++++++++
> >  include/soc/tegra/mc.h          |  3 ++
> >  3 files changed, 84 insertions(+)
> >=20
> > diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > index c854639cf30c..bace5ecfe770 100644
> > --- a/drivers/memory/tegra/mc.c
> > +++ b/drivers/memory/tegra/mc.c
> > @@ -97,6 +97,15 @@ struct tegra_mc *devm_tegra_memory_controller_get(st=
ruct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(devm_tegra_memory_controller_get);
> > =20
> > +int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev)
> > +{
> > +	if (mc->soc->ops && mc->soc->ops->probe_device)
> > +		return mc->soc->ops->probe_device(mc, dev);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tegra_mc_probe_device);
> > +
> >  static int tegra_mc_block_dma_common(struct tegra_mc *mc,
> >  				     const struct tegra_mc_reset *rst)
> >  {
> > diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/teg=
ra186.c
> > index 1f87915ccd62..e65eac5764d4 100644
> > --- a/drivers/memory/tegra/tegra186.c
> > +++ b/drivers/memory/tegra/tegra186.c
> > @@ -4,6 +4,7 @@
> >   */
> > =20
> >  #include <linux/io.h>
> > +#include <linux/iommu.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/of_device.h>
> > @@ -15,6 +16,10 @@
> >  #include <dt-bindings/memory/tegra186-mc.h>
> >  #endif
> > =20
> > +#define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
> > +#define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
> > +#define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
> > +
> >  static void tegra186_mc_program_sid(struct tegra_mc *mc)
> >  {
> >  	unsigned int i;
> > @@ -66,10 +71,77 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
> >  	return 0;
> >  }
> > =20
> > +static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
> > +					    const struct tegra_mc_client *client,
> > +					    unsigned int sid)
> > +{
> > +	u32 value, old;
> > +
> > +	value =3D readl(mc->regs + client->regs.sid.security);
> > +	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) =3D=3D 0) {
> > +		/*
> > +		 * If the secure firmware has locked this down the override
> > +		 * for this memory client, there's nothing we can do here.
> > +		 */
> > +		if (value & MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED)
> > +			return;
> > +
> > +		/*
> > +		 * Otherwise, try to set the override itself. Typically the
> > +		 * secure firmware will never have set this configuration.
> > +		 * Instead, it will either have disabled write access to
> > +		 * this field, or it will already have set an explicit
> > +		 * override itself.
> > +		 */
> > +		WARN_ON((value & MC_SID_STREAMID_SECURITY_OVERRIDE) =3D=3D 0);
> > +
> > +		value |=3D MC_SID_STREAMID_SECURITY_OVERRIDE;
> > +		writel(value, mc->regs + client->regs.sid.security);
> > +	}
> > +
> > +	value =3D readl(mc->regs + client->regs.sid.override);
> > +	old =3D value & MC_SID_STREAMID_OVERRIDE_MASK;
> > +
> > +	if (old !=3D sid) {
> > +		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
> > +			client->name, sid);
> > +		writel(sid, mc->regs + client->regs.sid.override);
> > +	}
> > +}
> > +
> > +static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device=
 *dev)
> > +{
> > +#if IS_ENABLED(CONFIG_IOMMU_API)
>=20
> Is this part really build-time dependent? I don't see here any uses of
> IOMMU specific fields, so maybe this should be runtime choice based on
> enabled interconnect devices?

Unfortunately it is. struct iommu_fwspec is an empty structure for
!CONFIG_IOMMU_API, so the code below that tries to access fwspec->ids
fails for !CONFIG_IOMMU_API configurations if we don't protect this with
the preprocessor guard.

>=20
> > +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +	struct of_phandle_args args;
> > +	unsigned int i, index =3D 0;
> > +
> > +	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#i=
nterconnect-cells",
> > +					   index, &args)) {
> > +		if (args.np =3D=3D mc->dev->of_node && args.args_count !=3D 0) {
> > +			for (i =3D 0; i < mc->soc->num_clients; i++) {
> > +				const struct tegra_mc_client *client =3D &mc->soc->clients[i];
> > +
> > +				if (client->id =3D=3D args.args[0]) {
> > +					u32 sid =3D fwspec->ids[0] & MC_SID_STREAMID_OVERRIDE_MASK;
> > +
> > +					tegra186_mc_client_sid_override(mc, client, sid);
> > +				}
> > +			}
> > +		}
> > +
> > +		index++;
> > +	}
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> >  const struct tegra_mc_ops tegra186_mc_ops =3D {
> >  	.probe =3D tegra186_mc_probe,
> >  	.remove =3D tegra186_mc_remove,
> >  	.resume =3D tegra186_mc_resume,
> > +	.probe_device =3D tegra186_mc_probe_device,
> >  };
> > =20
> >  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
> > diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> > index 1387747d574b..bbad6330008b 100644
> > --- a/include/soc/tegra/mc.h
> > +++ b/include/soc/tegra/mc.h
> > @@ -176,6 +176,7 @@ struct tegra_mc_ops {
> >  	int (*suspend)(struct tegra_mc *mc);
> >  	int (*resume)(struct tegra_mc *mc);
> >  	irqreturn_t (*handle_irq)(int irq, void *data);
> > +	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
> >  };
> > =20
> >  struct tegra_mc_soc {
> > @@ -240,4 +241,6 @@ devm_tegra_memory_controller_get(struct device *dev)
> >  }
> >  #endif
> > =20
> > +int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
> > +
>=20
> What about !CONFIG_TEGRA_MC? I think arm-smmmu will fail.

I think it doesn't fail because for !CONFIG_TEGRA_MC it basically throws
away most of nvidia_smmu_impl_init() already because ERR_PTR(-ENODEV) is
returned by devm_tegra_memory_controller_get() and so it unconditionally
fails early on already.

I say I /think/ that happens because I can't reproduce a build failure
even if I manually tweak the .config such that ARM_SMMU is enabled and
TEGRA_MC is disabled. But I can't say I fully understand why it's
working, because, yes, the symbol definitely doesn't exist. But again,
if the compiler is clever enough to figure out that that function can't
be called anyway and doesn't even want it, why bother making it more
complicated than it has to be?

Thierry

--exGO0SlXbaQVEgpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCGrlQACgkQ3SOs138+
s6FCiRAAkMIChAR9+a9l4Pdle+ApbEqJHDF/TKKKX3T4ZNnsnTBILT3sJjkSSfg+
F2q+VXzDRq4bl0k0fTrTxf5gjbWWCJ6EWcG3e1rXr+UF1a5PHtyDoAxbIuAuS+DH
sPhegeoEa/p+vcVJxaX1EaoNwLCTLXfVPdj4ZY9H5tPKzZMW9uce8w6VuczKLhOc
aph0YPIsrhOBA79ZA7zZTQy+a0PqwXomYws855EuTWt5c2iion9QGaYjviTySU0A
eWSPh60/U69FcB5orLLz1LatZqu/ikOVuBb8LcGjECjVgRMJ6NsNA01AK6qXXN9L
EVrJvLDBoc7dwLw7XesrJrQ2hiaJvgufIENTopcwq/EHn9f99vQB8pu1upyI3ehh
tAMJxwUnXEVEdzb0EIfV/l1fJVvk/ltG1q3MSevKXdIH1/fYNt0sOowXAJ20giFy
EtNbIGTKz0Hytfi3qzieyUQ62yzmTTvSG3UpZCfEvmfLa6HeKhr6oZppxRLshkX6
mv6aUaMyCavCkxsSdmuIOKR2pX/IO4AGdZDIdNQgMxEzEuhHdMPAR3gAv1wx8MS9
wIDYFvv0pOfobnFtpZu/uyzoK94PWbG3ptRMcOVx5hgnvj1SEjnkiBg4mHs21lBa
l+7KtAdfZrwyVAGTGFDJrPZ/xPfo5HIH/uftzzg0p+Uny4sDCVQ=
=rwsh
-----END PGP SIGNATURE-----

--exGO0SlXbaQVEgpj--

--===============3703758589916755284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3703758589916755284==--
