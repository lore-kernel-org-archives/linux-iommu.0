Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B6C2BA80
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC8D20771
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S7dku9eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC8D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6642A221DC;
	Wed,  8 Apr 2020 21:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 084Pj6ZAE4PI; Wed,  8 Apr 2020 21:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C25C82408D;
	Wed,  8 Apr 2020 21:21:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B067BC1D85;
	Wed,  8 Apr 2020 21:21:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DDBAC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4DDD4880C2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmlWdrXpJf-D for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:21:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5BB66880D5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:12 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id np9so360742pjb.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=tzxcVfYqDaPeZReasS8qD6qKEgdprHW9+s9O1hZTsQc=;
 b=S7dku9eUTelk+NIxd5md2NkDK5b3imi2QHWeyDBBDDcrvmjt27DpHCsqUREtsSeeU4
 LWtIXun2WRrvnU5+Mi+QDZ44E/PUo8yGraQxVZo+cw/gxAdVMVwxRGnzOrMTqqJjwG0q
 VmVYnfi+iIbuIo40rVQ2ZNnDI8pS3GVoxmWJEPMYkLvQe6jkBzm8XBD+lcpu1LxJU96P
 LKKbcKRTVIKRLRoN3CUUqXj0kj7QZFow/wHeGm4TMuTQLz5xwerblJaOAdMaSwPayqSW
 pwitgq51n5deonLMg1acLi5p4zxUKVEFyHZqIrb6PosYqToOkl/NrAAnKhXQUgMrTa27
 CfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=tzxcVfYqDaPeZReasS8qD6qKEgdprHW9+s9O1hZTsQc=;
 b=jRzB4lvQ8Y79h5Pfrur0O/CAAlfmaRezUEYOwOortoC4FHecVRQOPfUjgK3JOIhDrq
 NHmtLmMbyWEogFw/7HmTxVT00bOdE9wO6aFyznyecgiXZLz4AqVVweL/84VJOCPkaCUd
 1JG5HUudDD/xXqCdqBhCBj46ZL5e8jr/it/HG4pKIW3fmhJ04Zf2fAQPJGef5Lgs4ymV
 NF4JAYbmo2DTPQ1sjuJnkGRJOK4Zi4t3DrEvBc+F+2gaYCa/rJlCR1vGtOKbwYu+l2N5
 wzpvV+ME9E/f8TxxCReVRJApdKWgwG7f8+4DkBApG6jQvhNK9rarBDmL2aPfUbLItkRL
 k8Ag==
X-Gm-Message-State: AGi0PuY5Wlq3mfWA82HORspppQUWDayx8GvWSxtHOeZvkXKwzJGUDQq6
 diTeyNq88azRFtMuR7qQyRq5gw==
X-Google-Smtp-Source: APiQypLzuioXyKB2rsVHdIo/cg8MndRznC5d3+Fj5BV7jR+NxJO7bpFagBpEzVoX2RqVkHvT6AeBnQ==
X-Received: by 2002:a17:90a:a4c9:: with SMTP id
 l9mr1907410pjw.44.1586380871617; 
 Wed, 08 Apr 2020 14:21:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id d23sm17523800pfq.210.2020.04.08.14.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 14:21:11 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:21:10 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc v2 5/6] x86/mm: unencrypted non-blocking DMA allocations use
 coherent pools
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081420220.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Grimm, Jon" <jon.grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When CONFIG_AMD_MEM_ENCRYPT is enabled and a device requires unencrypted
DMA, all non-blocking allocations must originate from the atomic DMA
coherent pools.

Select CONFIG_DMA_COHERENT_POOL for CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8d078642b4be..b7c9e78a5374 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1520,6 +1520,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DMA_COHERENT_POOL
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
