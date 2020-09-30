Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D7C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F325C207C4
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COpFGQAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75D78860C1;
	Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZDvJJAEgtxV; Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E24A386004;
	Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B99F3C0889;
	Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF45FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D65618677C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJhRIvoORo+I for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3C66786764
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id u24so5417908pgi.1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LQdI0KJeifkWmziJ1KKn/3OkC7DNIF2gUIHKqRdQ2No=;
 b=COpFGQAUJ3szg36uk+5qopcDl+hjq6PhY+7+jCoz1ihc2jigTeQyhRxgHGeL5BcDhg
 2kEKVntCA3nl+RMU046/O/2qBso/6JJua47NOu9yi/gI3TUhG8CE4mCD+MLABEV6gXho
 8EtBVmpUc0EOmjeoOjg2SM7z95mdP2zz8gi/5wQZPRDwSNE5/eNLb88zg8OHqo1N0oO4
 XHN0XTpjxG/Rfe6mEDX43ti5n5+e+Zsf/4qbVysWUXnQPT8uLj/QiLgW3xZbSiU/9bTF
 G8ouAw0zzuiN/jrH7n41AFC4Z1X1btFsUNZZvmI82Zxu0dTTorjFmCOTyWJar5krdem3
 lxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LQdI0KJeifkWmziJ1KKn/3OkC7DNIF2gUIHKqRdQ2No=;
 b=VVChj1+ndMLhQdhEYwCnJdvuxKvl6wAc2gjUeK0TzjtN/gCGEU8b5dIHiu5aqnWA+j
 q9OTbZ56UILS2r6UyMtWECZeGTYQRhDVq2KdEQUGGT7e2tTzdTzkbWRVZY/F1qlWX2hl
 KHjK6cNtqTVnMS3uuUC+jeWJheP84/19/Q5OICIwyeTmMjLWOssXGcNiX7jN/DSECXRD
 xAl9ZZr/fXnwb2G4gRIHNV4ghg1PaIiuJsL5fjskMHDAY8dbBnQ/WuQrrN6/ZEB3pywN
 IvVl8BgBH02RcJtlJUZsxyCwCP5HPO5Aoo5w+tbvw92r1aRJlGOVqTXcKzWuAZ1tatmH
 5FPQ==
X-Gm-Message-State: AOAM530jsRN6RNWOANmBg+KTas2KmecXf5QsBdeGYIADnaSpS6DvUi+Y
 TYBQmAvTo2eKmlzIxehari4=
X-Google-Smtp-Source: ABdhPJwUklEQdqfwvZZtfMtagP7cPb6ScYPheOd9v+vPXqgLW6Q0BFn78D4uerB2Nem22xypmGh3GQ==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr125903pgd.209.1601426144665; 
 Tue, 29 Sep 2020 17:35:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 17:35:44 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v2 0/3] iommu/tegra-smmu: Add PCI support
Date: Tue, 29 Sep 2020 17:30:10 -0700
Message-Id: <20200930003013.31289-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

This series is to add PCI support with three changes:
PATCH-1 adds a helper function to get mc pointer
PATCH-2 adds support for clients that don't exist in DTB
PATCH-3 adds PCI support accordingly

Changelog
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Prvious versions
v1: https://lkml.org/lkml/2020/9/26/66

Nicolin Chen (3):
  memory: tegra: Add helper function tegra_get_memory_controller
  iommu/tegra-smmu: Rework .probe_device and .attach_dev
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 177 +++++++++++++------------------------
 drivers/memory/tegra/mc.c  |  23 +++++
 include/soc/tegra/mc.h     |   1 +
 3 files changed, 84 insertions(+), 117 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
