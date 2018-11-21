From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Wed, 21 Nov 2018 10:11:33 -0500
Message-ID: <20181121151133.GC26925@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de>
 <20181120163441.GD31199@char.us.oracle.com>
 <20181121130331.GA1373@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181121130331.GA1373@lst.de>
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
Cc: sstabellini@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, john.stultz@linaro.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > Konrad, are you ok with me picking up both through the dma-mapping
> > > tree?
> > 
> > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> 
> Stefano, can you take a look asap?  This is a pretty trivial fix for
> a nasty bug that breaks boot on real life systems.  I'd like to merge
> it by tomorrow so that I can send it off to Linus for the next rc
> (I will be offline for about two days after Friday morning)

It is Turkey Day in US so he may be busy catching those pesky turkeys.
How about Tuesday? And in can also send the GIT PULL.
