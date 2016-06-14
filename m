From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 6/7] iommu/arm-smmu: Finish off SMMUv3 default domain
 support
Date: Tue, 14 Jun 2016 16:59:48 +0100
Message-ID: <20160614155948.GD16531@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <aabcdd814b93b2b6a902b189f6911f929a29b64f.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aabcdd814b93b2b6a902b189f6911f929a29b64f.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 06:15:41PM +0100, Robin Murphy wrote:
> The driver's current reliance on attaching/detaching an entire group
> for the first device it sees is at odds with the IOMMU core's initial
> construction of a group by adding each device and attaching it to the
> default domain in turn. As it turns out, we can happily do away with the
> whole palaver by simply letting each device be in charge of its own
> stream ID/stream table entry, and reducing the problem of tracking
> duplicate IDs and domains down to "Is the STE already associated with
> the appropriate context?", which is easily done by just looking at the
> stream table itself.

Hmm, it would be nice if Joerg could confirm this before we remove the
driver code.

Joerg: can an IOMMU driver rely on not receiving contradictory ->attach
callbacks for devices in the same group? Robin is proposing that we
remove the group tracking code from the ARM SMMU driver which is a nice
cleanup but leaves us open to silent misconfiguration if we are asked to
violate the group constraints.

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 7631639cc209..28dcc5ca237e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -607,15 +607,6 @@ struct arm_smmu_device {
>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>  };
>  
> -/* SMMU private data for an IOMMU group */
> -struct arm_smmu_group {
> -	struct arm_smmu_device		*smmu;
> -	struct arm_smmu_domain		*domain;
> -	int				num_sids;
> -	u32				*sids;
> -	struct arm_smmu_strtab_ent	ste;
> -};

I'm not keen on losing this structure. How about we instead change the
sids array to be a linked list of {struct device, sid[]} and then change
arm_smmu_install_ste_for_group to take a device pointer as well?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
