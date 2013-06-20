From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 3/3] iommu/tegra: smmu: Support read-only
 mapping
Date: Thu, 20 Jun 2013 09:27:17 +0200
Message-ID: <20130620.102717.424970523102380476.hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com><1371707384-30037-4-git-send-email-hdoyu@nvidia.com><CAH9JG2VUCJErBNwT0_u_9niaSWUza5gJ-+q8OOJhrrdw5D-hUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH9JG2VUCJErBNwT0_u_9niaSWUza5gJ-+q8OOJhrrdw5D-hUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Kyungmin,

Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote @ Thu, 20 Jun 2013 08:50:14 +0200:

> On Thu, Jun 20, 2013 at 2:49 PM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Support read-only mapping via struct dma_attrs.
> >
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++++++++------------
> >  1 file changed, 29 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index fab1f19..3aff4cd 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -862,12 +862,13 @@ static size_t __smmu_iommu_unmap_largepage(struct smmu_as *as, dma_addr_t iova)
> >  }
> >
> >  static int __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
> > -                                unsigned long pfn)
> > +                               unsigned long pfn, int prot)
> Can you find 'prot' is used at other arch? In previous patch, you cast

{amd,intel}_iommu_map() take the IOMMU standard flags below and
translate it into each H/W dependent bits.

#define IOMMU_READ	(1)
#define IOMMU_WRITE	(2)
#define IOMMU_CACHE	(4) /* DMA cache coherency */

The others like OMAP/MSM pass their H/W dependent bits all the way. I
think that they don't use IOMMU via DMA mapping API.

> it as 'int' but below code cast it as 'struct dma_attr' again.
> doesn't it better to use 'struct dma_attr' as parameter to avoid
> double cast? Of course you have to modify existing APIs to use 'struct
> dma_attr'.

If DMA mapping API is considered as the standard frontend of
IOMMU(API), that may be an option.
