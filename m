From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [lkp] [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
	msi_domain_alloc/free_irqs
Date: Tue, 26 Apr 2016 18:43:38 +0200
Message-ID: <571F9ABA.8020307@linaro.org>
References: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
	<57173407.9040401@linaro.org> <20160426012413.GC11960@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160426012413.GC11960@yexl-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ye Xiaolong <xiaolong.ye-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Xiaolong
On 04/26/2016 03:24 AM, Ye Xiaolong wrote:
> On Wed, Apr 20, 2016 at 09:47:19AM +0200, Eric Auger wrote:
>> Hi,
>>
> Hi, Eric
>> Both reported errors related to this series are due to the fact part n
>> has dependency on part n-1.
>>
> 
> If I understand correctly, what you meant is that you send patch series
> (let's say B), and B has its dependency patch series A which is in-flight
> and hasn't been merged, so the commit history is like:
> 
>         ---P---A---B
> 
> where P is the well-known commit in public linux tree. In this case,
> 0day just applied B based on P without A, thus caused the build error.

yes that's it.
> 
>> Does anyone know how to let the 0-day CI robot know about such
>> dependency between series?
>>
> 
> Currently, we have proposed to add a new '--base' option for git-format-patch
> to git community[1], developers could use this option to record the base tree
> information which could help 0day to identify the state the patch series
> applies to, thus 0day could avoid false report like this case.
> 
> For example, imagine that on top of the public commit P, you applied well-known
> patches X, Y and Z from somebody else or yourself, and then built your
> three-patch series A, B, C, the history would be like:
> 
> ................................................
> ---P---X---Y---Z---A---B---C
> ................................................
> 
> With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
> `--cover-letter` of using `Z..C` instead of `-3 C` to specify the
> range), the base tree information block is shown at the end of the
> first message the command outputs (either the first patch, or the
> cover letter), like this:
> 
> ------------
> base-commit: P
> prerequisite-patch-id: X
> prerequisite-patch-id: Y
> prerequisite-patch-id: Z
> ------------
> 
> Now this feature is still under review in git community[2], hope it could be
> merged in next git release.

OK. That's good to know. Thank you very much for the info. I will follow
the progress then.

Best Regards

Eric
> 
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/286873
> [2] http://thread.gmane.org/gmane.comp.version-control.git/292168
> 
> Thanks,
> Xiaolong
> 
>> If it is an inconvenience I can put all the patches back into the same
>> big series, specifying tentative patch split according to sub-systems in
>> the cover-letter?
>>
>> Thank you in advance
>>
>> Best Regards
>>
>> Eric
>>
>> 04/19/2016 08:04 PM, kbuild test robot wrote:
>>> Hi,
>>>
>>> [auto build test ERROR on tip/irq/core]
>>> [also build test ERROR on v4.6-rc4 next-20160419]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160420-011957
>>> config: x86_64-lkp (attached as .config)
>>> reproduce:
>>>         # save the attached .config to linux build tree
>>>         make ARCH=x86_64 
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> kernel/irq/msi.c:17:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
>>>     #include <linux/dma-reserved-iommu.h>
>>>                                          ^
>>>    compilation terminated.
>>>
>>> vim +17 kernel/irq/msi.c
>>>
>>>     11	 */
>>>     12	#include <linux/types.h>
>>>     13	#include <linux/device.h>
>>>     14	#include <linux/irq.h>
>>>     15	#include <linux/irqdomain.h>
>>>     16	#include <linux/msi.h>
>>>   > 17	#include <linux/dma-reserved-iommu.h>
>>>     18	#include <linux/iommu.h>
>>>     19	
>>>     20	/* Temparory solution for building, will be removed later */
>>>
>>> ---
>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>>
>>
