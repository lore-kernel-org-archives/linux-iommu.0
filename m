Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33731C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 15:32:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058492086A
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 15:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058492086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D15C7DBB;
	Fri,  9 Aug 2019 15:32:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3B922DA6
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 15:32:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C40DE82D
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 15:32:37 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 3D4F23D0; Fri,  9 Aug 2019 17:32:36 +0200 (CEST)
Date: Fri, 9 Aug 2019 17:32:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] iommu/dma: Handle SG length overflow better
Message-ID: <20190809153234.GC12930@8bytes.org>
References: <fbdbb8c0e550ae559ea3eedc1fea084c0111f202.1564418681.git.robin.murphy@arm.com>
	<20190806152529.GB1198@8bytes.org>
	<166ef834-c10e-5f94-ee89-6a0caedf323d@arm.com>
	<20190807011150.GA8938@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190807011150.GA8938@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Aug 06, 2019 at 06:11:51PM -0700, Nicolin Chen wrote:
> Well..it was triggered in our downstream test that's supposed to
> cover large size (> 4G) corner case, so I don't feel it's "easy"
> but our test case was running with 4.14 kernel so I also feel it
> might be a good idea to Cc stable kernel even if we postpone the
> patch during the merge window. I'll personally be fine with any
> decision though -- if no one else cares that much, I'll backport
> to our downstream 4.14 on my own.

Okay, decided to apply it for v5.3.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
