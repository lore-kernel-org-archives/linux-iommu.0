From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 02/12] amba: Add Kconfig file
Date: Fri,  7 Nov 2014 17:00:53 +0100
Message-ID: <1415376063-17205-3-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Rather than duplicate the ARM_AMBA Kconfig symbol in both 32-bit and
64-bit ARM architectures, move the common definition to drivers/amba
where dependent drivers will be located.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Hi Russell, Will, Catalin,

As explained in the cover-letter there are tight dependencies between the
patches in this series, so for simplicity I'd like to take this patch through
the Tegra tree with your Acked-by.

Thanks,
Thierry

 arch/arm/Kconfig     | 3 ---
 arch/arm64/Kconfig   | 3 ---
 drivers/amba/Kconfig | 2 ++
 3 files changed, 2 insertions(+), 6 deletions(-)
 create mode 100644 drivers/amba/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9d580d0e89a9..21fbf144a9fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1242,9 +1242,6 @@ source "arch/arm/common/Kconfig"
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config ISA
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66b0b519ea02..275d635041d6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,9 +167,6 @@ endmenu
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config PCI
 	bool "PCI support"
 	help
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
new file mode 100644
index 000000000000..d1cba6a9b3b8
--- /dev/null
+++ b/drivers/amba/Kconfig
@@ -0,0 +1,2 @@
+config ARM_AMBA
+	bool
-- 
2.1.3
