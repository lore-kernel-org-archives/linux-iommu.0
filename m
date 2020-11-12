Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C46C5519F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 15:56:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027F0221E9
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 15:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027F0221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 66B792E1FE;
	Thu, 12 Nov 2020 15:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H+PO7YBMtowM; Thu, 12 Nov 2020 15:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CA3B22E209;
	Thu, 12 Nov 2020 15:56:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4BB6C088B;
	Thu, 12 Nov 2020 15:56:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABF7C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 486CE86F01
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtO9XPVpEUfO for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:56:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E3E8D871B6
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:56:41 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E823CAEA3;
 Thu, 12 Nov 2020 15:56:39 +0000 (UTC)
Message-ID: <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 12 Nov 2020 16:56:38 +0100
In-Reply-To: <X6rZRvWyigCJxAVW@trantor>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 ardb@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 James Morse <james.morse@arm.com>, linux-rpi-kernel@lists.infradead.org,
 guohanjun@huawei.com, will@kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7433917973695009550=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7433917973695009550==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-M9M1vcPQLg1DUcTwNys9"


--=-M9M1vcPQLg1DUcTwNys9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Tue, 2020-11-10 at 18:17 +0000, Catalin Marinas wrote:
> On Fri, Nov 06, 2020 at 07:46:29PM +0100, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:
> > > On 03/11/2020 17:31, Nicolas Saenz Julienne wrote:
> > > > crashkernel might reserve memory located in ZONE_DMA. We plan to de=
lay
> > > > ZONE_DMA's initialization after unflattening the devicetree and ACP=
I's
> > > > boot table initialization, so move it later in the boot process.
> > > > Specifically into mem_init(), this is the last place crashkernel wi=
ll be
> > > > able to reserve the memory before the page allocator kicks in.
> > > > There
> > > > isn't any apparent reason for doing this earlier.
> > >=20
> > > It's so that map_mem() can carve it out of the linear/direct map.
> > > This is so that stray writes from a crashing kernel can't accidentall=
y corrupt the kdump
> > > kernel. We depend on this if we continue with kdump, but failed to of=
fline all the other
> > > CPUs.
> >=20
> > I presume here you refer to arch_kexec_protect_crashkres(), IIUC this w=
ill only
> > happen further down the line, after having loaded the kdump kernel imag=
e. But
> > it also depends on the mappings to be PAGE sized (flags =3D=3D NO_BLOCK=
_MAPPINGS |
> > NO_CONT_MAPPINGS).
>=20
> IIUC, arch_kexec_protect_crashkres() is only for the crashkernel image,
> not the whole reserved memory that the crashkernel will use. For the
> latter, we avoid the linear map by marking it as nomap in map_mem().

I'm not sure we're on the same page here, so sorry if this was already impl=
ied.

The crashkernel memory mapping is bypassed while preparing the linear mappi=
ngs
but it is then mapped right away, with page granularity and !MTE.
See paging_init()->map_mem():

	/*
	 * Use page-level mappings here so that we can shrink the region
	 * in page granularity and put back unused memory to buddy system
	 * through /sys/kernel/kexec_crash_size interface.
	 */
	if (crashk_res.end) {
		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
			       PAGE_KERNEL,
			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
		memblock_clear_nomap(crashk_res.start,
				     resource_size(&crashk_res));
	}

IIUC the inconvenience here is that we need special mapping options for
crashkernel and updating those after having mapped that memory as regular
memory isn't possible/easy to do.

> > > We also depend on this when skipping the checksum code in purgatory, =
which can be
> > > exceedingly slow.
> >=20
> > This one I don't fully understand, so I'll lazily assume the prerequisi=
te is
> > the same WRT how memory is mapped. :)
> >=20
> > Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
> > prerequisite.
> >=20
> > Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend=
 on
> > having the linear mappings available.
>=20
> So it looks like reserve_crashkernel() wants to reserve memory before
> setting up the linear map with the information about the DMA zones in
> place but that comes later when we can parse the firmware tables.
>=20
> I wonder, instead of not mapping the crashkernel reservation, can we not
> do an arch_kexec_protect_crashkres() for the whole reservation after we
> created the linear map?

arch_kexec_protect_crashkres() depends on __change_memory_common() which
ultimately depends on the memory to be mapped with PAGE_SIZE pages. As I
comment above, the trick would work as long as there is as way to update th=
e
linear mappings with whatever crashkernel needs later in the boot process.

> > Let me stress that knowing the DMA constraints in the system before res=
erving
> > crashkernel's regions is necessary if we ever want it to work seamlessl=
y on all
> > platforms. Be it small stuff like the Raspberry Pi or huge servers with=
 TB of
> > memory.
>=20
> Indeed. So we have 3 options (so far):
>=20
> 1. Allow the crashkernel reservation to go into the linear map but set
>    it to invalid once allocated.
>=20
> 2. Parse the flattened DT (not sure what we do with ACPI) before
>    creating the linear map. We may have to rely on some SoC ID here
>    instead of actual DMA ranges.
>=20
> 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crashkernel
>    reservations and not rely on arm64_dma_phys_limit in
>    reserve_crashkernel().
>=20
> I think (2) we tried hard to avoid. Option (3) brings us back to the
> issues we had on large crashkernel reservations regressing on some
> platforms (though it's been a while since, they mostly went quiet ;)).
> However, with Chen's crashkernel patches we end up with two
> reservations, one in the low DMA zone and one higher, potentially above
> 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkernel
> reservations than what we have now.
>=20
> If (1) works, I'd go for it (James knows this part better than me),
> otherwise we can go for (3).

Overall, I'd prefer (1) as well, and I'd be happy to have a got at it. If n=
ot
I'll append (3) in this series.

Regards,
Nicolas


--=-M9M1vcPQLg1DUcTwNys9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+tWzYACgkQlfZmHno8
x/65FAf+LLZOeUhzc95cBKLl00enpYv+BDp5WO7U6y0jRH/RYuamx56LOFGNF4gi
BG1Jkf+2jkPfyLRZ9JdivlTPmBHBnQCGGxKQVrHu72tiGJqBoX8VfW+r+r6zVqjL
pBKLB62ac3Txf7qKv2WZ83Qhir+K206E0RE7zglgCZ4RTBDgNwhz3YdF5y+nyYaw
/+EYngwjopzL5qLAAA4fw0vVyROwV8KaBL+7YjoVZnEyJvH7Wg6fabEfBRVw/WPW
EaNXBlbwCOZrnsUGsIhc419pkyZxCresF+3JTLjdgClDYvzVbUB+q25qyVmWAy4F
tKLs7M5thq3az+48jtTP7WEQm4pbxQ==
=ycwy
-----END PGP SIGNATURE-----

--=-M9M1vcPQLg1DUcTwNys9--


--===============7433917973695009550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7433917973695009550==--

