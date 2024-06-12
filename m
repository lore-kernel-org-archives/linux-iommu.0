Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFBB17F4E2
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200395; cv=none; b=k65Br7Ka6IzKmEs4FBZqQ23SAtJFEzl+0LrtpgFbfnL3O9Jd+A9mQm20cYyGwcpRghkgX1TOAdVA1dYV8mRk8HJkvxXfz/b+ZAkZHIBVIgYqzJXwioiweZgCPSxV1FuzSwABdKvHNF1OkIVWc3i3Okf/P+hG6xtlfIxEXYkOeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200395; c=relaxed/simple;
	bh=ETeqjYikvQUmV+JBY0OUQbNcQiW4jGVDEl9xk5l13Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHtZ4KMk6bR6HhgP+7Z6P4liFxWwfGuJFEhJBOcN2U1oFd7uSbpT/VLHEof3V01MmHoWRKvu5056bQvXMhVq8LRQxsHMVtSeVZmU3G6B3xNU0BE3SBQ6KVjzGEkiySooLDo1MLiqCg/C7IwCMUhs8N2JbFhwe2N5m+oTGJJ44+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42108856c33so6089485e9.1
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200393; x=1718805193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gvlL/3Hh6Rvkzj8HeRV4KajZ/sjiz7m+L1scRmwe5k=;
        b=rFH5huDOPc3oo/whUkcH41Zszr3LzsSmhJIXq8AMQiLfcSVyyXEhlPyX0gMdjCFpky
         p1CB+5s/MymbhfgeuIxH5plNFmHVhCjDq/H3KtTXAYWvILEAMjQfi+KRqPDGV3hFIH/Z
         /T0Y3Q8Dwyde2o0rmGk3ywAniVo7NMTS0igeQy5sqFmxtcMsvJWIATsT/310PHFJlZ63
         4ysYF1VetoWLbKm1CBf2q8gQDJy2rDHGl6D+vLHG23Uf7/HzKx7SJ8/yvFvMbG0UdROv
         E8lyEHpHUUnS6upV6zxjQpabEAQzwANfM0mFxgJZn5nNmGNiU8iyZsuznwfGok2wWS4z
         YJBw==
X-Gm-Message-State: AOJu0YyYY51qlhp/QYjZnSkIUE/zeK+UTbUZ1iaHJj28OEAyEvEBpdCK
	ij4Vm0dEX7pMdAMdnz7vA+5esh/Kq6wMR3aC5qJqK/X1fsKMDDJf
X-Google-Smtp-Source: AGHT+IE2T90QH80rrQ35HgVVqB20gHNtrUAWASa/gbvajU+K3eKydM1CK3LNiNDzGaMzR19vk4V0bw==
X-Received: by 2002:a05:600c:3b23:b0:421:3249:557e with SMTP id 5b1f17b1804b1-4223c531cf9mr51588135e9.8.1718200392753;
        Wed, 12 Jun 2024 06:53:12 -0700 (PDT)
Received: from ramallet.home (cst-prg-45-36.cust.vodafone.cz. [46.135.45.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871ec9e6sm28201695e9.38.2024.06.12.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:53:12 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 12 Jun 2024 15:52:58 +0200
Subject: [PATCH 5/9] arm64: dts: rockchip: Enable the NPU on quartzpro64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-6-10-rocket-v1-5-060e48eea250@tomeuvizoso.net>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
In-Reply-To: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
X-Mailer: b4 0.13.0

Enable the nodes added in a previous commit to the rk3588s device tree.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index b4f22d95ac0e..9afb7efebace 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -291,6 +291,14 @@ &gpu {
 	status = "okay";
 };
 
+&rknn {
+	status = "okay";
+};
+
+&rknn_mmu {
+	status = "okay";
+};
+
 &i2c2 {
 	status = "okay";
 

-- 
2.45.2

