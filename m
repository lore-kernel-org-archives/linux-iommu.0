Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767A3C31E58
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:20:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB6820657
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mWanSoeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB6820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07518CB2;
	Mon, 17 Jun 2019 13:20:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A1377CAF
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:20:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 673DE832
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:20:37 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id h21so10551327qtn.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WxySO7RavF5zKMyjv/ZaNC+WOWObSuSTRMAxWTHSvk8=;
	b=mWanSoeKZy4yF6NDlcrcGKEXWiXQ/nNABojBc9NmRQLyOxGN+dfp6x98NxigKwj4A1
	0TbLG+zYbbzxQ9VsYrkBavXogdkcX6lH1Q2hGSSD1xPLqrb3OEfaPzOgWOuZwF838FIM
	abzv0h0l/nIAiwtlY+xCaD6+GIdpUj1xNWcH9XHJ285eeYs/KxtJFGcAtFZTcN83DFe2
	OS0m58Pyl5UPRnWJZRdZlEZbD1QXl6SfEcziIPoJYPWq1xYE3vprBROYORWK14gLD1Gh
	ySE/+Wx36zotGAUWWc2tV8iUfDd8G8nNTDA3sCmBlr0f6FRrRl1WRUUwh6stUCakMUvG
	9mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WxySO7RavF5zKMyjv/ZaNC+WOWObSuSTRMAxWTHSvk8=;
	b=csvHSrEFn/IjhObCyAPA0WfiWLyMzBbQVZIMYOiDBvL+jpWMMWnETd+QxL++SL/WCQ
	5tfx8vKoT7RloB8MBnpxRJX0OCPPPau2MSMbg71lxkwyrA0pgxRUWaN3ItWL0sPxa+EW
	Tgo+pL7EcAh8LlZVqa65UhKY5iqaDKoceWeu5+A80JcVa86By4I/Y3l7BtW4uVqsxkc6
	6mxkD+kaK/J05JQO0KTa4O4CP23016CI2+ly3iHOH6aCdFwykqaoVWyytSRD/qkfKjis
	g3upWJtmaPwXSANOlsXIRhz8aQCTrpKpkgsyh/ekjGmO4OQuPiybq4SpmljfQI12Jubj
	9JWQ==
X-Gm-Message-State: APjAAAX8WWGq+fe4HgSPDVsR/KzHmjVWENwAS3DxSn2M/C7lPu9Ua84c
	GUzbbYc9aT8KQZkVS7OGvGaAxQ==
X-Google-Smtp-Source: APXvYqx8nwAh/ef1Z7S6mpaIuw+uQGeTu/VellQt7Hwdg7+ajM7LdXfG3blR+hAVljz5qh/x3jNcpw==
X-Received: by 2002:a0c:b0c6:: with SMTP id p6mr20449953qvc.225.1560777636216; 
	Mon, 17 Jun 2019 06:20:36 -0700 (PDT)
Received: from ovpn-120-145.rdu2.redhat.com
	(pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
	by smtp.gmail.com with ESMTPSA id
	t80sm5767002qka.87.2019.06.17.06.20.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 17 Jun 2019 06:20:35 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/intel: remove an unused variable "length"
Date: Mon, 17 Jun 2019 09:20:27 -0400
Message-Id: <20190617132027.1960-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org
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

The linux-next commit "iommu/vt-d: Duplicate iommu_resv_region objects
per device list" [1] left out an unused variable,

drivers/iommu/intel-iommu.c: In function 'dmar_parse_one_rmrr':
drivers/iommu/intel-iommu.c:4014:9: warning: variable 'length' set but
not used [-Wunused-but-set-variable]

[1] https://lore.kernel.org/patchwork/patch/1083073/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 478ac186570b..d86d4ee5cc78 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4011,7 +4011,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
-	size_t length;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
@@ -4022,8 +4021,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrru->base_address = rmrr->base_address;
 	rmrru->end_address = rmrr->end_address;
 
-	length = rmrr->end_address - rmrr->base_address + 1;
-
 	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
-- 
2.20.1 (Apple Git-117)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
