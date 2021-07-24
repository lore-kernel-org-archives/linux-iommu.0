Return-Path: <SRS0=sT52=MQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B99C4338F
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 06:29:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B765C60E90
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 06:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B765C60E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 625AA406AB;
	Sat, 24 Jul 2021 06:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AulEv9X_XYd0; Sat, 24 Jul 2021 06:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D1F6406A9;
	Sat, 24 Jul 2021 06:29:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E812DC001A;
	Sat, 24 Jul 2021 06:29:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07060C000E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 06:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E191F406AA
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 06:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNJJZOdu-YM6 for <iommu@lists.linux-foundation.org>;
 Sat, 24 Jul 2021 06:29:25 +0000 (UTC)
X-Greylist: delayed 00:06:40 by SQLgrey-1.8.0
Received: from mail.sf-mail.de (mail.sf-mail.de
 [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89B43406A9
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 06:29:24 +0000 (UTC)
Received: (qmail 29130 invoked from network); 24 Jul 2021 06:21:54 -0000
Received: from p548c622d.dip0.t-ipconnect.de ([::ffff:84.140.98.45]:48018 HELO
 daneel.sf-tec.de) (auth=eike@sf-mail.de)
 by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted)
 ESMTPSA
 for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 08:21:54 +0200
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 21/21] dma-mapping: Disallow .map_sg operations from
 returning zero on error
Date: Sat, 24 Jul 2021 08:22:28 +0200
Message-ID: <2591613.mvXUDI8C0e@daneel.sf-tec.de>
In-Reply-To: <20210723175008.22410-22-logang@deltatee.com>
References: <20210723175008.22410-1-logang@deltatee.com>
 <20210723175008.22410-22-logang@deltatee.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============0136056911180503847=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0136056911180503847==
Content-Type: multipart/signed; boundary="nextPart11795432.O9o76ZdvQC"; micalg="pgp-sha1"; protocol="application/pgp-signature"

--nextPart11795432.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. Juli 2021, 19:50:08 CEST schrieb Logan Gunthorpe:
> Now that all the .map_sg operations have been converted to returning
> proper error codes, drop the code to handle a zero return value,
> add a warning if a zero is returned and update the comment for the
> map_sg operation.

I see no comment being touched here.

Eike
--nextPart11795432.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYPuxpAAKCRBcpIk+abn8
TmEXAJ4y9fSVV7pgh2KPWXQ4YaTcwXP08ACgkfbFqKsGtxv2IZPJJiPcxo/F4Bg=
=swGr
-----END PGP SIGNATURE-----

--nextPart11795432.O9o76ZdvQC--




--===============0136056911180503847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0136056911180503847==--



