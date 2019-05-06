Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42031C04AAC
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 04:12:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5EF20830
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 04:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jBlCglUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5EF20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9A85A44C0;
	Mon,  6 May 2019 04:12:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2836B44BC
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 04:11:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E54247DB
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 04:11:31 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id w20so1092023qka.7
	for <iommu@lists.linux-foundation.org>;
	Sun, 05 May 2019 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=a/9jBpXTZnQFeOciLXd3ZrvUElHq2Jv+0k02JlnPEJU=;
	b=jBlCglUaJPP/RHcXNVXHWy5SxyOg7l9yIUGv/SlPVrdvtfSkWMXBmufeK4XN6+N2CQ
	hrZrwGcS+vtGlcYninLD0qmZXP9pOHuNW5TkPN3kdv8uIuj4nboRj7XrstWxZXX0sXvh
	8Hjwe49h11MXj2vAuYKPaNlSXfLPJGZwopxWHySAX5FYinUkLTCYI/eR8Gp68Z/LW+Ao
	HuslEbmnRLs6LOsfzyw2kB4L/M2r363F34q06KGgmC7ptC2Nd75ubGNbAF5PjpKyNhVm
	xSFrwQ9nVlgtkvdRItuhcoYlxBL2JalPkVoalg4GdHX0cTkNBSF+0J7VlP8Y03OcJwZp
	9ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=a/9jBpXTZnQFeOciLXd3ZrvUElHq2Jv+0k02JlnPEJU=;
	b=iNBHCQrwhr5dnKonku1IIgWTIZtvc7NbywpNIkSqFH2wG+8EztQic+EqWFKFMl7wnj
	elNsqjFa91mr8Sd4sxWVBzC6z4ltT71x5kqJciGwNChb8zCjeU3v9sDExd0JOLlfJdZo
	Y/cm8ipDL+4NXPiGnHfXAVaxUoIzdpr5x8GoX38k6phHdhbb4gob2TT1GkxgWqK58nb9
	qPCHqVakob5wDt1Cjd12k5T+IRAJENngie+yQpCPyXkgLXqi7oEI30+rWX6l0fsuns7t
	Gtzpy/Hhr2h1B7mDoJgotR5cFwbOuA5vb1ABah14NuS6w8zIATmK0ZpSZ6UP7/vmsFCi
	L/Ug==
X-Gm-Message-State: APjAAAWUvVydvaYSi+jRFhwdD/DZBps8Q4q7sv+Y3sX/zPXeUBA56Zb4
	4aJPvtFO7X5NX9yNRRjnyZFLNw==
X-Google-Smtp-Source: APXvYqzDxKH7+7jB1OvTn40IPHrxitvDRhwmOASshkDIaRLNFor/C/gqgDxKs/ndQBhcJ743DS4ZIA==
X-Received: by 2002:a37:2d81:: with SMTP id
	t123mr17416678qkh.316.1557115890995; 
	Sun, 05 May 2019 21:11:30 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com
	(pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
	by smtp.gmail.com with ESMTPSA id h7sm4739467qkk.27.2019.05.05.21.11.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 21:11:30 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Date: Mon,  6 May 2019 00:11:06 -0400
Message-Id: <20190506041106.29167-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Cc: Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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

The commit e7f63ffc1bf1 ("iommu/amd: Update logging information for new
event type") introduced a variable "tag" but had never used it which
generates a warning below,

drivers/iommu/amd_iommu.c: In function 'iommu_print_event':
drivers/iommu/amd_iommu.c:567:33: warning: variable 'tag' set but not
used [-Wunused-but-set-variable]
  int type, devid, pasid, flags, tag;
                                 ^~~
so just use it during the logging.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..52f41369c5b3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -631,9 +631,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x tag=0x%04x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, tag, address, flags);
 		break;
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-- 
2.20.1 (Apple Git-117)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
