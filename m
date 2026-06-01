Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3159331203
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316003; cv=none; b=qf2UejavS34Recbu9Aie1Q6bOo5evL9h/khBNCT6e4RKytWd00qhIwBpcfSYmLyl/QxEwyoEpVIAwnSaYXoRiiaS/Me4vwITXx925+cKnMAu7PYAfhl2/R/ZT+at+ZImEJXKiPLA/0U/E7zi9bN8yaShKE8XNsJbwUxd5mQG60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316003; c=relaxed/simple;
	bh=LZJ8Svuo7djBDxLwtuMAwakmdGCCC+ETcnBOs2yKNWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaeJNWRIsSpNSuuFlnt5UsUDoisOlvGPWBKDfSQfUJaYrY9X4h6R6w6rnENfYYp2z56u+7Rw9IpbRcSbfXSNJiUSsgOvQIBQCF4EZ4D/IbTRZjmmlM5A/uM3krlbdl5bq7rQVwNSzIoz3U3wpjDPsp6h818pSGdDti9wzE5XrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=OdYH6Aab; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="OdYH6Aab"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/amd: Fix undefined behavior in devid_write debugfs function
Date: Mon, 1 Jun 2026 08:12:40 -0400
Message-ID: <20260601121240.2474-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780315968;
	bh=pmI+Zw4RALLO9MTnTkIO8f3Iqt538OVzYC3v96E48l0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=OdYH6AabmK1BNGv1pmmxDIjT6ndf62OqYhl7G6JP1Yyud4TcWz1zPsg9/i2AQ0xVU
	 6nAF03pqJYDEt490YaB2lA7UPNX860HRxVW5LnfK78RtDm1sdi9mtbxCAoBifIG5So
	 NmXJAF6kFymPX9GOb6eZgmoOdhDHkJ3P3stPORrTv0CLt3nmyAJghsJaW/9Uy/Zhqw
	 PW7vs02aRylUNsXZzBZpTJdfEIozJyOSMejDlAgERKdozJXIvFngHvCBCOJTfJjmiA
	 2pjeBcDTpvpyd4dS859S5WRkpSpaeoV6+6CIPReIaxiN+sZjfIzQvpXA8rLWVRE5ap
	 giiP6Uy1VkxHQ==

From: Li RongQing <lirongqing@baidu.com>

When for_each_pci_segment() loop completes without finding a matching
segment, the pci_seg pointer is not NULL but points to an invalid memory
location (the list head). Accessing pci_seg->id after the loop causes
undefined behavior.

Fix this by handling the successful case inside the loop and returning
-EINVAL after the loop if no matching segment is found.

Fixes: 2e98940f123d9 ("iommu/amd: Add support for device id user input")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/amd/debugfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 4c53b63..5c573ec 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -176,19 +176,13 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
 			kfree(srcid_ptr);
 			return -ENODEV;
 		}
-		break;
-	}
-
-	if (pci_seg->id != seg) {
+		sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
 		kfree(srcid_ptr);
-		return -EINVAL;
+		return cnt;
 	}
 
-	sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
-
 	kfree(srcid_ptr);
-
-	return cnt;
+	return -EINVAL;
 }
 
 static int devid_show(struct seq_file *m, void *unused)
-- 
2.9.4

