Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A878470440
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392654; cv=none; b=OFted8v2PZluNI/SJX8816Dw6BdMovlQMTh9+CN8kpp9dbKUshDMAdCPiOLLb+gpj8a4fE2IKWE6xXYqs9pNO3X2e9io7vd6q8ONWd024YBNoEaj9n8oItX3C//lRM/xiy6Fq3bMe+hnFPwIu/CkiKGdNSI7LG1ckDKkzg/KYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392654; c=relaxed/simple;
	bh=IE9uzs2DfEHR/K6U5+EleAkKoKjLhWPifcX2XlK3Wh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3AaIClIzh7nmHZLhYmiUa8WrUH33hEDwAA41KYlc8gBZOXjue+1PcbCMyzJIVcei4DFwBpoWWmCOBI8H869WsriihbyH/cxkarvZKnOqAfkvD3km2K3oeQBWSqvJHLaGDUP4sBAxK/qbVuYwDxSw66MzMIwZHjVlPG3XNZTJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcZdZWlg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcZdZWlg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79fbso11549255ad.3
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392651; x=1789997451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BJaElS3MZVd4zd/Sev0Vi87r/VeJDnrTVpf4OPQWFKo=;
        b=JcZdZWlgWCb1TwywzPGgjMp4YJ9HDERQsIT2gz0xIJqh8RJxXLh+Q9dsa2c3HV7Tuu
         ky4Dv+d0K7PrlCzbZQohQTVJI54vU4RJED0E1d7fUBs0kEZOYI6DlV0GXBDrTB3Kxwen
         BVAhRzpXCx3cCYE/nx0tf5xkIEjo7ukCVciApu09ElMKhVH62NrGMrOWGifTs+83+r30
         8LlmuBrIwYSeQBLsu9RtXbZ3HVASZrKHfVhw9wMov7phgLb0z4f8cunwT/0tcdmnk70X
         Ln3KNDdDG+CFIKBLYrooHv30U/6t4Nbn45FYxKqnYWwU8BLUN3vPunAY0xXxlP9gFzGI
         OajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392651; x=1789997451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJaElS3MZVd4zd/Sev0Vi87r/VeJDnrTVpf4OPQWFKo=;
        b=lK2E+0xdWOGHKrTu+BQwBjE5UblefmVKRauux81XvORQOhy8j2pgMjyGbLQOARRaFn
         kfjDPdgn3jc7/kgmxCoM7H7xa/xFl7E9PpPR+xUwC7TlDZBSyGVr/2O6uFS/OpAvwSEO
         U3t+cDZFBa+VBto3nIise7IyaVkBw2mBngQC4kjCARPOaAE0ETHIabhnz7PSjLPXSRE4
         3ftqzP8QySbFaJjmWFWQzJp/b5WGxT5DcGYxW2vQL5poeMs6JY2O+DHdD//4hOzCA12D
         7uYmuWVi1dzkfcUTwUxWBc8KuRKxDrGz2eWLevSPf7QUp43hBrFdLGWkv8A8Q73smpmx
         SX2Q==
X-Forwarded-Encrypted: i=1; AKwUvByK8vvkjuI6RXy0fHduZ+9C2FQObugCH9btgX/NML4G9xuXJ4npSIbwNMP7Gi/AJTvZXi6HtA==@lists.linux.dev
X-Gm-Message-State: AFuF++k3qlsu3p0Go6PH4GOf5/hxSZZZgi3AHNFf/ErOTVnZbSVX8F0Y
	b2BCt0c7J8uoFNuO0LpEsVGKin1vR3LbjlhwOUKnneEAvr5amKfyCGgA
X-Gm-Gg: AYBFou1XWoFEpDZh4mCeGTG8EOpwIYht1yN62MVMtnvaXMKiE7gwcWv6bKsv/AutSza
	H1qFEB/iEs52jsSLEviXJfyzECxspfpEZjpbmrEIpu06KRJFdhzn9nPazTxhCk5q9MNvHgG3DRN
	8ZWXfMHuJsVso7OPuLtmuD4OZhkwxvhLnesen14f9zwPaitPFXfIhCrkg0aoRj2QroNQgwvcUT0
	VLkMNHa/UqGmXRpWVVG4y+Akz7yrs+Q/fTSkCbCCkIXunY9cNBmWy4MssAA6yov1j1sjY7h97tF
	0fQDtNlqDCLDdagm+/KTxjeB+vRSf58TSeY6+cPv4YGhvlDilabCcpEhQoV7ck3/Nf/WgUedy2D
	B1PfQcV7ipyRaIRSpgENmiwMslrtq21vnd2zd9ZdAxHvOFllmZGvYu7Yt6wWzA+a59X8+Co6MC9
	5psMN41/W1ZQi4jQw9iC+bNYTTss1n1X1flIAOlcwM2le5v0jFoCyEiQ==
X-Received: by 2002:a17:902:f70e:b0:2dd:752e:6d69 with SMTP id d9443c01a7336-2dd752e6effmr6027245ad.4.1789392650893;
        Mon, 14 Sep 2026 06:30:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd428ede1dsm39850535ad.13.2026.09.14.06.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:30:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/sprd: disable clock on remove
Date: Mon, 14 Sep 2026 21:30:39 +0800
Message-ID: <20260914133039.1732900-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprd_iommu_probe() enables the optional IOMMU gate clock through
sprd_iommu_clk_enable(), which obtains the clock with
devm_clk_get_optional() and explicitly calls clk_prepare_enable().

The probe error path correctly balances this operation with
sprd_iommu_clk_disable(), but the normal remove path does not disable
the clock. devm_clk_get_optional() only manages the clock reference and
does not balance the explicit clk_prepare_enable() performed by the
driver.

As a result, successfully probing and subsequently removing the driver
leaves the clock prepare and enable counts unbalanced.

Disable the clock after unregistering the IOMMU device, once teardown
that may require access to the IOMMU registers has completed.

This issue was found by manual code inspection.

Fixes: b23e4fc4e3fa ("iommu: add Unisoc IOMMU basic driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iommu/sprd-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c1a34445d244..65a970ad4c9f 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -524,6 +524,7 @@ static void sprd_iommu_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
+	sprd_iommu_clk_disable(sdev);
 }
 
 static struct platform_driver sprd_iommu_driver = {
-- 
2.43.0

