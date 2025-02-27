Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E11B4F15;
	Thu, 27 Feb 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675368; cv=none; b=q4K+ypgMAES37orrn/zGonitBLBhWmXjR/tAwHd/00T5jKsojpDwd90pgRbkNtR0kPltqFplde3DDsdKGE9Zhxr1TIAaJF4+Hj7XX1/L+az+NwvwIFIgG3pp8vFK9/MGo/keUNcT2Alhs2s9eKwXX9YNZZWlp0eTTt1iMHgkX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675368; c=relaxed/simple;
	bh=4UiMkKkA2k7XmYBH6m4C6kTI8TjWMvHDne3q7Wmshd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xm98MD+9JlW8MJA4YnXur+zMcEyPyJLOSt4a9u82vQ1vuoyYJJQtOT7anNy4fpHP2bRO5O9N+YkBdmLp7CPGz0KCEoEz6r03IvGHPxg3vj2JZ3NlNQQYF63WfyKJeB6PbqSv0QJB8eaodN71wipk6Em2k13RRaoHqZjjI9OHkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3WXj7Zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3WXj7Zf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 039B5C4CEE7;
	Thu, 27 Feb 2025 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675368;
	bh=4UiMkKkA2k7XmYBH6m4C6kTI8TjWMvHDne3q7Wmshd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r3WXj7Zf9qbAc4E44AOSlvzhMW8gE1wOPf+XLxyFDJfByYEYpiuwzAE3i65/G8kyO
	 60YB0MdyzN95iADRDOKAJBg5Bx4hjlRKVjuLv+vL47fRZZPv0EyYVA4S03iwvcmCjv
	 VpGWnW4zCpwHraa4KfdmZG+nScj3iOIDKf6qBBesR8FMshSSo8eHjoSu7yPCIXf3qC
	 bfUXHYo42MPHIo1IUqoq4xSVmX9GUXeB9ewt8dVqp3Lw25lTRHoJ8x0+Nhag1WDe7y
	 0z0pOQ2CeeL03jp38KB87WLdvAMNdBEkOjGOidaVDE+QTUJWrm8EsL+sTAYGtV1Wlq
	 bNR85VXu28Qyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E65C282C1;
	Thu, 27 Feb 2025 16:56:07 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Thu, 27 Feb 2025 17:56:03 +0100
Subject: [PATCH 1/2] iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-isp-dart-v1-1-161e91ef4f46@gmail.com>
References: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
In-Reply-To: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740675366; l=643;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=VLb6ei5YDATwjI9GwTuWhThgZUr54hxXR+bLrvtteos=;
 b=nGennlX6EccZFKEYMqV//HecoBeGHkhvWIENZ1kzeI1LmLGnOIbWsPLane7YabErGkJ94lnzi
 EDuLvx5Cd4UCBm8e92qD8T/Q5beHjuc2U6wmjryWx2nGorcigYKmfbH
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

ISP needs this.

Signed-off-by: Hector Martin <marcan@marcan.st>
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


