Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71224C433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 16:49:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3E7206DC
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 16:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+Gi3XrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3E7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE4D587DB1;
	Thu, 11 Jun 2020 16:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qgp15PDu1Q2k; Thu, 11 Jun 2020 16:49:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2867087DA9;
	Thu, 11 Jun 2020 16:49:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6D8C0178;
	Thu, 11 Jun 2020 16:49:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A87EEC016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 16:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F46787DAF
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 16:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iSJT9UIkwkON for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 16:49:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 85FAD87DA9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591894189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G26V2Ew/8yFsnDQkGFYVfeA5EQT8Zm6hGN1RoBXJQjA=;
 b=F+Gi3XrQJ6K9mq/+dpYuVnNDJWjXQovxfVNKWOHVDrkWQDNR/uZEFL7OFe/sQ2FOKNYpwG
 oSDVUlsVfxzRms2rUm6Kfdrg9LiWWdM4sKIUZvGR1xeJh7c9CLd8ZJwPf36v+Q/sG7HeS0
 4AsmBRQB6SiCaXqmOAb6W2jlmcd9uWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-7gYTRGMRP1i3w8cgUoLl6g-1; Thu, 11 Jun 2020 12:49:43 -0400
X-MC-Unique: 7gYTRGMRP1i3w8cgUoLl6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55639835B41;
 Thu, 11 Jun 2020 16:49:41 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 749445D9DC;
 Thu, 11 Jun 2020 16:49:37 +0000 (UTC)
Date: Thu, 11 Jun 2020 10:49:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/3] iommu/uapi: Add argsz for user filled data
Message-ID: <20200611104936.5129e99e@x1.home>
In-Reply-To: <1591848735-12447-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-3-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, 10 Jun 2020 21:12:14 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> As IOMMU UAPI gets extended, user data size may increase. To support
> backward compatibiliy, this patch introduces a size field to each UAPI
> data structures. It is *always* the responsibility for the user to fill in
> the correct size.

Though at the same time, argsz is user provided data which we don't
trust.  The argsz field allows the user to indicate how much data
they're providing, it's still the kernel's responsibility to validate
whether it's correct and sufficient for the requested operation.
Thanks,

Alex

> Specific scenarios for user data handling are documented in:
> Documentation/userspace-api/iommu.rst
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index e907b7091a46..303f148a5cd7 100644
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
> @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
>  
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
> + * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
>   * @format:	PASID table entry format
>   * @flags:	Additional information on guest bind request
> @@ -309,6 +314,7 @@ struct iommu_gpasid_bind_data_vtd {
>   * PASID to host PASID based on this bind data.
>   */
>  struct iommu_gpasid_bind_data {
> +	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
>  #define IOMMU_PASID_FORMAT_INTEL_VTD	1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
