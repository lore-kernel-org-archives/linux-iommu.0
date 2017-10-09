From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Don't register bus-notifier under
Date: Mon, 9 Oct 2017 18:58:13 +0200
Message-ID: <2ee59dfe-0a02-05b6-8115-5846b49bc053@siemens.com>
References: <4e9f9665-38f7-c5f0-2a9d-13bb3a00aab2@siemens.com>
	<6ed4183a-b2eb-b8d3-c54c-fb0c4fd7a813@siemens.com>
	<82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
	<20171006130823.a4rtzhusjpbgo3ar@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171006130823.a4rtzhusjpbgo3ar-l3A5Bk7waGM@public.gmane.org>
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
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2017-10-06 15:08, Joerg Roedel wrote:
> Hey Jan,
> 
> On Wed, Sep 27, 2017 at 04:19:15PM +0200, Jan Kiszka wrote:
>> If we could drop the dmar_global_lock around bus_register_notifier in
>> dmar_dev_scope_init, the issue above would likely be resolved.
> 
> That is true. Can you please try this patch?
> 
>>From dd7685f84d3954f9361bfb4290fb8a0dd033097a Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Date: Fri, 6 Oct 2017 15:00:53 +0200
> Subject: [PATCH] iommu/vt-d: Don't register bus-notifier under
>  dmar_global_lock
> 
> The notifier function will take the dmar_global_lock too, so
> lockdep complains about inverse locking order when the
> notifier is registered under the dmar_global_lock.
> 
> Reported-by: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
> Fixes: 59ce0515cdaf ('iommu/vt-d: Update DRHD/RMRR/ATSR device scope caches when PCI hotplug happens')
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/dmar.c        |  7 +++++--
>  drivers/iommu/intel-iommu.c | 10 ++++++++++
>  include/linux/dmar.h        |  1 +
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 57c920c1372d..1ea7cd537873 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -801,13 +801,16 @@ int __init dmar_dev_scope_init(void)
>  				dmar_free_pci_notify_info(info);
>  			}
>  		}
> -
> -		bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
>  	}
>  
>  	return dmar_dev_scope_status;
>  }
>  
> +void dmar_register_bus_notifier(void)
> +{
> +	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
> +}
> +
>  
>  int __init dmar_table_init(void)
>  {
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6784a05dd6b2..934cef924461 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4752,6 +4752,16 @@ int __init intel_iommu_init(void)
>  		goto out_free_dmar;
>  	}
>  
> +	up_write(&dmar_global_lock);
> +
> +	/*
> +	 * The bus notifier takes the dmar_global_lock, so lockdep will
> +	 * complain later when we register it under the lock.
> +	 */
> +	dmar_register_bus_notifier();
> +
> +	down_write(&dmar_global_lock);
> +
>  	if (no_iommu || dmar_disabled) {
>  		/*
>  		 * We exit the function here to ensure IOMMU's remapping and
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index e8ffba1052d3..e2433bc50210 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -112,6 +112,7 @@ static inline bool dmar_rcu_check(void)
>  
>  extern int dmar_table_init(void);
>  extern int dmar_dev_scope_init(void);
> +extern void dmar_register_bus_notifier(void);
>  extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
>  				struct dmar_dev_scope **devices, u16 segment);
>  extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
> 

Silences the warning, but locking in the init paths still smells fishy
to me.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
