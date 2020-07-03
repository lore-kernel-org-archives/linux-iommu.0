Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ECEC433DF
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:21:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC69208E4
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLAgdC6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC69208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C2FD2204E1;
	Fri,  3 Jul 2020 16:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQ-VCMshQAwL; Fri,  3 Jul 2020 16:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 26321203F1;
	Fri,  3 Jul 2020 16:21:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 075BBC0888;
	Fri,  3 Jul 2020 16:21:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8ACFC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6FAE203F1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7sQUciKVXzs for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 16:21:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 99B61204E1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:21:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 330B020870;
 Fri,  3 Jul 2020 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593793302;
 bh=NzfhRf3soxj5TQfIjjCSrbgU2QN4oP6jlNZFAvHuZOU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qLAgdC6ezL1L+Qj1hDr43/Lc0qG1m/WMRQEdKTPT7BAp4ExPpbZ46FN13dokZWmxE
 sqyNjMCz2MY0H0YP/cteR63+lSK1gnO68F5AWXmCutMVWi3VDZZp3whB24iM/exovw
 sRW/fvDrWluUp3xPS/smfAiSCWFZjCiJiprq9ptg=
Date: Fri, 3 Jul 2020 17:21:38 +0100
From: Will Deacon <will@kernel.org>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users
 in sysfs
Message-ID: <20200703162137.GA19780@willie-the-truck>
References: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Sat, May 30, 2020 at 09:15:05PM +1200, Barry Song wrote:
> As tests show the latency of dma_unmap can increase dramatically while
> calling them cross NUMA nodes, especially cross CPU packages, eg.
> 300ns vs 800ns while waiting for the completion of CMD_SYNC in an
> empty command queue. The large latency causing by remote node will
> in turn make contention of the command queue more serious, and enlarge
> the latency of DMA users within local NUMA nodes.
> 
> Users might intend to enforce NUMA locality with the consideration of
> the position of SMMU. The patch provides minor benefit by presenting
> this information to users directly, as they might want to know it without
> checking hardware spec at all.

I don't think that's a very good reason to expose things to userspace.
I know sysfs shouldn't be treated as ABI, but the grim reality is that
once somebody relies on this stuff then we can't change it, so I'd
rather avoid exposing it unless it's absolutely necessary.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
