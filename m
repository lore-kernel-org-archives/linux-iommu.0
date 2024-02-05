Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF0200BA
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134765; cv=none; b=VtjZJq6WbtI9HnA1ZbLiZ2w32ZxWpv2p74Nsi0Sy9mQHnJYdeHCJjFYLXALlf+0cTGEhxeUCkNcLy36JRBEfrp9pg0oLGvxb2AQMeCUDMkq+e7/xn6IbXcqryO9D1NLY4o1R/TN6Golc8qnSNZzUXCwKzPOCdmWXYrL94Cef+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134765; c=relaxed/simple;
	bh=ixoM0Sd7pCRhUQdiB6CxvVkou2FFR6qDgDmLsYAURmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0lfDTpX734aaX4QIyZ61+y/E8q1Lijox5R4h9nbf1QQ93aINAjj5wI7y7SmPb3Ok8d9L9uZIYleZH/qKqra3ul13ljb2XEfJHTbDPXKADV4NiaU/QNjVActcYasE2ttzhZ3Z9QECwgXnSTWwahb7WSQBmlDg1Es63ndSDlQHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U/ckuN0e; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U/ckuN0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134764; x=1738670764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZz9j1l+xmnCAt/gSMnG+c7uMbg+JDxTUK6mJnmY1gY=;
  b=U/ckuN0efPirCZOhg0jyhphmPGDn1IRr2LwtDRkRQrbeEPzEH/weHts0
   YorB72I59IZN2MAX3ID5nYprUDZrZXdTGi5vEM9OQ86aEqJ/1XC0FI3SJ
   tUE++vkfb1i2+c74YrOeZMtCEQPg8DChdCuFjpne0BfHmvsXSSpti5eCb
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="182633597"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:04 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:57869]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.144:2525] with esmtp (Farcaster)
 id 1dbb430b-a9a2-4718-957f-9c92058f05d9; Mon, 5 Feb 2024 12:06:02 +0000 (UTC)
X-Farcaster-Flow-ID: 1dbb430b-a9a2-4718-957f-9c92058f05d9
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:06:02 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:56 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 17/18] pci: Don't clear bus master is persistence enabled
Date: Mon, 5 Feb 2024 12:02:02 +0000
Message-ID: <20240205120203.60312-18-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

In order for persistent devices to continue to DMA during kexec the bus
mastering capability needs to remain on. Do not disable bus mastering if
pkernfs is enabled, indicating that persistent devices are enabled.

Only persistent devices should have bus mastering left on during kexec
but this serves as a rough approximation of the functionality needed for
this pkernfs RFC.
---
 drivers/pci/pci-driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..131127967811 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/mempolicy.h>
+#include <linux/pkernfs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -519,7 +520,8 @@ static void pci_device_shutdown(struct device *dev)
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot)
+			&& !pkernfs_enabled())
 		pci_clear_master(pci_dev);
 }
 
-- 
2.40.1

