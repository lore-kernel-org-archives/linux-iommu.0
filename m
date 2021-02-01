Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EB7C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 07:35:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B2264E33
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 07:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B2264E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A61986846;
	Mon,  1 Feb 2021 07:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWmtu8xpzxEM; Mon,  1 Feb 2021 07:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E7B298684F;
	Mon,  1 Feb 2021 07:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFA65C0FA7;
	Mon,  1 Feb 2021 07:35:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C74CC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46AE48683B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id asQi7sNwm9gV for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:35:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ED67C8683F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612164934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIIyMdYX4ss9YyVUqtXNFUPDM8yR2OxXJHbAJpn06hc=;
 b=efZjtEizggs2z14M4Xk9lvTNpy5aNQnzVTuWdVpWf1hHKvn/332BY6iUOkwW2+BaAJ3djt
 ogDbTLvinIYVmziT4xelbr5ceP3eoqns66HlCpva3XmzE2m619Qnis9LaK71Dv45YdG0Mm
 /Ejv62C4TJx4hO5xPJMvk5gh2KVge1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-O7QH08jgPK6rXsyzh-FQIw-1; Mon, 01 Feb 2021 02:35:30 -0500
X-MC-Unique: O7QH08jgPK6rXsyzh-FQIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E113E10054FF;
 Mon,  1 Feb 2021 07:35:26 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C16335F705;
 Mon,  1 Feb 2021 07:35:20 +0000 (UTC)
Subject: Re: [PATCH v12 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-4-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f706b2f8-fcd8-4b49-0f1b-5ee7ed996256@redhat.com>
Date: Mon, 1 Feb 2021 08:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-4-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, vivek.gautam@arm.com,
 guohanjun@huawei.com, linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
 lenb@kernel.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 David Woodhouse <dwmw2@infradead.org>, linux-accelerators@lists.ozlabs.org
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

Hi Jean,

On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> mandating IOMMU-managed IOPF. The other device drivers now need to first
> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
> IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
> device driver, it is used in combination with other features.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  include/linux/iommu.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b7ea11fc1a93..00348e4c3c26 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>  	enum iommu_resv_type	type;
>  };
>  
> -/* Per device IOMMU features */
> +/**
> + * enum iommu_dev_features - Per device IOMMU features
> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
> + *			 enabling %IOMMU_DEV_FEAT_SVA requires
> + *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
> + *			 Faults themselves instead of relying on the IOMMU. When
> + *			 supported, this feature must be enabled before and
> + *			 disabled after %IOMMU_DEV_FEAT_SVA.
> + *
> + * Device drivers query whether a feature is supported using
> + * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
> + */
>  enum iommu_dev_features {
> -	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
> -	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
> +	IOMMU_DEV_FEAT_AUX,
> +	IOMMU_DEV_FEAT_SVA,
> +	IOMMU_DEV_FEAT_IOPF,
>  };
>  
>  #define IOMMU_PASID_INVALID	(-1U)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
