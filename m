From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Mon, 25 Jun 2018 17:15:00 +0100
Message-ID: <20180625161500.dbyxd4b434jh5jhj@debian>
References: <881d576b-c7c1-ef74-c6bc-68b81371e7e0@intel.com>
	<20180523212956.n4ztasdffg2aeaku@debian>
	<80eace7a-976d-65a5-a353-54a2b18edd06@linux.intel.com>
	<20180604152848.db3msouyi4ektvv6@debian>
	<06226ecb-baad-cc36-e9e3-797dabb0aa5e@linux.intel.com>
	<42ec4ab07d96b4302b875ac9c5eb76675bf85690.camel@linux.intel.com>
	<20180606164524.n4vb7xre6rykzxih@debian>
	<2e8829c2-850d-6bca-5f0c-58a809dc9499@linux.intel.com>
	<20180621005332.5uy74tkjoel6w4xy@debian>
	<2b4fe87a-3706-0aa8-2b61-a9c1d1352a7a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2b4fe87a-3706-0aa8-2b61-a9c1d1352a7a-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mathias,

On Thu, Jun 21, 2018 at 02:01:30PM +0300, Mathias Nyman wrote:
> On 21.06.2018 03:53, Sudip Mukherjee wrote:
> > Hi Mathias, Andy,
> > 
> > On Thu, Jun 07, 2018 at 10:40:03AM +0300, Mathias Nyman wrote:
> > > On 06.06.2018 19:45, Sudip Mukherjee wrote:
<snip>
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git dmapool-test
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=dmapool-test
> 
> Tested by just leaving the following running for a few days:
> 
> while true; do echo 0 > authorized; sleep 3; echo 1 > authorized; sleep 3; done;
> For some usb device (for example: /sys/bus/usb/devices/1-8)
> 
> Then grep logs for "MATTU dmatest match! "
> 
> Can you share a bit more details on the platform you are using, and what types of test you are running.

Sorry for the delayed reply, I was in Tokyo for the OSS.

It is a board based on "Intel(R) Atom(TM) CPU  E3840  @ 1.91GHz".
The usb device in question is a bluetooth device:

Bus 001 Device 012: ID 8087:07dc Intel Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x07dc
  bcdDevice            0.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1

And the problem that we are seeing is with phone calls via bluetooth.

> Does my test above trigger the case? (show "MATTU dmatest match!")

I have kept it for tonight, will see the results tomorrow morning.
And I am using that same device in the usb script to change "authrized".

But looking at the code for dma_pool_alloc(), it seems 'dma' can have
same value again only if "*(int *)(page->vaddr + offset)" gets a value
of 0 in pool_initialise_page(). But I can't think of anyway how it
can be 0. I have also added some more debugs in the kernel to see what
might be going wrong there.

--
Regards
Sudip
