From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/vt-d: Ratelimit fault handler
Date: Tue, 15 Mar 2016 10:10:51 -0700
Message-ID: <1458061851.11972.193.camel@perches.com>
References: <20160315163503.2875.49980.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160315163503.2875.49980.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, dwmw2@infradead.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2016-03-15 at 10:35 -0600, Alex Williamson wrote:
> Fault rates can easily overwhelm the console and make the system
> unresponsive.=A0=A0Ratelimit to allow an opportunity for maintenance.

A few suggestions:

o Use a single ratelimit state.
o The multiple lines output are unnecessary and hard to grep
=A0 in the dmesg output because of inconsistent prefixing as
=A0 second and subsequent output lines are not prefixed by pr_fmt.
o The DMAR prefix on the second block is also unnecessary as
=A0 it's already prefixed by pr_fmt
o Coalesce the formats for easier grep.

so maybe:
---
=A0drivers/iommu/dmar.c | 28 ++++++++++++++++------------
=A01 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8ffd756..59dcaaa 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1575,23 +1575,27 @@ static int dmar_fault_do_one(struct intel_iommu=
 *iommu, int type,
=A0{
=A0	const char *reason;
=A0	int fault_type;
+	static DEFINE_RATELIMIT_STATE(rs,
+				=A0=A0=A0=A0=A0=A0DEFAULT_RATELIMIT_INTERVAL,
+				=A0=A0=A0=A0=A0=A0DEFAULT_RATELIMIT_BURST);
+
+	if (__ratelimit(&rs))
+		return 0;
=A0
=A0	reason =3D dmar_get_fault_reason(fault_reason, &fault_type);
=A0
=A0	if (fault_type =3D=3D INTR_REMAP)
-		pr_err("INTR-REMAP: Request device [[%02x:%02x.%d] "
-		=A0=A0=A0=A0=A0=A0=A0"fault index %llx\n"
-			"INTR-REMAP:[fault reason %02d] %s\n",
-			(source_id >> 8), PCI_SLOT(source_id & 0xFF),
-			PCI_FUNC(source_id & 0xFF), addr >> 48,
-			fault_reason, reason);
+		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx =
[fault reason %02d] %s\n",
+		=A0=A0=A0=A0=A0=A0=A0source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		=A0=A0=A0=A0=A0=A0=A0PCI_FUNC(source_id & 0xFF), addr >> 48,
+		=A0=A0=A0=A0=A0=A0=A0fault_reason, reason);
=A0	else
-		pr_err("DMAR:[%s] Request device [%02x:%02x.%d] "
-		=A0=A0=A0=A0=A0=A0=A0"fault addr %llx \n"
-		=A0=A0=A0=A0=A0=A0=A0"DMAR:[fault reason %02d] %s\n",
-		=A0=A0=A0=A0=A0=A0=A0(type ? "DMA Read" : "DMA Write"),
-		=A0=A0=A0=A0=A0=A0=A0(source_id >> 8), PCI_SLOT(source_id & 0xFF),
-		=A0=A0=A0=A0=A0=A0=A0PCI_FUNC(source_id & 0xFF), addr, fault_reason,=
 reason);
+		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault re=
ason %02d] %s\n",
+		=A0=A0=A0=A0=A0=A0=A0type ? "DMA Read" : "DMA Write",
+		=A0=A0=A0=A0=A0=A0=A0source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		=A0=A0=A0=A0=A0=A0=A0PCI_FUNC(source_id & 0xFF), addr,
+		=A0=A0=A0=A0=A0=A0=A0fault_reason, reason);
+
=A0	return 0;
=A0}
=A0
