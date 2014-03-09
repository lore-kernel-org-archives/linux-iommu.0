From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH] iommu/exynos: Remove driver
Date: Sun, 9 Mar 2014 22:54:09 +0900
Message-ID: <CAHQjnOP=cq4+wxjuOzKKHmp2vC1DUTwogiQkL=8NtNWZiBJ4jg@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
	<CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
	<CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
	<52F4E481.3050902@samsung.com>
	<CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
	<CAOesGMhH2WHvkaobewdnPeiThrWTfw0m4WWAZW98-iS2xdr+ow@mail.gmail.com>
	<001301cf291a$233fdc70$69bf9550$@samsung.com>
	<CAH9JG2WtV7HeJmjGDaNfHVbZiKG5aDznqxK+AYaTzK_bCud-TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAH9JG2WtV7HeJmjGDaNfHVbZiKG5aDznqxK+AYaTzK_bCud-TQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@gmail.com>, Sean Paul <seanpaul@chromium.org>, Olof Johansson <olof@lixom.net>, Tomasz Figa <t.figa@samsung.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 6, 2014 at 8:48 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Fri, Feb 14, 2014 at 9:17 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
>>> -----Original Message-----
>>> From: Olof Johansson [mailto:olof@lixom.net]
>>> Sent: Friday, February 14, 2014 4:34 AM
>>>
>>> On Mon, Feb 10, 2014 at 10:21 PM, Kukjin Kim <kgene.kim@gmail.com> wrote:
>>>
>>> > Just adding KyongHo Cho.
>>> >
>>> > If he can fixup for this time, it would be best solution because he knows
>>> > well than others, I think.
>>>
>>> It's not so much a matter of "fixup for this time", it's a about
>>> having ownership of the driver, making sure it works (and keeps
>>> working if there is related development). The posted patches have not
>>> been followed through on and the result is a broken driver. :(
>>>
>>> I definitely appreciate his expertise, and we should make sure that he
>>> gets to review the code, but if someone else is able to spend time on
>>> reworking the driver (or rewriting a newer one) and maintaining it
>>> longer-term, then we should not stop them from doing so. And there is
>>> no reason to keep broken stale code in the kernel meanwhile.
>>>
>>
>> Thank you for your concerning.
>> I also definitely agree with you that the driver must work.
>> I am always concerning about it but it was not easy to make some time
>> for the patches.
>>
>> I will continue to post the next version of patches, of course.
>> I think it is not far from now to show it.
>
> Lots of time is going from last reply. there are two options.
> 1. just waiting more
> 2. remove it as patch and start it again by someone.
>
> what's the opinions?
>

Please be patient until the patches are OK enough to post.

The patches have lots of improvements and workarounds.

Sorry for delaying the patches.

One thing is certain, starting from scratch is not a good idea.
Why not discuss with me to make exynos-iommu driver better?

Thank you.

KyongHo
