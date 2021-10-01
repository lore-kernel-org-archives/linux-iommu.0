Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88AAC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 04:14:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E06C619E9
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 04:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E06C619E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00073400D5;
	Fri,  1 Oct 2021 04:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmgYl8IOLvBg; Fri,  1 Oct 2021 04:14:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E2804010D;
	Fri,  1 Oct 2021 04:14:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72736C000F;
	Fri,  1 Oct 2021 04:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE4D4C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96A1E4010D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7FdT6S83I81 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 04:14:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A738400D5
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:14:07 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HLGvX3VR8z4xbT; Fri,  1 Oct 2021 14:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633061640;
 bh=ErzESc+3j15+IBkmNZmWRkNDim6Klxc8DaJ69XgNhq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ARxZnU3s5FNr8NvyJlmKRTVFYh6OTyT7VDurD/TxE3AgXrUf0o3e0BEn5otjeg9Gh
 V+tlfc9uRhb4TapUkstbqYbj/OvuZqK2eF2/sIuv2u9+EwpTjqnBnL390uNsxu9sCr
 thN9IcRSVl7shSeObTIvRdq5bYQJZwz6iOXfstXI=
Date: Fri, 1 Oct 2021 13:54:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <YVaGjKggJ9guJ4gE@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <YVPxzad5TYHAc1H/@yekko>
 <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YVQJJ/ZlRoJbAt0+@yekko> <20210929125716.GT964074@nvidia.com>
 <YVUqYsJTMkt1nnXL@yekko> <20210930222818.GI964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210930222818.GI964074@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============5341356924263710363=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5341356924263710363==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yg8w2iyVSrHxaZnC"
Content-Disposition: inline


--yg8w2iyVSrHxaZnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2021 at 07:28:18PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 30, 2021 at 01:09:22PM +1000, David Gibson wrote:
>=20
> > > The *admin* the one responsible to understand the groups, not the
> > > applications. The admin has no idea what a group FD is - they should
> > > be looking at the sysfs and seeing the iommu_group directories.
> >=20
> > Not just the admin.  If an app is given two devices in the same group
> > to use *both* it must understand that and act accordingly.
>=20
> Yes, but this is true regardless of what the uAPI is,

Yes, but formerly it was explicit and now it is implicit.  Before we
said "attach this group to this container", which can reasonably be
expected to affect the whole group.  Now we say "attach this device to
this IOAS" and it silently also affects other devices.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yg8w2iyVSrHxaZnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFWhooACgkQbDjKyiDZ
s5KWOxAAjyayEpk3/2UCunzQoONH2hekaB3mFVJmCIhc7mJCra4nKi0QetNRNSJR
Mu4bgd8Espq9vrCUL2gHPfaXOfJqi34ln+aElFfmOiKSiBz0tXQJ3e/L/KWpDAAL
L5KsZxLwWJ4nOCpk9skfKxzECUasDHOgeUHvLhJiLEoHP3dYwO+gijf96rOcTwmj
PHBPL960LXUGBIbFAocGquSuvMOUpbtIRUlCmdVgkPZeWqm2WCUs5/jesBnxAKtj
qJU5aEytGm6bAhFfhvtLasQUVC42xVJmE0A9fXGvhvKtigEcWHWd4c16E7tGYYB3
z7IliPfnD8cuhMN7MzlImEM3zBQWxrgdQn8zKXvCvcIVBGAvlfcj53KYHuPyLGZE
8SzuCMbiqGQjLNZ/d7fxrTalaOvn8r3/njB/YpLUzaRXeUIM5K8MK1pmxLtbOF2q
jYt8WGVQhDFU+BE/YdPDme4E8kgrskk9d3QDeb00pzHayBuq2RZtA1WqnjXDGvfr
uJPnyOiH2WigaRlsyKO6l0a9WmnbWZE5f75rW476Lw9qGFpU8d3vfNXhQHM6payb
4LwEHjDGgdlQncfujTBXHpBt6kH9r0Zg+lmA8mmHTpfRVfNoJtB2HuvFQgUMYVNa
Fa0jPYeQTMyjlp7DpxGosCLB9OQJ3E5S64ppTdpPIQULRQKFx4w=
=37P5
-----END PGP SIGNATURE-----

--yg8w2iyVSrHxaZnC--

--===============5341356924263710363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5341356924263710363==--
