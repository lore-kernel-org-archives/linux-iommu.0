Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E11C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:17:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FF320684
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ojTbSggA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W8usSLa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FF320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4049D1609;
	Wed, 12 Jun 2019 07:17:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0AA615E9
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:16:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 94FBE87E
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:16:24 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 78EA560DB3; Wed, 12 Jun 2019 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560323784;
	bh=jKTJ9ZrZ6EFrkiwQkIMVckjzgUxXO6La0Ii8Ot5rqEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojTbSggAy0YXRJvvIBe8Egg4ggrE7DrLaIF7D3vM1KuEcKp1Ud/bYth1DGhryV4PP
	S4ipiJa2Cwb02jTT/UHbZ+vZyTAp73GUg7XTJcr1dUDaqFmrEtul2C1xXRVq3BtUxJ
	LOV4kG7SnqKPvgf1jABURIYc4wC2xdjFkNIM7YCo=
Received: from blr-ubuntu-41.ap.qualcomm.com
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DF9660DAB;
	Wed, 12 Jun 2019 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560323783;
	bh=jKTJ9ZrZ6EFrkiwQkIMVckjzgUxXO6La0Ii8Ot5rqEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8usSLa8PJFP9GOoYaVgym2ZNLcyks5Bh/JQnF1ZcfwOl3yeFiTQE/SqSdN82nBAE
	DqshXc8mF7tK2uhUC5J1i8dEw5SZj4VGZS0wl03Xt8fT2lYtaeHK8nKGwpQRHW40nL
	6BQj40xQNR9d9gRHZbVI0C/ZIuLkFsOsbe1s6lmQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DF9660DAB
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: agross@kernel.org, robh+dt@kernel.org, will.deacon@arm.com,
	robin.murphy@arm.com, joro@8bytes.org, bjorn.andersson@linaro.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe sequence
	handler on MTP
Date: Wed, 12 Jun 2019 12:45:54 +0530
Message-Id: <20190612071554.13573-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
Cc: david.brown@linaro.org, linux-kernel@vger.kernel.org
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

Indicate on MTP SDM845 that firmware implements handler to
TLB invalidate erratum SCM call where SAFE sequence is toggled
to achieve optimum performance on real-time clients, such as
display and camera.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 78ec373a2b18..6a73d9744a71 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2368,6 +2368,7 @@
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
 			#iommu-cells = <2>;
+			qcom,smmu-500-fw-impl-safe-errata;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
