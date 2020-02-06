Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDDC2D0B1
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC967214AF
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT/Gq9iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC967214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B50B88741F;
	Thu,  6 Feb 2020 10:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T3hGtAQGd05k; Thu,  6 Feb 2020 10:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FB5B8715D;
	Thu,  6 Feb 2020 10:14:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D634C0881;
	Thu,  6 Feb 2020 10:14:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0618C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDF0E8734E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGnbAOeIf6X7 for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 10:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F10B58715D
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580984084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILoRHHda+PqYCNA93STvliCKWA3E9VPhrVdonajAaSU=;
 b=BT/Gq9ivOPKhzqs7kZ1NM6kxAt3dF3pT5S64aMGPKyrtFNSv5dhXy0lSChuBND1ZtHUzmn
 fTxWorTRmJj65G4O/mH1k1q2IzmTdzx3jPoT6MOVi0moRH7izh0regCdBW4M1u8OEz/nOC
 Pmd8PD5ip/kKiYMwThy/xPScoa9/IOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-q4MWjhmSMFOhQ6qLr4ZWjw-1; Thu, 06 Feb 2020 05:14:39 -0500
X-MC-Unique: q4MWjhmSMFOhQ6qLr4ZWjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426CE8010FA;
 Thu,  6 Feb 2020 10:14:37 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3B615C1B0;
 Thu,  6 Feb 2020 10:14:29 +0000 (UTC)
Subject: Re: [PATCH 1/3] iommu/uapi: Define uapi version and capabilities
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <699faadb-e714-e36d-152a-5b650c0a403f@redhat.com>
Date: Thu, 6 Feb 2020 11:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,
On 1/29/20 7:02 AM, Jacob Pan wrote:
> Define a unified UAPI version to be used for compatibility
> checks between user and kernel.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index fcafb6401430..65a26c2519ee 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -8,6 +8,54 @@
>  
>  #include <linux/types.h>
>  
> +/**
> + * Current version of the IOMMU user API. This is intended for query
> + * between user and kernel to determine compatible data structures.
> + *
> + * Having a single UAPI version to govern the user-kernel data structures
> + * makes compatibility check straightforward. On the contrary, supporting
> + * combinations of multiple versions of the data can be a nightmare.
I would rather put the above justification in the commit msg and not here.
> + *
> + * UAPI version can be bumped up with the following rules:
> + * 1. All data structures passed between user and kernel space share
> + *    the same version number. i.e. any extension to to any structure
s/to to/to
> + *    results in version bump up.
in a version number increment?
> + *
> + * 2. Data structures are open to extension but closed to modification.> + *    New fields must be added at the end of each data structure with
> + *    64bit alignment. Flag bits can be added without size change but
> + *    existing ones cannot be altered.
> + *
> + * 3. Versions are backward compatible.
> + *
> + * 4. Version to size lookup is supported by kernel internal API for each
> + *    API function type. @version is mandatory for new data structures
> + *    and must be at the beginning with type of __u32.
> + */
> +#define IOMMU_UAPI_VERSION	1
> +static inline int iommu_get_uapi_version(void)
> +{
> +	return IOMMU_UAPI_VERSION;
> +}
> +
> +/*
> + * Supported UAPI features that can be reported to user space.
> + * These types represent the capability available in the kernel.
> + *
> + * REVISIT: UAPI version also implies the capabilities. Should we
> + * report them explicitly?
> + */
> +enum IOMMU_UAPI_DATA_TYPES {
> +	IOMMU_UAPI_BIND_GPASID,
> +	IOMMU_UAPI_CACHE_INVAL,
> +	IOMMU_UAPI_PAGE_RESP,
> +	NR_IOMMU_UAPI_TYPE,
> +};
> +
> +#define IOMMU_UAPI_CAP_MASK ((1 << IOMMU_UAPI_BIND_GPASID) |	\
> +				(1 << IOMMU_UAPI_CACHE_INVAL) |	\
> +				(1 << IOMMU_UAPI_PAGE_RESP))
> +
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
>  #define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
