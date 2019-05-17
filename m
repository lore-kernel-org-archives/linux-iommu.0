Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FDC04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5FE2087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WvJgtdvF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q5qKpN3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5FE2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A7AF9CA8;
	Fri, 17 May 2019 19:05:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27493AA5
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D429D5E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:48:30 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9858C619EC; Fri, 17 May 2019 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558118910;
	bh=OV/Plnh2chiiFpl1tPau4te8Ie4x49eB+//wLShrquY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvJgtdvFG5xvdzJ6SeLvHgYIB4+iX2jh4xkHa7GFOXxriVA/nDgYcpgQPNCnqfmWQ
	h+fhJdHHbFljAETDngUoAE0qOIeNRcP18Efbki0Lprr/ZesmnIVpROI9q0GNyPylns
	FCDUBVOFKcnl1TwJoyEOqCSyvitAPo0E60ko9b24=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: isaacm@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id F01AD619CC;
	Fri, 17 May 2019 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558118905;
	bh=OV/Plnh2chiiFpl1tPau4te8Ie4x49eB+//wLShrquY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5qKpN3dzD5EBfg8X33uOuhjvsyIAfJF6baPusIbikdtrA7fSJA4JsOWL4C85cVDC
	6FtobZvYMtIuxiz15DDKOE+LomXOAc/mc8XvGNFwKs80DvTeeluNDTIpqXyNMmQIN8
	HYC2NEdjPmNHGdOTajB64JomRehH+pSN1aUwCpA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F01AD619CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC/PATCH 4/4] iommu: Add probe deferral support for IOMMU kernel
	modules
Date: Fri, 17 May 2019 11:47:37 -0700
Message-Id: <1558118857-16912-5-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
X-Mailman-Approved-At: Fri, 17 May 2019 19:05:24 +0000
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
	robin.murphy@arm.com, will.deacon@arm.com, lmark@codeaurora.org,
	robh+dt@kernel.org, bhelgaas@google.com, frowand.list@gmail.com,
	pratikp@codeaurora.org
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

Currently, the IOMMU core assumes that all IOMMU drivers
will be built into the kernel. This makes it so that all
the IOMMU core will stop deferring probes when all of the
builtin kernel drivers have finished probing (i.e. when
initcalls are finished).

This is problematic if an IOMMU driver is generated as a module,
because the registration of the IOMMU driver may happen at an
unknown point in time after all builtin drivers have finished
probing.

Thus, if there exists a chance for the IOMMU driver
to be a module, then allow for clients to wait indefinitely
for the IOMMU driver to be loaded. Otherwise, rely on the
driver core to dictate when clients should stop deferring
their probes.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index f04a6df..1e7e323 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -116,8 +116,12 @@ static int of_iommu_xlate(struct device *dev,
 	 * IOMMU device we're waiting for, which will be useful if we ever get
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
-	if (!ops)
-		return driver_deferred_probe_check_state(dev);
+	if (!ops) {
+		if (IS_ENABLED(CONFIG_MODULES))
+			return -EPROBE_DEFER;
+		else
+			return driver_deferred_probe_check_state(dev);
+	}
 
 	return ops->of_xlate(dev, iommu_spec);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
