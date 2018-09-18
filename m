From: poza-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
Date: Tue, 18 Sep 2018 14:07:26 +0530
Message-ID: <a46544a647f1f7309d1a10fb19910eb8@codeaurora.org>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3e9950c5-4986-6b0d-74c8-97014530c132-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Vidya Sagar <vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 2018-09-18 03:06, Stephen Warren wrote:
> Joerg, Christoph, Marek, Robin,
> 
> I believe that the driver for our PCIe endpoint controller hardware
> will need to explicitly manage its IOVA space more than current APIs
> allow. I'd like to discuss how to make that possible.
> 
> First some background on our hardware:
> 
> NVIDIA's Xavier SoC contains a Synopsis Designware PCIe controller.
> This can operate in either root port or endpoint mode. I'm
> particularly interested in endpoint mode.
> 
> Our particular instantiation of this controller exposes a single
> function with a single software-controlled PCIe BAR to the PCIe bus
> (there are also BARs for access to DMA controller registers and
> outbound MSI configuration, which can both be enabled/disabled but not
> used for any other purpose). When a transaction is received from the
> PCIe bus, the following happens:
> 
> 1) Transaction is matched against the BAR base/size (in PCIe address
> space) to determine whether it "hits" this BAR or not.
> 
> 2) The transaction's address is processed by the PCIe controller's ATU
> (Address Translation Unit), which can re-write the address that the
> transaction accesses.
> 
> Our particular instantiation of the hardware only has 2 entries in the
> ATU mapping table, which gives very little flexibility in setting up a
> mapping.
> 
> As an FYI, ATU entries can match PCIe transactions either:
> a) Any transaction received on a particular BAR.
> b) Any transaction received within a single contiguous window of PCIe
> address space. This kind of mapping entry obviously has to be set up
> after device enumeration is complete so that it can match the correct
> PCIe address.
> 
> Each ATU entry maps a single contiguous set of PCIe addresses to a
> single contiguous set of IOVAs which are passed to the IOMMU.
> Transactions can pass through the ATU without being translated if
> desired.
> 
> 3) The transaction is passed to the IOMMU, which can again re-write
> the address that the transaction accesses.
> 
> 4) The transaction is passed to the memory controller and reads/writes 
> DRAM.
> 
> In general, we want to be able to expose a large and dynamic set of
> data buffers to the PCIe bus; certainly /far/ more than two separate
> buffers (the number of ATU table entries). With current Linux APIs,
> these buffers will not be located in contiguous or adjacent physical
> (DRAM) or virtual (IOVA) addresses, nor in any particular window of
> physical or IOVA addresses. However, the ATU's mapping from PCIe to
> IOVA can only expose one or two contiguous ranges of IOVA space. These
> two sets of requirements are at odds!
> 
> So, I'd like to propose some new APIs that the PCIe endpoint driver can 
> use:
> 
> 1) Allocate/reserve an IOVA range of specified size, but don't map
> anything into the IOVA range.

I had done some work on this in the past, those patches were tested on 
Broadcom HW.

https://lkml.org/lkml/2017/5/16/23,
https://lkml.org/lkml/2017/5/16/21,
https://lkml.org/lkml/2017/5/16/19

I could not pursue it further, since I do not have the same HW to test 
it.
Although now in Qualcomm SOC, we do use Synopsis Designware PCIe 
controller
but we dont restrict inbound addresses range for our SOC.

of course these patches can easily be ported, and extended.
they basically reserve IOVA ranges based on inbound dma-ranges DT 
property.

Regards,
Oza.

> 
> 2) De-allocate the IOVA range allocated in (1).
> 
> 3) Map a specific set (scatter-gather list I suppose) of
> already-allocated/extant physical addresses into part of an IOVA range
> allocated in (1).
> 
> 4) Unmap a portion of an IOVA range that was mapped by (3).
> 
> One final note:
> 
> The memory controller can translate accesses to a small region of DRAM
> address space into accesses to an interrupt generation module. This
> allows devices attached to the PCIe bus to generate interrupts to
> software running on the system with the PCIe endpoint controller. Thus
> I deliberately described API 3 above as mapping a specific physical
> address into IOVA space, as opposed to mapping an existing DRAM
> allocation into IOVA space, in order to allow mapping this interrupt
> generation address space into IOVA space. If we needed separate APIs
> to map physical addresses vs. DRAM allocations into IOVA space, that
> would likely be fine too.
> 
> Does this API proposal sound reasonable?
> 
> I have heard from some NVIDIA developers that the above APIs rather go
> against the principle that individual drivers should not be aware of
> the presence/absence of an IOMMU, and hence direct management of IOVA
> allocation/layout is deliberately avoided, and hence there hasn't been
> a need/desire for this kind of API in the past. However, I think our
> current hardware design and use-case rather requires it. Do you agree?
