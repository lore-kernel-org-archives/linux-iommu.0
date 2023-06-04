Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5EB33F2
	for <iommu@lists.linux.dev>; Sun,  4 Jun 2023 13:52:55 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.43])
	by gateway (Coremail) with SMTP id _____8BxV_G+lnxkA0cEAA--.8812S3;
	Sun, 04 Jun 2023 21:50:54 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTu+lnxkpC+JAA--.24334S2;
	Sun, 04 Jun 2023 21:50:54 +0800 (CST)
From: Sui Jingfeng <suijingfeng@loongson.cn>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH] dma/Kconfig: fix a typo
Date: Sun,  4 Jun 2023 21:50:54 +0800
Message-Id: <20230604135054.3055185-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfTu+lnxkpC+JAA--.24334S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtrWkZryrWFWkKF45ZF15CFg_yoW3Jwb_Jw
	10qrW8Wr1kZrZ2gFWUJFZ3XFn0qa4jgFyF9w17tF429347Xwn8Ww4fXFn3JFnxGw4kWFZ8
	uFZ5Zr1kAF4SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
	xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
	b7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
	AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
	6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
	xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

'thing' -> 'think'

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 kernel/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 6677d0e64d27..fd35ed4c67b8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -39,7 +39,7 @@ config ARCH_HAS_DMA_SET_MASK
 #
 # Select this option if the architecture needs special handling for
 # DMA_ATTR_WRITE_COMBINE.  Normally the "uncached" mapping should be what
-# people thing of when saying write combine, so very few platforms should
+# people think of when saying write combine, so very few platforms should
 # need to enable this.
 #
 config ARCH_HAS_DMA_WRITE_COMBINE
-- 
2.25.1

