Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CBC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:55:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6762077B
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6762077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 673B42901;
	Fri, 26 Apr 2019 15:55:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A1DE2731
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:53:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 875BE860
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:53:49 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF4AD308A11E;
	Fri, 26 Apr 2019 15:53:48 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD71C691A6;
	Fri, 26 Apr 2019 15:53:45 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 14/19] iommu: Add guest PASID bind function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-15-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <35194a94-ed09-d086-8725-f7e1bdfbb877@redhat.com>
Date: Fri, 26 Apr 2019 17:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-15-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 26 Apr 2019 15:53:49 +0000 (UTC)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426155343.ONgbHmiDXOJLub-n3IRtaDmblhVMytGI2YPxBozlwt4@z>

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> Guest shared virtual address (SVA) may require host to shadow guest
> PASID tables. Guest PASID can also be allocated from the host via
> enlightened interfaces. In this case, guest needs to bind the guest
> mm, i.e. cr3 in guest phisical address to the actual PASID table in
physical
> the host IOMMU. Nesting will be turned on such that guest virtual
> address can go through a two level translation:
> - 1st level translates GVA to GPA
> - 2nd level translates GPA to HPA
> This patch introduces APIs to bind guest PASID data to the assigned
> device entry in the physical IOMMU. See the diagram below for usage
> explaination.
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process mm, FL only |
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |
>     '-------------'
> Guest
> ------| Shadow |--------------------------|------------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.---------------------.
>     |             |   |Set SL to GPA-HPA    |
>     |             |   '---------------------'
>     '-------------'
> 
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c      | 20 ++++++++++++++++++++
>  include/linux/iommu.h      | 10 ++++++++++
>  include/uapi/linux/iommu.h | 15 ++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 498c28a..072f8f3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1561,6 +1561,26 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
>  
> +int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> +			struct device *dev, struct gpasid_bind_data *data)
> +{
> +	if (unlikely(!domain->ops->sva_bind_gpasid))
> +		return -ENODEV;
> +
> +	return domain->ops->sva_bind_gpasid(domain, dev, data);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> +
> +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			int pasid)
> +{
> +	if (unlikely(!domain->ops->sva_unbind_gpasid))
> +		return -ENODEV;
> +
> +	return domain->ops->sva_unbind_gpasid(dev, pasid);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4b92e4b..611388e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -231,6 +231,8 @@ struct iommu_sva_ops {
>   * @detach_pasid_table: detach the pasid table
>   * @cache_invalidate: invalidate translation caches
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> + * @sva_bind_gpasid: bind guest pasid and mm
> + * @sva_unbind_gpasid: unbind guest pasid and mm
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -295,6 +297,10 @@ struct iommu_ops {
>  
>  	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
>  				struct iommu_cache_invalidate_info *inv_info);
> +	int (*sva_bind_gpasid)(struct iommu_domain *domain,
> +			struct device *dev, struct gpasid_bind_data *data);
> +
> +	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
So I am confused now. As the scalable mode PASID table entry contains
both the FL and SL PT pointers, will you ever use the
attach/detach_pasid_table or are we the only known users on ARM?

>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -409,6 +415,10 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
>  extern int iommu_cache_invalidate(struct iommu_domain *domain,
>  				  struct device *dev,
>  				  struct iommu_cache_invalidate_info *inv_info);
> +extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> +		struct device *dev, struct gpasid_bind_data *data);
> +extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> +				struct device *dev, int pasid);
definition in !CONFIG_IOMMU_API case?
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 61a3fb7..5c95905 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -235,6 +235,19 @@ struct iommu_cache_invalidate_info {
>  		struct iommu_inv_addr_info addr_info;
>  	};
>  };
> -
> +/**
> + * struct gpasid_bind_data - Information about device and guest PASID binding
> + * @gcr3:	Guest CR3 value from guest mm
> + * @pasid:	Process address space ID used for the guest mm
> + * @addr_width:	Guest address width. Paging mode can also be derived.
> + */
> +struct gpasid_bind_data {
> +	__u64 gcr3;
> +	__u32 pasid;
> +	__u32 addr_width;
> +	__u32 flags;
> +#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor request */
> +	__u8 padding[4];
> +};


Thanks

Eric
>  
>  #endif /* _UAPI_IOMMU_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
