Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555F1B912
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xk7UcK2JitL8EW9ZuelDDstRDKvC7QWgJZaUJF9iY8U=; b=gi/Nxa/zQEPmiix7WWxiDcuGaQ
	UXWNUHjwEt1uV9G92Cki/tGyE4Fxl9h7Uw5/VW0QgnJaASa9uwWV+jTL1gGuqDpKpZSeQCnal1E5J
	qEv0DtE4DOdI2krZd7P/X4lJwG0qNpuqNQ/o25wL+x7eif+U1SXUWZb60We+k49zNk8r/rmi/Tl4E
	SoZuJ+wCJxNYD4SRNiAsgCiNftC3faUgZS/u0LJDBvs8x175TAWPm0lP2tjb4Cswk2u4xkFViVI4h
	PPfk9D+URfM35VS9Ur/NWziYDFfRS0b4rQtJX0lZUcaXERtO1ykJfsTkvpjcFifFd0gsamVHI2h6y
	NlYvrHJA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iUQ-004I8Z-1u;
	Mon, 12 Jun 2023 14:25:50 +0000
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
Subject: [PATCH 1/3] xen/pci: add flag for PCI passthrough being possible
Date: Mon, 12 Jun 2023 16:25:40 +0200
Message-Id: <20230612142542.111581-2-hch@lst.de>
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

From: Juergen Gross <jgross@suse.com>

When running as a Xen PV guests passed through PCI devices only have a
chance to work if the Xen supplied memory map has some PCI space
reserved.

Add a flag xen_pv_pci_possible which will be set in early boot in case
the memory map has at least one area with the type E820_TYPE_RESERVED.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/xen/setup.c | 6 ++++++
 include/xen/xen.h    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index c2be3efb2ba0fa..716f76c4141651 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -43,6 +43,9 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 /* Number of pages released from the initial allocation. */
 unsigned long xen_released_pages;
 
+/* Memory map would allow PCI passthrough. */
+bool xen_pv_pci_possible;
+
 /* E820 map used during setting up memory. */
 static struct e820_table xen_e820_table __initdata;
 
@@ -804,6 +807,9 @@ char * __init xen_memory_setup(void)
 		chunk_size = size;
 		type = xen_e820_table.entries[i].type;
 
+		if (type == E820_TYPE_RESERVED)
+			xen_pv_pci_possible = true;
+
 		if (type == E820_TYPE_RAM) {
 			if (addr < mem_end) {
 				chunk_size = min(size, mem_end - addr);
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0efeb652f9b8fb..5eb0a974a11e7e 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -29,6 +29,12 @@ extern bool xen_pvh;
 
 extern uint32_t xen_start_flags;
 
+#ifdef CONFIG_XEN_PV
+extern bool xen_pv_pci_possible;
+#else
+#define xen_pv_pci_possible	0
+#endif
+
 #include <xen/interface/hvm/start_info.h>
 extern struct hvm_start_info pvh_start_info;
 
-- 
2.39.2

