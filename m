From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 1/2] staging: fsl-dpaa2/eth: Fix address translations
Date: Wed, 24 May 2017 12:33:53 +0000
Message-ID: <59257DB0.8010604@nxp.com>
References: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
Content-Language: en-US
Content-ID: <1B196A65277E1543B853FF0C94AEAFC2@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Nipun Gupta <nipun.gupta@nxp.com>, Bogdan Purcareata <bogdan.purcareata@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ioana,

Debatable nit inline.

On 05/24/2017 03:13 PM, Ioana Radulescu wrote:
> Use the correct mechanisms for translating a DMA-mapped IOVA
> address into a virtual one. Without this fix, once SMMU is
> enabled on Layerscape platforms, the Ethernet driver throws
> IOMMU translation faults.
>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> ---
>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 25 +++++++++++++++++++------
>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |  1 +
>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> index 6f9eed66c64d..3fee0d6f17e0 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> @@ -37,6 +37,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/msi.h>
>   #include <linux/kthread.h>
> +#include <linux/iommu.h>
>
>   #include "../../fsl-mc/include/mc.h"
>   #include "../../fsl-mc/include/mc-sys.h"
> @@ -54,6 +55,16 @@ MODULE_DESCRIPTION("Freescale DPAA2 Ethernet Driver");
>
>   const char dpaa2_eth_drv_version[] = "0.1";
>
> +static void *dpaa2_iova_to_virt(struct iommu_domain *domain,

if you pass a "struct dpaa2_eth_priv *priv" instead of "iommu_domain" 
you can move the priv->iommu_domain reference in the function and 
slightly simplify the call sites.

---
Best Regards, Laurentiu
