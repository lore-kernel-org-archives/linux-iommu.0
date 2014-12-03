From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Wed, 03 Dec 2014 20:57:50 +0100
Message-ID: <2579924.PPXuLn3o19@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 December 2014 14:16:57 Grant Likely wrote:
> On Mon, Dec 1, 2014 at 11:54 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Dec 1, 2014 at 10:57 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >>
> >> +static inline void of_iommu_set_ops(struct device_node *np,
> >> +                                   const struct iommu_ops *ops)
> >> +{
> >> +       np->data = (struct iommu_ops *)ops;
> >> +}
> >> +
> >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> >> +{
> >> +       return np->data;
> >> +}
> >
> > This may collide with other users. While use of it is rare, PPC uses
> > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > sets it. There may be some coming usage with the DT overlay code or
> > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > really should try to get rid of this pointer rather than expand it's
> > usage.
> >
> > I didn't see a user of this. I'm guessing that is coming in a SMMU patch?
> 
> Good catch. This is not good. The data pointer should be avoided since
> there are no controls over its use. Until a better solution can be
> implemented, probably the safest thing to do is add a struct iommu_ops
> pointer to struct device_node. However, assuming that only a small
> portion of nodes will actually have iommu_ops set, I'd rather see a
> separate registry that matches device_nodes to iommu_ops.

Fair enough. Will, can you take a copy of drivers/dma/of-dma.c and
adapt it as needed? It should be exactly what we need to start
out and can be extended and generalized later.

	ARnd
