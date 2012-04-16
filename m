From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Mon, 16 Apr 2012 18:54:55 +0900
Message-ID: <CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
	<CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
	<4F899D18.6000700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F899D18.6000700@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Apr 15, 2012 at 12:51 AM, Kukjin Kim <kgene.kim@samsung.com> wr=
ote:
> On 04/12/12 01:19, KyongHo Cho wrote:
>>
>> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> =A0wrote:
>>>
>>> Hi!
>>>
>>> These two patches fixes operation of the SYSMMU driver (v12 version=
 [1])
>>> with the new power domain driver based on generic power domains and
>>> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>>>
>> Thanks, Marek.
>>
>> Your way of power gating is right
>> and I will look into the changed runtime PM scheme in Exynos tree.
>>
> KyongHo,
>
> Do you want to upstream this series with your previous sysmmu (cleanu=
p and
> moving) patches?
>

Yes I hope so.
Marek's patch corrects run-time power management in Exynos4 with System=
 MMU.

Thank you.

KyongHo
