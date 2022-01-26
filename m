Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF95C63684
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 16:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81D5160B97;
	Wed, 26 Jan 2022 16:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRYv3qIV_PRS; Wed, 26 Jan 2022 16:11:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6252C60F80;
	Wed, 26 Jan 2022 16:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C6DC0039;
	Wed, 26 Jan 2022 16:11:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45687C002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F1C683027
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h7XAAA2JN-6y for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 16:11:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B181B83104
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:10 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id g2so21508967pgo.9
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0tQ228U3nQXaWjV8cViOybTVc9dWTMhKsSPLFqG1IfY=;
 b=Y9o46Wo42zMqCSbsyBcmqzXIZi9mLVHoOLEBmOmxftVHauCdwprtlA5oNTyoEhv/lM
 BsJnJKmPK3FuDm9q7GcNTbfGuPI2gyypzpSXLStZAh4BYV/m12jF/hKI610tpFW96CXj
 nylvUtFW+7fRDveRi2PMMgXXpfdUS7DgSkmPCf2ipPm89TKUc4qkpVVQqTNmp57P2GhD
 j61gN7wG/Y+8tpV+/PRPug6pEJnQDVliKLf/zT5yAlL1Oj7VYBkMrh07OuWUA2wd/KvB
 1bvLa4ltZCktXMwhskOQlbGqOkNQSmYoSK62NCi4LjKMlFdWdGNMPLM9m5sCM8z+Nyy9
 7lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0tQ228U3nQXaWjV8cViOybTVc9dWTMhKsSPLFqG1IfY=;
 b=N37kgYKQ7ECtbEFEhjZ7+4ey54mMxNIJiur7WaWkYnl/5J4Dzt9JHx/QDGskr/hBd3
 ajUC2Oy9wMr6qLRWugOZGzOiavzZvukOCg2GlexggGoQgZ9nPtIM4qwx2RUwy1ZMpX/0
 EVORZNtzUQtcMO0a5lAE5/4TziLE8b7hjVOEzwvWp2wk6gl+uAsIShl3PNwwrJ3X/0ab
 6+c5Z43Q9WiJsrChiERfl7jwiESeiPNoUx3bDStmVEZzfYSdW61m0FlHkgnMfxwi46dU
 WBlouw9bO2KvxCaNfqdgqcPsCJgHvue7zZHkxp851GlvGYwVbOoJkXp+2pdDBbbJYhzx
 I1AQ==
X-Gm-Message-State: AOAM533wUCcqv/KLFGTT+VuJLxT8ano/5nY60lOQ5nG8p59iIO6cVNsk
 uvHr5H1E00Yiov8knsSC38Q=
X-Google-Smtp-Source: ABdhPJx/62+0JV4W7kaGThLI9clYp04X79pUIPK2kep5k3Cto21975tua1EyydW+0edNiUOUJmpZdg==
X-Received: by 2002:a63:7549:: with SMTP id f9mr19021304pgn.259.1643213470086; 
 Wed, 26 Jan 2022 08:11:10 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:cf50:7507:71bb:9b04])
 by smtp.gmail.com with ESMTPSA id b9sm2555534pfm.154.2022.01.26.08.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 08:11:09 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH 2/2] x86/hyperv: Set swiotlb_alloc_from_low_pages to false
Date: Wed, 26 Jan 2022 11:10:53 -0500
Message-Id: <20220126161053.297386-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 hch@lst.de
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

In Hyper-V Isolation VM, swiotlb bnounce buffer size maybe 1G at most
and there maybe no enough memory from 0 to 4G according to memory layout.
Devices in Isolation VM can use memory above 4G as DMA memory. Set swiotlb_
alloc_from_low_pages to false in Isolation VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..80a0423ac75d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -343,6 +343,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * use swiotlb bounce buffer for dma transaction.
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
+		swiotlb_alloc_from_low_pages = false;
 #endif
 	}
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
