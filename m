Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C6C31E5B
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:16:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E40B213F2
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40B213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BEC2FE56;
	Tue, 18 Jun 2019 15:16:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 69D92E57
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:16:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3DAB831
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:15:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id CA3D04D4; Tue, 18 Jun 2019 17:15:56 +0200 (CEST)
Date: Tue, 18 Jun 2019 17:15:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] iommu: Add padding to struct iommu_fault
Message-ID: <20190618151555.GA21128@8bytes.org>
References: <20190612131143.GF21613@8bytes.org>
	<20190612175938.16428-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612175938.16428-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Wed, Jun 12, 2019 at 06:59:38PM +0100, Jean-Philippe Brucker wrote:
> Ease future extensions of struct iommu_fault_page_request and struct
> iommu_fault_unrecoverable by adding a few bytes of padding. That way, a
> new field can be added to either of these structures by simply introducing
> a new flag. To extend it after the size limit is reached, a new fault
> reporting structure will have to be negotiated with userspace.
> 
> With 56 bytes of padding, the total size of iommu_fault is 64 bytes and
> fits in a cache line on a lot of contemporary machines, while providing 16
> and 24 bytes of extension to structures iommu_fault_page_request and
> iommu_fault_unrecoverable respectively.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  include/uapi/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
