Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA851C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:21:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A5420709
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A5420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 468792E672;
	Fri, 15 May 2020 12:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H63twWvx7sfA; Fri, 15 May 2020 12:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7FAFB203F7;
	Fri, 15 May 2020 12:21:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E853C0178;
	Fri, 15 May 2020 12:21:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2FECC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DF95F203F7
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfpB0ybGxvkP for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 12:21:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 7B1E62E8B0
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:21:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DEA45379; Fri, 15 May 2020 14:21:05 +0200 (CEST)
Date: Fri, 15 May 2020 14:21:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Message-ID: <20200515122104.GV18353@8bytes.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515104359.1178606-3-jean-philippe@linaro.org>
 <20200515120150.GU18353@8bytes.org>
 <20200515121124.GA784024@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515121124.GA784024@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alex.williamson@redhat.com, ashok.raj@intel.com, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, iommu@lists.linux-foundation.org, bhelgaas@google.com,
 will@kernel.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, May 15, 2020 at 02:11:24PM +0200, Jean-Philippe Brucker wrote:
> On Fri, May 15, 2020 at 02:01:50PM +0200, Joerg Roedel wrote:
> > Hmm, but per patch 1, pci_ats_supported() does not check
> > pci_ats_disabled(), or do I miss something?
> 
> The commit message isn't clear. pci_ats_init() sets dev->ats_cap only if
> !pci_ats_disabled(), so checking dev->ats_cap in pci_ats_supported()
> takes pci_ats_disabled() into account.

Right, so the patch is fine:

Reviewed-by: Joerg Roedel <jroedel@suse.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
