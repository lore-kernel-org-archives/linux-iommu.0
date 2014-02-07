From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu/exynos: Remove driver
Date: Fri, 07 Feb 2014 14:49:53 +0100
Message-ID: <52F4E481.3050902@samsung.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
 <CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
 <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>
Cc: Olof Johansson <olof@lixom.net>, Kukjin Kim <kgene.kim@samsung.com>, Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sean Paul <seanpaul@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-02-07 13:44, Kyungmin Park wrote:
>
> On Friday, February 7, 2014, Inki Dae <inki.dae@samsung.com 
> <mailto:inki.dae@samsung.com>> wrote:
>
>     2014-02-07 Olof Johansson <olof@lixom.net <javascript:;>>:
>     > The driver has been unbuildable due to unfulfilled dependencies
>     since
>     > 3.11, and even if enabled it won't build due to build breakage.
>     Emails
>     > about status on this have gone unanswered, and fixes seem to
>     have been
>     > abandoned.
>     >
>     > It's obvious that nobody cares about it, so let's remove it.
>
>     Wait, we are going to fix up this module. It seems that KyoungHo,
>     original author, is busy with some works related to product.
>
>     we can care about it if KyoungHo cannot afford to care for the
>     time being.
>
> Any volunteers?
> Marek or Bartek, how do you think?
>
> Before that it makes orphan or unsupported at maintainer file first and
> change it to new volunteers.

I think that it might be easier to remove the existing non-functional driver
now and add it again once the driver is ready. I have it on my TODO 
list, but
doubt I will manage to finish it for v3.15.

Discussing the DT bindings might take some time.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
