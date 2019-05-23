Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E183EC282DC
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 01:33:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C1E20B1F
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 01:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NY+76YSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C1E20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B7C4F16;
	Thu, 23 May 2019 01:33:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDE18F07
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 01:33:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5723A5D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 01:33:32 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id h1so4895742qtp.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=AamLO/X/2HFW4+8OQqzF4OMXoHcsEVisRKCkgWHRdBI=;
	b=NY+76YSaThUkioGyKoXDynhJQ1jm7W5HmM96xMkzvko8Ocl1qBMOe0YYwBf5JtducB
	81/zREAC2Wf3cRbMvq+36hvHbQyRj4mWmFaxngal9YqA2PtCm+gusF6PHedzcYcDXXp2
	nxkb5VKHMp56NOcCa4ZPPa8ziaHOkeUG93h9aSu+AodgvuHC6M3ugshxjvFSRmyzKd4r
	1v1O9leuI3gcSvxrbyzFV2yBAtX6Gwt6vx/j6LvrxMJCdOtxZLWN73qN8d77Q1zeNUlQ
	CgwYG9S8Z8reLts4pmk7cEicmE7H7UYM0H1cazPbptv6bYkzMxcsc4mQxXoWAhZS97HQ
	sR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=AamLO/X/2HFW4+8OQqzF4OMXoHcsEVisRKCkgWHRdBI=;
	b=oeU4eJNfY4O40cNy+6wGC/Wd78FpgdLZiiKS6wOOhREsfnbdtoPdPD/UWXihwGpg9O
	Oi0fB5PpnQfg6tlwbuJB66xsdxHa4CKYFWcdjNk2Yg0ZUwpJSnuDaUc88WnNXoSqNa/V
	N1hwcYS8PZZsPczfLhVocy36u6fXNtnk4Sim0HxSpvtdajgmx5D8IocBC46JBj+ZD7QP
	yjru/43T3Liw40y8YW33w5+xUTcjbq9b2m/pf0xW3HwnwM7firBjDUoinXtpRfkJNQUx
	AGymL5NFevzo9wtAi+ChOrasBBrz6R4flcgHRs55u1dzJkiZPIZ2oGZP04DXFJehDrot
	QqdA==
X-Gm-Message-State: APjAAAXGHl+s/G7LUJM9xxQzMQEbLNyTBFdLaRezA3AVTTlj9xU2m1iO
	NanVJRlPhIYiz8aJXNSXKEJMcw==
X-Google-Smtp-Source: APXvYqx5MfUdVLYzIj0g4Pnb3ek/AOecqzC1HqvGl7gFPc6FwlwF35cD3VyHW9X27tAxbfSTWll7xA==
X-Received: by 2002:ac8:309d:: with SMTP id v29mr77648603qta.195.1558575211371;
	Wed, 22 May 2019 18:33:31 -0700 (PDT)
Received: from ovpn-121-0.rdu2.redhat.com
	(pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
	by smtp.gmail.com with ESMTPSA id
	r129sm12798151qkb.9.2019.05.22.18.33.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 22 May 2019 18:33:30 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [PATCH v2] iommu/intel: fix variable 'iommu' set but not used
Date: Wed, 22 May 2019 21:33:14 -0400
Message-Id: <20190523013314.2732-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Cc: Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org, jroedel@suse.de,
	dwmw2@infradead.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
but never used the each element, i.e, "drhd->iommu".

drivers/iommu/intel-iommu.c: In function
'iommu_prepare_static_identity_mapping':
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but
not used [-Wunused-but-set-variable]
 struct intel_iommu *iommu;

Fixed the warning by appending a compiler attribute __maybe_unused for it.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..09b8ff0d856a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3034,7 +3034,8 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	struct intel_iommu *iommu __maybe_unused;
 	struct device *dev;
 	int i;
 	int ret = 0;
-- 
2.20.1 (Apple Git-117)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
