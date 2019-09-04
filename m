Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF7C3A5A7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 09:06:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F8E22CF7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 09:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F8E22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C87D51203;
	Wed,  4 Sep 2019 09:06:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFE1011FB
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 09:05:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 66BFE7DB
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 09:05:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC445227A8A; Wed,  4 Sep 2019 11:05:48 +0200 (CEST)
Date: Wed, 4 Sep 2019 11:05:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/4] remoteproc: don't allow modular build
Message-ID: <20190904090548.GA13541@lst.de>
References: <20190902200746.16185-1-hch@lst.de>
	<20190902200746.16185-4-hch@lst.de> <20190903210739.GW6167@minitux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903210739.GW6167@minitux>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Loic Pallardy <loic.pallardy@st.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

On Tue, Sep 03, 2019 at 02:07:39PM -0700, Bjorn Andersson wrote:
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Please pick this together with the other patches.

Thanks, I've applied the series to the dma-mapping tree for 5.4.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
