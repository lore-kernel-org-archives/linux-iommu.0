Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D02C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8758220715
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtsVZiHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8758220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D2312051C;
	Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nchvo3BU7f1Z; Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 338F5204D9;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 269A6C1DC9;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80D25C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6A208204EF
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oKKcEZRA-fp3 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 00:14:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id B6594203E5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:24 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id x28so649286pfo.6
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 16:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iWcHlEgNUMXWNtKMo9fnHArr6iM67LDOF9B6/mC5eh0=;
 b=FtsVZiHS0XjHawCmjdwhHMQklah08Y+cI5JlQyrmYL0+HJeWbW4B5FqM/V3xIUNFps
 ESSb1QTy3Nqa2LHI/2Q9ErojKLztxhds+mZVEt7luzVOAlUOw+yHR1vuNjdrYy6VwAX4
 l1DeaynlLib7Wb9UOYvUSuEjZ1gM7AqyJI9iFecvlu2FBuwabg+BznsHDiwda8a6qIkC
 lgFeurHDPHcZEfCAG0tH1S5MrFlAc8Kxj3zegQIr3/f/xnuN7kR5OTaAN+1rXyfvMsH0
 Hrj+lDNatJ0cM0EbflECXE+f9IQSp0Cb7RqlGH+cKLhgphjzx7e/q+1yXg7MbHNKT781
 /hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iWcHlEgNUMXWNtKMo9fnHArr6iM67LDOF9B6/mC5eh0=;
 b=DSCTlYJI0ELKJ6/RiY1y4ONsgWccKlwZOoV7NJz/aeq1lM2g0DmuhLB9aYVtx3AsQs
 a5g5XRHNx+iXhKs55ZrxQkA8cME/QNz1yTQZKZL9X+mAaxeED0dUFGLvhE0Owxfg0UAy
 rPo7mh7lNzkYIPoww/FtFj7U55b3Y0kS4Qjqk/XFNXsdvDT7z9Oq/9Q71C6Ha4Skz3sb
 var1c+34zYkrQsSEiGkJnyMKp2GL8dMHC7nVs5KG94mFBWtg3kWPNOW5hvMrzbpEYlqB
 UQjrVkUQUss3gLu7jviNvWvg7EC5E846VekzgAS6lDbHqUHREjvXY5xVV+wD2h9Qo+9c
 TVIg==
X-Gm-Message-State: APjAAAVwUzoJjR+NJp35EyRqJQI/nBt+inhzov2lGB89jxZuid0mzzYh
 rcZcUjdTJer8/+M1VdA00+Q8aPXLuAA=
X-Google-Smtp-Source: APXvYqzMz3F5gc0bmdB8045zo0z/zHlARfgRPm4Md5Gby/s36OsyddwO4k65Ri++p+1zF7BVsSTEyQ==
X-Received: by 2002:a63:f48:: with SMTP id 8mr6308884pgp.329.1574295264037;
 Wed, 20 Nov 2019 16:14:24 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:14:23 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/3] iommu: reduce spinlock contention on fast path
Date: Wed, 20 Nov 2019 16:13:45 -0800
Message-Id: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Nov 2019 00:26:19 +0000
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
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

This patchset contains three small optimizations for the global spinlock
contention in IOVA cache. Our memcache perf test shows this reduced its
p999 latency down by 45% on AMD when IOMMU is enabled.

Cong Wang (3):
  iommu: match the original algorithm
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice

---
 drivers/iommu/iova.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
