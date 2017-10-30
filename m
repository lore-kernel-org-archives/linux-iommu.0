From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: add sysfs file to print out all domains
Date: Mon, 30 Oct 2017 23:15:52 +0100
Message-ID: <20171030231552.0d59a0e7@t450s.home>
References: <1509395971-28863-1-git-send-email-vpai@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1509395971-28863-1-git-send-email-vpai-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vishwanath Pai via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Vishwanath Pai <vpai-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, pai.vishwain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 30 Oct 2017 16:39:31 -0400
Vishwanath Pai via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:

> This patch adds a new sysfile for intel-iommu driver which prints out
> all allocated iommu domains:
> 
> $> cat /sys/class/iommu/dmar0/intel-iommu/domains  
> did | pci_device_name
>   1 | 0000:00:14.0
>   2 | 0000:00:1d.0
>   3 | 0000:00:1f.0
>   4 | 0000:02:00.0
>   5 | 0000:02:00.1
>   6 | 0000:02:00.2
>   7 | 0000:02:00.3
>   8 | 0000:00:1f.2
>   9 | 0000:04:00.0
>  10 | 0000:03:00.0
>  11 | 0000:03:00.1

If we want this feature (you haven't said why we want this feature),
this is the wrong model to do it.  It's heavy weight, it has built in
truncation if we have too many devices, it only supports PCI, it kind of
violates the sysfs one value per file model, it's not very machine
readable, and it's potentially racy.  Why not instead create a directory
per domain id and within that directory link to the devices attached to
the domain?  Evaluating the domains is then free at the cost of a
little extra when we add/remove domains or attach/detach devices.
Thanks,

Alex


> Signed-off-by: Vishwanath Pai <vpai-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6784a05..9428cb9 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4704,6 +4704,58 @@ static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
>  }
>  static DEVICE_ATTR(domains_used, S_IRUGO, intel_iommu_show_ndoms_used, NULL);
>  
> +/*
> + * This can return a maximum of PAGE_SIZE bytes, so we are forced to chop off
> + * any characters beyond that
> + */
> +static ssize_t intel_iommu_show_domains(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	bool found = false;
> +	ssize_t len, count = 0;
> +	char *str;
> +	int did;
> +
> +	str = (char *) kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!str)
> +		return sprintf(buf, "ERROR: ENOMEM\n");
> +
> +	for (did = 0; did < cap_ndoms(iommu->cap); did++) {
> +		domain = get_iommu_domain(iommu, (u16)did);
> +
> +		if (!domain)
> +			continue;
> +
> +		list_for_each_entry(info, &domain->devices, link) {
> +			if (!info->dev)
> +				continue;
> +
> +			if (!dev_is_pci(info->dev))
> +				continue;
> +
> +			if (!found)
> +				count += sprintf(buf, "did | pci_device_name\n");
> +			found = true;
> +
> +			len = sprintf(str, "%3d | %s\n", did, dev_name(info->dev));
> +			if (count + len < PAGE_SIZE)
> +				count += sprintf(buf+count, str);
> +		}
> +	}
> +
> +	kfree(str);
> +
> +	if (!found)
> +		return sprintf(buf, "No domains found, IOMMU disabled?\n");
> +
> +	return count;
> +}
> +static DEVICE_ATTR(domains, S_IRUGO, intel_iommu_show_domains, NULL);
> +
>  static struct attribute *intel_iommu_attrs[] = {
>  	&dev_attr_version.attr,
>  	&dev_attr_address.attr,
> @@ -4711,6 +4763,7 @@ static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
>  	&dev_attr_ecap.attr,
>  	&dev_attr_domains_supported.attr,
>  	&dev_attr_domains_used.attr,
> +	&dev_attr_domains.attr,
>  	NULL,
>  };
>  
