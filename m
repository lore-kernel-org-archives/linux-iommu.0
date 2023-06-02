Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE0168BF
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 08:57:58 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4QXcDT4lmZz4x24M
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 10:51:21 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
	by laurent.telenet-ops.be with bizsmtp
	id 48qo2A00F1tRZS8018qoyb; Fri, 02 Jun 2023 10:51:14 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50UP-00BhYW-0P;
	Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50Ui-00APxr-3g;
	Fri, 02 Jun 2023 10:50:48 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dejin Zheng <zhengdejin5@gmail.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 7/7] iommu/ipmmu-vmsa: Convert to read_poll_timeout_atomic()
Date: Fri,  2 Jun 2023 10:50:42 +0200
Message-Id: <dd0ba3ebc63a4b2ef1b59b798a0a7ef445af4b3b.1685692810.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
References: <cover.1685692810.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use read_poll_timeout_atomic() instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/iommu/ipmmu-vmsa.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b90ace..3b58a8ea3bdef190 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
@@ -253,17 +254,13 @@ static void ipmmu_imuctr_write(struct ipmmu_vmsa_device *mmu,
 /* Wait for any pending TLB invalidations to complete */
 static void ipmmu_tlb_sync(struct ipmmu_vmsa_domain *domain)
 {
-	unsigned int count = 0;
+	u32 val;
 
-	while (ipmmu_ctx_read_root(domain, IMCTR) & IMCTR_FLUSH) {
-		cpu_relax();
-		if (++count == TLB_LOOP_TIMEOUT) {
-			dev_err_ratelimited(domain->mmu->dev,
+	if (read_poll_timeout_atomic(ipmmu_ctx_read_root, val,
+				     !(val & IMCTR_FLUSH), 1, TLB_LOOP_TIMEOUT,
+				     false, domain, IMCTR))
+		dev_err_ratelimited(domain->mmu->dev,
 			"TLB sync timed out -- MMU may be deadlocked\n");
-			return;
-		}
-		udelay(1);
-	}
 }
 
 static void ipmmu_tlb_invalidate(struct ipmmu_vmsa_domain *domain)
-- 
2.34.1

