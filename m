From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Sat, 14 Apr 2012 08:51:52 -0700
Message-ID: <4F899D18.6000700@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com> <CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 04/12/12 01:19, KyongHo Cho wrote:
> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> Hi!
>>
>> These two patches fixes operation of the SYSMMU driver (v12 version [1])
>> with the new power domain driver based on generic power domains and
>> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>>
> Thanks, Marek.
>
> Your way of power gating is right
> and I will look into the changed runtime PM scheme in Exynos tree.
>
KyongHo,

Do you want to upstream this series with your previous sysmmu (cleanup 
and moving) patches?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
