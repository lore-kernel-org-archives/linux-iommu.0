Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EB6C54FD0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:34:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223CA2074F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v4sllP8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223CA2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCAAD88182;
	Mon, 20 Apr 2020 18:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7bh2gcRBCDx; Mon, 20 Apr 2020 18:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4607087D56;
	Mon, 20 Apr 2020 18:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22299C1D74;
	Mon, 20 Apr 2020 18:34:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7709C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D5F6886932
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhoFMkDkEYW2 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 18:34:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7072C86930
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:34:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587407646; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=lDdMNhQybqsQtbAqEgBb/XrE+d1a0X3/rjZ+QCjMTco=;
 b=v4sllP8YLEu8m8g1yTouV8rbIYLyed8hejgLutODvs/CMTA7/9HZAE8zaz/3Zk+0/MansAp+
 VUvCS6GR5zudXpIlqYS2qsIyJxOoBOOuHPjkQqKV78fdjEWLJ29uKmoTq4wjx8+ym7QctR7N
 qs0ZpwrqbFG/wr/HeWBIbOVQz6s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9deb1d.7fb7772125e0-smtp-out-n04;
 Mon, 20 Apr 2020 18:34:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 593D2C433F2; Mon, 20 Apr 2020 18:34:05 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 77763C433CB;
 Mon, 20 Apr 2020 18:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77763C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sibi Sankar <sibis@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>
Subject: [PATCHv4 0/6] iommu/arm-smmu: Allow client devices to select identity
 mapping
Date: Tue, 21 Apr 2020 00:03:48 +0530
Message-Id: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org
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

This series allows DRM, Modem devices to set a default
identity mapping in qcom smmu implementation.

Patch 1 is cleanup to support other SoCs to call into
QCOM specific  implementation.
Patch 2 sets the default identity domain for DRM devices.
Patch 3 implements def_domain_type callback for arm-smmu.
Patch 4 sets the default identity domain for modem device.
Patch 5-6 adds the iommus property for mss pil.

This is based on Joerg's tree:
 - https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2

v4:
 * Updated commit msg for mss pil requesting direct mapping

v3:
 * Use arm_smmu_master_cfg to get impl instead of long way as per Robin.
 * Use def_domain_type name for the callback in arm_smmu_imp as per Robin

Jordan Crouse (1):
  iommu/arm-smmu: Allow client devices to select direct mapping

Sai Prakash Ranjan (2):
  iommu: arm-smmu-impl: Convert to a generic reset implementation
  iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back

Sibi Sankar (3):
  iommu/arm-smmu-qcom: Request direct mapping for modem device
  dt-bindings: remoteproc: qcom: Add iommus property
  arm64: dts: qcom: sdm845-cheza: Add iommus property

 .../bindings/remoteproc/qcom,q6v5.txt         |  3 ++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  5 +++
 drivers/iommu/arm-smmu-impl.c                 |  8 ++--
 drivers/iommu/arm-smmu-qcom.c                 | 37 +++++++++++++++++--
 drivers/iommu/arm-smmu.c                      | 12 ++++++
 drivers/iommu/arm-smmu.h                      |  1 +
 6 files changed, 60 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
