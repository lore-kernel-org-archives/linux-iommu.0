From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Thu, 12 Apr 2012 17:19:05 +0900
Message-ID: <CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi!
>
> These two patches fixes operation of the SYSMMU driver (v12 version [1])
> with the new power domain driver based on generic power domains and
> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>
Thanks, Marek.

Your way of power gating is right
and I will look into the changed runtime PM scheme in Exynos tree.

> [1] https://lkml.org/lkml/2012/3/15/51

Regards,

KyongHo
