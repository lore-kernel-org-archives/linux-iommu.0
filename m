From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/11] iommu: Add iommu_device_set_fwnode() interface
Date: Fri, 10 Feb 2017 14:16:54 +0000
Message-ID: <417eee8c-4e1b-57f0-2c00-d6c3926ce66d@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-7-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486639981-32368-7-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/02/17 11:32, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Allow to store a fwnode in 'struct iommu_device';
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  include/linux/iommu.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bae3cfc..626c935 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -214,6 +214,7 @@ struct iommu_ops {
>  struct iommu_device {
>  	struct list_head list;
>  	const struct iommu_ops *ops;
> +	struct fwnode_handle *fwnode;
>  	struct device dev;
>  };
>  
> @@ -233,6 +234,12 @@ static inline void iommu_device_set_ops(struct iommu_device *iommu,
>  	iommu->ops = ops;
>  }
>  
> +static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
> +					   struct fwnode_handle *fwnode)
> +{
> +	iommu->fwnode = fwnode;
> +}

Would it make sense to simply make the ops and fwnode additional
arguments to iommu_device_register() (permitting fwnode to be NULL)?
AFAICS they should typically all have the same effective lifetime so
there doesn't seem to be any real need to handle everything separately.

Robin.

> +
>  #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
>  #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
>  #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
> @@ -580,6 +587,11 @@ static inline void iommu_device_set_ops(struct iommu_device *iommu,
>  {
>  }
>  
> +static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
> +					   struct fwnode_handle *fwnode)
> +{
> +}
> +
>  static inline void iommu_device_unregister(struct iommu_device *iommu)
>  {
>  }
> 
