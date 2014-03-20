From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH v11 24/27] iommu/exynos: use exynos-iommu specific typedef
Date: Thu, 20 Mar 2014 18:55:19 +0900
Message-ID: <20140320185519.0035bf69004da6c570133414@samsung.com>
References: <20140314141302.393cfdf96dd7b82eee3f700e@samsung.com>
 <CANEJEGu=yDfYi-gH7W7h7up2gd7MxBOg9bz4konLoe-UGf4RYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANEJEGu=yDfYi-gH7W7h7up2gd7MxBOg9bz4konLoe-UGf4RYA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 18 Mar 2014 18:33:20 -0700, Grant Grundler wrote:
> On Thu, Mar 13, 2014 at 10:13 PM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > This commit introduces sysmmu_pte_t for page table entries and
> > sysmmu_iova_t vor I/O virtual address that is manipulated by
> > exynos-iommu driver. The purpose of the typedef is to remove
> > dependencies to the driver code from the change of CPU architecture
> > from 32 bit to 64 bit.
> 
> hi Cho,
> I noticed this before but understood this code was only compiled for
> ILP-32 programming model. I'm assuming that is going to change in the
> not-to-distant future. Good. :)
> 

Thanks.

> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  drivers/iommu/exynos-iommu.c |  103 ++++++++++++++++++++++--------------------
> >  1 file changed, 54 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index e375501..6e716cc 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -56,19 +56,19 @@
> >  #define lv2ent_large(pent) ((*(pent) & 3) == 1)
> >
> >  #define section_phys(sent) (*(sent) & SECT_MASK)
> > -#define section_offs(iova) ((iova) & 0xFFFFF)
> > +#define section_offs(iova) ((sysmmu_iova_t)(iova) & 0xFFFFF)
> 
> The cast will mask abuses of iova. Define section_offs as a static
> function and GCC can type check iova parameter to make sure it's a
> sysmmu_iova_t.
> Thoughts?
> 
> I was thinking "((iova) & (sysmmu_iova_t) 0XFFFFF)" might do what you
> want but it doesn't warn on abuse that I tried. I believe GCC knows
> the upper bits are being ignored.

Thank you for advice.

I agree that type checking by compiler will be more helpful
as you mentioned.

Regards,

KyongHo
