From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/arm-smmu: add support for multi-master iommu
	groups
Date: Mon, 15 Sep 2014 17:22:57 +0200
Message-ID: <20140915152257.GX28786@8bytes.org>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
	<1409849405-17347-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409849405-17347-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 04, 2014 at 05:50:00PM +0100, Will Deacon wrote:
>  static struct arm_smmu_master_cfg *
> -find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
> +find_smmu_master_cfg(struct device *dev)
>  {
> -	struct arm_smmu_master *master;
> -
> -	if (dev_is_pci(dev))
> -		return dev->archdata.iommu;
> -
> -	master = find_smmu_master(smmu, dev->of_node);
> -	return master ? &master->cfg : NULL;
> +	struct iommu_group *group = iommu_group_get(dev);
> +	return group ? iommu_group_get_iommudata(group) : NULL;

Using iommu_group_get requires the call-sites to do an iommu_group_put
in the end, but I don't see the call-sites updated.


	Joerg
