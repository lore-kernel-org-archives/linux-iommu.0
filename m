From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
Date: Wed, 28 Mar 2012 18:23:47 -0700
Message-ID: <4F73B9A3.30605@samsung.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com> <20120315111227.GA2384@amd.com> <4F61FF1D.5000502@samsung.com> <4F630841.2070307@linaro.org> <4F63A6F6.9050506@samsung.com> <20120318132746.GL26973@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120318132746.GL26973@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Younglak Kim' <younglak1004.kim@samsung.com>, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel wrote:
> On Fri, Mar 16, 2012 at 01:47:50PM -0700, Kukjin Kim wrote:
>> Anyway Joerg, how do you want to handle this? Do you want to pick up
>> 1/2/3 all of them in your tree? If so, 2nd patch should be on top of
>> some samsung topic stuff.
>
> Since patch 2 only applies to the Samsung tree, it is best to carry
> this in your tree for merging. Feel free to add my Acked-by to patch 3.
> But any further patches for the Exynos IOMMU drivers should go through
> my tree after it is merged.
>

Hi Joerg,

Now that 1st and 2nd can be applied cleanly into latest mainline. But 
unfortunately, I have no chance to send them to Linus now and I'm not 
sure you can do it during this merge window. If it is possible, please 
keep going on with my ack.

KyongHo, just note, happens follwoing complaint with checkpatch, but I'm 
not sure this should be fixed right now. I think, if required, we can 
fix it later.

ERROR: Macros with complex values should be enclosed in parenthesis
#698: FILE: arch/arm/mach-exynos/dev-sysmmu.c:64:
+#define DEFINE_SYSMMU_RESOURCE(core, mem, irq)                         \
+       DEFINE_RES_MEM_NAMED(core##_PA_SYSMMU_##mem, SZ_4K, #mem),      \
+       DEFINE_RES_IRQ_NAMED(core##_IRQ_SYSMMU_##irq##_0, #mem)

ERROR: Macros with complex values should be enclosed in parenthesis
#702: FILE: arch/arm/mach-exynos/dev-sysmmu.c:68:
+#define SYSMMU_RESOURCE_DEFINE(core, ipname, mem, irq)                 \
+       SYSMMU_RESOURCE(core, ipname) {                                 \
+               DEFINE_SYSMMU_RESOURCE(core, mem, irq)                  \
+       }

WARNING: quoted string split across lines
#914: FILE: arch/arm/mach-exynos/dev-sysmmu.c:259:
+                               pr_err("%s: Failed to add device 
resources for "
+                                               "%s.%d\n", __func__,

total: 2 errors, 1 warnings, 1062 lines checked

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
