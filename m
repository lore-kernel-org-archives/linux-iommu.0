From: Christoph Hellwig <hch@lst.de>
Subject: move the arm arch_dma_alloc implementation to common code
Date: Mon,  5 Nov 2018 13:19:22 +0100
Message-ID: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series moves the existing arm64 implementation of arch_dma_alloc and
arch_dma_free to common code given that it is not arm64-specific, and
then also uses it for csky.  Given how many architectures remap memory
for the DMA coherent implementation it should be usable for many more,
and the new cache flushing hook and the generic atomic pool are also
enablers for implementing the IOMMU API dma ops in common code in a
follow on series.
