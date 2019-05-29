Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF6C28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 21:00:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6C4241C8
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kCF0pV8k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kCF0pV8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6C4241C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2863A2A97;
	Wed, 29 May 2019 20:59:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 042B62A6B
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 20:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C308881A
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 20:55:20 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C0E636137D; Wed, 29 May 2019 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1559163319;
	bh=MNplseeIKAQ0I6ymvujag5Wo9kZnnfQJJGa0KJiYvTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCF0pV8kDxPMcxpp+IyTex1gwg/kAHKVn4XAqB5esDSO93Xl+GZ/Y3itkDgvITbFW
	hsVAyZL2PjbfPvLGFb3/IQSk3xE/qZFsnXnioDQY2E/uCuCLzVdec4wzyCD0+mibcO
	paF/NvWuL6yXiI+I7DoQ//XSYK7/HmghFCVDIuNs=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 316DD6133A;
	Wed, 29 May 2019 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1559163319;
	bh=MNplseeIKAQ0I6ymvujag5Wo9kZnnfQJJGa0KJiYvTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCF0pV8kDxPMcxpp+IyTex1gwg/kAHKVn4XAqB5esDSO93Xl+GZ/Y3itkDgvITbFW
	hsVAyZL2PjbfPvLGFb3/IQSk3xE/qZFsnXnioDQY2E/uCuCLzVdec4wzyCD0+mibcO
	paF/NvWuL6yXiI+I7DoQ//XSYK7/HmghFCVDIuNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 316DD6133A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v3 05/16] iommu: Add DOMAIN_ATTR_PTBASE
Date: Wed, 29 May 2019 14:54:41 -0600
Message-Id: <1559163292-4792-6-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
References: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
Cc: jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, hoegsberg@google.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Add an attribute to return the base address of the pagetable. This is used
by auxiliary domains from arm-smmu to return the address of the pagetable
to the leaf driver so that it can set the appropriate pagetable through
it's own means.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a2f07cf..49639b7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -129,6 +129,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_SPLIT_TABLES,
+	DOMAIN_ATTR_PTBASE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
