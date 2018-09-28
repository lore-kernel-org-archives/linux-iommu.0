From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Use fast DMA domain lookup
Date: Fri, 28 Sep 2018 16:46:47 +0100
Message-ID: <973e866f-2a92-b92e-8844-0b5a91edcb00@arm.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
	<CGME20180912152438epcas5p175098b44c3f7232302e10b087279bd3c@epcas5p1.samsung.com>
	<e42771992a73620f23128c0479b2ae91b3e177bf.1536764440.git.robin.murphy@arm.com>
	<20180928132605eucas1p1d39fedc3be3e4e2c16035c01a40cfab6~Ykz2Rax6e0538205382eucas1p17@eucas1p1.samsung.com>
	<78a5b373-d569-4461-e258-3104286ba322@arm.com>
	<20180928142148eucas1p17d6ecbd5c98b3fe1bf008dbcf0626c76~YlkfonoPN1120711207eucas1p1u@eucas1p1.samsung.com>
	<a9eb4b79-1fb8-eec7-0566-966f84022d7b@arm.com>
	<20180928153334.GA9462@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180928153334.GA9462-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, =?UTF-8?B?64yA7J246riw?= <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/09/18 16:33, Christoph Hellwig wrote:
> On Fri, Sep 28, 2018 at 04:31:10PM +0100, Robin Murphy wrote:
>> The tricky part is how to reconcile that with those other drivers which
>> want to do explicit IOMMU management with their own domain but still use
>> the DMA API for coherency of the underlying memory. I do have a couple of
>> half-formed ideas, but they're not quite there yet.
> 
> It think the only sensible answer is that they can't, and we'll need
> coherency API in the iommu API (or augmenting it).  Which might be a
> real possibility now that I'm almost done lifting the coherency
> management to arch hooks instead of dma op methods.

I reckon it seems feasible if the few clients that want to had a way to 
allocate their own proper managed domains, and the IOMMU API knew how to 
swizzle between iommu_dma_ops and dma_direct_ops upon attach depending 
on whether the target domain was managed or unmanaged. The worst part is 
liekly to be the difference between that lovely conceptual 
"iommu_dma_ops" and the cross-architecture mess of reality, plus where 
identity domains with a possible need for SWIOTLB come into it.

Robin.
