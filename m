From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
Date: Tue, 18 Sep 2018 12:16:03 -0600
Message-ID: <52dc4d4b-b521-17a5-dc93-e2992e481083@wwwdotorg.org>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
	<a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a0d97ebd-c77e-400a-29cd-9524e9f47dbc-5wv7dgnIgG8@public.gmane.org>
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

On 09/18/2018 04:59 AM, Robin Murphy wrote:
> Hi Stephen,
> 
> On 17/09/18 22:36, Stephen Warren wrote:
>> Joerg, Christoph, Marek, Robin,
>>
>> I believe that the driver for our PCIe endpoint controller hardware 
>> will need to explicitly manage its IOVA space more than current APIs 
>> allow. I'd like to discuss how to make that possible.
...
>> One final note:
>>
>> The memory controller can translate accesses to a small region of DRAM 
>> address space into accesses to an interrupt generation module. This 
>> allows devices attached to the PCIe bus to generate interrupts to 
>> software running on the system with the PCIe endpoint controller. Thus 
>> I deliberately described API 3 above as mapping a specific physical 
>> address into IOVA space, as opposed to mapping an existing DRAM 
>> allocation into IOVA space, in order to allow mapping this interrupt 
>> generation address space into IOVA space. If we needed separate APIs 
>> to map physical addresses vs. DRAM allocations into IOVA space, that 
>> would likely be fine too.
> 
> If that's the standard DesignWare MSI dingaling, then all you should 
> need to do is ensure you IOVA is reserved in your allocator (if it can 
> be entirely outside the EP BAR, even better) - AFAIK the writes get 
> completely intercepted such that they never go out to the SMMU side at 
> all, and thus no actual mapping is even needed.

Unfortunately it's not. We have some custom hardware module (that 
already existed for other purposes, such as interaction/synchronization 
between various graphics modules) that we will slightly repurpose as a 
plain interrupt generator for PCIe endpoint use-cases.

>> Does this API proposal sound reasonable?
> 
> Indeed, as I say apart from using streaming DMA for coherency management 
> (which I think could be added in pretty much orthogonally later), this 
> sounds like something you could plumb into the endpoint framework right 
> now with no dependent changes elsewhere.

Great. I'll take a look at Oza's code and see about getting this 
implemented.

Thanks.
