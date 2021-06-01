Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C7C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EB1613AB
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB1613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5382183947;
	Tue,  1 Jun 2021 07:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kEnC2R0kORG; Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1943083530;
	Tue,  1 Jun 2021 07:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB56EC000E;
	Tue,  1 Jun 2021 07:55:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFFF5C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E324483947
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fU3MuPHh0I_9 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A04583409
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:55:13 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FvMqv04JQz9sWc; Tue,  1 Jun 2021 16:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622529371;
 bh=Ak8v6J4KZgBCm2gkleU0vO46h8Ck6IdgA6FN2O7Jaio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZGuoGWAXjF+uLY5kl0PEgFkT0CF0LUWT0pU8sXnoXW00QpIg9n4YSk3ANreX9JBOJ
 gOU9X71o5Z8FUdMaSuAj+rLmHaCXbVOAzpBiU0cO1TAq5jv5B+3HyCudYO9YbJhI5z
 yDi4FmOsknyKB/UQFB2n724sq4XVAH2B4zNAdF9Q=
Date: Tue, 1 Jun 2021 14:03:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YLWxlZC4AXJPOngB@yekko>
References: <YIoiJRY3FM7xH2bH@yekko> <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko> <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko> <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com> <YK8m9jNuvEzlXWlu@yekko>
 <20210527184847.GI1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210527184847.GI1002214@nvidia.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
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
Content-Type: multipart/mixed; boundary="===============1699948050258916144=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1699948050258916144==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vhkj2zFFbKMf0kbf"
Content-Disposition: inline


--vhkj2zFFbKMf0kbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 03:48:47PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 02:58:30PM +1000, David Gibson wrote:
> > On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > >=20
> > > > 2. iommu backed mdev devices for SRIOV where mdev device is created=
 per
> > > > VF (mdev device =3D=3D VF device) then that mdev device has same io=
mmu
> > > > protection scope as VF associated to it.=20
> > >=20
> > > This doesn't require, and certainly shouldn't create, a fake group.
> >=20
> > It's only fake if you start with a narrow view of what a group is.=20
>=20
> A group is connected to drivers/iommu. A group object without *any*
> relation to drivers/iommu is just a complete fiction, IMHO.

That might be where we differ.  As I've said, my group I'm primarily
meaning the fundamental hardware unit of isolation.  *Usually* that's
determined by the capabilities of an IOMMU, but in some cases it might
not be.  In either case, the boundaries still matter.

> > > Only the VF's real IOMMU group should be used to model an iommu domain
> > > linked to a VF. Injecting fake groups that are proxies for real groups
> > > only opens the possibility of security problems like David is
> > > concerned with.
> >=20
> > It's not a proxy for a real group, it's a group of its own.  If you
> > discover that (due to a hardware bug, for example) the mdev is *not*
>=20
> What Kirti is talking about here is the case where a mdev is wrapped
> around a VF and the DMA isolation stems directly from the SRIOV VF's
> inherent DMA isolation, not anything the mdev wrapper did.
>=20
> The group providing the isolation is the VF's group.

Yes, in that case the mdev absolutely should be in the VF's group -
having its own group is not just messy but incorrect.

> The group mdev implicitly creates is just a fake proxy that comes
> along with mdev API. It doesn't do anything and it doesn't mean
> anything.

But.. the case of multiple mdevs managed by a single PCI device with
an internal IOMMU also exists, and then the mdev groups are *not*
proxies but true groups independent of the parent device.  Which means
that the group structure of mdevs can vary, which is an argument *for*
keeping it, not against.

> > properly isolated from its parent PCI device, then both the mdev
> > virtual device *and* the physical PCI device are in the same group.
> > Groups including devices of different types and on different buses
> > were considered from the start, and are precedented, if rare.
>=20
> This is far too theoretical for me. A security broken mdev is
> functionally useless.

Is it, though?  Again, I'm talking about the case of multiple mdevs
with a single parent device (because that's the only case I was aware
of until recently).  Isolation comes from a device-internal
IOMMU... that turns out to be broken.  But if your security domain
happens to include all the mdevs on the device anyway, then you don't
care.

Are you really going to say people can't use their fancy hardware in
this mode because it has a security flaw that's not relevant to their
usecase?


And then.. there's Kirti's case.  In that case the mdev should belong
to its parent PCI device's group since that's what's providing
isolation.  But in that case the parent device can be in a
multi-device group for any of the usual reasons (PCIe-to-PCI bridge,
PCIe switch with broken ACS, multifunction device with crosstalk).
Which means the mdev also shares a group with those other device.  So
again, the group structure matters and is not a fiction.

> We don't need to support it, and we don't need complicated software to
> model it.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vhkj2zFFbKMf0kbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC1sZMACgkQbDjKyiDZ
s5Jg0A//dfV0uuvM5wq5Lqe/8NygQkdHhnPLy98IVfmW8vahS2FUIZu+ys2WYxJz
nHkUuUMBA2iO9qx2qbT8gz75Ps7Np2dq1u6IJKoPguwT+ynzj5K1S1qWHN5ZjZtM
znpsoMq8OH+U0NZ7qrPRdD9FmoE+iwOGc0OhrG0eiaXZGRojgC2dVSRKC7filiZZ
Q53HYq9FteBRgkJSTof80+TVmQhhmT5XMySErJaiSMktHrehNZjgqulPUSjMRR2h
xKiGXCe9sXYrLvpfkvb5YBx6VHrtdQt9BKw53z5ctBoD1PbB/Dcxlpeu9m0KJm91
uEai0euc9G65QVqpGWoWW9yvsoE+YD6+Lk0KhveEN9yk/OknaiPHqIyLRR1j9G4i
HyjjC3V9VxGXrHgZY4taNvvb+CtOAWYeTfjR5QDYBTbZu7hUCeVPjAGlJEkCxufl
GOQfzJmMFyDrYVuvNzeYs3GHD3mncdg3NxWrLH03xVwaNHzIaNO6SKDAfjRVqBQH
ExP9kjVozUEPjspmHwQXJA6s/jRMK5v7Pl7Q4I5oHFXl9HK+1IKnMe1Wbj7LARul
5aL1tcFnyXA/5crtTcCMUxgWsHtKN+rN0EQ5O/rioAJWejkIGip2JSr+hN8bl+fS
nVamgXI2cpk3CESdmpROG+BeeLXPEvH/G36pj/C/x1K0MQhrx84=
=Bli1
-----END PGP SIGNATURE-----

--vhkj2zFFbKMf0kbf--

--===============1699948050258916144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1699948050258916144==--
