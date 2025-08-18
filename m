Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF0308F0F;
	Mon, 18 Aug 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506655; cv=none; b=kWf7ptu6nq2sNltaud6Uq/oJGKTc/tv3cz7bND/OeswTvvtxqGh7POLwdEE3Azxe4KxuU6VhT22rBxp+aeBqC/zqLacDU9i475rInp9VH1lfI7X/jjiBxTbkXe185k80CR/o+sUcbtBsNMPRBo+8fml5rOtcpumHpDJ0PmtgekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506655; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpRJanpS9is8YLax6tgBVXSU/2/zGBihlJQ/kTARlvhPvhULBxYgglBV4C09xt3wC9Pt/eKFwzlcjXbKOfcsIHIdAENEd25V4oU5q0bSDE96kU7wbbnuvSoU5s51demXu11KoqSv8OZIUEGOQxl5Sf7EdSSUrP32rSX1odcqGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNL1/9C+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNL1/9C+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445827be70so42129635ad.3;
        Mon, 18 Aug 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506652; x=1756111452; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=FNL1/9C+T76nU83CbSCnHk7+2Hs7ZnJD40HMtnxArdQ0L/s4ficbpmdvcphhcWdsAN
         UMsidFLJhFKa5fPn7J/IxRa/mAj0TebjonnDpO9RZqShuXBUu0YRLTUk5NtnHyZpQTkp
         fVVpUt5XKWXp8Qv7l86NQ+w1b/xQaYZcIvoL4SrrZQKnA6hU7bIeb0MVeBe8ID36og40
         SwKV9mtz+PMM4+gpHBlO8xo/V59YaR6v/soAF9ebuIlksi8dUmJQJDZe0f8kcyFmGfDl
         Tfq/Oq1O1fOVftLXVQoNnopnLNnLCEPFoICmK25UW+C8ay0Zwd3abQfn2YkOWF0nj+TF
         JKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506652; x=1756111452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=SYGRs+B5gEgQCJ925yIIKTaw7ppEabqntt0wsDEY4dD4aQpEJ/dIG5YSKW1AgybDmY
         DGNSsl7gVcDrZnJOLPlAdd9+cYe8P7Qv1+V5DpYjXclhPxIaGesQGGd6K/+15nsn5BBb
         Ii0eWJG5cTnJ22VhPNkjkb1dvrNxs6ns1LsRV4W9/4g+us+ixD2K7Yx1YxAllxark4N4
         cineYWzZcxDnbWpqGKn7WwSZMEyysi7vmBnKUDadQdFK/kqK1pEiJqn1spNaguNtSlVh
         /trAx66NqIJuzOzN9sJaJAlctNUkM7/QQiVBrs2itgOxgN+BWm0cN9RiBeYXOtjIf3uK
         eTkw==
X-Forwarded-Encrypted: i=1; AJvYcCXxuOhl0wiA3tcb/WsDR9yKei2YsktXpa6pS9sYV26oPIJrZi1SK9L9SF3aF3oEznn/oS9UNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydnNDXklNajU7SyMdhEQTS7pqZQZuGp07qCY/nA1tS1eUuoHM2
	ZLmoljIlsRAHiH9tGeyTg7wrsLv4wwXxXFCUNFznhDBq1uiRm2o3JvpS
X-Gm-Gg: ASbGncukc6hgd7soQ/P6J7qcCWE1wxV3gqtQIlHpmuw70aHpfI7Mvjdjm/rhvZaGDl2
	fiGL1ZDvtssLBgPkGWM0Tqe6ojMTT0RfGbnE+R/OP6tIHyQugY3ImTp1l7F3qvQ4ZE/S6mLUh2u
	gA0diwUTENsBJ9eO8NqHYYk8UQWOwIVotqP42fImjArhtVwVCXLuSOlHck60Ug3bezl2L/uv4QV
	rYH4gzuD4Tun33d2VafetUjt2niC6XuGFVcYb5qlkWu5ARiVASRPD0BRi9aURDvpm2FWHWM0GXW
	vxgDtV1uwuKWxYsjY2x1RsdHjcRbcbwdiaBcJMsrA8r7+vmtntGNcMiGYImdU/HkFSxOnSQZ3H8
	SFtclgXrZf2Q+PyuKvqKGR8PkSiSrVqZ7FDxlE9TrDrpGoqbbMXY/A4B/rQ==
X-Google-Smtp-Source: AGHT+IG1afPtfSsM25RsLVziBfnzCxe+fm/mDBbqheQlT6OGm2ccgvPEYnJThK+OOSerwaXiksOffA==
X-Received: by 2002:a17:903:24e:b0:240:8704:fb9 with SMTP id d9443c01a7336-2446d948463mr151270825ad.53.1755506651863;
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:01 +0800
Subject: [PATCH v2 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-8-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelWWJ0YeXG6dIWCt0vJagWW33XZSkjmaJ2r
 35WAX3kwK6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JDvPEACrtXL7Qr/DBRGiWukhhjd/4Z4w2dKfoWc6FF9aC19lals0kztGvk/RjEmsDol5RmPErQE
 MIEd5GstMiWFW32+K6f1VMh4YNf6wUn2kaz1gexAQdk0XAYgAsiKV3AUMPZrN37GpzqBoyCht0M
 kFxcpnvdq6CBkOsu8pgnCTRBe8PLDtGJPMcV33U5PlJXfpgJYRRRhaZKgBK6NebPt7m/09uodgd
 Oc5veSeMzd3QzmVqI5AkGn95VcnN0lWiA5srfxz6RhhoOk/ixgyTvg2IreLOKLzDMXlhzmA9Xpn
 mochAQmxFSZ3ZF0znN91qZH8HrC3zNSpEvDN9RQ8YnIaVg2n2plKKlIha5CRG4PNKfwzbJw3J6+
 3ClQcpUcYudBkeCcyPzqczIqMPpQ5tz6aL1MolfiiV2Yt2dRCIuVPvoEZbhNKDaYuDej1nGXJW7
 EygOsTIebFypwkjFkEDvwnjjbsnMRO/I67936jtrsqXndRUbb+srPh4kGIRsmP6QUP3F1zTnIgU
 nWY75uqHxdfv/jJ0deQ0nY+wLSX/iH0bW3ZHz50//N0JRxxBpkObWScmPh3d6+w306mkpnXriD1
 fzSAYuwHgXJI6yMrpyZVw2p2KBkOdbiUiNvJ/rMIBgEAKGDQUu3Ytqp9c9Xe2on8hUxHM96fmSF
 DaIl4kv/gDmUEOg==
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

