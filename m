Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9653EC33C8C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:03:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EFC2075A
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EFC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 038FC836B2;
	Tue,  7 Jan 2020 13:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azmG96Z35k9z; Tue,  7 Jan 2020 13:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 923A7834D2;
	Tue,  7 Jan 2020 13:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83CC3C1D82;
	Tue,  7 Jan 2020 13:03:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 123EFC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F020B83500
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0gxjiGSbB9O for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 13:03:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F5CE834D2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:03:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8A03F485; Tue,  7 Jan 2020 14:03:37 +0100 (CET)
Date: Tue, 7 Jan 2020 14:03:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] iommu/vt-d fix adding non-PCI devices to Intel IOMMU
Message-ID: <20200107130331.GA30567@8bytes.org>
References: <b47f83548d855ac920ad06b0ff78b877fa4f5189.1577404477.git.ps@pks.im>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b47f83548d855ac920ad06b0ff78b877fa4f5189.1577404477.git.ps@pks.im>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Dec 27, 2019 at 12:56:18AM +0100, Patrick Steinhardt wrote:
> 
> I've recently spotted above warning in v5.5-rc3. The attached fix
> is rather intended as a discussion starter -- it's quite likely
> to be wrong as I ain't got much of a clue about the IOMMU
> subsystem.
> 
>  drivers/iommu/intel-iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied for v5.5.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
