From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
Date: Sat, 25 Feb 2012 01:08:36 +0900
Message-ID: <CAHQjnOPE5X=dn+8D348OruLqoYNGZwZk3eLtLRSERce-eTzXDg@mail.gmail.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
	<014601ccf2fa$a25c8560$e7159020$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <014601ccf2fa$a25c8560$e7159020$%szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, Younglak Kim <younglak1004.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek.

On Fri, Feb 24, 2012 at 10:45 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi,
>
> On Thursday, December 29, 2011 1:24 PM KyongHo Cho wrote:
>
>> Changes since v7:
>> - Rebased with the recent commits of the following git branches
>> =A0 * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
>> =A0 * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.gi=
t/for-next
>> - Changed magic numbers into macros
>> - Setting owner of a System MMU in 'iommu' field of dev_archdata
>> - Verbose message in the default fault handler
>> - Some bug fixes.
>
> (snipped)
>
> The time is flying away and v3.4 merge windows will open soon. Do you=
 plan to
> send an updated version of the SYSMMU driver anytime soon? It will be=
 really
> nice to have it finally merged to v3.4.
>

Thank you for asking.

I prepared a new patchset and it is ready for submitting.
It includes several bugfixes and Exynos5 support.

The last patche submitted has a bug when the following situation:
   1. Allocating a 2nd level page table to map 4KB or 64KB on a virtual=
 region
   2. Unmapped all entries in the 2nd level page table.
   3. Mapping to the same region with 1MB page.
   Then iommu_map() will return -EADDRINUSE due to incorrect counting
   free entries in 2nd level page table.

The next patch will be submitted by 2/28.

BTW Marek, I want to know why MFC driver defines separate platform devi=
ces
for left and right buses.
The next IOMMU driver defines just one platform device for a H/W device=
=2E
Thus, it defines just one SYSMMU_MFC platform device, for example.
(the previous one defines 2 platform devices for SYSMMU_MFC)
However, it is easy to separate the single platform device to multiple
platform devices.

Regards,

Cho KyongHo.
