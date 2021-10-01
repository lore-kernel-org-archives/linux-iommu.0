Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E6C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 06:30:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE3861A65
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 06:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EE3861A65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D488E40017;
	Fri,  1 Oct 2021 06:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0fzTKwoZWQV; Fri,  1 Oct 2021 06:30:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D56B40414;
	Fri,  1 Oct 2021 06:30:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E45AEC0024;
	Fri,  1 Oct 2021 06:30:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36E49C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14A4C843F4
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fIUlJAzB79Az for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:30:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFE15843EB
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:47 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HLKxG5ddcz4xbX; Fri,  1 Oct 2021 16:30:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633069842;
 bh=8e3p6TcMHyRkYPl5aL0IcT9hwWBWAm1eByV6Ex3QjQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fmrCL9FoSlEpgqzzMuHtEIFJ5ELrO+YhZR+RUiPOoN2hvXbQz0WEIhHkT5wOOQMHf
 AMP4c0w0aAH6duPu0eVAeaN5GIxXJbC+Q0PtSYr4r+DNB4masVwneN6GxilQUPlcRq
 Hi6zgD6uJwYkjtypqC0k5G5BQzQU5BOKLm8IsAEM=
Date: Fri, 1 Oct 2021 16:19:22 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YVaoamAaqayk1Hja@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210922140911.GT327412@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============6873859079031467415=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6873859079031467415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHnk0tj9oYSt/rWa"
Content-Disposition: inline


--lHnk0tj9oYSt/rWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 22, 2021 at 11:09:11AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 03:40:25AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 1:45 AM
> > >=20
> > > On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > > > This patch adds IOASID allocation/free interface per iommufd. When
> > > > allocating an IOASID, userspace is expected to specify the type and
> > > > format information for the target I/O page table.
> > > >
> > > > This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> > > > implying a kernel-managed I/O page table with vfio type1v2 mapping
> > > > semantics. For this type the user should specify the addr_width of
> > > > the I/O address space and whether the I/O page table is created in
> > > > an iommu enfore_snoop format. enforce_snoop must be true at this po=
int,
> > > > as the false setting requires additional contract with KVM on handl=
ing
> > > > WBINVD emulation, which can be added later.
> > > >
> > > > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> > > > for what formats can be specified when allocating an IOASID.
> > > >
> > > > Open:
> > > > - Devices on PPC platform currently use a different iommu driver in=
 vfio.
> > > >   Per previous discussion they can also use vfio type1v2 as long as=
 there
> > > >   is a way to claim a specific iova range from a system-wide addres=
s space.
> > > >   This requirement doesn't sound PPC specific, as addr_width for pci
> > > devices
> > > >   can be also represented by a range [0, 2^addr_width-1]. This RFC =
hasn't
> > > >   adopted this design yet. We hope to have formal alignment in v1
> > > discussion
> > > >   and then decide how to incorporate it in v2.
> > >=20
> > > I think the request was to include a start/end IO address hint when
> > > creating the ios. When the kernel creates it then it can return the
> >=20
> > is the hint single-range or could be multiple-ranges?
>=20
> David explained it here:
>=20
> https://lore.kernel.org/kvm/YMrKksUeNW%2FPEGPM@yekko/

Apparently not well enough.  I've attempted again in this thread.

> qeumu needs to be able to chooose if it gets the 32 bit range or 64
> bit range.

No. qemu needs to supply *both* the 32-bit and 64-bit range to its
guest, and therefore needs to request both from the host.

Or rather, it *might* need to supply both.  It will supply just the
32-bit range by default, but the guest can request the 64-bit range
and/or remove and resize the 32-bit range via hypercall interfaces.
Vaguely recent Linux guests certainly will request the 64-bit range in
addition to the default 32-bit range.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lHnk0tj9oYSt/rWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFWqGoACgkQbDjKyiDZ
s5L8tw//YY7tiUXvMIAGIXm61TIv66CLrMTg/3GyGWaYPOk+/BAQDLy5JD1g3v8n
BFTejm6zx860jQwAkybZ9lBfZQrON5AwvUt75TGwjtMIgbHFJNfbicP9exYDtmrO
p8ioJcXNUG1+lxpkNZwqHr7w65TMTpGdkxFPw4ndpMB6fnyr9nLMFq29XoH8P21A
ksBSwHNAMnAffDWSo4f5WkOzn0lpr+wSJrdR300eHLpE7kAFxIsL89lse/q2t/RT
eXxKn3+wh049SR7Hs/EMNemJZlgLy2+7HQxR0jBBBBFuTCDlv5TCRKdqBQbdamMc
KJhaZLMub9D88YFof5rLYZ6VUfSQpcrtsJe7wmzjKvErjjYwRc/YhoQE+Ny+nWZh
Ufvin7QR2SUFT2DvWkntoqjP16gNn6F4ojvs9XJzvFrV5UWSK9O080pBRhlilshK
skD2BjpzeTGkSJyfVaK3JjV11Ng/JoJqE4jWddzDZlE3vcd1QYABuMhj0U/v9Nc3
urDaZ08q9eu3Bvmn7gVMeApH5S4H0NDl2MTQeaayz9gn1/AZGMOi8ai3qT2I/iWS
3OooRYVajkdqiMwsHhOF75UOHk38XYrrGp+NuQ6/vn3G7gMh0I5fADbCNKIP4LJJ
oU544hDEtGp+2mUL8ljjnZVjmsYwJ3TMI6icSSfL+sZ3eI9JVAo=
=iO+M
-----END PGP SIGNATURE-----

--lHnk0tj9oYSt/rWa--

--===============6873859079031467415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6873859079031467415==--
