From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/13] set_memory.h: provide set_memory_{en,de}crypted stubs
Date: Mon,  5 Mar 2018 09:46:52 -0800
Message-ID: <20180305174655.9878-11-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305174655.9878-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw2@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/set_memory.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e5140648f638..da5178216da5 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
+static inline int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+
+static inline int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.14.2
