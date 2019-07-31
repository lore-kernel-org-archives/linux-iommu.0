Return-Path: <SRS0=24gJ=V4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D2C433FF
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 16:36:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1D820659
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 16:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c49vK9Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1D820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F36D03EB0;
	Wed, 31 Jul 2019 16:36:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6922A3CD5
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 16:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 170887DB
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 16:23:25 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id x15so61500592wmj.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=0wYUbEYCCym2GG5RcSPUCX+mSupUTzw5PRJT+NcA3C4=;
	b=c49vK9WljD2alSugRVvLlrIpIQTwBkUjKcKwcmlmWlddUEeY4KOdRW50it6RdWdI0O
	hpBTKP/9JjJwkgaJ2VLpSU2iZEHq2I+INh/RMXyO/UKw3D0/cCRfNrWULJ9sYkahL6lM
	ZzpThU1yIZo93H2YbHEolXi0Qbz3TUh4YeKc9crEnmdtRJCYF8h/q0wB2R2fN2DWf+/F
	i4Ge2O76uENTjUz52D2tdFa6UzIIMZx3xggSKTupp6R5otKR/f7qIuZ0lI4pMKLqzCqn
	adFoe5tpUSS7ZNzbZwhriwVirmtcmDAGa4V8rZckhGtPd5yuU6kbQ3Ba7DFAs2LI9Art
	18CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=0wYUbEYCCym2GG5RcSPUCX+mSupUTzw5PRJT+NcA3C4=;
	b=MK36BaT6lR5ha3o5A9gIdazgWSUiZj8kJoUiOzA8aaMIOYSJee/foeeRCY+ICNs9u7
	pKl58w+xtr2+eWMVBrZBuyEUO7zNf815rd7RsweCAqWmXTUIe50KD0yd1oFjoXSnFqiZ
	2mbEtvzciZHZKy5aEALfQVfDqS8gdXX8U7gUnUC2iHOCMN9F7d7rsqfN3+WAIsP2HXRm
	m3vX0RoHEwuJyeJnagl4qntnruy7M+VMeKcsi23QJOuFwQ0MJUWxfLgQLCGstYUC37ta
	fQGzSj5LWoA0EYVMrl1ONuuLbIpkfoyJI36SZ2OohzMMfTxAqBusjSd86QRM3RVKrGbG
	gUbQ==
X-Gm-Message-State: APjAAAV73y6wtQ5Vunzkvft5o2pbHySF+Sm1Nnwy//K9Xwsd+wdzcOur
	I62Nt5tK6oXm/E0kRcqA93gNWgQq5RDM9zTUOizfLwxk0EmiXqzcMS2/yAvY8kWLmQ+o7D1euxt
	lgi8v2vH5kk7kTZlBQQjRnWvLseG7iNR8Pa1C/qA2bTGhb6vL3B8Y7t82qk0vn8ZKXW4BNAYgEA
	fKazU4mGdsb9RCaJ1AFGBdE5/EyNXd22Uk+PadbESVsG2S
X-Google-Smtp-Source: APXvYqwGzrRC4B4woWM6sGbK2nyczq6FciaPt62SyG/Zw7Fg/put55jM4d6qO9Qll74/TI15Htyx2g==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr114343485wmh.55.1564590203627; 
	Wed, 31 Jul 2019 09:23:23 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	c3sm75530382wrx.19.2019.07.31.09.23.22
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 31 Jul 2019 09:23:23 -0700 (PDT)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH-4.14-stable 0/2] iommu/vt-d: queue_iova() boot crash backport
Date: Wed, 31 Jul 2019 17:23:19 +0100
Message-Id: <20190731162321.24607-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Cc: Joerg Roedel <jroedel@suse.de>, Dmitry Safonov <dima@arista.com>,
	0x7f454c46@gmail.com, iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
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
From: Dmitry Safonov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Backport commits from master that fix boot failure on some intel
machines.

I have only boot tested this in a VM. Functional testing for v4.14 is
out of my scope as patches differ only on a trivial conflict from v4.19,
where I discovered/debugged the issue. While testing v4.14 stable on
affected nodes would require porting some other [local] patches,
which is out of my timelimit for the backport.

Hopefully, that's fine.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>

Dmitry Safonov (1):
  iommu/vt-d: Don't queue_iova() if there is no flush queue

Joerg Roedel (1):
  iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA

 drivers/iommu/intel-iommu.c |  2 +-
 drivers/iommu/iova.c        | 18 ++++++++++++++----
 include/linux/iova.h        |  6 ++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
