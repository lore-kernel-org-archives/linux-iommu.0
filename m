Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A9C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A3D2146E
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgw2AFNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A3D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E79F126D;
	Fri, 27 Sep 2019 09:09:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D0E2E1271
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 66A408AE
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:53 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id o18so1791601wrv.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DcoXTe9dNwBaF2/Bo9GV5mnsjAEgDdrMOllPSgWYRss=;
	b=Bgw2AFNPLRUm3YYSBZP2ZE7l81crt9WSD0IVV7pteiJl8qQnHYcuIHKFcs2sG4Kyjf
	UsRfIklG0dcvegKHMCPxhAe5BCzrptgv1EQsT7xXORTFINXboWI1aVa/l7epo6PnhRby
	MVVrwmGUs/0dJuOnO/poU5UDpURk1XgsfUYjPrKaYYq4qe3IyFD9NV1SheLk4RtZt33n
	pZ8y5R5AlV2lPbEW4p/DY4NIckdUAMBFwTp/6T3dxenPhmNzOreWfESTbvYGia0IdkS4
	dIYEQpGjv3xofDS9xfhvT/3uNjk6kwqEApZPnzcljeSaB/XsJbvpllsX+AL8Zz5lWrFw
	2f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DcoXTe9dNwBaF2/Bo9GV5mnsjAEgDdrMOllPSgWYRss=;
	b=jGsrC818e/LSC0e/VOdwOnoo+6/UL8BJqnZSLhr4vIezRrJfoREzQlcGbunbPZyMqu
	Lr3zBjImAuSVyQ0P21w/bvJt+joSDc8GSuzb79YmHBcvWx3Bc5Q2aNMnVaVwNGiYvm77
	OhLtZNMvU3hG4KGqeJFFwW4ayNEXbHfV7ZR4PRN6CiqlW8rHlsiuqwG5V4NtZRgjtBTL
	SULzedc8TiOIRtTGtxCN7q6AI48/1Qz+AxO0ZhyHY9uq7cwE4q0BJIAa916LBjFUikzZ
	CrNoMdbOnJay2PBHgNgDLfLXL0LQi5AS+xk2RKnzubv6sepNLyaYyzbajqtw643dO7HB
	S+og==
X-Gm-Message-State: APjAAAV3PulHcNn6RjcSIGXX7bedI8IcdV18UWoXnPuSd2H0p0ZowvPM
	6W7MEOeUsa1G20ztu4Y0oJY=
X-Google-Smtp-Source: APXvYqwcEycl8WD3DT7TUMtQq5bvTI3kyR4zV8aM3v5EcQrLSSNezEcb/DMx1zRGDckKZuoBeE7pfw==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr2140801wrn.231.1569575391806; 
	Fri, 27 Sep 2019 02:09:51 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	b62sm6037791wmc.13.2019.09.27.02.09.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Sep 2019 02:09:51 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/6] Add support for QCOM IOMMU v2 and 500
Date: Fri, 27 Sep 2019 11:09:41 +0200
Message-Id: <20190927090947.11175-1-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	AngeloGioacchino Del Regno <kholk11@gmail.com>
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

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Some Qualcomm Family-B SoCs have got a different version of the QCOM
IOMMU, specifically v2 and 500, which perfectly adhere to the current
qcom_iommu driver, but need some variations due to slightly different
hypervisor behavior.

The personal aim is to upstream MSM8956 as much as possible.

This code has been tested on two Sony phones featuring the Qualcomm
MSM8956 SoC.

Changes in v2:
- Fixed optional properties placement in documentation

AngeloGioacchino Del Regno (6):
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/qcom: Write TCR before TTBRs to fix ASID access behavior
  iommu/qcom: Properly reset the IOMMU context
  iommu/qcom: Add support for AArch64 IOMMU pagetables
  iommu/qcom: Index contexts by asid number to allow asid 0
  iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500 secured contexts

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   5 +
 drivers/iommu/qcom_iommu.c                    | 133 ++++++++++++++----
 2 files changed, 111 insertions(+), 27 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
