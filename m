Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA33812DA
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623364; cv=none; b=Q+stPZu8o2Lwt3RMRvEngCQvASuas42vYPdqeyuLjhb2nwO7z10w5/VRCBhFU4tMtnKvwYru4r53NDOg7z76kSXHi7txSJcl0htABcfHEB11Geav58q4pWcxBM+7RcAID5CQQ+f3glRMsJ6prrLCrpArYqCCbE6rvw94PbBO3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623364; c=relaxed/simple;
	bh=O2NCH6fRzAKfFcbo2g+YXWIY+g3rn0P+J4It7kRFVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4EF92xuaW6J3iQgaWyGhM3upjQ/8PAC1e3sZ4lPfDTh3/pt3wQTqLy8qr0qoKJriHvjKd32m70O2nex9Anm24U+PPJWrStriXV9ETBBt1nSO3I/dirsNN9/iTLpEQhMsLu0lWUGt0zizZV1Paj0QThHRvCB3hD1N+xmAhfHYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKfOUtUA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKfOUtUA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d560775ca2so14873155ad.1
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788623362; x=1789228162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPGHJlBhOsIhfLZxUC9HYvuAsWrMr3CvcXvz/1SrJ+0=;
        b=gKfOUtUA/mcT3T3U2N38XY4AgMyj7NjUVqk/pToPRiEeLYR7pcMntpHqH/AaNV1uoL
         tFGNxfiUZMkNL+0Hvd1J27euccSCYBXPO4hOaS/wYZsuX1fn7gSqNvNV109EKs5r29HI
         +s21+2RAYBi2x3LdlmdI5lsq6kaNqkh9oRZ2colnPEOQ0yXt590zFfcpTo0SGqkwkZtD
         jz6KrHIZkZPEAicsQmT0yYGSIIvFOAfQm4X3CWOjVZbUH6YUX7P6SdiyBqsOqMfAU1dP
         43Z6I7zlBib+922rojYNOKh85oqWLdR+iCGTFN2z9H1E+BVK6lfmWpDXGEOkTArvWzbj
         4M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623362; x=1789228162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPGHJlBhOsIhfLZxUC9HYvuAsWrMr3CvcXvz/1SrJ+0=;
        b=C/zmL87uGXAnwelghKgSLDhPHC/JJy8EE3tIDWKapGSL976IbyxXpi90w12JcCjQTa
         ymVLk6CkqmmttVGLrQ8MPzxhK4/hGPHEw7j0E+OSizP55OgVDl6jPiiRCo4vbo8Dwxs/
         7wiF36rNtD9NsvPRmQo2AVvxmKXmSTsYfLjhd2DmxkIY2OjfV0VlJ1fhi+Fjrg1iawQd
         71d2JfdVUEsZT57qdTCRze3mVN+tnkPBL0y2HPTY2bI8Erg+jEecxS7b1tXqTTQ0XyZu
         4xxUPr5PsCasuLHUY+05fZErMIvuAVTPLSfIn319MTSZLTUyx7DEzyZvQfC4EPt1IrsC
         v9Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzPFwb/hfRpEEvGYe6mHbidjUzv/Ji1KvR0yo/DnSXaFyEXvUsBGqEy0lNUFXGaHiXWc5iwdA==@lists.linux.dev
X-Gm-Message-State: AFuF++m+GcSkJEaWZB5JIjjXYE23P2u+8kJK/lY3tisMFyC6TuSQyica
	WFVgoGXwA/toNgP8ffuM/p1LQ6XYGc85h444JEx3BJyc1UzgbXzu6IkS
X-Gm-Gg: AYBFou1C1F3UKwLtkvd73ntUryO3fnbdtQ+4A6XMnvIA0/9zNdynX601YDYx3AXL2DK
	AZQ9HchvprJ5Qqjt5rcsdCdrbnXqGSO5WYaDEmhv3u6jxIWOQ236jRIvM7OIpAOk9nBKpo6WJOF
	06A+kubDkP3VufmpbvXc8fNY5M+Hw1exNT2mbgKQ8F6MMfDAfmcspVx1qKBU1lnA+9vLsr8ChbY
	KUP98pWD/sWSo5wtW2umTYFriWsLNWuThrHVhmoltUy7Rg/0ol/X1IKFTf3Fd/X4HWSHOYNH0K7
	RghXYrQ8j2LLqxuXTHkMmmXDFId03svuwHBcFG7mtF11ETFwNtOjpEpIbbwTMiokP9NabaYXnFG
	P5w5Mb1oNdEG4fyTSJh5jnUMYhJz/isXGMv1J6g4uDEGownw8LQYAMpsUWUzUT0gTQlgwL7Hh9n
	CYJV4H8Ig4GClYWvlkmJYGexSv3n5x80TND+czC3wdrARvTGTFXH56q7UVKpKubffalTG09/ptA
	YA=
X-Received: by 2002:a05:6a20:5681:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3da39eacde1mr21820617637.4.1788623362575;
        Sat, 05 Sep 2026 08:49:22 -0700 (PDT)
Received: from MSI.amritanet.edu ([103.5.112.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm14555211eec.10.2026.09.05.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:49:22 -0700 (PDT)
From: Daasaradhi Mannava <daasaradhimannava@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daasaradhi Mannava <daasaradhimannava@gmail.com>
Subject: [PATCH] MAINTAINERS: Drop the nonexistent vsi-iommu.h file entry
Date: Sat,  5 Sep 2026 15:49:00 +0000
Message-ID: <20260905154900.1272-1-daasaradhimannava@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 917ace84b770 ("iommu: Add verisilicon IOMMU driver") added the
VERISILICON IOMMU DRIVER section, including a file entry for
include/linux/vsi-iommu.h. That header is not present in the tree and
no file includes it; the driver in drivers/iommu/vsi-iommu.c is
self-contained.

scripts/get_maintainer.pl --self-test=patterns reports the pattern as
matching no file.

Drop the stale entry so the section only lists files that exist.

Assisted-by: LLM
Signed-off-by: Daasaradhi Mannava <daasaradhimannava@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fb50c3ca..95b5a3bc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28608,7 +28608,6 @@ L:	iommu@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 F:	drivers/iommu/vsi-iommu.c
-F:	include/linux/vsi-iommu.h
 
 VF610 NAND DRIVER
 M:	Stefan Agner <stefan@agner.ch>
-- 
2.43.0

