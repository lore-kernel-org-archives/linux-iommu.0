From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Mon, 16 Apr 2012 19:13:23 +0900
Message-ID: <CAHQjnOMbR1SUm=mjfZKLMxwpQasT6JsmXLgmRXyUT+3FyuwpTA@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
	<CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
	<4F899D18.6000700@samsung.com>
	<CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg@mail.gmail.com>
	<CAH9JG2VuBTp30KQGeKUsdQZKuPeAMj8XvGHdH-8r=XA5F2a5qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAH9JG2VuBTp30KQGeKUsdQZKuPeAMj8XvGHdH-8r=XA5F2a5qg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 16, 2012 at 7:01 PM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> On 4/16/12, KyongHo Cho <pullip.cho@samsung.com> wrote:
>> On Sun, Apr 15, 2012 at 12:51 AM, Kukjin Kim <kgene.kim@samsung.com>=
 wrote:
>>> On 04/12/12 01:19, KyongHo Cho wrote:
>>>>
>>>> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
>>>> <m.szyprowski@samsung.com> =A0wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>> These two patches fixes operation of the SYSMMU driver (v12 versi=
on [1])
>>>>> with the new power domain driver based on generic power domains a=
nd
>>>>> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>>>>>
>>>> Thanks, Marek.
>>>>
>>>> Your way of power gating is right
>>>> and I will look into the changed runtime PM scheme in Exynos tree.
>>>>
>>> KyongHo,
>>>
>>> Do you want to upstream this series with your previous sysmmu (clea=
nup and
>>> moving) patches?
>>>
>>
>> Yes I hope so.
>> Marek's patch corrects run-time power management in Exynos4 with Sys=
tem MMU.
>
> Hi,
>
> Next time, if you give Acked-By or Reviewed_by, then it's more helpfu=
l
> to determine to merge or not.
>

I did not Ack it since he did not CC me.
But, as you mentioned, I need to add my Reviewed-by after reviewing it.

Thank you.

KyongHo.
