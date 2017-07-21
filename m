From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V2 1/3] Docs: dt: rockchip: add rk-iommu,
	disable-reset-quirk property
Date: Fri, 21 Jul 2017 08:57:24 +0200
Message-ID: <1872258.Scr61cjSnF@phil>
References: <1500618430-114821-1-git-send-email-xxm@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1500618430-114821-1-git-send-email-xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

Am Freitag, 21. Juli 2017, 14:27:08 CEST schrieb Simon Xue:
> From: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> Add rk-iommu,disable-reset-quirk property to ignore the isp mmu
> reset operation
> 
> Signed-off-by: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

please use your full name in From and Signed-off.

Also, you need to include devicetree-people and mailinglists (as
scripts/get_maintainer.pl will show you) when sending dt-binding
changes.


> ---
> changes since V1:
>  - new added file
> 
>  Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 9a55ac3..aa2136c 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -15,6 +15,11 @@ Required properties:
>                      to associate with its master device.  See:
>                      Documentation/devicetree/bindings/iommu/iommu.txt
>  
> +Optional properties:
> +- rk-iommu,disable-reset-quirk : This ignore the isp mmu reset operation.

Prefix should be "rockchip," not "rk-iommu,".

Also, this quirk could be renamed to something like:

rockchip,disable-mmu-reset: Don't use the mmu reset operation.
				Some mmu instances may produce unexpected results
				when the reset operation is used.

But that is more a 

Heiko

> +				 It can't get the expected result when isp mmu
> +				 reset, but the reset function work normally
> +
>  Example:
>  
>  	vopl_mmu: iommu@ff940300 {
> 
