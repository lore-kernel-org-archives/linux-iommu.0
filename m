Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B807DC282CE
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939DF2184E
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939DF2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3726B257D;
	Thu, 11 Apr 2019 12:53:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D5782572
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 12:52:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C8E68F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 12:52:51 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 8B7F142D; Thu, 11 Apr 2019 14:52:49 +0200 (CEST)
Date: Thu, 11 Apr 2019 14:52:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 0/3] IOMMU: Tegra SMMU fixes
Message-ID: <20190411125242.GA4518@8bytes.org>
References: <20190306225009.3391-1-digetx@gmail.com>
	<99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
	Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>
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
Message-ID: <20190411125243.SeVUH_2z5Fw13XMAA_dzcBt2DhFzwyE2vqaaa7beJgA@z>

On Wed, Apr 03, 2019 at 08:14:18AM +0300, Dmitry Osipenko wrote:

> Joerg, could you please apply this series?

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
