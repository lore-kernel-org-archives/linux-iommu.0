Return-Path: <SRS0=0DsW=3G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C120DC33CB1
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 10:00:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972442073A
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 10:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972442073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5DE682040C;
	Fri, 17 Jan 2020 10:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JgvRRf6HlHq; Fri, 17 Jan 2020 10:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8BDB82046C;
	Fri, 17 Jan 2020 10:00:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80FE5C1D81;
	Fri, 17 Jan 2020 10:00:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88649C077D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 10:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 76F9E863FD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 10:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVB6UZmXXaKq for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jan 2020 09:59:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8759085B29
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 09:59:58 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AA481327; Fri, 17 Jan 2020 10:59:55 +0100 (CET)
Date: Fri, 17 Jan 2020 10:59:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON_ONCE()
Message-ID: <20200117095953.GB15760@8bytes.org>
References: <20200116015236.4458-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200116015236.4458-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, kevin.tian@intel.com, ashok.raj@intel.com,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

On Thu, Jan 16, 2020 at 09:52:36AM +0800, Lu Baolu wrote:
> Address field in device TLB invalidation descriptor is qualified
> by the S field. If S field is zero, a single page at page address
> specified by address [63:12] is requested to be invalidated. If S
> field is set, the least significant bit in the address field with
> value 0b (say bit N) indicates the invalidation address range. The
> spec doesn't require the address [N - 1, 0] to be cleared, hence
> remove the unnecessary WARN_ON_ONCE().
> 
> Otherwise, the caller might set "mask = MAX_AGAW_PFN_WIDTH" in order
> to invalidating all the cached mappings on an endpoint, and below
> overflow error will be triggered.
> 
> [...]
> UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1354:3
> shift exponent 64 is too large for 64-bit type 'long long unsigned int'
> [...]
> 
> Reported-and-tested-by: Frank <fgndev@posteo.de>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Does this need a Fixes and/or stable tag?


Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
