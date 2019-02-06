From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Date: Wed, 6 Feb 2019 15:08:26 +0000
Message-ID: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
 <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190201161305.GI6532@lst.de>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 01/02/2019 16:13, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>>> includes unconditionally so users can rely on it, and add a missing
>>> comment describing the #else cpp statement.  Last but not least include
>>> <linux/errno.h> instead of the asm version, which is frowned upon.
>>
>> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted
>> from the arch code as a fresh-faced noob yet to learn the finer details, so
>> ack for those parts. The forward-declarations, though, were a deliberate
>> effort to minimise header dependencies and compilation bloat for includers
>> who absolutely wouldn't care, and specifically to try to avoid setting
>> transitive include expectations since they always seem to end up breaking
>> someone's config somewhere down the line. Admittedly this little backwater
>> is hardly comparable to the likes of the sched.h business, but I'm still
>> somewhat on the fence about that change :/
> 
> As far as I can tell almost all users of linux/dma-iommu.h require
> CONFIG_DMA_IOMMU to be enabled anyway..

Other than dma-iommu.c itself, none of them *require* it - only 
arch/arm64 selects it (the one from MTK_IOMMU is just bogus), and a lot 
of the drivers also build for at least one other architecture (and/or 
arm64 with !IOMMU_API).

Either way, I have no vehement objection to the change, I just don't see 
any positive value in it.

Robin.
