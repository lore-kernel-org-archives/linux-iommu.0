From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 3/7] iommu: add new iommu_ops callback for adding
	an OF device
Date: Wed, 10 Sep 2014 12:22:13 +0100
Message-ID: <20140910112213.GH28488@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-4-git-send-email-will.deacon@arm.com>
	<541032F6.1090809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <541032F6.1090809-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 10, 2014 at 12:16:06PM +0100, Marek Szyprowski wrote:
> On 2014-09-02 19:56, Will Deacon wrote:
> > This patch adds a new function to the iommu_ops structure to allow an
> > OF device to be added to a specific IOMMU instance using the recently
> > merged generic devicetree binding for IOMMUs. The callback (of_xlate)
> > takes a struct device representing the master and an of_phandle_args
> > representing the IOMMU and the correspondong IDs for the new master.
> >
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > ---
> >   include/linux/iommu.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index fdddb14cd8f5..3e766b85daa3 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -21,6 +21,7 @@
> >   
> >   #include <linux/errno.h>
> >   #include <linux/err.h>
> > +#include <linux/of.h>
> >   #include <linux/types.h>
> >   #include <trace/events/iommu.h>
> >   
> > @@ -136,6 +137,10 @@ struct iommu_ops {
> >   	/* Get the numer of window per domain */
> >   	u32 (*domain_get_windows)(struct iommu_domain *domain);
> >   
> > +#ifdef CONFIG_OF_IOMMU
> > +	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> 
> If I understand correctly how it is designed to work, then it should be:
> 
> struct iommu_data *(*of_xlate)(struct device *dev, struct 
> of_phandle_args *args);

Yeah, that might be cleaner than the of_iommu_get_data call in
of_dma_configure. I'm currently cooking a v3, so I'll include this change.

Will
