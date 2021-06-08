Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F6C4743E
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0966C61287
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0966C61287
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D667060793;
	Tue,  8 Jun 2021 06:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXmf-bQg247y; Tue,  8 Jun 2021 06:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FAF8606B1;
	Tue,  8 Jun 2021 06:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D3BC000D;
	Tue,  8 Jun 2021 06:54:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED19C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FFB083279
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DxPhOomBYjBj for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 06:54:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA2C98318C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:35 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fzgvs2glGz9sWF; Tue,  8 Jun 2021 16:54:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623135273;
 bh=9NveCRioFHeEPrm1ZC24JtZPBHGFHQFr+VmZjDZpTsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W+ROdnGgmA5lXcwqruJxvUC86sE2uuS2o1rQWZfYHpLBqmQt+lwLs1czgOD+LVwu2
 b7z4eNa4FG7Du86oOFQzkP3bgFmnoIcEPXhY3Fe7TzH/SIMJeZdfViCAON5yDQVraQ
 xmr/z5AICfFHDJ120xhcz9CbxvwomhI69SnHUZjs=
Date: Tue, 8 Jun 2021 16:31:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL8O1pAlg1jtHudn@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <YLn/SJtzuJopSO2x@myrica>
MIME-Version: 1.0
In-Reply-To: <YLn/SJtzuJopSO2x@myrica>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5279121583608117625=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5279121583608117625==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G6gzn+uk31nVASOH"
Content-Disposition: inline


--G6gzn+uk31nVASOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 12:24:08PM +0200, Jean-Philippe Brucker wrote:
> On Thu, Jun 03, 2021 at 03:45:09PM +1000, David Gibson wrote:
> > > > But it would certainly be possible for a system to have two
> > > > different host bridges with two different IOMMUs with different
> > > > pagetable formats.  Until you know which devices (and therefore
> > > > which host bridge) you're talking about, you don't know what formats
> > > > of pagetable to accept.  And if you have devices from *both* bridges
> > > > you can't bind a page table at all - you could theoretically support
> > > > a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> > > > in both formats, but it would be pretty reasonable not to support
> > > > that.
> > >=20
> > > The basic process for a user space owned pgtable mode would be:
> > >=20
> > >  1) qemu has to figure out what format of pgtable to use
> > >=20
> > >     Presumably it uses query functions using the device label.
> >=20
> > No... in the qemu case it would always select the page table format
> > that it needs to present to the guest.  That's part of the
> > guest-visible platform that's selected by qemu's configuration.
> >=20
> > There's no negotiation here: either the kernel can supply what qemu
> > needs to pass to the guest, or it can't.  If it can't qemu, will have
> > to either emulate in SW (if possible, probably using a kernel-managed
> > IOASID to back it) or fail outright.
> >=20
> > >     The
> > >     kernel code should look at the entire device path through all the
> > >     IOMMU HW to determine what is possible.
> > >=20
> > >     Or it already knows because the VM's vIOMMU is running in some
> > >     fixed page table format, or the VM's vIOMMU already told it, or
> > >     something.
> >=20
> > Again, I think you have the order a bit backwards.  The user selects
> > the capabilities that the vIOMMU will present to the guest as part of
> > the qemu configuration.  Qemu then requests that of the host kernel,
> > and either the host kernel supplies it, qemu emulates it in SW, or
> > qemu fails to start.
>=20
> Hm, how fine a capability are we talking about?  If it's just "give me
> VT-d capabilities" or "give me Arm capabilities" that would work, but
> probably isn't useful. Anything finer will be awkward because userspace
> will have to try combinations of capabilities to see what sticks, and
> supporting new hardware will drop compatibility for older one.

For the qemu case, I would imagine a two stage fallback:

    1) Ask for the exact IOMMU capabilities (including pagetable
       format) that the vIOMMU has.  If the host can supply, you're
       good

    2) If not, ask for a kernel managed IOAS.  Verify that it can map
       all the IOVA ranges the guest vIOMMU needs, and has an equal or
       smaller pagesize than the guest vIOMMU presents.  If so,
       software emulate the vIOMMU by shadowing guest io pagetable
       updates into the kernel managed IOAS.

    3) You're out of luck, don't start.
   =20
For both (1) and (2) I'd expect it to be asking this question *after*
saying what devices are attached to the IOAS, based on the virtual
hardware configuration.  That doesn't cover hotplug, of course, for
that you have to just fail the hotplug if the new device isn't
supportable with the IOAS you already have.

One can imagine optimizations where for certain intermediate cases you
could do a lighter SW emu if the host supports a model that's close to
the vIOMMU one, and you're able to trap and emulate the differences.
In practice I doubt anyone's going to have time to look for such cases
and implement the logic for it.

> For example depending whether the hardware IOMMU is SMMUv2 or SMMUv3, that
> completely changes the capabilities offered to the guest (some v2
> implementations support nesting page tables, but never PASID nor PRI
> unlike v3.) The same vIOMMU could support either, presenting different
> capabilities to the guest, even multiple page table formats if we wanted
> to be exhaustive (SMMUv2 supports the older 32-bit descriptor), but it
> needs to know early on what the hardware is precisely. Then some new page
> table format shows up and, although the vIOMMU can support that in
> addition to older ones, QEMU will have to pick a single one, that it
> assumes the guest knows how to drive?
>=20
> I think once it binds a device to an IOASID fd, QEMU will want to probe
> what hardware features are available before going further with the vIOMMU
> setup (is there PASID, PRI, which page table formats are supported,
> address size, page granule, etc). Obtaining precise information about the
> hardware would be less awkward than trying different configurations until
> one succeeds. Binding an additional device would then fail if its pIOMMU
> doesn't support exactly the features supported for the first device,
> because we don't know which ones the guest will choose. QEMU will have to
> open a new IOASID fd for that device.

No, this fundamentally misunderstands the qemu model.  The user
*chooses* the guest visible platform, and qemu supplies it or fails.
There is no negotiation with the guest, because this makes managing
migration impossibly difficult.

-cpu host is an exception, which is used because it is so useful, but
it's kind of a pain on the qemu side.  Virt management systems like
oVirt/RHV almost universally *do not use* -cpu host, precisely because
it cannot support predictable migration.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G6gzn+uk31nVASOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC/DtQACgkQbDjKyiDZ
s5KJBQ/+L7W1Y9Y46BN23tHtdVkd5CoHSGXWktgg7elcMvGxgFt0BEM7+chyKrU6
H+NUhjBvDJpE+VlzuwgfcSroHXcPQ8PZN3PkQj9UXkDkyFjcgFW6gTSXiRxXz8PG
T/9U09w1f0Q7qzA7wNZ+m30ir+Y0YeTBxW05rT6cxi9702D26fJ0sZX08n4udAj8
OY/b5sR5eZ6gdByW2DN8HJImD90Yd2oPVVJhNbbADeSXDKmTxLoE0edccyfMQusK
pRpKfNeqTOqjBJ3IminSOrlPA2aF7GkHZtV1EKGNSTZw9qv5IgsF/AfJNqWkd3h3
/lm5PLyGtE3DqBrcj80CJxq+gUz9yQvs8DMi9uU6RTiwoNo2kf7ntmONy7K3kc4o
VRO+IZ6V4kCbIZLxDHzDJfM+zPfadyR2v7ckGiMzDeXRQiyqDoI1+x36lTwGC+Zv
IDPHawZ0vRbXffLwPl8hcIciZZgXeC1zsk3qPgF302TgrBwf4zKFuDXlD7YX8GyM
zh4eY73c7S2Hnj+c9vjfnGjeLO8Ptp5Pq2NwbU9NORFrEWLkPKtJFTBsca2C//6P
60KLN0QM2ZbI3CJhErOm7NoeUOALgfEZppa1h6Q8NfbQYfRRunvVovJ6507KmJq4
yGJUK9KFa4ZBKCk8h+c/dvylcKzJ8ePt9Iaj5JImNq7c62ZBIqk=
=OnJz
-----END PGP SIGNATURE-----

--G6gzn+uk31nVASOH--

--===============5279121583608117625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5279121583608117625==--
