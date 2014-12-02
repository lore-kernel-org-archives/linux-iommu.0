From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Tue, 2 Dec 2014 09:43:20 +0000
Message-ID: <20141202094320.GC9917@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<547D84F4.8030204@samsung.com> <2039644.fesfKXTybP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2039644.fesfKXTybP@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 02, 2014 at 09:36:59AM +0000, Arnd Bergmann wrote:
> On Tuesday 02 December 2014 10:23:00 Marek Szyprowski wrote:
> > >> +static inline void of_iommu_set_ops(struct device_node *np,
> > >> +                                   const struct iommu_ops *ops)
> > >> +{
> > >> +       np->data = (struct iommu_ops *)ops;
> > >> +}
> > >> +
> > >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > >> +{
> > >> +       return np->data;
> > >> +}
> > > This may collide with other users. While use of it is rare, PPC uses
> > > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > > sets it. There may be some coming usage with the DT overlay code or
> > > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > > really should try to get rid of this pointer rather than expand it's
> > > usage.
> > 
> > I think that for the initial version it is ok to use np->data. When 
> > per-iommu
> > controller structure is introduced later, it can be reused also for 
> > performing
> > of_node to iommu_ops lookup, because IOMMU framework will need to keep track
> > on all such iommu controllers anyway.
> 
> Agreed. I think in the long run, we will have a 'struct iommu' that is
> added into a global linked list and that contains (among other things)
> an iommu_ops pointer and a device_node pointer. The of_iommu_get_ops
> function then walks the list to find the right iommu instance.

Yup, I plan to look at that after Christmas because I need it for the
per-IOMMU instance pgsize_bitmap anyway.

Will
