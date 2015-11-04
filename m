From: Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 4 Nov 2015 09:35:26 -0800
Message-ID: <563A41DE.2010902@redhat.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
	<1446626388.6400.21.camel@mhfsdcap03> <563A0419.9070100@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <563A0419.9070100-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, labbott-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/04/2015 05:11 AM, Robin Murphy wrote:
> On 04/11/15 08:39, Yong Wu wrote:
>> On Thu, 2015-10-01 at 20:13 +0100, Robin Murphy wrote:
>>> Taking some inspiration from the arch/arm code, implement the
>>> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>> [...]
>>> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>>> +                 dma_addr_t *handle, gfp_t gfp,
>>> +                 struct dma_attrs *attrs)
>>> +{
>>> +    bool coherent = is_device_dma_coherent(dev);
>>> +    int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
>>> +    void *addr;
>>> +
>>> +    if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
>>> +        return NULL;
>>> +    /*
>>> +     * Some drivers rely on this, and we probably don't want the
>>> +     * possibility of stale kernel data being read by devices anyway.
>>> +     */
>>> +    gfp |= __GFP_ZERO;
>>> +
>>> +    if (gfp & __GFP_WAIT) {
>>> +        struct page **pages;
>>> +        pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
>>> +
>>> +        pages = iommu_dma_alloc(dev, size, gfp, ioprot,    handle,
>>> +                    flush_page);
>>> +        if (!pages)
>>> +            return NULL;
>>> +
>>> +        addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
>>> +                          __builtin_return_address(0));
>>> +        if (!addr)
>>> +            iommu_dma_free(dev, pages, size, handle);
>>> +    } else {
>>> +        struct page *page;
>>> +        /*
>>> +         * In atomic context we can't remap anything, so we'll only
>>> +         * get the virtually contiguous buffer we need by way of a
>>> +         * physically contiguous allocation.
>>> +         */
>>> +        if (coherent) {
>>> +            page = alloc_pages(gfp, get_order(size));
>>> +            addr = page ? page_address(page) : NULL;
>>> +        } else {
>>> +            addr = __alloc_from_pool(size, &page, gfp);
>>> +        }
>>> +        if (!addr)
>>> +            return NULL;
>>> +
>>> +        *handle = iommu_dma_map_page(dev, page, 0, size, ioprot);
>>> +        if (iommu_dma_mapping_error(dev, *handle)) {
>>> +            if (coherent)
>>> +                __free_pages(page, get_order(size));
>>> +            else
>>> +                __free_from_pool(addr, size);
>>> +            addr = NULL;
>>> +        }
>>> +    }
>>> +    return addr;
>>> +}
>>> +
>>> +static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>>> +                   dma_addr_t handle, struct dma_attrs *attrs)
>>> +{
>>> +    /*
>>> +     * @cpu_addr will be one of 3 things depending on how it was allocated:
>>> +     * - A remapped array of pages from iommu_dma_alloc(), for all
>>> +     *   non-atomic allocations.
>>> +     * - A non-cacheable alias from the atomic pool, for atomic
>>> +     *   allocations by non-coherent devices.
>>> +     * - A normal lowmem address, for atomic allocations by
>>> +     *   coherent devices.
>>> +     * Hence how dodgy the below logic looks...
>>> +     */
>>> +    if (__in_atomic_pool(cpu_addr, size)) {
>>> +        iommu_dma_unmap_page(dev, handle, size, 0, NULL);
>>> +        __free_from_pool(cpu_addr, size);
>>> +    } else if (is_vmalloc_addr(cpu_addr)){
>>> +        struct vm_struct *area = find_vm_area(cpu_addr);
>>> +
>>> +        if (WARN_ON(!area || !area->pages))
>>> +            return;
>>> +        iommu_dma_free(dev, area->pages, size, &handle);
>>> +        dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>>
>> Hi Robin,
>>      We get a WARN issue while the size is not aligned here.
>>
>>      The WARN log is:
>> [  206.852002] WARNING: CPU: 0 PID: 23329
>> at /mnt/host/source/src/third_party/kernel/v3.18/mm/vmalloc.c:65
>> vunmap_page_range+0x190/0x1b4()
>> [  206.864438] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat
>> rfcomm i2c_dev uinput dm9601 uvcvideo btmrvl_sdio mwifiex_sdio mwifiex
>> btmrvl bluetooth zram fuse cfg80211 nf_conntrack_ipv6 nf_defrag_ipv6
>> ip6table_filter ip6_tables cdc_ether usbnet mii joydev snd_seq_midi
>> snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device ppp_async
>> ppp_generic slhc tun
>> [  206.902983] CPU: 0 PID: 23329 Comm: chrome Not tainted 3.18.0 #17
>> [  206.910430] Hardware name: Mediatek Oak rev3 board (DT)
>> [  206.920018] Call trace:
>> [  206.925537] [<ffffffc000208c00>] dump_backtrace+0x0/0x140
>> [  206.931905] [<ffffffc000208d5c>] show_stack+0x1c/0x28
>> [  206.939158] [<ffffffc000870f80>] dump_stack+0x74/0x94
>> [  206.947459] [<ffffffc0002219a4>] warn_slowpath_common+0x90/0xb8
>> [  206.954100] [<ffffffc000221b58>] warn_slowpath_null+0x34/0x44
>> [  206.961537] [<ffffffc000321358>] vunmap_page_range+0x18c/0x1b4
>> [  206.967630] [<ffffffc0003213e4>] unmap_kernel_range+0x2c/0x78
>> [  206.976977] [<ffffffc000582224>] dma_common_free_remap+0x68/0x80
>> [  206.983581] [<ffffffc000217260>] __iommu_free_attrs+0x14c/0x160
>> [  206.989646] [<ffffffc00066fc1c>] mtk_vcodec_mem_free+0xa0/0x15c
>> [  206.996481] [<ffffffc00067e278>] vp9_free_work_buf+0x54/0x70
>> [  207.002260] [<ffffffc00067f168>] vdec_vp9_deinit+0x7c/0xe8
>> [  207.008134] [<ffffffc0006787d8>] vdec_if_deinit+0x84/0xec
>> [  207.013820] [<ffffffc000677898>] mtk_vcodec_vdec_release+0x54/0x6c
>> [  207.020672] [<ffffffc000673e3c>] fops_vcodec_release+0x7c/0xf8
>> [  207.026607] [<ffffffc000652b78>] v4l2_release+0x3c/0x84
>> [  207.031824] [<ffffffc00033b218>] __fput+0xf8/0x1c0
>> [  207.036599] [<ffffffc00033b350>] ____fput+0x1c/0x2c
>> [  207.041454] [<ffffffc00023ed78>] task_work_run+0xb0/0xd4
>> [  207.046756] [<ffffffc00020872c>] do_notify_resume+0x54/0x6c
>>
>>
>>     From the log I get in this fail case, the size of unmap here is
>> 0x10080, and its map size of dma_common_pages_remap in
>> __iommu_alloc_attrs is 0x10080, and the corresponding dma-map size is
>> 0x11000(after iova_align). I think all the parameters of map and unmap
>> are good, it look like not a DMA issue. but I don't know why we get this
>> warning.
>> Have you met this problem and give us some advices, Thanks.
>>
>> (If we add PAGE_ALIGN for the size in dma_alloc and dma_free, It is OK.)
>
> OK, having dug into this it looks like the root cause comes from some asymmetry in the common code: dma_common_pages remap() just passes the size through to get_vm_area_caller(), and the first thing that does is to page-align it. On the other hand, neither dma_common_free_remap() nor unmap_kernel_range() does anything with the size, so we wind up giving an unaligned end address to vunmap_page_range() and messing up the vmalloc page tables.
>
> I wonder if dma_common_free_remap() should be page-aligning the size to match expectations (i.e. make it correctly unmap any request the other functions happily mapped), or conversely, perhaps both the map and unmap functions should have a WARN_ON(size & PAGE_MASK) to enforce being called as actually intended. Laura?
>

Based on what I've found, the DMA mapping API needs to be able to handle unaligned sizes
gracefully so I don't think a warn is appropriate. I was aligning at the higher level but
it would be best for dma_common_free_remap to align as well.
  
> Either way, I'll send out a patch to make the arm64 side deal with it explicitly.
>
> Robin.
>

Thanks,
Laura
