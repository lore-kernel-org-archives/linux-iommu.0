Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B16364022
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034972; cv=none; b=ZKJQEpk7+kudZhiPz19MIRG0VNz1LqNimWUtUDJj8nQ/cGYH9Zn75z6A9fcGUnCr3dlc0BUGX6eUsz5NDAE14muY2nv97bZOheDnpuZam+pfskV5GOXftMB/+/2/M1eKamnPKxgy14K4D+B0MlhO4bH55+vYJdtP3wxMXihmn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034972; c=relaxed/simple;
	bh=pudNw9KOTYavH6C+k7jhuSO61Zrnc6WnJRIvsVXoTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vzvf4HvvtWt1CJQPrU0JdXaOsJ4//uQ0fjp5U/+Ve+SqM/PTOzAkKLPMCqeupwyKRIOmvy/cLFK3NMlgPEq/HWqFfvP9v9sJFUU7YvnqVJHB2CEDk0zh3sI2zYPiSuXvSKKyya3Y0qsiO05fWfoTUsoiylMFRk+lSJYFI3XcXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjSC5gfc; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjSC5gfc"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-307d0405e07so1685569eec.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034971; x=1781639771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TvimBqvRTEsIFmWQPnLqODUpV+PyJQr/0IZv3ddxZM=;
        b=KjSC5gfcKvads+zqfHw6lKecoIW35FCNHdI0wP8A1gphAnYh3oouHLyToUdJPCTIJe
         c69tc7rsK46610ztYqjqEaDrJ0W6oCsLtEuckwDKmz1jd4u/08QibKQsI5s9gKwDOAmb
         /AnMKO9VjAEppG1X8/wC0s/26JIUh9tx2kaS5EcZ2Aq80SBoZjeDvsGlzq/JwgnX+sM0
         qEoOSC+KKY05oBd2BPTyw3oC+TL/PT0OoVePpNwYxh7AZnsYLRhuSv886CqvnYX9lRwi
         7TiozhFsvRTslizJLrjL48WOIit91p9KgWpbwsdWc9jpHv7uR7uzBynke6smIjz8VPu8
         O0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034971; x=1781639771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TvimBqvRTEsIFmWQPnLqODUpV+PyJQr/0IZv3ddxZM=;
        b=EoQmdYhs425GDjKUvyFaQNuzmFAdUXR5+45/QX58HQNH7j774j/510T7WzGJYiPya+
         lBNfbzVWc3zTkcRpHxs4naKva3nyq4K5ZYsxwruLVr/FxkPielbl3yABJLS/W+R+yGuO
         d6UkND3WH4QGrVjkgZoyh9k1a6F/4VUMqRuXCU0VaDffrMzblSrbnj+g1JyGuATkjJ4D
         RqmmZGprEeBLzg0JSM28jJle6HHn1nQZTIieuCvB5nsXy0jUWVEJ9h3NzIbwcck+C9u0
         4zz+w99IYCENtmOwMq5Sw4+lBtJ/RnpYVPf5A8LJxyjLlYZ+Zzacs/LrG4BaIoVZz+w0
         IjtA==
X-Gm-Message-State: AOJu0Yzh35dQ/paQVAJSn8kGDffDVBdAC7ZBonUWz/Z1EVh3Cb1r5Mxa
	YRIca2tWH627dhHY39fmLDPomh9Jhhl9DgftfMFjqxq1IxlkfBB8j10D41USoxP/
X-Gm-Gg: Acq92OEwXU0Cjxpuv75bGGHjiZ1EAgE/LWncA/1zT6vLtpjCUW/KCbYU/woJY7z5h8+
	NQXy8bR4Ro90sCS5Y4DoEptTPVzk1qf9eML4OlyEWkHUREPbb2EWOTeK1+jPRoVUeT92OlaRwLk
	FQ4qAceJDPKMIyjBZKPq1wZ9A/KULOICL/iri4RpBe5SeLu2/Y+NbLTQkR6B941Q41vDhitDjjj
	bIKkKmqajkTZZLhFM8vI06IVlT+v090ypg8yCAhZehNWpwu/9UhUDV0/gQs6g6AOLXgKIBsCS3L
	G4LCag9amYGR1EHqK7DJaeplllJJ5IEv17SlvhoyYDhV73Js+nEIyaiyEoxsAonH5ZHrR9qDxcv
	M68j06QMkRs0Apcp2ZJlhkSZRunNAWYv+7LF4gKQsJ1knbyaKAf1dAiN8u3FwiIpFz5iVZegA8s
	AEATBX47x0F28S7Y9PjQrGtF3PgIZNird94KPufuEOj+e+qkJN1lmsrQ/UPZm+IZOVN5hDzf5wW
	YVRCuBZKBU4XulcprRy5LbW07a8ytyEVUW2j+off7d0d+gak6uhs8qmii+I4ln22HIdvazT7XFZ
	LfioZh+gL1gwsRbltWh0L5cY6Cxs
X-Received: by 2002:a05:7301:1f04:b0:304:8364:e95c with SMTP id 5a478bee46e88-3077b0d3f81mr12937350eec.15.1781034970446;
        Tue, 09 Jun 2026 12:56:10 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm22295010eec.19.2026.06.09.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:56:10 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/apple-dart: correct CONFIG_PCIE_APPLE macro name in comment
Date: Tue,  9 Jun 2026 12:56:04 -0700
Message-ID: <20260609195605.149650-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in drivers/iommu/apple-dart.c incorrectly refers to
CONFIG_PCI_APPLE instead of CONFIG_PCIE_APPLE. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 17bdadb6b504..b160fb464c5f 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -976,7 +976,7 @@ static int apple_dart_def_domain_type(struct device *dev)
 }
 
 #ifndef CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
-/* Keep things compiling when CONFIG_PCI_APPLE isn't selected */
+/* Keep things compiling when CONFIG_PCIE_APPLE isn't selected */
 #define CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR	0
 #endif
 #define DOORBELL_ADDR	(CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR & PAGE_MASK)
-- 
2.43.0

