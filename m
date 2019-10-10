Return-Path: <SRS0=TgHH=YD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E0C4360C
	for <iommu@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E5D206B6
	for <iommu@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ns1C9fer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1F9DAF25;
	Thu, 10 Oct 2019 22:28:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75E8FE2B
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 22:28:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2072A6CE
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 22:28:38 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id k7so3495685pll.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
	b=ns1C9ferSuxgAAnBlGRzPcG45QzbuNtsvk+IK5P1sm83hU4nWyKG3yPWsMyzZXdJNg
	8L1U7n6L7l4F27SGwiKO6AYQpuWZI4sK4uTbAnc7s2SBIwcp+kTcvUBjhNMO/NTpQrCV
	vOvaL9h3TsQnCeixMAb107cO508lsauqPytIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
	b=LXy+PxZEGYY4qfn9PiFxPSOjkceDir5OkT/ba54ZeTP83bloDJ7bXLvPeoR2FFYZxV
	J2s2Bx/TxkzvtwAcziC7LLuqY1b5eDUblCbqbeXcL/7IBQd2+PIyq7mYD3L6GKoAgpdO
	wmGXiOWkj4yy29Scp1RhgtmjRvy/jBdOX02I8YVYkF8k+W9x49Ro0uTar4VjucvwLOIV
	OmVp2cPZun5g676O9AWZytUHUrjCyW1yGCpo7qiJ89RFSg+SOtIGm2dOwuxdA8jR/pRn
	6nB2ZdyU+iYHj6q4Q5xwn+oVrk12/2XM/rGryH+wMSMoi3Hu76FklPmYixU1GSiiGrup
	KjCg==
X-Gm-Message-State: APjAAAWDMoUXfrPxN/Jujql1WSOoy1v5oJsCANSI/RejpcqlOcEYwG0Z
	HGfjUxREY8CWztNMxj3Q6oVBOQ==
X-Google-Smtp-Source: APXvYqyCnXy+P7NSDVP2SOlCeFKxu9djHVTFcrtbCYrEpGlSGxw5IkNB0B1GwgRZrimv5eyU3qcR6A==
X-Received: by 2002:a17:902:8342:: with SMTP id
	z2mr11623587pln.309.1570746517679; 
	Thu, 10 Oct 2019 15:28:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id
	q143sm3147254pfq.103.2019.10.10.15.28.36
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 15:28:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/2] usb: core: Remove redundant vmap checks
Date: Thu, 10 Oct 2019 15:28:29 -0700
Message-Id: <20191010222829.21940-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010222829.21940-1-keescook@chromium.org>
References: <20191010222829.21940-1-keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Allison Randal <allison@lohutok.net>
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

Now that the vmap area checks are being performed in the DMA
infrastructure directly, there is no need to repeat them in USB.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/core/hcd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index f225eaa98ff8..281568d464f9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd_uses_dma(hcd)) {
-			if (is_vmalloc_addr(urb->setup_packet)) {
-				WARN_ONCE(1, "setup packet is not dma capable\n");
-				return -EAGAIN;
-			} else if (object_is_on_stack(urb->setup_packet)) {
+			if (object_is_on_stack(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is on stack\n");
 				return -EAGAIN;
 			}
@@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
-			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
-				WARN_ONCE(1, "transfer buffer not dma capable\n");
-				ret = -EAGAIN;
 			} else if (object_is_on_stack(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer is on stack\n");
 				ret = -EAGAIN;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
