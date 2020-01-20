Return-Path: <SRS0=4rPt=3J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F7C2D0DB
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 11:02:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6262207FF
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 11:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6262207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A9558535F;
	Mon, 20 Jan 2020 11:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N71GDLc4u0JD; Mon, 20 Jan 2020 11:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB79F8526D;
	Mon, 20 Jan 2020 11:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 963B6C0178;
	Mon, 20 Jan 2020 11:02:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D07BEC0174
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 11:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC9318594B
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 11:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N13ixeDMsZEj for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jan 2020 11:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 76CA883DD9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 11:02:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA5630E;
 Mon, 20 Jan 2020 03:02:23 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B50A3F68E;
 Mon, 20 Jan 2020 03:02:22 -0800 (PST)
Date: Mon, 20 Jan 2020 11:02:20 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/7] Clean up VMD DMA Map Ops
Message-ID: <20200120110220.GB17267@e121166-lin.cambridge.arm.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
 <20200119222523.GA4890@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200119222523.GA4890@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jon Derrick <jonathan.derrick@intel.com>
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

On Sun, Jan 19, 2020 at 11:25:23PM +0100, Christoph Hellwig wrote:
> This series looks good to me (modulo the one minor nitpick which isn't
> all that important):
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Bjorn,

are you picking this up ? I can merge it too but since it is mostly
x86 changes I reckon you should take it, I acked patch (6) to that
end.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
