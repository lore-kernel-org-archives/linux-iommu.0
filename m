From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: problems with iommu and userspace DMA to hugepages, how to add
	iommu mapings from userspace.
Date: Thu, 10 Nov 2016 07:04:32 -0700
Message-ID: <20161110070432.0520e389@t450s.home>
References: <CAF-VNarFte4k0bAEjYkUMaCeWXqFZZdn-EHFPGKj8M7y9iCd+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF-VNarFte4k0bAEjYkUMaCeWXqFZZdn-EHFPGKj8M7y9iCd+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lars Segerlund <lars.segerlund-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 10 Nov 2016 12:16:19 +0100
Lars Segerlund <lars.segerlund-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>  Hi,
> 
>  I am getting these errors from a userspace 'device driver' ,
> 
> [599805.585424] DMAR: DRHD: handling fault status reg 202
> [599805.585431] DMAR: DMAR:[DMA Read] Request device [03:00.0] fault addr
> 4c0008000
>                 DMAR:[fault reason 06] PTE Read access is not set
> 
>  Basicly i mapp a dma engine in a PCIe card by uio to a userspace library,
> and then allocate hugepages ( continous ),  do a virt to phys translation
> via /proc/self/.... setup a dma and turn it on.
> 
> The message tells me I lack iommu mappings for the memory regions i try to
> read/write , so far so good nothing unexpected.
> 
> My problem is that I have to run with intel_iommu=on iommu=pt flags to the
> kernel due to other hard/software on the machine, I can't turn iommu off
> completely.
> 
> So I have the question is it possible to add iommu mappings from userspace
> ? through iommu groups in /sys/..  ?
> 
> So far all applications that does something similar either uses vfio or
> some kernel driver callback and I would prefer not to do this.
> ( I had high hopes for dpdk pmd driver but so far no luck ).

vfio is the right way to do this.
