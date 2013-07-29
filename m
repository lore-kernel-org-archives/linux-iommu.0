From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 03/12] iommu/exynos: fix page table maintenance
Date: Mon, 29 Jul 2013 09:22:01 -0700
Message-ID: <CANEJEGs-fMeK2yzwyx-jr6iCnNbaG0owC12-i3c8hqjUkpQbPA@mail.gmail.com>
References: <003901ce89f3$126c0390$37440ab0$@samsung.com>
	<CANEJEGvp1msjkMLN-8TfykYXmrT+sq8dMkNsVEoh9i2vDoh=tg@mail.gmail.com>
	<004e01ce8c3c$9480f9d0$bd82ed70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <004e01ce8c3c$9480f9d0$bd82ed70$@samsung.com>
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
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 29, 2013 at 2:18 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
...
>> > @@ -908,7 +916,7 @@ static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
>> >                 int i;
>> >                 for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
>> >                         if (!lv2ent_fault(pent)) {
>> > -                               memset(pent, 0, sizeof(*pent) * i);
>> > +                               clear_page_table(pent - i, i);
>> >                                 return -EADDRINUSE;
>>
>> I am wondering about two issues with this error handling:
>> 1) we don't call pgtable_flush() in this case - I think just for
>> consistency we should - don't rush to add since my next comment is to
>> change this error handling completely.
>>
> clear_page_table() is called for the page table entries that are already
> fault pages. That is why it does not contain cache flush.
>
>> 2) If  -EADDRINUSE is correct, why does the code clear the IO Page
>> table entries?
>>
>>    I think this error path should either
>>    (a) BUG_ON (ie panic) since this is an inconsistency between
>> generic IOMMU page allocation and chip specific IOMMU mapping code OR
>>    (b) WARN_ON, not clear the entries, and hope whoever was using it
>> can finish using the system before crashing or gracefully shutting
>> down.
>>
>> In any case, I'm pretty sure this code needs to change and it should
>> be in a follow up to this series.
>
> Yes, you're right. But I worried the case that a kernel module calls IOMMU API
> functions directly and does not want to make kernel panic when it tries to map
> a region that is already in use.

Using a DMA address for a different physical page while the current
mapping is still active can only be a bug. I can confidently say there
is no way to map the same DMA address twice (at least not for a single
page table.)  We can try to fail the mapping somehow and WARN_ON to
indicate we had a "Re-Use before free" type bug.

> I also wonder if the such kernel module exists.

I believe the kernel will never do this.

> WARN_ON is also a good idea.

After this series goes in, post another patch and I'd be happy to
review that as well.

After thinking about it more, I'm also ok with removing this code.
It's a very "defensive" code to catch errors in the generic IOMMU code
that probably no longer exist. Or maybe just make it
"CONFIG_DEBUG_IOMMU_ALLOC" or something like that.

cheers,
grant
