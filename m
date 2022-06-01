Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FFCC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0032441716;
	Wed,  1 Jun 2022 07:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_8WYBYvYudI; Wed,  1 Jun 2022 07:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CAD140341;
	Wed,  1 Jun 2022 07:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E42CC0039;
	Wed,  1 Jun 2022 07:56:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68705C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 483E260BFB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsCO06HZQz9E for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:56:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB07160AC0
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:56:30 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id e2so1169301wrc.1
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=Ckm/CNVIe8mJbLbjc1YMyZFHXRScklb7wbzs7EWiK/E=;
 b=Yzat/dwf/AM2htMHXoX8ZrBghDOu9mKHXzc5MFAu5+QDok8BgPTIYAjFXOR2OXZDA4
 6fa7lTHTG7f2t11AkCCBD7C6HFRrIz20d7/BuIDbX/DuWcYL0S0wkh0EGJi5jBc6ktkj
 m0FB/tvuT3D5ZxHrmq26AsXChgNqViQh4a0TkeT/PxgCZ1aj74xvQ4+EhLosRsd7HbhT
 Naw233YPyrpt61pYVfUczchi/g5OBG0Lt7mZ9QOkpvbZJAxXZ2oLiIu8ZbSvyTICQgTf
 F8zBDcFRL4GW7Te3LOqFkserLUHzvltgfeTWq57alR3KAImTN0UwZA1IU+9ma7eQlOT4
 Tb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ckm/CNVIe8mJbLbjc1YMyZFHXRScklb7wbzs7EWiK/E=;
 b=dkzrLO5zh69GiA+dvz6PGDKL6C5d1wqnvff+VGQi3Lc6dWK7mw79dLmC7cjcGvfurm
 4oCpowtaw9e+kQBmS4PTY+j/4CgZgnpUgAAymTICBkxbbG/cytPXFdWCokStwzeNrtRK
 xXPix6+NJsHpccSzQyaP2LX0aenoTPVelATdBRGc2G9aD7NmeVAAZjcwhwUqJbOT2t+g
 OQ3oyKcjv8v/CeOMlKImGtbk2JHtO4P/Uz5NAhup/NZIjX6Z1eqkKkt+FdZE0y9Sfe6e
 4S7KKOaKOgiZl5LIwcV3bzU1sFr/oQoJ7020PXzbVuAPYVcth5A9DKW1BnVRqrpcGW2o
 A08A==
X-Gm-Message-State: AOAM531j5HK1G7UJ/7N4yl2726ZBVPcj5tqfxT6xK/Vl4o//vSSXg9x/
 v7WwlCXLCDpyOR9bhK92DBw=
X-Google-Smtp-Source: ABdhPJw3jqa+s4fKLgdH9oRW96bVnODow/HsEpnjT5TE5pv0Rn52ACPvxIFOieMcuj+vYFblfcImlw==
X-Received: by 2002:a5d:4e86:0:b0:210:1f1d:978e with SMTP id
 e6-20020a5d4e86000000b002101f1d978emr19751278wru.172.1654070189022; 
 Wed, 01 Jun 2022 00:56:29 -0700 (PDT)
Received: from felia.fritz.box
 (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de.
 [2001:16b8:2620:c000:28af:8878:8fa7:d286])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0039744bd664esm4686686wmq.13.2022.06.01.00.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jun 2022 00:56:28 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux-foundation.org
Subject: [PATCH] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after
 refactoring
Date: Wed,  1 Jun 2022 09:56:13 +0200
Message-Id: <20220601075613.28245-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Juergen Gross <jgross@suse.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kernel-janitors@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit 78013eaadf69 ("x86: remove the IOMMU table infrastructure")
refactored the generic swiotlb/swiotlb-xen setup into pci-dma.c, but
misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Update the SWIOTLB SUBSYSTEM to include arch/x86/kernel/pci-dma.c, which
contains the swiotlb setup now and drop the file pattern that does not
match any files.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5ea4ef223f8..cc12a3aaad45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19166,7 +19166,7 @@ L:	iommu@lists.linux-foundation.org
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
+F:	arch/x86/kernel/pci-dma.c
 F:	include/linux/swiotlb.h
 F:	kernel/dma/swiotlb.c
 
@@ -21831,8 +21831,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux-foundation.org
 S:	Supported
-F:	arch/x86/xen/*swiotlb*
-F:	drivers/xen/*swiotlb*
+F:	arch/*/include/asm/xen/swiotlb-xen.h
+F:	drivers/xen/swiotlb-xen.c
+F:	include/xen/arm/swiotlb-xen.h
+F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
 C:	irc://irc.oftc.net/xfs
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
