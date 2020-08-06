Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C4CC433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9EA23136
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3bnalY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9EA23136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D6DB8814A;
	Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyuEDZNRfoYF; Thu,  6 Aug 2020 15:54:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C485B88257;
	Thu,  6 Aug 2020 15:54:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1878C0050;
	Thu,  6 Aug 2020 15:54:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECE0C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A49388257
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jKA1w-BglalA for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:54:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BDB468814A
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:11 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id di22so28340099edb.12
 for <iommu@lists.linux-foundation.org>; Thu, 06 Aug 2020 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5pqsHiVxuyGBu/0tH+qVfNYUFXwSd1VD/tbRJZDzCuM=;
 b=N3bnalY4rOo3OwG/8j8SBbq4MZzrUjNrh90GhJxywE3YKU44SMfEOiEHoXld0c18a0
 s/Gg0aOJQ3cFcQ/Ap2KO71Kecxd1R4OxkcRaXjoPX02kMyKnrLDQZ3DYKMShLa2nP5Cv
 XRQtHmF7f7Sx5a32R++4CxkmLy03gtfaNALT9Ke5z97jBI/lYZGFnmI/UX3f0AG0wntb
 +G0GIz3tDWen7R4VpxKqXxPY9f1+5Cf3pCrvHpqhjU4Iq394/+wLAmwrW/bei6LRtlEh
 9nXemf8stZtvILHHzL7E57QCdYRAO7xmzfUQS3MB2NSG8ZQNzidIPL7KwudmWzmRKvFZ
 IuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5pqsHiVxuyGBu/0tH+qVfNYUFXwSd1VD/tbRJZDzCuM=;
 b=f14jtoCcyNdYHGnE8fI5sH2F5lA+uUxi3AnQT926ZOCZFguq7jRK7rPRzDOjoKTafK
 QZ4VN4bpzz71ePoI8zIHgqmB7p7hGdD2F0ibFG/bAsaj69ZwsdndJIB2CT4jNamqcvAN
 WPkXX3HYWQCP10Zk6hobCoS4xwQEljvH0F563Wy9rLbij0s86Ytj1emygAmLqwZIf6Xj
 wBkk9tYdn+i8ABdfFRlK3ImEwrXHtuepXxb9KA1+PRv6AHr8ifQTII/1bP6cnGsSqXQj
 M0Om1rP6usRGBVrKW8fwYGBT9yo884W/iJnnYfJrMO4xs3H0wPqJ556SJtXwZan0FcS3
 GWtg==
X-Gm-Message-State: AOAM5330krW+YD8MOJcoacG0kdPY+fMGtucJPXrKS5+XclhU7/qX4yZS
 aea/5Q8FXEqRoBI5w8yFtdI=
X-Google-Smtp-Source: ABdhPJxbkk+OQPQaekYiTtv/1k6LUn7kBiyDWdKxOIUCH6YCl/8AvW5AiX9ILJ+dfF4n7DH4+OLu9A==
X-Received: by 2002:aa7:dbd9:: with SMTP id v25mr4827342edt.137.1596729250273; 
 Thu, 06 Aug 2020 08:54:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id p13sm3660700edq.81.2020.08.06.08.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:54:07 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] iommu/tegra-smmu: Set IOMMU group name
Date: Thu,  6 Aug 2020 17:54:02 +0200
Message-Id: <20200806155404.3936074-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806155404.3936074-1-thierry.reding@gmail.com>
References: <20200806155404.3936074-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>
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

From: Thierry Reding <treding@nvidia.com>

Set the name of static IOMMU groups to help with debugging.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..1ffdafe892d9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -847,6 +847,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 		return NULL;
 	}
 
+	iommu_group_set_name(group->group, soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
