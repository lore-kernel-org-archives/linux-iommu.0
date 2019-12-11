Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7501C43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD992077B
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bj6k8Bc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD992077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E7CD8653D;
	Wed, 11 Dec 2019 20:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUxfmpF6MBsR; Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 463D48687B;
	Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3205BC0881;
	Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53C83C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E091886FE
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7-9YMEokXlv for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 20:16:23 +0000 (UTC)
X-Greylist: delayed 00:23:42 by SQLgrey-1.7.6
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com
 [209.85.166.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7B43488692
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:16:23 +0000 (UTC)
Received: by mail-il1-f202.google.com with SMTP id s85so18076566ild.13
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=A53ZaoyxJN+P/x/wFOv9wV4eF+QY9qPjvQKuh7OFwuU=;
 b=bj6k8Bc7Ef+j+rl6hUKv99wGBXII19pyqdKKrJI0g1qkHNJltGp6k0JofsUtU0Kfp5
 zqAhCWh68oY3h93QzByhJEA8pU1o8YBJo+oZ4HSt1YsvpskpVpaUEo0vSulRMxSeCpcr
 VZMZA/5XiHkKoc65RR/BTzy/O5rbh4JTkFVhARzzljaJcGSBo6eIXI40pSDGc9OWm4nY
 2DNHHpbEB4SbXmkypEr5D7aJOGGv7GJAj7D9dia2t2v0LIph2fUasLu3FP/R3OHplmre
 9qq6Pms+e1Jc5fZJodLfVRV3xImJzyCRQUsXrnZDuOPRBmbuOJFlmaGZ1+ax43KuK2ZG
 CN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=A53ZaoyxJN+P/x/wFOv9wV4eF+QY9qPjvQKuh7OFwuU=;
 b=IWQZmf/WBIqBOX7h/D+9h0+vTjTDG5ztPjooL8cq2T58Cg7l7qRmxruA9QsAt6kNrw
 nhe+ELXqO+p4TVxXF2Am0tOVz3LttqpAoLGNiM1rYT1dLA5hatWC4t40DeJFuXlYd34A
 HTsWHAimHn8xTkSRBFL6rXRFc2+xge1yr1A2IX24v2u3eFIEROtVhGMC/aLdmmU39GWO
 OZ2nsGKIgiHOGYr4waQvR9YT0GNQ7gKOZjOBuouj2dZTFEdX2sXrU9IZ7WUBHGhUs7G0
 MjfoTNOGXbi0BRND7XgGw8Yh04VsVLuibNvnYPzK9LNp0j79pYWZheUcuCkaTNGRSHAp
 OMrA==
X-Gm-Message-State: APjAAAUM+zG36PTtDkQ8752JljfPLELUuaurvfcrpSkaaNcXz1jTu8YD
 JDtVD3i3sULraNN/U7KbNor8zzIi
X-Google-Smtp-Source: APXvYqxkWLsqIgmvHQiiMFxw4ZXKOkzE0dbenXYUwgiP/rqdexXMIIwgADKdnZ2MnxRj90Xlrt1a1MLn
X-Received: by 2002:a63:c013:: with SMTP id h19mr6078212pgg.447.1576093601550; 
 Wed, 11 Dec 2019 11:46:41 -0800 (PST)
Date: Wed, 11 Dec 2019 14:46:04 -0500
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Message-Id: <20191211194606.87940-2-brho@google.com>
Mime-Version: 1.0
References: <20191211194606.87940-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity check
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, 
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
X-Mailman-Approved-At: Wed, 11 Dec 2019 20:28:58 +0000
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RMRR entries describe memory regions that are DMA targets for devices
outside the kernel's control.

RMRR entries that fail the sanity check are pointing to regions of
memory that the firmware did not tell the kernel are reserved or
otherwise should not be used.

Instead of aborting DMAR processing, this commit skips these RMRR
entries.  They will not be mapped into the IOMMU, but the IOMMU can
still be utilized.  If anything, when the IOMMU is on, those devices
will not be able to clobber RAM that the kernel has allocated from those
regions.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f168cd8ee570..f7e09244c9e4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4316,7 +4316,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
 	ret = arch_rmrr_sanity_check(rmrr);
 	if (ret)
-		return ret;
+		return 0;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
-- 
2.24.0.525.g8f36a354ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
