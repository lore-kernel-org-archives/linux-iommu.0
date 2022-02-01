Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F94FC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 16:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F90E60BA8;
	Tue,  1 Feb 2022 16:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FOTUOUn-L5Ih; Tue,  1 Feb 2022 16:32:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F2FFC60AA8;
	Tue,  1 Feb 2022 16:32:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8E21C0011;
	Tue,  1 Feb 2022 16:32:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8EFC000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 16:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77F72415EF
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 16:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7bgCsiNRgCPn for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 16:32:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA769415E6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 16:32:14 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id 132so4782066pga.5
 for <iommu@lists.linux-foundation.org>; Tue, 01 Feb 2022 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6xhI2zbG0jNZ5yz1fLORa/ua0vNztHYbX/bz96VcvOU=;
 b=q2ZAeuPodxwJQU2rztwogjbHdGzMD0vXKNmluHDiGxY4gtRzIlQdJAWWWWWjXUSV2s
 sGBRGBuiR3MLuht7jztdnvcbWjncBC4pE7MSdoXTXEmhvXqE1YL03UhOlqmEicbtmEW3
 dttGWBz6b0XBsS4vyD/PbuGMxQIlrRMNmA+6rKW0csnsIKjValSTr588y9+Y73EefhH9
 rfLZ4sBttt02feGAlBaiVpMyZrVVUFIWbEtGK3tOgBBiHxXtZ3P7J71Tahy9yrX8xbBa
 II0n4I93snxUBwmOMUlUNpjqrSGoLwevzi+sR1ogid7z+9OZjQAJbBAGLh/X/b8FnysZ
 uiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6xhI2zbG0jNZ5yz1fLORa/ua0vNztHYbX/bz96VcvOU=;
 b=3uVE3c8RGKqTqtfhUSe6eQz24aWvG0DsRs4nws1jMsgYBkbMWV5tMYCCp3jF4MGPFs
 OgHNM8n0pGsqbsjlkETtIDj/KdkEEqM23og88OFRMw7qyjgxup1bhpxVnvwbPGcMKVJW
 j5Q2AHN02c9dJ66OLPczqARRQdunN+a15BElsRCfjZdEYjsSlRUdvDS7/+1O+vPwvL85
 N/wE/1/n4qWfCPZqBzDb8a8XNzPcJ1uulzpOv/5sqjKoZeugKtY2EvMacukNu9tVpait
 +JzTquUcU+U0jNSDt0+BU9rdXOReDVorrtLXFsYxG40NbVDEQN2QaqaCWMga7QQ3uGO0
 lCvg==
X-Gm-Message-State: AOAM530DXtucGkdxT5nUhBgdWx7+ZzN+mdH6appC/9xkX3R5+IAVYH7R
 QwZ1oKWm5JUUnHhCbegelCs=
X-Google-Smtp-Source: ABdhPJw+7LhIPln247qncqytiFgNPjhSAYA88YoV7GKl+p94CA5gb2dWEyZdTkrxr+/JsoKMGn4OLw==
X-Received: by 2002:aa7:8c02:: with SMTP id c2mr25899849pfd.81.1643733134011; 
 Tue, 01 Feb 2022 08:32:14 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:1876:8c7:1622:c2a0])
 by smtp.gmail.com with ESMTPSA id e17sm21659800pfj.168.2022.02.01.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 08:32:13 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH] Netvsc: Call hv_unmap_memory() in the netvsc_device_remove()
Date: Tue,  1 Feb 2022 11:32:11 -0500
Message-Id: <20220201163211.467423-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

netvsc_device_remove() calls vunmap() inside which should not be
called in the interrupt context. Current code calls hv_unmap_memory()
in the free_netvsc_device() which is rcu callback and maybe called
in the interrupt context. This will trigger BUG_ON(in_interrupt())
in the vunmap(). Fix it via moving hv_unmap_memory() to netvsc_device_
remove().

Fixes: 846da38de0e8 ("net: netvsc: Add Isolation VM support for netvsc driver")
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index afa81a9480cc..f989f920d4ce 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -154,19 +154,15 @@ static void free_netvsc_device(struct rcu_head *head)
 
 	kfree(nvdev->extension);
 
-	if (nvdev->recv_original_buf) {
-		hv_unmap_memory(nvdev->recv_buf);
+	if (nvdev->recv_original_buf)
 		vfree(nvdev->recv_original_buf);
-	} else {
+	else
 		vfree(nvdev->recv_buf);
-	}
 
-	if (nvdev->send_original_buf) {
-		hv_unmap_memory(nvdev->send_buf);
+	if (nvdev->send_original_buf)
 		vfree(nvdev->send_original_buf);
-	} else {
+	else
 		vfree(nvdev->send_buf);
-	}
 
 	bitmap_free(nvdev->send_section_map);
 
@@ -765,6 +761,12 @@ void netvsc_device_remove(struct hv_device *device)
 		netvsc_teardown_send_gpadl(device, net_device, ndev);
 	}
 
+	if (net_device->recv_original_buf)
+		hv_unmap_memory(net_device->recv_buf);
+
+	if (net_device->send_original_buf)
+		hv_unmap_memory(net_device->send_buf);
+
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
