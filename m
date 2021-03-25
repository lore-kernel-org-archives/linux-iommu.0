Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6753C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:54:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6498B619AB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6498B619AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D3A060B22;
	Thu, 25 Mar 2021 17:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ag6r7RfP4iyb; Thu, 25 Mar 2021 17:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13FB060633;
	Thu, 25 Mar 2021 17:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9BAEC000D;
	Thu, 25 Mar 2021 17:54:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39ECCC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2723184A41
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWCAHKwxuzAi for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 17:53:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7987847EF
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:53:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 005376192E;
 Thu, 25 Mar 2021 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616694839;
 bh=p9Fw2VLMXBm9WgC0jrRce9sCideLVwWWxngLieDXLLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ggTDTbr92KwP/mo+C2q0J3WFddw0H+IKJWQBbaFFSjZ5oY8Dmu4wHRa9QVpWJLR2M
 O3/vjS5TtRUHfnaRhuhH/rNtOQTOO2a2fJIzlzll1Y5bQ5WFqn1+hqZKhytwGgCoCO
 TNj7hpKX3eWJHHdHVJDt6rUNRefcyfO8Cti2AkVjjcdUqTt1NWAtxMoBMCloPgTEpo
 vzkR5v1+RT5byZy9E8NSsabT0RHHcbeKAzNgxrRERVo7GSEt5GxYjDpuN5k6vnGkg2
 I+luU5xrMQsGQiAvflIQDX0P5uf5qLkgkPJw/RrXiCRCGzyFk9yZgbzmMXf9fEqWQf
 5SFPdUDzKptyg==
Date: Thu, 25 Mar 2021 17:53:54 +0000
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
Message-ID: <20210325175354.GE15504@willie-the-truck>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
> offlined.
> 
> Let's move it to core code, so everyone can take advantage.
> 
> Also throw in a patch to stop exporting free_iova_fast().
> 
> Differences to v1:
> - Add RB tags (thanks!)
> - Add patch to stop exporting free_iova_fast()
> - Drop patch to correct comment
> - Add patch to delete iommu_dma_free_cpu_cached_iovas() and associated
>   changes
> 
> John Garry (4):
>   iova: Add CPU hotplug handler to flush rcaches
>   iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>   iommu: Delete iommu_dma_free_cpu_cached_iovas()
>   iommu: Stop exporting free_iova_fast()

Looks like this is all set for 5.13, so hopefully Joerg can stick it in
-next for a bit more exposure.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
