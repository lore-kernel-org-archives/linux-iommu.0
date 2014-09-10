From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 4/7] iommu: provide helper function to configure
	an IOMMU for an of master
Date: Wed, 10 Sep 2014 14:06:07 +0100
Message-ID: <20140910130607.GK28488@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-5-git-send-email-will.deacon@arm.com>
	<1486715.2XVviDPC9Z@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486715.2XVviDPC9Z@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

Cheers for the review.

On Wed, Sep 10, 2014 at 02:01:34PM +0100, Laurent Pinchart wrote:
> On Tuesday 02 September 2014 18:56:24 Will Deacon wrote:
> > +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> > +{
> > +	struct of_phandle_args iommu_spec;
> > +	struct iommu_dma_mapping *mapping;
> > +	struct bus_type *bus = dev->bus;
> > +	const struct iommu_ops *ops = bus->iommu_ops;
> > +	struct iommu_data *iommu = NULL;
> > +	int idx = 0;
> > +
> > +	if (!iommu_present(bus) || !ops->of_xlate)
> > +		return NULL;
> > +
> > +	/*
> > +	 * We don't currently walk up the tree looking for a parent IOMMU.
> > +	 * See the `Notes:' section of
> > +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> > +	 */
> > +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +					   "#iommu-cells", idx,
> > +					   &iommu_spec)) {
> > +		struct device_node *np = iommu_spec.np;
> > +		struct iommu_data *data = of_iommu_get_data(np);
> > +
> > +		if (!iommu) {
> > +			if (!ops->of_xlate(dev, &iommu_spec))
> > +				iommu = data;
> 
> If I understand the code correctly, this will call of_xlate for the first 
> IOMMU reference only and silently ignore all subsequent references if they 
> point to the same IOMMU device but with different stream/requester IDs. Is 
> that the desired behaviour ?

No; I just fixed that actually. I'll send a v3 soon which has a bunch of
fixes like this.

Will
