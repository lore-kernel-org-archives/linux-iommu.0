Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD141C3A5A3
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40F22CE3
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40F22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 48754D1A;
	Fri, 23 Aug 2019 08:23:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 306DFD12
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 08:23:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D872CE6
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 08:23:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 4823A1C7; Fri, 23 Aug 2019 10:23:07 +0200 (CEST)
Date: Fri, 23 Aug 2019 10:23:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: remove global page flush support
Message-ID: <20190823082307.GF30332@8bytes.org>
References: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Raj Ashok <ashok.raj@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Jacob,

On Tue, Aug 20, 2019 at 02:21:08PM -0700, Jacob Pan wrote:
> Global pages support is removed from VT-d spec 3.0. Since global pages G
> flag only affects first-level paging structures and because DMA request
> with PASID are only supported by VT-d spec. 3.0 and onward, we can
> safely remove global pages support.
> 
> For kernel shared virtual address IOTLB invalidation, PASID
> granularity and page selective within PASID will be used. There is
> no global granularity supported. Without this fix, IOTLB invalidation
> will cause invalid descriptor error in the queued invalidation (QI)
> interface.
> 
> Reported-by:   Sanjay K Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 36 +++++++++++++++---------------------
>  include/linux/intel-iommu.h |  3 ---
>  2 files changed, 15 insertions(+), 24 deletions(-)

Does not cleanly apply to v5.3-rc5, can you please rebase it and
re-send? Also, is this v5.3 stuff (in that case please add a Fixes tag)
or can it wait for v5.4?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
