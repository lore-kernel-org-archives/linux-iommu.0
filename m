From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 0/2] arm-smmu-v3 tlbi-on-map option
Date: Thu, 13 Jul 2017 20:17:49 +0100
Message-ID: <c786cb51-cade-7652-0044-56e9ccaca095@arm.com>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
	<20170712175454.GF15191@arm.com>
	<20170712223654-mutt-send-email-mst@kernel.org>
	<fd71a432-0799-3c07-4071-c79bce20a561@arm.com>
	<20170713204107-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170713204107-mutt-send-email-mst-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/07/17 18:44, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2017 at 10:29:42AM +0100, Jean-Philippe Brucker wrote:
>> On 12/07/17 23:07, Michael S. Tsirkin wrote:
>> [...]
>>> I think using hardware support for nesting is the right final
>>> solution. It will take some time though. Given this, what should
>>> we do meanwhile?
>>>
>>> Assuming that's the final destination, a simple quirk like this
>>> seems to be preferable to virtio-iommu which we'll never be
>>> able to offload to hardware.
>>
>> That's not entirely true. virtio-iommu will have an extension for hardware
>> nesting support. It was presented in my initial proposal, and I've made
>> significant progress since then.
>>
>> Thanks,
>> Jean
> 
> I don't recall seeing this.
> 
> Hardware specific extensions to virtio would be interesting, the
> difficulty is in finding the balance between enabling minor quirks and
> each vendor going their own way.

Yes, in order to avoid too many quirks and vendor-specific formats, we'd
like the guest to only manage page tables, which have relatively stable
format, while the host kernel manages context tables (PASID tables) and
other structures, that are more volatile across implementations.

Unavoidably, a few architecture-specific details need to be described in
the API, but it seems manageable. The host tells the guest which page
table format is supported by hardware, and the guest sends back a page
directory pointer along with a few configuration parameters.

In the guest, page table operations may be abstracted in a module and used
by multiple IOMMU drivers (what ARM does in drivers/iommu/io-pgtable-arm.c
for the various vendor drivers). This abstraction is quite helpful to find
out which information needs to be exchanged between virtio-iommu device
and driver. For ARM-based IOMMUs it amounts to 6 configuration registers
and 4 quirk bits.

The other problem is forwarding TLB invalidations to the host kernel.
There is an ongoing discussion [1] about the best way to do it in VFIO,
and it seems like the format can stay mostly generic, with a few
optimization hints depending on the hardware IOMMU.

> Is this the proposal you refer to?
> https://www.spinics.net/lists/kvm/msg147990.html

Yes, I'm referring to "II. Page table sharing" in
https://www.spinics.net/lists/kvm/msg147993.html

But it is now mostly obsolete. Lots of things had to change while writing
a prototype and following public discussions. At the moment my focus is on
tidying up the base, but I will send another RFC afterwards.

Thanks,
Jean

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01117.html
