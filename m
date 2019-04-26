Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6042C43219
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:52:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D50206A3
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D50206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8583027E0;
	Fri, 26 Apr 2019 13:52:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FE0027D5
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:50:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCB2C786
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:50:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 3A6247E3; Fri, 26 Apr 2019 15:50:13 +0200 (CEST)
Date: Fri, 26 Apr 2019 15:50:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.2
Message-ID: <20190426135011.GF24576@8bytes.org>
References: <20190424115252.GB14829@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424115252.GB14829@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: marc.w.gonzalez@free.fr, jean-philippe.brucker@arm.com,
	dianders@chromium.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190426135011.ZT34hclieRxhG8euXbhnNMg14JHxk5LRWqY84r6oOKQ@z>

On Wed, Apr 24, 2019 at 12:52:52PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, thanks Will.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
