Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD30C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B168233A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B168233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 08852DA1;
	Fri, 23 Aug 2019 08:12:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28038CC9
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 08:12:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A9E767F
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 08:12:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 46A6D1C7; Fri, 23 Aug 2019 10:12:37 +0200 (CEST)
Date: Fri, 23 Aug 2019 10:12:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
	Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 00/11 v3] Cleanup IOMMU passthrough setting (and disable
	IOMMU Passthrough when SME is active)
Message-ID: <20190823081236.GE30332@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Mon, Aug 19, 2019 at 03:22:45PM +0200, Joerg Roedel wrote:
> Joerg Roedel (11):
>   iommu: Remember when default domain type was set on kernel command line
>   iommu: Add helpers to set/get default domain type
>   iommu: Use Functions to set default domain type in iommu_set_def_domain_type()
>   iommu/amd: Request passthrough mode from IOMMU core
>   iommu/vt-d: Request passthrough mode from IOMMU core
>   x86/dma: Get rid of iommu_pass_through
>   ia64: Get rid of iommu_pass_through
>   iommu: Print default domain type on boot
>   iommu: Set default domain type at runtime
>   iommu: Disable passthrough mode when SME is active
>   Documentation: Update Documentation for iommu.passthrough
> 
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/ia64/include/asm/iommu.h                   |  2 -
>  arch/ia64/kernel/pci-dma.c                      |  2 -
>  arch/x86/include/asm/iommu.h                    |  1 -
>  arch/x86/kernel/pci-dma.c                       | 20 +-----
>  drivers/iommu/amd_iommu.c                       |  6 +-
>  drivers/iommu/intel-iommu.c                     |  2 +-
>  drivers/iommu/iommu.c                           | 93 +++++++++++++++++++++++--
>  include/linux/iommu.h                           | 16 +++++
>  9 files changed, 110 insertions(+), 34 deletions(-)

Applied.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
