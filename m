From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/exynos: Follow kernel coding style for
	__sysmmu_enable return type
Date: Sun, 18 Aug 2013 15:33:07 +0200
Message-ID: <CAG8rG2zf8CUu+1qRURRhvX8RsNx8CLXJU85qnsFjCvm0FYYuRg@mail.gmail.com>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
	<1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
	<003101ce89ed$52317330$f6945990$@samsung.com>
	<20130814131547.GA5889@8bytes.org>
	<20130816202151.b47fae1e9ed249d06baa37d1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130816202151.b47fae1e9ed249d06baa37d1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Yes, of course, I have no objections.

On Fri, Aug 16, 2013 at 1:21 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Wed, 14 Aug 2013 15:15:49 +0200, 'Joerg Roedel' wrote:
>> KyongHo,
>>
>> On Fri, Jul 26, 2013 at 07:46:01PM +0900, Cho KyongHo wrote:
>> > __sysmmu_enable() must return 1 if it is called with the same page table.
>> > I have fixed it exynos_iommu_attach_device() to always return zero on success
>> > in the next patchset which I will post today.
>> >
>> > Thank you.
>>
>> When you are fine with these patches please put them on-top of your
>> patch-set when you re-submit. I will take them from there then.
>>
>
> Ok.
>
> Antonios,
>
> Would you mind
> if I submit your 2 patches on top of my patches with your signed-off?
>
> KyongHo.
>
>>
>>       Joerg
>>
>>
