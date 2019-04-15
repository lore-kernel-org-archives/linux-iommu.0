Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930FC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 20:37:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDBF2087C
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 20:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDBF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A1975CC1;
	Mon, 15 Apr 2019 20:37:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A63BA95
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 20:37:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 83389854
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 20:37:13 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D31D133024A;
	Mon, 15 Apr 2019 20:37:12 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4F3D1001E93;
	Mon, 15 Apr 2019 20:37:11 +0000 (UTC)
Date: Mon, 15 Apr 2019 14:37:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20190415143711.13c29308@x1.home>
In-Reply-To: <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 15 Apr 2019 20:37:13 +0000 (UTC)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Message-ID: <20190415203711.OOerlM1tACHPg20lHQxwzPmg7CdAxIxndFJD97yC5_U@z>

On Mon,  8 Apr 2019 16:59:25 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch register a
> custom IOASID allocator which takes precedence over the default
> IDR based allocator. The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28cb713..a38d774 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4820,6 +4820,42 @@ static int __init platform_optin_force_iommu(void)
>  	return 1;
>  }
>  
> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +	ioasid_t ioasid;
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +	return ioasid;

How does this honor min/max?

> +}
> +
> +static int intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct iommu_pasid_alloc_info *svm;
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu || !cap_caching_mode(iommu->cap))
> +		return -EINVAL;
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbond.
> +	 */
> +	svm = ioasid_find(NULL, ioasid, NULL);
> +	if (!svm) {
> +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> +		return -EBUSY;
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +
> +	return 0;
> +}
> +
> +static struct ioasid_allocator intel_iommu_ioasid_allocator = {
> +	.alloc = intel_ioasid_alloc,
> +	.free = intel_ioasid_free,
> +};
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = -ENODEV;
> @@ -4921,6 +4957,20 @@ int __init intel_iommu_init(void)
>  				       "%s", iommu->name);
>  		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>  		iommu_device_register(&iommu->iommu);
> +		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
> +			/*
> +			 * Register a custom ASID allocator if we are running
> +			 * in a guest, the purpose is to have a system wide PASID
> +			 * namespace among all PASID users.
> +			 * Note that only one vIOMMU in each guest is supported.

Why one vIOMMU per guest?  This would prevent guests with multiple PCI
domains aiui.

> +			 */
> +			intel_iommu_ioasid_allocator.pdata = (void *)iommu;
> +			ret = ioasid_set_allocator(&intel_iommu_ioasid_allocator);
> +			if (ret == -EBUSY) {
> +				pr_info("Custom IOASID allocator already registered\n");
> +				break;
> +			}
> +		}
>  	}
>  
>  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index b29c85c..bc09d80 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -31,6 +31,7 @@
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/dmar.h>
> +#include <linux/ioasid.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
