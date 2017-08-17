From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] dt-bindings: mediatek: Add binding for mt2712 IOMMU
	and SMI
Date: Thu, 17 Aug 2017 10:33:41 -0500
Message-ID: <20170817153220.52mt3jjgyktydeln@rob-hp-laptop>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
	<1502445377-26936-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502445377-26936-2-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 11, 2017 at 05:56:10PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt2712 IOMMU and SMI.
> 
> In order to balance the bandwidth, mt2712 has two M4Us, two
> smi-commons, 8 smi-larbs. and mt2712 is also MTK IOMMU gen2 which
> use Short-Descriptor translation table format.

s/use/uses/

> 
> The mt2712 M4U-SMI HW diagram is as below:
> 
>                             EMI
>                              |
>               -------------------------------
>               |                             |
>              M4U0                          M4U1
>               |                             |
>          smi-common0                   smi-common1
>               |                             |
>   -------------------------       --------------------
>   |     |     |     |     |       |         |        |
>   |     |     |     |     |       |         |        |
> larb0 larb1 larb2 larb3 larb6    larb4    larb5     larb7
> disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2  mdp3->larb names
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
>  include/dt-bindings/memory/mt2712-larb-port.h      | 91 ++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
