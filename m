Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E0C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944DE2166E
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Ri4oDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944DE2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 230DC470E;
	Thu, 29 Aug 2019 11:18:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0FF4F4692;
	Thu, 29 Aug 2019 11:17:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A56FEC;
	Thu, 29 Aug 2019 11:17:55 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id w5so3622708edl.8;
	Thu, 29 Aug 2019 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Qw9TI/oO75bsTCfpr+cHjs+CGmEWrEJqDhW1Nr5mPhI=;
	b=S8Ri4oDngL/CuKTznOuFJut4kaqtLc9m6OEPBmcrmC9PTg98R4l6Ntojeqare4DfFw
	Ue+QAiofTOSeEn3E0/BxjOQLgEcmVTFzWxXf/RbFaYze8UQYLYXsmo8idr+2My4VQVHO
	xiQyF7kbM5iv+RsDvCU/qFLiwosQ4qE2PgBErmbwLqhtHhVnhy9ZxvLpK5PvWZK8+ra5
	TqQdfoKN+BbrZfXu4iysVRj4aZPP5GWU7rDJ2seuoGic6i98kGKTZABTaRT9p4b2Clsk
	wvL2evwLuZbxEu0B6knoORNMtSB0oGq3Ul3kTNAEVFmJUdo/iu0piqtwO8RTCzpdtAta
	+sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Qw9TI/oO75bsTCfpr+cHjs+CGmEWrEJqDhW1Nr5mPhI=;
	b=OkvZO2gpr8UVtONJb0DJuVa+u+jEadoYxzB+y55tni+AzNBTYYdQrr24lTBQ9OlAnD
	4QkOmMqYrahydSSY+Mu4YMiM6FyO+gKWqmdOtyeNh5da3sUWOOUgGXQnfyxUdpq9U6p6
	h4NdFHBk1vAHuga6FUxcaHSq2/tohCnXuQz9bUC4wlkEQsJV6Phmu173HdHmlRBbcowc
	DjigrOIT/oTG1FhFfrBmpNFDkbDzGh36ow+r+zOBEnWpe7KGe53R3mcXf99jiKutkhvd
	3pJOHHluuAtLUhpqlOmjfXF80BjSVFqJcNn3KeW5JOL6Qi2QZmjIpvo6k2/98fPRd3Lw
	O8Ag==
X-Gm-Message-State: APjAAAW2P3J+QbGdLlsbXoZyYGCSF4u7lDcHm+llqqG23QxApgGvyp6x
	m/imouE5+oP+2FI6aCZBaOA=
X-Google-Smtp-Source: APXvYqzf3VpKDNdxCgnDwyw+83rYA047IH5YU4ry9v57vAHMKEZsuLCcwInPPOQgF729h0A10YkaTw==
X-Received: by 2002:aa7:c81a:: with SMTP id a26mr9175586edt.26.1567077473918; 
	Thu, 29 Aug 2019 04:17:53 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id y19sm385592edu.90.2019.08.29.04.17.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 29 Aug 2019 04:17:53 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Thu, 29 Aug 2019 13:17:47 +0200
Message-Id: <20190829111752.17513-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Most IOMMU drivers only need to free the memory allocated for each
reserved region. Instead of open-coding the loop to do this in each
driver, extract the code into a common function that can be used by
all these drivers.

Thierry

Thierry Reding (5):
  iommu: Implement iommu_put_resv_regions_simple()
  iommu: arm: Use iommu_put_resv_regions_simple()
  iommu: amd: Use iommu_put_resv_regions_simple()
  iommu: intel: Use iommu_put_resv_regions_simple()
  iommu: virt: Use iommu_put_resv_regions_simple()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
