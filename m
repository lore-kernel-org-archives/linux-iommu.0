Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B7C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 16:40:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6294613D8
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 16:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6294613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0DD34054B;
	Tue,  6 Apr 2021 16:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALQ1kVjaehbk; Tue,  6 Apr 2021 16:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8783440109;
	Tue,  6 Apr 2021 16:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55F3AC000C;
	Tue,  6 Apr 2021 16:40:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA7DC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0222284A1F
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6NEV0Dx-E1mv for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 16:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BE3A84A1D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:37:10 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GZQ03100512;
 Tue, 6 Apr 2021 16:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=54xdP4UfJjTEKOCwjGvefkJl3tOpBsoNuArXb7g+ZC4=;
 b=pT1YE90PPPCiq1CIWl8XQH6Bu3q6ZaA7r/8GkEFtvgbKpnYXJjHrVWQF2kPL98XexEOd
 SHc2PbJ8XJ3eVCPJ6hPR90ecYbrNXU/y6hw5MQPlOF9ARxsncy+G6TOworox/JhjahPs
 TwidN7sMYqxvjKRZ5GBcAS3PjgtChnrnZz1LGIjFPV0teAzkbjixzzuNBDOrTXx855Yt
 4qzRFHfu2ico3B3wbrKqHWa5humGhYTIa4RYmPyIIbdND/f06T4dDtiNfaMNNj0Gs/ti
 rw5WJGCeCkX55gEgeNS+LW2YxSdEz5kbuWTm+4rwhJHdAzi7nCxJ21sENWqrqGrIoo0j qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 37qfuxdgka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Apr 2021 16:36:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GZt1t155979;
 Tue, 6 Apr 2021 16:36:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 37qa3jpsf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Apr 2021 16:36:48 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 136GalRL160127;
 Tue, 6 Apr 2021 16:36:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
 by userp3030.oracle.com with ESMTP id 37qa3jpsf0-1;
 Tue, 06 Apr 2021 16:36:46 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: 
Subject: [PATCH v5.4 1/1] iommu/vt-d: Fix agaw for a supported 48 bit guest
 address width
Date: Tue,  6 Apr 2021 09:35:34 -0700
Message-Id: <20210406163534.40735-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Proofpoint-GUID: 6YEVIvROgVzTKHZpJSxKjieOWVJdhLTU
X-Proofpoint-ORIG-GUID: 6YEVIvROgVzTKHZpJSxKjieOWVJdhLTU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060111
X-Mailman-Approved-At: Tue, 06 Apr 2021 16:40:18 +0000
Cc: saeed.mirzamohammadi@oracle.com, Camille Lu <camille.lu@hpe.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

The IOMMU driver calculates the guest addressability for a DMA request
based on the value of the mgaw reported from the IOMMU. However, this
is a fused value and as mentioned in the spec, the guest width
should be calculated based on the supported adjusted guest address width
(SAGAW).

This is from specification:
"Guest addressability for a given DMA request is limited to the
minimum of the value reported through this field and the adjusted
guest address width of the corresponding page-table structure.
(Adjusted guest address widths supported by hardware are reported
through the SAGAW field)."

This causes domain initialization to fail and following
errors appear for EHCI PCI driver:

[    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
[    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus
number 1
[    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
[    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity
mapping
[    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
[    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
[    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
[    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12

This issue happens when the value of the sagaw corresponds to a
48-bit agaw. This fix updates the calculation of the agaw based on
the IOMMU's sagaw value.

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Tested-by: Camille Lu <camille.lu@hpe.com>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 953d86ca6d2b..396e14fad54b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1867,8 +1867,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
-	if (guest_width > cap_mgaw(iommu->cap))
-		guest_width = cap_mgaw(iommu->cap);
+	if (guest_width > agaw_to_width(iommu->agaw))
+		guest_width = agaw_to_width(iommu->agaw);
 	domain->gaw = guest_width;
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
 	agaw = width_to_agaw(adjust_width);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
