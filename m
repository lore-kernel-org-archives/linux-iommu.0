Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1338F22F
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012290; cv=none; b=j5Hps26it+ZYqr4eAskMxUN+Urahb71Btk3qhliipdk0K65GgFREjSpG9n6AvpOTi8O78YhUj8Wa7FbHLpiihmIeLwB9DQWMzSbwtPLwgy8pFB0RM1ze74DZK0HfeovuySltIlFfCdwKE4PPDUEi+F+saIGAtCAq2bGGg79uvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012290; c=relaxed/simple;
	bh=sBPJTclpO4ljkonZpXg43TeBIfOkZrvH43vkF/8LyQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ow5qyXn3y2lRV15edtk/TEwzt8jT1KJ3LuBoL/lllElidKmnqujn7FmWTsxi0RhAwUIzHOS1daUntsPoHGkHk0lreYCvuaDmzmuweA55xKhVsfyEDTIeJXt01UFzi27P8kcecsiOOiCsuMtNzr0FAlridVeP+ZNNbQbIlR2EHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ug+43P3X; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ug+43P3X"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=09W6D/jMs6O1nkVVYiJFg6hsNahknxjfCtmESXdHLHA=;
	b=ug+43P3XXZH7Mlo6eYL/li1xvvDxIYFedDeoMTbkqYmiWa/LQyh9YR3nNZYbXVXAcaHkbMqeO
	kcAeXPQJbc3IDD7dBWNCURDRuT9yAmZlP5NbxE/5wSv5UqiBC4V5Bx5epUjBu+hhVEnLs4QjdK7
	26Qta3R0RghI3/b5nU4ei/I=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fLTsq2D0gz1K96m;
	Wed, 25 Feb 2026 17:33:19 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C92094056E;
	Wed, 25 Feb 2026 17:38:03 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Feb 2026 17:38:03 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v7 0/3] dma-mapping: benchmark: Add support for dma_map_sg
Date: Wed, 25 Feb 2026 17:37:57 +0800
Message-ID: <20260225093800.3625054-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Modify the framework to adapt to more map modes, add benchmark
support for dma_map_sg, and add support sg map mode in ioctl.
 
The result:
[root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.4 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.3
[root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.0 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.5 

---
Changes since V6:
- Address the comments from Barry, update the comment of the granule.
- Link: https://lore.kernel.org/lkml/20260112093436.3456315-1-xiaqinxin@huawei.com/

Changes since V5:
- Address the comments from Barry, the incorrect and unnecessary 'prepare_data' judgment
  is deleted and renamed 'prepare_data()' to 'initialize_data()'. The mode and
  other parameters in the output print are placed in the same print. In addition, the incorrect
  map_mode judgment in ioctrl and the wrong path in sg:prepare() does not release 'params' is fixed.
- Link: https://lore.kernel.org/all/20251222153246.2220659-1-xiaqinxin@huawei.com/

Changes since V4:
- Address the comments from Barry and Jonathan, irrelevant patches are deleted and
  the original cache processing logic is restored with add prepare_data().
- Link: https://lore.kernel.org/all/20250614143454.2927363-3-xiaqinxin@huawei.com/

Changes since V3:
- Address the comments from Barry, change mode to a more specific namespace.
- Link: https://lore.kernel.org/all/20250509020238.3378396-1-xiaqinxin@huawei.com/

Changes since V2:
- Address the comments from Barry and ALOK, some commit information and function
  input parameter names are modified to make them more accurate.
- Link: https://lore.kernel.org/all/20250506030100.394376-1-xiaqinxin@huawei.com/

Changes since V1:
- Address the comments from Barry, added some comments and changed the unmap type to void.
- Link: https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/

Qinxin Xia (3):
  dma-mapping: benchmark: modify the framework to adapt to more map
    modes
  dma-mapping: benchmark: add support for dma_map_sg
  tools/dma: Add dma_map_sg support

 include/uapi/linux/map_benchmark.h |  13 +-
 kernel/dma/map_benchmark.c         | 246 ++++++++++++++++++++++++++---
 tools/dma/dma_map_benchmark.c      |  23 ++-
 3 files changed, 254 insertions(+), 28 deletions(-)

-- 
2.33.0

