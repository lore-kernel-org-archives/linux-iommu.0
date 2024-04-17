Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6839ACD
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384426; cv=none; b=ik3yCmbF2zIl5o11SvXQ28Is7EN6ObLmmCuNyC52psA5yzCCZ2SrI7EZbdDThgOvJrH7eDwIxesTyeopXwg91E3zbFnwUL5zGG2XFH9TVgYwdMqZMLPhPBVu+uiS1IgYcUzayMUVPdx00RzykQdGJ7Fg5S4MqTS7Jg8WmBe9vuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384426; c=relaxed/simple;
	bh=FP49noh0itl+WdqHEAWcbgLL5Hde1RFigpB7XfXqmKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E03sDHzArBehKJe+8n0lfXci9DyBKvTRWsKoOysEEOypUcL1HWJuQotEARPuLb0xDxY0aEN6ioPg1QVDA/AzhpsJY4EEC8dTD5E7cqt75Q5um8milFygR6RZEuc09EXgPcUo44z//aRh5RqqlraPq8xHqV0koj0uFiG4FOLfoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ze0znmDD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ze0znmDD"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso119778a12.2
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384423; x=1713989223; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXdx5eKBbphyNwU77pSPLcGmccDtrtsrx93Wp2k5WuM=;
        b=Ze0znmDDX3x2PKBYq4XJRYaMVwwda7i+LPZACH1YEvvE1/LsGwvagGlp36nfM5Fde/
         uy4tEqq+X0mlDP1JAtPL/hcCodR2if9qYDgDfa7rmYof8olpPMNRDHy8UCu2HrCT0GIU
         jHhzntYZVGEoQjVMBF+5TqehJuVE5RI8d8LSK7G92DYW3JO7aMxVzb1k94/FHbMocZ+E
         bUWUnwQqggMnt1qTvrM7TR3SCqgLnAjKVmTDP8q4R+AArqvUeD1NXsZWtkk8gcScW/yk
         di60NiyfKoNo7pSZ7n8Pe6rwGYwoj26QS7TM9Bx4oiOqiup7Ch15RIT/GIftTf3VpGpm
         mJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384423; x=1713989223;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXdx5eKBbphyNwU77pSPLcGmccDtrtsrx93Wp2k5WuM=;
        b=l6M6sfop8dw79t8ihnYBaPy11xEBr/M2GTqpel119Vjm+IVdWVv9ELNhu2Y0i9ITeW
         PdmseG4/ISuOwNXMS2DyRDwLt1e2+lZJUndfXl8agP4gVyRgxUAs5GboHCqdBIkXxSE+
         WSNg9uzrsQwUzfElFfbV+2wtqmOdqWhl1jkPxu6kJFGH5Xd5uGpSWsLv7Od4RYu+oEjK
         HXH0evim6VOdAy7a4otLoDt+W1YnZhhDpk0ScpdPkFcKnnb4II224GPDSQMwNZ3g6khH
         VgXivyFvbKQDKNujfoAAwVUYnoNBazM3QY3H8Q30FVNNXZrvIlXi2X/OI5xoDvqkcUkK
         24Dw==
X-Gm-Message-State: AOJu0Ywl4WZ7zz0RBCUoqzbWksdjxyrizbDInCw5cQF1pFtHQmmGrAax
	ElrsrUmuSwNjz45Y4Q7nRVCc7GAH3Jlvki2wntYRvbqd/JM1QdReLzodZaFmE7I=
X-Google-Smtp-Source: AGHT+IGHTmLXzZ4dbyEnVSVT1MrRjAMRM8nYk4BRv40HrWRSUnLpPYVy0DGHhCrF7OXDSp+mVHyrlw==
X-Received: by 2002:a17:906:36d1:b0:a52:4edb:6db7 with SMTP id b17-20020a17090636d100b00a524edb6db7mr319651ejc.54.1713384423496;
        Wed, 17 Apr 2024 13:07:03 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm6128057ejd.98.2024.04.17.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:07:02 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Small qcom_iommu cleanups
Date: Wed, 17 Apr 2024 22:06:58 +0200
Message-Id: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIrIGYC/x2MQQqAIBAAvxJ7TigJsb4SEbGttQfb0oog/HvSc
 RhmXogUmCJ0xQuBbo4sW4a6LADXaVtI8ZwZdKWbqqmNOmVnVAeKH1m8v5Qlp02WFluCnO2BHD/
 /sh9S+gAK8gcnYgAAAA==
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384421; l=515;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FP49noh0itl+WdqHEAWcbgLL5Hde1RFigpB7XfXqmKc=;
 b=5/FbJrPNf4NOjKn27gt1gSHYQTPLvXP3Q/wmxcWPxxhTyDF9y1nO8Yev7Lm6eN7TR1F6ztJIU
 VEbRiJZYxJWCb1lNQrR88PCttN36W1/IRLJpjwJGHXzSIN1jFYqU75k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As it says on the can

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      iommu/qcom: Remove useless forward definition
      iommu/qcom: Always consume all clocks

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 54 +++++++++------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)
---
base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
change-id: 20240416-topic-qcom_iommu-8ef262408c9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

