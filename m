Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A8C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:43:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BB060F58
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5BB060F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D931404D0;
	Mon,  2 Aug 2021 14:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKlTa9PbMOlp; Mon,  2 Aug 2021 14:43:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5591E404E1;
	Mon,  2 Aug 2021 14:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F02EC001B;
	Mon,  2 Aug 2021 14:43:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F07D8C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2BB9404DB
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9k9arcifid8s for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 14:43:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DF16404D0
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:43:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECEF960E97;
 Mon,  2 Aug 2021 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627915404;
 bh=aM0DVf6JQLvM4JE6nhgIll57VwWvN+mFfwT4KaIBMqo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=alIhdWj5NmPdMs78zYc2kgRw8044tlXlenc0Mwo5FUvfnvNSGoQ/Zynr2jrM7IDFP
 qKwNXMYeSdd9U9UQsUjNIu+eyug6JqsvCC4F9Un3rfq2bBP+hTudcLlsF7jiJTE9nq
 5p/MRFGoTmwmonxvTe1UJSHJ7gB35rre4BaEgWV1GwWfm/OZ/5pMtHiAt85Tz7okoV
 KSeurmdRBRTJPMQl1iypfG5pejukRHjVFwiwOKQ9dCHW+nkHSWqNTEQV1/I4M2E6cV
 YClVIMDp6q6X9J4FgmEoxhweM5zZnWteJxI6vJic/WBQMsm+hpM/MOEBNSDU34bgp6
 raYNpA/W/isYg==
Date: Mon, 2 Aug 2021 15:43:20 +0100
From: Will Deacon <will@kernel.org>
To: chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/2] Implement [map/unmap]_pages callbacks for ARM SMMUV3
Message-ID: <20210802144319.GA28735@willie-the-truck>
References: <1627697831-158822-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1627697831-158822-1-git-send-email-chenxiang66@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, linuxarm@huawei.com
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

On Sat, Jul 31, 2021 at 10:17:09AM +0800, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> The series ("Optimizing iommu_[map/unmap] performance") improve the
> iommu_[map/unmap] performance. Based on the series, implement [map/unmap]_pages
> callbacks for ARM SMMUV3.
> Use tool dma_map_benchmark to test the latency of map/unmap, and it promotes
> much on it. The test result is as follows:
> t = 1(thread = 1):
>                    before opt(us)   after opt(us)
> g=1(4K size)        0.1/1.3          0.1/0.8
> g=2(8K size)        0.2/1.5          0.2/0.9
> g=4(16K size)       0.3/1.9          0.1/1.1
> g=8(32K size)       0.5/2.7          0.2/1.4
> g=16(64K size)      1.0/4.5          0.2/2.0
> g=32(128K size)     1.8/7.9          0.2/3.3
> g=64(256K size)     3.7/14.8         0.4/6.1
> g=128(512K size)    7.1/14.7         0.5/10.4
> g=256(1M size)      14.0/53.9        0.8/19.3
> g=512(2M size)      0.2/0.9          0.2/0.9
> g=1024(4M size)     0.5/1.5          0.4/1.0
> 
> t = 10(thread = 10):
>                    before opt(us)   after opt(us)
> g=1(4K size)        0.3/7.0          0.1/5.8
> g=2(8K size)        0.4/6.7          0.3/6.0
> g=4(16K size)       0.5/6.3          0.3/5.6
> g=8(32K size)       0.5/8.3          0.2/6.3
> g=16(64K size)      1.0/17.3         0.3/12.4
> g=32(128K size)     1.8/36.0         0.2/24.2
> g=64(256K size)     4.3/67.2         1.2/46.4
> g=128(512K size)    7.8/93.7         1.3/94.2
> g=256(1M size)      14.7/280.8       1.8/191.5
> g=512(2M size)      3.6/3.2          1.5/2.5
> g=1024(4M size)     2.0/3.1          1.8/2.6 
> 
> Xiang Chen (2):
>   iommu/arm-smmu-v3: Implement the unmap_pages() IOMMU driver callback
>   iommu/arm-smmu-v3: Implement the map_pages() IOMMU driver callback

For both patches:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you take these directly? They build on top of the
changes from Isaac which you have queued on your 'core' branch.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
