Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8382AC48BDF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA67613C3
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA67613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42CC7406B2;
	Thu, 24 Jun 2021 04:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Boe7pfS9024e; Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D2B24149A;
	Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C436C002C;
	Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EFF8C001A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AA7F60882
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DfuQuRphmUn2 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D0096079D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT58RKz9t0p; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=Sm55XzzGfIQHnANDiUMDuvbZ7IYjUCtojFRRcEiqmdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZuxeZjTQrfzT56BXV29tLxlyIOHOXy7GQrcr5dBHMdRwtRLepAJHBZ5QOStm+KtB9
 y/cqy+JBpGt3PhpRnK8A4w9a+1QeLo6AY7yDNB6p+zQ7fzd3+URtYF1LoCqsBD7qyE
 RJM+qZc3B2GADxb/auGsSb1b+o/5v4GHaOrRSSXE=
Date: Thu, 24 Jun 2021 14:37:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YNQMC4GcV3gxjerb@yekko>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <YMrXaWfAyLBnI3eP@yekko> <20210617230438.GZ1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210617230438.GZ1002214@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============7330638224017693521=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7330638224017693521==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yoFsgJzPurSq8+17"
Content-Disposition: inline


--yoFsgJzPurSq8+17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 08:04:38PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 17, 2021 at 03:02:33PM +1000, David Gibson wrote:
>=20
> > In other words, do we really have use cases where we need to identify
> > different devices IDs, even though we know they're not isolated.
>=20
> I think when PASID is added in and all the complexity that brings, it
> does become more important, yes.
>=20
> At the minimum we should scope the complexity.
>=20
> I'm not convinced it is so complicated, really it is just a single bit
> of information toward userspace: 'all devices in this group must use
> the same IOASID'

Um.. no?  You could have devA and devB sharing a RID, but then also
sharing a group but not a RID with devC because of different isolation
issues.  So you now have (at least) two levels of group structure to
expose somehow.

>=20
> Something like qemu consumes this bit and creates the pci/pcie bridge
> to model this to the guest and so on.
>=20
> Something like dpdk just doesn't care (same as today).
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yoFsgJzPurSq8+17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUDAsACgkQbDjKyiDZ
s5K4XA//Y4QIGGAGVVbJfKrlf5JkN2/2a7VHx4vaUfc4NR5mVhkNYwvGbSYutZQ7
AjjTm5pfpoAem4nB8Q6U3GfaFTsj2YUg6Vodt8xJhSilvNHENa04nCVQMhACfYUn
SaQAMbx4gnuxaL02rl5NzWe5u5j1Vm1L485cfpMvdDae0Huq4qiMV4zCASCxGkO3
vIRkdPSdp8legFimjVdQJPLVnAIFG1nJk/9toYcNpXp0esbOxYMHszvcXkMM3F2l
1qyY4HbXOHBGQTvuAAAATYZve/p9YqYQ8ePzuYuLo8q4HAzL3V1uB9Dy9sGgXhFL
g46MfO3FKjnjrMxpanmv6ztsnoY4WOxMJundhPQ1ANayPNAPVSn3KaCSzX7hcfQH
xSOX8kjr5RDi1F3BYKPmOOGRK0dmGMRaWlCapWSLkobKzUUAaUT43jMa2843gP9O
b9PSXzODLGUu3fIUITRoMLGI881jigBWg/gmtV1egbi0s/qngiheJFzP9mptbzfw
eciggSqjH/4ZBuBpRhNDnICQNNF/39/r9qOeWeiBicfW+8HciMvcsjvcWVgOnAhl
/nIFGSMu6uTSWnSP6WR4fYDy7WRlsQM+GUk58WekBW19yzvoaoubmBXRCHq5eHmF
hKf3A9OxFZRJNs0G8wp6e6R3RSp67s+4+AUyEmEdzsJ6863Z9xw=
=1/9P
-----END PGP SIGNATURE-----

--yoFsgJzPurSq8+17--

--===============7330638224017693521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7330638224017693521==--
