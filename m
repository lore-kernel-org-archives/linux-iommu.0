Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8A9C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C9260BCA;
	Tue, 14 Dec 2021 15:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PK0XempGEHn; Tue, 14 Dec 2021 15:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D55560761;
	Tue, 14 Dec 2021 15:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 014BAC002F;
	Tue, 14 Dec 2021 15:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24B4BC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 040A2814AB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aefWymT0G4tv for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A2BB8136E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9FAF0B81A77;
 Tue, 14 Dec 2021 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC7C34608;
 Tue, 14 Dec 2021 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639495106;
 bh=t/ioqHHdb/Ss2Yo/QWbW8oF8j/7s1fB4C/FeJDG9SlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E8ZsejB9aBcTlt03eyImEu3Q1qg23EcB85+Y5+380PQHuHkcOySIUzqYn9zunAtVr
 aBy08BL2lbqv5EFot4ykRIjNxlNvdDtOwf6RR55hHjgClCaTpYAxTWt6qRU5cctPiJ
 pdJU6sYIbqWkpAsB/dVTcQ3vLA39q+ACKeOe47hf61n3e2xNXxK9ioj7A1bevFte2W
 9CCKVePmBquGgZuOmTijgQqjvfPcg4D/2mtyPHk8TFS/N25hiBIDtnyHic4Yol/m6P
 59d+FWX3lT/XqSwZLFRxi002dNBVb7h1aqlgmxDXQhRVtaZBDHumHuY927E9G+Nnc2
 hEXtIe702jktQ==
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Heidelberg <david@ixit.cz>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Date: Tue, 14 Dec 2021 15:18:11 +0000
Message-Id: <163949295158.2865133.9086863880936702882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020231701.278846-1-david@ixit.cz>
References: <20211020231701.278846-1-david@ixit.cz>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
 ~okias/devicetree@lists.sr.ht, linux-arm-kernel@lists.infradead.org
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

On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> Add missing compatible for the SDX55 SoC.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
      https://git.kernel.org/will/c/ae377d342006

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
