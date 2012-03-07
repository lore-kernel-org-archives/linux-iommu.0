From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v10 2/3] ARM: EXYNOS: Change System MMU platform device definitions
Date: Wed, 7 Mar 2012 09:10:42 +0900
Message-ID: <CAHQjnOP_mEck35PwhDd7v=MKc+ONFRFxa7i=ro0iMxWy-fuFNw@mail.gmail.com>
References: <002101ccfb73$8684c240$938e46c0$%cho@samsung.com>
	<CAH9JG2Uvc27UMcsy_Apqo+Td_td_18C6i3vvC8aroBse2=+53w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAH9JG2Uvc27UMcsy_Apqo+Td_td_18C6i3vvC8aroBse2=+53w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Subash Patel <subash.ramaswamy@linaro.org>, Younglak Kim <younglak1004.kim@samsung.com>, iommu@lists.linux-foundation.org, Kukjin Kim <kgene.kim@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 6, 2012 at 7:03 PM, Kyungmin Park <kyungmin.park@samsung.co=
m> wrote:
>>
>> -#define S5P_SYSMMU_TOTAL_IPNUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXYNOS4_=
SYSMMU_TOTAL_IPNUM
>> +#define SYSMMU_DEVNAME_BASE "exynos-sysmmu"
>> +
>> +#define SYSMMU_CLOCK_NAME "sysmmu"
>> +#define SYSMMU_CLOCK_NAME2 "sysmmu_mc"
> What's the meaning of "mc"?
It stands for multi clock gating source.
ISP block has a lot of System MMUs and I merged them in a single
platform device to control them easier. However it is required to acces=
s
2 control registers to gating  their clocks. "sysmmu_mc" is prepared fo=
r the
case that requires 2 clock descriptors for clock gating.

>> +
>> +#ifdef CONFIG_EXYNOS_DEV_SYSMMU
>> +#include <linux/device.h>
>> +struct platform_device;
>> +
>> +#define SYSMMU_PLATDEV(ipname) exynos_device_sysmmu_##ipname
>> +
>> +extern struct platform_device SYSMMU_PLATDEV(mfc_l);
>> +extern struct platform_device SYSMMU_PLATDEV(mfc_r);
>> +extern struct platform_device SYSMMU_PLATDEV(tv);
>> +extern struct platform_device SYSMMU_PLATDEV(jpeg);
>> +extern struct platform_device SYSMMU_PLATDEV(rot);
> Where's the fimc platform_device?
>
> I think you only tested it with exynos5.

True. I am sorry that I have missed to define it externally.
Thank you.

Cho KyongHo.
