From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/8] iommu: Move default domain allocation to
	iommu_group_get_for_dev()
Date: Fri, 30 Oct 2015 15:13:47 +0100
Message-ID: <20151030141347.GK27420@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
	<1445464303-18206-9-git-send-email-joro@8bytes.org>
	<20151029182248.GI3440@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151029182248.GI3440-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thu, Oct 29, 2015 at 06:22:49PM +0000, Will Deacon wrote:
> The call to iommu_group_get_for_dev in arm_smmu_add_device will end up
> calling __iommu_attach_device, since group->domain will now be initialised
> by the code above. This means the SMMU driver will see an ->attach_dev
> call for a device that is part-way through an ->add_device callback and
> will be missing the initialisation necessary for us to idenfity the SMMU
> instance to which is corresponds. In fact, the iommudata for the group
> won't be initialised at all, so the whole thing will fail afaict.
> 
> Note that I haven't actually taken this for a spin, so I could be missing
> something.

Yeah, I havn't looked at how to convert the ARM-SMMU drivers to default
domains yet, so the issue you describe above is totally possible.

But there is no way to trigger it yet, because your domain_alloc
function can not yet allocate IOMMU_DOMAIN_DMA domains. While converting
the issue must be fixed, of course.

I tested this patch-set on an AMD Seattle system and it worked fine
there.


	Joerg
