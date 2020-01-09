Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF7C33C9E
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1F6205F4
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJDR6VqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1F6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C05E186501;
	Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6i3octQu8dG; Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 532E586141;
	Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4094BC1796;
	Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A07C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3C81487D75
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wli+6-tIpwwJ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 03:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C3E3587D57
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:29 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id c23so1942141plz.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jan 2020 19:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=J0eRs3RcPqHcD2wQFEt9wOIgKwMKXGJvq49opmGx+sU=;
 b=VJDR6VqL3U+L9S4NC+r6ZtWUQz1ZSAPTikYzUpaq8R0f8VEoYbKJuBrs6A4YQ+8Azx
 UgeeMnXbUfM7+gqHHvAnDFcvSBZSRpjWDPMkh1XevIJavDvGDNEyBToBF4ZG/a7DFqKY
 I8ykd9Qo85DlZ26anVtYhcBuD5PjldHHcSn/7NsfMPuDyh3dPM0UXDJtg5bCQQPAIA39
 6xW9tX6dklStXkef4DV74ll5fzLdOI0aY/vKx1akb/vPPS/oC2c7aFkp22MJXjpxOKym
 LEPiy7lI8mOE7jDx7fQAp1Yt4DqdDlbOs7IrNEOsYbzVUb+CTkfGPjr2Ff4E2XXUSyg5
 xzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=J0eRs3RcPqHcD2wQFEt9wOIgKwMKXGJvq49opmGx+sU=;
 b=C492jq7ajSKMafFLJNRqBfEHoquRKkQZMvir5Ta2NuXRU+qO+qmXHpuiOPWLRiJ9BO
 chhnhPe4MSNnQsaE0UGgK5jpY95/jYhPp7PTubTP7mmpwBefHm3xix1G260NkWMBxTE8
 eirMHVvr8K6VuInJ1MrPPqYFQHDreOBprn/9yq5mL0rlgjLy5CsGtn8kNa7MBL3BFtn+
 8ZeYCTzbhOYleuUQeaqwbvH3W/sDWBF7XzdQBkdppWOc2GWtzySCgBFLPGCToTrNojPD
 nxA2G4glBumCDsgqnvUJH8FSJSbzrRzK7R9y5/MkMH2w69m8BWPlgvf52hxA6/auKeZw
 mXNA==
X-Gm-Message-State: APjAAAVHh1ikDzmuVu4N8REIN+edgCijgXjmf/gT2Dulip/lbttDtUo3
 qO1DYP6vUP59wKxGoTLQgT8h95A9QSY=
X-Google-Smtp-Source: APXvYqxWqWfeGzZzt6hUnBTxEVlMFw+fkdYSwC4QeGV3Javb8I5zO5gMAxrYHfIivdIgruYvr/azEA==
X-Received: by 2002:a17:902:6905:: with SMTP id
 j5mr582289plk.239.1578539009045; 
 Wed, 08 Jan 2020 19:03:29 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (114-27-47-65.dynamic-ip.hinet.net.
 [114.27.47.65])
 by smtp.googlemail.com with ESMTPSA id r37sm684072pjb.7.2020.01.08.19.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 19:03:28 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu/amd: Optimization and cleanup for unused variables
Date: Thu,  9 Jan 2020 11:02:49 +0800
Message-Id: <20200109030251.5782-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

This series optimizes the register reading by using readq instead of
readl and cleans up the unused variables.

Adrian Huang (2):
  iommu/amd: Replace two consecutive readl calls with one readq
  iommu/amd: Remove unused struct member

 drivers/iommu/amd_iommu_init.c  | 6 +-----
 drivers/iommu/amd_iommu_types.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
