Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAC2902
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 10:00:28 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id lc7so19991819ejb.0
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hiz8j1ueWdpy1uTExZ+MoWZWMdqOcerL2IyS7vev/Lo=;
        b=qve8F367vri9vq2lNgPzzRwLYLQxb4ZdSpnBQTTL3sibXPY22aLAjYVTCNNfQ0UIY6
         UTyii6rVby5uvqqz48Leh7jQKfCazE0bn/1rSUdcfZClCza1CCIlbV6j0ejDjYqgduxx
         1nLfxzcz3u+oKQu4jdJpqsF/k1rU3852PwU0YkGR+9VpeRSwO4dsAn+p18sJbtykzS5p
         hryazIZMHBz//afiNf6gbWpi0lCSvAj4ZDKqTrmDNIPowqPOx1YvPHal1LlR/s2j0UjR
         sjm0AO+9mS2J9ygnNNUNkqeuWnPN5xVinCG7U7Em3EbnhaI90WLm0++wtrqlvzhW2zRN
         Mqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hiz8j1ueWdpy1uTExZ+MoWZWMdqOcerL2IyS7vev/Lo=;
        b=1kRuchEACPQwv1w5ot2AYt6wK6WA146krtLItTDxnIFbG3U0WYrhDloUhxZdhZ6Vz1
         OwZI2Z+t74pWUnmfe05ZFRHotvRYYZ0AxCh4pQmn4rhH4Gf+ljzpJIL4Y0hACXkPLajA
         NVazlqofp89+qH3EQ+7k62oGuRomj2metHkm0SQ5aaiVeJTZzxrBdQaEtHxbDFC44lvo
         quU3Uy7oKIPnHdUmK2S2kpSF5Ma8HOWVsZzJCLbX6eFMIlhp+HrRVRpKC1a/uOGb4Iof
         UX2lsl+PuybkQXoJLAqaXvj1XlRQhdDD1rpR1YJeaW2nv3N8zzC58NMHmdkRHKXxDnq7
         j+8Q==
X-Gm-Message-State: ACrzQf3pLNwpkM+sBDqjXySsi22Jw3tUzv90BDd3+P/wYeJ+hJcAKXuR
	26Evao1JsignyoXGUwfNxfM=
X-Google-Smtp-Source: AMsMyM6unBwC8/e3r0Rtx0/Sohl7J4lUQssMjBKp3vA8rOlQMATFFO0WHs0QwvNvk0svfi+Y3KP3/A==
X-Received: by 2002:a17:907:b15:b0:782:f8:8695 with SMTP id h21-20020a1709070b1500b0078200f88695mr1966054ejl.693.1663840826832;
        Thu, 22 Sep 2022 03:00:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826ee9d002d7918fb932a6deb.dip.versatel-1u1.de. [2001:16b8:26ee:9d00:2d79:18fb:932a:6deb])
        by smtp.gmail.com with ESMTPSA id ez24-20020a1709070bd800b00741383c1c5bsm2344770ejc.196.2022.09.22.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:00:26 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] MAINTAINERS: merge SWIOTLB SUBSYSTEM into DMA MAPPING HELPERS
Date: Thu, 22 Sep 2022 12:00:01 +0200
Message-Id: <20220922100001.12964-1-lukas.bulwahn@gmail.com>
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

As only include/linux/swiotlb.h is unique to the SWIOTLB SUBSYSTEM section
and Christoph is maintainer of DMA MAPPING HELPERS and SWIOTLB SUBSYSTEM,
just merge those two sections.

Leave the small architecture-dependent pieces to the arch maintainers.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
v1: https://lore.kernel.org/lkml/20220601075613.28245-1-lukas.bulwahn@gmail.com/
v1 -> v2: https://lore.kernel.org/lkml/20220919084744.3043-1-lukas.bulwahn@gmail.com/
  addressed Christoph's comment, removed arch/*/kernel/pci-swiotlb.c
  added Juergen's ack
v2 -> v3: 
  merged sections as requested by Christoph

Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d06f0b2861a..52f31f11bb0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6166,6 +6166,7 @@ F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
+F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
@@ -19739,16 +19740,6 @@ S:	Maintained
 F:	Documentation/admin-guide/svga.rst
 F:	arch/x86/boot/video*
 
-SWIOTLB SUBSYSTEM
-M:	Christoph Hellwig <hch@infradead.org>
-L:	iommu@lists.linux.dev
-S:	Supported
-W:	http://git.infradead.org/users/hch/dma-mapping.git
-T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
-F:	include/linux/swiotlb.h
-F:	kernel/dma/swiotlb.c
-
 SWITCHDEV
 M:	Jiri Pirko <jiri@resnulli.us>
 M:	Ivan Vecera <ivecera@redhat.com>
@@ -22457,8 +22448,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
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

