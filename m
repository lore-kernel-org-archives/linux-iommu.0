From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 0/6] Exynos SYSMMU (IOMMU) dts and arch updates
Date: Thu, 04 Jun 2015 12:51:07 +0900
Message-ID: <556FCB2B.8090406@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
 <556C4342.6060506@samsung.com> <556F89B2.9010607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <556F89B2.9010607@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On 04.06.2015 08:11, Kukjin Kim wrote:
> On 06/01/15 20:34, Krzysztof Kozlowski wrote:
>> W dniu 01.06.2015 o 19:10, Marek Szyprowski pisze:
>>> Hello,
>>>
>>> Main changes for Exynos SYSMMU (IOMMU) driver has been finally scheduled
>>> for merging - see
>>> https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=next
>>> In meantime there have been quite a lot of changes related to Exynos DTS
>>> files queued for merging and my patches don't apply anymore. To ease
>>> merge process I've decided to rebased all Exynos SYSMMU dts changes onto
>>> latest exynos next tree from: https://github.com/krzk/linux dt-for-next
>>>
>>> While rebasing I've fixes a few spotted issues: some nodes still used
>>> old 'samsung,power-domain' properties (now replaced with 'power-domains')
>>> and added properties to jpeg codec merged recently.
>>>
>>
>> Thanks for rebasing this stuff.
>>
> Same here ;-)
> 
>> I picked whole patchset with Javier's tested-by. I'll send it to Kukjin
>> later or directly to arm-soc (depending what will happen with last pull
>> request).
>>
>> Kukjin, you mentioned that you will do something with this patchset the
>> previous weekend. Since then nothing happened so I am not sure what are
>> your plans... Can you share them? Do you want to pick it by yourself, do
>> you have any comments or maybe you need something from our side? (I
>> checked the patches and they look fine)
>>
> Done, thanks.

Thank you, I tested the for-next branch on some of my boards and
everything looked fine.

Best regards,
Krzysztof
