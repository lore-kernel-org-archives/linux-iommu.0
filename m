From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Fri, 17 Aug 2018 05:01:13 -0700
Message-ID: <20180817120113.GA31542@infradead.org>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <20180817072415.GA22241@infradead.org>
 <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
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
Cc: catalin.marinas@arm.com, joro@8bytes.org, will.deacon@arm.com, linuxarm@huawei.com, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 17, 2018 at 12:30:31PM +0100, Robin Murphy wrote:
> On 17/08/18 08:24, Christoph Hellwig wrote:
> > I plan to make the arm iommu dma ops generic and move them to
> > drivers/iommu for the 4.20 merge window.
> 
> You mean 32-bit arm?

Sorry, I meant the arm64 wrappers for dma-iommu of course.

> The only place that code should move to is /dev/null ;)
> - the plan has always been to convert it to use groups and default domains
> so it can just plug iommu-dma in. The tricky bit is either weaning the users
> of the private arm_iommu_*() API onto generic IOMMU API usage, or at least
> implementing transitional wrappers in a way that doesn't break anything.

Agreed on the arm32 iommu code.
