Return-Path: <SRS0=eF7h=YU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F435CA9EAF
	for <iommu@archiver.kernel.org>; Sun, 27 Oct 2019 07:45:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19320717
	for <iommu@archiver.kernel.org>; Sun, 27 Oct 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSqSQdFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B8375491;
	Sun, 27 Oct 2019 07:45:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 02D29D09;
	Fri, 25 Oct 2019 16:13:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A605D14D;
	Fri, 25 Oct 2019 16:13:46 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id g21so2234928qkm.11;
	Fri, 25 Oct 2019 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=zt5aCiz15+loMlGNkzBIrHfGb4vgaMCHvSQtYFRY/lc=;
	b=RSqSQdFpzftnwwSvyCqfqI9kI9R1Gea4uZu/7c4HcLOEenQLvD6CNyY5ApaP3r8LOg
	Jt3rIUOFP0gv10p9j27BeHWQskLlx/bqhFgIcJGilqsGmOA+G/LMMDhQekmzaUqhGDKV
	F3R0k6+e3D7ZXZcZXHb1X0qkfjr35s/KVZK3Gcf45bXvQAuWDpDFsdVb29fnYlGOjrcy
	sFGCX8CtSZqkj+UWFYO22haL9lRb6hk16PffKamRtudK31D1i4jLKE6qzKQSsmpVjAvm
	jILjuKOYKQRsTFExw+Kq+idBK/QAgVDny4LFGejnKA3MRr2ui0QiHQVon+z7TOIhjWVO
	KeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=zt5aCiz15+loMlGNkzBIrHfGb4vgaMCHvSQtYFRY/lc=;
	b=KxrjiRWjTgfFtHcP3QRG6l4GpHcJeOSVX0itUS8LfRvXo/g+O18fJY3E7TxF0iKiY5
	FCf0JsxiCgzll+vPF7MVcHwhb4xvvaf+NHEfwooYMY518MK4salK6xEPbCTuClj1LXWp
	qUY+E8biUnT0jzGDPxqIq4808q+XmZMI+6sD21uzssAvHCfhhKMJ8Qgpl1t6pcj36A9t
	j6bvULixvRV/9UOzCSVabWm3NjRjK6jUGpHrWsHYGA8I+dCDblZSklwxXhMFhlRpatKP
	lodgvF3MID9r09DFjQKCcK/PTI8LQgjyPe4bGZnFJHjuN3/441wtYn+h6cV9GzMaxQhB
	OVFQ==
X-Gm-Message-State: APjAAAVnaLaTck1bVn9Igb/f6JCsaZFIGrx/bUrmB+jawpsnskH6+OE/
	dYEp6oXgdT8ww5XBV3oTp6M=
X-Google-Smtp-Source: APXvYqwtiEzeipFoVuO7IWnBrlmavQVuHg2nJWqquIkgtJHV0gswWxvIWE6i9CE24VVhA/5MzfgD7w==
X-Received: by 2002:a05:620a:1321:: with SMTP id
	p1mr3595050qkj.272.1572020025716; 
	Fri, 25 Oct 2019 09:13:45 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
	by smtp.gmail.com with ESMTPSA id
	q17sm1383695qtq.58.2019.10.25.09.13.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Oct 2019 09:13:45 -0700 (PDT)
Date: Fri, 25 Oct 2019 13:13:40 -0300
From: Cristiane Naves <cristianenavescardoso09@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH] iommu/virtio: Remove unused variable
Message-ID: <20191025161340.GA31368@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Sun, 27 Oct 2019 07:45:30 +0000
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org,
	outreachy-kernel@googlegroups.com, iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Remove the variable of return. Issue found by
coccicheck(scripts/coccinelle/misc/returnvar.cocci)

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d76..d8f29c8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -153,7 +153,6 @@ static off_t viommu_get_write_desc_offset(struct viommu_dev *viommu,
  */
 static int __viommu_sync_req(struct viommu_dev *viommu)
 {
-	int ret = 0;
 	unsigned int len;
 	size_t write_len;
 	struct viommu_request *req;
@@ -182,7 +181,7 @@ static int __viommu_sync_req(struct viommu_dev *viommu)
 		kfree(req);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int viommu_sync_req(struct viommu_dev *viommu)
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
