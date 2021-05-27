Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04355C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:12:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592E7613C0
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592E7613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24049607F8;
	Thu, 27 May 2021 07:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnEkDDqVOoa7; Thu, 27 May 2021 07:12:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09297607DE;
	Thu, 27 May 2021 07:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2FE5C000E;
	Thu, 27 May 2021 07:12:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE21C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F21A54023B
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFycaDmub9NX for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 07:12:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2897A401C3
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:26 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FrJsx3nZ0z9sX5; Thu, 27 May 2021 17:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622099541;
 bh=Lefrtr63WtZPzxCJD/a0Dt0CwKqdjDj9tbK9ydRsQZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fMUbeAdG8FfOw30NsEJoAerE2i88uoQM3TbXYsIqJzw49r1s6kG8D5t4trO1VCikP
 +rVJ2VxCicTOzRkJBR0xiHrYjWjJgK1YyFW/0R83MMdBht/clN1NyHUc7DS35Yjt17
 S75HTnNVpEtzMDbFQRWK1Q6j/r/BpiosihFY3ZeM=
Date: Thu, 27 May 2021 15:00:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YK8nXKAJdfT5UVEu@yekko>
References: <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
Content-Type: multipart/mixed; boundary="===============0363983078241597763=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0363983078241597763==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z64+IwN5nyf9pBFr"
Content-Disposition: inline


--Z64+IwN5nyf9pBFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 02:48:03AM +0530, Kirti Wankhede wrote:
>=20
>=20
> On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
> > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> >=20
> > > 2. iommu backed mdev devices for SRIOV where mdev device is created p=
er
> > > VF (mdev device =3D=3D VF device) then that mdev device has same iommu
> > > protection scope as VF associated to it.
> >=20
> > This doesn't require, and certainly shouldn't create, a fake group.
> >=20
> > Only the VF's real IOMMU group should be used to model an iommu domain
> > linked to a VF. Injecting fake groups that are proxies for real groups
> > only opens the possibility of security problems like David is
> > concerned with.
> >=20
>=20
> I think this security issue should be addressed by letting mdev device
> inherit its parent's iommu_group, i.e. VF's iommu_group here.

No, that doesn't work.  AIUI part of the whole point of mdevs is to
allow chunks of a single PCI function to be handed out to different
places, because they're isolated from each other not by the system
IOMMU, but by a combination of MMU hardware in the hardware (e.g. in a
GPU card) and software in the mdev driver.  If mdevs inherited the
group of their parent device they wouldn't count as isolated from each
other, which they should.

>=20
> Kirti
>=20
> > Max's series approaches this properly by fully linking the struct
> > pci_device of the VF throughout the entire VFIO scheme, including the
> > group and container, while still allowing override of various VFIO
> > operations.
> >=20
> > Jason
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z64+IwN5nyf9pBFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCvJ1wACgkQbDjKyiDZ
s5LA1A/9HdoNik7wBiSYXbYApT72IFI+LhekrRCOipo8yeKeq0f2VM5RS34wrfFw
1Uhvw2jZYG8HWgG6XQczVwGyXtXtKQQL/S8djvv2Nqp3xY+++sPj2HO1xy7051m6
UpAR0ILjYOHTzj4DQI4uR7iRt6JcfK6+gedGouV++4suDp95Ta4xBo5rLBkjqn8l
VrPRt6AVMCYvVRcDb6iRhofAvhFOIjGJfarivrhPS3BzDCBrk2/BXxQ61lYy1dR9
8qqb3CFFQWbyfgtaQXz8gAQLULpWX10Ob2tUaQRrWz3iZG0H/Iq5ffX3PPuQUsjg
fIs8GH7xxWe0/7tUVzS+iwhGwcS7TmA5uktxiITJHNB/aDG3yQpzLNoLGn9fQP6h
POpSLPQY1MyPvTO9ZF91celXdAZialXuchORnG+zHmzDcG0z1NPUYORzmR0G8D8V
tuCAUL/3ayA5pR6j0X4zcpWmn32CQyC6WJ113cDDQga7fFXCbyw7zilXISGRcxHY
7PA6tsnrBbVpuuYsJINgP/NM/eHgW1U07NSiNyIjj8UNPJPjGYFm/8obYwwXTIbF
Fqv0tBPGrmq9rKbfG9Xl12SVKMdmF7f1wHVNLc6SUvUiAIVswax4YPMJmiBBoSZ9
dbzfFlE13orgt8fbZ+nYuBx9L7xc2E+kNJcw/7a45nldRaqkH8U=
=yhde
-----END PGP SIGNATURE-----

--Z64+IwN5nyf9pBFr--

--===============0363983078241597763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0363983078241597763==--
