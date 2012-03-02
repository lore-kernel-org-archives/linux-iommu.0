From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 0/2] iommu/exynos: Add IOMMU/System MMU driver for
	Samsung Exynos
Date: Fri, 2 Mar 2012 14:45:43 +0900
Message-ID: <CAHQjnONxO32WP40sJz80=rjv3kqxmx55MUvjvhhO_mo3DNH8-A@mail.gmail.com>
References: <001801ccf5e3$69d79860$3d86c920$%cho@samsung.com>
	<CAH9JG2Vg8o_mm0gM042T0-kjMUoAdLzF+DeGErD7R86H0xqXZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH9JG2Vg8o_mm0gM042T0-kjMUoAdLzF+DeGErD7R86H0xqXZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 28, 2012 at 4:01 PM, Kyungmin Park
<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi,
>
> Some comments.
> 1. It's not same patch series. since it has additional feature,
> exynos5 series support which don't covered at previous time.
> 2. It assumes that name conversion is based on exynos5 as default. now
> you use gsc at exynos4 even though there's no gsc block. It should be
> fimc.

Thanks. I agree about the second and applied it in the next patchset.

>
> So I suggest to send exynos4 series patch as before and send
> additional exynos5 patch series next.
>

I will just extract a new patch that removes existing system MMU driver from
the previous 2 patches and the patchset will consist of 3 patches.
