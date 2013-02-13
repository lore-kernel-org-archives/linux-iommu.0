From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 05/12] iommu/exynos: support for device tree
Date: Tue, 12 Feb 2013 21:33:01 -0800
Message-ID: <1e0d01ce09ab$98eed690$cacc83b0$@samsung.com>
References: <003801cde30b$d9667b90$8c3372b0$%cho@samsung.com>
	<50E1E62B.3090501@gmail.com>
	<CAHQjnOMav9A43m4=7=N9kzEHTHE_q_ygu8x6mzY6Cus=q0c06A@mail.gmail.com>
	<20130201135114.GF25591@8bytes.org>
	<CAHQjnOP1U=LRU-fe-HuWzp=17s=KG8zPvSO3_zeVrrviEkmyHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAHQjnOP1U=LRU-fe-HuWzp=17s=KG8zPvSO3_zeVrrviEkmyHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'devicetree-discuss' <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Thomas Abraham' <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sylwester Nawrocki' <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Tomasz Figa' <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

KyongHo Cho wrote:
> 
> On Fri, Feb 1, 2013 at 10:51 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > Cho,
> >
> > On Wed, Jan 02, 2013 at 02:53:49PM +0900, KyongHo Cho wrote:
> >> On Tuesday, January 1, 2013, Sylwester Nawrocki
> <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> >> > Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> >
> > Since patch 7 of this set is already merged, do you mind to re-post the
> > rest of this patch-set with the latest comments addressed? I can have a
> > look at it again then and consider it for 3.9.
> >
> Thank you for your considerations.
> 
> I also think that I need to post the patch set again with some fixes that
are
> addressed in the comments.
> 
> Due to the heavy workload in my business I have hardly had a chance to
> handle this patch-set.
> As soon as the business lets me handle other pending issues, I will
> work on this patchset.
> I think I can start to it in the next 2 weeks.
> 
OK, I see.

Joerg, please hold this on until KyongHo's re-work, probably 3.10?

Thanks.

- Kukjin
