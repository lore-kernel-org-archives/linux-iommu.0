From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 18/31] iommu/exynos: allow having multiple System MMUs
	for a master H/W
Date: Fri, 09 May 2014 19:54:40 +0900
Message-ID: <20140509195440.ae989be464cde24ade92eec2@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
	<5369245A.1060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <5369245A.1060001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 06 May 2014 20:05:14 +0200, Tomasz Figa wrote:
> On 27.04.2014 09:37, Shaik Ameer Basha wrote:
> > From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >
> > Some master device descriptor like fimc-is which is an abstraction
> > of very complex H/W may have multiple System MMUs. For those devices,
> > the design of the link between System MMU and its master H/W is needed
> > to be reconsidered.
> >
> > A link structure, sysmmu_list_data is introduced that provides a link
> > to master H/W and that has a pointer to the device descriptor of a
> > System MMU. Given a device descriptor of a master H/W, it is possible
> > to traverse all System MMUs that must be controlled along with the
> > master H/W.
> >
> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >   drivers/iommu/exynos-iommu.c |  545 ++++++++++++++++++++++++++----------------
> >   1 file changed, 335 insertions(+), 210 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index fefedec3..c2e6365 100755
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -117,6 +117,10 @@
> >   #define REG_PB1_EADDR		0x058
> >
> >   #define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
> > +#define for_each_sysmmu_list(dev, list_data)				\
> > +	list_for_each_entry(list_data,					\
> > +		&((struct exynos_iommu_owner *)dev->archdata.iommu)->mmu_list, \
> > +		entry)
> 
> Sorry, NAK.
> 
> Please don't add this kind of complexity and business logic to low level 
> code. We want the configuration functions to be simple, easy to read, 
> maintain and extend.
> 
> The proper way to do it is to let the IOMMUs be grouped together on 
> IOMMU subsystem level, so that each IOMMU consumer driver would see just 
> one IOMMU, but then IOMMU driver callbacks would handle just particular 
> instances of the IOMMU IP blocks, without any loops, lists and other 
> crazy code...
> 

It is done in IOMMU driver internally.
IOMMU consumer driver(IOMMU client device driver?) sees IOMMU domain
but IOMMU itself. How to handle IOMMUs of the client device is just
in charge of IOMMU driver according to the hardwired bus topology.

If a master and IOMMU device should be 1:1 relationship as you contend,
the master device driver should be responsible for express the bus
topology in its business logic. I think it is not good as I told earlier.

IOMMU group is different from the grouping System MMUs in Exynos IOMMU driver.
IOMMU group is invented to group several IOMMUs on different bus with different
masters to assign the same IOMMU domain.
It is useful for user level virtualization but for expressing bus topology.
Exynos IOMMU driver just groups System MMUs that have the same master device.
Even though Exynos IOMMU driver implements IOMMU group which is already
implemented by 20/31 patch, such looping is still required.

However, I will consider other elegant way of interation of multiple System MMUs.

Regards,

KyongHo
