Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DAAC49EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0F8613D5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0F8613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C0E83BFD;
	Thu, 24 Jun 2021 04:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sw2zP38TQ-3r; Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8C5D83C13;
	Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6104C002F;
	Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33630C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E412403F4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcsFgmnSRE_I for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40930400DC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT3YPMz9srZ; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=EHvfXmcln2cuvHUfIp1Ef7p8K3ajzOq94RDeey096tE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TLx424KuLQp4RlGrMdd/XU1zskLB9aQBL7f+kySPUHLCC3lqX9LWrh12zvpA+TcOr
 0StJ/pb2zu0SG9Y0IiFFtsyzTFOs8YMMnsQ7Xl5Oy/8tVeSv8nw3Nz8qwSpgUoHTfg
 JWwQ8QJOV4hokfVSaRLQ1EUzu8E+KejVDr94Jz50=
Date: Thu, 24 Jun 2021 14:23:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YNQIyP4RR0PmVtLo@yekko>
References: <20210612012846.GC1002214@nvidia.com>
 <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210617151452.08beadae.alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
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
Content-Type: multipart/mixed; boundary="===============8716380939158912696=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8716380939158912696==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbemreCsSMMcmVQr"
Content-Disposition: inline


--VbemreCsSMMcmVQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 03:14:52PM -0600, Alex Williamson wrote:
> On Thu, 17 Jun 2021 07:31:03 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Thursday, June 17, 2021 3:40 AM
> > > On Wed, 16 Jun 2021 06:43:23 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Wednesday, June 16, 2021 12:12 AM
> > > > > On Tue, 15 Jun 2021 02:31:39 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > Sent: Tuesday, June 15, 2021 12:28 AM
[snip]

> > > > > 3) A dual-function conventional PCI e1000 NIC where the functions=
 are
> > > > >    grouped together due to shared RID.
> > > > >
> > > > >    a) Repeat 2.a) and 2.b) such that we have a valid, user access=
ible
> > > > >       devices in the same IOMMU context.
> > > > >
> > > > >    b) Function 1 is detached from the IOASID.
> > > > >
> > > > >    I think function 1 cannot be placed into a different IOMMU con=
text
> > > > >    here, does the detach work?  What's the IOMMU context now? =20
> > > >
> > > > Yes. Function 1 is back to block-DMA. Since both functions share RI=
D,
> > > > essentially it implies function 0 is in block-DMA state too (though=
 its
> > > > tracking state may not change yet) since the shared IOMMU context
> > > > entry blocks DMA now. In IOMMU fd function 0 is still attached to t=
he
> > > > IOASID thus the user still needs do an explicit detach to clear the
> > > > tracking state for function 0.
> > > > =20
> > > > >
> > > > >    c) A new IOASID is alloc'd within the existing iommu_fd and fu=
nction
> > > > >       1 is attached to the new IOASID.
> > > > >
> > > > >    Where, how, by whom does this fail? =20
> > > >
> > > > No need to fail. It can succeed since doing so just hurts user's ow=
n foot.
> > > >
> > > > The only question is how user knows the fact that a group of devices
> > > > share RID thus avoid such thing. I'm curious how it is communicated
> > > > with today's VFIO mechanism. Yes the group-centric VFIO uAPI preven=
ts
> > > > a group of devices from attaching to multiple IOMMU contexts, but
> > > > suppose we still need a way to tell the user to not do so. Especial=
ly
> > > > such knowledge would be also reflected in the virtual PCI topology
> > > > when the entire group is assigned to the guest which needs to know
> > > > this fact when vIOMMU is exposed. I haven't found time to investiga=
te
> > > > it but suppose if such channel exists it could be reused, or in the=
 worst
> > > > case we may have the new device capability interface to convey... =
=20
> > >=20
> > > No such channel currently exists, it's not an issue today, IOMMU
> > > context is group-based. =20
> >=20
> > Interesting... If such group of devices are assigned to a guest, how do=
es
> > Qemu decide the virtual PCI topology for them? Do they have same
> > vRID or different?
>=20
> That's the beauty of it, it doesn't matter how many RIDs exist in the
> group, or which devices have aliases, the group is the minimum
> granularity of a container where QEMU knows that a container provides
> a single address space.  Therefore a container must exist in a single
> address space in the PCI topology.  In a conventional or non-vIOMMU
> topology, the PCI address space is equivalent to the system memory
> address space.  When vIOMMU gets involved, multiple devices within the
> same group must exist in the same address space.  A vPCIe-to-PCI bridge
> can be used to create that shared address space.
>=20
> I've referred to this as a limitation of type1, that we can't put
> devices within the same group into different address spaces, such as
> behind separate vRoot-Ports in a vIOMMU config, but really, who cares?
> As isolation support improves we see fewer multi-device groups, this
> scenario becomes the exception.  Buy better hardware to use the devices
> independently.

Also, that limitation is fundamental.  Groups in a guest must always
be the same or strictly bigger than groups in the host, because if the
real hardware can't isolate them, then the virtual hardware certainly
can't and the guest kernel shouldn't be given the impression that it
can separate them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbemreCsSMMcmVQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUCMYACgkQbDjKyiDZ
s5IbcQ//RRnk6578Dd3RoItAw/ouSkamizbOnDMKW7uaqK9YsPPO02q6NleujshT
GRaG2DwHv5YMH3GGLpS7zFa9iitJezuIC/0WuLH/Ypq735SPTU7NVbRpsB5ijbUR
HW06YH5mmYETGwtp+vb8zxq7AWcKk7KqlHYBjvwK8nU5Klr27m8gqth7qW5DqB0k
9uhcJZXOaFCDYMdVX1DTaOQ3TdJLf7+Rwf8gfVM3Ma1sq0jgv3rzxCz6tLqoJ0pe
pQW/yd0/iwz/tIYYWK8xB6YnT+u+ozEFJHqehdxY5yaC+c/GN8tzd4UNCJv5F0is
CTdwipKta3C9Mxzv4x1s74NkDnT6b1SSN0ZjyVA/md10KLnyRFjSxVoYh7Ab/ODk
+u70Zl2lBBScUksTyeqG5QDVa/y0T8O9b6yTsh4aY4XdtpR2FZSY/kVS6gyq0uyr
1Epw5S1E9JSmYaGuYcdaAHD3b8+HxTVvn1RfdWXcfNvhSjDrmPtmUyWnqWTo64OV
PEWuw4FcaSPDMLZMqvFFMWE2heNyWfLpzvU9ym+cgj4L6bImaY8k6jAaEu3HfWQZ
25XxtcXaWhBHrCT66YWjeqPtMZypAZCaiabGEt29+ijNqBRiaO8+tGwBtAuYiWvK
K9v+f84XO3+e+kCvEdIf0a5+Xn2N04QDnb6fs41xkCE8hasvUVQ=
=Tqsh
-----END PGP SIGNATURE-----

--VbemreCsSMMcmVQr--

--===============8716380939158912696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8716380939158912696==--
