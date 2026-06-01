Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D213ACF0E
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321337; cv=none; b=s7D140Z7WUWZPuaFd9t/uQr09GqP1ZP6qujbOLZB5eWdx9Pvu84WBIIBmBJ3Xfk3UftevpNmKELxIDb58nIezYnukneyOLoXPN+uPZc8koYy5atypL0Co20yvFyYWt6XPWK/LL9Hg/m4pATQIthT3rMz+8SuTwlfuhs227vuzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321337; c=relaxed/simple;
	bh=b85lZZdAEpendsttCqpo8oWZqe64dF3AQ7gsmsmlFcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fafxUxQ6aiQUnYSjXIZTWcydPJa76EuYay1TNHA5fdouGUH9BNgNMag2LC28suPXqkOUcKQccrkqtpwGJGhHj59DGjXVaX47ofKPPLdREpNNq2GulGX0qiXA1Xnk+Y2nMwz4mBibHJMU/x+L4QEbdCCYwvpQcXiQ1bZXzFSWWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okpvbrEq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okpvbrEq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso7716465a12.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321334; x=1780926134; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxfBWSy/eY/9f0RcQZ6Xq3ck7ox0I1FIw/EK+42VaI=;
        b=okpvbrEqEVdOHpQbhh3r1I13fDjT4a49tgqDPynY3nvZD/xw4cstgHD5GfuGz6mHqG
         vECIXkeTRsVWCDh9qer0baClsl6Mh6ElTvfxt+8AUDyzDgwAjJ9jUH7hueEhvC+jQWn5
         jXzLakiu0cwLkQ8L5uxEmVunTH5fAlXK3qfW+ws4qBCfUuseb8OgzjXvdmn+pxBCxU0g
         l9neu2uuO44kVngfClqTCk8v8MaAZHoSHirdEu4mBwUFw2GJmp07vQ/qFqFk1MUVuwd5
         URphe1JFReQqtPJkjoLb9X6Ja3nvWfe8Xt4QlY04SHuWzDeENP4YkcemCtBUFcg7DBGC
         dJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321334; x=1780926134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxfBWSy/eY/9f0RcQZ6Xq3ck7ox0I1FIw/EK+42VaI=;
        b=JpDJtis/dSn2yTgkqWYF22QwvuCJIcrVwKHo4n2PVaCS3z/mmFLl6oI+g9hkpQpgFw
         sxEfrkhw7stNF2z4Dy85n9HqNS1Kq4iJxWY4+8BXyoxMG2NV/A7C7tvgIkUFk7Q3t9xE
         Ai2nVcgUTYEhlErwuK1EFxA0y73ODS3H4+8QCRXexsQhXxzK9f6G0Xf0T+fHDF3Mh4ap
         5odS0h7YUDg9U7cMQoNA+KWt+pw5UX3mRtBrUjx4sqd3QbXxxJVLgGVyP8jZbPP0PN3B
         wYZL7e8gT7YNFtxyUNapuW8Tb+3cdLDAHHNYCqqJcOWF65nQy02CSQ5qeK2l4sV9Qdsr
         Cg8g==
X-Gm-Message-State: AOJu0Yzs+A549XJ1Tfw0PegJSo+dk+foJqIPcgjAAXP9+PegD8bAQ9sc
	h/tHdvN8OUnuYWJhFAPnfZ5LLGzHs1CLRA4BVNoBTludTATRvjHu/WZvY61iGzJBpBAER85WHGx
	e+0xzkdCheqj2mS1bTJLPIGG0NOBoI93dzs4a6cCcGYSDZOq2kocKbT7z522173Oidi7zsUWMSd
	4QExbu7ZKznDkHqr/CQw2W+cwZFjQLeg==
X-Received: from pgaf27.prod.google.com ([2002:a63:381b:0:b0:c79:65ab:b3b4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:489:b0:3b3:be1f:c89b
 with SMTP id adf61e73a8af0-3b42823a7e2mr12624173637.22.1780321333571; Mon, 01
 Jun 2026 06:42:13 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:00 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-3-praan@google.com>
Subject: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() function currently uses memset() to clear
the Device Table Entry (DTE), which risks torn writes because the
hardware reads DTEs as atomic 256-bit qwords. Fix this by using
update_dte256() to perform a hardware-safe atomic clear when a live
dev_data entry is available.

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a94de66a885e..9b5861e241d7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	setup_aliases(iommu, dev);
 
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
+
+	/* Clear DTE if we have a live entry */
+	if (dev_data) {
+		struct dev_table_entry new = {};
+
+		amd_iommu_make_clear_dte(dev_data, &new);
+		update_dte256(iommu, dev_data, &new);
+	} else {
+		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
+	}
 }
 
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

