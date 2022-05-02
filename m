Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67984C433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 21:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 015D282425;
	Mon,  2 May 2022 21:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2jXO7GGtBNe; Mon,  2 May 2022 21:32:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC249823DD;
	Mon,  2 May 2022 21:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CAFDC0032;
	Mon,  2 May 2022 21:32:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 669E9C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 465F0405A3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_ocVRfNE9bb for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:32:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 922CF40133
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651527143; x=1683063143;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G0FF9i1jLHjZ/yzasx+agtmTQl9xoAQw3ixOJN2ci8o=;
 b=dz7We7e+kF/k31RFE3cuiz4z2jAyl+enLi/JHSTbhc6Psyiw9m80sx+O
 HoCpmCrdJdCJAaPdB2NhhOxB5YpFbf4yuM0HKEOIHEwbgXm9XpIq68vub
 L8ZpYBhGOaDIF4XPAo6r5TG/BVWvwrQnxTHlcHXy8UEeOEpWgdIMMLoWg
 phtDGyUz9eOvWDjwe0QFMTSJnknHyTKH4sFfR4+W8gcRnqCUbW49jWfFH
 TJqKlDIprExlNAln8diHsOkcAwPh4vzPBxqxnRWRxjerY6fbC9kVJjTQt
 6GaktZ3hpQQvmAoOQglCrtPf6C++u3/TpnWKaCkwMe3187PNHTyTtil83 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="264924731"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; d="scan'208";a="264924731"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 14:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; d="scan'208";a="652997307"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 14:32:22 -0700
Date: Mon, 2 May 2022 14:36:03 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Message-ID: <20220502143603.4143dd66@jacob-builder>
In-Reply-To: <20220501112434.874236-5-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-5-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>, jacob.jun.pan@intel.com,
 Jason Gunthorpe <jgg@nvidia.com>
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

Hi BaoLu,

On Sun, 1 May 2022 19:24:33 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> The IOMMU force snooping capability is not required to be consistent
> among all the IOMMUs anymore. Remove force snooping capability check
> in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
> a dead code now.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 34 +---------------------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3c1c228f9031..d5808495eb64 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct
> dmar_domain *domain) rcu_read_unlock();
>  }
>  
> -static bool domain_update_iommu_snooping(struct intel_iommu *skip)
> -{
> -	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> -	bool ret = true;
> -
> -	rcu_read_lock();
> -	for_each_active_iommu(iommu, drhd) {
> -		if (iommu != skip) {
> -			/*
> -			 * If the hardware is operating in the scalable
> mode,
> -			 * the snooping control is always supported
> since we
> -			 * always set PASID-table-entry.PGSNP bit if the
> domain
> -			 * is managed outside (UNMANAGED).
> -			 */
> -			if (!sm_supported(iommu) &&
> -			    !ecap_sc_support(iommu->ecap)) {
> -				ret = false;
> -				break;
> -			}
> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static int domain_update_iommu_superpage(struct dmar_domain *domain,
>  					 struct intel_iommu *skip)
>  {
> @@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit
> *dmaru) iommu->name);
>  		return -ENXIO;
>  	}
> -	if (!ecap_sc_support(iommu->ecap) &&
> -	    domain_update_iommu_snooping(iommu)) {
> -		pr_warn("%s: Doesn't support snooping.\n",
> -			iommu->name);
> -		return -ENXIO;
> -	}
> +
Maybe I missed earlier patches, so this bit can also be deleted?

struct dmar_domain {
	u8 iommu_snooping: 1;		/* indicate snooping control
feature */

>  	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
>  	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
>  		pr_warn("%s: Doesn't support large page.\n",


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
