Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDFC10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D0E20873
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gRP9xKna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D0E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 472E720773;
	Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tNXE0j29sR1g; Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6D336203AE;
	Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A22C18D3;
	Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7979BC0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6816787238
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kA2whcrelDJI for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 18:23:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B30987233
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:23 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1583778203; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=GX+dz/is320lqcSRtGzhyX1xm5hzo2sSwZB3Hj6u3VU=;
 b=gRP9xKnabFUKKDMX9Nrnk2NPRFhiRvSo9jaBVOwn8CD1DZvygZXbZFfGFvMcgQXcRocxsE3y
 NfeyVN/J4zUs0GjWxOJqiDPUZ8vTzRIaIHMwMZ/6XG+UBCNUqduT7ceG/Xee34luE67whyQX
 AjQptlVnbG1lRoTDV6jBLg7EKVQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e66899a.7f682ddad490-smtp-out-n01;
 Mon, 09 Mar 2020 18:23:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C7124C44798; Mon,  9 Mar 2020 18:23:21 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A1FBEC433D2;
 Mon,  9 Mar 2020 18:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1FBEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org,
	robh+dt@kernel.org,
	joro@8bytes.org
Subject: [PATCH 0/3] Request direct mapping for modem firmware subdevice
Date: Mon,  9 Mar 2020 23:52:52 +0530
Message-Id: <20200309182255.20142-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Mar 2020 18:47:56 +0000
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org,
 Sibi Sankar <sibis@codeaurora.org>
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

The Q6 modem sub-system has direct access to DDR through memnoc and
an indirect access routed through a SMMU which MSS CE (crypto engine
sub-component of MSS) uses during out of reset sequence. Request direct
mapping for the modem-firmware subdevice since smmu is not expected
to provide access control/translation for these SIDs (sandboxing of the
modem is achieved through XPUs engaged using SMC calls).

Sibi Sankar (3):
  iommu: Export "iommu_request_dm_for_dev"
  dt-bindings: remoteproc: qcom: Add modem-firmware bindings
  remoteproc: qcom_q6v5_mss: Request direct mapping for firmware
    subdevice

 .../bindings/remoteproc/qcom,q6v5.txt         |  4 ++
 drivers/iommu/iommu.c                         |  1 +
 drivers/remoteproc/qcom_q6v5_mss.c            | 68 +++++++++++++++++++
 3 files changed, 73 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
