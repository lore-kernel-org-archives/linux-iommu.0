From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Thu, 16 Jan 2014 13:44:20 +0100
Message-ID: <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Grant Likely <grant.likely@linaro.org>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Andreas Herrmann <andreas.herrmann@calxeda.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

arm-smmu driver uses of_parse_phandle_with_args when parsing DT
information to determine stream IDs for a master device.
Thus the number of stream IDs per master device is bound by
MAX_PHANDLE_ARGS.

To support Calxeda ECX-2000 hardware arm-smmu driver requires a
slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
stream IDs for one master device.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 include/linux/of.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 276c546..0807af8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -67,7 +67,7 @@ struct device_node {
 #endif
 };
 
-#define MAX_PHANDLE_ARGS 8
+#define MAX_PHANDLE_ARGS 10
 struct of_phandle_args {
 	struct device_node *np;
 	int args_count;
-- 
1.7.9.5
