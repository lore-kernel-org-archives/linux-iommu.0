Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212F2D3A63;
	Thu, 21 Aug 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791888; cv=none; b=LhNa8teKugPqd9WfHODfYWF040yAP4cXdTj+8wt4Ve5h/xn/PdccEgMQaMq+EgwwTmwA1Y5sF+OCFI8tnPdGPyGJoByhp47vA7t4uJcBneFSFkOuHc1xvDjd+YCGnHzZe0oplK4UYCMJou7rv1f5tPiBuyxX+6+6vS0YodYeAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791888; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArfgbWyhMVtKPFcAmiWVMjznOurLMdiA+ZussuzjHQjIQddIH2a50GGZAn1v1Od3hG1Sx3ige95JqN50F+21cUm0bI7uXM8mIZ8r/gWlBQklwvyvzvduGql8JIuZvb66StWhTAQBddweYh7uDWPedqJ5DKF3RiFk1quRa1WKZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkS2tZBe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkS2tZBe"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453869b3a.2;
        Thu, 21 Aug 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791886; x=1756396686; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=DkS2tZBe3APWs8ODq9NzbXO6MhRp5Q2FY2VhFZ5eI2HTOOxoJ4OZ23TMZWsu1D7U/1
         0mTt6sFq9TzAwVnNJ0vVMKW2cSZ4dPjBWyQU8HGkjtiXdWbMUQb8tZeZuTJzIE55ZkFz
         7QMgeEPOUhliRyxtOrGRAv3/ZA86Ae2Qc4I7nHNJBd//Mj0fOt7lI2XyCZKwfQTXUFLj
         HyQs6VuAIbhz0HS+kvTyRIYZJKyK8xHxILcGizjdrntgayDU4qU/XmIcxIh3yojCfic6
         vTWhYH+NlFrbGA2dPM/ql5+bOxkb1nfusDOjgY9fxowHI/QuRIsiydHcLdDlkOKqwYli
         ggmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791886; x=1756396686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=PubhNiXFOBX0z/hWAdGJ0Fpjk55MlAy9ahhQSSBVhbwu9X+Yl28vyL36wVsSGYfSOG
         CmsBPGvk02Dkb64TqE4LIvqL69+4rikpm01YMmGW6iCfPgARQmBdqfEczBbwLtEzFIrN
         WmJEGfGUcvZUg5aZcfkmfTYK//E64XYIiRLU1BzWuPw953hu04IIXUx5CH/rwlmigpt5
         uzMSwSfDlFt2SKayjZ2S7swXEpdy7dpl/6vSNzpRHWaSRTac2VICamU5LXR9lFmISEOs
         xmANB/pEyxd6LSZA7EDCd9EoNB4pGZxOJ6+zfVnzlIfFqr7avUCP8dOLk1Jd45eatlFd
         a4zw==
X-Forwarded-Encrypted: i=1; AJvYcCX8mV0XF+iQf0T0/Vrcbk+w/+4cWzg7kJgwDuzYsHSEb3TtZ4/z5lHyneA623B3ECsBwlvyUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyOjLo7+b5JsAb+P+0vbIamjeUB9AOFP2xNa5zCC3I508rjFy1
	mnsbz6SiHZMOSX7P9VN/YE87DiVCiSNyIgj6B+PDhvorv+TdyRcNMtN4n2xY/09t
X-Gm-Gg: ASbGncvHgIjRp4tSXwg4qzN8DBg/wtE/zjbMXX2wQ750n/P9sncy3DPvAKMm2QLnwmR
	AmuIN1xN47fbd5uK5X6QvOnjQ0wBL3Z2W1+cW7KPapuTxbVvxu5ha2qpgZ0nfARcanbCSwCFsey
	FY16eADw/OpBqhjpD1esbjj9bxNOdOcbGZaP7NurGs0nAMt2G//LawohdvUhP3vUyAMTO8EPweZ
	ItEeuZ4gh2mOpQtnlj/v4cUOL1BFSuX2n6WB+mELFuSaJ9N6Q3iwwneXe2q4WLMKdwsf+ywFoQa
	knh4XUIJqfwuTAoZeesH7Bm0R/7ei3ce3s/yLxjoG4/UFsvpFPMNvpV3AX5U6grmjVMaK1wxU6o
	jP2KboH6d5lljpH4wY2CgHywnA1rc1bDiNWV49nSnWA81zD8=
X-Google-Smtp-Source: AGHT+IEANrnSY6fFShGILep2ycHZBMPux8sJi2tr6F2Rs1Ziij66iom0whiB3Kjde3in4VCY4nqZlw==
X-Received: by 2002:a05:6a21:328b:b0:240:75c:6f40 with SMTP id adf61e73a8af0-243307c954amr4973125637.14.1755791885735;
        Thu, 21 Aug 2025 08:58:05 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:04 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:45 +0800
Subject: [PATCH v3 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-8-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVmCaSw/+oi3sVEhtvuJHWUTvf8G4prmp//
 YiXmbkm2zaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JNK2D/4mz5vu/Rrjfd46ezfd+12en5Stf1fevsnGAnRYJmwNP8Zj6ewOMDKb4Hckbr65gbaranD
 OJvCXduPVY9ZRPucRECvzMASR04HDR4v2cIHjb5up1ho8zS+wLOfRxOYNEaZO5ktb1B9ArBaiGA
 wfgnzBeZdkzBMSo7YkVwl+NzOOxNSQTLT4uHdvz49KXPWLrFN32P72V3ljyxXnQNlCAtmCNn8uD
 xx3eH94bhUFbM3S5opENJyqagxAa1FBemcAN+hRu/dRqQfgK1swLrWe0Oy3OO1HmGpmEKbvXm8I
 MYzrAbr6V0FqLUJvbPh/Xck2EdsfumT+0+PG/p50KfM7pLvKQDRqKMMxAqlXlliR3U/XkzcZPg1
 FsgQKhYDvympCQs1t1eycSHUAZu04LFNHFPuIA3IX4HTBdfV5ch2xLMsm9jXK0LWYej7A3V9V1S
 JWMx/i1eZWu2XGGRM3XkORCctP4PXtasy5MJqaQ4r7oKj+1kemOwGWZJnmY5bHeYyCYE8amrOlk
 hIoe0sRkETeS2C/+MJq2ODhDJHwcj5XuEAz71QwW7r7pbQ6jXoJP85oZscInTKf7cpAzzS+Xcnt
 iwSaZm1PFWWRGr66hmj0ufw4LKq3Mjrh9lPlH8mQOwFjp1T73EEdYaSnw/W2H4MiB7PibcEv6Vm
 k5r4QFW71ZZa3fA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.50.1

