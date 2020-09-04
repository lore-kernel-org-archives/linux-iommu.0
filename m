Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F99C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA88D206D4
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA88D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6DA9487517;
	Fri,  4 Sep 2020 10:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4N7bQSykrs5; Fri,  4 Sep 2020 10:03:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C25D487516;
	Fri,  4 Sep 2020 10:03:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD8FC0052;
	Fri,  4 Sep 2020 10:03:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6CEAC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 98459204D0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NbuZ039+Kj09 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 10:03:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id BB97920407
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:03:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1952D3D5; Fri,  4 Sep 2020 12:03:42 +0200 (CEST)
Date: Fri, 4 Sep 2020 12:03:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu api
Message-ID: <20200904100340.GT6714@8bytes.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org
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

Hey Tom,

On Thu, Sep 03, 2020 at 09:18:32PM +0100, Tom Murphy wrote:
> Tom Murphy (5):
>   iommu: Handle freelists when using deferred flushing in iommu drivers
>   iommu: Add iommu_dma_free_cpu_cached_iovas function
>   iommu: allow the dma-iommu api to use bounce buffers
>   iommu/vt-d: Convert intel iommu driver to the iommu ops
>   DO NOT MERGE: iommu: disable list appending in dma-iommu

Thanks for your continued work on this. As discussed in the
microconference, Lu Baolu will take this over now and we can hopefully
merge it soon.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
