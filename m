From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
Date: Wed, 9 Nov 2016 16:59:49 +0000
Message-ID: <20161109165949.GF17771@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
	<003a01d22f97$82534c70$86f9e550$@codeaurora.org>
	<421e2b14-0231-d376-02a0-097423120b3d@arm.com>
	<006f01d236ae$61751c40$245f54c0$@codeaurora.org>
	<9f36244f-62d4-08e3-d64a-2b04ad4dc2e0@arm.com>
	<002001d23a51$ecb01390$c6103ab0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002001d23a51$ecb01390$c6103ab0$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 09, 2016 at 11:54:20AM +0530, Sricharan wrote:
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 71ce4b6..a1d0b3c 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -1516,8 +1516,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
> >>  		group = smmu->s2crs[idx].group;
> >>  	}
> >>
> >> -	if (group)
> >> +	if (group) {
> >> +		iommu_group_get_by_id(iommu_group_id(group));
> >>  		return group;
> >
> >This might as well just be inline, i.e.:
> >
> >		return iommu_group_get_by_id(iommu_group_id(group));
> >
> >It's a shame we have to go all round the houses when we have the group
> >right there, but this is probably the most expedient fix. I guess we can
> >extend the API with some sort of iommu_group_get(group) overload in
> >future if we really want to.
> >
> 
> ok, i can send this fix separately then. Otherwise, Will was suggesting on the
> other thread that there should probably be a separate API to increment
> the group refcount or get the group from the existing aliasing device.
> As per me adding the api, looks like another option or post the above ?

I think adding a new function to the API is the way to go -- having code
like what you propose above littered around the drivers is hard to read and
pretty error-prone, since it looks like a NOP to people who aren't already
thinking about ref counts.

Will
