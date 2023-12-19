Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289A1426D
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO7T04IU"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e239c49d0so4065345e87.2
        for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980143; x=1703584943; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=eO7T04IU8zc2W/lZnrSnxna52jTmjv+pOm1Twm4qmu2YhSi3EKlnKgJP23pl6Ret7B
         Ec/e/hsP+0AoOyzsQK+9GCQ+4/26meIhOaBlO1A/8kYF6ZXs3rR65GSwjfZL8VOhtZZ+
         H/Xi2woQYcinl4S2hmN6Sgcfz/crdSelSfR3oRMAM/X0fedeBxygzADcMQysu9SWjs5f
         MdJYRdOraIzXgoobqWj5OJj/u5cLSFLd17P8YtmT7vrKd8Driy+SrNQPTy9dqxv284pU
         Q469dTFaKfOXfVEcFsxGOlWBSO1rDK0O/4ZLP+o7RucLlLAkOF9hgCrr8DAfr8hkpLwM
         fVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980143; x=1703584943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=kTZZFAWMElddXPf1CB10mfDmL1DPQt7tJWkheZHbO7C6bTF990ZFuUmY/6xPuavMFB
         FjpJSBW7Q13gFCCgJeKJ2UMJjFj8nYb3sF0M/RdEH5RkkEJuBcmWpvoS+WFQIr9FntIR
         TAswI//NRRjLC9DxchMKNL1+OrDaPIJ3hQWX0AKNarJjLADvb4O+xSb1DcK1KiuENa9g
         ib9XHeHDyey86M9/SHOKBtQKGXkowz0W5Zo0/TyGAHyES5QwGocg+6snqlevsuqSMyIC
         nHfGhpOmjxKuS26+hY7JiIidMFTebNmGDcKmIL1PfpdxBO1wb/zUZaY6EhoTYjMvMYFt
         g9uQ==
X-Gm-Message-State: AOJu0Yy1932Tnt54LALKrAgN8+gBGabPKeL0wB9En8G6ihLdAQvO8Ukn
	NKU7qVjx7NbmKFxcMk9On+8=
X-Google-Smtp-Source: AGHT+IGGyi36JojkdScUn6fM9cojSilK3uIeYR37ylgaQGGepsG17xKE2lLl8KGvgmI8cf12vBdpMA==
X-Received: by 2002:ac2:5e35:0:b0:50e:35e5:f22a with SMTP id o21-20020ac25e35000000b0050e35e5f22amr1537214lfg.16.1702980143419;
        Tue, 19 Dec 2023 02:02:23 -0800 (PST)
Received: from alsp.netis.cc ([2a02:2168:8a0b:bd00:ec0a:381e:719d:789d])
        by smtp.googlemail.com with ESMTPSA id s11-20020a056512214b00b0050e4bf426desm42161lfr.246.2023.12.19.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:02:23 -0800 (PST)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	ToWill Deacon <will@kernel.org>
Cc: Alexander Sapozhnikov <alsp705@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iommu: amd: NULL value may be dereferenced
Date: Tue, 19 Dec 2023 13:02:19 +0300
Message-Id: <20231219100219.17332-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer 'dom' which was dereferenced at iommu.c:1993 
is compared to NULL value at iommu.c:1998.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0924144bac8..64a88e67be9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1985,6 +1985,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 
+	if (!dom)
+		return;
+
 	domain = to_pdomain(dom);
 
 	if (domain->dev_cnt > 0)
-- 
2.40.1

