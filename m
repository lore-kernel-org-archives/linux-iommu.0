From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 03/12] intel-ipu3: Add DMA API implementation
Date: Thu, 8 Jun 2017 23:35:51 +0900
Message-ID: <CAAFQd5AWGN_qSXGG32D-eWKZRoRme+XCD9v1r8qJ5bthtS9z9w@mail.gmail.com>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
	<1496695157-19926-4-git-send-email-yong.zhi@intel.com>
	<CAAFQd5CLXUsDv6H1C22tc4qjG9e7tm5jtxwYBjV5gx9qrDw50A@mail.gmail.com>
	<73992991-65a9-915b-a450-b23aeb3baaed@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <73992991-65a9-915b-a450-b23aeb3baaed-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "Zheng, Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Toivonen, Tuukka" <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mani,
	Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 8, 2017 at 10:22 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 07/06/17 10:47, Tomasz Figa wrote:
>> Hi Yong,
>>
>> +Robin, Joerg, IOMMU ML
>>
>> Please see my comments inline.
>>
>> On Tue, Jun 6, 2017 at 5:39 AM, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
[snip]
>>> +
>>> +/* End of things adapted from arch/arm/mm/dma-mapping.c */
>>> +static void ipu3_dmamap_sync_single_for_cpu(struct device *dev,
>>> +                                           dma_addr_t dma_handle, size_t size,
>>> +                                           enum dma_data_direction dir)
>>> +{
>>> +       struct ipu3_mmu *mmu = to_ipu3_mmu(dev);
>>> +       dma_addr_t daddr = iommu_iova_to_phys(mmu->domain, dma_handle);
>>> +
>>> +       clflush_cache_range(phys_to_virt(daddr), size);
>>
>> You might need to consider another IOMMU on the way here. Generally,
>> given that daddr is your MMU DMA address (not necessarily CPU physical
>> address), you should be able to call
>>
>> dma_sync_single_for_cpu(<your pci device>, daddr, size, dir)
>
> I'd hope that this IPU complex is some kind of embedded endpoint thing
> that bypasses the VT-d IOMMU or is always using its own local RAM,
> because it would be pretty much unworkable otherwise.

It uses system RAM and, as far as my understanding goes, by default it
operates without the VT-d IOMMU and that's how it's used right now.
I'm suggesting VT-d IOMMU as a way to further strengthen the security
and error resilience in future (due to the IPU complex being
non-coherent and also running a closed source firmware).

> The whole
> infrastructure isn't really capable of dealing with nested IOMMUs, and
> nested DMA ops would be an equally horrible idea.

Could you elaborate a bit more on this? I think we should be able to
deal with this in a way I suggested before:

a) the PCI device would use the system DMA ops,
b) the PCI device would implement a secondary bus for which it would
provide its own DMA and IOMMU ops.
c) a secondary device would be registered on the secondary bus,
d) all memory for the IPU would be managed on behalf of the secondary device.

In fact, the driver already is designed in a way that all the points
above are true. If I'm not missing something, the only significant
missing point is calling into system DMA ops from IPU DMA ops.

Best regards,
Tomasz
