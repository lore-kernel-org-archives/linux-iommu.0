Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18349C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8D2206A1
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv2D/j9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8D2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B97151023;
	Fri, 11 Oct 2019 03:57:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 979ABF0C
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4F99814D
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:15 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id q24so3791583plr.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=lwaGexEIk4Tlv5FRwTaoLvYkPu+sAPH7np80Oye+n20=;
	b=Tv2D/j9IhiVwpOomkMei9mX/yftFh3M+jMXDqPObnbTzNhkl3Vbwz8nfJt804LsPWh
	IciDobUmz3EIfjwukLWZxWxft7TKG+lQlr1HIcNDIM95T5GmFnxBh0PykfqcZUF7nGuJ
	st/oFLIiOnlYOIsi/QPu+nMU9JawJsEhsXlo7oBSWtOMGGgZplUJRBzKreEHEFhxtKnF
	kIENpylMwCncC7haXNujmrB+OKFJ0oMJFyyhOZW+jCRvJpupe0S8Wr3g0q9X106g2d15
	vGR81cJiKSNy/G4YPrbEaW/YduaOG9S5kuIaOYGcKC5oHBox9NzEtg9IAVveiZnhtEAT
	HDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=lwaGexEIk4Tlv5FRwTaoLvYkPu+sAPH7np80Oye+n20=;
	b=gdNrxq53d+QFsEGAXTW29d8jbZU/jP4SwH75ZeAnL22Z7ueSbKDQF425JIumj+3Oqe
	B/q46AypdtCLlryEHzpcV1vE04cLRHzZEbIHKVcZRaIG3vYz4Jx7hLiazaha/ANjE2uD
	CgNulCpFL6HZ1B6oL02pkWGUJy+fPzG865DRkREM8b1l59A5AsDKuxLmwRwhcB5Jw7WE
	ioEAOUvVkuTbsphjIOrnsghshHmm8sPUcTkOYgnC0D1CRjoH/Xl8eM2MRSxOSLgKU4O5
	fl02to5B6hnM5JyvQrHVf5IK0kJ3YvUBcvIvJnXieoLQfoyJ/YeAqU/8pWt0kLeFTqMh
	bzcg==
X-Gm-Message-State: APjAAAVRTphEwmTQ5X485gS8LbGfXpWsgrCHIppD9+wGn8kd6h8GsFur
	Wrgw3m6O8sZYnA+v4hSK1Sg=
X-Google-Smtp-Source: APXvYqyR1rmTzHQKhSUn3T3BkL6TnScR8FJqXArtRUVHc2yY16j/jZMdOqQe/IiJJA8w+1/i2ZTwMg==
X-Received: by 2002:a17:902:ba95:: with SMTP id
	k21mr4891378pls.49.1570765634586; 
	Thu, 10 Oct 2019 20:47:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	u3sm7493267pfn.134.2019.10.10.20.47.13
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 20:47:13 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size"
	property
Date: Thu, 10 Oct 2019 20:46:07 -0700
Message-Id: <20191011034609.13319-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series of patches add an optional DT property to allow an SoC to
specify how many bits being physically connected to its SMMU instance,
depending on the SoC design.

Nicolin Chen (2):
  dt-bindings: arm-smmu: Add an optional "input-address-size" property
  iommu/arm-smmu: Read optional "input-address-size" property

 Documentation/devicetree/bindings/iommu/arm,smmu.txt |  7 +++++++
 drivers/iommu/arm-smmu.c                             | 10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
