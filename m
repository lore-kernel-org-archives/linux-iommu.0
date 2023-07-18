Received: from mail.208.org (unknown [183.242.55.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073D187E
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 08:28:35 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R4sXp3ygjzBR9sk
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 16:28:26 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689668906; x=1692260907; bh=D8d+MsQpIDEMC9w+5s1SwmR6S+n
	0xq3gry16gHMpo4A=; b=1DepZRv0v9ufvyClbtE831S94x/8NSMzuCe7SENuKIP
	EfTVng/v331BtBWiBJey1AhLXI9rvwvP+HrGJ6r4+71Lv2V0lvFVKh7mRNVFfbqL
	mw1FwDiTyFJbSoul/PRtusSOkx9ODuJKWIXRB8lIaDqdM1MmRY4UzL2OWPaReKwy
	AE6ygcLmUE7jRTl3NZ+bmTVEYAjWyhKhNNIIGXbhUnBc536TnD4ZbCsOQ3PhMMRW
	qos7U9zPI2lLjSHXOHCveV+V/LJJPUkmEy2KvVjQ8Ee1AYhYG3TusDma11gIFsGE
	z8OFcgJ6w9gjbZO73fAeqpPxmepmm18wiFmfZaKF1bQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fkqXZjE0NQLv for <iommu@lists.linux.dev>;
	Tue, 18 Jul 2023 16:28:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R4sXp1ShhzBR7bp;
	Tue, 18 Jul 2023 16:28:26 +0800 (CST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Jul 2023 16:28:26 +0800
From: sunran001@208suo.com
To: joro@8bytes.org, will@kernel.org, matthias.bgg@gmail.com
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/mtk_iommu_v1: add missing put_device()
In-Reply-To: <20230718082500.17066-1-xujianghui@cdjrlc.com>
References: <20230718082500.17066-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <36b3ef1e2a73f84216d9fa656f6146a6@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

./drivers/iommu/mtk_iommu_v1.c:669:3-9: ERROR: missing put_device; call
of_find_device_by_node on line 662, but without a corresponding object
release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/iommu/mtk_iommu_v1.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 8a0a5e5d049f..1833d0ce7afe 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -666,6 +666,7 @@ static int mtk_iommu_v1_probe(struct platform_device 
*pdev)
          }
          if (!plarbdev->dev.driver) {
              of_node_put(larbnode);
+            put_device(&plarbdev->dev);
              return -EPROBE_DEFER;
          }
          data->larb_imu[i].dev = &plarbdev->dev;
