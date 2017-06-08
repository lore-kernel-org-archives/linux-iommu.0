From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 03/12] intel-ipu3: Add DMA API implementation
Date: Thu, 8 Jun 2017 11:55:18 +0900
Message-ID: <CAAFQd5BYk6ErzaLgVp+sL2sQg1FzFjDu4tg_b3KBCAM7=39icw@mail.gmail.com>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
	<1496695157-19926-4-git-send-email-yong.zhi@intel.com>
	<CAAFQd5CLXUsDv6H1C22tc4qjG9e7tm5jtxwYBjV5gx9qrDw50A@mail.gmail.com>
	<20170607184512.0e627965@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170607184512.0e627965-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Zheng, Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Toivonen, Tuukka" <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mani,
	Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alan,

On Thu, Jun 8, 2017 at 2:45 AM, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> > +       struct ipu3_mmu *mmu = to_ipu3_mmu(dev);
>> > +       dma_addr_t daddr = iommu_iova_to_phys(mmu->domain, dma_handle);
>> > +
>> > +       clflush_cache_range(phys_to_virt(daddr), size);
>>
>> You might need to consider another IOMMU on the way here. Generally,
>> given that daddr is your MMU DMA address (not necessarily CPU physical
>> address), you should be able to call
>>
>> dma_sync_single_for_cpu(<your pci device>, daddr, size, dir)
>
> Te system IOMMU (if enabled) may be cache coherent - and on x86 would be,
> so it doesn't think it needs to do anything for cache synchronization
> and the dma_sync won't actually do any work.

I'm not very familiar with x86, but typically I found coherency to be
an attribute of the DMA master (i.e. if it is connected to a coherent
memory port).

Looking at all the IPU3 code, it looks like the whole PCI device is
non-coherent for some reason (e.g. you can see implicit cache flushes
for page tables). So I would have expected that a non-coherent variant
of x86 dma_ops is used for the PCI struct device, which would do cache
maintenance in its dma_sync_* ops.

Best regards,
Tomasz
