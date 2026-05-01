Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59513783B2
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593668; cv=none; b=J0sA6LTJlRy2ezCnB33KpPkjUduugydy7VaXh6Dhyb8Md17oXDM4sACYuFymwO7WOFcyTUi3dcLsCHy2wxeSv7dslcmExSFtGGevuMpvJUY5vFUUExOFIZsN+62covHqL1yUWiMY5/ld/ulVRzhzb9Si2fuiPS/YIbBiYaCCt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593668; c=relaxed/simple;
	bh=vFS/zQjd56B3fLWY6rq0TVzIfgce3sBAg1mKjG6Ekhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdH7L7TnG1HiDsk0OIX6gDXUBZrV7mYj5S1ZOA7GJQKvP87xgB58SwYASdCOytCJr+fFoUBClzNfPg3BSSkfh4rZq6Gmrlk+5rx/7zsI6nMw8uRq8NRcvX++u0iS63kRP/0M6g5cFVy1ah6kGSN6vifv++JFuLIUYJuW902Jmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGOGRaJj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGOGRaJj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2de07c12745so9468725eec.1
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777593663; x=1778198463; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHpNReJ/NE9/UeuqVc7wulNIRWGmhInh1blTLbI9Cu0=;
        b=cGOGRaJjyDVttUCpQWDwHO/vAroqHacnTiHBl60WfQsC30seC+eWkUx+b7y3YRfrPU
         2YZ6bKQyfr6xF6voRS6azS1SG+JWvPAfbSFk+zvKztkUrJj+5FvL3BnO4soM1ZGanyi3
         N4RgVY59ui9EWidECsEA/IjOKkqPCYp1dUwyrPSng6mpKt2MrbdWcBYotA4zxpr5S8KQ
         n3T0lyKt1BDnzlHu4TU4gQ9p1/r5WEdPoUMKHkN8zrvcRiyr/fg17G0/8DDIRENwTqZ5
         uXd8iLnvjy601XAYa0apIkClrwk46WV6DUO5ch7eKaC1bCGHBEXYqk6FM3IDNS0AdxWa
         4EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777593663; x=1778198463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHpNReJ/NE9/UeuqVc7wulNIRWGmhInh1blTLbI9Cu0=;
        b=EKnEL0c0+p/ZnIbYcyq1QrVmw1R7hQOVke0s5+14H6NykU/7txYZ4Tig9U1AObUhYV
         5tOwTx1jau6E/fjzZGPD4pM2TadR5KZPDxLP9AINwI8gxhClostcWt3nmkrjg72BKLe3
         QUg8eF67zmR9MFfpxe0qVVby/nWPJfWpOHfFmCKZYSGjgxLgyZOuusEf1xm04ZzWuWZ9
         mIPbeBGfDJtqD+Rjhc4Xxct+zCjhllgXujabO6avQgOYdlhDfabDiEZYFhSJimLw7JNc
         RIs+t+Efv0VN18epE573JDJ0VKK4u1gs3kkAMLYNyMDuX7pZl8bdKZp1CaoKClbWENaL
         H6eA==
X-Forwarded-Encrypted: i=1; AFNElJ8pID3XpVMTPX5w6LNQYdACuWjeZB0SaHxsy0NuBJ7klNHpxRVR6NqV2irTo+bC7f4MEqMPCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfDrlnyq7V6wsuScx+tpDn8vdJbf0dr7Oi7BpMR755jd80F0la
	2x4HUE9eMNKmSTCD9qhGRofAabqZ+9ZcaHlX6W+YlrP0pIkDQJ87PznRzpfoU3V9j8z/IlDkKcO
	PJA==
X-Received: from dybvi26.prod.google.com ([2002:a05:7301:531a:b0:2d8:dd18:baee])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1284:b0:2ed:e17:d50d
 with SMTP id 5a478bee46e88-2ee88e25449mr433736eec.32.1777593663040; Thu, 30
 Apr 2026 17:01:03 -0700 (PDT)
Date: Fri,  1 May 2026 00:00:59 +0000
In-Reply-To: <20260430232851.236666-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260430232851.236666-1-wnliu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501000059.262516-1-wnliu@google.com>
Subject: [PATCH] iommu/amd: Fix precedence order in set_dte_passthrough()
From: Weinan Liu <wnliu@google.com>
To: wnliu@google.com
Cc: chrisl@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	patches@lists.linux.dev, robin.murphy@arm.com, santosh.shukla@amd.com, 
	stable@vger.kernel.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Bitwise OR | operator has a higher precedence than the ternary ?:
operatior. It will be incorrectly evaluated as:

new->data[1] |= (FIELD_PREP(...) | dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;

Wrap the conditional operation in parentheses to enforce the
correct evaluation order.

Fixes: 93eee2a49c1b ("iommu/amd: Refactor logic to program the host page table in DTE")
Cc: stable@vger.kernel.org # v7.0.*
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 01171361f9bc..ccffbecb15c2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2149,7 +2149,8 @@ static void set_dte_passthrough(struct iommu_dev_data *dev_data,
 	new->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW;
 
 	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id) |
-			(dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
+
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-- 
2.54.0.545.g6539524ca2-goog

