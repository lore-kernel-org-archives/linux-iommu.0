From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: add qcom_iommu
Date: Fri, 5 May 2017 14:50:51 -0500
Message-ID: <CAL_Jsq+nheA0=Boz0EeNvW7TNZvYQvUi3Z_=hFk9yTN8bLV+fg@mail.gmail.com>
References: <20170504133436.24288-4-robdclark@gmail.com> <20170505182151.22931-1-robdclark@gmail.com>
 <CAL_Jsq+5noR6pE5da9C8PTdX2c5HE9s4Mt4ovMi6w9FbhX6EXg@mail.gmail.com> <CAF6AEGuZgt8OVg+YwOYh5ECOU66ZBAf_6XchAA1NR586S8TouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGuZgt8OVg+YwOYh5ECOU66ZBAf_6XchAA1NR586S8TouA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 5, 2017 at 2:37 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Fri, May 5, 2017 at 3:04 PM, Rob Herring <robh@kernel.org> wrote:
>> On Fri, May 5, 2017 at 1:21 PM, Rob Clark <robdclark@gmail.com> wrote:
>>> An iommu driver for Qualcomm "B" family devices which do not completely
>>> implement the ARM SMMU spec.  These devices have context-bank register
>>> layout that is similar to ARM SMMU, but no global register space (or at
>>> least not one that is accessible).
>>>
>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>> ---
>>> v1: original
>>> v2: bindings cleanups and kconfig issues that kbuild robot pointed out
>>> v4: fix issues pointed out by Rob H. and actually make device removal
>>>     work
>>> v3: fix WARN_ON() splats reported by Archit
>>>
>>>  drivers/iommu/Kconfig      |   9 +
>>>  drivers/iommu/Makefile     |   1 +
>>>  drivers/iommu/qcom_iommu.c | 833 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 843 insertions(+)
>>>  create mode 100644 drivers/iommu/qcom_iommu.c
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index 37e204f..f8f79a4 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -359,4 +359,13 @@ config MTK_IOMMU_V1
>>>
>>>           if unsure, say N here.
>>>
>>> +config QCOM_IOMMU
>>> +       bool "Qualcomm IOMMU Support"
>>
>> Either this needs to be tristate or...
>>
>> [...]
>>> +#include <linux/module.h>
>>
>> this include and the things that need it should go. Or some
>> explanation like "once X happens, then we can enable as module" and
>> leave it all for now.
>
> tbh, I'm not sure what the issue is for modules (other than
> potentially that you'd want the iommu driver fairly early in boot if
> you didn't have an initrd).  I just saw that the other iommu drivers
> are all bool.  (Sorry, I don't really follow iommu-devel so not
> familiar with the history.)  With my distro hat on, I would prefer
> them to be modules eventually.

For starters, does it even build as a module if you allow that? It
might not work because of some run-time ordering, but that's good
enough for this discussion.

>
>> See this[1] for some background.
>
> it mentions there are some downsides, but I can't see where those
> downsides are listed ;-)
>
> I would kinda prefer to leave the MODULE_*() stuff in place unless
> modular iommu drivers are never going to happen.

Maybe a note, so the module police don't fix it.

Rob
