From: Christoph Hellwig <hch@lst.de>
Subject: add config symbols for arch_{setup,teardown}_dma_ops
Date: Mon,  4 Feb 2019 09:14:18 +0100
Message-ID: <20190204081420.15083-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Cc: iommu@lists.linux-foundation.org, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series adds kconfig symbols to indicate that the architecture
provides the arch_setup_dma_ops and arch_teardown_dma_ops hooks.

This avoids polluting dma-mapping.h which is included by just about
every driver with implementation details, and also removes some
clutter.
