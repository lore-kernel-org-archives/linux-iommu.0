Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592618;
	b=wlYau2v2ZX1t0QpXskz6K+zNViDigwwXtPqDNrMsaRL4T8CouGhTNHWOK3lkzBUCHa5q
	 YYhCgCc44tduR6K3x9pEFM54FmQyHAjMzdqLXP2UDwidBT47Sx2Qhc/h6tdV8xzcTbPsp
	 uR8GbTMWviINsFdMPnzAPOJ/Rga7/wxNtw0cZ/IqEEb1jOrWTMyDLdNSaBfmQG97u/FyI
	 4qDTtdfted0Yy7Qer0sChGIElNa7HNtdD1kbBuPJSe/lwraXC7tgjbWl0TH7E+7PQJ9cB
	 Izowg9N2yQs76YNCNMSp5Wmwr8xY2WzXVXY7agOqAi7PRx3nNdLquFXvdb8y/09H0Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592618;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=MvidlHPU8zvIqyySx25kBpinAsib8zkl7VX76ecSDBw=;
	b=vPiA545gawc8KRfMD6cZZlOgyVKznMx8ALHB7qIvGqfIqM4qV9HAHt2snIpSZQybFjLg
	 KRuz6MijvGrLBfnl01KbqkWMBHSZoXiIa+mEmmTz+CX2b+/EqgFjMoi0LIvz3rC1VwuWR
	 1Gkke7x1DnrqE6SnPSFy9pJroccy2s/xQnupr8cxmkXR29OFUZ6Zl4n0TW1y/Cl/WHMUm
	 SoRnyZX4A1aDYRVVSSiWvwmyMDRobyRnAXTB/wd9UIb1RWLI+gMCTq6098ZEeyNfbjGy+
	 VLMDxBWjHpzU9uhYJ00T1P+m6VhyCtiyz8IC+lHt45vidu8hVFqriVLg32lUqaXg3zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="gL6+D7/t";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B6606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gL6+D7/t
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC16120B7170;
	Tue, 24 Nov 2026 23:43:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC16120B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795592613;
	bh=MvidlHPU8zvIqyySx25kBpinAsib8zkl7VX76ecSDBw=;
	h=From:To:Cc:Subject:Date:From;
	b=gL6+D7/tP+NARCMQe/7ktmUFQv32T7IljpieRbSaIBU++NmAwQ82xDvAtFFD3NxW9
	 dQCF3x5x9QbVptO4OasySrQxmMTJPQoCsqh9/axGmDklVzNpGFF1NpAb4JbzYba9Mu
	 lvUHfkrnBFn7IXcISE/wmWUf/asbWv0WB9yb3azE=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Mukesh R <mrathor@linux.microsoft.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add dedicated entry for Hyper-V IOMMU
Date: Wed, 25 Nov 2026 15:43:30 +0800
Message-ID: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
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

Changes under drivers/iommu/hyperv/ are merged through the IOMMU
subsystem tree, while MAINTAINERS currently lists the directory under
"Hyper-V/Azure CORE AND DRIVERS" pointing to the Hyper-V tree.

Move drivers/iommu/hyperv/ into a dedicated "HYPER-V IOMMU DRIVER"
entry pointing to the IOMMU tree, with Yu Zhang as maintainer and Jacob
Pan, Easwar Hariharan, and Tianyu Lan as reviewers. Keep
linux-hyperv@vger.kernel.org on the mailing list entries so the Hyper-V
community stays copied on patches.

Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
Easwar, Tianyu: please let me know if you have any other thoughts or
suggestions.

Wei, Haiyang, Dexuan: feel free to chime in if you have any feedback on
moving drivers/iommu/hyperv/ out of the Hyper-V core section.

 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..dcdc73e9ce6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12448,6 +12448,17 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/hi847.c
 
+HYPER-V IOMMU DRIVER
+M:	Yu Zhang <zhangyu1@linux.microsoft.com>
+R:	Jacob Pan <jacob.pan@linux.microsoft.com>
+R:	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
+R:	Tianyu Lan <Tianyu.Lan@microsoft.com>
+L:	iommu@lists.linux.dev
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
+F:	drivers/iommu/hyperv/
+
 Hyper-V/Azure CORE AND DRIVERS
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
@@ -12470,7 +12481,6 @@ F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/iommu/hyperv/
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
-- 
2.52.0

