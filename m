Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145C6111
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678908124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bLdC3wHFT7oUZ2jPsmMgtk2F4YyIOWga1n5deAIvgCc=;
	b=URMAHkhbXn918mkEk/klyEcpUCDrYzDzNGYWpcYPbRifU/4UatQT2U5TzJsVk+oJGMSCRu
	2v7EWGmPqB4c43aUEMqGF+7MOFriqVeC2as+wGa4R8E9JI9iKbY3fWl6hc/Xv126TKInRO
	q3l3eA3SaMrbLc9/2Tf3NHetQZYbO6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-IeopC1enPc-oAJsZDGCFrg-1; Wed, 15 Mar 2023 15:22:02 -0400
X-MC-Unique: IeopC1enPc-oAJsZDGCFrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDB69185A792;
	Wed, 15 Mar 2023 19:22:01 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C825240C6E67;
	Wed, 15 Mar 2023 19:21:58 +0000 (UTC)
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
Subject: [PATCH 0/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
Date: Wed, 15 Mar 2023 16:21:27 -0300
Message-Id: <20230315192130.970021-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

In summary, this series fixes an overlapping mappings asymmetry on the
smartpqi driver due to a missing pqi_pci_unmap() call, while also adding
the cacheline on debug messages of dma-debug debugging functions.

Other minor non-functional updates are also provided.

Desnes Nunes (3):
  dma-debug: small dma_debug_entry's comment and variable name updates
  dma-debug: add cacheline to user/kernel space dump messages
  scsi: smartpqi: fix overlapping mappings asymmetry on DMA

 drivers/scsi/smartpqi/smartpqi_init.c |   2 +
 kernel/dma/debug.c                    | 133 ++++++++++++++------------
 2 files changed, 72 insertions(+), 63 deletions(-)

-- 
2.39.1

