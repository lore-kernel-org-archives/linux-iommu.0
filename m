From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: usb HC busted?
Date: Tue, 17 Jul 2018 10:28:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180717114104.irgdb5rmg2qxclgp@debian>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 17 Jul 2018, Sudip Mukherjee wrote:

> I did some more debugging. Tested with a KASAN enabled kernel and that
> shows the problem. The report is attached.
> 
> To my understanding:
> 
> btusb_work() is calling usb_set_interface() with alternate = 0. which
> again calls usb_hcd_alloc_bandwidth() and that frees the rings by
> xhci_free_endpoint_ring().

That doesn't sound like the right thing to do.  The rings shouldn't be 
freed until xhci_endpoint_disable() is called.  

On the other hand, there doesn't appear to be any 
xhci_endpoint_disable() routine, although a comment refers to it.  
Maybe this is the real problem?

Alan Stern

> But then usb_set_interface() continues and
> calls usb_disable_interface() -> usb_hcd_flush_endpoint()->unlink1()->
> xhci_urb_dequeue() which at the end gives the command to stop endpoint.
> 
> In all the cycles I have tested I see that only in the fail case
> handle_cmd_completion() gets called, but in the cycles where the error
> is not there handle_cmd_completion() is not called with that command.
> 
> I am not sure what is happening, and you are the best person to understand
> what is happening. :)
> 
> But for now (untill you are back from holiday and suggest a proper solution),
> I made a hacky patch (attached) which is working and I donot get any
> corruption after that. Both KASAN and slub debug are also happy.
> 
> So, now waiting for you to analyze what is going on and suggest a proper
> fix.
> 
> Thanks in advance.
> 
> --
> Regards
> Sudip
> 
