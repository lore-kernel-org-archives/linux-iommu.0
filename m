Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C33E9
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678975789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+mGYYulQUCelnuxj3PjgHCArB8Ei0mGxcOTGUHa8as=;
	b=jMYPXM/gDrNGY695d7M1ilyJ/SfPWg8upAgMv/lxDGTsO2VxtswBb5O9fmGmolNg5gJRM0
	kk8qaOEPPDJ91VE5SZACASHki7Uo5mqh4sU95SM5QOFAF+3b7mK9DmhctutBBbf6HTiCLU
	iyJ+fqBW3qLbsC0J/PSarU0y64pKmbU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-0S6QgkyZMHCDuzbWbgswFg-1; Thu, 16 Mar 2023 10:09:38 -0400
X-MC-Unique: 0S6QgkyZMHCDuzbWbgswFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BA51381459A;
	Thu, 16 Mar 2023 14:09:35 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA9F40C6E67;
	Thu, 16 Mar 2023 14:09:27 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: iommu@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	storagedev@microchip.com,
	linux-kernel@vger.kernel.org
Cc: hch@lst.de,
	martin.petersen@oracle.com,
	don.brace@microchip.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jejb@linux.ibm.com,
	jsnitsel@redhat.com,
	Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH v2 3/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
Date: Thu, 16 Mar 2023 11:09:12 -0300
Message-Id: <20230316140912.1038404-4-desnesn@redhat.com>
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
References: <20230316140912.1038404-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

Currently, pqi_keep_device_offline() calls pqi_build_raid_path_request()
(i.e., a wrapper to pqi_map_single()), but there isn't a pqi_pci_unmap()
call in pqi_keep_device_offline(). Hence, this is flaged as an API viola-
tion due to the overlapping mapping of the physical address.

This patch fixes following warning:

  DMA-API: smartpqi 0000:43:00.0: cacheline tracking EEXIST, overlapping
  mappings aren't supported
  WARNING: CPU: 0 PID: 15 at kernel/dma/debug.c:570
  add_dma_entry+0x1f6/0x2f0
  CPU: 0 PID: 15 Comm: kworker/0:1 Not tainted 6.3.0-rc1-linux #1
  Call Trace:
   <TASK>
   dma_map_page_attrs+0x6f/0xa0
   pqi_map_single+0xaa/0x160 [smartpqi]
   pqi_keep_device_offline+0xaf/0x160 [smartpqi]
   ? dma_unmap_page_attrs+0x1a1/0x1e0
   ? pqi_identify_physical_device.constprop.0+0xd3/0xe0 [smartpqi]
   pqi_update_scsi_devices+0x284/0x7e0 [smartpqi]
   pqi_scan_scsi_devices+0x87/0xe0 [smartpqi]
   pqi_ctrl_init+0x725/0xa60 [smartpqi]
   pqi_pci_probe+0xa7/0x130 [smartpqi]
   local_pci_probe+0x46/0xa0
   work_for_cpu_fn+0x16/0x20
   process_one_work+0x2bf/0x670
   ? __pfx_worker_thread+0x10/0x10
   worker_thread+0x1d1/0x3b0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xf3/0x120
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x2c/0x50
   </TASK>

Fixes: be76f90668d8 ("scsi: smartpqi: Add TEST UNIT READY check for SANITIZE operation")
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 49a8f91810b6..6fca497ca605 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1726,6 +1726,8 @@ static bool pqi_keep_device_offline(struct pqi_ctrl_info *ctrl_info,
 
 	rc = pqi_submit_raid_request_synchronous(ctrl_info, &request.header, 0, &error_info);
 
+	pqi_pci_unmap(ctrl_info->pci_dev, request.sg_descriptors, 1, dir);
+
 	if (rc)
 		goto out; /* Assume not offline */
 
-- 
2.39.1

