Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A613486405
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161676; cv=none; b=Rk8XbxPiXJyD5X4J0me9xCqAa2I89B2+RYZpzeDSUiR0dqnQNspXE/9X9nNgtCT3ZIUcMf4xkvlc6pSKGvMPX6j2z05QChk/sus7SkhjPtazCgqU5nSJwrR36cx1EjSyc7mMjRZxMwySUI0EDPwIv7Yv58JzXRerLP3D/9kGcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161676; c=relaxed/simple;
	bh=c21PgPKHOIxP9rG11c7WqJwD7hUOwv0oDlYhmLHwZRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ApVuy2AJ05Mj9oVL0dNblBsYAtIaGURg+5PuM5IHCRqjKLs1DsTJ4rB+r25qv+siBI6vmejOlYvLwiQzbRaHBqoU30gMQS3dG2uq9Z4ice2adPmKrfinVgB4hMdzvy3/6g9F7jzPjwNOcFNfK2zF/3Pxm0C1C2O2FR6ZrE85Fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNpHaedL; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNpHaedL"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so4892166b.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789161673; x=1789766473; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YtkRxipFDL5icgX3Q2CLk2qBLGJiypsIowMqv9dIrjU=;
        b=KNpHaedLxtSuKtTm4z1LzKKFfWGCG8oooU0jJRsBL5Y6KlYo7VEeAIwzvO+sZjRs/+
         UgrSwv4sfJ56eK0ET3ceZASJPX1czCETxnWNiEIy+bsQxaZlrfKU7U0yLf2fHZ9lv6KV
         bISPjyQY3Oab8dEcM2wA4mfDKLFhDmg2KCCZD2xDs49YXiCZD4291JGG3D07pwKRgFok
         NTwYWwisRUQiac+LH4XWsM9p136nvuD85tPh8ullG3s+xMapW+hOa8kWjcsPwHDUcEV+
         kLF5Lw57mpJBCsLUadGZN3E7SMKdZbL83hFIEi/YjIVZAKFixVUFu40x1ubnBydpdVcS
         eJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161673; x=1789766473;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YtkRxipFDL5icgX3Q2CLk2qBLGJiypsIowMqv9dIrjU=;
        b=C4yRk2Fk8LXnKGM0ZP8CkCTrOIA4BFZ8SQSpupmorrM0ZNMktVG0H7B1m/15JqvPVk
         aHl81+ejC8kJ9UHRLzvHk1JCAfZ2EFHa5VAV+rqfhqAxdLccqgkWWs3hFK/+8exnyddR
         YRD7Hlkeks8VapvU3T0PN6oPpnVBy6eFnE6TH1jltKQw9cBKJ1IXsExYc0ZuRm0rTRgf
         2zdgDYcr1OSFoE0kDDICvgHC4p892vSO8jvHLsZuBhQzP1rf6DsczF3m1PaUv3aXHBpT
         NPLehzOPYAGhQ587sBTy31XSDr/8js00GLkHo1p3jm9BOtZgMHphbKFqQhLavk/wkJHO
         Qu9Q==
X-Forwarded-Encrypted: i=1; AKwUvBz0BNEri6IGebl5aJVNiJS3sPewb79BBLsjw+al5Y1wvhd8Ve6mLhqwXgEk6cey2F53yHPbIA==@lists.linux.dev
X-Gm-Message-State: AFuF++n/BKWX3QwDjknp5HbAIsXVf+8PjoXNX/1xqzeXkjYv4Bca8bzb
	M66B8sf52jNrqGBqH08aCtpeiCtmUuoMtFmtb2UeB5FjfVOMsdSD+9Dwiyx5AY2SQBs=
X-Gm-Gg: AYBFou0S+szAXKiavpghlN8zAH+bvZTbrKAhzCMfWcSX+2qA6MkyfENQWLcFKP0medx
	YBVtx7mIUP5kueirytzcSwLWEMOh5swt8x0lmS/P5o/8Vu198jLDUutqd1lhmCLItSC8LOIIwx1
	vLOtKeCNozRU9+O7BLCRg6hnW0r5cxZtDzEx0BvqIoO6JWnySB4ymB12rSZ93azgQkBMIVRG489
	O5/cyQ6gb3IWvcOx5BuB8WyB1Fc5DMpf4xRu5KYZfIMF/Dr0XF0fynbbA1ivZyBtTXArXTq9j0a
	wIxsRO3gYUrcDtzdrjxFJbB9DqeNI2PkWZekFFNW0g07h31AWf7E0DNGNhh1IeedqJt98L5R9Pt
	T/bybkSN+q7YZE8KVdax/rNRjnTdKf3BYZ0GuS85TJzYXbwcvzmcymMRsJRvtP4ioC8Sahr3gUU
	9mN0tDP/HxO0NFJDeP6+T5AmIwDzzh420hVOdJ39xNYky38tNolgkCYEDs0aYnN0otOpBNL1wUn
	XBlt59xhCCK6mFlTkUjQAswnXVBcRYF95CTZPV5NH+tt4hs0Nu/CpaRLBc8SX5opQfu5o8EhUnj
X-Received: by 2002:a17:906:478a:b0:c20:3402:bd35 with SMTP id a640c23a62f3a-c2985736d25mr5788366b.12.1789161673377;
        Fri, 11 Sep 2026 14:21:13 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234f2sm126375166b.12.2026.09.11.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:12 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/2] Add arm-smmu-v3 support for Laguna SMMU silicon
 erratum workaround
Date: Fri, 11 Sep 2026 21:21:04 +0000
Message-Id: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBwpGoC/43NQQ6CMBCF4auQWTumFArGlfcwLApMYRJpzRQbD
 eHuVk7g8nuL/20QSZgiXIsNhBJHDj5DnwoYZusnQh6zQSvdqFbXaGXBuCwvTBWyj+vgJgyJRHg
 k7E1jlBt7R1UNOfEUcvw+8vcue+a4Bvkcb6n8rX+GU4kKqbWDq+3FGm1uD/ZWwjnIBN2+71+fp
 QY7yQAAAA==
X-Change-ID: 20260724-arm-smmu-v3-instcfg-override-b5650fdbfe34
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=c21PgPKHOIxP9rG11c7WqJwD7hUOwv0oDlYhmLHwZRo=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqpHDHRXghRdY6uBz63a5ApZqNJCpKlCLxF8jzV
 5/3SSiL7jyJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaqRwxwAKCRDO6LjWAjRy
 usxOD/9TZnmjDxdAt4z+h8x9Bjg9ECMZxhknIg3DibsnTWsOJFDnVWfD0SOIpWiWOg/crqeJFnX
 6x2XWbd12BM0bZWsuArGA3ESu50pJBPil9ReIv/PUPft1PqLLsQeTf+z4kRS1RxLurUzsAZmHUr
 U266fE+if9Ov8Z/MNicdH76HEQyihmaEtAGzOhMpbK41V/VX5FnnsFIJrJHaH62Ni1jO1+5miJ2
 5Mk6EKnc80okBZazcn26U87g9/flORVwGvddRO03VO0RQFt9Z7pkfJpM/uxN9sNJymtxAg4qJB9
 8GK90HECfopF7wdVkBWdy7jrM2/hRIUPprg8F63ET6Yo7EwCygOYzIC6Xagu134W6tVAKlgec2V
 Yv+IA/VQ1pXtI41y4v6vXcfwnyFfvmM6hKH01CyxuES8JW3+/pDIGTEyeF+Uu3OVGkUdHrbl3K0
 b3clvzMgMDqC5Cy8NmZ61QNLJEah535UXYM/3vWdg9pJjbXiwsoKGB1sXyX+vQIJIeBXahb/Yzc
 8RAvyCIjdHJrXjh3+0aEy2Nyzpz58wMj4L2OwVUGnPZ4C5c2Oi8NbNwt7fcZ0h/jLdjEPMgQl5Z
 m7lBYdUanmvu/ZMYv64dnc6NJYMXmoQvmPh8TL37LwhXp/UaHdrnsv4aezmnif6CONBzNJmLq5G
 JyL0noaCWqix8bg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

The Google Tensor G5 SoC (Laguna) has a silicon erratum with the SMMU
integration where the AxPROT[2] signal is always 1, which makes all
transactions appear as instructions.

As a software workaround we make use of the INSTCFG override feature to
force all incoming traffic to data.

To enable this workaround, the "arm,instdata-override" DT property can be
provided in the device tree entry for the SMMU, similar to how existing
errata workarounds are handled by this driver.

The first patch in this series adds the DT bindings documentation for the
property and the second patch adds the associated driver changes. The
Laguna SMMU device tree changes will be sent separately (as that will
go via Arm SoC tree).

Note existing silicon errata DT options in this driver tend to use a vendor
prefix e.g. hisilicon,broken-prefetch-cmd or
cavium,cn9900-broken-page1-regspace. But Rob agreed in the v1 thread that
using "arm,instdata-override" makes sense here in case other SoCs need
to use this.

The Arm SMMU spec that documents the instcfg feature can be found at this
link: https://developer.arm.com/documentation/ihi0070/ha/

regards,

Peter

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v2:
- Add a more verbose commit message of the silicon errata issue (Will/Robin)
- Make clear it is a silicon errata software workaround not a "feature" (Rob)
- Fixup incorrect bracket (Sashiko / Nicolin)
- Add a note about why "bypass" is not required in commit message (Nicolin)
- Remove feature flag (Nicolin)
- Move override feature/DT property sanity check closer to the
  register read (Peter)
- Rebase on next-20260911 
- Link to v1: https://lore.kernel.org/r/20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org

---
Peter Griffin (2):
      dt-bindings: iommu: arm,smmu-v3: Add arm,instdata-override property
      iommu/arm-smmu-v3: Add support for arm,instdata-override DT property

 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     | 10 +++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 25 ++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  6 ++++++
 3 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260724-arm-smmu-v3-instcfg-override-b5650fdbfe34

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>

