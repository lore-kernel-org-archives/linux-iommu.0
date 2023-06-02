Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7D168B6
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 08:57:58 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4QXcDT4w7mz4x2YR
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 10:51:21 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
	by laurent.telenet-ops.be with bizsmtp
	id 48qo2A00B1tRZS8018qoyS; Fri, 02 Jun 2023 10:51:14 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50UO-00BhY9-RW;
	Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q50Uh-00APxS-V7;
	Fri, 02 Jun 2023 10:50:47 +0200
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
Subject: [PATCH v3 1/7] iopoll: Call cpu_relax() in busy loops
Date: Fri,  2 Jun 2023 10:50:36 +0200
Message-Id: <45c87bec3397fdd704376807f0eec5cc71be440f.1685692810.git.geert+renesas@glider.be>
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

It is considered good practice to call cpu_relax() in busy loops, see
Documentation/process/volatile-considered-harmful.rst.  This can not
only lower CPU power consumption or yield to a hyperthreaded twin
processor, but also allows an architecture to mitigate hardware issues
(e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
architecture-specific cpu_relax() implementation.

In addition, cpu_relax() is also a compiler barrier.  It is not
immediately obvious that the @op argument "function" will result in an
actual function call (e.g. in case of inlining).

Where a function call is a C sequence point, this is lost on inlining.
Therefore, with agressive enough optimization it might be possible for
the compiler to hoist the:

        (val) = op(args);

"load" out of the loop because it doesn't see the value changing. The
addition of cpu_relax() would inhibit this.

As the iopoll helpers lack calls to cpu_relax(), people are sometimes
reluctant to use them, and may fall back to open-coded polling loops
(including cpu_relax() calls) instead.

Fix this by adding calls to cpu_relax() to the iopoll helpers:
  - For the non-atomic case, it is sufficient to call cpu_relax() in
    case of a zero sleep-between-reads value, as a call to
    usleep_range() is a safe barrier otherwise.  However, it doesn't
    hurt to add the call regardless, for simplicity, and for similarity
    with the atomic case below.
  - For the atomic case, cpu_relax() must be called regardless of the
    sleep-between-reads value, as there is no guarantee all
    architecture-specific implementations of udelay() handle this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v3:
  - Add Reviewed-by,

v2:
  - Add Acked-by,
  - Add compiler barrier and inlining explanation (thanks, Peter!).
---
 include/linux/iopoll.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd8cae..0417360a6db9b0d6 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -53,6 +53,7 @@
 		} \
 		if (__sleep_us) \
 			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
@@ -95,6 +96,7 @@
 		} \
 		if (__delay_us) \
 			udelay(__delay_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.34.1

