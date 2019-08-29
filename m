Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7AC3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D16220674
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqZSmeLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBEE946FA;
	Thu, 29 Aug 2019 11:14:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2323146E7
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:14:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A584EC
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:14:10 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id d16so3406296wme.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JD+FPst1Rc2Zts2/SszFlnm8yp7vNf5nv1OwzcG2Ea4=;
	b=oqZSmeLw/EC3Wd0txJnCJRoJzOmmCY56LdWnG2oKlSLUljtbZSUQpyV71svWYX9r4a
	nHrLUveNwTmd16rB8M0PNaaiHRW9/d9Jzb+ru281rX04x3PB0KLs6Bxo9dZhgg3PBQFW
	umAZcpfdKECX/Caf4nntQFZS79CEf3J/8mswG+70D4oIMuQx8+TODriRJQp7/uBp+oU5
	YIObXT9Hj6in32E9rNwbWdIBzc4LDYhJhYYXS/l+iGNtrtqtMpUu2iJVEpFcGHwVmcvO
	WGWAc/knxRIl1thWtrjKuOJ1V9Y4XxiGwiQTYNaoVFkMGCE0Z/PiqW4tcKI0ZlzxpjIS
	qzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JD+FPst1Rc2Zts2/SszFlnm8yp7vNf5nv1OwzcG2Ea4=;
	b=oB+h/RRdHX1/SVbs0ObvPKv0Vj2li+ewQTnP5fTAc2BeFBsN2nYjcqK9zZHfhyjvLb
	T53ceJEljwMc/HxygVZ5tDl2HJABnEnp7SWb9ltwOnSbtkeOh2FRc+Iqkx4veYwVmUxk
	KZoSkND0A5ijnDHAmF+0nSoPk0lJmVJTR7cDSDO9KyZ9+r6wPvYuFClUJ15itL9CuaUq
	V4w+G0X2UAtQuNkdslCHyfIPpV+Ff0UAZPnqocYr5o0UDpVeAqVKLv0D4E2SUxOKVQ2k
	wPvEitzlZdz0bpmlT70jiC8LIde/fjyeJlIDT6+HfANGYJIVREunEvO5OoqbgfE+1DP7
	R9mA==
X-Gm-Message-State: APjAAAWVsOcl+IDwFM7/cKEq2Ij3gt61PLeHduP6i48Ei5XBAFbtWuYc
	oYaUxzSpPkR7pwxUv0swOJ4=
X-Google-Smtp-Source: APXvYqzcmuDvPpuvAAO8pn2NqELxI3Y0KBVVxn316XZ2m3inkhdiVtyJlblr8PnZhlxEiSikUNWvPg==
X-Received: by 2002:a1c:ca09:: with SMTP id a9mr10586744wmg.43.1567077249051; 
	Thu, 29 Aug 2019 04:14:09 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id
	l62sm3469749wml.13.2019.08.29.04.14.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 29 Aug 2019 04:14:08 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu: Support reserved-memory regions
Date: Thu, 29 Aug 2019 13:14:05 +0200
Message-Id: <20190829111407.17191-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

These two patches implement support for retrieving a list of reserved
regions for a device from its device tree node. These regions are
described by the reserved-memory bindings:

	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

These reserved memory regions will be used to establish 1:1 mappings.
One case where this is useful is when the Linux kernel wants to take
over the display controller configuration from a bootloader. In order
to ensure that the display controller can keep scanning out from the
framebuffer allocated by the bootloader without faulting after the
IOMMU has been enabled, a 1:1 mapping needs to be established.

Thierry

Thierry Reding (2):
  iommu: Implement of_iommu_get_resv_regions()
  iommu: dma: Use of_iommu_get_resv_regions()

 drivers/iommu/dma-iommu.c |  3 +++
 drivers/iommu/of_iommu.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h  |  8 ++++++++
 3 files changed, 50 insertions(+)

-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
