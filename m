Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6195AC2D0C0
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:44:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362B32467F
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362B32467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 01CF088862;
	Fri, 20 Dec 2019 11:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XzFMoMZsXcZ; Fri, 20 Dec 2019 11:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C29F68885B;
	Fri, 20 Dec 2019 11:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA2D1C1796;
	Fri, 20 Dec 2019 11:44:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFA89C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EB5E48885E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5sAUo+0unim6 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 11:44:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1F6818885B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:44:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 03:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; d="scan'208";a="416513880"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2019 03:44:18 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Dec 2019 03:44:18 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Dec 2019 03:44:17 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.109]) with mapi id 14.03.0439.000;
 Fri, 20 Dec 2019 19:44:15 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "David Woodhouse" <dwmw2@infradead.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v4 4/7] iommu/vt-d: Setup pasid entries for iova over
 first level
Thread-Topic: [PATCH v4 4/7] iommu/vt-d: Setup pasid entries for iova over
 first level
Thread-Index: AQHVthrhmA1+nPY36UOVgBomY8KF4KfC58BA
Date: Fri, 20 Dec 2019 11:44:15 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A13A334@SHSMSX104.ccr.corp.intel.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
 <20191219031634.15168-5-baolu.lu@linux.intel.com>
In-Reply-To: <20191219031634.15168-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjliMzllZmEtYzk0MS00YzBhLWEwNGQtMzE3ODk5NTgzYWYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRktFb1l3NDlWOUZ1RFh2SERTK2FiS2MrNXdSMU9CUDZEc0o2NE5jRzl1YmVySUhESGRKcnFORDZYVUpJVWxRQyJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, December 19, 2019 11:17 AM
> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>;
> Alex Williamson <alex.williamson@redhat.com>
> Subject: [PATCH v4 4/7] iommu/vt-d: Setup pasid entries for iova over first level
> 
> Intel VT-d in scalable mode supports two types of page tables for IOVA translation:
> first level and second level. The IOMMU driver can choose one from both for IOVA
> translation according to the use case. This sets up the pasid entry if a domain is
> selected to use the first-level page table for iova translation.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h | 16 ++++++++-----
>  2 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 2b5a47584baf..f0813997dea2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -571,6 +571,11 @@ static inline int domain_type_is_si(struct dmar_domain
> *domain)
>  	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;  }
> 
> +static inline bool domain_use_first_level(struct dmar_domain *domain) {
> +	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL; }
> +
>  static inline int domain_pfn_supported(struct dmar_domain *domain,
>  				       unsigned long pfn)
>  {
> @@ -2288,6 +2293,8 @@ static int __domain_mapping(struct dmar_domain
> *domain, unsigned long iov_pfn,
>  		return -EINVAL;
> 
>  	prot &= DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP;
> +	if (domain_use_first_level(domain))
> +		prot |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
> 
>  	if (!sg) {
>  		sg_res = nr_pages;
> @@ -2515,6 +2522,36 @@ dmar_search_domain_by_dev_info(int segment, int bus,
> int devfn)
>  	return NULL;
>  }
> 
> +static int domain_setup_first_level(struct intel_iommu *iommu,
> +				    struct dmar_domain *domain,
> +				    struct device *dev,
> +				    int pasid)
> +{
> +	int flags = PASID_FLAG_SUPERVISOR_MODE;

Hi Baolu,

Could you explain a bit why PASID_FLAG_SUPERVISOR_MODE is
required?

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
