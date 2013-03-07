From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu: add a dma remap fault reason.
Date: Thu, 07 Mar 2013 13:31:05 -0500
Message-ID: <5138DCE9.1010204@redhat.com>
References: <1362537797-6034-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1362537797-6034-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

cc-ing the upstream iommu-list

On 03/05/2013 09:43 PM, Li, Zhen-Hua wrote:
> The number of dma fault reasons in intel's document are from 1 to 0xD, but in dmar.c I cannot find fault reason 0xD.
>
> In this document:
> Intel Virtualization Technology for Directed I/O Architecture Specification
> http://download.intel.com/technology/computing/vptech/Intel(r)_VT_for_Direct_IO.pdf
>
> Chapter 4. Support For Device-IOTLBs
>
> Table 6. Unsuccessful Translated Requests
>
> There is fault reason for 0xD not listed in kernel:
>      Present context-entry used to process translation request
>      specifies blocking of Translation Requests (Translation Type (T)
>      field value not equal to 01b).
>
> So I think 0xD should be added.
>
> Signed-off-by: Li, Zhen-Hua<zhen-hual-VXdhtT5mjnY@public.gmane.org>
> ---
>   drivers/iommu/dmar.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index dc7e478..e5cdaf8 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1083,6 +1083,7 @@ static const char *dma_remap_fault_reasons[] =
>   	"non-zero reserved fields in RTP",
>   	"non-zero reserved fields in CTP",
>   	"non-zero reserved fields in PTE",
> +	"PCE for translation request specifies blocking",
>   };
>
>   static const char *irq_remap_fault_reasons[] =
