From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Thu, 9 Aug 2018 15:36:30 -0600
Message-ID: <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 09/08/18 03:31 PM, Eric Pilmore wrote:
> On Thu, Aug 9, 2018 at 12:35 PM, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org> wrote:
>> Hey,
>>
>> On 09/08/18 12:51 PM, Eric Pilmore wrote:
>>>>> Was wondering if anybody here has used IOAT DMA engines with an
>>>>> IOMMU turned on (Xeon based system)? My specific question is really
>>>>> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
>>>>> destination without having to map that address to the IOVA space of
>>>>> the DMA engine first (assuming the IOMMU is on)?
>>
>> I haven't tested this scenario but my guess would be that IOAT would
>> indeed go through the IOMMU and the PCI BAR address would need to be
>> properly mapped into the IOAT's IOVA. The fact that you see DMAR errors
>> is probably a good indication that this is the case. I really don't know
>> why you'd want to DMA something without mapping it.
> 
> The thought was to avoid paying the price of having to go through yet another
> translation and also because it was not believed to be necessary anyway since
> the DMA device could go straight to a PCI BAR address without the need for a
> mapping.  We have been playing with two DMA engines, IOAT and PLX. The
> PLX does not have any issues going straight to the PCI BAR address, but unlike
> IOAT, PLX is sitting "in the PCI tree".

Yes, you can do true P2P transactions with the PLX DMA engine. (Though
you do have to be careful as technically you need to translate to a PCI
bus address not the CPU physical address which are the same on x86; and
you need to watch that ACS doesn't mess it up).

It doesn't sound like it's possible to avoid the IOMMU when using the
IOAT so you need the mapping. I would not expect the extra translation
in the IOMMU to be noticeable, performance wise.

Logan
