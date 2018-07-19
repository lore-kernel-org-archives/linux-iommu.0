From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 19 Jul 2018 12:34:55 +0100
Message-ID: <20180719113455.urktqxijzoyhfoou@debian>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
	<f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f7801c24-fa98-6338-0b26-33a0ac9498bb-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

On Thu, Jul 19, 2018 at 01:59:01PM +0300, Mathias Nyman wrote:
> On 17.07.2018 18:10, Sudip Mukherjee wrote:
> > Hi Alan, Greg,
> > 
> > On Tue, Jul 17, 2018 at 03:49:18PM +0100, Sudip Mukherjee wrote:
> > > On Tue, Jul 17, 2018 at 03:40:22PM +0100, Sudip Mukherjee wrote:
> > > > Hi Alan,
> > > > 
> > > > On Tue, Jul 17, 2018 at 10:28:14AM -0400, Alan Stern wrote:
> > > > > On Tue, 17 Jul 2018, Sudip Mukherjee wrote:
> > > > > 
> > > > > > I did some more debugging. Tested with a KASAN enabled kernel and that
> > > > > > shows the problem. The report is attached.
> > > > > > 
<snip>
> > 
> > And, my hacky patch worked as I prevented it from calling
> > usb_disable_interface() in this particular case.
> > 
> 
> Back for a few days, looking at this

I hope you had a good holiday. :)

> 
> xhci driver will set up all the endpoints for the new altsetting already in
> usb_hcd_alloc_bandwidth().
> 
<snip>
> 
> As first aid I could try to implement checks that make sure the flushed URBs
> trb pointers really are on the current endpoint ring, and also add some warning
> if we are we are dropping endpoints with URBs still queued.

Yes, please. I think your first-aid will be a much better option than
the hacky patch I am using atm.

> 
> But we need to fix this properly as well.
> xhci needs to be more in sync with usb core in usb_set_interface(), currently xhci
> has the altssetting up and running when usb core hasn't event started flushing endpoints.

I am able to reproduce this on almost all cycles, so I can always test
the fix for you after you are fully back from your holiday.

--
Regards
Sudip
