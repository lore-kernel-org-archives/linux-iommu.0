Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BA200B99
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391586; cv=none; b=Ky01FrvG5NhV8o222Mxo+c3ZMgzGPKCVTIB1LAtsYYrrn8olFQuUjHbSF9F5hilD86NhlNjbfXgPuYEanWDeWAa2XNbyZAD1KYoctBnXrdUASO+TB+wYqTKKl75ypSEenspyqVCv9EtUwdOO8K3cPVqiRor+j3/4SaA5ogsnVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391586; c=relaxed/simple;
	bh=4Z0JQhN6fp9gquUDGJ84tUXaVmHYEEGbPTsb0CbEDQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bk5QfLwYE3od6ZPDUUTog95vAlkvigl5ea7SGR9pWvArbav5ApY3esAsAue4FkjW1C/Lb/iABBmBSnGy3/AzWE4x86S57Qaf93USBV/ZJQybY5qkx1OHeOA+GZNeG1VdbkcoJNb4VrZHHvmzAX1SaZkYYI3BMk6gC1gTJIL2tEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cD3cGGPU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cD3cGGPU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5deb440675eso13134a12.0
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 12:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391583; x=1739996383; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3ckrB5J2xK0c/DqMrzhF8wIxf+yknZR24r322/l5ls=;
        b=cD3cGGPUK0jJACOsJYzLM/QfvWE6DvouBI5D8GUvS3mvWAzH/1kbRf/UpNu8hwg583
         NkDgX8w0qHErwbtSDYwFmyvvqnJ7wXBAQKHiO8Cwk69EiQUEmP1kBOnRJuMymKxmS0wR
         WibzHjpQimsFj2e3nOj2pYmpdx1N364eLNZAolfBJKo8SbgyVeursm6a73l3iF8bfChZ
         VwyJlbP90IrcIKfIRgX8q6eetpCMGGRkb5mfqFF1H7bavXAPCzhE3OjuwAYMRT2IlooU
         ibjBpCjxTY1famB/3vOr7mNKfL1h9ckWKHHpXqAyYYFESGJbeA+3zRBP+DLvqxQ5WURE
         MFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391583; x=1739996383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3ckrB5J2xK0c/DqMrzhF8wIxf+yknZR24r322/l5ls=;
        b=ZMCzwYSmhNN7GEwq9Nrc30f1Kpe6z4x2Y/PimM3u8bBSmKKzLjSRrxyzs7jVSkmJIQ
         tzvTWYbs8Ee5IqGNXpNx2G0Vms8v0xHAmlvwfLZEBE6hz41gb145BGSv5V4vBXZGtTPQ
         dNi4CkJWTQNhibsMJNjyEZmB8komGb1p63hW0oJSeOMlzm+6pdZYIepny7WQ5vCtzto8
         +uH2bp2+TjjbCfy8mIJ4eOIEhGNyZ/J4S77BoSK+71En8YqmoJQVV/JeehFXKuY3Guwo
         zVrcM+GwZCAIPtndgz55r1gpRCTH/sZ+IkgWBln1B4q0kiv0esdzTXeuCD2a0Gecxi+P
         QSoQ==
X-Gm-Message-State: AOJu0YweFjdZSCsdyd1FwzeaeR7fDeuqy0UXJnyEpmDsE6Egc8BzL554
	9V4Ty8qx2vDyikrnQ/EiDNMybWgKtZR3ZbYgWD5TZSZtmyPVXWE4u8z/5YqatJc=
X-Gm-Gg: ASbGncsyY498jHATRBXpauHAW3gXHHtfwUVbEhpta2v5X6QvHfC/1xkpylffVltAcig
	Gn8xLw2ir5xlMPNLYXP1ggnfo5F2miE6S67IF86257Y/CZ1XqmR/Kgezp8ZBhf8FvK5rM+kes/U
	ysvcVFJosF+O9RybX9FCqqnmyKeKTnPMZFK4TmhMsU12/buPe/ovHzi2ZJAIp9hTI/D+RBsLNSs
	5uS4QsyibnWxX6akyI59yN1ODzYohiBQp/896nv1CrrVc/pcn3LrvSaA2t2re4Zy3SViBceYJtf
	uwA6agAqR1V6vBCscnHTQnTtF01D6is=
X-Google-Smtp-Source: AGHT+IGWQ6Ea/hya66y48VSHflrqIGI6YnsBwXSrI5ppeQDFsXbRnz9SXM1F2dK4IQhptqcpYoEGrA==
X-Received: by 2002:a05:6402:3483:b0:5dc:740b:3cd9 with SMTP id 4fb4d7f45d1cf-5deadde0a01mr1628644a12.5.1739391583427;
        Wed, 12 Feb 2025 12:19:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 0/3] iommu: omap: Simplify few things
Date: Wed, 12 Feb 2025 21:19:32 +0100
Message-Id: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQCrWcC/42NsQ6CQBBEf4Vs7Rru8MBYWUhroaWhOGGFTeCO3
 CqREP7dC19gOfMybxYQCkwCp2SBQBMLexeD2iVQd9a1hNzEDDrVJlVKocxSe4djhE1PaEMryH4
 YPqjJqlw/tc7sAeJ+DPTi7+Z+wK28l9cLVLHvWN4+zNvlpDb6h31SmGJW5EVDZI7G5ueenQ1+7
 0ML1bquP1boxErLAAAA
X-Change-ID: 20250111-syscon-phandle-args-iommu-2ea162b223a4
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4Z0JQhN6fp9gquUDGJ84tUXaVmHYEEGbPTsb0CbEDQc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJZOXGqBuHcgsU8HSbp2xo3yFRm/Ms+c8j5O
 ExsuSuqtKGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWQAKCRDBN2bmhouD
 1169EACSYDTLDH1DQKpYn2cATzfRIpbpcY5CzEC7W7IUY+ucB1/RIMc8lh8gGurqPkv8xHzhNSi
 Q6Sh3s/OOaHYyvXACeEZCADKjzyIAurionrjkAffeJWeRLAM0houZ/7UR3hWEy5FrLAppZDsgZT
 lN95xHKhBKwKRZOGE2OLljHhzj1MHs9urL1fr6vD5eivwuyn9Ule6KZ3TE27Oz2qugZayk9aAq/
 etS/IES+qFzgYthOGlL214ARm5RDABk94coQNtTAoDgs3tLPX9dlc62ewHv/6X1oOUSrWu4TmRj
 Dd1nCnNw/DOg6xAmGMRWoWNZ9htgcLzTgalNvIJNyyl3AMLR/QKsxK2l6IogpbbCFPGceCmstjn
 Y7ffxhq71utCdOclpJFH3r7k7AXFcpqinYTWkMXve5b1yaWeopMx/re20tL+JY0xuvpDg8bffya
 bOiwVJVPM0BJLe+Ri51C6wowd1Q9CU2WxNP8Vw0B1ubEylawqluyI8j586PatEmpKAt2C2OJjTX
 GHYzN1g+JdMmvNFTqJKIi9nwFmAjycWkJOkQ9cALy4JeYpGv7kBswsFNUyi5TzoQ7uPfW6jS+EH
 UV6Q7Z6uvaW1G2eR6H+hjnpb29QYjvOZ/TV5JLlpN0bNOLh+FUw9IPxSpgRQR3LF0Y/q9vWuj+3
 WOZBCG7GZSWGNXA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resending after 1 month.

Link to v1: https://lore.kernel.org/r/20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu: omap: Simplify returning syscon PTR_ERR
      iommu: omap: Use syscon_regmap_lookup_by_phandle_args

 drivers/iommu/omap-iommu.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)
---
base-commit: c674aa7c289e51659e40dda0f954886ef7f80042
change-id: 20250111-syscon-phandle-args-iommu-2ea162b223a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

