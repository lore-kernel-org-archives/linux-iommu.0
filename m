Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC53AEB26
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782660398; cv=none; b=U81M4w1qEzJPm0giAS4hLiCVNpdHkTujTjMFKSHhsVx70W/gLrfrAPDV5XyKAvR03ySE9zfeidDIBJWJBZIi4Dl2L/6jfTnInlXuxYWY/OUT6tG7s5QYSM0PLBh2kV07f6dsGjigju4h3at8i+kJlL9OhVr7/nqMZITeCq1tlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782660398; c=relaxed/simple;
	bh=Psg+BEPCrWQehpC4vVGZncoib61fM9hgxCY/O/yo39U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7deDZM+6NKFaoq9peIW96af+hPWkXaWXG4BTdM3lNob2QNt6EhmnE5hNShGM5+4RTRBWGh6S9rM/dwGvssAf7CV9+zp3m9CoCQ261kSTwIIq4ScWlX6qPQVILJ378M4j0TiNNwmpuFfjVZkAqh/8QqI+q2mjVyayqJNv0Go8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HC8FYdaw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HC8FYdaw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92b21f65b60so178672985a.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782660396; x=1783265196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CfnQksWaSbp2ovyXk3RdqN/MF8n3ttFf3hc1ArqSrk=;
        b=HC8FYdawhodOoi4fuTPDZu0sOwohOSbnCh7ofaAemsPHxy5IVjKLX7GC3p6mK5AHpc
         tOb5i6JyqOeF3dmJIlPGivmhHNXjKuHhzdcb6BSAezCq5kfTMno/pimzHEHPJXzl3+e6
         FilEtTblO8ndANE9k6ANAf6om+hTwBFCs+eHwhd9HhDszLdgyS/ucUqqALOYU4QX3q2Z
         Pc8C0w37weJHec1gFeYzJV5lmHpiVbzf7BzJvSlJBZF6DF27HtSIYinjl5awBzuSLvjx
         bJLKqOrk8pq6X6OIfegL2ubd0l8sFiQ43HWWC8tMgjzuzf4k33rYxeP5vZxh1XTRsE1p
         Koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782660396; x=1783265196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CfnQksWaSbp2ovyXk3RdqN/MF8n3ttFf3hc1ArqSrk=;
        b=kAK8LboxRAvVwMkzjHCmQLuKXehP4V60oaY+Zshy+Io8/qey3nHW9ZOke4J2TtdG9u
         b06t66j/FByAd84OHFi7TvPCoW1jFtI0UX6VdlOXQxtAZxHyp8znVLxPZnlFmzRD+oTg
         UWPevzXbs98tPNZPNZuA6DV8HfTSSI7THNTc6lMBF1O+QOUBoFc9ClwTyvfy7p4+DR9d
         9Ph/8Dji7q00FoOWsTiKBQGNWrIYb0SLCKHWZO1pj7RV7YvLCjth8PLf11InDHG2lJ2f
         H7icsPn+dCQGjxPjCVElvm7pysO5dZKEsCHMac45zW6oGxsWYNeSb8/0Cm9hcSzKldic
         ofLw==
X-Forwarded-Encrypted: i=1; AFNElJ8YCsjuelm4SfgrEQiHTNwm1kolM5JbV5vUfNyjzb9IooWSLulCEHJVJVYgMIGI/3tifq6hSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyej0RiJ3obxtw+SQwU2NmOASxUTnXJ7v4Rhwptklb5lkKbrkUu
	rIOKFUHlxujOaPV99wIag21iwsBgTx+lq1d0IjNkPog8T6YhJze8DvIizitV4W2aufSLxuNtLQ8
	B4O4J1N0=
X-Gm-Gg: AfdE7ckFFzgIP/BDqADZpcsuxgxPIAxjrGtpJq/ZFL8J4WwvU48aQCtejpSosArcoGB
	+sZkp3dv14UauRhl3vvt0HYRLestbAcZPqmWHUjrqK4Kaksd6s+0MZX9wDsgE5ysZyXO0DCIhPY
	a6KhaJKgoKn69JFPbQwAwLhD6GI2EQ7hZnzN5+NpgLsNZOw2I6zVHTpW4tas8PJb6/1JY5aGQS5
	cpq4XlcUpM9vQB+270bQncChusn0ncQpLTJeOaRhefmxRiskfCgndpD1MUnYLWAsEQL7fWEF2hw
	WjO91DLzdqtUQFiwapUbZNARfd6OyQLzZwr6FPyWBbhSf0SeFPXs/uCg/xFBCbz3XRt5TWrNz+D
	dqFNFk7Qq9BrsIMuiWayWy5OY6ORVtZVq0QWETFxTblZHcmWKMG+NXfBMsoQ8fkK+fNSNg/YIgB
	5AkxPT4qQnU7/YBrcfMOQ861ytVlg=
X-Received: by 2002:a05:620a:4052:b0:91e:712d:f79d with SMTP id af79cd13be357-926033c265bmr3255298485a.40.1782660395985;
        Sun, 28 Jun 2026 08:26:35 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92e51f017ebsm18209385a.5.2026.06.28.08.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 08:26:35 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:IOMMUFD),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iommu/iommufd: avoid selftest dirty bitmap size wrap
Date: Sun, 28 Jun 2026 15:23:32 +0000
Message-ID: <20260628152331.82122.408afd7b466c.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_TEST_OP_DIRTY sizes its temporary dirty bitmap from
length / page_size.  Very large selftest ranges can make the
DIV_ROUND_UP() additions wrap before allocation, producing a
zero-length allocation while the later test_bit() loop still walks the
original number of bits.

The selftest helper does not need to support unbounded dirty bitmap
sizes.  Reject requests whose range cap calculation overflows, or whose
range exceeds SZ_16M pages, before converting the value to bitmap
allocation and copy sizes.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v3:
  - Fail if page size is too large
Changes in v2:
  - Adjust how length is checked

 drivers/iommu/iommufd/selftest.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..cf9a38e72b9a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -12,6 +12,7 @@
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/generic_pt/iommu.h>
@@ -1686,6 +1687,8 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 			      u32 flags)
 {
 	unsigned long i, max;
+	unsigned long max_pages = SZ_16M;
+	unsigned long max_length;
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
@@ -1705,6 +1708,15 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 		goto out_put;
 	}
 
+	if (check_mul_overflow(max_pages, page_size, &max_length)) {
+		rc = -EOVERFLOW;
+		goto out_put;
+	}
+	if (length > max_length) {
+		rc = -EOVERFLOW;
+		goto out_put;
+	}
+
 	max = length / page_size;
 	tmp = kvzalloc(DIV_ROUND_UP(max, BITS_PER_LONG) * sizeof(unsigned long),
 		       GFP_KERNEL_ACCOUNT);
-- 
2.43.0

