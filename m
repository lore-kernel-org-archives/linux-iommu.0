Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0333C33C8C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:06:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C0F2072A
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 467EF20362;
	Tue,  7 Jan 2020 13:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hN5HHgDXHtYF; Tue,  7 Jan 2020 13:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3710C20346;
	Tue,  7 Jan 2020 13:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCF0C1D82;
	Tue,  7 Jan 2020 13:06:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A35B0C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 928F484DCD
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sHgUfUh0aEG8 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 13:06:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 50EE683B2F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:06:52 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4C37F485; Tue,  7 Jan 2020 14:06:49 +0100 (CET)
Date: Tue, 7 Jan 2020 14:06:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PULL REQUEST] iommu/vt-d: patches for v5.6
Message-ID: <20200107130647.GB30567@8bytes.org>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200102001823.21976-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Thu, Jan 02, 2020 at 08:18:01AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> Below patches have been piled up for v5.6.
> 
>  - Some preparation patches for VT-d nested mode support
>    - VT-d Native Shared virtual memory cleanup and fixes
>    - Use 1st-level for IOVA translation
> 
>  - VT-d debugging and tracing
>    - Extend map_sg trace event for more information
>    - Add debugfs support to show page table internals
> 
>  - Kconfig option for the default status of scalable mode
> 
>  - Some miscellaneous cleanups.
> 
> Please consider them for the iommu/vt-d branch.

Applied patches 1-21 to the x86/vt-d branch, thanks Baolu.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
