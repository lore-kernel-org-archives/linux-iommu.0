Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6306FC10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 12:47:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1933C205F4
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1933C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D69991E47;
	Thu, 25 Apr 2019 12:47:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0B7AA1E43
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 12:47:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B2D1F74A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 12:47:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA24A78;
	Thu, 25 Apr 2019 05:47:04 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F063A3F5C1;
	Thu, 25 Apr 2019 05:47:01 -0700 (PDT)
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
Date: Thu, 25 Apr 2019 13:46:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
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
Message-ID: <20190425124643.77Il0KT99Zmd3_S2NjAQ0iwZD9LoutVoLECNeO1221M@z>

On 24/04/2019 00:31, Jacob Pan wrote:
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> new file mode 100644
> index 0000000..edcc0dd
> --- /dev/null
> +++ b/include/uapi/linux/iommu.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * IOMMU user API definitions
> + */
> +
> +#ifndef _UAPI_IOMMU_H
> +#define _UAPI_IOMMU_H
> +
> +#include <linux/types.h>
> +
> +#define IOMMU_FAULT_PERM_WRITE	(1 << 0) /* write */
> +#define IOMMU_FAULT_PERM_EXEC	(1 << 1) /* exec */
> +#define IOMMU_FAULT_PERM_PRIV	(1 << 2) /* privileged */

Could we add IOMMU_FAULT_PERM_READ back? The PRI Page Request has both R
and W fields, and R=W=0 encodes the PASID Stop Markers. Even though the
IOMMU drivers currently filter out the Stop Markers, we may want to
inject them into guests at some point in the future, which wouldn't be
possible with the current API. We could add a
IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find it
weird to denote the validity of a bitfield using a separate bit.

Given that three different series now rely on this, how about we send
the fault patches separately for v5.2? I pushed the recoverable fault
support applied on top of this, with the PERM_READ bit and cleaned up
kernel doc, to git://linux-arm.org/linux-jpb.git sva/api

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
