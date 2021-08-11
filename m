Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEBC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 14:53:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF28660FC3
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 14:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF28660FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CE9840163;
	Wed, 11 Aug 2021 14:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozhQczwY00uV; Wed, 11 Aug 2021 14:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CD93400D5;
	Wed, 11 Aug 2021 14:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E30CC001A;
	Wed, 11 Aug 2021 14:53:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC0D9C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 14:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C83F060864
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 14:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wq6yT_ovYA_f for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 14:53:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 478256085F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 14:53:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214868681"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; d="scan'208";a="214868681"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2021 07:53:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; d="scan'208";a="571158048"
Received: from watoney1-mobl.amr.corp.intel.com (HELO
 skuppusw-mobl5.amr.corp.intel.com) ([10.209.129.121])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2021 07:53:40 -0700
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
Date: Wed, 11 Aug 2021 07:53:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
Content-Language: en-US
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Andi Kleen <ak@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 7/27/21 3:26 PM, Tom Lendacky wrote:
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..f8ed7b72967b
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky<thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _PROTECTED_GUEST_H
> +#define _PROTECTED_GUEST_H
> +
> +#ifndef __ASSEMBLY__

Can you include headers for bool type and false definition?

--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -12,6 +12,9 @@

  #ifndef __ASSEMBLY__

+#include <linux/types.h>
+#include <linux/stddef.h>

Otherwise, I see following errors in multi-config auto testing.

include/linux/protected_guest.h:40:15: error: unknown type name 'bool'
include/linux/protected_guest.h:40:63: error: 'false' undeclared (first use in this functi


> +
> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
> +
> +#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
> +
> +#include <asm/protected_guest.h>
> +
> +#else	/* !CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +static inline bool prot_guest_has(unsigned int attr) { return false; }
> +
> +#endif	/* CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* _PROTECTED_GUEST_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
