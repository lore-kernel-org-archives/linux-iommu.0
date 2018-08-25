From: Thiago Jung Bauermann <bauerman-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Date: Fri, 24 Aug 2018 21:38:02 -0300
Message-ID: <87mutbxout.fsf@morokweng.localdomain>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
	<20180824162535.22798-12-bauerman@linux.ibm.com>
	<45561478-ee75-ee62-52d6-a96d60132669@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <45561478-ee75-ee62-52d6-a96d60132669-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Anshuman Khandual <anshuman.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Mike Anderson <andmike-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Ram Pai <linuxram-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Hello Randy,

Thanks for your quick review.

Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> writes:

> On 08/24/2018 09:25 AM, Thiago Jung Bauermann wrote:
>> From: Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>>
>> SWIOTLB buffer default size (64MB) is not enough for large sequential write
>> operations which eventually leads to kernel crash like here.
>>
>> virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
>> virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
>> Kernel panic - not syncing: DMA: Random memory could be DMA read
>> CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
>> Call Trace:
>> [c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
>> [c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
>> [c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
>> [c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
>> [c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
>> [c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
>> [c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
>> [c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
>> ..................
>>
>> Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.
>>
>> Signed-off-by: Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Thiago Jung Bauermann <bauerman-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
>> ---
>>  arch/powerpc/Kconfig | 5 +++++
>>  kernel/dma/swiotlb.c | 5 +++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 1466d1234723..fee7194ce9e4 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -457,6 +457,11 @@ config PPC_SVM
>>
>>  	 If unsure, say "N".
>>
>> +config SWIOTLB_DEFAULT_SIZE
>> +       int "Size of Software I/O TLB buffer (in MiB)"
>> +       default "1024"
>
> I would add a "range" to limit (restrict) how small or large that can be.  E.g.:
>
> 	range 16 102400
>
> or even smaller for the maximum value...

That's an interesting idea. Since this config option is restricted to
PPC_SVM it may be possible to find out what reasonable limits would be.
I'll have to experiment a bit to find out. Though I can say that 16 MB
is too small since even with 64 MB the kernel panics with the simple
task of formatting a filesystem...

--
Thiago Jung Bauermann
IBM Linux Technology Center
