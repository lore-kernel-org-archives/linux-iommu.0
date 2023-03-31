Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727C15C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:31:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id d13so19206744pjh.0
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0dyJHBuK5UpoDUR2HtwiB0N1zgJU2RE6kdVXBTWcZE=;
        b=jND5ce5JWkxV0kSqsZnPmOZC5F+jlDguHcuLWv0PtRKqc0xvdyrkCYfdLOd5wLTf0I
         4f6QOAAEBkUWLxLk+ubfelg6JyUSlWmeVhl6P0hkLnBnoiXbC21BxjBNErX2WoZFzXjI
         mMPx5i1TgomZRiLJhti472rzFjRjMs78zQo6DboaN4OZaWclZRlviF+5fFQ9N7tbYYOq
         ZH0rf/Z1+ifs+NYKnKWRoX9AxH4gTrFeCjxMI7Z6q/SOLbig8zWOec041Yq0O6odTKiT
         jsRK931W+lbOKHwIhflL7hc003WbXxxJ6TytRSXi2ehFRSZ0oPVx48mb4EjT/GUp5+69
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0dyJHBuK5UpoDUR2HtwiB0N1zgJU2RE6kdVXBTWcZE=;
        b=NJPjiuUExwLM5LsVQu+vfVbKrp1lWcR/ZQz3D0qFDsakpgjhmQ5BF2cbv6xfOQEtP2
         BxLvvPK6oImM/2n4xUGsknxv2OuQaL8eWZTYS6/PfPiSyJrwVFv4ow9qxDXtUWIaCAfg
         XpToYSoMVZNDsjk2+XjCDJFj06iqhN28CFH4JzTQa/DUpLod0c/C9MuPTSyVTE1hOKMm
         dECXZMAON+KcaQKUGv5ipGLC81iEcHvj0W5AMsOSIBHjF7IBcjEczW3Rh1IyYAVtOkw1
         i/gcKDjOc5y7Xacoc//QDLVQQBn4dpnTymApwEdU/BQyH0Mdpcsl3AM5lRXzhY1G89g0
         nV9g==
X-Gm-Message-State: AAQBX9fmArOgLdSXotl1Sbrd82yze8+HyoTpJf7gKIWpkg3Jza8ipCdS
	a494GHF+XloSFIMHnPXK8hE=
X-Google-Smtp-Source: AKy350ao0UIaY49NAnVjHbGTq092/pCn7iKgFwIfciJ3fEwDzuOpFLcRz9RQuZFES1aQXmBM0kqbMQ==
X-Received: by 2002:a17:903:32c7:b0:199:4be8:be48 with SMTP id i7-20020a17090332c700b001994be8be48mr9694702plr.19.1680233502317;
        Thu, 30 Mar 2023 20:31:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:41 -0700 (PDT)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 0/2] Add reattaching support and fix memory leak issue
Date: Fri, 31 Mar 2023 11:31:22 +0800
Message-Id: <20230331033124.864691-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

V3:
* Split into two patches;
* Added support reattching an existing domain;
* Release DMA buffer only when domain freed.

V2: https://lkml.org/lkml/2023/3/7/1717
* Added some comment in sprd_iommu_attach_device() for the reason
  of calling sprd_iommu_cleanup().

V1: https://lkml.org/lkml/2023/2/10/198

Chunyan Zhang (2):
  iommu: sprd: release dma buffer to avoid memory leak
  iommu: sprd: Add support for reattaching an existing domain

 drivers/iommu/sprd-iommu.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

-- 
2.25.1

