Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.150.92.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943745;
	b=hxoENgPw8aipGUGLWvLqSl2sN+meve3MWWKRXGAOQ189XBB18fsCVjivKCa1TeQxasZj
	 UAgs0066hbmREiqRVy/S/0Ls7OMxhXu6tR7FHv6HjP6iYC9X25sVkJfVjZxXICInBwQia
	 G1ullVNuHUNnpkHi9ueq7wduSdQ6Q380IjWp1nk0WudGTvPJ5GnGPolhheaY6pOKF4xgy
	 3VBQUKxIhYR9nzyMLi3nm4zMSTmJ5IFoqM9TbX2JprKyNz/b1QuQf/zR75e5IYpXckmiG
	 BVwA8TvUKqnoOafn385P9pU1bN8lkyYdLIQQKz7reLfcqw6PQVkYAXtucPOm4r7MBCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943745;
	h=DMARC-Filter:Received:Received:Received:X-Authinfo:
	 X-Hiworks-Remote-IP:X-Hiworks-User:X-MailFrom-INFO:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sCjK+eSjFwVT1Le/uIyIA/BxA96L8az923s+JnTYtYk=;
	b=1pCB7+8CJ+FkRYIVu2KyOB9xwXmbVVI4LdmuU73b5XU4dR8dewfj+oa2ZU/8VXJdjkFf
	 8Uy9nRqHUfsliXM9SiPsz1OhFB/0l7gqC9zCmN7bzth2kIncKxvwiK2xdSFJC9ZJZIV0u
	 JHU4xpNcoFvNfpM6Ev4826tHLDGmOTmFFigTHZN6gaXAAGPrgcdqhJ8/1yCaz/mkDTY2D
	 Hj41MciHMFz488beB41GJAWb79WLzTcNWOL/FoEoFSN/SodS3t6roYSWfqXcyhzAKzjf3
	 VFsD6z5ceLJajXrBx9E+8vHkLXy0RPLZzkcrJDI1SRYVVPa85psFwcH3KKxv2kBizpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nirvanahyj.com;
	spf=pass smtp.mailfrom=nirvanahyj.com;
	arc=none smtp.remote-ip=139.150.92.27
Received: from smtp92-27.hiworks.co.kr (smtp92-27.hiworks.co.kr [139.150.92.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016D606D807
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 05:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C016D606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nirvanahyj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nirvanahyj.com
Received: from hi-smtp-node1 (unknown [172.19.0.2])
	by smtp92-27.hiworks.co.kr (Postfix) with ESMTPS id 4jLSjz2p4bzkX4tw
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 14:42:15 +0900 (KST)
Received: from hi-smtp-node1 (unknown [192.168.71.54])
	by hi-smtp-node1 (Postfix) with ESMTP id 4jLSjz0CDxzQLZQT
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 14:42:15 +0900 (KST)
Received: from hi-total-node5 (amphora-3294b420-308a-4b9e-8a1d-bf25580dae1f.openstack.gabia.io)
 	by hi-smtp-node1 with ESMTP id ozztoffo3bw3i2wb;
 	Fri, 06 Nov 2026 14:42:15 +0900 (KST)
X-Authinfo: HIWORKS SMTP authenticated <nirvanah@nirvanahyj.com|114.203.237.180|nirvanah@nirvanahyj.com|261106144214_8061351674>
X-Hiworks-Remote-IP: 114.203.237.180
X-Hiworks-User: (SASL_USER) nirvanah@nirvanahyj.com
X-MailFrom-INFO: <country_code:KR|rbl_level:0>
Received: from localhost.localdomain (unknown [114.203.237.180])
	(Authenticated sender: nirvanah@nirvanahyj.com)
	by hi-total-node5 (Postfix) with ESMTPSA id 4jLSjx6ghZzSqYcR;
	Fri,  6 Nov 2026 14:42:13 +0900 (KST)
From: Young-Jun Hong <nirvanah@nirvanahyj.com>
To: 
Cc: stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/io-pgtable-arm: use inner shareable for Mali LPAE on a non-coherent GPU
Date: Fri,  6 Nov 2026 14:41:48 +0900
Message-ID: <20261106054210.2893230-2-nirvanah@nirvanahyj.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
References: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io-pgtable marks every ARM_MALI_LPAE PTE outer shareable (SH = 2). Outer
shareability is only meaningful when the GPU sits behind a coherent
interconnect, i.e. when the page-table walk is coherent (cfg.coherent_walk,
which panfrost sets from the dma-coherent DT property). The vendor kbase
driver on a non-coherent Exynos 5422 (COHERENCY_NONE) never uses outer
shareable: its PTEs are non-shareable or inner shareable.

On Exynos 5422 (Mali-T628 MP6, ARMv7 LPAE, not IO-coherent) the outer
shareable attribute hangs the whole SoC when a large GPU buffer is first
used under GPU bandwidth load and memory pressure: 0 of 22 runs survived
with SH = 2, 3 of 3 with inner shareable. Non-shareable also avoids the
hang but breaks global atomics between the two core groups, so use inner
shareable for a non-coherent Mali; coherent configurations are unchanged.
Sustained GPU copy bandwidth also rises from 6.3 to 7.7 GB/s.

Tested on Samsung ARTIK 10 (Exynos 5422) with panfrost and Mesa Rusticl:
hang reproducer clean, OpenCL accuracy suite 96/96, no GPU faults over
several days of use.

The analysis, the code and this changelog were produced with Claude
Code (Anthropic), a coding assistant.

Fixes: 7618e4790982 ("iommu/io-pgtable-arm: Improve attribute handling")
Cc: stable@vger.kernel.org
Signed-off-by: Young-Jun Hong <nirvanah@nirvanahyj.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631a..0e7b2edd9ca1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -565,6 +565,13 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	 */
 	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
 		pte |= ARM_LPAE_PTE_SH_IS;
+	else if (data->iop.fmt == ARM_MALI_LPAE && !data->iop.cfg.coherent_walk)
+		/*
+		 * A non-coherent Mali must not mark its accesses outer
+		 * shareable; inner shareable keeps atomics consistent across
+		 * its core groups.
+		 */
+		pte |= ARM_LPAE_PTE_SH_IS;
 	else
 		pte |= ARM_LPAE_PTE_SH_OS;
 
-- 
2.47.3

