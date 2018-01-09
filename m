From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: Check the result of iommu_group_get() for NULL
Date: Tue, 9 Jan 2018 17:15:01 +0000
Message-ID: <98dd6b2f-5d54-4ebe-fc53-92a7e3e6f899@arm.com>
References: <1512408130-24833-1-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1512408130-24833-1-git-send-email-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jordan,

On 04/12/17 17:22, Jordan Crouse wrote:
> The result of iommu_group_get() was being blindly used in both
> attach and detach which results in a dereference when trying
> to work with an unknown device.

I missed this one before it got applied, but FWIW that behaviour was 
actually somewhat intentional (see 05f80300dc8b). Callers really 
shouldn't be trying to attach random unknown devices to IOMMU domains 
anyway, but more crucially, now that iommu_{attach,detach}_group() work 
everywhere I think the long-term plan is still to remove 
iommu_{attach,detach}_device() completely.

I have no great objection to this patch myself, but do consider it a 
heads-up that any callers it fixes are liable to be ridden roughshod 
over by further API changes in future.

Robin.

> Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>   drivers/iommu/iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3de5c0b..69fef99 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1303,6 +1303,9 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   	int ret;
>   
>   	group = iommu_group_get(dev);
> +	if (!group)
> +		return -ENODEV;
> +
>   	/*
>   	 * Lock the group to make sure the device-count doesn't
>   	 * change while we are attaching
> @@ -1341,6 +1344,8 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>   	struct iommu_group *group;
>   
>   	group = iommu_group_get(dev);
> +	if (!group)
> +		return;
>   
>   	mutex_lock(&group->mutex);
>   	if (iommu_group_device_count(group) != 1) {
> 
