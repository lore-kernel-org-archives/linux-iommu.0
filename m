From: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Mon, 16 Apr 2012 19:01:32 +0900
Message-ID: <CAH9JG2VuBTp30KQGeKUsdQZKuPeAMj8XvGHdH-8r=XA5F2a5qg@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
	<CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
	<4F899D18.6000700@samsung.com>
	<CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/16/12, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Sun, Apr 15, 2012 at 12:51 AM, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> On 04/12/12 01:19, KyongHo Cho wrote:
>>>
>>> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
>>> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>  wrote:
>>>>
>>>> Hi!
>>>>
>>>> These two patches fixes operation of the SYSMMU driver (v12 version [1])
>>>> with the new power domain driver based on generic power domains and
>>>> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>>>>
>>> Thanks, Marek.
>>>
>>> Your way of power gating is right
>>> and I will look into the changed runtime PM scheme in Exynos tree.
>>>
>> KyongHo,
>>
>> Do you want to upstream this series with your previous sysmmu (cleanup and
>> moving) patches?
>>
>
> Yes I hope so.
> Marek's patch corrects run-time power management in Exynos4 with System MMU.

Hi,

Next time, if you give Acked-By or Reviewed_by, then it's more helpful
to determine to merge or not.

Thank you,
Kyungmin Park
>
> Thank you.
>
> KyongHo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
