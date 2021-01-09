Return-Path: <SRS0=vLlZ=GM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CCC433E0
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 01:50:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020B123A9B
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020B123A9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A322C8761E;
	Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSRu+doOHsQm; Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1266C8741C;
	Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0209DC088B;
	Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE37C013A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6193A87458
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AdubhIYh8d3Q for <iommu@lists.linux-foundation.org>;
 Sat,  9 Jan 2021 01:50:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8BB9E8741C
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610157044; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ghU2g/Iny5eN7E5fSfRXmvip4hkqKRjVxmdD1byGeNg=;
 b=QHWUQJJXBJ9FfiO5oYiYTr6x5JNY+epCVbuSa8tX+NzkNYDXT9zPJ7BylQjz+DGlUPE9orle
 /MLh3gyPD6D0n5gzO1+84F7zbQjIftWcctr/dFIA907JHQ6bRLfTE7cCJglI9A6+FPEOnOyg
 ETSOe9yllTBThOBI8krx4Lx016U=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ff90bf34dcca1247515d1a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Jan 2021 01:50:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8C430C433CA; Sat,  9 Jan 2021 01:50:42 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 50452C433CA;
 Sat,  9 Jan 2021 01:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50452C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH 0/5] Optimize iommu_map_sg() performance
Date: Fri,  8 Jan 2021 17:50:26 -0800
Message-Id: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The iommu_map_sg() code currently iterates through the given
scatter-gather list, and in the worst case, invokes iommu_map()
for each element in the scatter-gather list, which calls into
the IOMMU driver through an indirect call. For an IOMMU driver
that uses a format supported by the io-pgtable code, the IOMMU
driver will then call into the io-pgtable code to map the chunk.

Jumping between the IOMMU core code, the IOMMU driver, and the
io-pgtable code and back for each element in a scatter-gather list
is not efficient.

Instead, add a map_sg() hook in both the IOMMU driver ops and the
io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
map_sg() hook with the entire scatter-gather list, which can call
into the io-pgtable map_sg() hook, which can process the entire
scatter-gather list, signficantly reducing the number of indirect
calls, and jumps between these layers, boosting performance.

On a system that uses the ARM SMMU driver, and the ARM LPAE format,
the current implementation of iommu_map_sg() yields the following
latencies for mapping scatter-gather lists of various sizes. These
latencies are calculated by repeating the mapping operation 10 times:

    size        iommu_map_sg latency
      4K            0.624 us
     64K            9.468 us
      1M          122.557 us
      2M          239.807 us
     12M         1435.979 us
     24M         2884.968 us
     32M         3832.979 us

On the same system, the proposed modifications yield the following
results:

    size        iommu_map_sg latency
      4K            3.645 us
     64K            4.198 us
      1M           11.010 us
      2M           17.125 us
     12M           82.416 us
     24M          158.677 us
     32M          210.468 us

The procedure for collecting the iommu_map_sg latencies is
the same in both experiments. Clearly, reducing the jumps
between the different layers in the IOMMU code offers a
signficant performance boost in iommu_map_sg() latency.

Thanks,
Isaac

Isaac J. Manjarres (5):
  iommu/io-pgtable: Introduce map_sg() as a page table op
  iommu/io-pgtable-arm: Hook up map_sg()
  iommu/io-pgtable-arm-v7s: Hook up map_sg()
  iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
  iommu/arm-smmu: Hook up map_sg()

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c    | 90 +++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        | 86 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c                 | 25 ++++++++--
 include/linux/io-pgtable.h            |  6 +++
 include/linux/iommu.h                 | 13 +++++
 6 files changed, 234 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
