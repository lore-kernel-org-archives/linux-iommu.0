Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80723C3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:08:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C550214DB
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C550214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C54908593F;
	Mon,  2 Mar 2020 15:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5ZNwNMN5t14; Mon,  2 Mar 2020 15:08:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BE7D858A6;
	Mon,  2 Mar 2020 15:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCEAC1AE2;
	Mon,  2 Mar 2020 15:08:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765C1C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 65060858A6
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcpSBvX3mzD9 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 15:08:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B7ECA8589C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:08:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A5A462AF; Mon,  2 Mar 2020 16:08:37 +0100 (CET)
Date: Mon, 2 Mar 2020 16:08:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH V2 3/5] iommu: Add support to change default domain of an
 iommu_group
Message-ID: <20200302150833.GA6540@8bytes.org>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hello Sai, Baolu,

On Sun, Feb 16, 2020 at 01:57:26PM -0800, Sai Praneeth Prakhya wrote:
> Hence it will be helpful if there is some way to change the default
> domain of a B:D.F dynamically. Since, linux iommu subsystem prefers to
> deal at iommu_group level instead of B:D.F level, it might be helpful
> if there is some way to change the default domain of a *iommu_group*
> dynamically. Hence, add such support.

The question is how this plays together with the per-device private
domains in the Intel VT-d driver. I recently debugged an issue there and
I think there are more. The overall code for this seems to be pretty
fragile, so I had the idea to make the private default domains more
general.

IOMMU default domains don't necessarily need to stick to the iommu-group
granularity, because the default domain is used by in-kernel drivers
only, and the kernel trusts itself.

So my idea was to make the private-domain concept of the VT-d driver
more generic and move it to the iommu core code. With that we can
configure real per-device default domain types and don't have the race
condition with driver probing when changing the default domain of
multiple devices. We have to limit the ability to change default domain
types to devices with no PCI aliases, but that should not be a problem
for the intended use-case.

What do you think?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
