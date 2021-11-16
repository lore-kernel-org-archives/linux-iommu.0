Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD2C433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7591D61507
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7591D61507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25D16607E7;
	Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oC8KdEPWfKH5; Tue, 16 Nov 2021 11:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED34060648;
	Tue, 16 Nov 2021 11:52:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1A42C001E;
	Tue, 16 Nov 2021 11:52:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 583B2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DD5C40457
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id behRz7yQkea7 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 11:52:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5912F40237
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:15 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id s13so37064020wrb.3
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7+tviJRIIqKFH/joMd9Q2VuwL2kp++/vcVTuNBiLmTY=;
 b=HuQiMtiZzY3tdoruvkLz+dFNF4HPYoYbLJTFSRlg4HRZnlHKcnqq1IoO4ZwobFLcRC
 BQZ6XgkY4SsDEhJKABgXqn/SfHerqbyeRYxCM0hy3QXPz3W6CFGZdEbDHxlmtyQ+BKgp
 VW9hUr6mhhmm2e4Y20CvwcO/knaFw/blt4cbVZHY6YcS0BlYchEgzdel/4n5GYIl1M1k
 a01lUXY5YzDpacvANaEX2KcmlG5rrkTYYLlbv1TQJjULgaC00SfTJOL0s7SMq9TKFYSE
 4WRItc2FbEBFER611wRJJ/I1iKKcxSapImMYriUx2q0dowq8HHTxXFHAyolm2jnb6EDK
 5dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7+tviJRIIqKFH/joMd9Q2VuwL2kp++/vcVTuNBiLmTY=;
 b=asC46clg7possmj+VNVtuhClTlQIMcd7rijHAGnNqId3HGSKYaT6whLIJMZzdr2jMq
 cVhVjQZPVQsBoxrXooYIDQTUFh3zVT/g4zToFspqQ2f6TiqxvQnQVy1iN3ucX0lb5wgi
 S8Var/KjOjne+Z6+6o7ijj5QwUJWlaDjg+9asM8jBiIr/z6KMy44b20Pk2vRri3daWjR
 iAVYPikmqstIu0ZYxosKjNdGjXRMfZjPAE6fBXY2C78ZK0lMWU87/cjEiMqCOa+yntQB
 pJpVIkcxa07HqVnXrwyjuPydXB8DbB8oTGs2lSmRA0lukj7BkDlcoQlkvnlUlxSxcvBD
 WRCw==
X-Gm-Message-State: AOAM533rIvg7E9kBHyrj/VfRzzU537P1vJVO0WEj7ugNCiPfQUNcrxVZ
 XH6QunhokJNaMmTMXKDgduUkGA==
X-Google-Smtp-Source: ABdhPJzoIAXoYG38x1WM1fYsQvGCoCy5YoncrC23En2Ic65ARoZ2im8YfvNnsAezImOGHOPPsguxAA==
X-Received: by 2002:a05:6000:144a:: with SMTP id
 v10mr8881733wrx.315.1637063533400; 
 Tue, 16 Nov 2021 03:52:13 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id b6sm2232846wmq.45.2021.11.16.03.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:52:12 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH 0/2] perf/smmuv3: Support devicetree
Date: Tue, 16 Nov 2021 11:35:35 +0000
Message-Id: <20211116113536.69758-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
multiple independent PMCGs, for example one for the Translation Control
Unit (TCU) and one per Translation Buffer Unit (TBU).

I previously sent the binding as reply to Jay Chen's thread implementing
device tree support [1]. This posting addresses the comments from that
thread.

Patch 1 adds two compatible strings. "arm,smmu-v3-pmcg" is common to all
PMCGs. "hisilicon,smmu-v3-pmcg-hip08" allows to support the same quirk
as IORT for that implementation (see patch 2). We'll probably want to
also introduce compatible strings for each implementation that has
additional perf events. For example the MMU-600 implementation has
different events for TCU and TBU PMCGs [2], but both components have the
same device IDs. So the driver could differentiate them if they had two
distinct compatible strings such as "arm,mmu-600-pmcg-tbu" and
"arm,mmu-600-pmcg-tcu".

The series doesn't deal with this because for testing I use a software
model which only implements architected events. I do not include DTS
change for that platform because enabling PMCGs requires an additional
model option. See my branch smmu/pmu-dt [3] for details.

[1] https://lore.kernel.org/all/20200707150114.GC159413@myrica/
[2] https://developer.arm.com/documentation/100310/0202/Functional-description/Operation/Performance-Monitoring-Unit
[3] https://jpbrucker.net/git/linux/log/?h=smmu/pmu-dt

Jean-Philippe Brucker (2):
  dt-bindings: Add Arm SMMUv3 PMCG binding
  perf/smmuv3: Add devicetree support

 .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
 drivers/perf/arm_smmuv3_pmu.c                 | 25 ++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml

-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
