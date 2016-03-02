From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Bug: Freeing dma regions
Date: Wed, 2 Mar 2016 14:45:28 +0100
Message-ID: <20160302134528.GA20213@8bytes.org>
References: <CABdVeACY5dWoj-q4uMUnc-NgqqShemunLU1bbvLpAN6jPdBC+w@mail.gmail.com>
	<20160302082940.GS22747@8bytes.org>
	<CABdVeAB4C2aDGSgmCnGOjSzSZZ3Er5gu-ngsSVPc_XbBxsVaTA@mail.gmail.com>
	<CABdVeABM7OzGWeoXo1uui7f0HyP9wVLCPsEe+LnXrWXcmt7dVg@mail.gmail.com>
	<20160302123519.GT22747@8bytes.org>
	<CABdVeAAq_u6kAC9pm96UAdozWN5VSiiNm3HMBJ5wGqpd5zvbrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABdVeAAq_u6kAC9pm96UAdozWN5VSiiNm3HMBJ5wGqpd5zvbrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>, Valentine Sinitsyn <valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 02, 2016 at 03:58:18PM +0300, David Kiarie wrote:
> On Wed, Mar 2, 2016 at 3:35 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, Mar 02, 2016 at 11:40:04AM +0300, David Kiarie wrote:
> >> What effect is setting the value next_bit to last invalidated index
> >> supposed to have ?
> >
> > The idea is to safe the IOTLB flush by not re-using the address-range
> > until the allocator wraps around to 0 again. We only allocate address
> > ranges between next_bit and end-of-range. This way we don't need a flush
> > after every unmap operation.
> 
> Okay, I'll look at this issue again.
> 
> Last unrelated question. If I have 'iommu=pt' IOMMU doesn't seem to
> allocate any addresses and doesn't populate the 'root page table'
> until I try to pass-through a device. Why is that set like this ?

The pt stands for passthrough. In this mode the IOMMU is enabled, but
configured in way as if it is disabled. This means that all devices get
access to the physical address space and no remapping through the
DMA-API is done at all. Often this is used for performance reasons.

This only changes when a device is is assigned to a guest. In that case
it will only see the guest-physical address space via a page-table.


	Joerg
