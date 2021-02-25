Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20444C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 22:17:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB5464F2C
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 22:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB5464F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82ABB84246;
	Thu, 25 Feb 2021 22:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3nfoyXc4k-d; Thu, 25 Feb 2021 22:17:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CAF984241;
	Thu, 25 Feb 2021 22:17:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41D50C000A;
	Thu, 25 Feb 2021 22:17:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF13AC0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 22:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9D9F43326
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 22:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sas9yvMqb8sF for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 22:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A23C43324
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 22:17:19 +0000 (UTC)
IronPort-SDR: /8jrOjHh7U/PgQIgoHEp0K/yIVpmOnLcpQxKR8yLl2B52JtEhs25P3qHHdpagqqtcySxEOtqiX
 bttFycil9gog==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="205211217"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="205211217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 14:17:18 -0800
IronPort-SDR: HBKSHiLe0MtfvnRN4zT3jI0f0Rqf5KuNeB1ORFZDVA8T397xDurDMDhDQchjk4a8veYMxlqzmu
 CNop4lCWAW1w==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="404589780"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 14:17:18 -0800
Date: Thu, 25 Feb 2021 22:17:11 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
 <YDYoL/zZ9YaGgwSV@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YDYoL/zZ9YaGgwSV@myrica>
Cc: Ashok Raj <ashok.raj@intel.com>, zhangfei.gao@foxmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Jacob Jun Pan <jacob.jun.pan@intel.com>
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

Hi, Jean,

On Wed, Feb 24, 2021 at 11:19:27AM +0100, Jean-Philippe Brucker wrote:
> Hi Fenghua,
> 
> [Trimmed the Cc list]
> 
> On Mon, Jul 13, 2020 at 04:48:03PM -0700, Fenghua Yu wrote:
> > When a new mm is created, its PASID should be cleared, i.e. the PASID is
> > initialized to its init state 0 on both ARM and X86.
> 
> I just noticed this patch was dropped in v7, and am wondering whether we
> could still upstream it. Does x86 need a child with a new address space
> (!CLONE_VM) to inherit the PASID of the parent?  That doesn't make much
> sense with regard to IOMMU structures - same PASID indexing multiple PGDs?

You are right: x86 should clear mm->pasid when a new mm is created.
This patch somehow is losted:(

> 
> Currently iommu_sva_alloc_pasid() assumes mm->pasid is always initialized
> to 0 and fails on forked tasks. I'm trying to figure out how to fix this.
> Could we clear the pasid on fork or does it break the x86 model?

x86 calls ioasid_alloc() instead of iommu_sva_alloc_pasid(). So
functionality is not a problem without this patch on x86. But I think
we do need to have this patch in the kernel because PASID is per addr
space and two addr spaces shouldn't have the same PASID.

Who will accept this patch?

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
