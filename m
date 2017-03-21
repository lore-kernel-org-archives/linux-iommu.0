From: Mason <slash.tmp-GANU6spQydw@public.gmane.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
Date: Tue, 21 Mar 2017 17:19:29 +0100
Message-ID: <c4115685-577c-aa6a-3bf7-422ab711d214@free.fr>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
	<f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
	<20170321123129.GB6816@e110455-lin.cambridge.arm.com>
	<d5062453-39cc-1435-bb13-87c81b6ef0b3@free.fr>
	<20170321142305.GC6816@e110455-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170321142305.GC6816-A/Nd4k6kWRHZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thibaud Cornic <thibaud_cornic-y1yR0Z3OICC7zZZRDBGcUA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Laight <david.laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Phuong Nguyen <phuong_nguyen-y1yR0Z3OICC7zZZRDBGcUA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 21/03/2017 15:23, Liviu Dudau wrote:

> On Tue, Mar 21, 2017 at 02:01:57PM +0100, Mason wrote:
>
>> My PCIe controller is b/d/f 0/0/0.
>> It ignores all PCI addresses that do not fall within the range
>> defined in BAR0 of b/d/f 0/0/0.
>>
>> BAR0 has a configurable width of 2^(23+i) bytes, i < 8
>> It is implicitly split in 8 regions, which can map to
>> anywhere in CPU space. However, my understanding is that,
>> by default, the DMA framework expects PCI address X to
>> map to CPU address X...
>> (My understanding of that part is still a bit hazy.)
> 
> It looks very much like your PCIe controller (host bridge) has the configuration
> registers on the wrong side of the bridge (PCIe one vs the more normal host side).
> But otherwise it does look very much like an ATS system, where you program how the
> PCIe bus addresses map into the system (you call them CPU) addresses. Do you also
> have a way of controlling the direction of the mapping? (in other words, those 8
> regions are only for translating request coming out of the PCIe bus into system
> addresses, or can you also set the direct mapping of system address to PCIe address?).

There are two (asymmetric) features for these mappings.

For bus-to-system accesses, the scheme described above
of "bus addresses within BAR0 fall into 1 of 8 regions,
and 8 registers define 8 target system addresses".

For system-to-bus accesses, there is a single "offset"
register which gets added to the system address, to form
the bus address. I just use a 0 offset.

(This is made slightly more complex on later chips because
someone in marketing thought it would look good on the
data sheet to support 4 GB of RAM in a SoC using 32-bit
processors. There is an additional cpu-to-foo mapping.)

> As for DMA framework expectations, I'm not sure how that plays a role, unless you
> have some DMA engines on the PCIe bus.

I think the USB3 PCIe card I'm using is a bus master, so
it's able to push data to RAM without any help from the
ARM core.

Regards.

P.S. something in your message is confusing my MUA, likely
your Mail-Followup-To field. My MUA thinks it should not
send you my reply. Is that really what you want?
