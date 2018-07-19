From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 19 Jul 2018 13:59:01 +0300
Message-ID: <f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180717151017.yk5d4glzwqcrxpqc@debian>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 17.07.2018 18:10, Sudip Mukherjee wrote:
> Hi Alan, Greg,
> 
> On Tue, Jul 17, 2018 at 03:49:18PM +0100, Sudip Mukherjee wrote:
>> On Tue, Jul 17, 2018 at 03:40:22PM +0100, Sudip Mukherjee wrote:
>>> Hi Alan,
>>>
>>> On Tue, Jul 17, 2018 at 10:28:14AM -0400, Alan Stern wrote:
>>>> On Tue, 17 Jul 2018, Sudip Mukherjee wrote:
>>>>
>>>>> I did some more debugging. Tested with a KASAN enabled kernel and that
>>>>> shows the problem. The report is attached.
>>>>>
>>>>> To my understanding:
>>>>>
>>>>> btusb_work() is calling usb_set_interface() with alternate = 0. which
>>>>> again calls usb_hcd_alloc_bandwidth() and that frees the rings by
>>>>> xhci_free_endpoint_ring().
>>>>
>>>> That doesn't sound like the right thing to do.  The rings shouldn't be
>>>> freed until xhci_endpoint_disable() is called.
>>>>
>>>> On the other hand, there doesn't appear to be any
>>>> xhci_endpoint_disable() routine, although a comment refers to it.
>>>> Maybe this is the real problem?
>>>
>>> one of your old mail might help :)
>>>
>>> https://www.spinics.net/lists/linux-usb/msg98123.html
>>
>> Wrote too soon.
>>
>> Is it the one you are looking for -
>> usb_disable_endpoint() is in drivers/usb/core/message.c
> 
> I think now I understand what the problem is.
> usb_set_interface() calls usb_disable_interface() which again calls
> usb_disable_endpoint(). This usb_disable_endpoint() gets the pointer
> to 'ep', marks it as NULL and sends the pointer to usb_hcd_flush_endpoint().
> After flushing the endpoints usb_disable_endpoint() calls
> usb_hcd_disable_endpoint() which tries to do:
> 	if (hcd->driver->endpoint_disable)
> 		hcd->driver->endpoint_disable(hcd, ep);
> but there is no endpoint_disable() callback in xhci, so the endpoint is
> never marked as disabled. So, next time usb_hcd_flush_endpoint() is
> called I get this corruption.
> And this is exactly where I used to see the problem happening.
> 
> And, my hacky patch worked as I prevented it from calling
> usb_disable_interface() in this particular case.
> 

Back for a few days, looking at this

xhci driver will set up all the endpoints for the new altsetting already in
usb_hcd_alloc_bandwidth().

New endpoints will be ready and rings running after this. I don't know the exact
history behind this, but I assume it is because xhci does all of the steps to
drop/add, disable/enable endpoints and check bandwidth in a single configure
endpoint command, that will return errors if there is not enough bandwidth.
This command is issued in hcd->driver->check_bandwidth()
This means that xhci doesn't really do much in hcd->driver->endpoint_disable or
hcd->driver->endpoint_enable

It also means that xhci driver assumes rings are empty when
hcd->driver->check_bandwidth is called. It will bluntly free dropped rings.
If there are URBs left on a endpoint ring that was dropped+added
(freed+reallocated) then those URBs will contain pointers to freed ring,
causing issues when usb_hcd_flush_endpoint() cancels those URBs.

usb_set_interface()
   usb_hcd_alloc_bandwidth()
     hcd->driver->drop_endpoint()
     hcd->driver->add_endpoint() // allocates new rings
     hcd->driver->check_bandwidth() // issues configure endpoint command, free rings.
   usb_disable_interface(iface, true)
     usb_disable_endpoint()
       usb_hcd_flush_endpoint() // will access freed ring if URBs found!!
       usb_hcd_disable_endpoint()
         hcd->driver->endpoint_disable()  // xhci does nothing
   usb_enable_interface(iface, true)
     usb_enable_endpoint(ep_addrss, true) // not really doing much on xhci side.

As first aid I could try to implement checks that make sure the flushed URBs
trb pointers really are on the current endpoint ring, and also add some warning
if we are we are dropping endpoints with URBs still queued.

But we need to fix this properly as well.
xhci needs to be more in sync with usb core in usb_set_interface(), currently xhci
has the altssetting up and running when usb core hasn't event started flushing endpoints.

-Mathias
