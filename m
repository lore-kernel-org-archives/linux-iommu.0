Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87352C47093
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426106124B
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426106124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E483640465;
	Tue,  1 Jun 2021 07:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSZrMdNDKmAA; Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A1A24046B;
	Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45EEAC000E;
	Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA38C0028
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6CBB83409
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mWrqYn23bjrc for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 647A683530
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FvMqt6qFfz9sW6; Tue,  1 Jun 2021 16:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622529370;
 bh=8FKPbUwTdF9kXq/7rKGoMVmaAc+sr0iom6gOoa22bhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EnRHDYuc/K0jQcbuSJnSUPnKeSQBw8M6wzAi5eQtsV77jv3C1wdmIoZh7Qm4KD6RF
 RBvSlO3AdQj1A76MnpCaatuTrjlcVf4cFf0qAnt+deB2TM49TCmzk4Rt2o9LmUpbDZ
 /zke07cwG5qud9ON9OOle53NgWVmA3MlnyIm9v/s=
Date: Tue, 1 Jun 2021 14:27:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YLW3LVWf4amurq4o@yekko>
References: <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com> <YK8l1mZ0NVggAVUO@yekko>
 <20210527190620.GJ1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210527190620.GJ1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============1430476096926753044=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1430476096926753044==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xbmv8PanLUJwMAHh"
Content-Disposition: inline


--Xbmv8PanLUJwMAHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 04:06:20PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 02:53:42PM +1000, David Gibson wrote:
>=20
> > > > If the physical device had a bug which meant the mdevs *weren't*
> > > > properly isolated from each other, then those mdevs would share a
> > > > group, and you *would* care about it.  Depending on how the isolati=
on
> > > > failed the mdevs might or might not also share a group with the par=
ent
> > > > physical device.
> > >=20
> > > That isn't a real scenario.. mdevs that can't be isolated just
> > > wouldn't be useful to exist
> >=20
> > Really?  So what do you do when you discover some mdevs you thought
> > were isolated actually aren't due to a hardware bug?  Drop support
> > from the driver entirely?  In which case what do you say to the people
> > who understandably complain "but... we had all the mdevs in one guest
> > anyway, we don't care if they're not isolated"?
>=20
> I've never said to eliminate groups entirely.=20
>=20
> What I'm saying is that all the cases we have for mdev today do not
> require groups, but are forced to create a fake group anyhow just to
> satisfy the odd VFIO requirement to have a group FD.
>=20
> If some future mdev needs groups then sure, add the appropriate group
> stuff.
>=20
> But that doesn't effect the decision to have a VFIO group FD, or not.
>=20
> > > > It ensures that they're parked at the moment the group moves from
> > > > kernel to userspace ownership, but it can't prevent dpdk from
> > > > accessing and unparking those devices via peer to peer DMA.
> > >=20
> > > Right, and adding all this group stuff did nothing to alert the poor
> > > admin that is running DPDK to this risk.
> >=20
> > Didn't it?  Seems to me the admin that in order to give the group to
> > DPDK, the admin had to find and unbind all the things in it... so is
> > therefore aware that they're giving everything in it to DPDK.
>=20
> Again, I've never said the *group* should be removed. I'm only
> concerned about the *group FD*

Ok, that wasn't really clear to me.

I still wouldn't say the group for mdevs is a fiction though.. rather
that the group device used for (no internal IOMMU case) mdevs is just
plain wrong.

> When the admin found and unbound they didn't use the *group FD* in any
> way.

No, they are likely to have changed permissions on the group device
node as part of the process, though.

> > > You put the same security labels you'd put on the group to the devices
> > > that consitute the group. It is only more tricky in the sense that the
> > > script that would have to do this will need to do more than ID the
> > > group to label but also ID the device members of the group and label
> > > their char nodes.
> >=20
> > Well, I guess, if you take the view that root is allowed to break the
> > kernel.  I tend to prefer that although root can obviously break the
> > kernel if they intend do, we should make it hard to do by accident -
> > which in this case would mean the kernel *enforcing* that the devices
> > in the group have the same security labels, which I can't really see
> > how to do without an exposed group.
>=20
> How is this "break the kernel"? It has nothing to do with the
> kernel. Security labels are a user space concern.

*thinks*... yeah, ok, that was much too strong an assertion.  What I
was thinking of is the fact that this means that guarantees you'd
normally expect the kernel to enforce can be obviated by bad
configuration: chown-ing a device to root doesn't actually protect it
if there's another device in the same group exposed to other users.

But I guess you could say the same about, say, an unauthenticated nbd
export of a root-owned block device, so I guess that's not something
the kernel can reasonably enforce.


Ok.. you might be finally convincing me, somewhat.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xbmv8PanLUJwMAHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC1tysACgkQbDjKyiDZ
s5KRpg/+Lo/Si85pyON9vgnETlHuXUrPpw9adKpomBRfTV4i64cdow1u5AP9m3+/
qkNtTt/hFKbvGUtedWclFX1WPrO4nwELMY0iVXBHDN7vuH94ZbJllORtord8pzzL
Yo8kHxmIlWBsyfYzEh0jCeICbfakLs+bymK+jurvB6yO2MeL1cx71TIRrqdZkcvg
Aytpv7vLgL+OEzTTn8LRRQUM8UGI9vQroYufKmy4xACkOY9xuDnqGDNDrVJBmPte
HnovCg+vfeiNC7XY4Zbk6nDHtzXxI1KrCCrPqPASE3m+rwR3VRUBfaEX8OavJ0A/
p7eYUttJoeYCBNQqheZSJF3VEqaMxL8HgS2FKdWCNtM0qd4y463Z/3/emqH27iCs
faHe62/iohgr0BXew/eN4Cg6YuEVO2yj4RqVbFSLsytlNYdavpCnUOSC0HPvFv/5
oIQVm3VHkOTco/dBp//XKR4KWBdE8ebykMKAoNltwBv56toPMFE1Fm22Kof3vsAN
WeiEt3cVmQvNcv1VVlDkCSY5ORTviK6Xn8et4sWHETkurO09yMkXERoedBL51ThQ
0RAZytphO/6j9EE60WmhyQ24lj92Gt4Ow3OY34BosHz+8nkJKnOdqRPc4wsxKDBy
de+/tCGyRVRXUircNfz5Z5jzLMEvb3Y42B3qotZxzvEVVCnS2/8=
=RPSa
-----END PGP SIGNATURE-----

--Xbmv8PanLUJwMAHh--

--===============1430476096926753044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1430476096926753044==--
