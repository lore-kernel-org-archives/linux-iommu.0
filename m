From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [lkp] [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
 msi_domain_alloc/free_irqs
Date: Tue, 26 Apr 2016 09:24:13 +0800
Message-ID: <20160426012413.GC11960@yexl-desktop>
References: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
 <57173407.9040401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57173407.9040401@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, eric.auger@st.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 20, 2016 at 09:47:19AM +0200, Eric Auger wrote:
>Hi,
>
Hi, Eric
>Both reported errors related to this series are due to the fact part n
>has dependency on part n-1.
>

If I understand correctly, what you meant is that you send patch series
(let's say B), and B has its dependency patch series A which is in-flight
and hasn't been merged, so the commit history is like:

        ---P---A---B

where P is the well-known commit in public linux tree. In this case,
0day just applied B based on P without A, thus caused the build error.

>Does anyone know how to let the 0-day CI robot know about such
>dependency between series?
>

Currently, we have proposed to add a new '--base' option for git-format-patch
to git community[1], developers could use this option to record the base tree
information which could help 0day to identify the state the patch series
applies to, thus 0day could avoid false report like this case.

For example, imagine that on top of the public commit P, you applied well-known
patches X, Y and Z from somebody else or yourself, and then built your
three-patch series A, B, C, the history would be like:

................................................
---P---X---Y---Z---A---B---C
................................................

With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
`--cover-letter` of using `Z..C` instead of `-3 C` to specify the
range), the base tree information block is shown at the end of the
first message the command outputs (either the first patch, or the
cover letter), like this:

------------
base-commit: P
prerequisite-patch-id: X
prerequisite-patch-id: Y
prerequisite-patch-id: Z
------------

Now this feature is still under review in git community[2], hope it could be
merged in next git release.


[1] http://thread.gmane.org/gmane.comp.version-control.git/286873
[2] http://thread.gmane.org/gmane.comp.version-control.git/292168

Thanks,
Xiaolong

>If it is an inconvenience I can put all the patches back into the same
>big series, specifying tentative patch split according to sub-systems in
>the cover-letter?
>
>Thank you in advance
>
>Best Regards
>
>Eric
>
>04/19/2016 08:04 PM, kbuild test robot wrote:
>> Hi,
>> 
>> [auto build test ERROR on tip/irq/core]
>> [also build test ERROR on v4.6-rc4 next-20160419]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160420-011957
>> config: x86_64-lkp (attached as .config)
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64 
>> 
>> All errors (new ones prefixed by >>):
>> 
>>>> kernel/irq/msi.c:17:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
>>     #include <linux/dma-reserved-iommu.h>
>>                                          ^
>>    compilation terminated.
>> 
>> vim +17 kernel/irq/msi.c
>> 
>>     11	 */
>>     12	#include <linux/types.h>
>>     13	#include <linux/device.h>
>>     14	#include <linux/irq.h>
>>     15	#include <linux/irqdomain.h>
>>     16	#include <linux/msi.h>
>>   > 17	#include <linux/dma-reserved-iommu.h>
>>     18	#include <linux/iommu.h>
>>     19	
>>     20	/* Temparory solution for building, will be removed later */
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>> 
>
