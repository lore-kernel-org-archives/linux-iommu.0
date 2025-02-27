Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68F1B4F04;
	Thu, 27 Feb 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675368; cv=none; b=Aq3ARH5ZEjgzGV0gwaoEtlNVor4uUwhk3zX5p5LzRH7wckTkG2GYrUabQutHGvQYJ2G508CzS1qXh+KYDpSMehKCYqoXC76XS2SCLF36jwUIsDU/iqNRZjBGZrz/V1pC3hSI00cd51l/DTACY7fyRpAjjgjBTo5R4QfLYNLeP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675368; c=relaxed/simple;
	bh=ddHSWzfOpgj/d3fX6Fk+tB0XVBjWU5UoN35QACCC/xc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n8IFWImp4hDSMj9Wd84MCR6hHZ1k6/Y7lFNMJlIn/uMgetj1jlthN6sfE5d3/pnMtXXkMMn2ZLWUKTxQXSxxwSbNZB8KLwaCO/+iDYKK1aj1qH4Sjlnia33o5p5wY87ebE+Y1T+naMRzVWctlmQ0J48fLEqH0ZYGDGDoWwEmp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLC0RUux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLC0RUux"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7096C4CEDD;
	Thu, 27 Feb 2025 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675368;
	bh=ddHSWzfOpgj/d3fX6Fk+tB0XVBjWU5UoN35QACCC/xc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uLC0RUuxuh8h7kPu7nlreNvQnb5TmspiaLbq89qkbZwbb+MQAmsvGzPqVqwmD++Tl
	 q2tQCnPEMMDOtLTjm2JFpm6Zn1cyieReI9toAYgnUOHqO2beknnWYFyeTIYU0RBtpp
	 noYczIz8UEU37EBHnwwh7yBPK5GsDujh0nhsT45nDwXweKjiPMMLsBh/6hetWqRwaa
	 PkpIfXZiXbGWPGMJ1AieQmKBRyh0JAbxQSuJx3DRkEIPlLJMpG4kbV66IvVZd86Hql
	 l1o/x+evwXLpziuDFZGNi3t4T1VpF7nJG3P+9JkBSyMM0KuL6k9gIHU6uDiqqPan2h
	 yGs+GaQmF12bA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34BEC19F32;
	Thu, 27 Feb 2025 16:56:07 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH 0/2] iommu: apple-dart: Support the ISP DART
Date: Thu, 27 Feb 2025 17:56:02 +0100
Message-Id: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKZwGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3cziAt2UxKIS3TQLYzPLpMTE1OQkQyWg8oKi1LTMCrBR0bG1tQC
 mlcbVWgAAAA==
X-Change-ID: 20250227-isp-dart-f8369baaecb1
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740675366; l=655;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=ddHSWzfOpgj/d3fX6Fk+tB0XVBjWU5UoN35QACCC/xc=;
 b=TasZ/Is8Sj8Qao/MTZTpDzngUe2vnUOdsD1prS7ULnltrgtT+NSrIYi6D2PdSla0qQ1xfJ7KG
 Ln5SGozEOtRDaPc3IZl9VDj3M30AM+ik9Wm1tXZLEm9ntEXwsx0cnBD
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

The ISP block has 3 linked DARTs with mismatched bypass support.
This series adds support for this setup.

(The ISP driver itself is sent as a separate series
https://lore.kernel.org/asahi/20250219-isp-v1-0-6d3e89b67c31@gmail.com/T/ )

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Hector Martin (2):
      iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
      iommu: apple-dart: Allow mismatched bypass support

 drivers/iommu/apple-dart.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250227-isp-dart-f8369baaecb1


