From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Mon, 4 Feb 2013 20:53:32 +0100
Message-ID: <20130204195232.GA15278@8bytes.org>
References: <1359620050-28727-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359620050-28727-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2013 at 10:14:10AM +0200, Hiroshi Doyu wrote:
>  drivers/iommu/tegra-smmu.c |   61 ++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 25 deletions(-)

Okay, applied this patch to arm/tegra, but

>  static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
>  {
> -	BUG_ON(offs < 0x10);
> -	if (offs < 0x3c)
> -		return readl(smmu->regs[0] + offs - 0x10);
> -	BUG_ON(offs < 0x1f0);
> -	if (offs < 0x200)
> -		return readl(smmu->regs[1] + offs - 0x1f0);
> -	BUG_ON(offs < 0x228);
> -	if (offs < 0x284)
> -		return readl(smmu->regs[2] + offs - 0x228);
> +	int i;
> +
> +	for (i = 0; i < smmu->nregs; i++) {
> +		void __iomem *addr = smmu->regbase + offs;
> +
> +		BUG_ON(addr < smmu->regs[i]);
> +		if (addr <= smmu->rege[i])
> +			return readl(addr);
> +	}

This loop is purely for checking offset to be valid. And this loop is
repeated in the smmu_write() function. I queued a patch on-top to make
this more clear. Please double-check:

>From 08c4ae0b8955bd818bdfd438a684bd5f8db7fb67 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Date: Mon, 4 Feb 2013 20:40:58 +0100
Subject: [PATCH 1/1] iommu/tegra: smmu: Use helper function to check for
 valid register offset

Do not repeat the checking loop in the read and write
functions. Use a single helper function for that check and
call it in both accessors.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3e07e8b..5ea8d66 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -327,36 +327,37 @@ static struct smmu_device *smmu_handle; /* unique for a system */
 /*
  *	SMMU register accessors
  */
-static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
+static bool inline smmu_valid_reg(struct smmu_device *smmu,
+				  void __iomem *addr)
 {
 	int i;
 
 	for (i = 0; i < smmu->nregs; i++) {
-		void __iomem *addr = smmu->regbase + offs;
-
-		BUG_ON(addr < smmu->regs[i]);
+		if (addr < smmu->regs[i])
+			break;
 		if (addr <= smmu->rege[i])
-			return readl(addr);
+			return true;
 	}
 
-	BUG();
+	return false;
 }
 
-static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
+static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
 {
-	int i;
+	void __iomem *addr = smmu->regbase + offs;
 
-	for (i = 0; i < smmu->nregs; i++) {
-		void __iomem *addr = smmu->regbase + offs;
+	BUG_ON(!smmu_valid_reg(smmu, addr));
 
-		BUG_ON(addr < smmu->regs[i]);
-		if (addr <= smmu->rege[i]) {
-			writel(val, addr);
-			return;
-		}
-	}
+	return readl(addr);
+}
+
+static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
+{
+	void __iomem *addr = smmu->regbase + offs;
+
+	BUG_ON(!smmu_valid_reg(smmu, addr));
 
-	BUG();
+	writel(val, addr);
 }
 
 #define VA_PAGE_TO_PA(va, page)	\
-- 
1.7.9.5
