From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu/exynos: Remove initconst attribute to avoid
 potential kernel oops
Date: Wed, 11 Oct 2017 07:49:05 +0200
Message-ID: <655ae123-dee4-9001-682d-4581070b77ba@samsung.com>
References: <CGME20171009114035eucas1p102089b889ad374b33c3302f1ad84e783@eucas1p1.samsung.com>
        <20171009114023.3427-1-m.szyprowski@samsung.com>
        <20171010121359.kb7b22regypsg2vd@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20171010121359.kb7b22regypsg2vd@8bytes.org>
Content-language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 2017-10-10 14:13, Joerg Roedel wrote:
> On Mon, Oct 09, 2017 at 01:40:23PM +0200, Marek Szyprowski wrote:
>> Exynos SYSMMU registers standard platform device with sysmmu_of_match
>> table, what means that this table is accessed every time a new platform
>> device is registered in a system. This might happen also after the boot,
>> so the table must not be attributed as initconst to avoid potential kernel
>> oops caused by access to freed memory.
>>
>> Fixes: 6b21a5db3642 ("iommu/exynos: Support for device tree")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Applied, thanks.

Could you also apply it to v4.14-fixes, or is it too late for that?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
