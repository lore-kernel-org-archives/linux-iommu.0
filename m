Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4D5C3A5A7
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2D52077B
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 20C76D09;
	Tue,  3 Sep 2019 15:43:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA48DCAF
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 15:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 030FF831
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 15:43:56 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id DF1D8AB91;
	Tue,  3 Sep 2019 15:43:54 +0000 (UTC)
Message-ID: <cf743e0a1571c1748588f088cfd9804e8b55c36b.camel@suse.de>
Subject: PCIe DMA addressing issues on Raspberry Pi 4
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh+dt@kernel.org>, "robin.murphy" <robin.murphy@arm.com>
Date: Tue, 03 Sep 2019 17:43:52 +0200
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	mbrugger <mbrugger@suse.com>, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6280466402032068936=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6280466402032068936==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-VNc7oUE10RoRira+Huej"


--=-VNc7oUE10RoRira+Huej
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, sorry for the long read, I kept it as short as possible.

So, the wrapper around the PCIe block available on the Raspberry Pi 4 has a=
 bug
preventing it from accessing anything beyond the first 3G of ram [1]. I'm
trying to figure out the best way to integrate this upstream.

Note that the only thing behind the PCIe bus is an USB3 chip. The bus is no=
t
exposed to users directly.

I see two options:

- Isolate the PCIe block on it's own interconnect. IMO this could be accept=
able
  as it's arguable that the bug is not really in the PCIe block.  I set the
  interconnect's dma-range size to 2GB instead of 3GB as dma masks don't pl=
ay
  well with non power of two DMA constraints:

  buggy-scb {
	compatible =3D "simple-bus";
	dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0x800000000>;

	pcie {
		compatible =3D "brcm,bcm2711-pcie";
		dma-ranges =3D <0x02000000 0x0 0x00000000 0x0 0x00000000
			      0x1 0x00000000>;
		[...]

	};
  };

  scb {
	compatible =3D "simple-bus";
	dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0xfc0000000>;

	eth0 {
		[...]
	};

	[...]
  };

  With this setup the PCIe devices should behave correctly as long as they
  don't play with their own DMA masks.

- Configure PCIe's inbound view of memory taking into account the buggy
  interconnect:

  scb {
	compatible =3D "simple-bus";
	dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0xfc000000>;

	pcie {
		compatible =3D "brcm,bcm2711-pcie";
		dma-ranges =3D <0x02000000 0x0 0x00000000 0x0 0x00000000
			      0x0 0x80000000>;
		[...]

	};

	eth0 {
		[...]
	};

	[...]
  };

  The downside of this is that of_dma_configure() doesn't play well with PC=
I
  devices. of_dma_configure() expects a device's OF node, yet the PCI core
  passes the bridge's OF node, as the device has none. The result is
  of_dma_configure() ignores PCI's dma-ranges. Solving this is not trivial.
  IMO the simplest solution would be to create a distinct OF node on PCI
  bridges, child of the actual PCI root complex.  FYI this was already an i=
ssue
  some years ago [2].

  This solution also suffers from devices setting their own DMA masks.

If you're curious abot the downstream kernel, they use their custom buffer
bouncing code, which AFAIK is something we're trying to get rid of.

Any comments? Alternative solutions?

Thanks,
Nicolas

[1] https://www.spinics.net/lists/arm-kernel/msg740693.html
[2] https://patchwork.kernel.org/patch/9650345/#20294961


--=-VNc7oUE10RoRira+Huej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1uijgACgkQlfZmHno8
x/4ncwf/bFv3AD0ndtH89sJxuLuYsOfE/0zdO83AOPyEGnYUEp8yPyov0zO43okd
oQ2rfzZl8jALpzSy936hXZIIcJmWuOaTApRMaf14Rumq/RKR1zIG5e69ZlTskd5s
/ar4nASgz8/9ShY6LASonoXaTSSkbsOEWhBJPQjrS4Rf/Q9ggnLuzapHI6pDGdrJ
9DupdCcl7v1+Mfa+erRSGYrNgPWMnt85PaVQT2I+ICwc0UDWDND2hgIbuHsxnBre
1JFn0x26TIpqUCqegsZxOJOjNCQS+bTvoYzoi/xAhyuMMt+DFR7Jhk+l1TRrB/qs
x7bWu1wcIdB+gfhyeOrJUjm2qd5nFw==
=f55V
-----END PGP SIGNATURE-----

--=-VNc7oUE10RoRira+Huej--


--===============6280466402032068936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6280466402032068936==--

