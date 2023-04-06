Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A91872
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 08:55:36 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id l12so38728522wrm.10
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771335; x=1683363335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7txVTxf4VgSRpVhYeEkO74+1AKmp0Ykpq11aY2byhk=;
        b=pfSmWPO3N8Z/GMBw8IydKi0iku0P+O92dK5LhpN58P47xOQXIptsOGaSs9neEUJKqg
         BOvkLDw9p0MMvadI/+5TNgKRLp1tMpJQoAQNULZd87C2us2gw0HoU91U9glatgdoji3x
         9TlRNAkRVec20j2pmoLrXk8B8fORaTh0t9LkFk0HpJO8X0YYQuYZ6++KCgGKC5/ENzHB
         jP13FmuPYy5bKSMyPj3juqOfmunMPAp3tr72ssJtkpw7cLlCw4orS56fatTW07UQMsME
         //l9E1BODxBE9qw/CfFDEFqCLgEwcwiWBC5hT0gyIkdTxnY9PjfsRnDIBYaqZHD8d4N4
         6wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771335; x=1683363335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7txVTxf4VgSRpVhYeEkO74+1AKmp0Ykpq11aY2byhk=;
        b=XDJhsDH2eoG1v9YT2ycywjysxkK/LO1E4+bQg2N+4dJeO/7gbuL8oODviBUKc7MCsz
         jbxfKMcme+b/xecb7qwsDUMXN11oPNWH8jjitA2Fw0sdP1WMuvFU/gd1NVRNIevYOfTw
         fBOi99hXzJx7i7Mf09wCfpBjr2/t9/TjZxOtxtLXxHiklXnnjMrLnDFU3dGFi9znwIwj
         EufBk5FD5oboCbjII2S7pnXX1s7pdBrZ4iultuSALfKs6a4Hfi32oNt3mTpR6FYHdv6f
         0crm6ROyUIM4m99GEa7j4gDjzYhwBmObzXlVscJr10BUwzxv8JG5V19OoCHtk4P5A9ZY
         uoXg==
X-Gm-Message-State: AAQBX9fgycYc75GceDxHSmjIK9CYbBDIKhrwv/hCSHRzOA7ijSZrv7dT
	x4iG7MQqSBJHE1RNTihurpM=
X-Google-Smtp-Source: AKy350Z/yqy0Ka8rHZ160xapJkbWkSFSsDNx8JryjDJ7M1zdz/g42+5DgPJhbaWIUQAq5RLttaL6jA==
X-Received: by 2002:adf:ef03:0:b0:2e4:ff71:1c8e with SMTP id e3-20020adfef03000000b002e4ff711c8emr5681057wro.68.1680771335087;
        Thu, 06 Apr 2023 01:55:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b5-20020adfde05000000b002d78a96cf5fsm1147318wrm.70.2023.04.06.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:55:34 -0700 (PDT)
Date: Thu, 6 Apr 2023 11:55:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/sva: fix signedness bug in iommu_sva_alloc_pasid()
Message-ID: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ida_alloc_range() function returns negative error codes on error.
On success it returns values in the min to max range (inclusive).  It
never returns more then INT_MAX even if "max" is higher.  It never
returns values in the 0 to (min - 1) range.

The bug is that "min" is an unsigned int so negative error codes will
be promoted to high positive values errors treated as success.

Fixes: 1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iommu/iommu-sva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c4ab3c457fbc..6e4f1ba1c148 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -33,8 +33,9 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 	}
 
 	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	if (ret < 0)
 		goto out;
+
 	mm->pasid = ret;
 	ret = 0;
 out:
-- 
2.39.1

