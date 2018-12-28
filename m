From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping
	in get_arch_dma_ops
Date: Fri, 28 Dec 2018 18:59:00 +0100
Message-ID: <20181228175900.GB16929@lst.de>
References: <20181214150240.26427-1-hch@lst.de> <20181219165502.GA25904@lst.de>
	<20181228173057.GA20342@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181228173057.GA20342-hOhETlTuV5niMG9XS5x8Mg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 28, 2018 at 05:30:57PM +0000, Liviu Dudau wrote:
> On Wed, Dec 19, 2018 at 05:55:02PM +0100, Christoph Hellwig wrote:
> > As all maintainers seem to be off to their holidays already I've
> > applied this now given that I don't want to leave arm64 in broken
> > state in linux-next any longer.
> 
> Hi Christoph,
> 
> Talking about linux-next being broken, I found out that with
> next-20181224 the nvme driver with an HMB NVMe SSD (Toshiba RC-100)
> also fails on a RK3399 board (NanoPC T4). It works with v4.20 just fine.
> 
> The reason for linking it to your patchset is that I get this on
> next-20181224 (the DMA addresses looks the same for the allocated buffers):

Your patch looks correct.  Can you send the dma_alloc_coherent
to dma_alloc_attrs switch to linux-nvme list with a proper commit log
and signoff?
