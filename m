Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B456C47420
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:04:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E964B216C4
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN7aVqVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E964B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A83620510;
	Tue, 29 Sep 2020 00:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44+EtNGT6UIj; Tue, 29 Sep 2020 00:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6D138204CE;
	Tue, 29 Sep 2020 00:04:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D5F4C0891;
	Tue, 29 Sep 2020 00:04:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 686D3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 56DF086F9A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3+BPYFJ5+Z0 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 95F4986F8F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:04:46 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id b17so1660347pji.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2F2+5D5YYyNtX412eaEEkRAVLuYFhL798dSPFQt/UiI=;
 b=KN7aVqVR2irl+UwyQ/zwfgh5MAtJqeXE2N50vSO/iqptVA7aYfjoFof5Ns9kuNbscY
 rzp0TsTPcIGTWZIA+i+EPEwRQfgP24eHdkOBtltnAgOw/CEjGTNCZZw1h1+h+22JBRv0
 P2uWeCDjzsbVnf5pafKMnnSGrrJ7Uw5g9LZkqAjAkc2mOpMTfUuJLLtYDnSGGXiRHStS
 7HV53RqU5CE7dw7qzLUpmyzHotpwRVwcT3V4hniOJHD72f2kJw4XrhOAzq4CleSxXHZU
 LICALTYjQJzbtI42zVkbs9SaeBBWVC36agePjxCRhiz1zQduauhwV2UZVRArEaCDJgYb
 hebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2F2+5D5YYyNtX412eaEEkRAVLuYFhL798dSPFQt/UiI=;
 b=s3xhO76rEPV/m2WNDB0zBYEVM39s8kCaYdDxLyoLcn8lJOlNL/+3Hn0leN9utSX8wK
 l4iZBQP9VQq/Qx8D3cioftu26V3mN06YEAbtsrKYfVMhPOzGRZd7youQDI6wD1svDngz
 wdccJw02MytNN9aI28js7ytr6IX/rnEEntwBPp4v0eBnZP2qmv1m3Jp3AYgkN8HSmSTt
 lVFNW0DWhLc+YkcWH39Xk2JQ8maQpwAACuL2nWmbNOIkKuQH4SXNssUOTApGrUEOaWOs
 i0OIPm7X5OdzEQFNL9qbhdAdd5bS+u04a7lLTN8SSCIkSDiqO9O4cfQA2kZmmPSGQM4a
 4SXg==
X-Gm-Message-State: AOAM530IL5slM9ZLWWm+myRNaZxJt8JDg1bk8pLNANqbEj9yuoNRczFt
 +ShxR3AIF9gUinNApeWd4Dk=
X-Google-Smtp-Source: ABdhPJwgFda4M/Fy6oERQj0m1JqZSIWvhaK/zpKP1yJw7KCeqXlbxVK7LrTLpsSN/pB8+dspfSVhBA==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id
 y9-20020a1709029b89b02900d242a6088fmr1789567plp.71.1601337886094; 
 Mon, 28 Sep 2020 17:04:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id fz23sm2392814pjb.36.2020.09.28.17.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 17:04:45 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH v2 0/2] iommu/tegra-smmu: Two followup changes
Date: Mon, 28 Sep 2020 16:58:59 -0700
Message-Id: <20200928235901.28337-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

Two followup patches for tegra-smmu:
PATCH-1 is a clean-up patch for the recently applied SWGROUP change.
PATCH-2 fixes a potential race condition

Changelog
v1->v2:
 * Separated first two changs of V1 so they may get applied first,
   since the other three changes need some extra time to finalize.

Nicolin Chen (2):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expend mutex protection range

 drivers/iommu/tegra-smmu.c | 53 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
