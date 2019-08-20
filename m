Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24221C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 05:46:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFDA214DA
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 05:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFDA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A49C2DA7;
	Tue, 20 Aug 2019 05:46:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 33E04D97
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 05:46:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9F56587
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 05:46:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6944C68B02; Tue, 20 Aug 2019 07:46:05 +0200 (CEST)
Date: Tue, 20 Aug 2019 07:46:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
Message-ID: <20190820054605.GA27501@lst.de>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
	<0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
	<20190820012415.GA21178@lst.de>
	<a69cce68-8c41-2030-b011-cdfacfeae421@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a69cce68-8c41-2030-b011-cdfacfeae421@gmx.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	iommu@lists.linux-foundation.org, Ian Jackson <ian.jackson@citrix.com>,
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 20, 2019 at 07:43:52AM +0200, Stefan Wahren wrote:
> i applied this patch and it fixes the build issue i reported before. But
> this seems to reveal another build issue in drivers/firmware/qcom_scm.c:

Yes, I rean into this as well until I disabled the qcom platform.  But
this is in no way related to the swiotlb changes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
