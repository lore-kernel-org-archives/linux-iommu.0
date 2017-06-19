From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/s390: Add support for iommu_device handling
Date: Mon, 19 Jun 2017 17:02:19 +0200
Message-ID: <20170619170219.0a8626b6@thinkpad>
References: <1497532312-30470-1-git-send-email-joro@8bytes.org>
	<1497532312-30470-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497532312-30470-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 15 Jun 2017 15:11:52 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Add support for the iommu_device_register interface to make
> the s390 hardware iommus visible to the iommu core and in
> sysfs.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  arch/s390/include/asm/pci.h |  7 +++++++
>  arch/s390/pci/pci.c         |  5 +++++
>  drivers/iommu/s390-iommu.c  | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 4e31866..a3f697e 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -8,6 +8,7 @@
> 
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
> +#include <linux/iommu.h>
>  #include <asm-generic/pci.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_debug.h>
> @@ -123,6 +124,8 @@ struct zpci_dev {
>  	unsigned long	iommu_pages;
>  	unsigned int	next_bit;
> 
> +	struct iommu_device iommu_dev;  /* IOMMU core handle */
> +
>  	char res_name[16];
>  	struct zpci_bar_struct bars[PCI_BAR_COUNT];
> 
> @@ -173,6 +176,10 @@ int clp_add_pci_device(u32, u32, int);
>  int clp_enable_fh(struct zpci_dev *, u8);
>  int clp_disable_fh(struct zpci_dev *);
> 
> +/* IOMMU Interface */
> +int zpci_init_iommu(struct zpci_dev *zdev);
> +void zpci_destroy_iommu(struct zpci_dev *zdev);
> +
>  #ifdef CONFIG_PCI
>  /* Error handling and recovery */
>  void zpci_event_error(void *);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 8051df1..4c13da6 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -749,6 +749,7 @@ void pcibios_remove_bus(struct pci_bus *bus)
> 
>  	zpci_exit_slot(zdev);
>  	zpci_cleanup_bus_resources(zdev);
> +	zpci_destroy_iommu(zdev);
>  	zpci_free_domain(zdev);
> 
>  	spin_lock(&zpci_list_lock);
> @@ -820,6 +821,10 @@ int zpci_create_device(struct zpci_dev *zdev)
>  	if (rc)
>  		goto out;
> 
> +	rc = zpci_init_iommu(zdev);
> +	if (rc)
> +		goto out_free;
> +

After this point, there are two options for failure (zpci_enable_device +
zpci_scan_bus), but missing error handling with an appropriate call to
zpci_destroy_iommu().

I must admit that I do not understand what these sysfs attributes are
used for, and by whom and when. Is it really necessary/correct to register
them (including the s390_iommu_ops) _before_ the zpci_dev is registered
to the bus (zpci_scan_bus -> pci_scan_root_bus/pci_bus_add_devices)?

What is the expected life cycle for the attributes, and are they already
needed when a device is still under DMA API access, or even before it is
added to the PCI bus?

>  	mutex_init(&zdev->lock);
>  	if (zdev->state == ZPCI_FN_STATE_CONFIGURED) {
>  		rc = zpci_enable_device(zdev);
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 8788640..85f3bc5 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -18,6 +18,8 @@
>   */
>  #define S390_IOMMU_PGSIZES	(~0xFFFUL)
> 
> +static struct iommu_ops s390_iommu_ops;
> +
>  struct s390_domain {
>  	struct iommu_domain	domain;
>  	struct list_head	devices;
> @@ -166,11 +168,13 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>  static int s390_iommu_add_device(struct device *dev)
>  {
>  	struct iommu_group *group = iommu_group_get_for_dev(dev);
> +	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
> 
>  	if (IS_ERR(group))
>  		return PTR_ERR(group);
> 
>  	iommu_group_put(group);
> +	iommu_device_link(&zdev->iommu_dev, dev);
> 
>  	return 0;
>  }
> @@ -197,6 +201,7 @@ static void s390_iommu_remove_device(struct device *dev)
>  			s390_iommu_detach_device(domain, dev);
>  	}
> 
> +	iommu_device_unlink(&zdev->iommu_dev, dev);
>  	iommu_group_remove_device(dev);
>  }
> 
> @@ -327,6 +332,36 @@ static size_t s390_iommu_unmap(struct iommu_domain *domain,
>  	return size;
>  }
> 
> +int zpci_init_iommu(struct zpci_dev *zdev)
> +{
> +	int rc = 0;
> +
> +	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
> +				    "s390-iommu.%08x", zdev->fid);
> +	if (rc)
> +		goto out_err;
> +
> +	iommu_device_set_ops(&zdev->iommu_dev, &s390_iommu_ops);
> +
> +	rc = iommu_device_register(&zdev->iommu_dev);
> +	if (rc)
> +		goto out_sysfs;
> +
> +	return 0;
> +
> +out_sysfs:
> +	iommu_device_sysfs_remove(&zdev->iommu_dev);
> +
> +out_err:
> +	return rc;
> +}
> +
> +void zpci_destroy_iommu(struct zpci_dev *zdev)
> +{
> +	iommu_device_unregister(&zdev->iommu_dev);
> +	iommu_device_sysfs_remove(&zdev->iommu_dev);
> +}
> +
>  static struct iommu_ops s390_iommu_ops = {
>  	.capable = s390_iommu_capable,
>  	.domain_alloc = s390_domain_alloc,
