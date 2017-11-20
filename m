From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: No check of the size passed to unmap_single in  swiotlb
Date: Mon, 20 Nov 2017 11:26:52 -0500
Message-ID: <20171120162652.GR24312@char.us.oracle.com>
References: <VI1PR04MB30715EA7212DC661481041438C220@VI1PR04MB3071.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB30715EA7212DC661481041438C220-mr6QIVyDiCFHIX2o+zdTns9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Yang <yu.yang_3-3arQi8VN3Tc@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 20, 2017 at 08:17:14AM +0000, Eric Yang wrote:
> Hi all,

Hi!
> 
> During debug a  device only support 32bits DMA(Qualcomm Atheros AP) in our LS1043A 64bits ARM  SOC, we found that the invoke of dma_unmap_single --> swiotlb_tbl_unmap_single  will unmap the passed "size" anyway even when the "size" is incorrect.
> 
> If the size is larger than it should, the extra entries in io_tlb_orig_addr array will be refilled by INVALID_PHYS_ADDR, and it will cause the bounce buffer copy not happen when the one who really used the mis-freed entries doing  DMA data transfers, and this will cause further unknow behaviors.
> 
> Here we just fix it temporarily by adding a judge of the "size" in the swiotlb_tbl_unmap_single, if it is larger than it deserves, just unmap the right size only. Like the code:

Did the DMA debug API (CONFIG_DMA_API_DEBUG) help in figuring this issue as well?

> 
> [yangyu@titan dash-lts]$ git diff ./lib/swiotlb.c
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index ad1d2962d129..58c97ede9d78 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -591,7 +591,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>                  */
>                 for (i = index + nslots - 1; i >= index; i--) {
>                         io_tlb_list[i] = ++count;
> -                       io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> +                      if(io_tlb_orig_addr[i]  != orig_addr)
> +                          printk("======size wrong, ally down ally down!===\n");
> +                      else
> +                         io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>                 }
>                 /*
>                  * Step 2: merge the returned slots with the preceding slots,
> 
> Although pass a right size of DMA buffer is the responsibility of  the drivers, but Is it useful to add some size check code to prevent  real damage happen? 
> 
> Regards,
> Eric
