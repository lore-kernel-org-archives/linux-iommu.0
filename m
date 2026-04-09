Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5E3E121D;
	Thu,  9 Apr 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754096; cv=none; b=VnpcjRCN3yprzpGRGmQaWwPucApUxDp8QmckNVRsUniQxe6KYHHQSN6mTiXk/Blqi1NM5uQc1V39TozkSQc6wZT5VzbH9O1gvjhASBbTqHO8NSYdbSWUfI3Lgt9AXZ5UagKo8pkSfxBcwl4ct7zk9OXXLfitVg0abP6JI3L8jwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754096; c=relaxed/simple;
	bh=5CRbey0arYxrFhxOh9Gyzz0tTN0+lWt0UV3n+cdhaoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB8LRCDvWHthF6qFs31Jw4VhzrI2+32Qm8EnjghuI/bIXlDdI8bZTSfffmAeeMCT5w/ZyGrTvl/RjnfgpGQW2y3so4SheZ1aKe5WPB5Ppa+wa66VgLUQjjqoA3ZE1HqCUzqZezMzEY0We2JRFUFT3WufKbTnGo1mhMznGuB5o0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=mZtqYObe; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mZtqYObe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=Rs7OPYD1TokukjV6lvO3LVsA7e/v0I+9yX0sfAcUWEE=; b=mZtqYObeP+XV
	p3hWyLUxXL3FCE0c0RKtesIPBHhlawhPQKON9sKqN3B0nSvaHNFQ9IEMn6/lX8syGdc2loydBYReH
	FbhIIINJ2xux2cg29kw+TMQvGmZd5pCGp/e/A733ZHUV/9Humpq+61exwoNUhh02iMN/g2mqZ8f6z
	6tmQ7PXhCwGy/xWMJ5kSOV62pustC3ZrKyAEoEVDrYuhOl0FtZZAwwAAgel4EedYKJOMkWmERs0VV
	XFcIu1/nIAsbew8ynTuNOydXjzqBXtcJvKQXSqVvz6YITcLzEIkixOAEfPb31p11mRBxX0Q9XK+2S
	MI/sjXKm4DiZxWdZTELFsw==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wAsiS-00CYGt-2B;
	Thu, 09 Apr 2026 19:01:15 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: [PATCH v2] iommu/generic_pt: use __always_inline for amdv1pt_install_leaf_entry()
Date: Thu,  9 Apr 2026 20:01:17 +0300
Message-ID: <20260409170117.2014479-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260409170117.2014479-1-khorenko@virtuozzo.com>
References: <20260402141012.1437095-1-khorenko@virtuozzo.com>
 <20260409170117.2014479-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With -fprofile-update=atomic in CFLAGS_GCOV, GCC fails to eliminate
an impossible branch in FIELD_PREP() inside amdv1pt_install_leaf_entry()
when the function is merely "static inline".  GCC may choose not to
inline it, and without seeing the constant arguments at the call site
it cannot prove the FIELD_PREP value fits the field.

Change from "static inline" to "static __always_inline" so GCC is
forced to inline the function and can see the constant values,
allowing dead code elimination of the impossible branch.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 3b2c41d9654d..8d11b08291d7 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -191,7 +191,7 @@ static inline enum pt_entry_type amdv1pt_load_entry_raw(struct pt_state *pts)
 }
 #define pt_load_entry_raw amdv1pt_load_entry_raw
 
-static inline void
+static __always_inline void
 amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
 			   unsigned int oasz_lg2,
 			   const struct pt_write_attrs *attrs)
-- 
2.43.5

