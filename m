From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 07/12] ARM: EXYNOS: remove system mmu initialization
	from exynos tree
Date: Mon, 30 Sep 2013 11:34:34 +0900
Message-ID: <20130930113434.4890db899def8d5797567aa4@samsung.com>
References: <003a01cde30b$e13c1910$a3b44b30$%cho@samsung.com>
	<CAOw6vbJfi7UhwxgFKmMzO91fnywWZNTRVDLLSWQOkbbU=C5ndA@mail.gmail.com>
	<20130930093500.ffa527f8f5f004e02a9cb187@samsung.com>
	<CAOw6vbKSQ2xTj7__D5F40vRLxU5Yt1NH4zEp4WcRtB1rVK5gQQ@mail.gmail.com>
	<20130930105234.73b5380ec08bf4cc6b2c9677@samsung.com>
	<CALiw-2HwQvpHCoJw0JyGn87ZV1vuvqMtPv8i+AcVGQHnAKtEJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CALiw-2HwQvpHCoJw0JyGn87ZV1vuvqMtPv8i+AcVGQHnAKtEJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 29 Sep 2013 19:03:06 -0700, Olof Johansson wrote:
> Hi,
> 
> 2013/9/29 Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> 
> > Ah, I remember that this is merged.
> > I agreed to merge this patch because iommu driver need to be completely changed.
> > Whenever I change exynos-iommu driver, synchronizing samsung-next and iommu-next
> > branches is a big challenge.
> > Thus I decided to remove dependencies to samsung-next branch.
> > But I didn't know that the rest of the new driver is not merged soon. :(
> > I am sorry about that.
> >
> > new patch (v10) will be posted soon.
> 
> Will the v10 patch set be incremental based on v6?
> 
The single patch 07/12 is merged to mainline from v6 patches.
v10 patch is more advanced than v6.
Of course, much more is changed.
You can refer the v9 patch what is changed since v6.

> How have you tested v10 on mainline?
> 

I just test if the System MMU is correctly enabled and disabled,
if page table is correctly maintained.
It is done with IOMMU API call from custom driver/device and applications.

The test does not involve working with master IPs such as MFC, FIMC and so on.

> Thanks,
> 
> -Olof
