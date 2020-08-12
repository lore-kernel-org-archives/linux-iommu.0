Return-Path: <SRS0=ejku=BW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EAEC433DF
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 16:59:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A5E20838
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfnkuvzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A5E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93EDE883E1;
	Wed, 12 Aug 2020 16:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bD6XF3kv9mGj; Wed, 12 Aug 2020 16:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4FC488164;
	Wed, 12 Aug 2020 16:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9175CC013C;
	Wed, 12 Aug 2020 16:59:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37791C004D
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 33EBF86A57
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AJUwdMQjeGV2 for <iommu@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 16:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EE47A869FE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597251565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/TMDbTXRPMHA++0X0V/1R29t8yISpXHRZTrFNiw52A=;
 b=WfnkuvzI+Wv8PA3PAqHeBPBFHu6yumt6Z3mdCFpHnZgAxlc4IJq56wsv39RsGHqJcWwmJx
 1LCVkKLD+TI0fHhJ6RY81kz9i18GP9xDEXm4cKFvfHXdqhUWMdAk/utYMNQ43A3fTKWHj+
 Tn5bCu3t9SfWFM+mzGtpxk2Q3Rd2DiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-pPvv2GvsObOnxmeBqAXoZA-1; Wed, 12 Aug 2020 12:59:23 -0400
X-MC-Unique: pPvv2GvsObOnxmeBqAXoZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7AFF1835862;
 Wed, 12 Aug 2020 16:59:21 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1168119D71;
 Wed, 12 Aug 2020 16:59:15 +0000 (UTC)
Subject: Re: [PATCH v7 2/7] iommu/uapi: Add argsz for user filled data
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-3-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1ac39547-143b-2a2e-e142-92be023ef8d7@redhat.com>
Date: Wed, 12 Aug 2020 18:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Hi,

On 7/30/20 2:21 AM, Jacob Pan wrote:
> As IOMMU UAPI gets extended, user data size may increase. To support
> backward compatibiliy, this patch introduces a size field to each UAPI
s/compatibiliy/compatibility
> data structures. It is *always* the responsibility for the user to fill in
> the correct size. Padding fields are adjusted to ensure 8 byte alignment.
> 
> Specific scenarios for user data handling are documented in:
> Documentation/userspace-api/iommu.rst

you may mention the struct version does not need to be incremented as no
IOCTL uses the structs yet.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index e907b7091a46..d5e9014f690e 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -135,6 +135,7 @@ enum iommu_page_response_code {
>  
>  /**
>   * struct iommu_page_response - Generic page response information
> + * @argsz: User filled size of this data
>   * @version: API version of this structure
>   * @flags: encodes whether the corresponding fields are valid
>   *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
> @@ -143,6 +144,7 @@ enum iommu_page_response_code {
>   * @code: response code from &enum iommu_page_response_code
>   */
>  struct iommu_page_response {
> +	__u32	argsz;
>  #define IOMMU_PAGE_RESP_VERSION_1	1
>  	__u32	version;
>  #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> @@ -218,6 +220,7 @@ struct iommu_inv_pasid_info {
>  /**
>   * struct iommu_cache_invalidate_info - First level/stage invalidation
>   *     information
> + * @argsz: User filled size of this data
>   * @version: API version of this structure
>   * @cache: bitfield that allows to select which caches to invalidate
>   * @granularity: defines the lowest granularity used for the invalidation:
> @@ -246,6 +249,7 @@ struct iommu_inv_pasid_info {
>   * must support the used granularity.
>   */
>  struct iommu_cache_invalidate_info {
> +	__u32	argsz;
>  #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
>  	__u32	version;
>  /* IOMMU paging structure cache */
> @@ -255,7 +259,7 @@ struct iommu_cache_invalidate_info {
>  #define IOMMU_CACHE_INV_TYPE_NR		(3)
>  	__u8	cache;
>  	__u8	granularity;
> -	__u8	padding[2];
> +	__u8	padding[6];
>  	union {
>  		struct iommu_inv_pasid_info pasid_info;
>  		struct iommu_inv_addr_info addr_info;
> @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
>  
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
> + * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
>   * @format:	PASID table entry format
>   * @flags:	Additional information on guest bind request
> @@ -309,17 +314,18 @@ struct iommu_gpasid_bind_data_vtd {
>   * PASID to host PASID based on this bind data.
>   */
>  struct iommu_gpasid_bind_data {
> +	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
>  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>  	__u32 format;
> +	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
>  	__u64 flags;
>  	__u64 gpgd;
>  	__u64 hpasid;
>  	__u64 gpasid;
> -	__u32 addr_width;
> -	__u8  padding[12];
> +	__u8  padding[8];
>  	/* Vendor specific data */
>  	union {
>  		struct iommu_gpasid_bind_data_vtd vtd;
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
