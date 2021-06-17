Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FFC49361
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E092613B9
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E092613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 477BA83DC2;
	Thu, 17 Jun 2021 07:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYBCafoP0pk4; Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 573E883DC7;
	Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6F43C0023;
	Thu, 17 Jun 2021 07:22:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4245C002B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71D3883DC4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbDq37CYSbBQ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F43683DA3
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:11 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5W6N8xz9sWM; Thu, 17 Jun 2021 17:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914527;
 bh=nMIejQhBBbAiJzh1waEkmffz9zEoMKNNjdFKEBUdaAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LP2SrMyFZFM3lxnV0cfsJLLOZ8pFFXH4yyGOAuS/2XtiUfUx3XwCsddDp919mD57F
 XzK/GtQd1OZxlkdHpfgxnFDEZ4UL8woMDvJ38I2R8RBvX/0nRdewdAjSGYOPSFnb9v
 LpwehvlI98nioGHkuJ42banezN8EHq75C6WmjrFI=
Date: Thu, 17 Jun 2021 15:02:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YMrXaWfAyLBnI3eP@yekko>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210609101532.452851eb.alex.williamson@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6866503895776485203=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6866503895776485203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8PvddoXrk24w8n4P"
Content-Disposition: inline


--8PvddoXrk24w8n4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 10:15:32AM -0600, Alex Williamson wrote:
> On Wed, 9 Jun 2021 17:51:26 +0200
> Joerg Roedel <joro@8bytes.org> wrote:
>=20
> > On Wed, Jun 09, 2021 at 12:00:09PM -0300, Jason Gunthorpe wrote:
> > > Only *drivers* know what the actual device is going to do, devices do
> > > not. Since the group doesn't have drivers it is the wrong layer to be
> > > making choices about how to configure the IOMMU. =20
> >=20
> > Groups don't carry how to configure IOMMUs, that information is
> > mostly in the IOMMU domains. And those (or an abstraction of them) is
> > configured through /dev/ioasid. So not sure what you wanted to say with
> > the above.
> >=20
> > All a group carries is information about which devices are not
> > sufficiently isolated from each other and thus need to always be in the
> > same domain.
> >=20
> > > The device centric approach is my attempt at this, and it is pretty
> > > clean, I think. =20
> >=20
> > Clean, but still insecure.
> >=20
> > > All ACS does is prevent P2P operations, if you assign all the group
> > > devices into the same /dev/iommu then you may not care about that
> > > security isolation property. At the very least it is policy for user
> > > to decide, not kernel. =20
> >=20
> > It is a kernel decision, because a fundamental task of the kernel is to
> > ensure isolation between user-space tasks as good as it can. And if a
> > device assigned to one task can interfer with a device of another task
> > (e.g. by sending P2P messages), then the promise of isolation is broken.
>=20
> AIUI, the IOASID model will still enforce IOMMU groups, but it's not an
> explicit part of the interface like it is for vfio.  For example the
> IOASID model allows attaching individual devices such that we have
> granularity to create per device IOASIDs, but all devices within an
> IOMMU group are required to be attached to an IOASID before they can be
> used.  It's not entirely clear to me yet how that last bit gets
> implemented though, ie. what barrier is in place to prevent device
> usage prior to reaching this viable state.
>
> > > Groups should be primarily about isolation security, not about IOASID
> > > matching. =20
> >=20
> > That doesn't make any sense, what do you mean by 'IOASID matching'?
>=20
> One of the problems with the vfio interface use of groups is that we
> conflate the IOMMU group for both isolation and granularity.  I think
> what Jason is referring to here is that we still want groups to be the
> basis of isolation, but we don't want a uAPI that presumes all devices
> within the group must use the same IOASID.  For example, if a user owns
> an IOMMU group consisting of non-isolated functions of a multi-function
> device, they should be able to create a vIOMMU VM where each of those
> functions has its own address space.  That can't be done today, the
> entire group would need to be attached to the VM under a PCIe-to-PCI
> bridge to reflect the address space limitation imposed by the vfio
> group uAPI model.  Thanks,

I'm fairly sceptical of the idea of allowing the "identifiable
requestor" grouping to be different from the isolation grouping.
Certainly it's possible in hardware, but I think it makes the
interface horribly complex to understand without buying much.

"Good" modern devices on modern systems will be both fully isolated
and well identified, so for the uses cases that people seem to mostly
care about here we'll still have identification group =3D=3D isolation
group =3D=3D one device.

In other words, do we really have use cases where we need to identify
different devices IDs, even though we know they're not isolated.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8PvddoXrk24w8n4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDK12cACgkQbDjKyiDZ
s5JIqw/+Le8InXvaXY8PJqs4GLnd0hYRw12Z0I/TLdJN/Tb0dn4/aCLKUwXDe2L0
RmzpW/UurBMhJcndCukBTe5k9ylkhmifjAVHzDt+fjxc1hdwaaUWKblj8lQPzVkb
TBSFQlj9hGJ1zVYZRq1lG2Oh8CbUveiM3UP7dfaV/N0M5KhBtqdMsq/+LrF9MW0s
6d7ckET4i2UoOBVWVLO+UVx2HekQmZ6F0LJIUs45PkqusM0U5ruBsnmhCy8oNgcB
HWoICR834W0u6r8ox8QXQCpe5vvIk6RzXGc0hgWEmQCT7QHIrg6J4QqspIalkp0O
7Mm9HlgHXg/d9emXUA+kL5GvvtF84+iNjxMU9llCrCIsq24rvY1x2GhmzcyVly/9
6Rzclsze/0I3DF7oHvwlW8x6fbQ6rKDryLfeIPBrGzoyEQQmTznTkVbo/MSbilUY
q739RRgRjq9248MZJFZJ8UVYDsyfxgXglLB/8R1O/Y/q+z88W4EbX7p2tcHSQXMx
wBkdYp0oQyhpvCHIbsqPnClnwM5Ox1w640jM0aq439IchMWcd+xkumiamm1uHcu7
jkl9Gr+6qzPXAFZdpuSgKUV+HJhf3U7A/94rZlNoP75fhC9UrODKZFLmtmRymegG
w+NjcLl2mH0z1r3r0L7BE1w7eafKYOAqQF1I6VWIXnoWojHHq5w=
=CyOl
-----END PGP SIGNATURE-----

--8PvddoXrk24w8n4P--

--===============6866503895776485203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6866503895776485203==--
