Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D33876A1
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181453; cv=none; b=WM75BP99paQFtFztp5x+fEv9dJ7rzDA8sxI8KpFoA7Zoh7yXeagNp0MYaw0HZYFGvHl9qfun6Ba23GwECzMSJHPCWsijMvoF0jTOq2FgQ2d4Fqok3eeFDwgQ22+p0/94tqSACkbGAfZX0xDxDyG4lgy00R2K9pXHCgN7ockTxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181453; c=relaxed/simple;
	bh=O2V2DsT0wchdMEeMQ9UoQItef140NCwlYATi/kazat4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNIznhtMqlSVU/WIi5rxEwPPvh694mITN4Zck5Ika5Jp0q93S17nXFcBhbAyDIh0FZ9pMXZ8UNGqDRk0ljKQEyn3ciP1sFeKi1CBCrcqYvbaqcsr7Iug5LWvpaQp43eTjyLd+Y0WRmoH/ryR0P/aI24pc5bM3gYZdZoyJ8udXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu3mAqX5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu3mAqX5"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so29715176d6.1
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785181450; x=1785786250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALFj5mx6ITSwQDeWBA78YJn0TzhnH9OoHmiUjwscou4=;
        b=Uu3mAqX52cOY2FkWQGF0A6bAro1B258JxHqbYH283j+xLZ1VR0geC3JFKKR9o4FPlw
         o6z5p/EmlZ19MqBfyWH+9AgqPDMh26KZPmZ9mV1LHqov2TxamT0cIBgBjw98aqTiXMp6
         Of5700vED+HoYOllIsU4AYe7xsIybuZp3dxeTN37OmxOFPAflWiKTJHhrlPPLvQvekQg
         q0o6eOboxi8VOTH+zTquSbCLnGIGui0TM1xa5S6bpo24sX2gB4fhFJxJ1YxTXAqZalWY
         ACuaDkqOD2crB7FP2tCa++DsI5+B6eaPjAY6x//FGqhE7DIZHuq3iLV+5KM6llYgKJNk
         A+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785181450; x=1785786250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALFj5mx6ITSwQDeWBA78YJn0TzhnH9OoHmiUjwscou4=;
        b=culDroT5gapu0JBIG0cu5IjhT69Wr7RKKZA8HHaZn00e4WUApuhQD+1/7oka5hFjc/
         7dMZbpwkYH/nW/3piJ/PTHbWvkgcd6MfEJCiPldYV4Vy3pksSW2N241P3bqowl8XnrFo
         bRz6VizokTfAAhiizGmt4hHd7yrLC7tNeluUdSVEmb0qsZpeKSzJmI+1RfKVHmahK2S4
         igwAGbaob2LkNor7XFbmn9ByzDaHEavq3RVonXcvzkRspCOYU0ZgzvSjsuuvRVcUS+sL
         Z5hg5PImQpP9+ZXXF7pGqQFe9QZQ300rwOY/XJyS39Zkqt01wCv2gBR1nUP0vsAvwQNB
         nRJA==
X-Gm-Message-State: AOJu0Yz+BAvtz4UCNHzSPsSuo9hvsiAxrJG+NTrBZZMOeY7DK3VQ0qdr
	1Q6VWVu/IiCX6PmCYmVynfdvZnqNfu0m30oTklxA11/s1xxLe0O7WV+K0gTLEzZq
X-Gm-Gg: AR+sD11WnzbZ3UGaBKjHZd71iCmD3scmC0HLg2yidr4SrB0Xe7JAzOqh+IT/rg3lMTj
	Xeqv+QOYjLXaTGpmAN57OKwcw6QjefFi0GmoDvDwenRrwOPKVoSqJDruH5MvfMEZtHisL2bRyLS
	hABTTWVLjkMHyhCIgw6/Sayoeyo5o5e/a5TNY2mhOG5A/9GQgOI8lqwAIHQ3V+ufM1TZ81q++LL
	UNjsMhEMcbMC1XBBtYJeUekWmInDb5rSLBAZadHzEfKgtObRf1b6Z8BIkz1GRym141gT/tvrQg4
	t8Fln5jQvUytsMO19Xmo53rT9IqmOUGHh0Y5JpmTwwDGgtph+Ha6tONym3BZKB3iNyBSG4RLFRL
	trNXwXlyL831Mq6ksVOup7z3PJP5sZp5nnCs2IjPuL9oxYEEPWi1ChB6ezYPkUx/tbsH5iLfnKz
	f7QjTxCts73XEcgoqNO/r1k120c3pzVBfARacGouXOyBbtgRTYvfYkaawjV/du/VJo8b6OUdlNa
	RLgvc/gkR3sugEWrG+PIXcCInwezGZprqe9gBtaVSvZda5MRsgp9vo=
X-Received: by 2002:a05:6214:2e4a:b0:8e9:f5de:d631 with SMTP id 6a1803df08f44-90812885555mr11933016d6.50.1785181450036;
        Mon, 27 Jul 2026 12:44:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e871c5a7sm71383086d6.44.2026.07.27.12.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:44:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/fsl-pamu: modernize IRQ lookup, MMIO mapping, and pointer types
Date: Mon, 27 Jul 2026 12:44:07 -0700
Message-ID: <20260727194407.10555-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq() and of_iomap()
with devm_platform_ioremap_resource(), removing manual iounmap() and
the of_irq.h include.

Retype all PAMU register base pointers from unsigned long to
void __iomem with proper __iomem annotations throughout
get_pamu_cap_values(), setup_one_pamu(), and fsl_pamu_probe(),
eliminating unsafe casts. Initialize size to 0 to prevent use of an
uninitialized value if of_get_address() fails.

devm_platform_ioremap_resource(pdev, 0) is safe here: all 10 DTSI
files define non-overlapping child pamu@N reg values, each exactly
0x1000 bytes, translated correctly via the parent ranges property.
The t4240 special case (no children, parent node probed directly with
reg = <0x20000 0x6000>) also maps correctly as the loop iterates
over the full region in PAMU_OFFSET steps.

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/iommu/fsl_pamu.c | 49 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c83bbc3faad5..86f221e21b6e 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 #include <asm/mpc85xx.h>
@@ -402,26 +401,25 @@ static void setup_omt(struct ome *omt)
  * Get the maximum number of PAACT table entries
  * and subwindows supported by PAMU
  */
-static void get_pamu_cap_values(unsigned long pamu_reg_base)
+static void get_pamu_cap_values(void __iomem *pamu_reg_base)
 {
 	u32 pc_val;
 
-	pc_val = in_be32((u32 *)(pamu_reg_base + PAMU_PC3));
+	pc_val = in_be32(pamu_reg_base + PAMU_PC3);
 	/* Maximum number of subwindows per liodn */
 	max_subwindow_count = 1 << (1 + PAMU_PC3_MWCE(pc_val));
 }
 
 /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */
-static int setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu_reg_size,
+static int setup_one_pamu(void __iomem *pamu_reg_base, unsigned long pamu_reg_size,
 			  phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
 			  phys_addr_t omt_phys)
 {
-	u32 *pc;
-	struct pamu_mmap_regs *pamu_regs;
+	u32 __iomem *pc;
+	struct pamu_mmap_regs __iomem *pamu_regs;
 
-	pc = (u32 *) (pamu_reg_base + PAMU_PC);
-	pamu_regs = (struct pamu_mmap_regs *)
-		(pamu_reg_base + PAMU_MMAP_REGS_BASE);
+	pc = pamu_reg_base + PAMU_PC;
+	pamu_regs = pamu_reg_base + PAMU_MMAP_REGS_BASE;
 
 	/* set up pointers to corenet control blocks */
 
@@ -449,8 +447,7 @@ static int setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu_reg_si
 	 * & enable PAMU access violation interrupts.
 	 */
 
-	out_be32((u32 *)(pamu_reg_base + PAMU_PICS),
-		 PAMU_ACCESS_VIOLATION_ENABLE);
+	out_be32(pamu_reg_base + PAMU_PICS, PAMU_ACCESS_VIOLATION_ENABLE);
 	out_be32(pc, PAMU_PC_PE | PAMU_PC_OCE | PAMU_PC_SPCC | PAMU_PC_PPCC);
 	return 0;
 }
@@ -749,10 +746,10 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	struct ccsr_guts __iomem *guts_regs = NULL;
 	u32 pamubypenr, pamu_counter;
 	unsigned long pamu_reg_off;
-	unsigned long pamu_reg_base;
+	void __iomem *pamu_reg_base;
 	struct pamu_isr_data *data = NULL;
 	struct device_node *guts_node;
-	u64 size;
+	u64 size = 0;
 	struct page *p;
 	int ret = 0;
 	int irq;
@@ -773,25 +770,22 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (WARN_ON(probed))
 		return -EBUSY;
 
-	pamu_regs = of_iomap(dev->of_node, 0);
-	if (!pamu_regs) {
-		dev_err(dev, "ioremap of PAMU node failed\n");
-		return -ENOMEM;
-	}
-	of_get_address(dev->of_node, 0, &size, NULL);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	irq = irq_of_parse_and_map(dev->of_node, 0);
-	if (!irq) {
-		dev_warn(dev, "no interrupts listed in PAMU node\n");
-		goto error;
-	}
+	pamu_regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pamu_regs))
+		return PTR_ERR(pamu_regs);
 
 	data = kzalloc_obj(*data);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
 	}
+
 	data->pamu_reg_base = pamu_regs;
+	of_get_address(dev->of_node, 0, &size, NULL);
 	data->count = size / PAMU_OFFSET;
 
 	/* The ISR needs access to the regs, so we won't iounmap them */
@@ -817,7 +811,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	}
 
 	/* read in the PAMU capability registers */
-	get_pamu_cap_values((unsigned long)pamu_regs);
+	get_pamu_cap_values(pamu_regs);
 	/*
 	 * To simplify the allocation of a coherency domain, we allocate the
 	 * PAACT and the OMT in the same memory buffer.  Unfortunately, this
@@ -882,7 +876,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	for (pamu_reg_off = 0, pamu_counter = 0x80000000; pamu_reg_off < size;
 	     pamu_reg_off += PAMU_OFFSET, pamu_counter >>= 1) {
 
-		pamu_reg_base = (unsigned long)pamu_regs + pamu_reg_off;
+		pamu_reg_base = pamu_regs + pamu_reg_off;
 		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
 			       spaact_phys, omt_phys);
 		/* Disable PAMU bypass for this PAMU */
@@ -910,9 +904,6 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 
 	kfree_sensitive(data);
 
-	if (pamu_regs)
-		iounmap(pamu_regs);
-
 	if (guts_regs)
 		iounmap(guts_regs);
 
-- 
2.55.0

