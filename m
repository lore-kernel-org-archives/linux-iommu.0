Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57966C433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 20:07:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E602E61029
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 20:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E602E61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AECDA833A0;
	Sun, 11 Apr 2021 20:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DEXy-hrAKd4e; Sun, 11 Apr 2021 20:07:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B952183396;
	Sun, 11 Apr 2021 20:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93CD4C000B;
	Sun, 11 Apr 2021 20:07:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D94AC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 20:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1705E605C6
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 20:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lI6vu6nsouqc for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 20:07:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EE376058A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 20:07:45 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id e13so1468440qkl.6
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
 :date:message-id;
 bh=vVteGm197WS+Pak+/03TURfJdtAKD0/wWNPTtY/GWDI=;
 b=wDsEMJNSELb4D9d8wRNn0MbMRRWFXjdzSA7q/kyUPTt3sHrv50eaai5yZPPumSweIa
 8k4TpNFR7hd5n/U/hYnGJKKf5i2WNXrMADJ6Rj8Y1hYcxAoJzZy1toNQIiK/LsK2uqjN
 P0Ap0VXL/4IBAmXsSfE3DH6XcmAGg9K2vwkQTEY5jTdV46N/1V4N8e+ZcBjkhba2cRJ3
 3XTmKMtGmdIzxN0AOoYZTMJi8K4UYLQHfQLAT0TGPTL74HtmFg6iXerq83xQUFzwxAu7
 DS1vav5shfWwDpe4P8O2p0b4mPaUtEAo9ByGkiX1MApQr4YCviRVtvO1Q0wUuEmmGavR
 b9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:mime-version
 :content-transfer-encoding:date:message-id;
 bh=vVteGm197WS+Pak+/03TURfJdtAKD0/wWNPTtY/GWDI=;
 b=i8VeUgXVGNdVFL+A/MU50Xv8ucMWEvr8IHErA487UG28NbyQGoLBG2FO9Wzo4VlHtg
 JXwZdICnRAy2ScK+7j4AEMTGR6XcW3wYDsacU/5rQUs42lJg9B0YJImHC+LO3IDUe8Nu
 g7/jnhKFH8410gx1kxvIjBkWNHEXwZYypXEaO6fzn+vX53Oem31obDkJXyVULK5bJWPm
 MjX2O2UZ5u6d2LmqGwl5JgPT4uZH9hFRLV8ZsNiufDjHJVu17sfMRvH87r7loHLjVeiZ
 PHbozVJEKXlAjkvzAPcf7/BFuQex3k4PbIG2+qG0bA+LbfUKxgm0C+WnyqKOAp9tE9VY
 x7Cg==
X-Gm-Message-State: AOAM531VEJNl7uaqQyIjCHHwd55NW+mAWjB81Vi90VX6MfayPwOHef3k
 s1C7hFHvBz7uUr7Sg79TaM2Zsw==
X-Google-Smtp-Source: ABdhPJyAChITVeE/MPh85xPT3C4GtprBydVBUFkQXQgUgMw/idzip7Ea7PWDwcBBiq0rEPbkfjkx2Q==
X-Received: by 2002:a05:620a:110a:: with SMTP id
 o10mr1706986qkk.148.1618171664926; 
 Sun, 11 Apr 2021 13:07:44 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
 by smtp.gmail.com with ESMTPSA id h9sm6275557qtk.6.2021.04.11.13.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 13:07:44 -0700 (PDT)
From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?="
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
 Will Deacon <will@kernel.org>
Subject: next-20210409 build breakage in drivers/iommu/mtk_iommu_v1.c
Mime-Version: 1.0
Date: Sun, 11 Apr 2021 16:07:43 -0400
Message-ID: <14335.1618171663@turing-police>
Cc: iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============2511136223008717815=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2511136223008717815==
Content-Type: multipart/signed; boundary="==_Exmh_1618171662_13593P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1618171662_13593P
Content-Type: text/plain; charset=us-ascii

This commit:

commit 8de000cf0265eaa4f63aff9f2c7a3876d2dda9b6
Author: Yong Wu <yong.wu@mediatek.com>
Date:   Fri Mar 26 11:23:36 2021 +0800

    iommu/mediatek-v1: Allow building as module

changes drivers/iommu/Kcconfig

 config MTK_IOMMU_V1
-       bool "MTK IOMMU Version 1 (M4U gen1) Support"
+       tristate "MediaTek IOMMU Version 1 (M4U gen1) Support"

Unfortunately, this doesn't actually build properly as a module, because:

  MODPOST modules-only.symvers
ERROR: modpost: "of_phandle_iterator_args" [drivers/iommu/mtk_iommu_v1.ko] undefined!
make[2]: *** [/usr/src/linux-next/scripts/Makefile.modpost:150: modules-only.symvers] Error 1

There's no EXPORT_SYMBOL and drivers/of/base.o is a built-in, so
the symbol isn't available to modules.

--==_Exmh_1618171662_13593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYHNXDgdmEQWDXROgAQI3Kg//UWC6smWytHYy158jtuNo7OaHGa9t9z7H
lAii0QD95wLc+gUO/BnzXGuNubA9NdVlesFcQv2U9oIdKcAZ3fZCJPf/u8Rr97Zc
a5+au4AJza/4tYVU8z0+W/xqGU6vqv/vA7dJgyN8BbOZLD+rjHUj97ZPm23vcnd+
5NQI42xXvbCREQi9xy1JwGd+7TAZsht27XaUbU+2es69bmDfW0g3O+sDqqn6mt4+
sExSalCV+F75JENIYpPV/xd2FU7naYSngtOASLFr5jzcQmaRf0HJsplnpzdm2da+
FskOg2KzHVybqM458G6hZhoTS+Z7DGVAY/COLV35ino9JWVnfO0u9Gid0uFeQes+
VVtXumGlnTuKgIQbIIBJ3pfX6DT3tTUbgSe3Z/0eI4L4xi6yQCCS4zlwBCnl10ry
gH1sCvYC9FQivqIoEBmM3MCXG06AwEbRkEHtdhLOrFCzRq7RWaHug0yvT9QGKHWe
e34rB6PHzKKSPGMinaOyqHcLS5L0va1W5v8LSltW2xtElcqahI7eCNZXI72i2aZH
TB6APLeQqlCStsDLWGVGWBFO2c8mYH/Ww42UyI7YSTVpQOf4O7oLrkG/5d2WZqGB
8qYnaoomGsCl6Npi9wzDZ9FWK6PTa2KaovEp9EiwzA9NHVZ2OyHg5IXZBwMiz8BY
GvvNXIphQXU=
=yc6U
-----END PGP SIGNATURE-----

--==_Exmh_1618171662_13593P--

--===============2511136223008717815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2511136223008717815==--
