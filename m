Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C4C49EA3
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E8B613C1
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E8B613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0155E40570;
	Thu, 17 Jun 2021 07:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkwDhJFH1W_7; Thu, 17 Jun 2021 07:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16B5240150;
	Thu, 17 Jun 2021 07:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA3C2C000E;
	Thu, 17 Jun 2021 07:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 142F4C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A6C36072E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxYgpJO1jXT0 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D13B56070B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:09 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5W491pz9sT6; Thu, 17 Jun 2021 17:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914527;
 bh=zVWbZ8t57yg6jr2vkel/FfVJmSI+OssX8pb3npfVLG0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ENOesf92LKWneTrHhvauCH/Tmz57Jo+jwf8vIfQXhSZv8qrfNtxWwMvrrUa2SVU85
 L0HfZQWRvkWHZMCKtSOeTz9BQwNcM4AlPFK8MywJ35dgPX49Y+2nTAo3fTCsNIzYfq
 TJ1ygljN2+gEkdiRP9N8vES/H6QCe87y/Ri6vUKc=
Date: Thu, 17 Jun 2021 12:42:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YMq2l7YId3cjmVKG@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com> <YLcl+zaK6Y0gB54a@yekko>
 <20210602161648.GY1002214@nvidia.com> <YLhlCINGPGob4Nld@yekko>
 <20210603115224.GQ1002214@nvidia.com> <YL6/bjHyuHJTn4Rd@yekko>
 <20210608190406.GN1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210608190406.GN1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============3627616849997158332=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3627616849997158332==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5bobZhJ8ovb9pZNW"
Content-Disposition: inline


--5bobZhJ8ovb9pZNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 04:04:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 10:53:02AM +1000, David Gibson wrote:
> > On Thu, Jun 03, 2021 at 08:52:24AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 03, 2021 at 03:13:44PM +1000, David Gibson wrote:
> > >=20
> > > > > We can still consider it a single "address space" from the IOMMU
> > > > > perspective. What has happened is that the address table is not j=
ust a
> > > > > 64 bit IOVA, but an extended ~80 bit IOVA formed by "PASID, IOVA".
> > > >=20
> > > > True.  This does complexify how we represent what IOVA ranges are
> > > > valid, though.  I'll bet you most implementations don't actually
> > > > implement a full 64-bit IOVA, which means we effectively have a lar=
ge
> > > > number of windows from (0..max IOVA) for each valid pasid.  This ad=
ds
> > > > another reason I don't think my concept of IOVA windows is just a
> > > > power specific thing.
> > >=20
> > > Yes
> > >=20
> > > Things rapidly get into weird hardware specific stuff though, the
> > > request will be for things like:
> > >   "ARM PASID&IO page table format from SMMU IP block vXX"
> >=20
> > So, I'm happy enough for picking a user-managed pagetable format to
> > imply the set of valid IOVA ranges (though a query might be nice).
>=20
> I think a query is mandatory, and optionally asking for ranges seems
> generally useful as a HW property.
>=20
> The danger is things can get really tricky as the app can ask for
> ranges some HW needs but other HW can't provide.=20
>=20
> I would encourage a flow where "generic" apps like DPDK can somehow
> just ignore this, or at least be very, very simplified "I want around
> XX GB of IOVA space"
>=20
> dpdk type apps vs qemu apps are really quite different and we should
> be carefully that the needs of HW accelerated vIOMMU emulation do not
> trump the needs of simple universal control over a DMA map.

Agreed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5bobZhJ8ovb9pZNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDKtpUACgkQbDjKyiDZ
s5L55hAAz7xTXdVl6Sc751CmGpD70USGAOw/RdKHKOF7XHOzBuYE9TL3q5fk1JDy
xbJA2l9E6UsZDNafSc4V36fAx7MUHmengBK4zqzLK3uhP+xq/4IfJ1vugMt3SJNW
Bq78GzvTs3O0j/eVDp/Ha81XK20Dy/RFfcP1E6j7YDSsXjEwkOwavFyna/xMPpGP
HJl/cLDR2rXrAIURWO33A3W7am7TZVsLPzXblykE03XVPHDupsZTDr/vd6GXf4W0
8atDbuq09y1mi7fLdNaOMx/LVZTFQtaQwd8+1jprYEc4UJ6n/f++HS7NtNCBsPwZ
QH0LJrWjW8RaG6IVOPuQIwJ1SBAZ/gtXC65UdrBMAjQaKjxoO5b/WvUxXpXktMod
CD2dYHIzo/RKmg7NBTExYOzw9J31jIoNLXXu1Ao++RmXSSHlCb5aWkS3TQFilnMp
hdZm/4Aih4DDrgFdDYBuhanzS6IpRAwysxDj9h2cJWOR/OwYdZAcnZHS03FC6DQ0
fzIbGVFKhVk+Kstnkb8AgoLgdIFSONHdUoH8ISWIZ0bO+XGBGE9PjeqV3v9C+EhD
J8xPnFzRlGgK1BleopuME+ukjT4t1yjAfqud6EYVKzN7DcfC9kkwTNtFX2CRjRNV
H/hCA3c9kxdjRi6tk/juYHoLEAHevB1IAtTukDrsw6f+vxSQ2yE=
=PXAb
-----END PGP SIGNATURE-----

--5bobZhJ8ovb9pZNW--

--===============3627616849997158332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3627616849997158332==--
