Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB1C43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:19:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D3E21741
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D3E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 08C4B21509;
	Mon,  7 Sep 2020 15:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G+9zvcDWfqxF; Mon,  7 Sep 2020 15:19:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D7DEA2094D;
	Mon,  7 Sep 2020 15:19:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAA1DC0859;
	Mon,  7 Sep 2020 15:19:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAD2AC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D523E86F76
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHXLiwN5XKvq for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 15:19:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 274E286F78
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:19:08 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2B8CEB6FB;
 Mon,  7 Sep 2020 15:19:07 +0000 (UTC)
Message-ID: <d23837ac7e077625ffbb8d34bf3c8f999c338f0e.camel@suse.de>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 07 Sep 2020 17:18:59 +0200
In-Reply-To: <20200901082429.GA1440@lst.de>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200901082429.GA1440@lst.de>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR
 \(REMOTEPROC\) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, "open
 list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE" <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:USB
 SUBSYSTEM" <linux-usb@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============0872648441524075965=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0872648441524075965==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7ynDZbhKR8WXoCauQUzC"


--=-7ynDZbhKR8WXoCauQUzC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph, a small fix to your fixes:

On Tue, 2020-09-01 at 10:24 +0200, Christoph Hellwig wrote:
> I've applied this to the dma-mapping tree.
>=20
> I had to resolve a conflict in drivers/of/address.c with a recent
> mainline commit.  I also applied the minor tweaks Andy pointed out
> plus a few more style changes.  A real change is that I changed the
> prototype for dma_copy_dma_range_map to require less boilerplate code.

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b5f8d62f251..4cd012817af6 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -610,7 +610,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *par=
ent,
         * mask for the entire HCD, so don't do that.
         */
        dev->dev.dma_mask =3D bus->sysdev->dma_mask;
-       if (!dma_copy_dma_range_map(&dev->dev, bus->sysdev))
+       if (dma_copy_dma_range_map(&dev->dev, bus->sysdev))
                dev_err(&dev->dev, "failed to copy DMA map\n");
        set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
        dev->state =3D USB_STATE_ATTACHED;

Regards,
Nicolas


--=-7ynDZbhKR8WXoCauQUzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9WT2MACgkQlfZmHno8
x/5q5Qf+OmaWcIzrt/lcS25wejqy5pTxhDjSytNTrN8Gxzv5pMXBnbZRXkBlG2Is
+0Q8A2byliMTtdy3KKax7cglRDXrgoWj+uae9Fv3bYkr7OFvpRfNguEU0kzibabA
Mse73yBnaRQZZfRZplvez4tTYp8LYF2KBT70V6o9YJmHqyK/XMs5YolSDE4YUdxj
GdSH5FGrBoPWhtgMMANzJu9aozbAG1SE1cpHQT/CSQ8ihRiFiaVCzpDEQKFnKdhg
0QYUajzkg8sN3fKFIBr2gQbwgblg9K2A2YRjAYPiuCerOqQ5RGtv8cu/m6E045Sh
aC6pJKqrIwYTwc2vFS/xwQnFpMYcYA==
=oOCe
-----END PGP SIGNATURE-----

--=-7ynDZbhKR8WXoCauQUzC--


--===============0872648441524075965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0872648441524075965==--

