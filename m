Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFFA45
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 08:48:21 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id n12so6035471wrx.9
        for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=pkwi8nsN9NDMEjsY4MvvhMCnG4OoSO3psLEaN68e788BwWN6q9jdox1XHrguwF/rWf
         0uohS/6e5t9zS0hiDt36er3Qojp0Hao0/EYZ0buUTekrv22g+IAQhXl/aD6aV0bPcH0O
         bul1armvjAHpjbEez6cA4c3j5xQaFS5Xg5f+7itr8ZHVoms9QIXHmG7NhvqFUZeUKhMK
         +sstfbrP2ig3wiwhnlsaJr4huN846qt5SA1qJ2R/uin97XRzvsdlV7qtEC82jzlolOKC
         D+bwlxwPtICnlKZHxgv9NUGkUn3EiOIdrCWsFWLP6BGyzbEAF/swiXA+DuFkcjl8hw1w
         xxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=AUf1t2FGw3B3FXPYQ2LL0oIDEPK1GMZOpTVzMudJ3aQPRNPietMF2ix8sWiY2tVgXr
         B89sIUmBQTW08CqTEEUsYE1CeNwJgPlxPnkNc6Cfz5Fcyj3nyrsUxhETpxwmlenfRzYA
         tBJ2rR2bvUGESxyJYWGy1li6Lov6HTm50yhXRJqb6WCwEIGbz0HLEwBQYxC/1kTHEWC1
         GvFQeW1+u9vA8WkTRt3KK/DfgFpciaxtls9Nd7tOUASdZRAgQ1qdG6TPqGsa4YvKZSqW
         CY9J6V5oB6my7Vg1eRzBftNMUCVqqbdg2n+TKKEF0O9ikvHZ5cQj1IpaE7D5mvMg+g6v
         GRmg==
X-Gm-Message-State: ACrzQf2h4YzemBC53923Jtte5es17INDDxCOlnyL4wXov+o6leJgOfAC
	yXWQvA8/lcSL8j9U4pIdziY=
X-Google-Smtp-Source: AMsMyM5HeTIRifF54cDZV5YELSwKmAEMfl1TCa7MzD5pz4j0ErB/1h+iX+/jTt7GGSJhH+Pt79VWsQ==
X-Received: by 2002:a05:6000:124f:b0:228:8713:ced9 with SMTP id j15-20020a056000124f00b002288713ced9mr10175266wrx.198.1663577299621;
        Mon, 19 Sep 2022 01:48:19 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0022aeba020casm7540610wrb.83.2022.09.19.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:48:19 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after refactoring
Date: Mon, 19 Sep 2022 10:47:44 +0200
Message-Id: <20220919084744.3043-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Commit 78013eaadf69 ("x86: remove the IOMMU table infrastructure")
refactored the generic swiotlb/swiotlb-xen setup into pci-dma.c, but
misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Update the SWIOTLB SUBSYSTEM to contain the architecture-independent
pieces for swiotlb, but leave the small architecture-dependent pieces to
the architecture maintainers.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
v1: https://lore.kernel.org/lkml/20220601075613.28245-1-lukas.bulwahn@gmail.com/
v1 -> v2:
  addressed Christoph's comment, removed arch/*/kernel/pci-swiotlb.c
  added Juergen's ack

Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index babb441f7474..69d58c43bd6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19699,7 +19699,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
 F:	include/linux/swiotlb.h
 F:	kernel/dma/swiotlb.c
 
@@ -22403,8 +22402,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux.dev
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

