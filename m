Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7A33E7;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760329; cv=none; b=Jg+NbnjMMP+m+e//p1HbntrZQeHClaeaKXhXIzmi9KmgwdnSOlpbR4q2XusVGdHN4PI4xNlYP9s+NeNPAlqYriN+KU/M1cTA1PxEqo4giKNDridMKd0LOdB8Fj1KYC4xgQD6M4zroLr67A1XzB+P1JUBrRO2gVE8S2gIEQhxp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760329; c=relaxed/simple;
	bh=IbehU3J+OYsV0YR19msdwmo9VEnGilX4b2l/J/pWEKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibt0CaBJ9qUSQofKlJet7EZfvSyRuVlKwvXun4/oRG3VrSdMaYaLfa0rC8GkR8kReTMf7gibmfPyUgtP/xJckbmj3JoFQyZBRlVgPemWnvmUPd+rMCpliRhvck+YHa5aKkxbXEeIq0arrgvtb0lIFqr//JMcBy8o9CM/WZzotWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmXHIIuM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmXHIIuM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB02AC4CEE2;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760328;
	bh=IbehU3J+OYsV0YR19msdwmo9VEnGilX4b2l/J/pWEKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TmXHIIuMbkmQ1XYD/WDnmG2toGxcQgUsC0tlH/Q2rAlfQ31uDUBa3MkGANGzLAjH0
	 4aN2p0mvuSNgb7uOp9s8ht1JxgBUXMU7KQIu24dwXJib4qMpwR5xoqO1SBPyUWYaLO
	 BQShG+qTimycwaldYMwXsXqvqq/DywDcuP+Kb+U51ROfOyQVW9FJFgs9GOqlDkdiXN
	 GY6ErfSLPC9YQfA0sU/vEwteWlOUQOts6fgawvsGSspHaiYc8aZQEtyg7e8QU6QkNP
	 i7pLpQ4/tpqwQ1YQJjWLZGle9dpMCDyQLYwpQO/K/UX3K+s7J3Xk8dmvCiQON+ejoV
	 +7K/QqXXj3mvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB9EC282D0;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Fri, 28 Feb 2025 17:32:07 +0100
Subject: [PATCH v2 1/2] iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to
 3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-isp-dart-v2-1-0ead81a90e2d@gmail.com>
References: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
In-Reply-To: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740760327; l=698;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=lnQqB1BR4mWIGODXOGI5G9lt91LbhceR/0LaO+MRnP8=;
 b=S06jxQ7AYreCqafQAUkk1RbVxcL4tN9dIdffKsqJUcXn9Y6vwsP8LtxfP1nNmIV4pa79FE9S0
 ndH2BkZx621DgfmBLn9vvS2e3dDYhQIoXOHwK0Q9zdQXq83cKazxu68
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


