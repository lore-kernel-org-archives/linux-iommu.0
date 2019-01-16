From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: Check for iommu_ops == NULL in iommu_probe_device()
Date: Wed, 16 Jan 2019 16:27:58 +0100
Message-ID: <e1a87036-d2df-c59b-a23d-9093ba02bacd@redhat.com>
References: <20181220090833.6643-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181220090833.6643-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12/20/18 10:08 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> This check needs to be there and got lost at some point
> during development. Add it again.
> 
> Fixes: 641fb0efbff0 ('iommu/of: Don't call iommu_ops->add_device directly')
I experience a regression with those 2 patches. I have virtio-pci device
protected by virtual smmuv3 and in that case I get err = -EPROBE_DEFER
after pci_for_each_dma_alias() in of_iommu_configure(). When
iommu_probe_device is called, ops = NULL so it returns -EINVAL and err
is overwritten. So there is no deferred probing while it happened before.

Thanks

Eric
> Reported-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reported-by: kernelci.org bot <bot-ssFOTAMYnuFg9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a2131751dcff..3ed4db334341 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -114,10 +114,14 @@ void iommu_device_unregister(struct iommu_device *iommu)
>  int iommu_probe_device(struct device *dev)
>  {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	int ret = -EINVAL;
>  
>  	WARN_ON(dev->iommu_group);
>  
> -	return ops->add_device(dev);
> +	if (ops)
> +		ret = ops->add_device(dev);
> +
> +	return ret;
>  }
>  
>  void iommu_release_device(struct device *dev)
> 
