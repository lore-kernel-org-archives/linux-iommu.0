From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel-iommu: Possible memory corruption due to deferred iommu
	flush
Date: Thu, 16 Nov 2017 17:23:48 -0800
Message-ID: <20171117012348.GA53764@otc-nc-03>
References: <CAGkh+XfVC0Ki0T88qdKke4Hsp2nyAZewRupEOLTds+1i4eBQYQ@mail.gmail.com>
	<20171116225226.GA53404@otc-nc-03>
	<CAGkh+XesX-yFnU_3q2=t6Zcju_zE3wN7EZoBswQnfc_cZ9qZxQ@mail.gmail.com>
	<CAGkh+Xd-mwYT75-sFWbjxKCOu5H0QhZFBKNELZxBytWpnORnZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGkh+Xd-mwYT75-sFWbjxKCOu5H0QhZFBKNELZxBytWpnORnZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: nick klingsman <nick.klingsman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Nick

On Fri, Nov 17, 2017 at 01:57:19AM +0200, nick klingsman wrote:
> 
> Oh - now I understand the confusion. Although the subject said 'deferred'
> I used the word 'Batched' in the email body. I meant 'deferred'. Not batching.
> If it was only batching, than it would make sens as 'Ashok' pointed out.
> 
> >
> >>
> >>>
> >>> 2. If WD is not needed, why do we do it ? Why do we effect IOMMU work
> >>> with unneeded actions (in the most critical fast path of map/unmap) ?

The purpose of WRITE_DRAIN is something like this.. 

If you had a buffer that DMA writes are still happening but the entity using
the buffer has been terminated. You are just looking to ensure that before you
reallocate the buffer to another entity that the old writes aren't still
happening.

When we do the dma_unmap() that would get rid of the mappings and an iotlb 
flush would ensure any future access the DMA would fail. WRITE_DRAIN ensures
any address already translated and DMA is in progress completes. 

In the batched mode when we delay performing the iotlb invalidations + 
write_drain, the I/O is completed and driver was notified earlier. As
part of tracking the I/O completion the driver would have read some mmio
on the device that would have caused all the outstanding writes from the
device written to memory. So the buffer in this case is all globally 
observable by the consumer.. so there is no stale state for that DMA that 
has properly completed. In these cases the WD is probaly not required, but 
we have the same path for all invalidations so its simple to do it for 
consistency.



Hope this helps.

Cheers,
Ashok
