Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38BECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:29:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08102086A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3jhicXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F92EE8D;
	Tue, 15 Oct 2019 16:29:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 986D6E8C
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C4036C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:49 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id v8so24667959wrt.2
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wAzFGzcLL6WAf/z3cyyzneFzX1+V+N4hjXrOwquZa2M=;
	b=o3jhicXQtmz/DSOHvCOjnMHpFbXGymx2Ki6YJHEo/oMfzY26egQxgfjGfk9kZPDrZE
	5yAcYuRtfXxm4M1BktchOWRwOo8l/X8yr8H+rqG34ntMVZVINVqy/QIInxfUBQbfjdal
	U+m5NwKC2SgEopbD+0MjwJcmG/MAloEeuNyT2Eoom2y+Pc0Dhb411nx1OO9m+NOTqL5X
	sXOdDN9BFEE6n5dfWw/+CUSiqMkXZDqQfFVE7ai0ZE2g72S+Q864RwMXBGwQK0HyvKPJ
	IYbCZpkDW15WuGLU+9eGWXOyAmKk/DELFjG6unChFzgzbAzogAezXw0zPeJzDGUbd72S
	lYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wAzFGzcLL6WAf/z3cyyzneFzX1+V+N4hjXrOwquZa2M=;
	b=A5NcrlGNwjR1G7QnmPc3DEKsFZSTkuoc7Cf7kgQDlUufgp1UaQBVBsCLFKuYshDjaa
	tBYcU9ITjz09vRLeAMhQyXY7O7aEp8SeCNYhQROPzd9j/MV4az8pFbZjqkVtoL4W2mv0
	i5CxB0UXSmmKRb72XK2bZy0zmimCElWiXDWgwpoTSuaOhPetnEb/QiwL1zuKPjZF6JFK
	nK1XEw7z5BvWEYRcG0BtqbcDruNUv49axvLuvL/F63zOL5suuHWknvF1NYDuHm1Yusdk
	qze7pdCI6p5M5dPkNrY4MT2K3RW5e2XxI3Qegndas4qZH2O28s+h6ipmLxxswbroifhX
	79ew==
X-Gm-Message-State: APjAAAVYoB+GhqoKBwGwEfNfX5w//CCjb8LkLDfJAwjiwIVNZmbJsdep
	6BiMwCb/DHKx8pXanEEdvkw=
X-Google-Smtp-Source: APXvYqxY8m6ws0Ps/xNd97nA9lPYvlg6lXyRj0BOkqvzazf9zbQrmyXVV6Scivg7OpPzYnTBcU98ew==
X-Received: by 2002:adf:c98b:: with SMTP id f11mr33393097wrh.274.1571156988431;
	Tue, 15 Oct 2019 09:29:48 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id
	q19sm45324010wra.89.2019.10.15.09.29.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 15 Oct 2019 09:29:47 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 0/3] Introduce memory controller mini-framework
Date: Tue, 15 Oct 2019 18:29:42 +0200
Message-Id: <20191015162945.1203736-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi,

this series proposes the introduction of a mini-framework for memory
controllers. The primary use-case for this right now is to allow for
drivers that depend on the memory controller to defer probe until the
memory controller has been successfully registered.

One example where this is needed is on Tegra186 and later SoCs where
the memory controller needs to program some registers to associate a
stream ID with memory clients. This requires that the IOMMU driver
defers probe until the memory controller has been registered.

This is achieved by providing a trivial memory controller registry that
can be queried.

I haven't written up a full device tree binding for this, but if people
think this is a reasonable proposal, I can flesh things out. Currently I
use something along these lines on Tegra186:

	mc: memory-controller@2c00000 {
		...
		#memory-controller-cells = <0>;
		...
	};

	iommu@12000000 {
		...
		memory-controllers = <&mc>;
		...
	};

Thierry

Thierry Reding (3):
  memory: Introduce memory controller mini-framework
  memory: tegra186: Register as memory controller
  iommu: arm-smmu: Get reference to memory controller

 drivers/iommu/arm-smmu.c          | 12 ++++
 drivers/iommu/arm-smmu.h          |  2 +
 drivers/memory/Makefile           |  1 +
 drivers/memory/core.c             | 99 +++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra186.c   |  8 ++-
 include/linux/memory-controller.h | 25 ++++++++
 6 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/core.c
 create mode 100644 include/linux/memory-controller.h

-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
