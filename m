From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
Date: Thu, 10 Oct 2013 01:10:03 +0200
Message-ID: <20131009231003.GM2935@alberich>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
	<20131008151007.GD21189@mudshark.cambridge.arm.com>
	<20131008152008.GE2935@alberich> <20131008164021.GH2935@alberich>
	<20131008165920.GG21189@mudshark.cambridge.arm.com>
	<52545266.6010400@gmail.com>
	<20131009100917.GB5985@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131009100917.GB5985-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 09, 2013 at 06:09:17AM -0400, Will Deacon wrote:
> On Tue, Oct 08, 2013 at 07:43:50PM +0100, Rob Herring wrote:
> > On 10/08/2013 11:59 AM, Will Deacon wrote:
> > > On Tue, Oct 08, 2013 at 05:40:21PM +0100, Andreas Herrmann wrote:
> > >> On Tue, Oct 08, 2013 at 05:20:08PM +0200, Andreas Herrmann wrote:
> > >> To be more specific: For SATA I'd need to specify 10 StreamIds. This
> > >> would
> > >>
> > >> (1) exceed MAX_MASTER_STREAMIDS (currently it's 8)
> > >>
> > >>    (Can easily be fixed by adapting a macro.)
> > >>
> > >> (2) exceed number of available SMR groups to map the IDs to a context.
> > >>
> > >>    This can be solved by caclulating an appropriate mask for the
> > >>    mapping (but with a non-power-of-two number of StreamIds that's
> > >>    already non-trivial -- for the trivial case I have some code to do
> > >>    this).
> > >>
> > >> Both problems are avoided by introducing this patch -- use
> > >> smr_mask_bits to map all StreamIDs to the same context and be done
> > >> with it. (for the "single-master-SMMU" case)
> > > 
> > > The problem is, this information *really* doesn't belong in the device tree,
> > > but I think computing the general case dynamically is incredibly difficult
> > > too (and requires *complete* topological information in the device-tree, so
> > > you don't accidentally pull in other devices).
> > 
> > Couldn't this information be implied from the DT when you have no
> > streamID and only a single mmu-master?
> 
> It's still fairly fragile though, since you (a) don't know that the stream
> IDs of the master are matchable by the SMRs (if we had the stream IDs, we
> can check this) and (b) you can still end up pulling devices into your
> address space that would otherwise happily operate using passthrough.

FYI, for SATA I'd have to specify below IDs (which requires some other
minor adaptions). I really would like to avoid specification of all
these StreamIDs and rather use stream matching with an appropriate
mask.

I can't end up pulling other devices into that mapping. It's just this
single master device at this SMMU.

And I also think that this "mask-all-stream-ids" option belongs to the
device tree as an hint to the driver that it is sane to use
smr_mask_bits as a mask for stream matching for this particular SMMU.


Andreas

---
ecx-2000, iommu/arm-smmu, of: Add all 10 StreamIDs for sata-smmu

Unfortunately this requires adaptions of MAX_MASTER_STREAMIDS and
MAX_PHANDLE_ARGS.

It still won't work with the current arm-smmu driver as it strictly
uses one SMR group for each StreamID. (But the corresponding SMMU has
just 4 SMR groups).

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/ecx-2000.dts    |    2 +-
 arch/arm/boot/dts/ecx-common.dtsi |    2 +-
 drivers/iommu/arm-smmu.c          |    2 +-
 include/linux/of.h                |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 270f052..3904c2b 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -135,7 +135,7 @@
 		smmu_sata: smmu@920180000 {
 			compatible = "arm,mmu-400";
 			reg = <0x00000009 0x20180000 0x10000>;
-			mmu-masters = <&sata>;
+			mmu-masters = <&sata 0 1 2 3 4 5 6 7 8 9>;
 			#global-interrupts = <1>;
 			interrupts = <0 114 4 0 114 4>;
 			arm,smmu-secure-config-access;
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index 50e401e..961dc5b 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -35,7 +35,7 @@
 					     &combophy0 3>;
 			calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
 			calxeda,led-order = <4 0 1 2 3>;
-			#stream-id-cells = <0>;
+			#stream-id-cells = <10>;
 		};
 
 		sdhci@ffe0e000 {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4e8ceab..cd370f7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -55,7 +55,7 @@
 #define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 2)
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		8
+#define MAX_MASTER_STREAMIDS		10
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
diff --git a/include/linux/of.h b/include/linux/of.h
index f95aee3..47f4857 100644
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
