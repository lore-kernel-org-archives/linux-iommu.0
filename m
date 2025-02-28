Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AF26AAA3;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760329; cv=none; b=Nwo2hyPn9RTMar81BxCH5I5lMhY+krDZA6Y/q/0ojyKNWYy7mC/zF2RjhiukjocwbXjqnvIt46Ph7wnpt7sTP1lMNXLXO0nLADBaBaAUvcbs8pZMc6v0HRPIxSGMNi2fScp6FlPs5wA1+wEzbcNivETpes5sS/I9vnccc/OJDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760329; c=relaxed/simple;
	bh=QxKE/vnJMWgW3Fp9S6RUPUhxvfrYA/OhRaJWoXg5OT0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZsEIvhfejwR2Ote/YPRPj0WG/4IaXKjxxlQuuVEajVEvWX3Pvy00u0bI9dDw5BCr/B4sTMuOoEQnROoBX70sInCZMsUOgx2Cq31+OCIRxKu9MsUXsPiLV7cIPE7u9UOob8OFv427isY3kGOlE5rZ93uwqPiee4H/a97DPA2wX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5/ReRPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5/ReRPm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB783C4CED6;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760328;
	bh=QxKE/vnJMWgW3Fp9S6RUPUhxvfrYA/OhRaJWoXg5OT0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=E5/ReRPm3Hx56j0Y7VqvCQBpbaRGUJITQD3WoknMWBf0wvJkoloKeklZwhdIDfo2p
	 LtWbj134LSWzcyvZpjbeMNKg1uEpkzpp45OzzNgmSoMpaPftc2iC4AVraoBiV6J3Vd
	 VoWEyfKcPSrZR/l/Jg9VOAfWzjNd1htHqXQMKjcD0zF+ehx4fiof/Orou/vj2E6D5n
	 yr1tZELClvsO7uj3gpY3oWTmCICE0XKeqG2+gOywuZYfdmdNwGtQzs0r+QB20s/5c0
	 +V09pCNaGYb0nITGTPH2lizR4o622/1T4TVnlmAsQx8eRooKfUoWSCh8JneNxx9w+b
	 IiGoQezo2Dt1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF1C282C1;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] iommu: apple-dart: Support the ISP DART
Date: Fri, 28 Feb 2025 17:32:06 +0100
Message-Id: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAblwWcC/23MQQ6CMBCF4auQWVvTqViFlfcwLEqZwiRCSUsaD
 endraxd/i8v3w6RAlOEttohUOLIfimhThXYySwjCR5Kg5LqKpW6CY6rGEzYhLtfdNMbQ7ZHKPc
 1kOP3QT270hPHzYfPISf8rX+QhEIK1EgNkqtdrR/jbPh1tn6GLuf8BTf5WjagAAAA
X-Change-ID: 20250227-isp-dart-f8369baaecb1
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740760327; l=820;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=QxKE/vnJMWgW3Fp9S6RUPUhxvfrYA/OhRaJWoXg5OT0=;
 b=NkWNCpfcMNwzWsbnSKE+X1A1U4WmVG9Nd2rgKOi5zpr713ES47sa+Vb6FYzPoD6/JrAn/oHg5
 H7rwQkMQBQiB4NsAeu4cBz9ysy5g2QqS+7KaiGZ/StIiAE3RJ4QPQ1R
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
Changes in v2:
- Made comments and code a closer match for each other
- Link to v1: https://lore.kernel.org/r/20250227-isp-dart-v1-0-161e91ef4f46@gmail.com

---
Hector Martin (2):
      iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
      iommu: apple-dart: Allow mismatched bypass support

 drivers/iommu/apple-dart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250227-isp-dart-f8369baaecb1


