From: Stuart Yoder <stuart.yoder@nxp.com>
Subject: RFC: extend IOMMU attributes
Date: Thu, 18 Feb 2016 16:16:26 +0000
Message-ID: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, Peter Newton <peter.newton@nxp.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Varun Sethi <V.Sethi@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg and Will,

We are implementing support for some specialized NXP SoC network
devices and have the desire to extend the mapping attributes beyond
those currently in iommu.h. (I see there is a recent proposal to
add an IOMMU_MMIO flag)

What we have right now in Linux is a least-common-denominator set of
attributes, while for the ARM SMMU there is a much richer set of
attributes that seem useful to support. Specifically, we have one
SoC device we're dealing with right now that is the target of DMA
that functionally requires a "cacheable, non-shareable" attribute
in its SMMU mapping.

In addition, there are many other attributes such as r/w allocate
hints, transient hints, write-back/write-thru, etc in the SMMU.

We wanted to see what your thinking is with respect to the
direction the Linux IOMMU layer will head over the longer term with
respect to attributes.

Is there anything problematic with continuing to grow the
attributes in iommu.h?...e.g.:

 #define IOMMU_READ            (1 << 0)
 #define IOMMU_WRITE           (1 << 1)
-#define IOMMU_CACHE           (1 << 2) /* DMA cache coherency */
+#define IOMMU_CACHE_COHERENT  (1 << 2) /* cacheable and coherent */
 #define IOMMU_NOEXEC          (1 << 3)
 #define IOMMU_MMIO            (1 << 4) /* e.g. things like MSI doorbells */
+#define IOMMU_CACHEABLE       (1 << 5) /* cacheable, not coherent */
+#define IOMMU_CACHE_ALLOCATE  (1 << 6) /* hint to allocate in the cache */

Also, are we willing to let somewhat architecture specific flags
onto that list?  For, example the ARM 'transient' hint.

Another potential direction would be to provide some approach
where IOMMU PTE attributes could be somehow derived from a
corresponding MMU PTE in an arch-specific manner and the IOMMU
API itself would not have to explicitly define all possible
attributes.

Thoughts?

Thanks,
Stuart
