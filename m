From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Fri, 20 Jul 2018 13:54:21 +0100
Message-ID: <20180720125421.jhdvas6oapryw6yz@debian>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
	<f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
	<20180719113455.urktqxijzoyhfoou@debian>
	<ab814c88-0857-5444-57da-34c21b8d7f6c@linux.intel.com>
	<20180719173256.hc5aprma4biuqd4p@debian>
	<d3f5575c-c75b-ea16-6da9-b2fe3cc9c102@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d3f5575c-c75b-ea16-6da9-b2fe3cc9c102-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mathias,

On Fri, Jul 20, 2018 at 02:10:58PM +0300, Mathias Nyman wrote:
> On 19.07.2018 20:32, Sudip Mukherjee wrote:
> > Hi Mathias,
> > 
> > On Thu, Jul 19, 2018 at 06:42:19PM +0300, Mathias Nyman wrote:
> > > > > As first aid I could try to implement checks that make sure the flushed URBs
> > > > > trb pointers really are on the current endpoint ring, and also add some warning
> > > > > if we are we are dropping endpoints with URBs still queued.
> > > > 
> > > > Yes, please. I think your first-aid will be a much better option than
> > > > the hacky patch I am using atm.
> > > > 
> > > 
<snip>
> So poison is overwritten at e5acda58 with almost its own address, (reading backwards) e5 ac da 60, twice.
> looks like something (32bit?)is pointing to itself twice, maybe a linked list node next and prev pointer
> being set to point to itself as last item was removed from list.
> 
> The cancelled_td_list is part of struct xhci_virt_ep, so that should be fine.
> But td_list is part of struct xhci_ring, which was freed. and we removed the URBs tds from the td_list when
> flushing the ring after ring was freed
> 
> I changed the patch (attached) to make sure it doesn't touch the td_list when canceling a URB after
> ring is freed.
> 
> How about this one, any improvements?

Yes, it worked. :D

So, cycle-1 = no change, just to make sure I can still reproduce the error.
cycle-2 and cycle-3 with your patch, and there was no problem,
slub debug was also happy.
I am starting an autotest with this patch now, and I will have almost
50 cycles tested by tomorrow morning.

--
Regards
Sudip
