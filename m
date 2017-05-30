From: Ray Jui <ray.jui@broadcom.com>
Subject: Device address specific mapping of arm,mmu-500
Date: Mon, 29 May 2017 18:18:45 -0700
Message-ID: <1b79efe2-6835-7a7a-f5ad-361391a7b967@broadcom.com>
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
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ray.jui@broadcom.com
List-Id: iommu@lists.linux-foundation.org

Hi All,

I'm writing to check with you to see if the latest arm-smmu.c driver in
v4.12-rc Linux for smmu-500 can support mapping that is only specific to
a particular physical address range while leave the rest still to be
handled by the client device. I believe this can already be supported by
the device tree binding of the generic IOMMU framework; however, it is
not clear to me whether or not the arm-smmu.c driver can support it.

To give you some background information:

We have a SoC that has PCIe root complex that has a build-in logic block
to forward MSI writes to ARM GICv3 ITS. Unfortunately, this logic block
has a HW bug that causes the MSI writes not parsed properly and can
potentially corrupt data in the internal FIFO. A workaround is to have
ARM MMU-500 takes care of all inbound transactions. I found that is
working after hooking up our PCIe root complex to MMU-500; however, even
with this optimized arm-smmu driver in v4.12, I'm still seeing a
significant Ethernet throughput drop in both the TX and RX directions.
The throughput drop is very significant at around 50% (but is already
much improved compared to other prior kernel versions at 70~90%).

One alternative is to only use MMU-500 for MSI writes towards
GITS_TRANSLATER register in the GICv3, i.e., if I can define a specific
region of physical address that I want MMU-500 to act on and leave the
rest of inbound transactions to be handled directly by our PCIe
controller, it can potentially work around the HW bug we have and at the
same time achieve optimal throughput.

Any feedback from you is greatly appreciated!

Best regards,

Ray
