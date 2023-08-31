Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B611CB6
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:46:23 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5958487ca15so14194717b3.1
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503982; x=1694108782; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=97NbLwOzwX2yfBkjP3g3hHfcNULS8xoy6ngi79VwyiQ=;
        b=XviiOrKjLNK92ijD9scm7XGWLmWhFGrI56Lsc9Et+rDesAksoJzks07hQP0y+9OgSr
         4sNXjQs+P3b+dmBXF5ofB9E5sTH274z/dCfbfkO84yRTKFAn2t7rYjl80/gWMC6SYA7X
         nUdh/SvZK6jx0CMCE7wbMYJ9G/AZN4l7nBNQPFjEXWaJVMwiRUX0sY6YWX2QfaeXNHtW
         pAo3fdKMJCEAx575BuOvHn9uEqX97zQmfjzmU6LsLe6s88uyIX3oU0sxtxP1/cnNV5hp
         TDWU0KjmxT6GZi3WXpzRJIu7vW/OHGn9TTfqGi+1THrjqpyBXH0ZDbV4GxQrtTuAkAns
         T+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503982; x=1694108782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97NbLwOzwX2yfBkjP3g3hHfcNULS8xoy6ngi79VwyiQ=;
        b=bli9hEI+POdI1m+LnwCHhcJ7hCk4C3Qow7pYq9EBBvAK7u4jI1OJB2x210Q8QUqHe1
         z42dlPTQuLOmX8Y2bqit4E9S3x0DPT5ZBWp+LV3vsl4iuf1/hIOgRt5k2ytFUv5HU6l3
         NTD5qhfP55plolOWV26dJZlGvNBe91Lkl+Q5bg+jM/4uqHIMjYAb9SLZrXbSWuhuVnaO
         RtVmj4Fdm9tJqufY+NYyElnRYJ1WzbQo36qlaHJbFANhSW+5+SxPsZSb2ro5WPns+pjy
         p4sijSFU3m2Q9Tlq+Eyzqw6lklZG7a4q7NbON5s+I6A9GyNbnSvfuPbDVMFisVmE9zwR
         4qrg==
X-Gm-Message-State: AOJu0Yy/VRPpZDRvUk+zaDn+YwWDize9Xep9nLWOVlzjBQlGN2retCCT
	y/nx7Uc7/WJSCsGcXnzAe19Owkqu7xmNrY5Ki+9FWTk8sE77EyQY4OYIpoYjP0kEueU1d1omc+L
	xkNldLsQiHZU/5mkcHQ98zY2b8GwasGt3TBqZA2oMn39blfy0o7pa7CKCBRXYUWU=
X-Google-Smtp-Source: AGHT+IFnAn3Jgebhh43eiBoBmSBDyph6RaR6op6wjUZNKsymtjXCclD9kKZcfRwzPgCeOQNDjo1qmsyY58LY
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:e40b:0:b0:592:8069:540a with SMTP id
 r11-20020a81e40b000000b005928069540amr2213ywl.8.1693503982384; Thu, 31 Aug
 2023 10:46:22 -0700 (PDT)
Date: Fri,  1 Sep 2023 01:44:37 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v7 8/9] iommu/arm-smmu-v3: Update comment about STE liveness
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v6)

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8d177ed550054..adede66621163 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1091,7 +1091,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-- 
2.42.0.283.g2d96d420d3-goog

