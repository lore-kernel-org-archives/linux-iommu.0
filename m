Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D362C433E4
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 09:29:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C4E20781
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 09:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DK5yRnBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C4E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B8B952045B;
	Thu, 13 Aug 2020 09:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NhOlE2dGr0-5; Thu, 13 Aug 2020 09:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B8D8120415;
	Thu, 13 Aug 2020 09:29:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A98B8C013C;
	Thu, 13 Aug 2020 09:29:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C116AC004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BCDFF863FD
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TeMXBqW5Mfwu for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 09:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 26B1C8621D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597310961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuW+niP5miqE6IU1aSrvItfHXK36bjH0nUEUiC5ZcoE=;
 b=DK5yRnBY3gAauOSTThQ6cK88P8P/YVeOPb4gwmH6xXDN3uO2YUgwu2rm3lhHQTv2DqWtp9
 8YbGkcaarMiucS6+wM+Y/5mjUp8P170eUFqOpDppwKM7o7xA0FQbSc6c4LT09CMVsNUGzt
 lrhevViaa9npEnvNlxtgEvcItOEIA3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-xxSP7HqAMUiNawIogS2kFQ-1; Thu, 13 Aug 2020 05:29:17 -0400
X-MC-Unique: xxSP7HqAMUiNawIogS2kFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511711854FC7;
 Thu, 13 Aug 2020 09:29:15 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3F7600C5;
 Thu, 13 Aug 2020 09:29:06 +0000 (UTC)
Subject: Re: [PATCH v7 3/7] iommu/uapi: Introduce enum type for PASID data
 format
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-4-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <98781b4e-fe8e-fa65-4b77-c5221d241821@redhat.com>
Date: Thu, 13 Aug 2020 11:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

On 7/30/20 2:21 AM, Jacob Pan wrote:
> There can be multiple vendor-specific PASID data formats used in UAPI
> structures. This patch adds enum type with a last entry which makes
> range checking much easier.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index d5e9014f690e..abf4455a3495 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -294,11 +294,16 @@ struct iommu_gpasid_bind_data_vtd {
>  					 IOMMU_SVA_VTD_GPASID_PCD |  \
>  					 IOMMU_SVA_VTD_GPASID_PWT)
>  
> +enum iommu_pasid_data_format {
> +	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
> +	IOMMU_PASID_FORMAT_LAST,
> +};
> +
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>   * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
> - * @format:	PASID table entry format
> + * @format:	PASID table entry format of enum iommu_pasid_data_format type
>   * @flags:	Additional information on guest bind request
>   * @gpgd:	Guest page directory base of the guest mm to bind
>   * @hpasid:	Process address space ID used for the guest mm in host IOMMU
> @@ -317,7 +322,6 @@ struct iommu_gpasid_bind_data {
>  	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
> -#define IOMMU_PASID_FORMAT_INTEL_VTD	1
>  	__u32 format;
>  	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
