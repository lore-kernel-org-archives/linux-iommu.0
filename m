Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1421AB528;
	Fri,  7 Mar 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378070; cv=none; b=Jfh+74+RQDYwQrFDfVhe+xNpM6o0t7Fblwg4Ad91pR0J1as/WMtLpodwv4+yhmGeazNvC4ZAfSFGdGg3RotC820ItaEfnw1Wa/DwnUt7fvl9dcKDt9MZ5vfTTiePQoZ0X+WJ8+9nvqbpnobcoMGSdSbSdIkaRYNjTj9frRrUX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378070; c=relaxed/simple;
	bh=IbehU3J+OYsV0YR19msdwmo9VEnGilX4b2l/J/pWEKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2MCd5LBN/cMhFchqFmyrdzCU7EjjwagCQi5VjUCw/3ItuRrYRdJHWCSZhXM9Nxfbv5aGjoQxaNppnSLOHcWiba30z5c47X13GLDuEwT+YRk62vU1KRY+dKIz5Rkab5DDp7KA9sV+/SR9nDFiShGooeNDXeM8SGLbPBPxc4v6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqWoUP0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqWoUP0N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07BCAC4CEE7;
	Fri,  7 Mar 2025 20:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378070;
	bh=IbehU3J+OYsV0YR19msdwmo9VEnGilX4b2l/J/pWEKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pqWoUP0N4DJSJV1hyYYl/yQbVSqn4JGxlUsQfKaW5tdj1ub2Eu+tGgoYfug+PrOrE
	 eSAzQAZnFZPbUNb4zeV8rZY4JeN5YWkvfvivyqJM0ZJ9PNJsFeRt8YX++9J6Qr4YE1
	 aHHf2Yk0+sJD+g/HlVK/O2AolXsik5hGrJTvqY0s1Ub54ZwrSSxYm2LUQ9/wQa9gYM
	 mnlix4S0nr8kXzg+jYbT59cdj+Jk5oXdKX5RD57LRYPFOZYiyAHb1MS1fnn8YRBQMB
	 kkPuBn3ah+MOQVHNIcgdLyVgVi89gMdVX8RM8keABs3BHLlC2kNALc3fX/82AHxwaG
	 Qn2YDzAx+onWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D8C28B23;
	Fri,  7 Mar 2025 20:07:49 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Fri, 07 Mar 2025 21:07:45 +0100
Subject: [PATCH v3 1/2] iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to
 3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-isp-dart-v3-1-684fe4489591@gmail.com>
References: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
In-Reply-To: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741378068; l=698;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=lnQqB1BR4mWIGODXOGI5G9lt91LbhceR/0LaO+MRnP8=;
 b=hb786voX2A/Zpfx3df/i6HBELMfG+WChRQ+gVPjf13bM7zHlP5dR/JwTCojn8llcpbX90nexF
 PK1W1aIzQaYB/s5G7gj1BOAxx9vqxvreXXoTQpErQTiKqYEeOtsrraY
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

ISP needs this.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 95ba3caeb40177901086076416874b9905a1f40a..edb2fb22333506d7c64ad1b6321df00ebfd07747 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -36,7 +36,7 @@
 
 #define DART_MAX_STREAMS 256
 #define DART_MAX_TTBR 4
-#define MAX_DARTS_PER_DEVICE 2
+#define MAX_DARTS_PER_DEVICE 3
 
 /* Common registers */
 

-- 
2.48.1


