Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F63168C0
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 08:57:58 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4QXcDT5CD6z4x5gw
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 10:51:21 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
	by andre.telenet-ops.be with bizsmtp
	id 48qo2A00F1tRZS8018qoWX; Fri, 02 Jun 2023 10:51:13 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50UO-00BhYI-U1;
	Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50Ui-00APxd-1F;
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
Subject: [PATCH v3 4/7] clk: renesas: mstp: Convert to readl_poll_timeout_atomic()
Date: Fri,  2 Jun 2023 10:50:39 +0200
Message-Id: <bce7d0bdd80c800aa150f1868b610b7d94f4cc66.1685692810.git.geert+renesas@glider.be>
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

As typically no retries are needed, 10 µs is a suitable timeout value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Polling measurements done on R-Mobile APE6 and A1, R-Car H1, and
SH-Mobile AG5.

v3:
  - New.
---
 drivers/clk/renesas/clk-mstp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 6e3c4a9c16b07ae9..e96457371b4cce88 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -14,6 +14,7 @@
 #include <linux/clk/renesas.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm_clock.h>
@@ -78,8 +79,8 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	struct mstp_clock_group *group = clock->group;
 	u32 bitmask = BIT(clock->bit_index);
 	unsigned long flags;
-	unsigned int i;
 	u32 value;
+	int ret;
 
 	spin_lock_irqsave(&group->lock, flags);
 
@@ -102,19 +103,14 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	if (!enable || !group->mstpsr)
 		return 0;
 
-	for (i = 1000; i > 0; --i) {
-		if (!(cpg_mstp_read(group, group->mstpsr) & bitmask))
-			break;
-		cpu_relax();
-	}
-
-	if (!i) {
+	/* group->width_8bit is always false if group->mstpsr is present */
+	ret = readl_poll_timeout_atomic(group->mstpsr, value,
+					!(value & bitmask), 0, 10);
+	if (ret)
 		pr_err("%s: failed to enable %p[%d]\n", __func__,
 		       group->smstpcr, clock->bit_index);
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int cpg_mstp_clock_enable(struct clk_hw *hw)
-- 
2.34.1

