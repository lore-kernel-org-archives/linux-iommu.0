Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDB19E79
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7+xegEsHtqdZfD90PqdQG2V9qml0A9VagIuPc+XndpY=; b=nOfGMv5BDRQxDfnrKd8bzmQWqr
	goBsBKB7Iw1m2LxzLRFbWVRVGrjRdpF9rFhCZElyGUexeqx5Gd9/KXOz8Z/0AvV6Y2V4vqzAHsT6M
	7gsR0fVXxD0Ee2qf1VyGvSE4UDuPsMTrlK1/DNRnlXS6AY76SN3HBTrdKLf3sdFvc7RaNofiW/9Mp
	cq5fhS41yZ0jYIePZfhZ1xV0fXI0Ev3LIRDrz5qE4H3oed9BmraNqp8ahrJhZN2yibbAhjChO5VYJ
	z3KK6ayWVF4A0AKXxPff8zQPHaAPIfph3bQmUV3jONDK18rW/BiLpeLYl4TfbalzVkNQyDg9yP4ZQ
	7jqvZpVQ==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iUV-004I92-0g;
	Mon, 12 Jun 2023 14:25:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] swiotlb: unexport is_swiotlb_active
Date: Mon, 12 Jun 2023 16:25:42 +0200
Message-Id: <20230612142542.111581-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612142542.111581-1-hch@lst.de>
References: <20230612142542.111581-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drivers have no business looking at dma-mapping or swiotlb internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 775f7bb10ab184..1891faa3a6952e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -932,7 +932,6 @@ bool is_swiotlb_active(struct device *dev)
 
 	return mem && mem->nslabs;
 }
-EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.39.2

