From: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 25 Nov 2015 16:14:58 +0100
Message-ID: <5655D072.1000901@profitbricks.com>
References: <564EFF6A.2050709@profitbricks.com>
	<564F051E.9010703@profitbricks.com> <20151125150806.GG2064@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151125150806.GG2064-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/25/2015 04:08 PM, Joerg Roedel wrote:
> On Fri, Nov 20, 2015 at 12:33:50PM +0100, Michael Wang wrote:
>> The kmemleak testing on 3.18.24 show:
>>
>> unreferenced object 0xffff880233ff9010 (size 16):
>>   comm "swapper/0", pid 1, jiffies 4294937440 (age 2010.490s)
>>   hex dump (first 16 bytes):
>>     0a 0a 00 00 20 00 00 00 00 44 fb 33 02 88 ff ff  .... ....D.3....
>>   backtrace:
>>     [<ffffffff8118192d>] create_object+0x10d/0x2d0
>>     [<ffffffff815c2d4b>] kmemleak_alloc+0x5b/0xc0
>>     [<ffffffff8116dd19>] kmem_cache_alloc_trace+0xb9/0x160
>>     [<ffffffff814ffe51>] get_irq_table+0x151/0x380
>>
>> This is caused by the 'irq_lookup_table' was allocated with
>> __get_free_pages() which won't create kmemleak object, thus it's
>> pointers won't be count as referencing 'irq_remap_table' in
>> kmemleak scan.
> 
> Isn't it better to allocate the kmemleak object manually instead of
> ignoring all irq-table pointers? With this patch we might not notice any
> real leak of irq-tables.

We've considered that too, but found that the irq-tables is not
dynamically alloc/free, they won't be freed once initialized, so there
is no leaking for such object :-)

Regards,
Michael Wang

> 
> 
> 
> 	Joerg
> 
