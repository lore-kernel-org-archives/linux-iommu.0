Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4074C43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C669A20650
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669A20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9BD2724AB;
	Fri,  6 Sep 2019 15:16:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AB3224A7
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:16:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1E3527DB
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:16:04 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
	(mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
	1MpTpc-1iVdYL0j08-00py2u; Fri, 06 Sep 2019 17:15:53 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: omap: mark pm functions __maybe_unused
Date: Fri,  6 Sep 2019 17:15:38 +0200
Message-Id: <20190906151551.1192788-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:M0af/bs8WnLsuP5v9Cfk35XYuWThVjCh/hUKldRjhSEfmpKW5nU
	TgZI+JhlgW7OUNGEFkEKtYW0Q4sQeuBhhtcioFZ/qQ1cp684duECo09+mJCZ/JErVoQs/U7
	9vt9Dl/fFjGpETZ+6TmZU2WXF3GLe58bX0l8kO4gvBThJq8+hCgEnvPbsKifg01BhzP6b7t
	GGM5kQTV+y93s3XLlHrvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTaH62799Ls=:IEN0kCFz2j77p/z0ACtfne
	SaZpmsL7cZsIuhw9dDwLOgQByab3KUEBgIUlzbr7I/K+qM9/46Ikxw6j8KtnUwgtL+7LWLnlL
	9DSrZbkCSq0n5gw51H55vijQziqGehEpIM9x5KHdGoQYFz5MuFxSbCzNf4BvipgXrPx6uQSTd
	AsAeeUUj48BT0PNxGkm1S9jRG1t1G3iCk38TxC7mBISxKPTrKf9+/9CZnWTmzJaXYAcBtfgc+
	C9niXUfYzQ7y3cw/6y0A56Cji4mfn+I54ZVdJKiznXxIasmeW/x1V/cHd7sG216cHWCPAtT9X
	QzGU1+3cZK1DPwP9hGk5k3XcPaJ8uTl8Iq+ulByyZyi/O3VqPqBlYCNAcKDcJh1ef2M04Illp
	gy8C2OeXPk89El0vCZO9Dw5BWwtMaVJI7E7/dX/YXSnKaw5oNtW7gMb1PRWdO1Un6y0kWHpR+
	GmnWXHdowppVLB+TJS2vNDZq5ay7sECkB669iureCDXtESyOq0s7oyOz+dqHhWuHtv8rj7Wxc
	qermZ56i2H+0ZXk7PznB4DweZfo7jKKlJIjsmFX1wTG8KHFChgX6Ex60xyu/qmf62M+IWGH0p
	ZQ5MnUNJMEdRyMvF7Aw4/NP9gn6U7RFC8uOjsUXm5wf1tUPWF8T2COCVPDOe/96Q8HWPplvBI
	0/zGQIAn6iI+5lbYce7QjkPc2ypBPkXyLR4O4iMRSZg2EnUcxel0RzQ2RXcMOJ5aNHi2L9cq9
	FTmtCPTF3hWNE2MwpPUL9rcS/1irRmfGi2npPopRdOJpjv123XnzTHWshXvaZyqszLCPMS3Ts
	e02ozL0PENqjoLXdclkfRN3556XLSPbi1/Jjf8bMQjhv3AxvLQ=
Cc: Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

The runtime_pm functions are unused when CONFIG_PM is disabled:

drivers/iommu/omap-iommu.c:1022:12: error: unused function 'omap_iommu_runtime_suspend' [-Werror,-Wunused-function]
static int omap_iommu_runtime_suspend(struct device *dev)
drivers/iommu/omap-iommu.c:1064:12: error: unused function 'omap_iommu_runtime_resume' [-Werror,-Wunused-function]
static int omap_iommu_runtime_resume(struct device *dev)

Mark them as __maybe_unused to let gcc silently drop them
instead of warning.

Fixes: db8918f61d51 ("iommu/omap: streamline enable/disable through runtime pm callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/omap-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 451e3c98ab2d..09c6e1c680db 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1019,7 +1019,7 @@ EXPORT_SYMBOL_GPL(omap_iommu_domain_activate);
  * reset line. This function also saves the context of any
  * locked TLBs if suspending.
  **/
-static int omap_iommu_runtime_suspend(struct device *dev)
+static __maybe_unused int omap_iommu_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(dev);
@@ -1061,7 +1061,7 @@ static int omap_iommu_runtime_suspend(struct device *dev)
  * reset line. The function also restores any locked TLBs if
  * resuming after a suspend.
  **/
-static int omap_iommu_runtime_resume(struct device *dev)
+static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(dev);
-- 
2.20.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
