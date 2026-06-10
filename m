Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EE18E025
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051149; cv=none; b=uIprtEdLMt+Sqv+PfuWqPIsdPMZ5W/pREr3UuOcENH3jeTeON0ziWqJvMxNM5ZkTQY0mGCtIS49wyvqDMdTfcOMjEvSlXjPEJtW8TrcxJYLOl//78GpsSsl0GwqeJF39j5gD9/eh8oSE6CNzZWtiw7CKkveAgoEMX8S1CpjnY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051149; c=relaxed/simple;
	bh=jQ8rpJPP8MPzEUWil8NSu9IYQD7Fxt3cyljH+Liy1SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c37NPuD9I2l1OpPJkdld26j4b2jONW+A9doTNWxzKs74qUvhumfdZ9W7U5iwIoNP8Cu0f5Nxdo8F5VtlCTeS8ZMqMLO3cSPsQCWGeSUvUZtPghrDakIxXMLYv8EZ4KFEbMYh1GMMwMME2r1BjbzlHanxiIAO6aO+KmAWwxcd4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YhnzY0hT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YhnzY0hT"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517b1f2c6adso30916331cf.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781051147; x=1781655947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPD9/1geSMgRX6H4K6RRuedeClxy0eObAyWFQ0djRVo=;
        b=YhnzY0hTvNbHA0+Ur2pUEqL3N+3trr3I+f/ieunoNwzkS+rytJEs+aWxUy/PpGU/LB
         T3uSBLxTKX4+WYmIdT67t6Fwjq/ewPsDjCG+EStOOmjM35Od5dzwkMw2Yqptoj16tyiV
         lk2zLeFF9LFpNZJcSV1ByriL4StiHzHqZShicjczhYXbYa+n2jY1mSvRNrvnUdeAtiGW
         EanAOZYFxp9r1xoFxRCev1hnNGYFDxVInIr6tD+ytPsPE1jMZMUTZ3U/9hLKH+5GAUtH
         hdRyzdqXe+/UTVOMH1T/uPrPc8PddQAwP2p2eWUHm0/1FcDlagFW8HliTaYk0IOdZ3Xw
         5piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051147; x=1781655947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPD9/1geSMgRX6H4K6RRuedeClxy0eObAyWFQ0djRVo=;
        b=bHNOuP85sMW4uQm9HU8j9Up1kdDDOnMU4zlEXcTYcQv6WyTA6K9yiGW3IJuvVB/djd
         WqL1zKtrfuu/59C9COF/lBNTkcKaur6R1SFpuhbzsFLa4FaW6lRNJTpLT0k822slbtD9
         HXaRFt+VcEnTXePhEK5dv4zJfPZYV4x4pVKbq2N6l8qFACUw7Zg3rSz286K7xS3tmjdK
         B0eQdfQemGnMcQcb1VYL2FN9AKKJEOgetM4QCDB79nWlbcML745XGv5p2bfQr2UZOPUQ
         jORRv1G4TIA7CDEEA02n2RRWBJwZ5SnNNcpTy3kPttU6h5LousRGh+qmri6AzyJLb4Ab
         QSVA==
X-Forwarded-Encrypted: i=1; AFNElJ+mNgAm4NuJkO23m0+oktPGVPPrdVMwomk6FHExTbv/fw/zKZlAMykh5zwb3eYfyW8myZeniw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX7kZAhx49QigqhPziE8Ubqnz73zOg4nK/u1LLgP75WcfnVBkC
	2vya7g1+L4mvDfyD9NrZs9yRid/eInOzpMgww/ZsnIE8l1ZyDu/U88nCuQE3pMu/ACM=
X-Gm-Gg: Acq92OH0zUYPoGDPriA/qGMr31pdmqkhUrVJjqY6R7ZyvD1NodZTH05AnBmztP2RCUs
	hLnxNuonf0wKYYDlV0B9CdTq86vGTgEjjaEST2EjX8SmderPUWJsoBUmrM2DFbtTrXFh+CXZrYX
	ugY1aCVxaaLhnEYqrSjhBJb2J/plhkru2KZheLe5dg6lflhj1BLZnrbWxcNqEaZs1hkbYQsWBks
	7l9lPyz7XhJwdR8rR/g1Ue1+wfuqBeIqzymbxMXgy1JLMpCwa0BceQgWwS1U2z453B14/o6kfxA
	isZ0vw5b/fCXnUOCCD5Q2ozk1muJ5u3NFwRkQD9SirBezEXFrtmc+R2+u/DYSfpHZmHRbGDNVRd
	ju/vHYZZyH7vc+TkDomT5XLMuIuXVQR9lHTLg52kFgMhb0A80s0m9K+cSPYq1TDIG5iXgd66URB
	eVqx974+Qo2J/FmzyxB2JeS/kHwmOtlSYYwvpeqg==
X-Received: by 2002:a05:622a:1801:b0:517:6ef7:f6e0 with SMTP id d75a77b69052e-51795bbdc18mr326913491cf.46.1781051146693;
        Tue, 09 Jun 2026 17:25:46 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-517af149fa5sm97583471cf.3.2026.06.09.17.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 17:25:45 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:IOMMUFD),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/iommufd: avoid selftest dirty bitmap size wrap
Date: Wed, 10 Jun 2026 00:23:52 +0000
Message-ID: <20260610002351.1672863.5f5d62d5e4be.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
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
sizes.  Limit the requested range to SZ_16M pages before converting it
to bitmap allocation and copy sizes.  If the maximum range calculation
overflows, treat the representable length limit as ULONG_MAX so that a
large page size is not rejected solely because the mathematical cap is
above the type limit.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Adjust how length is checked

 drivers/iommu/iommufd/selftest.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..4ff6fce362ef 100644
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
@@ -1686,6 +1687,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 			      u32 flags)
 {
 	unsigned long i, max;
+	unsigned long max_length;
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
@@ -1705,6 +1707,13 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 		goto out_put;
 	}
 
+	if (check_mul_overflow((unsigned long)SZ_16M, page_size, &max_length))
+		max_length = ULONG_MAX;
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

