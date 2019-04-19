From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Fri, 19 Apr 2019 11:07:59 +0200
Message-ID: <20190419090759.GA22885@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
 <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
 <20190418163512.GA25347@lst.de>
 <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 05:41:00PM +0100, Robin Murphy wrote:
>>  From a very high level POV this looks ok, but sometimes a bit to
>> convoluted to me.  The major issue why I went with the version I posted
>> is that I can cleanly ifdef out the remap code in just a few sections.
>> In this version it is spread out a lot more, and the use of IS_ENABLED
>> means that we'd need a lot more stubs for functionality that won't
>> ever be called but needs to be compilable.
>
> What functionality do you have planned in that regard? I did do a quick 
> build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and 
> dma-iommu.o appeared to link OK (although other bits of arm64 and 
> dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make 
> sure, though.

Yeah, this seems to actually work, there just is a huge chunk of
remapping that is hopefully discarded by the compiler even without the
ifdefs.
