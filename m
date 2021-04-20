Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74876C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 10:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9649613B0
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 10:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9649613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 650A560827;
	Tue, 20 Apr 2021 10:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9DZyMPh9bes; Tue, 20 Apr 2021 10:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67F116082E;
	Tue, 20 Apr 2021 10:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 522A3C000F;
	Tue, 20 Apr 2021 10:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0BC4C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE4DC606CF
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4b83gdmaBobc for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 10:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 837E86083B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:22:05 +0000 (UTC)
IronPort-SDR: AaoSK29XWgJQNFHggQOit2FMwIXZuNNpnxVQfzl2jGlQleqW+fzh5wq4CzdJT/BQ4MYr2DuXy3
 lEYrwZxzhmXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="192294529"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="192294529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 03:22:05 -0700
IronPort-SDR: yirMUWERDYce0xR6aBQqunuWlhSFnIXRlQU5SjyFCuQxBxKWw0hY0vuU+H7C/KWlycCWW6xAKN
 GJqlhKnS51Ow==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="463066320"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 03:22:01 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lYnW2-005iGd-0V; Tue, 20 Apr 2021 13:21:58 +0300
Date: Tue, 20 Apr 2021 13:21:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bingbu Cao <bingbu.cao@intel.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <YH6rRUXyNdC6DDzQ@smile.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: will@kernel.org, grundler@chromium.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, rajatja@google.com,
 dwmw2@infradead.org, bingbu.cao@linux.intel.com
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

On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
> The IPU driver allocates its own page table that is not mapped
> via the DMA, and thus the Intel IOMMU driver blocks access giving
> this error:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
>       fault addr 76406000 [fault reason 06] PTE Read access is not set
> 
> As IPU is not an external facing device which is not risky, so use
> IOMMU passthrough mode for Intel IPUs.

I'm wondering if IPU MMU should be described properly in the DMAR table.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
