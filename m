Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B17CC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 17:28:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A41D207DD
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 17:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A41D207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE9CA86366;
	Wed, 27 Nov 2019 17:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brJzGJFp1y3v; Wed, 27 Nov 2019 17:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 481768625E;
	Wed, 27 Nov 2019 17:28:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E72C1DDA;
	Wed, 27 Nov 2019 17:28:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA909C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D8FC220396
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h4Y3exjoE1TO for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 17:28:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A8DA20035
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:28:41 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 25895AF22;
 Wed, 27 Nov 2019 17:28:39 +0000 (UTC)
Message-ID: <eccd6a23d8dbc577058c538fa4ef79ba376cd04a.camel@suse.de>
Subject: Re: [PATCH v3 0/7] Raspberry Pi 4 PCIe support
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 27 Nov 2019 18:28:35 +0100
In-Reply-To: <20191126215020.GA191414@google.com>
References: <20191126215020.GA191414@google.com>
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, f.fainelli@gmail.com,
 linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org, maz@kernel.org,
 phil@raspberrypi.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
 james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============3754805634034659696=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3754805634034659696==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-LD8Ga7xd6xkOxp2WErAx"


--=-LD8Ga7xd6xkOxp2WErAx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Tue, 2019-11-26 at 15:50 -0600, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2019 at 10:19:38AM +0100, Nicolas Saenz Julienne wrote:
> > This series aims at providing support for Raspberry Pi 4's PCIe
> > controller, which is also shared with the Broadcom STB family of
> > devices.
> > Jim Quinlan (3):
> >   dt-bindings: PCI: Add bindings for brcmstb's PCIe device
> >   PCI: brcmstb: add Broadcom STB PCIe host controller driver
> >   PCI: brcmstb: add MSI capability
>=20
> Please update these subjects to match the others, i.e., capitalize
> "Add".  Also, I think "Add MSI capability" really means "Add support
> for MSI ..."; in PCIe terms the "MSI Capability" is a structure in
> config space and it's there whether the OS supports it or not.
>=20
> No need to repost just for this.

Noted, I'll update them.

Regards,
Nicolas


--=-LD8Ga7xd6xkOxp2WErAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3eskMACgkQlfZmHno8
x/60Swf/Rwz7o3DibuLSdZZBrCQ9sK0AToOIKPKSSquZNgW7MKr1ByJjnNAS9/4r
9N3namc6tZJcCE7C+QKKVcikyMR0ENUSovq0hrCA6WCiUipefFyD22H/WEtsWvHf
1QcGifBBN6mjLDS1DSnBTPiDAVqWm5w1celUlauXFZAZc5YQftSwRQRVkZui2q9H
aljeQuVsPZ+CfdOFgqo1xlwJvk+BbfDIxgQ+cg4du/tS3enlrrMspevtkEw/awv9
aZl62mLNRTUPlsHW07akov+GIKROrknLnBTqiCKLg0Ei7J3dTo3Su/wzSyZQw7H4
hOq7QZ/9Qezc3LUiCtuauS3v8a6ang==
=dKU6
-----END PGP SIGNATURE-----

--=-LD8Ga7xd6xkOxp2WErAx--


--===============3754805634034659696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3754805634034659696==--

