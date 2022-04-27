Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F84C433EF
	for <iommu@archiver.kernel.org>; Wed, 27 Apr 2022 08:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABF2041960;
	Wed, 27 Apr 2022 08:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxV1TamwAvQ8; Wed, 27 Apr 2022 08:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D249417C4;
	Wed, 27 Apr 2022 08:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29908C0032;
	Wed, 27 Apr 2022 08:12:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8A2AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 08:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B650B404B9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 08:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59GQYSVG9BI0 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 08:12:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38A7340017
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 08:12:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 05DD3D11; Wed, 27 Apr 2022 10:11:58 +0200 (CEST)
Date: Wed, 27 Apr 2022 10:11:55 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: Personal email outage
Message-ID: <Ymj6yyXj4TarKujv@8bytes.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============0956707900172274204=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0956707900172274204==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HXqfdEALr/ieJ3Vn"
Content-Disposition: inline


--HXqfdEALr/ieJ3Vn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

last week I had an outage of the mail server which handles my 8bytes.org
emails, and I probably lost some of the incoming stuff that was sent to
me.

The machine has been repaired now and I can receive emails again on
that account, but it is likely that I still lost a couple of emails (at
least I have seen several replies to emails I didn't get).

I plan to go through all IOMMU patches tomorrow, if I havn't replied to
your patches by Friday, please just re-send them to me.

Sorry for the inconveniences and delays!


Thanks,

       Joerg

--HXqfdEALr/ieJ3Vn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmJo+sgACgkQK/BELZcB
GuMm4A/7Bv8o04KE4Q7YP9aCTVCf/Jqc/qy403ayQdowr2drl6+o1N3ECbPVzBFp
0fDXZhRfp8lLWoPsc5GBG6o6eCayoC1XznADh6gUFvbe5+obZqst13yJJ56UD+Y1
XITLRPIrrAJcpvquh3citQhwDzo/+4zPLvQN4wjeJsmgks5VcCTkIKF/FoaEAPJ7
6kUecAeK9ntKRW5A/iKzdjNlQfZNeD5QNwHa94jrMboDmz+5o+ZvVq7zth0l04Lc
i9Ej9XzQsc0TRsbzk7bnPjMbQ/fF9AWWdxGMcjzoOBkB5yK/ox55G5ModrWrzZ72
Bg7RLDuRAMfu7rv05JeM/iBObh/VtkUy80hE7Fcx8E6WpDBP4D+osofHvokkJSBJ
Vpz311f+uWZRby7i9T8C51MNUWfi+YFF8fNK8xkGtLLDwuBKJO3rtMGwya/kxWQa
Sn+vo688e3AGE0/QXG/7MLjG/NGUvBKwgXP2jZEOLyT8bBDj+2Qu/jI/bjzVIwa4
B0jnMc3gdbf0w5sDQODnx1XXCP1nnrfMszYVyUXkEPtaQoy9+SwxVirbxJ2fKDId
bvBqAJc/EwEou4rShtUdr+wfnLEV3+m/Q7sCnjzFi1nK0LythTsUlHQy4aPILf7v
1zeUvoUXQCAWNoJnouzFQWNJzoFZKxmv3ca7flrWhHLEaox7h/E=
=cInR
-----END PGP SIGNATURE-----

--HXqfdEALr/ieJ3Vn--

--===============0956707900172274204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0956707900172274204==--
