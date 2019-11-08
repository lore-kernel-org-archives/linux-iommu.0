Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E6FC6199
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526402178F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr+E9RT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526402178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 87408E4C;
	Fri,  8 Nov 2019 15:26:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9547BE0E
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C13F196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:50 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id c22so6645549wmd.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xkWcxJ6Iuy+TFzutOZwKsDdjGV2W0A5RS2sI5DD8vzM=;
	b=rr+E9RT1m3Uo7HDUww3oQBuqgMwd4smQJlm1F51cGsAn5yxcXpfWYxrw5HNGAbAN0T
	vCuV/pFnYtG6J/pA8tYatmkzzIt46o+Dibijb10+j8gXZtsXmaPI2hVExy0xaTPM1pUw
	jWyJ4iAp0CaA+2OriDDPyVEAYwIpVTS1sbFx5qbFpaZE0rXPjKfyiWXPnoRAZqG++wEI
	quuvaGA4UYD7FneNYZe2huxUVlofu3I9+CDwSJXYrb2yPBxitzAAjDVaYj/cfBnZTpZK
	Q/VnQBsoVhbXhLUrHkrWvVm1kgTuEYPkBFnVWoN8dc8lROj6lv/76Wr+Dt4SpoqAyU3N
	Cv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xkWcxJ6Iuy+TFzutOZwKsDdjGV2W0A5RS2sI5DD8vzM=;
	b=gB8aUa1ADhjbzVciQ4xWq3PwDRB75+Yt+apzZMx6p/CJoSGnpESyrilgSxDuN59ZDq
	Fw+A/BCyhNvYDHjQTwYZgiYW16gpqmAmqS8eQOAr9j4qJhdmVGcToCD21dmWg8Pkclim
	Ceb666DBmlZZMO1GkG8FcZskWuOMQvnAFTypdM9GxfsXYRhIqQ/I9NU10ZiGIfMJLfFl
	D2O6R/wSaEsSPJ4dZDEFeTvMHmxA8KTCJuCvM0vq45x0eceHaSo/3wBQ1yE9dJQgLfkA
	aAnTWpzygQg8kWGPuQIaoLMYziySxi3xWaKQu/2Kefv983WUiy7tNov8ycZhML3pATSR
	Qeew==
X-Gm-Message-State: APjAAAX7ptCwYt0iivXJRHGEZHRTYk3NGhLDJJk7B8hYY8o9K+Wig3Sp
	KODbrprQQllr8Hy9F+57be1uHvyytvimYg==
X-Google-Smtp-Source: APXvYqx/xuA1TPNnHqIK0UYk9J6qHcyjmZQq/kaCmKhNSU7fNuxym1Kdo6WOQxPLxhdoo0A3JfJ3WA==
X-Received: by 2002:a05:600c:210b:: with SMTP id
	u11mr9006014wml.170.1573226808499; 
	Fri, 08 Nov 2019 07:26:48 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:47 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/8] dt-bindings: document PASID property for IOMMU masters
Date: Fri,  8 Nov 2019 16:25:01 +0100
Message-Id: <20191108152508.4039168-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
	rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
	zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
