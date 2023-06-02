Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB58838
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 08:57:59 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4QXcDT517wz4x2XJ
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 10:51:21 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
	by andre.telenet-ops.be with bizsmtp
	id 48qo2A00L1tRZS8018qoWZ; Fri, 02 Jun 2023 10:51:13 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50UO-00BhYR-Vj;
	Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50Ui-00APxl-2q;
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
Subject: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
Date: Fri,  2 Jun 2023 10:50:41 +0200
Message-Id: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
References: <cover.1685692810.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use readl_poll_timeout_atomic() instead of open-coding the same
operation.

  1. rmobile_pd_power_down(): as typically less than 20 retries are
     needed, PSTR_RETRIES (100) µs is a suitable timeout value.

  2. __rmobile_pd_power_up(): the old method of first polling some
     cycles with a 1 µs delay, followed by more polling cycles without
     any delay didn't make much sense, as the latter was insignificant
     compared to the former.  Furthermore, typically no retries are
     needed.  Hence just retain the polling with delay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Polling measurements done on R-Mobile APE6 and A1, and SH-Mobile AG5.

v3:
  - New.
---
 drivers/soc/renesas/rmobile-sysc.c | 31 ++++++++++--------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index 728ebac98e14a5cc..5d621c35fba1116a 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -12,6 +12,8 @@
 #include <linux/clk/renesas.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm.h>
@@ -19,8 +21,6 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 
-#include <asm/io.h>
-
 /* SYSC */
 #define SPDCR		0x08	/* SYS Power Down Control Register */
 #define SWUCR		0x14	/* SYS Wakeup Control Register */
@@ -47,6 +47,7 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
 	unsigned int mask = BIT(rmobile_pd->bit_shift);
+	u32 val;
 
 	if (rmobile_pd->suspend) {
 		int ret = rmobile_pd->suspend();
@@ -56,14 +57,10 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 	}
 
 	if (readl(rmobile_pd->base + PSTR) & mask) {
-		unsigned int retry_count;
 		writel(mask, rmobile_pd->base + SPDCR);
 
-		for (retry_count = PSTR_RETRIES; retry_count; retry_count--) {
-			if (!(readl(rmobile_pd->base + SPDCR) & mask))
-				break;
-			cpu_relax();
-		}
+		readl_poll_timeout_atomic(rmobile_pd->base + SPDCR, val,
+					  !(val & mask), 0, PSTR_RETRIES);
 	}
 
 	pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n", genpd->name, mask,
@@ -74,25 +71,17 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 
 static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
 {
-	unsigned int mask = BIT(rmobile_pd->bit_shift);
-	unsigned int retry_count;
-	int ret = 0;
+	unsigned int val, mask = BIT(rmobile_pd->bit_shift);
+	int ret;
 
 	if (readl(rmobile_pd->base + PSTR) & mask)
 		return ret;
 
 	writel(mask, rmobile_pd->base + SWUCR);
 
-	for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
-		if (!(readl(rmobile_pd->base + SWUCR) & mask))
-			break;
-		if (retry_count > PSTR_RETRIES)
-			udelay(PSTR_DELAY_US);
-		else
-			cpu_relax();
-	}
-	if (!retry_count)
-		ret = -EIO;
+	ret = readl_poll_timeout_atomic(rmobile_pd->base + SWUCR, val,
+					(val & mask), PSTR_DELAY_US,
+					PSTR_RETRIES * PSTR_DELAY_US);
 
 	pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
 		 rmobile_pd->genpd.name, mask,
-- 
2.34.1

