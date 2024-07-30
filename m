Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E438C1F
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303510; cv=none; b=HODnI+D0ZzFnyb34I7NSM3iH5+b9WiLfWQj0HfZRSVWEdomxb6xS9geLqq2rXmT8vM14TR5uoEdxroPdIsO8xyKPc4y8Doay8BusW38+n8OnPui+jntfKdmdUByp+It1XZCnMrfY8qbhkQj5ux5/cbhIoKbYgSxEqLcX3MjpEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303510; c=relaxed/simple;
	bh=vCMeJLxBE1E1OUKIuCiF5v71+zDefOF1YYBnAe/5hlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcEkdPoIGlgiBlmFSP5FEhFIWIjNDlxDuzn5c4ysU7z+kDo3Oyy8DpNDrX7VxNnfIx09t+Ui7Cn8T7rT945NcLTR0Yxk/9GrQpUwvtA/zuDGgUSgvo8p2B4KEmHVCfQ+2mDZVtLkT3l71g2b04juxqHkMcwEs3Onl3wbkWy+SzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzbtnI23; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzbtnI23"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b95b710e2cso24757356d6.2
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 18:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722303508; x=1722908308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl23btDpfXcYyDJZrQxbw4uzYXVetl2r/66y8xWnu+c=;
        b=KzbtnI23IWaFeri3AOcRitCHvFSgcEqKFcx8zrIRi7C3hL5CjTWWfAzCVavPcBArlJ
         yw7l91RqvBW6arfHRsyMBvLjOs8CsVqQqRJRChTXHo0YuNT0JbL6KWzEgXZTUiHkypTy
         Ay2E0eJLW0MoxyUbVwQRheIktYrFzqN0pZtmz2XylCIo4iBqZwe2sj4VSIrA+cERkRW7
         w4sB6k8Eu1+VfkZCWY2QYL9waAeVghyFpgpBUp6OG1X5n7Wb4aZLAbqZ0vb32iWHGpj8
         OJKlyRYIzecALX7OQcTbesdG2ailPAOBAPOa+Eb2rx3WOqObRj/541ko8r9/a72oYZyB
         rN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722303508; x=1722908308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl23btDpfXcYyDJZrQxbw4uzYXVetl2r/66y8xWnu+c=;
        b=MEBEwLGif+R2JjtGCepnny+lqfAfc0OwkbcsG0hGyW0DXRNWmSHp8zR7uJGsEeo77R
         2jcLMYFZCy4EcjDg4uDmJ3WzAfWFzdTEJ2fapPJEW00+Xf6ACZMgJ5MJpgMmSg3ph/wy
         e0CS4dnmXWrkbkxZeh/6YJ+jjvqbdeE9ZnuFSVlzqyWm917zeowxP8zF6cexP31Y1Pz/
         H7jcPTsuNb7dPAXc/gK6uPzboDTOznjHS71R2Hm10CZ4ZvN+gXAPiZDv++Oh/g7P8Jcp
         CHPGIk4bEPdfDLUL/dBUgOB7ynq5qNfID6CmPNesqLzP5lSxsCtwGGWy/SufRW5/CjrS
         Nv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/d4wSJTW/ok70WW4WoBTyhuMuF/Q5P1Zz6MgMdAfxwMtpq/OCEZFQ1n7OxdXxsHBv25MTU6zoEC+F6ARsYyUBoN6X9EY=
X-Gm-Message-State: AOJu0Yyou1j2nzSmHJEWZ9FprgpRFefyS4TunrxmA5eaaHsGhkNhagdm
	qvYEjzHWw9XenMpq1Nyhs/BpX7FdYMXQ3GRbyX0zs4lOnn3DJ1Ll
X-Google-Smtp-Source: AGHT+IFjfgSVi+KOR/NBYMpeFH2G10iYQT6mSJZ9NSOEk4wpt0+LukvkRQ+bUHo6la43XxdEZ8Y39g==
X-Received: by 2002:a05:6214:cc5:b0:6b9:5bfc:557d with SMTP id 6a1803df08f44-6bb559b4d46mr170582156d6.1.1722303507968;
        Mon, 29 Jul 2024 18:38:27 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3facb1e9sm57947226d6.119.2024.07.29.18.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 18:38:27 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 0/2] iommu/arm-smmu-qcom: Add SDM670 SMMU v2
Date: Mon, 29 Jul 2024 21:38:21 -0400
Message-ID: <20240730013820.41702-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the SMMU v2 for the Snapdragon 670, used for the Adreno GPU.

Richard Acayan (2):
  dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
  iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.45.2

