Return-Path: <SRS0=Te3Q=WX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BDC3A5A4
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7354020850
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mtNiy007"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7354020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A99CA49;
	Tue, 27 Aug 2019 00:15:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C47055AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 00:15:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 55FA4887
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 00:15:26 +0000 (UTC)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R0F94q123270;
	Mon, 26 Aug 2019 19:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1566864909;
	bh=RsMdpRqUalyAi3dA3oqiFcxv5t3kJ8Ef294FTJiip/Y=;
	h=From:To:CC:Subject:Date;
	b=mtNiy007c4c+bjaKOM+VXU0XirUWm3gZ3N7XfEEFwPDQww3FaTEu5Is1few/wZ71k
	hr3/3ebZBvMX1oM+yWUlSVeltang57drIWNn9v6bvGIaMlOLcY4RgxN9nmWDDcNzIA
	PFkqNN8A0ogp0fM+Bp+3GDU1fc5FLwlwyRw0xiw8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R0F9UT022283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2019 19:15:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
	(157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Mon, 26 Aug 2019 19:15:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
	(157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Mon, 26 Aug 2019 19:15:09 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com
	[128.247.22.53])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R0F9eD004937;
	Mon, 26 Aug 2019 19:15:09 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id
	x7R0F8Z18962; Mon, 26 Aug 2019 19:15:08 -0500 (CDT)
To: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] OMAP IOMMU fixes to go with 5.4 OMAP IOMMU changes
Date: Mon, 26 Aug 2019 19:14:50 -0500
Message-ID: <20190827001452.31930-1-s-anna@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-omap@vger.kernel.org
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Tony,

The following 2 patches need to go along with the recent "iommu/omap: misc
fixes" series [1] that is currently staged [2] for a 5.4 merge and available
in linux-next. That series added runtime pm callbacks in preparation for
the ti-sysc migration, but without adding the necessary platform data
callbacks for the existing functional MMUs on OMAP3, OMAP4 and OMAP5 SoCs.
These 2 patches add the same to maintain the functionality (l3_noc errors
are the visible symptom while enabling the MMUs without these patches).

OMAP4 and OMAP5 would also need another set of fixes related to the
breakage caused by the switch to clkctrl clocks as seen in [3].

These patches do have a dependency on the staged patches, so either you
submit a pull-request towards 5.4-rc2 using 5.4-rc1 baseline, or let
Joerg pick these through the arm/omap IOMMU branch for 5.4-rc1 itself.

Sakari/Laurent,
Appreciate it if you can check the OMAP3 ISP functionality on latest
linux-next with the second patch. I have verified the ISP MMU programming
only through an unit-test.

Tero,
I will be submitting another patch against OMAP IOMMU driver to skip the
pdata callbacks for ti-sysc in the next couple of days.

regards
Suman

[1] https://lore.kernel.org/linux-iommu/20190809153730.GF12930@8bytes.org/T/#mec99f8e8ed351689f4fcc76f4f000f9144a02b51
[2] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=arm/omap
[3] https://patchwork.kernel.org/patch/11082125/#22829477

Suman Anna (2):
  ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
  ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU

 arch/arm/mach-omap2/pdata-quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
