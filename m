Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25467C47420
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 09:52:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B657722204
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVa3j7DF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B657722204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4C9F386AF7;
	Thu,  1 Oct 2020 09:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCRzs97mrB-s; Thu,  1 Oct 2020 09:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9408D86AF0;
	Thu,  1 Oct 2020 09:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F16CC016F;
	Thu,  1 Oct 2020 09:52:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A5B5C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 17A8186AF6
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8gcAeCPbsYb for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 09:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1025F86AF0
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 09:52:00 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id i26so7067818ejb.12
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aPY+MyaN3eHD52C4pGO+iu+NSxmmOLBQGpmRY1viv6c=;
 b=bVa3j7DFaJdudCtmoiaTsVjk7lsQZkfEAlX8wmufqsJVZ1hTWHFjKyzxTuSzbNqBfL
 VN6JoknzhePNt/5Pb+Rrm5QrIIIwQ5X6sOu3jUB8X46wSVeZ+tSY7vfFeLuG8bTeFnNa
 U8Clrrec+YrqQvOkNALd1taQ0uurzd7rfN1wfysg3/rY9N1PB/cJhPPqzG8PPHdxWjr6
 EarFIZigBkgyWtYqgrWAurK2ArZNVNX8p7AROwzjbGztxW5TW2h1cSMPirlqGs4b01Dn
 YFXQUwS5UMRkXfghSPMLpx0bkT6rlc++RXl5lRf0vi1HYm0x5yqS6SvZSKk6rLCwu2p2
 z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aPY+MyaN3eHD52C4pGO+iu+NSxmmOLBQGpmRY1viv6c=;
 b=RXbs2lO84GD81FffttJjwFoXqjj1+mBdqI8iSLEc81PwytTduuEB9JUDM/xKeqJu79
 kTFD4YygKLKH10KgEyWtf8Z5/lo59rNWeH3KE56OJv8lZRHEValWykajt5F8DzmzltmB
 aOPqDMXyTjV0YS++y5av0VSfka2ClJ0UdWSlkKb9Td5AlCtY3Puvn3VEHkurX3eHFOey
 +y5WQZBxU0rmcM6YU7kfFHExx6E4lXj92yuP6/kNYxH17g+c8gUlpcUG/ebNKFgEYSCw
 Ahuj4/RLEyL0rjE1dU5hePz7ixlxY1ZQ5n4CMDoODJr0pHq2/rtp+lz/7AaRn3lXEiFx
 aMDA==
X-Gm-Message-State: AOAM533pJcHNEsjUDjc7aQ/jAPanohbUJDk1vCzXKv5OkJwoC3YcHKOo
 DO+SZVkiFzRguNoTah+QXzo=
X-Google-Smtp-Source: ABdhPJx+7eAB9ejqZO0LRBbDrS6HTe/2rWdJAxOZl3urF2SeUR0xFxi5gkfUXGyNtvkYSnLmQi2Flg==
X-Received: by 2002:a17:906:aec1:: with SMTP id
 me1mr7368299ejb.225.1601545918322; 
 Thu, 01 Oct 2020 02:51:58 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id a2sm3705187ejx.27.2020.10.01.02.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 02:51:57 -0700 (PDT)
Date: Thu, 1 Oct 2020 11:51:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001095152.GD3919720@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20201001012630.GA28240@Asurada-Nvidia>
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
Content-Type: multipart/mixed; boundary="===============0351525153765724263=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0351525153765724263==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 06:26:30PM -0700, Nicolin Chen wrote:
> On Thu, Oct 01, 2020 at 12:56:46AM +0300, Dmitry Osipenko wrote:
> > 01.10.2020 00:32, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Thu, Oct 01, 2020 at 12:24:25AM +0300, Dmitry Osipenko wrote:
> > >> ...
> > >>>> It looks to me like the only reason why you need this new global A=
PI is
> > >>>> because PCI devices may not have a device tree node with a phandle=
 to
> > >>>> the IOMMU. However, SMMU support for PCI will only be enabled if t=
he
> > >>>> root complex has an iommus property, right? In that case, can't we
> > >>>> simply do something like this:
> > >>>>
> > >>>> 	if (dev_is_pci(dev))
> > >>>> 		np =3D find_host_bridge(dev)->of_node;
> > >>>> 	else
> > >>>> 		np =3D dev->of_node;
> > >>>>
> > >>>> ? I'm not sure exactly what find_host_bridge() is called, but I'm =
pretty
> > >>>> sure that exists.
> > >>>>
> > >>>> Once we have that we can still iterate over the iommus property an=
d do
> > >>>> not need to rely on this global variable.
> > >>>
> > >>> I agree that it'd work. But I was hoping to simplify the code
> > >>> here if it's possible. Looks like we have an argument on this
> > >>> so I will choose to go with your suggestion above for now.
> > >>
> > >> This patch removed more lines than were added. If this will be oppos=
ite
> > >> for the Thierry's suggestion, then it's probably not a great suggest=
ion.
> > >=20
> > > Sorry, I don't quite understand this comments. Would you please
> > > elaborate what's this "it" being "not a great suggestion"?
> > >=20
> >=20
> > I meant that you should try to implement Thierry's solution, but if the
> > end result will be worse than the current patch, then you shouldn't make
> > a v4, but get back to this discussion in order to choose the best option
> > and make everyone agree on it.
>=20
> I see. Thanks for the reply. And here is a sample implementation:
>=20
> @@ -814,12 +815,15 @@ static struct tegra_smmu *tegra_smmu_find(struct de=
vice_node *np)
>  }
> =20
>  static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *=
dev,
> -				struct of_phandle_args *args)
> +				struct of_phandle_args *args, struct fwnode_handle *fwnode)
>  {
>  	const struct iommu_ops *ops =3D smmu->iommu.ops;
>  	int err;
> =20
> -	err =3D iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> +	if (!fwnode)
> +		return -ENOENT;
> +
> +	err =3D iommu_fwspec_init(dev, fwnode, ops);
>  	if (err < 0) {
>  		dev_err(dev, "failed to initialize fwspec: %d\n", err);
>  		return err;
> @@ -835,6 +839,19 @@ static int tegra_smmu_configure(struct tegra_smmu *s=
mmu, struct device *dev,
>  	return 0;
>  }
> =20
> +static struct device_node *tegra_smmu_find_pci_np(struct pci_dev *pci_de=
v)
> +{
> +	struct pci_bus *bus =3D pci_dev->bus;
> +	struct device *dev =3D &bus->dev;
> +
> +	while (!of_property_read_bool(dev->of_node, "iommus") && bus->parent) {
> +		dev =3D &bus->parent->dev;
> +		bus =3D bus->parent;
> +	}
> +
> +	return dev->of_node;
> +}

This seems like it's the equivalent of pci_get_host_bridge_device(). Can
you use that instead? I think you might use the parent of the host
bridge that's returned from that function, though.

Thierry

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl91prcACgkQ3SOs138+
s6Fzow/9EGA/miigYk1RYGKaX6nN8Jl2bZRTKfwp0TTaegw7NEya34qmC1q6Ifou
MRCbSPSDXC97bkOQ5dZloJvAnv1mzZd+79ihEEGGeoEwkGk2FqA99/1vTSKYK+58
MN1A2NY1DtOD6yoRsJbfjI7tc+Embd3aymXaI/gT9yOYPRd9z/0Fg+FoJudUIEhE
Gs+AP0VCpre0XkRDiq1mONE74lgcfidMp6wXHLWNdbJ6OjK87xgqFQZ0tD1Y0ecS
MS1dttMszm3S43a/1QdY0Qr9p0Nxl6KgDRtmez2ELTY8n63vfslQ4RDd+Om/++nW
divpQqi3W8dYtHE9CwEI45mtUlJSMTup+ThfYJ4/O6sh/JDSIYxX9ligNEsySpsy
5ZHIsEE77tdFSwynk7oxnHCBYkLo/qp5CvW5t+e1hx8Cf2Jaj6gQ5YjAxbOBy2Zk
8tGdm7d5XhJjyPzWq1q5nHBY2iEi7PAQlmAurHJkTTujYc318H1Xp3NYgKThdFGd
SueTpE1dIouqFpVdp3hks8jzFSqOP0tjOAHBW2OVm3r0EseG8W6uXvoYUF8FN9ui
ajYqfqrtpUrfdOGnEqCClmUbOoJvb9nnzI861SLYEv9OZJ0ag4Pwic4wf5XEl8CM
M/AdWcldy82Bbhr0KmmP6Av7/DBSjIM2RskCiOHvfFnMWQ+YfnI=
=eSx1
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

--===============0351525153765724263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0351525153765724263==--
