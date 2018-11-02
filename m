From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
	area
Date: Fri, 2 Nov 2018 07:35:42 +0100
Message-ID: <20181102063542.GA17073@lst.de>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
	<13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <13d60076-33ad-b542-4d17-4d717d5aa4d3-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> On 31/10/2018 20:03, Nicolin Chen wrote:
>> The addresses within a single page are always contiguous, so it's
>> not so necessary to allocate one single page from CMA area. Since
>> the CMA area has a limited predefined size of space, it might run
>> out of space in some heavy use case, where there might be quite a
>> lot CMA pages being allocated for single pages.
>>
>> This patch tries to skip CMA allocations of single pages and lets
>> them go through normal page allocations. This would save resource
>> in the CMA area for further more CMA allocations.
>
> In general, this seems to make sense to me. It does represent a theoretical 
> change in behaviour for devices which have their own CMA area somewhere 
> other than kernel memory, and only ever make non-atomic allocations, but 
> I'm not sure whether that's a realistic or common enough case to really 
> worry about.

Yes, I think we should make the decision in dma_alloc_from_contiguous
based on having a per-dev CMA area or not.  There is a lot of cruft in
this area that should be cleaned up while we're at it, like always
falling back to the normal page allocator if there is no CMA area or
nothing suitable found in dma_alloc_from_contiguous instead of
having to duplicate all that in the caller.
