From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 15/19] iommu/arm-smmu: Convert to iommu_fwspec
Date: Thu, 1 Sep 2016 19:53:45 +0100
Message-ID: <20160901185344.GW6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<221f668d606abdfb4d6ee6da2c5f568c57ceccdd.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <221f668d606abdfb4d6ee6da2c5f568c57ceccdd.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Aug 23, 2016 at 08:05:26PM +0100, Robin Murphy wrote:
> In the final step of preparation for full generic configuration support,
> swap our fixed-size master_cfg for the generic iommu_fwspec. For the
> legacy DT bindings, the driver simply gets to act as its own 'firmware'.
> Farewell, arbitrary MAX_MASTER_STREAMIDS!
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 139 ++++++++++++++++++++++++++---------------------
>  1 file changed, 77 insertions(+), 62 deletions(-)

[...]

>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec(dev);
> +	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -	struct arm_smmu_master_cfg *cfg = dev->archdata.iommu;
>  
> -	if (!cfg) {
> +	if (!fwspec || fwspec->iommu_ops != &arm_smmu_ops) {

As mentioned off-list, you have already dereferenced fwspec before this
NULL check.

Will
