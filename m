Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A56C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 14:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E361404B2;
	Tue, 14 Dec 2021 14:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TpO6jloVJ5Q; Tue, 14 Dec 2021 14:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9A7B400DA;
	Tue, 14 Dec 2021 14:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFEB7C002F;
	Tue, 14 Dec 2021 14:04:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C35C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0148640261
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKIkjXZs0vHN for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E7824023E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:04:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 53482B819B8;
 Tue, 14 Dec 2021 14:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B52C34609;
 Tue, 14 Dec 2021 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639490684;
 bh=R2yYzdfAUMdXI+rHDFOCMcqQHOwzK5dqvhI3qK51N7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I9kugNlFqqdj9kOOEbtHWUckO09tFTPQHhnNjKszX0GgBgf31pU2X2swpO2CbNej2
 EQz7XTWDmGrs2MdvvmjnV6cjUVhHRolhK9t+Xr4xs9P06ex60uLDDxtliedWMAI+C2
 jGSicEHIuDw5DMve8HZYsQt/16NDKHU5TfMeQN8gGjewqVZBgtM46YCHxninb3lt70
 xH8+7M+qzD0FFwKHVB8Eqs2mndC+KpE4YzTpKCn0aAfgxLwrta5hMpQmfzni4G4qy3
 jqNzZ3KzpZqJ9hlYHNSTlLcchT3memO/an5L7TpOs6UkRO5DVlqqVxUZ/eiA0fgdE9
 icumL5pWvAeUQ==
From: Will Deacon <will@kernel.org>
To: robh+dt@kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 0/3] perf/smmuv3: Support devicetree
Date: Tue, 14 Dec 2021 14:04:33 +0000
Message-Id: <163948379278.3583372.10472496054779146145.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211117144844.241072-1-jean-philippe@linaro.org>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

On Wed, 17 Nov 2021 14:48:42 +0000, Jean-Philippe Brucker wrote:
> Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
> Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
> multiple independent PMCGs, for example one for the Translation Control
> Unit (TCU) and one per Translation Buffer Unit (TBU).
> 
> Since v1 [1]:
> * Fixed warnings in the binding doc
> * Removed hip08 support
> * Merged Robin's version. I took the liberty of splitting the driver
>   patch into 2 and 3. One fix in patch 3, and whitespace changes (the
>   driver uses spaces instead of tabs to align #define values, which I
>   was going to fix but actually seems more common across the tree.)
> 
> [...]

Applied to arm64 (for-next/perf-smmu), thanks!

[1/3] dt-bindings: Add Arm SMMUv3 PMCG binding
      https://git.kernel.org/arm64/c/2704e7594383
[2/3] perf/smmuv3: Add devicetree support
      https://git.kernel.org/arm64/c/3f7be4356176
[3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID registers
      https://git.kernel.org/arm64/c/df457ca973fe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
