Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E6C433B4
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9239613BE
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9239613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C3B4185D;
	Fri, 21 May 2021 06:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cm2EY6Yk3jq4; Fri, 21 May 2021 06:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6454185B;
	Fri, 21 May 2021 06:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7FF9C000D;
	Fri, 21 May 2021 06:53:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C54C2C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B45DC4185C
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDeMfpxkhu5P for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 06:53:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFC544185B
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:27 +0000 (UTC)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 6BAB06051C;
 Fri, 21 May 2021 08:53:25 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
Date: Fri, 21 May 2021 08:53:22 +0200
Message-ID: <1889881.5hqWi3GpDC@devpool47>
Organization: emlix GmbH
In-Reply-To: <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
References: <1716403.SmlLz2RZUD@devpool47>
 <17411490.HIIP88n32C@mobilepool36.emlix.com>
 <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============6652993772268634502=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6652993772268634502==
Content-Type: multipart/signed; boundary="nextPart3163522.BJEOxDOq7s"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3163522.BJEOxDOq7s
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
Date: Fri, 21 May 2021 08:53:22 +0200
Message-ID: <1889881.5hqWi3GpDC@devpool47>
Organization: emlix GmbH
In-Reply-To: <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
References: <1716403.SmlLz2RZUD@devpool47> <17411490.HIIP88n32C@mobilepool36.emlix.com> <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>

Am Donnerstag, 22. April 2021, 07:34:17 CEST schrieb Lu Baolu:
> Hi Rolf,
>=20
> On 4/22/21 1:39 PM, Rolf Eike Beer wrote:
> > iommu_device_sysfs_add() is called before, so is has to be cleaned on
> > subsequent errors.
> >=20
> > Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_devic=
e")
> > Cc: stable@vger.kernel.org # 4.11.x
> > Signed-off-by: Rolf Eike Beer <eb@emlix.com>
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Ping. Who is going to pick this up, please?

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart3163522.BJEOxDOq7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYKdY4gAKCRCr5FH7Xu2t
/ACxBADM0v8DMoBMsSIwqGZQTN5UG8+C8zbDs8rpd6pngku/cGNYaHVKaiq9oG41
hXUJEJJVYru+33WKfYb6yLgDogvf7qclfBwqK3Wz180G2nxCqfZ9yAxz4VCexuvY
bYUpOruM3oSwnt+j5WDIBANdct//q1fNc9BDPJgROZ7fws16Dg==
=OzhT
-----END PGP SIGNATURE-----

--nextPart3163522.BJEOxDOq7s--




--===============6652993772268634502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6652993772268634502==--



