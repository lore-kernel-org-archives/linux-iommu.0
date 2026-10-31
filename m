Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435433;
	b=vxWtZaBL1dPX4JYflZSIVJWuk+D11okAnv/UQ7vJFHMrasK3fiFqMMZGz1h5RdQ3NjML
	 cERjcaHwtxjyga7M5QibeMOOXQh6IOGlLDnJSob8x/NBrsHGmghaVPDnbw3JaQV6O5vF/
	 xa2YMsA7lYLmCTX0p2V/0BLdoFwCxAFI+ctbBB7LN72xWgfJepX39vQvQozX8glp1xFhx
	 RPYlpUmr05UeoS8o6ktYkWgXGHgVB+7ktw7/SWE341SDsk4xtoN6E6rJDl7d3dByirjbU
	 VZmfF/RFDOIcbukIpgAhQDmiVtNaRn+msNk3gXyKXRiQcHiiafx62oOx7GDhMvQMmIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435433;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JvLg4S5shvS7IVAuk/ea4lw7Xa2XcuYDCBZ9VnAd86s=;
	b=GibT8d2YYLcpKeuaCvxwLMMbum+2EFaP1jqbdI/Mnt2xtWXCYvGGwlEStENb7BuUo4f8
	 6yU7NN9lGNd6rnPeo5Sf1+Yz3SEEqzs+4Al2r9haHw9a102SGpKWksVsfumphwrwkD9yY
	 ffRlcmSbzCfZkItPltCtqEZIQ06y6JZN/AZmVfvQUOUwq94D8fvOIDVihRAHqWmExwPKn
	 jYtL62w4ItWfCRdVvukbSZ+yrW9tW7uiLHPd6uluTqnSMUa05vRjg40cnV/QOthen0MTx
	 wTRCJAeQz72MakmXgbkSwK10hq3eMyPlGN6SscLMKZQGWezJpcL8D/PQULuJSi326pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iYFHEv53;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512D606A32A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0512D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iYFHEv53
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793435423; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JvLg4S5shvS7IVAuk/ea4lw7Xa2XcuYDCBZ9VnAd86s=;
	b=iYFHEv53TnBB0X4KK3H1nP71vR5aAIIpgIANX0MAVlIW2iLZd9GS48AKEpy4lxxtLB+5YpaHrQArrmQRoW+arU1fMDn8Wh/z6lwF9XdjqIn8aDWyWW3UBFu4eEerX6hvx3X6RS0kp4g5WhUVsQiUodx9WmGrKyyhBVH4yA2k+CA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDo-2im_1793435420;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDo-2im_1793435420 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Oct 2026 16:30:21 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 01/10] iommu/generic_pt: Fix the RISC-V supported feature mask
Date: Sat, 31 Oct 2026 16:30:05 +0800
Message-Id: <20261031083014.15040-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
References: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

The RISC-V format advertises Svpbmt to its users, but omits the feature
from PT_SUPPORTED_FEATURES. Add it there so configurations which enable
Svpbmt pass generic page-table feature validation.

Fixes: f196a8668797 ("iommu/riscv: Advertise Svpbmt support to generic page table")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
index b18fc4d109f5..1bb74114fb02 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
+++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
@@ -7,7 +7,8 @@
 #define PT_SUPPORTED_FEATURES                                  \
 	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
 	 BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
-	 BIT(PT_FEAT_DETAILED_GATHER))
+	 BIT(PT_FEAT_DETAILED_GATHER) |                        \
+	 BIT(PT_FEAT_RISCV_SVPBMT))
 #define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
 
 #include "iommu_template.h"
-- 
2.50.1

