From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
Date: Tue, 13 Jan 2015 16:02:08 +0800
Message-ID: <1421136128.27675.58.camel@mtksdaap41>
References: <cover.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1421086706.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux@arm.linux.org.uk, sakari.ailus@linux.intel.com, arnd@arndb.de, stefano.stabellini@eu.citrix.com, catalin.marinas@arm.com, joro@8bytes.org, thunder.leizhen@huawei.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, yong.wu@mediatek.com, suravee.suthikulpanit@amd.com, ritesh.harjani@gmail.com, lauraa@codeaurora.org, eddie.huang@mediatek.com, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, yh.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-01-12 at 20:48 +0000, Robin Murphy wrote:
> Hi all,
> 
> Whilst it's a long way off perfect, this has reached the point of being
> functional and stable enough to be useful, so here it is. The core
> consists of the meat of the arch/arm implementation modified to remove
> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
> allocator instead of the bitmap-based one. For that, this series depends
> on my "Genericise the IOVA allocator" series posted earlier[1].

Hi Robin,

We'd to give it a try. Do you have a public git tree contains both
series?

Joe.C
