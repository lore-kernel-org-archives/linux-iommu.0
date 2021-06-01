Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88696C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F47561378
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F47561378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCCCF402E9;
	Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-gmyqfTNFJb; Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7009C4045A;
	Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C065C0025;
	Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F44AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E504483B47
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHH5i699V1Su for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 649268379F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FvMqt6CVVz9sWD; Tue,  1 Jun 2021 16:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622529370;
 bh=RcI3Lx6JqEXLQdQCTtj7ox+tPHAP/LFuk9JoMwCrYnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g8TTpBDIOhwOzpuTzNz/rgTIH6GOtOp2ImFhD29VybP0A3+MY/DGJ7LOTsp0UzL0t
 NDTCwcOkwNx796SFiWI5riuLggf6GllJosGLDxvACByxmyNyqKG3MLt4g8mln6Ei+E
 fiHf3GYNn3wFrctEbMA/+GDV1CZNMv7S++8AnP9I=
Date: Tue, 1 Jun 2021 13:45:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YLWtWRzO/DukUC1a@yekko>
References: <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
 <YK8nXKAJdfT5UVEu@yekko>
 <2476b70c-9320-a49c-efa5-fb7027e1b572@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <2476b70c-9320-a49c-efa5-fb7027e1b572@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: multipart/mixed; boundary="===============7043516553752540610=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7043516553752540610==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RMasjA1xbGOcqeUG"
Content-Disposition: inline


--RMasjA1xbGOcqeUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 11:55:00PM +0530, Kirti Wankhede wrote:
>=20
>=20
> On 5/27/2021 10:30 AM, David Gibson wrote:
> > On Wed, May 26, 2021 at 02:48:03AM +0530, Kirti Wankhede wrote:
> > >=20
> > >=20
> > > On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
> > > > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > > >=20
> > > > > 2. iommu backed mdev devices for SRIOV where mdev device is creat=
ed per
> > > > > VF (mdev device =3D=3D VF device) then that mdev device has same =
iommu
> > > > > protection scope as VF associated to it.
> > > >=20
> > > > This doesn't require, and certainly shouldn't create, a fake group.
> > > >=20
> > > > Only the VF's real IOMMU group should be used to model an iommu dom=
ain
> > > > linked to a VF. Injecting fake groups that are proxies for real gro=
ups
> > > > only opens the possibility of security problems like David is
> > > > concerned with.
> > > >=20
> > >=20
> > > I think this security issue should be addressed by letting mdev device
> > > inherit its parent's iommu_group, i.e. VF's iommu_group here.
> >=20
> > No, that doesn't work.  AIUI part of the whole point of mdevs is to
> > allow chunks of a single PCI function to be handed out to different
> > places, because they're isolated from each other not by the system
> > IOMMU, but by a combination of MMU hardware in the hardware (e.g. in a
> > GPU card) and software in the mdev driver.
>=20
> That's correct for non-iommu backed mdev devices.
>=20
> > If mdevs inherited the
> > group of their parent device they wouldn't count as isolated from each
> > other, which they should.
> >=20
>=20
> For iommu backed mdev devices for SRIOV, where there can be single mdev
> device for its parent, here parent device is VF, there can't be multiple
> mdev devices associated with that VF. In this case mdev can inherit the
> group of parent device.

Ah, yes, if there's just one mdev for the PCI function, and the
function doesn't have an internal memory protection unit then this
makes sense.

Which means we *do* have at least two meaningfully different group
configurations for mdev:
  * mdev is in a singleton group independent of the parent PCI device
  * mdev shares a group with its parent PCI device

Which means even in the case of mdevs, the group structure is *not* a
meaningless fiction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RMasjA1xbGOcqeUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC1rVYACgkQbDjKyiDZ
s5LMVxAAsYLjKEMctzEWQ3xVpx/4Hfkf2mPGV/JzCIgHCBaT6eaYbHpLCAGtpuLQ
Vd7VkM2Ytcl+x9AKw2ssd0VHn9t8VaS1bSshJRCUoaIAN2Nu/HhwQ7IArsS4ro25
FvsIoALYpr9dwp7u9c2fVAOB8hWPyRH4li3k/xLY1H6c/OSMNhMUyAvOX9iaFQk4
Fw0/nLH/y17Vf9w1WEqS/X0ePMI0TK8W5UtUjXMOK//3M7jyFsodKLNblNDVnPHg
BUUFrkmWgLw7pXHYaDnvW411cSRkQ1bzUyMC9Jad6FwdWY/Y9fmuvu/oTvD9fjUS
vjlxcrIzo/e/AJn9WStMp4FB2PA0iAlonSghB0y1Zxar4eGLjPqC9rEKQ8o1Z2O0
oKrSZ4JRRGW1c3NBxg9NWIdg1nsn/TdKo3XysOf8a7HexVf0fbz9FWwy4OJ3M0uv
g5LpDFlb6CFA7ZSs+Crro+PvfWMxp6CR86S9gnN+emo3zw5dDejWgitJeRW2Jsox
CJMc3+1fVmhUAlgzCvnf5W9vlshod9Nhs32NxQCNxHGEuWUFDQu/mnw2CqGxhWjf
/KFmvOCm/S0Qo3h1eaadoiRqEhX7uEqW1cuCfxBp4wg3I85nAJEtct1CYUCzsV0q
ytCWdEh6AQg7aJB0KMrC5TWXGp4vrCn+Dm9tFqXnMMZnVmQ5QZY=
=vGLv
-----END PGP SIGNATURE-----

--RMasjA1xbGOcqeUG--

--===============7043516553752540610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7043516553752540610==--
