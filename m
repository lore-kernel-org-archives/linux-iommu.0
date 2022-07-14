Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558682F36
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 09:44:17 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lk8Hj6M5tz1L8qj;
	Thu, 14 Jul 2022 17:26:09 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 17:28:45 +0800
From: Yicong Yang <yangyicong@hisilicon.com>
To: <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
	<leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
	<corbet@lwn.net>, <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
	<jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC: <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
	<suzuki.poulose@arm.com>, <joro@8bytes.org>,
	<shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
	<zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: [PATCH v10 8/8] MAINTAINERS: Add maintainer for HiSilicon PTT driver
Date: Thu, 14 Jul 2022 17:27:10 +0800
Message-ID: <20220714092710.53486-9-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220714092710.53486-1-yangyicong@hisilicon.com>
References: <20220714092710.53486-1-yangyicong@hisilicon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected

Add maintainer for driver and documentation of HiSilicon PTT device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..4b93c59a9b68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8965,6 +8965,13 @@ F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 F:	drivers/perf/hisilicon
 
+HISILICON PTT DRIVER
+M:	Yicong Yang <yangyicong@hisilicon.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/hisi-ptt.rst
+F:	drivers/hwtracing/ptt/
+
 HISILICON QM AND ZIP Controller DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.24.0

