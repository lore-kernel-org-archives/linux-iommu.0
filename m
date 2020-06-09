Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B30C433DF
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7EE20737
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="M8PvEfs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7EE20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3863D8893C;
	Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hk2Yz80zrGaN; Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9F809888A7;
	Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7498AC088C;
	Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 343D3C016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 19:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2FE1587173
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 19:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJjEB45rHuOX for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 19:48:50 +0000 (UTC)
X-Greylist: delayed 00:08:16 by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 023688716B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 19:48:49 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id c185so22072892qke.7
 for <iommu@lists.linux-foundation.org>; Tue, 09 Jun 2020 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fooRxBUyxBVZY7kJJL8VBy6grxiTlxx+OOYM9dBJ/2A=;
 b=M8PvEfs14mubrLj1XaXYuw77/9Sq33tjev7K9cNSQaxOHDR6yrSRTFwfmH4RdcsptN
 clItDCqBLGzhMO6BQxz8iY+SD7ORaFgogN0+hGx3LhLx2U5if5zrUtze9Cvuqx2wWmyf
 rVWn2umVU71LVwdc9Y1ADjYiP3GYlZBhLhBYHkT9ZvvGyzJj/7/lKO1Qfa3N/42fl1hk
 wj9BQXiP3HLYmgLp0xcIf6ahnjNgYmYP2y2OzCIQKvx3vfjKou6iKGKCX6eZFp5CVQoa
 bnB0dIKg22iA7Iv6XuLQCJATB1ao2T2Nm3oZNEVNKJDKHvUSmTPUMgV7nCcwWSdoExnm
 BmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fooRxBUyxBVZY7kJJL8VBy6grxiTlxx+OOYM9dBJ/2A=;
 b=T6XIT07pW1Alm33gkW3KeF80Hm1SdurWa08U1Rn7O6XmHTQLsqQEE+6UXQNxaLpJc5
 0ctf8Ugy/jFDQkHXZMFEUuNvt/sQcW771GCo39+kH0a/eT7FB++YpK/DAGYzFVRFcojk
 u/yDZGDlSB4o0vJ3Ew2rX9K9fNlWQGy2yWn2IsR35K1sUCtyq9B9giIVsKejrBuAKzD7
 PvjV9sbc0oYJXbQrtDJIwjpLjq3jex4sPuHbVQJ1JPj2e/dnH2hWnY0tz/7O+6QuBZfh
 US63ZPuofL6NUUWmyETeiKr4taWl9/tKIRZCIOUWHgf4jj5zgU1SdL4GKi6oZm+TebMZ
 6JgQ==
X-Gm-Message-State: AOAM533w/G3P3aUatkhpT1hpX/t29u80yjWfv4ET5ZtHhO4JVvOrizSr
 EWQjPWxlJqG1bCEIv5lbMsCQZa4C2mbxuA==
X-Google-Smtp-Source: ABdhPJyBKbeiX6PPFfn4v6iP/rDxW8LkNd+ZfOa5pftTCgh+62D/kuaiIKUv+4K4cVgbFk/e+K0MsA==
X-Received: by 2002:a05:620a:153c:: with SMTP id
 n28mr29203054qkk.457.1591731633704; 
 Tue, 09 Jun 2020 12:40:33 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
 by smtp.gmail.com with ESMTPSA id v8sm10513181qto.21.2020.06.09.12.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 12:40:32 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: dts: qcom: smmu/USB nodes and HDK855/HDK865 dts
Date: Tue,  9 Jun 2020 15:40:18 -0400
Message-Id: <20200609194030.17756-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Jun 2020 20:16:08 +0000
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.

Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
few changes. Notably, the HDK865 dts has regulator config changed a bit based
on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).

V2 changes:
* Added two patches for sm8150 and sm8250 iommu compatibles
* Changed apps_smmu node patches to use new compatibles
* Updated commit messages for apps_smmu patches to be more correct
* Updated HDK dts patches based on Bjorn's comments

Jonathan Marek (8):
  dt-bindings: arm-smmu: Add sm8150 and sm8250 compatible strings
  iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles
  arm64: dts: qcom: sm8150: add apps_smmu node
  arm64: dts: qcom: sm8250: add apps_smmu node
  arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
  arm64: dts: qcom: sm8250: Add USB and PHY device nodes
  arm64: dts: qcom: add sm8150 hdk dts
  arm64: dts: qcom: add sm8250 hdk dts

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts       | 463 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 180 +++++++
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts       | 454 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 287 +++++++++++
 drivers/iommu/arm-smmu-impl.c                 |   4 +-
 7 files changed, 1391 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-hdk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-hdk.dts

-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
