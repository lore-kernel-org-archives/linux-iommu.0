From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
	msi_domain_alloc/free_irqs
Date: Wed, 20 Apr 2016 09:47:19 +0200
Message-ID: <57173407.9040401@linaro.org>
References: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201604200215.XNyvZSsl%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Both reported errors related to this series are due to the fact part n
has dependency on part n-1.

Does anyone know how to let the 0-day CI robot know about such
dependency between series?

If it is an inconvenience I can put all the patches back into the same
big series, specifying tentative patch split according to sub-systems in
the cover-letter?

Thank you in advance

Best Regards

Eric

04/19/2016 08:04 PM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on tip/irq/core]
> [also build test ERROR on v4.6-rc4 next-20160419]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160420-011957
> config: x86_64-lkp (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/irq/msi.c:17:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
>     #include <linux/dma-reserved-iommu.h>
>                                          ^
>    compilation terminated.
> 
> vim +17 kernel/irq/msi.c
> 
>     11	 */
>     12	#include <linux/types.h>
>     13	#include <linux/device.h>
>     14	#include <linux/irq.h>
>     15	#include <linux/irqdomain.h>
>     16	#include <linux/msi.h>
>   > 17	#include <linux/dma-reserved-iommu.h>
>     18	#include <linux/iommu.h>
>     19	
>     20	/* Temparory solution for building, will be removed later */
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
