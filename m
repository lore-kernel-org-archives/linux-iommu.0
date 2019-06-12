Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049CC31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010AF206E0
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010AF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85D8817AB;
	Wed, 12 Jun 2019 08:38:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2E50F179D
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 08:37:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C6B49E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 08:37:28 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 2237A642; Wed, 12 Jun 2019 10:37:27 +0200 (CEST)
Date: Wed, 12 Jun 2019 10:37:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fixes and cleanups for linux-next
Message-ID: <20190612083725.GE17505@8bytes.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, cai@lca.pw,
	jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 12, 2019 at 08:28:44AM +0800, Lu Baolu wrote:
> Lu Baolu (6):
>   iommu/vt-d: Don't return error when device gets right domain
>   iommu/vt-d: Set domain type for a private domain
>   iommu/vt-d: Don't enable iommu's which have been ignored
>   iommu/vt-d: Allow DMA domain attaching to rmrr locked device
>   iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
>   iommu/vt-d: Consolidate domain_init() to avoid duplication

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
