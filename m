From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Fri, 29 Jun 2018 14:41:13 +0300
Message-ID: <4b269009-7593-a41f-9f0f-203ee174b52e@linux.intel.com>
References: <20180523212956.n4ztasdffg2aeaku@debian>
	<80eace7a-976d-65a5-a353-54a2b18edd06@linux.intel.com>
	<20180604152848.db3msouyi4ektvv6@debian>
	<06226ecb-baad-cc36-e9e3-797dabb0aa5e@linux.intel.com>
	<42ec4ab07d96b4302b875ac9c5eb76675bf85690.camel@linux.intel.com>
	<20180606164524.n4vb7xre6rykzxih@debian>
	<2e8829c2-850d-6bca-5f0c-58a809dc9499@linux.intel.com>
	<20180621005332.5uy74tkjoel6w4xy@debian>
	<2b4fe87a-3706-0aa8-2b61-a9c1d1352a7a@linux.intel.com>
	<20180625161500.dbyxd4b434jh5jhj@debian>
	<20180627115948.ww534mkoovkt3uwb@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180627115948.ww534mkoovkt3uwb@debian>
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
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 27.06.2018 14:59, Sudip Mukherjee wrote:
>>> Can you share a bit more details on the platform you are using, and what types of test you are running.
>>
>> It is a board based on "Intel(R) Atom(TM) CPU  E3840  @ 1.91GHz".
>> The usb device in question is a bluetooth device:
>>
>> Bus 001 Device 012: ID 8087:07dc Intel Corp.
> <snip>
>>
>> And the problem that we are seeing is with phone calls via bluetooth.
>>
>>> Does my test above trigger the case? (show "MATTU dmatest match!")
>>
>> I have kept it for tonight, will see the results tomorrow morning.
>> And I am using that same device in the usb script to change "authrized".
> 
> No, your test did not trigger the error. :(
> 
> But, my last night's test (with an added debug to get some extra trace for addresses) showed the same error of -
> "Looking for event-dma", but looking at the ftrace, I could not see it getting same address from dma_pool_zalloc().
> 
> Can you please have a look at the dmesg and ftrace at:
> https://drive.google.com/open?id=1nMy_qVxOQzcZNYa9bw7az9WiS2MZzdKo
> 

There is however freeing of the same dma address:

<...>-28448 [003] ....   492.025808: xhci_ring_free: ISOC f1ffb700: enq 0x000000002d31bcc0(0x000000002d31b000) deq 0x000000002d31b000(0x000000002d31b000) segs 2 stream 0 free_trbs 305 bounce 17 cycle 0
<...>-28448 [003] ....   492.025818: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ 0x000000002d31b000
<...>-28448 [003] ....   492.025823: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ 0x000000002d31b000
<...>-28448 [003] ....   492.025826: xhci_ring_free: ISOC f1f9b380: enq 0x000000002d31b140(0x000000002d31b000) deq 0x000000002d31b000(0x000000002d31b000) segs 2 stream 0 free_trbs 489 bounce 17 cycle 1
<...>-28448 [003] ....   492.025828: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ 0x000000002d31b000
<...>-28448 [003] ....   492.025830: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ 0x000000002d31b000

I'd guess it's still the same cause, maybe trace is not complete?

-Mathias
