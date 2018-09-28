From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
Date: Fri, 28 Sep 2018 14:39:36 -0600
Message-ID: <4dc0ffa8-7b16-9063-2aba-b8249a09885f@wwwdotorg.org>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
	<a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
	<52dc4d4b-b521-17a5-dc93-e2992e481083@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52dc4d4b-b521-17a5-dc93-e2992e481083-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Vidya Sagar <vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/18/2018 12:16 PM, Stephen Warren wrote:
> On 09/18/2018 04:59 AM, Robin Murphy wrote:
>> Hi Stephen,
>>
>> On 17/09/18 22:36, Stephen Warren wrote:
>>> Joerg, Christoph, Marek, Robin,
>>>
>>> I believe that the driver for our PCIe endpoint controller hardware 
>>> will need to explicitly manage its IOVA space more than current APIs 
>>> allow. I'd like to discuss how to make that possible.
...
>>> Does this API proposal sound reasonable?
>>
>> Indeed, as I say apart from using streaming DMA for coherency 
>> management (which I think could be added in pretty much orthogonally 
>> later), this sounds like something you could plumb into the endpoint 
>> framework right now with no dependent changes elsewhere.
> 
> Great. I'll take a look at Oza's code and see about getting this 
> implemented.

I took a longer look at the various APIs in iommu.h and dma-iommh.h. As 
you said, I think most of it is already there. I think we just need to 
add functions iommu_dma_alloc/free_iova() [1] that drivers can call to 
acquire an IOVA range that is guaranteed not be used by any other device 
that shares the same IOVA domain (i.e. IOMMU ASID). After the driver 
calls that, it can just use iommu_map() and iommu_map_sg() on the IOVA 
range that was reserved. Does that sound reasonable?

[1] there's already a static function of that name for internal use in 
dma-iommu.c. I guess I'd rename that to __iommu_dma_alloc_iova() and 
have the new function be a thin wrapper on top of it.
