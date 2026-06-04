Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661773BB669
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550306; cv=none; b=Pf0y1vIjXGDQJEvHgSqHUBJJnbMjaL0Ead3agIgo1AzZsmEyHR7g0TB8MqXNIuiAtcH0ooVrGZQjH/6ZiVPqnWqVqCQQqIHaPojuAWYxnpFafCfI9wL8TeLCX33dyMEiwx37qI82KYoZlTJWhKpTCnZgQrwXDPvvssTKMYogBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550306; c=relaxed/simple;
	bh=swCN0pyL9on2TRI3+1vBUIXQTmxVF54W3TG1qGC77p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICE0yIrhEsVTCeEwsY455S70xz8rgCvr1LbeU3RVYZObNUkuwWV24vpwK37wmpB6hSqzNc+L3tUZqCAiIyUOKzY8ASWvac1e5NWgQavqt/AQgh/K1eNejg+brXYenzD6dPJE0BszCLzdXjZrakWb4KrzLuE89lQmmOM20++/9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgY8uctj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgY8uctj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so164936a91.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550304; x=1781155104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzXAoL8G5yh9nalpFe2jIG9YHdbmlWG6e7G4yOR+whk=;
        b=MgY8uctjhAassXPP6Nx9YlNFa99f9+puFWISAgp1SJlf8zLhvTgecorz3FC44g66kr
         HPxgTgnB1NI/c6GJpma9LU6R7pIqKiNriytaJ3uqn6hWSC0vn+dwu9vo2q2goGLOGisY
         V0PCEaWDmYN9aqyr8vd8aP/dDlXNxeIy2FBegAyOv/baFY841621giumJcrffJbe18QR
         84DtRvikDbaV9sXS4qmjsQ4Vw+e3CVpELooyXBdn6tryLrQGoIo5TtWgfk0H93pLqtP7
         I4EkCtatMxWZB3G+wSx7xLyYMFsG+PnJ2IqMKHc9C+F6okm19g2CajuopoaOrssPS8X4
         OMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550304; x=1781155104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VzXAoL8G5yh9nalpFe2jIG9YHdbmlWG6e7G4yOR+whk=;
        b=htFTOjcr6lbb0e6DXe+B0QQPuHWiIo4IN0s5rQP0dAsDgeve5/W/UrmABzlor9unvI
         1fNYcGGEodmiNSOY847pCOy2xR87acOLpSzZ4YA7DzygWTMMpDh5NEi3J08P6cZCAMKq
         4B41OSPmD/jBo5zv4YssyKZJvai6VT+aQcqOmVZ2NMu4NZAIF8SlvKpqiEuzRe2sKjHB
         ABoXVEmnNEVSFCtdHoDIaxysfJD1I5nCttSTs3xYHnK6qnadUM7KYnI1Xtu263zGMJ3o
         hyIErZXX1427bSWVk+qo4SU/ZYmazGdrjL7VDs23h5xhjsDnRrg9jIc6Gwy2+Y4PTWc/
         TvTw==
X-Gm-Message-State: AOJu0YwBEY/XQzEPt2XXhp7Ct07E+cqHHbDDFVo/tLzOBlttQpWFev0S
	YLHlsXUvI4Ulh4vywZ7ex4SziGlW5FknK4MDmKiTdfzQTuT1HYiQTrO2
X-Gm-Gg: Acq92OE80yp36aXalXGXkQYwIZKSy7SRMO8xcLE/JJZVKokR868BRR/xbowvybKUh6j
	nqiGThPITCx5oTDpqIPq9OtsJPyIM3843lBmShHiPd3pJaC7icLGNkpRlaVF6ig45MHjksff4/y
	nAIu98MQAAwrj3OMAgpp80LPg/V/5hqtDGemPVX32W+0ZFarVYo8o1D1jeMUXZZdQ0Cl+6ZoFQT
	3jlHqFt4rsdZup8+xKtWMWUICiLDwmNHn6d5XDzkfp/Y14tuKrVWqYWTGB6hRSuFvUlXngZnmzC
	5YypQZ1kAuwTPWtDuMuC9ZH6lgUuEnYBYkW0GDopLJ7OEU2zaEcnzio22cnc/+rMF6ioecZj6bM
	OUjBvmR+quB+NtEmaNplIIVgJzl2V3dIhwrd1QxvfVt4ePLazEeedHrc4MieYUxeD322BI3angn
	Tlh3HxoVPi6Z6/AXVw2wpB/qNeRd5aP9oklV5dGSpoY8f/4meUFdAzWA8c8SU=
X-Received: by 2002:a17:90a:e710:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-36e2dd4c595mr6569489a91.0.1780550304582;
        Wed, 03 Jun 2026 22:18:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 1/2] iommu: Avoid using the list iterator past the loop in iommu_insert_resv_region()
Date: Thu,  4 Jun 2026 13:18:15 +0800
Message-Id: <20260604051816.2976221-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604051816.2976221-1-maoyixie.tju@gmail.com>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_insert_resv_region() walks @regions to find the insertion point.
When no element compares greater, the list_for_each_entry() iterator ends
up one past the last entry, so &iter->list aliases the list head through
container_of() offset cancellation and the following list_add_tail() still
targets the tail. The result is correct, but using the iterator after the
loop is undefined per the list_for_each_entry() contract.

The loop only needs a list_head to use as the insertion point, not the
entry itself, so iterate with list_for_each() and keep the typed
list_entry() dereference inside the loop body. No functional change.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/iommu/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..f9f53db9696f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -862,6 +862,7 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 				    struct list_head *regions)
 {
 	struct iommu_resv_region *iter, *tmp, *nr, *top;
+	struct list_head *pos;
 	LIST_HEAD(stack);
 
 	nr = iommu_alloc_resv_region(new->start, new->length,
@@ -870,12 +871,14 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 		return -ENOMEM;
 
 	/* First add the new element based on start address sorting */
-	list_for_each_entry(iter, regions, list) {
+	list_for_each(pos, regions) {
+		iter = list_entry(pos, struct iommu_resv_region, list);
+
 		if (nr->start < iter->start ||
 		    (nr->start == iter->start && nr->type <= iter->type))
 			break;
 	}
-	list_add_tail(&nr->list, &iter->list);
+	list_add_tail(&nr->list, pos);
 
 	/* Merge overlapping segments of type nr->type in @regions, if any */
 	list_for_each_entry_safe(iter, tmp, regions, list) {
-- 
2.34.1

