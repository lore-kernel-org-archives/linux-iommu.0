Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3C277CB9;
	Mon, 18 Aug 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506606; cv=none; b=VDsy2TgzBmZ6K5B+Y8nk7PCA7vNbca1VP7UE18B8xTS6GaHoy840DxCXxYBnzcYJ5+8zT75WI9Y+jw+LXeZAWvcnzU4nr0e/a0eorUtDN87tpppXpNC2HN0Jw9OOSw2BjAnkk6wlRDT6V3a11f9gwnKxQ0EyApuKC6Ybs7S9gA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506606; c=relaxed/simple;
	bh=h//OnE8xjMrdJsTFOXyv+oxSEG4dfiZyYKDlv6KTGHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WjF6L7nGSGZVK3dBS9Hgom0Wy21r2HUgLGJKYckYcDsOXOEG0OxN+WIzECVYuaoSh/DLnZnvAU0TueGpihC8v9iYf8VuZLNljkR3iPak33wpAwwdvhG422/Q1CBWIN5V/fPmj3jRQ8z6BD60bluSsQvjyjPkW1bTuKJY9YGh6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDA3uBov; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDA3uBov"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so4217992b3a.3;
        Mon, 18 Aug 2025 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506604; x=1756111404; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=iDA3uBovCLIJ8krO/v4r3f9PsSaFKCjOrBa+wQmi1VEEKq1oZWRNF6P7PW7tZcqfRj
         RZCwwBA/r6tYui8XetWwuGBnBX90NbF1oKfesxY0pc4+UJs+w/N+nx4P5npLnGDQvjLs
         k9+yuz+pzWlEUfMMQ5N/9/CKqURb1LcQsAZms7CYtPpkS/H0B/86zGRXWmgHT7Avqop1
         0XhLnzIgQDE67UhXFpB6koFGzMvDKA3Sfjc8yW1dhKd0pi5XPK+x6eMT0lCzKBwfNmyy
         vWk73SkBYjnIVDj7c8YLnAqFgJaDeC96HsBHbtead4G45msAh6nDdILwwOxCCtz8lW/J
         Trlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506604; x=1756111404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=w+8KZEbZ4k8LT84qIsFKuLyDCdcQmt6Yqor/2gNHuFGcs9YzTF9iEc2v65XlByxEnW
         GKQMK5OerpGi0s15kMmAYBxsy0ojGqoLzcvSc8DjV0toK+IbI0LD4l0rhCijJsGg50Sc
         NRoa2PvCMQ0oMB7a/LTnAkigtKLQC1S31Z4TeUOTadlIBdQ0BytnOSeJOGUiFFi3kCSH
         CDBKXBDhP96YwW35WbmdmeF1YNMJmPqGsJdC5cykyYm7EyQICdemN/AyI/1bsOD17uzM
         yworJcNrLnQM2Ff23A17qzjkCk1kzIayUzZAPQWmc0dnFya0Bs8+pWsc8dvIeh6w3QmN
         73Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXtWwNNgmPDJnMC6e9aOlbCxGHdU0wod55GfyB1Fwm7G9tk9b6sCRlBpUz8RnkXSPXJBf035w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0CF4IxetBV7neWj+6q7jg3oxiXFzM0aLQ9pUSOWwbIDUUM2D5
	U82NitG3isVeWFXHBlzxD0YiyJDrFdhLe0fvnyVA8h5VC4BwGgv8GJZR
X-Gm-Gg: ASbGncuoz5c8yWd2rt5lin2pWsLbdEc2qEWWv/o2JvbiXFRtal/6iOnWHrbe3UHTOdy
	VTDibriWAIQnABFhq6sa7rVeoEXri5K2VaanyOHICCsXEowvnUqglgVXKPOTXYN6JFJBky3rslM
	WqHGnbQkCUgEI6srVKDYkkbraYPu1ZDqty2o9SvA3jmaSgisbMNL4n/k1+XM21bdngsATFaFMHi
	esyXb9Lx2Ith2OBXs7o6kGu5U/IfgAx2W3PY9c9Uoa3/KncEOXIoP7AamG+EXLq7NNR0lreJyTY
	5MkHhzBCaWwfrnJn+Z3MIZbNOEule4/u40nV3bmkq/Ai6so5fxwyi9DHtd9vOM+MRKOT9Egpi9l
	VR+xAAg/NtsRIhy3zkqYSosFiVxp3wQvkzmpl+hqWHVtdM8o=
X-Google-Smtp-Source: AGHT+IGr+QvXGo3/T80TEtk8GucqtvAHkHyeZ3j5ycRlwOeaTV8Fhjp6M6C6LOuR/Yh1gB0/IdKRSg==
X-Received: by 2002:a17:903:4b4c:b0:242:a0b0:3c30 with SMTP id d9443c01a7336-2446d8edf38mr141753015ad.43.1755506604217;
        Mon, 18 Aug 2025 01:43:24 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 18 Aug 2025 16:42:53 +0800
Message-Id: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3nomgC/03MQQrCMBCF4auUWRuZxIZGV72HdBGSaTtgWklKU
 ErubiwuXP4P3rdDosiU4NbsEClz4nWpoU4NuNkuEwn2tUGh0mjQiM2g1GLJgUR3se3ovFXae6i
 HZ6SRXwd2H2rPnLY1vg87y+/6Y6T8Z7IUKGi8OoVIXWu7fgqWH2e3BhhKKR/numlkpAAAAA==
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=h//OnE8xjMrdJsTFOXyv+oxSEG4dfiZyYKDlv6KTGHQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouegHci7I26tBuTw2954p8e1MuDA7bm7+1HK1
 MMona/pAhWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnoAAKCRABygi3psUI
 JAnAD/4sXJEJsWnJXyEtUrZyoCoNIoaFwJzZuTYIWftzOPbeFpexvXqlVwu+Ysc2UNrQQr05hco
 kF3AFRksFtzPz0VxvuisoNbhvv24NdsTvsxs/z2T0ofzyJ0UQ1BQL54uiwLYgiqMSgqRqCu7SNY
 isS+k8QYYwt7W1idiosA7W9Sp/i2WEyNu6tSAXwIJF+eykXAeSVFeZyIf3Rw3FDwFXyRsn+rGWM
 ABGTsSP2o1/HPNr3FobP3WuJ4qZAP+9n8PsOi2YcvFsF0wuwcFiZ4xs8aIswtAWMNKWXq9tDv4X
 DzqFDNu2iUpjlAeB+LfCBGn9fdO4F5dp0UZqXyg7tV47ryOVdfxTHslC/02UAmFBrszw2hqM4RJ
 SSFTzvF1q0qb3hnPr8PVG8IPYj5LyPa9+gzsGuPnGYRhFUeqhF4KQwyyOaB2rlHgKO+qgRgVkWR
 ChSqP7W8hyV5dm4fOwGFwSlO3gyp5lOFnKszOPsmwekqQyfg9/+27TIF1oMnbsDYbK5XG+hukG9
 11Dn1/TwCIjN/yPyOMYt9/1nwMo5TF/wu17jwMSkXo3jSCUAPYodPLwsq+Jiv3hlIS2ukSQLV4j
 RUfcSqUk1TqNXjgtLcf9VJhX492IkA4ALFmSVle3syy9efPFNB71Hz5cT6nR1/bea95NZmn+wiE
 v3Ei+Fu+gPBvyEw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 198 +++++++++++++++------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 267 insertions(+), 68 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

