Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A62C10DCE
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 09:47:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A398D20674
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 09:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A398D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lespocky.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 742AB887F9;
	Wed, 18 Mar 2020 09:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nj3M0x51Mj4F; Wed, 18 Mar 2020 09:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0F09887EF;
	Wed, 18 Mar 2020 09:47:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F1EC07FE;
	Wed, 18 Mar 2020 09:47:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B0FDC013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 09:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EBED386D84
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 09:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WfVDIbRCtFEN for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 09:47:24 +0000 (UTC)
X-Greylist: delayed 00:05:27 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5BF4A86C9B
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 09:47:24 +0000 (UTC)
Received: from methusalix.internal.home.lespocky.de ([92.117.32.245]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MY60J-1imdCT1A5d-00YNg1; Wed, 18 Mar 2020 10:41:16 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
 by methusalix.internal.home.lespocky.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <post@lespocky.de>)
 id 1jEVCK-00056W-AI; Wed, 18 Mar 2020 10:41:13 +0100
Date: Wed, 18 Mar 2020 10:41:11 +0100
From: Alexander Dahl <post@lespocky.de>
To: x86@kernel.org
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200318094110.avr3zlsfti5yieyj@falbala.internal.home.lespocky.de>
Mail-Followup-To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>
References: <20200302181612.20597-1-post@lespocky.de>
MIME-Version: 1.0
In-Reply-To: <20200302181612.20597-1-post@lespocky.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: e8c5bd5a54e3cc84f9f74fb02e158981
X-Provags-ID: V03:K1:beBTNnE927QP+aKFJHcxblVneBTl0bSAcbYVv30H9JrDXwVVd89
 NLz6wJn/Pq58n10Z4+nUsOH5YKqiKur6qGO9tMOHm3UjiLK4XPv5HKy9k+adImN+BED3fG0
 9LucvGa0amgKZz+DtahkOZ7QSK7Ech9GjKrUST1Y0oJroSGSoFzZ6zBP7BYWnt9XO+mqwCM
 olrX/Q7iW96l+mF6aWL2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cy7bBkH8eI0=:Fs5HUz3JxpYzs0FybeHLik
 EdOSJzx7Z5YkMcr80RhD78ECpNG+YW3Mg9GyUmNwrYx8q1bxvX1jEtQMXyM5BpeVhNnMjX8o4
 ZtfEVJXqZgCOKWaJNigmBYwqW83BOJOIstJZcmwiLyyA0J/LWM33X4DqUTyH9haicy+xfAzgp
 1utYk3zUjvt2Rq/mXhqf8l5NZzj9IIDmVn8ISe2eHV5ptEk15ojDH/uNzIYXRPfeTHEngmmha
 3al/1Mg0C97IpQm0/6HQZzzawleNnjhs7XwehRnCe2Nl/6k0jaydltf6QCm3gff3j/sZlm+1y
 o662O+FwIIzs3NMNXbfXuq2+gE95Z4s+HZEZEwIeIFOzUP+Uog6fUiE/Bd/k+J2/NvFlwX9Nz
 RcWPD0mliSm9DrVNT0qbLtcvZTX3Hvw33WO6959gjb2z7NBDOiY95ZFdOwRIyp2/45ujfDsnP
 Bw/rGmuBlOxLyFSWHXzrA4S3X2YfsZ1AuzmIFrKuK69IpAhXjdywGgCIsS6joEE3p4vTnITT3
 LAfH30mRrgLG2/W0Mobcutq0w95snfMbUewjmoAkPmct4kGmWVHfz/etQSAtH5goNgA9TYSpI
 3ONfPjUc0fzmZMmWl7oKV3NYdQoElY58+J5fN+oseksR7bZewfcqKuN4bUyJYQEROe6YlxXrd
 EjocKdpp2MlhoszXJQfyMP1oPW8T5Ky9zVMVtMAhabb6XW0Ghjvm5JU/wpNv7TwxZ28P9hxmY
 SPKzfaWXTk14rMqS4AnGcyXqIqnn0brDW/UYUV1o09owiKNUq2B/TSOOsmeAQ+wnfoCmWke5r
 gUEybCOvNMRtltIVlMznQj/5Elehy5G+CLSdAzkup9h6gVhC5xM3L+N3AnxQEgFwxcFzrkZ
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alexander Dahl <post@lespocky.de>
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
Content-Type: multipart/mixed; boundary="===============6122964143948755024=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6122964143948755024==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ic722qmmebqodye4"
Content-Disposition: inline


--ic722qmmebqodye4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

gentle ping on this patch from two weeks ago. Did anyone have time to
look into it? Did I miss someone in Cc or sent it to the wrong lists
maybe?

On Mon, Mar 02, 2020 at 07:16:12PM +0100, Alexander Dahl wrote:
> For ARCH=3Dx86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
> ("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
> a dependency on CONFIG_SWIOTLB, which was not necessarily active before.
>=20
> The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
> something against MAX_DMA32_PFN to decide if it should be active.
> However that define suffers from an arithmetic overflow since
> 1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
> first made visible to x86_32.
>=20
> The effect is at boot time 64 MiB (default size) were allocated for
> bounce buffers now, which is a noticeable amount of memory on small
> systems. We noticed this effect on the fli4l Linux distribution when
> migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
> ALIX 2D3 with 256 MiB memory for example:
>=20
>   Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroo=
t 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
>   =E2=80=A6
>   Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660=
K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highme=
m)
>   =E2=80=A6
>   PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>   software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)
>=20
> The initial analysis and the suggested fix was done by user 'sourcejedi'
> at stackoverflow and explicitly marked as GPLv2 for inclusion in the
> Linux kernel:
>=20
>   https://unix.stackexchange.com/a/520525/50007
>=20
> Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
> Fixes: https://unix.stackexchange.com/q/520065/50007
> Suggested-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Signed-off-by: Alexander Dahl <post@lespocky.de>
> ---
> We tested this in qemu and on real hardware with fli4l on top of v5.4,
> v5.5, and v5.6-rc kernels, but only as far as the reserved memory goes.
> The patch itself is based on v5.6-rc3 (IIRC).

We had no complaints of our fli4l users, since we applied this patch
to our distribution kernels.

Thanks & greets
Alex

>=20
> A quick grep over the kernel code showed me this define MAX_DMA32_PFN is
> used in other places as well. I would appreciate feedback on this,
> because I can not oversee all side effects this might have?!
>=20
> Thanks again to Alan who proposed the fix, and for his permission to
> send it upstream.
>=20
> Greets
> Alex
> ---
>  arch/x86/include/asm/dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> index 00f7cf45e699..e25514eca8d6 100644
> --- a/arch/x86/include/asm/dma.h
> +++ b/arch/x86/include/asm/dma.h
> @@ -74,7 +74,7 @@
>  #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> =20
>  /* 4GB broken PCI/AGP hardware bus master zone */
> -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> +#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))
> =20
>  #ifdef CONFIG_X86_32
>  /* The maximum address that we can perform a DMA transfer to on this pla=
tform */
> --=20
> 2.20.1

--=20
/"\ ASCII RIBBON | =C2=BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=C2=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--ic722qmmebqodye4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl5x7LEACgkQNK3NAHIh
XMaF3xAAp8sNaWZsUbnNjftUCPAj9ymsbuY/vafpAsck9ijxVFpseaSQaGpiyobF
xF9E3fFvTJIqI1kkRizNUKp3CYrygmgqkVitwgQk6cAFyAtiIZnTvbrHqdSRBN26
lgnuXnRcpJvYIe5M4LStj++QgV1UavVowuEtJkilKG3zdoV5oGuUJdmbp9YMm2yb
Z6ysEKBlL26aOjJHepN7uQj//hkCKsyZuz22gmAgUKlWXgzhKgDI95NfaPbQwxft
pzGa0GFhuhw3a4bjlpZ4uWOb2NR9a8md5ml5TUWouj97tw73vJ6zwRpwn40fqSJQ
HGmCkN3Qzqd+RKzC4YPr4ZRd9p5oIvd9mKEe3Q8DCMaAdv1itu5yfWsA4CtgESaX
LUSLslE5rdEnob3YXZ3FhNe5Tuea0ayrFIpKUPZmAgnsGLKxpuGEWpHDSX+G3zTa
Z3wvzJ0LMPmCrgFXmg9jrgNC7MUNwb6IYgPzcM2WV8QRsYH0MGYsMAia288tEPz/
ynxfr3lDHDYWjccUyHBarh6UmkeZ9QbXSmE+aFZk32PQT2XqmzTNVTKwD26O2eiR
b6s9K5qmtojPncvhu0uPCE63nu23+/C7HlyxETktaB6WTqoQNRCUyM8QGD3s1dxe
NL+0rwGbDa8GYfxXlUrv4TRwucNsRjsMVLWMlU7ybVnrfeUsFbg=
=Ijam
-----END PGP SIGNATURE-----

--ic722qmmebqodye4--

--===============6122964143948755024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6122964143948755024==--
