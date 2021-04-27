Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D9C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 05:15:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD558613D3
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 05:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD558613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BC7660AF4;
	Tue, 27 Apr 2021 05:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id el1U_LiKWJLk; Tue, 27 Apr 2021 05:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 355B460666;
	Tue, 27 Apr 2021 05:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA6FC000E;
	Tue, 27 Apr 2021 05:15:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D22FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 05:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0101383B3D
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 05:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TTA3tJFFXeet for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 05:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C37283B3B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 05:15:19 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FTqhc53bFz9sXH; Tue, 27 Apr 2021 15:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1619500512;
 bh=HFGpFkXW8RlYcOPAB0wEMYUjK4DKM74cGeGkNzCmj6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U9ZU8PygQ+gKg4Dw7vVyO8B/ZibWN2WAUIrLKdub8+JGLK39Z6TjSoKCanuVi1+YM
 0hwW5wA/niQmTfcV6ul0Y99xwmUvhMN+vdlkSQwGrokpZrgV2ARlsQGM4RlWqV/Fcp
 +6jHzpMuVPFfrsTC35WsndWQ/VCRpN/syLpMOBwM=
Date: Tue, 27 Apr 2021 15:15:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YIed2X41lAzNrRkn@yekko.fritz.box>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <20210423103851.41138791@redhat.com>
 <20210423222803.GK1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210423222803.GK1370958@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============2866099465806913567=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2866099465806913567==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zaCd5yHFtW9CjF+V"
Content-Disposition: inline


--zaCd5yHFtW9CjF+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 07:28:03PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 23, 2021 at 10:38:51AM -0600, Alex Williamson wrote:
> > On Thu, 22 Apr 2021 20:39:50 -0300
>=20
> > > /dev/ioasid should understand the group concept somehow, otherwise it
> > > is incomplete and maybe even security broken.
> > >=20
> > > So, how do I add groups to, say, VDPA in a way that makes sense? The
> > > only answer I come to is broadly what I outlined here - make
> > > /dev/ioasid do all the group operations, and do them when we enjoin
> > > the VDPA device to the ioasid.
> > >=20
> > > Once I have solved all the groups problems with the non-VFIO users,
> > > then where does that leave VFIO? Why does VFIO need a group FD if
> > > everyone else doesn't?
> >=20
> > This assumes there's a solution for vDPA that doesn't just ignore the
> > problem and hope for the best.  I can't speak to a vDPA solution.
>=20
> I don't think we can just ignore the question and succeed with
> /dev/ioasid.
>=20
> Guess it should get answered as best it can for ioasid "in general"
> then we can decide if it makes sense for VFIO to use the group FD or
> not when working in ioasid mode.
>=20
> Maybe a better idea will come up
>=20
> > an implicit restriction.  You've listed a step in the description about
> > a "list of devices in the group", but nothing in the pseudo code
> > reflects that step.
>=20
> I gave it below with the readdir() - it isn't in the pseudo code
> because the applications I looked through didn't use it, and wouldn't
> benefit from it. I tried to show what things were doing today.

And chance are they will break cryptically if you give them a device
in a multi-device group.  That's not something we want to encourage.

>=20
> > I expect it would be a subtly missed by any userspace driver
> > developer unless they happen to work on a system where the grouping
> > is not ideal.
>=20
> I'm still unclear - what are be the consequence if the application
> designer misses the group detail?=20
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zaCd5yHFtW9CjF+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCHndgACgkQbDjKyiDZ
s5JxehAAtYO+RRKc5WVZPWIeDfyXnWi8ml0FoabDxvzajDH8+p17N5be0pdmIfD7
RwIxa6vsjc6bimUxdIfC2yK87E2H5OCy2k2hFKKPH6eYVl9sl13Z1bYMPku/bvdG
4SGcpDrqdhVkl3Vf3dvcmdfFPD8WFYN0+Q8rnnteezGmsI2c+xkUVXk+3MeSZ3Sv
oxtOe1wZm1SQ/pPNGIZlp7hDkGpdVNoxU7rE0B+HBmLatGUbSCIfXdCR2xkkbrDI
52EyYoXno6q3yAdBdGsMfobaj+Dyza6aL7pINX450Ue4MBtUeQi3h5ymXUE1xBm6
MDiw0tTvH2lbKFmQ/Z1aQi8UTT0rOdoN0mxstkf+vukt/3j5d5MjB/cZiRDc53uk
0fTJFsv45cSxig3jzfqSR4nIvjSSwwM3h5EnSsUaauilYpi8PDR5oaJJOlmAqZyH
f80as4HB9h7qEafiEnyEHeLlGdJLfthr9tsKLsYvvmNsOKgfci+CdwJDl0oVRBQS
1JnSDAxhmPD2FbBFO6uCP0kpqDmqumsskCkyn6SWmuRHXCliAnSUvi6xHjJ2J2Fo
3jaj3241cqqLPW6CObh4ERY6YItB24UcwCcq6I8JplSRVtwJG1f4kKevAnnfHJt3
ejcWCsfAxqmnc8Zo4MHzjBiB8+UyMz40/OxAEiPMCDRqQ4Y2kTU=
=zpk/
-----END PGP SIGNATURE-----

--zaCd5yHFtW9CjF+V--

--===============2866099465806913567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2866099465806913567==--
