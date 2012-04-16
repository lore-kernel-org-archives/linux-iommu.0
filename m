From: Subash Patel <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Mon, 16 Apr 2012 19:05:57 +0530
Message-ID: <4F8C203D.3000407@gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1334154871-4756-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

I have tested these patches on origen 3.4-rc2 with sysmmu_v12, and they 
work great ! Thank you for sharing them.

Regards,
Subash

On 04/11/2012 08:04 PM, Marek Szyprowski wrote:
> Hi!
>
> These two patches fixes operation of the SYSMMU driver (v12 version [1])
> with the new power domain driver based on generic power domains and
> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>
> [1] https://lkml.org/lkml/2012/3/15/51
>
> Best regards
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Patch summary:
>
> Marek Szyprowski (2):
>    iommu/exynos: fix runtime pm support
>    ARM: Exynos4: update SYSMMU setup code for gen_pd power domain driver
>
>   arch/arm/mach-exynos/dev-sysmmu.c |    6 +++++-
>   arch/arm/mach-exynos/pm_domains.c |   13 +++++++++++++
>   drivers/iommu/exynos-iommu.c      |   20 ++++++++++++++++++--
>   3 files changed, 36 insertions(+), 3 deletions(-)
>
