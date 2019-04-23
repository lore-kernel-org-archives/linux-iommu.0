Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E148C10F14
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC243204EC
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC243204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C46D4102A;
	Tue, 23 Apr 2019 11:21:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95434101A
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 11:21:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 562F882E
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 11:21:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E91D374;
	Tue, 23 Apr 2019 04:21:43 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710193F557;
	Tue, 23 Apr 2019 04:21:40 -0700 (PDT)
Date: Tue, 23 Apr 2019 12:21:38 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Message-ID: <20190423112138.GC3439@fuggles.cambridge.arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	bhelgaas@google.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Message-ID: <20190423112138.c9mfRJYWsDawyJ-wl-OkMwb3r_7Lz8mW0_xIstLQhfw@z>

On Wed, Apr 17, 2019 at 07:24:39PM +0100, Jean-Philippe Brucker wrote:
> This series enables PCI ATS in SMMUv3. Changes since v2 [1]:
> 
> * Fix build failure when building arm-smmu-v3 without CONFIG_PCI
>   Patches 1 and 2 are new.
> 
> * Only enable ATS if the root complex supports it. For the moment, only
>   IORT provides this information. I have patches for devicetree but
>   they are less mature and I'd rather make it a separate series.
> 
> * Tried to address most comments. I'll see if I can improve the firmware
>   code when adding devicetree support (see [2]).
> 
> Note that there is a small conflict with the SVA API. This series
> applies on top of Joerg's api-features branch for v5.2.

I'll pick this up via the SMMU queue, since the conflict with api-features
is trivial to resolve.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
