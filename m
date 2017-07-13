From: Federico Vaga <federico.vaga-VIMSii5OdOuonA0d6jMUrA@public.gmane.org>
Subject: Re: IOMMU - DMA debugging
Date: Thu, 13 Jul 2017 10:43:27 +0200
Message-ID: <22729074.Vd8Fat30YZ@harkonnen>
References: <1807773.bRUB8Ke59R@harkonnen> <4002588.18GdeEVaQi@harkonnen>
	<9273b2ab-2648-63f7-fe0f-a4462b4e4062@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9273b2ab-2648-63f7-fe0f-a4462b4e4062-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday, July 12, 2017 8:02:42 PM CEST Robin Murphy wrote:
> On 12/07/17 18:20, Federico Vaga wrote:
> > On Wednesday, July 12, 2017 2:15:34 PM CEST Federico Vaga wrote:
> >> Thank you Robin
> >> 
> >> (inline comments)
> >> 
> >> On Wednesday, July 12, 2017 1:10:51 PM CEST Robin Murphy wrote:
> >>> On 12/07/17 08:11, Federico Vaga wrote:
> >>>> Hello,
> >>>> 
> >>>> kernel version 4.4.x
> >>>> 
> >>>> I'm facing an issue with the INTEL IOMMU driver and DMA mapping. I have
> >>>> an
> >>>> Ethernet driver that uses `dma_alloc_coherent()` to allocate and map
> >>>> some
> >>>> memory for DMA transfers.
> >>> 
> >>> Assuming 02:00.0 is your actual endpoint and not some upstream aliasing
> >>> bridge, is your driver definitely using the correct struct device
> >>> pointer corresponding to that for its DMA API calls?
> > 
> > I had a look at this point. The driver is using the device 02:08.0 (which
> > is the one that should use) but the errors refers to the 02:00.0. I have
> > a rough idea about how the IOMMU works but I do not know the details
> > involved in the process.
> > 
> > \-[0000:00]-+-00.0
> > 
> >              +-01.0-[01-02]----00.0-[02]----08.0      <<<<<<<<<<
> >              +-01.1-[03]----00.0
> 
> OK, this is what I suspected might be happening, thanks for confirming.
> 
> > Then among all the other devices, I have this from `dmesg`
> > 
> > [...]
> > [    2.212107] DMAR: Hardware identity mapping for device 0000:00:1f.3
> > [    2.219113] DMAR: Hardware identity mapping for device 0000:03:00.0
> > [    2.226118] DMAR: Hardware identity mapping for device 0000:04:00.0
> > [    2.233123] DMAR: Hardware identity mapping for device 0000:04:00.1
> > [...]
> > [    2.693295] iommu: Adding device 0000:00:1f.3 to group 22
> > [    2.699350] iommu: Adding device 0000:01:00.0 to group 23
> > [    2.705389] iommu: Adding device 0000:02:08.0 to group 23
> > [    2.711444] iommu: Adding device 0000:03:00.0 to group 24
> > [    2.717552] iommu: Adding device 0000:04:00.0 to group 25
> > [...]
> > 
> > 
> > It misses the message "Hardware identity mapping for device 0000:02:08.0".
> > Is it possible that there is not a valid DMAR table?
> 
> I'm a bit sketchy on intel-iommu details as well, but based on a quick
> scan through the code I'd assume your endpoint doesn't get an identity
> mapping because it's a PCI device behind a PCIe-to-PCI bridge (which
> ties in with the RID alias to DevFn 00.0). AFAICS that then means that
> the DMA ops should always give back a remapped address (i.e. iommu=pt
> ends up behaving the same as iommu=on), at which point it does start to
> look like your device is simply making bogus accesses.
> 
> The IOVA allocator will allocate DMA addresses downwards from
> 0xfffff000, but your reported fault addresses don't look anything like
> that, so I'd imagine that either some part of the driver is bypassing
> the DMA API and erroneously passing physical addresses to the hardware,

I don't think that this is the case. The addresses returned by 
dma_alloc_coherent are consistent with the IOVA logic:

[...]
[67594.620282] DMA addr 0x00000000ffffd000
[67594.620294] DMA addr 0x00000000ffffc000
[67594.620305] DMA addr 0x00000000ffffb000
[67594.620314] DMA addr 0x00000000ffffa000
[...]

and this is the address that is going to be programmed in the hardware 
register.


> or alternatively the hardware itself is going wrong somehow (e.g. trying
> to read a buffer address from an in-memory descriptor, getting back
> junk, and going downhill from there).

Probably it worth to have a look there
 
> Hope that helps,

Thank you

-- 
Federico Vaga
http://www.federicovaga.it/
