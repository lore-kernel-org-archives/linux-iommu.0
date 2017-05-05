From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] iommu: fix device remove
Date: Fri, 5 May 2017 11:24:52 -0700
Message-ID: <20170505182452.GA3575@kroah.com>
References: <20170505180837.11326-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170505180837.11326-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 05, 2017 at 02:08:37PM -0400, Rob Clark wrote:
> It looks like it *used* to make sense to free the device.  But now it is
> embedded in 'struct iommu' (which is allocated or embedded in something
> that the device allocated).
> 
> Spotted when testing qcom_iommu with CONFIG_DEBUG_TEST_DRIVER_REMOVE.
> 
> Fixes: 39ab955 ("iommu: Add sysfs bindings for struct iommu_device")
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/iommu/iommu-sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
> index c58351e..ad19cbb 100644
> --- a/drivers/iommu/iommu-sysfs.c
> +++ b/drivers/iommu/iommu-sysfs.c
> @@ -34,7 +34,6 @@ static const struct attribute_group *iommu_dev_groups[] = {
>  
>  static void iommu_release_device(struct device *dev)
>  {
> -	kfree(dev);
>  }

As per the documentation in the kernel tree, I now get to make fun of
you for doing such a crazh and foolish thing!

Come on, don't do that, a release function _HAS_ to free the memory
involved.  If not, then it is really broken...

greg k-h
