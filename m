Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB68C432C2
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 09:41:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239622146E
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 09:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239622146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E8483C74;
	Tue, 24 Sep 2019 09:41:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 18A71C11
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 09:41:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A2E328B7
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 09:41:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id EE14C3A2; Tue, 24 Sep 2019 11:41:06 +0200 (CEST)
Date: Tue, 24 Sep 2019 11:41:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH 1/5] iommu/amd: Wait for completion of IOTLB flush in
	attach_device
Message-ID: <20190924094105.GB11453@8bytes.org>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
	<1568137765-20278-2-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568137765-20278-2-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 10, 2019 at 07:49:21PM +0200, Filippo Sironi wrote:
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
>  drivers/iommu/amd_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied this one with a commit message and a fixes tag, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
