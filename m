Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB7DC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728F42190A
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728F42190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5928F153D;
	Wed, 24 Apr 2019 17:27:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 298E71532
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 17:27:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D13A0855
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 17:27:51 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4509870D7D;
	Wed, 24 Apr 2019 17:27:51 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 51E6F5D9CD;
	Wed, 24 Apr 2019 17:27:46 +0000 (UTC)
Subject: Re: [PATCH v2 12/19] iommu/vt-d: Move domain helper to header
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-13-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <69413823-2749-80d0-c200-0f82d14467b7@redhat.com>
Date: Wed, 24 Apr 2019 19:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-13-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 24 Apr 2019 17:27:51 +0000 (UTC)
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
Message-ID: <20190424172744.F7wBN-DB0-D_VJ95BMfqwF4a6eXL7MkSiEE7ErHcXEk@z>

Hi Jacob

On 4/24/19 1:31 AM, Jacob Pan wrote:
> Move domainer helper to header to be used by SVA code.
s/domainer/domain
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel-iommu.c | 6 ------
>  include/linux/intel-iommu.h | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 785330a..77bbe1b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -427,12 +427,6 @@ static void init_translation_status(struct intel_iommu *iommu)
>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>  }
>  
> -/* Convert generic 'struct iommu_domain to private struct dmar_domain */
> -static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> -{
> -	return container_of(dom, struct dmar_domain, domain);
> -}
> -
>  static int __init intel_iommu_setup(char *str)
>  {
>  	if (!str)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index c24c8aa..48fa164 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -597,6 +597,12 @@ static inline void __iommu_flush_cache(
>  		clflush_cache_range(addr, size);
>  }
>  
> +/* Convert generic 'struct iommu_domain to private struct dmar_domain */
> +static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct dmar_domain, domain);
> +}
> +
>  /*
>   * 0: readable
>   * 1: writable
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
