Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217741102
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 07:23:20 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4Pmd8Y5gZjz4x3LF
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 09:14:21 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by xavier.telenet-ops.be with bizsmtp
	id e7EC290021C8whw017ECJl; Wed, 29 Mar 2023 09:14:13 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1phPzr-00FCqK-UX;
	Wed, 29 Mar 2023 09:14:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1phQ0Z-006ZvT-V8;
	Wed, 29 Mar 2023 09:14:11 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Desnes Nunes <desnesn@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>,
	noreply@ellerman.id.au
Subject: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Date: Wed, 29 Mar 2023 09:14:05 +0200
Message-Id: <20230329071405.1568021-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 32-bit without LPAE:

    kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
    kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
    kernel/dma/debug.c: In function ‘dump_show’:
    kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]

Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/dma/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 676142072d997b6a..f190651bcaddc9e9 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
 					 type2name[entry->type], idx,
 					 phys_addr(entry), entry->pfn,
 					 entry->dev_addr, entry->size,
-					 cln, dir2name[entry->direction],
+					 &cln, dir2name[entry->direction],
 					 maperr2str[entry->map_err_type]);
 			}
 		}
@@ -565,13 +565,13 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
 				   phys_addr(entry), entry->pfn,
 				   entry->dev_addr, entry->size,
-				   cln, dir2name[entry->direction],
+				   &cln, dir2name[entry->direction],
 				   maperr2str[entry->map_err_type]);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
-- 
2.34.1

