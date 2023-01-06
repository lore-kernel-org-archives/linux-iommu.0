Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55175137F
	for <iommu@lists.linux.dev>; Fri,  6 Jan 2023 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673004892; x=1704540892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h52bTybgotE/+arZH7dQLP3uJT6YAOrJvSJlk08qNYs=;
  b=R9hmaZhIN1CwJhZw+eQrauZoAul16HpX/7J/uC+M1V0AThl6YdpaqQGv
   Yo2lFVEsBQxYlYIRswePMmH5cpcae0NuqVxW18L6DLErgNBq4puJ1HK7G
   9YEv587YBPiTyK0KheOlgTmgNRn0KJRQZn9T7PjtV5HiumpcDov95+HTW
   NP/LOBilXUOMmgLd1+EPviq/MpXviWyWuC8qy0a8IdgR1jXHH7kFBP5qZ
   qTaqmQrR3c9l3rJImXSU7FrRzEoAyqyywtOq5EMhNRWvg4Fg8kdlat7+G
   fLkcH3XJaJKDkOCLEzrKSyIlxjTvi/NZ4vbKxMKqRppevt2l3JLaimUoG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="322531835"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="322531835"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 03:34:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="655934700"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="655934700"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.214]) ([10.254.211.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 03:34:43 -0800
Message-ID: <654b8a24-e5a5-07b1-3127-46df80c1b545@linux.intel.com>
Date: Fri, 6 Jan 2023 19:34:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iommufd v3 3/9] vfio/type1: Convert to
 iommu_group_has_isolated_msi()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Will Deacon <will.deacon@arm.com>
References: <3-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/2023 3:33 AM, Jason Gunthorpe wrote:
> Trivially use the new API.
>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00d4..393b27a3bd87ee 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -37,7 +37,6 @@
>   #include <linux/vfio.h>
>   #include <linux/workqueue.h>
>   #include <linux/notifier.h>
> -#include <linux/irqdomain.h>
>   #include "vfio.h"
>   
>   #define DRIVER_VERSION  "0.2"
> @@ -2160,12 +2159,6 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>   	list_splice_tail(iova_copy, iova);
>   }
>   
> -/* Redundantly walks non-present capabilities to simplify caller */
> -static int vfio_iommu_device_capable(struct device *dev, void *data)
> -{
> -	return device_iommu_capable(dev, (enum iommu_cap)data);
> -}
> -
>   static int vfio_iommu_domain_alloc(struct device *dev, void *data)
>   {
>   	struct iommu_domain **domain = data;
> @@ -2180,7 +2173,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	struct vfio_iommu *iommu = iommu_data;
>   	struct vfio_iommu_group *group;
>   	struct vfio_domain *domain, *d;
> -	bool resv_msi, msi_remap;
> +	bool resv_msi;
>   	phys_addr_t resv_msi_base = 0;
>   	struct iommu_domain_geometry *geo;
>   	LIST_HEAD(iova_copy);
> @@ -2278,11 +2271,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	INIT_LIST_HEAD(&domain->group_list);
>   	list_add(&group->next, &domain->group_list);
>   
> -	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
> -					     vfio_iommu_device_capable);
> -
> -	if (!allow_unsafe_interrupts && !msi_remap) {
> +	if (!allow_unsafe_interrupts &&
> +	    !iommu_group_has_isolated_msi(iommu_group)) {
>   		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>   		       __func__);
>   		ret = -EPERM;

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

--

Best regards,

baolu

