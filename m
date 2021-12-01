Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB7DC433FE
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 16:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 748D361BD5;
	Wed,  1 Dec 2021 16:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zn7YsEXlSUZ; Wed,  1 Dec 2021 16:03:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E55B61BA8;
	Wed,  1 Dec 2021 16:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EFF8C0012;
	Wed,  1 Dec 2021 16:03:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8440BC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6876782C98
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0MwhO2XOAtr for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 16:03:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D68DE82C75
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:08 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id k4so18037203plx.8
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i+xUpMEUxrmLaLZETYGitNsZhfrMVhJB1Bk6Yp08byU=;
 b=br/8rZr5MsJhI8n1irXI1gp9Qy4y2qB0ZN5gBXyv9j4Su5bhkV81nOXq9DGZu89aNd
 1yE59r1UZL97RAiD6x+SXTYEoUeu7G0jCsBQ1cuLrPvmNB9yCPuhglIAjJYi604mfSQh
 gyy1MrYjqf6FuZtwg+yZTOfgs9SEgL6VOT93jo6Lr0hZDIeKaRrkgfgJp35M71zw1HjF
 mCa+7WRc/5GxMq2fBfHGjWIosZhHgGj4pZbJ+Vjey1HAEvVpBkgPAoLT3LqFfLNjLY2o
 qMt8D2/BJNN7vwve4krmx/83c7M5pnGp6HV82Z4b4QIdszQpO2qvXOEgIjSwmrsLY0WX
 XfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i+xUpMEUxrmLaLZETYGitNsZhfrMVhJB1Bk6Yp08byU=;
 b=wetL6S6XXAdkiOiST9Jj9bvBkkBi8vnyS7SXe10W6rrdDTlOZ5xK6IIC5XEptdrrsl
 HuVe3xqk3PeBxt1PFr3KGwmTnmbDnhlnfeFRW+B092sR9ty5HHFUNIjH4c2GoFkdv4Pb
 0irHeEfkkB4Oj1yL7M04dDFzm6ACfLf0zgfK3l6e6Y7M0ZgdZz8QL1oP3APccEsEEokQ
 sbFUSbi96yjxvebMP0kH3WqzrVmoGoMvQoIXVUCEaGgMf6m2t64J9G0HaYFtsb83COBq
 1uxtOQ6dWQ5fofaOPf8SMwiofJyuxbsxxcFs9eJBfg7Yq5r072o7FuKR1ASpY9INXvyW
 hB4Q==
X-Gm-Message-State: AOAM533UOr+qqDIBar0ppUMryuO90Zmmi84apjfptBqApVITnxfF9B+d
 D/3869I5wlHI+1xGy5PRpS8=
X-Google-Smtp-Source: ABdhPJzYMUML3tqpL7gDFerbs5Ms9xF8HxCcNqwI0mV93rIMF31+44VhoYZsU5gprIBYp9oOrgPvNQ==
X-Received: by 2002:a17:902:748c:b0:142:5f2f:1828 with SMTP id
 h12-20020a170902748c00b001425f2f1828mr8493620pll.4.1638374588262; 
 Wed, 01 Dec 2021 08:03:08 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:7fe9:3f1e:749e:5d26])
 by smtp.gmail.com with ESMTPSA id i193sm260316pfe.87.2021.12.01.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 08:03:08 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 thomas.lendacky@amd.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V3 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Wed,  1 Dec 2021 11:02:53 -0500
Message-Id: <20211201160257.1003912-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201160257.1003912-1-ltykernel@gmail.com>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides Isolation VM which has memory encrypt support. Add
hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
attribute.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cc_platform.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..f3bb0431f5c5 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,9 +59,23 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_HYPERV
+	if (attr == CC_ATTR_GUEST_MEM_ENCRYPT)
+		return true;
+	else
+		return false;
+#else
+	return false;
+#endif
+}
 
 bool cc_platform_has(enum cc_attr attr)
 {
+	if (hv_is_isolation_supported())
+		return hyperv_cc_platform_has(attr);
+
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
