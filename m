Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CC2737E3
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966704; cv=none; b=ehBFanzllfdc90bkNegCOZXz8ek7JfOyHMlY3fisKu/zdIxkSXST3qHW7BktiTuCeBBd1yHyJBrzp/z5vDpinSzAuvMhaew7TXqwQ8brmPmU5K5caWKm/nDSQ5yTRdNRGugTIrrh/n9to7+8CuITvOLTSYh8wPS1MWh/oCLBZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966704; c=relaxed/simple;
	bh=J9YQ6Xwb3PzeLfxOuYVQZmDKYv4GWWrJKCD4LtH17V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ6/F6ux4cfK65WHGez27oGS0q9Xc7MJdQRN+buAADa5I0Uzqpvegn5uphgx1pJTCWZaqrbDGjHA1V6rVuIEt759mXdqAL46fI44rUtYxXx9vlMEhblKkJ1oy+S7FfF52XrFZEWGKlx6ifFBPKwdhLTrwcj6z5x0fENsp02O/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ANf/lalk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ANf/lalk"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9de10985so59111256d6.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 17:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780966701; x=1781571501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gky2v9JSE1w7jBIDaaiZ40uFnpjgdDfEBJ+T5yMCyF4=;
        b=ANf/lalk5VqjpYxfVGoYf0OMMP0yvRlrf4fwpEbi0lN75eDsu6tSfdqodFYx2hxaP6
         C/XGuT/CfGDpi2oD5wPh3adgMaGXcVnbfFX0T9r6llj3xlydGc3nYi165QmPQremBpW7
         Yrp3P0hKBVeXkgJPqdgDUFsU5HAjV8bDU0Q5kQI6qDkNDxKKcfBgxhHXv49WCjyvRbUA
         mXJhXu/l/YDdqF74KsD9xRI2KEH7RWdW6tirbd9EnDucYRyiYnaOtZP77FyTrAYQT/Ly
         L6mYPp/Ls2YNr/aYyi3lZ0lknAVSKZAE+n4q1QtQsuz8fo01KZWuVP+2QiyoiUw4mPVj
         anXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966701; x=1781571501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gky2v9JSE1w7jBIDaaiZ40uFnpjgdDfEBJ+T5yMCyF4=;
        b=WUgYtTtZseey/FDBA9ewqMFGclEWKskUuPr1MqjBwIatz74imd70j7hQKQWcldO+ij
         tP0qdbJmqz+N9o6Io2CiLwFUZFUP3kp9dlgsPu2Ibwqoo8ukbaVIoA95gzYsc3y78maQ
         scLIEz12ADE/UjK9jvi+wbOus7SH93sflMCQj2DXozMrqOPHqsRKc6CTamrNa29hKAKJ
         LKG5ucID3rDh3Xq0AcDwyrFFQ5X71BX1Twse1q5mSWkYOei1uRvGxB2DWpk4pNzklAIX
         aRg0TD/5Pp7nS4pyMbAyetRnPMAa6yExHj9krES541wKWJFYzRMJN5wWQ7XLPTCe1kGK
         Vf1g==
X-Forwarded-Encrypted: i=1; AFNElJ9kJu7qqlqUC+nP2Y7Tgpsqdzq+9SbFkz9aWCLw5ZaDEtLDbrSiRKQmIYFfrU4Th/myYD0QQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/385sYvBZ2U/UvBU3uAyz/hPkrOgVAxOm2C+jxP9ePSWe9rs6
	bdZ7OI+pGGgawkcsDwRHE8FjZtHdcy7Fonl1UOtBeBqoUP4KHv89zSGEye0lZ5MBQOg=
X-Gm-Gg: Acq92OEUniYtjjmm1CRo6kNyOod7CeXb7tNyWJWjc3FPlk4SahEHVabfP+3Eq8AZQCn
	MTI5Jqp4rpYe3GMCNKR5+BsCNABvrDC2bjSmy2Y11Ogr+NrK5aPT2ZJIGCfI2xcMtCV943xJO3g
	p9IWxBB9Y4Mhrp3IWtaDkH1ntxSauryygrrV2noHJHW4U4FtGUr2xi8l6y/SQubpvD+PK5VV+Dx
	NG7IMYOJdBV90Bzaf7+FpI00uR789gzBm102vZgPK+HD+tEZMn2AtfKAosFG6auBTYfDdVSDpEb
	Sn8X9XWXh1fPx0kweJogadaYdmt6ALvq9edXohvKD887ndHvtmzkfhcpm9CsaymA6jR6fwpc2Jg
	zWloS/CQj2nS+i8QHEz9LtPo+Bl2rqooccKwGoX5GmHKSl+F7KxzIQqPmRsYWVt2sUDbniFnsXa
	Ru/qNNl5fv6ETNWFrZxnqQC8U4mOxYyXEuvLGa3A==
X-Received: by 2002:a05:6214:d88:b0:89c:c713:ae57 with SMTP id 6a1803df08f44-8cee8c1203fmr194625576d6.19.1780966701158;
        Mon, 08 Jun 2026 17:58:21 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd0535b0sm182684116d6.28.2026.06.08.17.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:58:20 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:IOMMUFD),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/iommufd: avoid selftest dirty bitmap size wrap
Date: Tue,  9 Jun 2026 00:55:18 +0000
Message-ID: <20260609005517.1241471.82360db24575.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
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

Reject bitmap sizes whose byte or unsigned-long counts cannot be
computed without overflow, and use array_size() for the allocation.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/iommu/iommufd/selftest.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..08c36d9ba3e4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1685,8 +1685,9 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 			      unsigned long page_size, void __user *uptr,
 			      u32 flags)
 {
-	unsigned long i, max;
 	struct iommu_test_cmd *cmd = ucmd->cmd;
+	unsigned long i, max, nr_bytes;
+	unsigned long nr_longs;
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
 	int rc, count = 0;
@@ -1706,14 +1707,22 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	}
 
 	max = length / page_size;
-	tmp = kvzalloc(DIV_ROUND_UP(max, BITS_PER_LONG) * sizeof(unsigned long),
+	if (check_add_overflow(max, BITS_PER_LONG - 1, &nr_longs) ||
+	    check_add_overflow(max, BITS_PER_BYTE - 1, &nr_bytes)) {
+		rc = -EOVERFLOW;
+		goto out_put;
+	}
+	nr_longs /= BITS_PER_LONG;
+	nr_bytes /= BITS_PER_BYTE;
+
+	tmp = kvzalloc(array_size(nr_longs, sizeof(unsigned long)),
 		       GFP_KERNEL_ACCOUNT);
 	if (!tmp) {
 		rc = -ENOMEM;
 		goto out_put;
 	}
 
-	if (copy_from_user(tmp, uptr, DIV_ROUND_UP(max, BITS_PER_BYTE))) {
+	if (copy_from_user(tmp, uptr, nr_bytes)) {
 		rc = -EFAULT;
 		goto out_free;
 	}
-- 
2.43.0

