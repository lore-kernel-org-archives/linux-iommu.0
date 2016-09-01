From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 04/19] iommu/of: Introduce iommu_fwspec
Date: Thu, 1 Sep 2016 13:31:58 +0100
Message-ID: <20160901123158.GE6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<3e8eaf4fd65833fecc62828214aee81f6ca6c190.1471975357.git.robin.murphy@arm.com>
	<20160831172856.GI29505@arm.com>
	<900f3dcb-217c-4fb3-2f7d-15572f31a0c0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <900f3dcb-217c-4fb3-2f7d-15572f31a0c0-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 01, 2016 at 01:07:19PM +0100, Robin Murphy wrote:
> On 31/08/16 18:28, Will Deacon wrote:
> > On Tue, Aug 23, 2016 at 08:05:15PM +0100, Robin Murphy wrote:
> >> +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
> >> +{
> >> +	struct iommu_fwspec *fwspec = dev->archdata.iommu;
> >> +	size_t size;
> >> +
> >> +	if (!fwspec)
> >> +		return -EINVAL;
> >> +
> >> +	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
> >> +	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
> >> +	if (!fwspec)
> >> +		return -ENOMEM;
> >> +
> >> +	while (num_ids--)
> >> +		fwspec->ids[fwspec->num_ids++] = *ids++;
> >> +
> >> +	dev->archdata.iommu = fwspec;
> > 
> > It might just be me, but I find this really fiddly to read. The fact
> > that you realloc the whole fwspec, rather than just the array isn't
> > helping, but I also think that while loop would be much better off as
> > a for loop, using the index as, well, an index into the ids array and
> > fwspec->ids array.
> 
> Sure - copying one array into the tail end of another is always going to
> be boring, ugly code, which I feel compelled to make as compact as
> possible so as not to distract from the more interesting code, but I
> guess that's self-defeating if it then no longer looks like something
> simple and boring to skip over. I'll expend a few more precious lines on
> turning it back into something staid and sensible ;)

Why do you need to make the copy explicit? If you ensure that the array
is NULL in a freshly initialised fwspec, then you can either kmalloc
it when adding the IDs, or krealloc it if you need to append to an
array that's already been initialised. It's pretty much the same as you
have already, just operating on the array as opposed to the containing
structure.

Will
