From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 03/16] iommu/exynos: fix page table maintenance
Date: Fri, 16 Aug 2013 20:17:21 +0900
Message-ID: <20130816201721.b93a6e3db960e38b29ca7b1a@samsung.com>
References: <002701ce941a$eecebdb0$cc6c3910$@samsung.com>
	<1516548.d7oQuzQS7g@amdc1227>
	<CANEJEGu1ponghpfvyUsQX16+TZWUV+0KXJ7AehjXpju2N_H+Ew@mail.gmail.com>
	<20130814104938.GF4491@8bytes.org>
	<CANEJEGveOtGs8XEYFnnXoZ575bqKRkc3AMikr_1x02cNikwTng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CANEJEGveOtGs8XEYFnnXoZ575bqKRkc3AMikr_1x02cNikwTng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Aug 2013 13:54:53 -0700, Grant Grundler wrote:
> On Wed, Aug 14, 2013 at 3:49 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, Aug 08, 2013 at 11:28:44AM -0700, Grant Grundler wrote:
> >> I can't speak to the previous BUG_ON(). I believe the EADDRESSINUSE
> >> failures could be either WARN_ON or BUG_ON.   This condition is
> >> clearly a bug in the generic IOMMU allocator and I think that's why
> >> KyongHo Cho used BUG_ON.
> >>
> >> Handing out duplicate addresses will generally lead to some sort of
> >> data corruption or other fault depending on how robust the underlying
> >> device drivers are written.  So my preference is a BUG_ON to
> >> immediately flag this condition instead of hoping a device driver will
> >> correctly handling the dma mapping failure (Some do, most currently
> >> don't).
> >>
> >> WARN_ON() + return -EADDRESSINUSE would be a good alternative.
> >
> > Even if it is a real BUG condition, I don't think it is worth to stop
> > execution at this point. It makes debugging harder and the system less
> > reliable. I prefer to go with the WARN_ON and an error return value.
> 
> I'm ok with WARN_ON and an error return value. This is "valid"
> behavior.  I expect this bug to never happen but if and when it does,
> I want a clear symptom (e.g. WARN_ON) that it happened.
> 

Ok.
Finally, everyone thinks that WARN_ON() is OK.
It will be helpful for the kernel code that uses iommu api.

> My concern is that historically, drivers did not get an error return
> value on failure:
>     ftp://193.166.3.4/pub/linux/kernel/v2.3/patch-html/patch-2.3.47/linux_Documentation_DMA-mapping.txt.html
> 
> or later:
>     https://www.kernel.org/pub/linux/kernel/people/marcelo/linux-2.4/Documentation/DMA-mapping.txt
> 
> And thus, some drivers don't check or attempt to handle mapping
> failures based on this existing code. Here is a recent example:
>      http://comments.gmane.org/gmane.linux.network/272969
> 
> I hope very few or none of those exist since Neil Horman demonstrated
> "dma debugging" can flag this behavior.
> 
> Just for fun, I'll include this link : (apperently 2003 was a good
> year for DMA talks :)
>      http://ols.fedoraproject.org/OLS/Reprints-2003/LinuxSymposium2003-2side.pdf
>      (three talks on DMA issues)
> 

Thank you for the resources :)
Those will be helpful for the guys with me.

> thanks
> grant
