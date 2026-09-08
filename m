Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E50538D7E;
	Tue,  8 Sep 2026 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904121; cv=none; b=PiiPRUEmCZhawzfG3j8dlFfzWnbEUss+2EcOjhllQRZTI+xcIuuVG/xpTmWFkONmg9OpX5VPLGwY3Cq6dN9SQl/Gn3viu9pKUUNyVGpeEMJ64O2foZ+gomJwFGHwJBEoSMB5KlVCPCf8a1aRjrmmSaOAalJnsAV4Y/2XOORMaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904121; c=relaxed/simple;
	bh=NBn1b/pAJh9jp5+mm3asIR3e5//SYND5JIWJyHvtzQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKVfl2YB+/03NRx4srTrEhT24AFG4W/u09vjKcjXn0kYrZTJsXyccTah1Lazg/i7sXKJxJ5egW5pZb3+2eFGB1ARJTHw7t3BQGbcIhTTxGGCDhdS+VaG2Ymq8U3KiOgkQoilLGhNLh7WljDTBOR0RJAkgQTRUXHbg3Lz7dykgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Gj1B+zLC; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gj1B+zLC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=EprWQ6/5qkuwvBjUQ8U8imK3Hu0Noopy2ZG9qCCogmk=; b=Gj1B+zLCiH/g
	CdYgMrXYgnOzqmX9EeEiKPFopMhOaJeFUis7Lu1RWJK4OBNcjI/Xx134BX1tte/64o07DHehG/cDe
	0UinIoKZVoU0fSwHs4OwdRJzLtFAgSLws37y54y71mtCUboBMOjRBSheeU721U9KXOZpxLP8VKsqM
	MFrzegaGzGf02B396HZ6rWg9/VMZPbIBoQEiIYZ/GANpJLg3yS8HOB33FXG6S86zAMoQyIbKsi8GC
	y6/QwH57Q/4tTTreurivGFASQAGO9XpBV3pT6upzn9ofQd0Hbj1IjhHjRB8O71XjsJbrMRGozspTv
	UV/WKEizR3UU9yhHR8fdIQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1x43da-002qQQ-0v;
	Tue, 08 Sep 2026 23:48:22 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests: iommu: suppress -Warray-bounds in _test_cmd_get_hw_info
Date: Wed,  9 Sep 2026 00:48:11 +0300
Message-ID: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  In function '_test_cmd_get_hw_info',
      inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:614:3,
      inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:589:1:
  iommufd_utils.h:683:37: warning: array subscript 'struct iommu_test_hw_info[0]'
  is partly outside array bounds of 'struct iommu_test_hw_info_buffer_smaller[1]'
  [-Warray-bounds=]
    683 |                         assert(!info->flags);
        |                                 ~~~~^~~~~~~

The test intentionally passes a smaller buffer to exercise the kernel's
handling of undersized user buffers. Runtime data_len checks make the
access safe, but GCC cannot prove this statically. Suppress the warning
locally with a pragma.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index b4928cbd4d9c..c4dfa05e0612 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -866,12 +866,19 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 		}
 	}
 
+	/*
+	 * When data_len is smaller than sizeof(*info), GCC warns about
+	 * out-of-bounds access.  The runtime data_len checks make this safe.
+	 */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Warray-bounds"
 	if (info) {
 		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
 			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
 		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
 			assert(!info->flags);
 	}
+#pragma GCC diagnostic pop
 
 	if (max_pasid)
 		*max_pasid = cmd.out_max_pasid_log2;
-- 
2.55.0

