Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4373D16EF
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065152; cv=none; b=H38T1iuoVowQqH7hwSTztiADezseino8RP24bkXyarC4vxDyLtX6VBCti+rc4GzIRK8micESqShZ++jm//NpwCe84ZPb0FSMTNI7w06gOusXZxMryQOEXbFE7lBJIDvCIBMrj7Y2nzCKfEiztupytHCM+qdVlyig53JMiOBHIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065152; c=relaxed/simple;
	bh=ai9qc1lPJY+Yjfa+voLyahiV/loyiFjcD0nuhpD6/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8acOrSxz6iXvuWW9H5qPkDtgwaJ14426q2gqo77SwuRxPn4gHrHnoPmst4mSFxzJ8mKS7Eh8hNVCInBYgRCjiVdT94kv9+JvLp173p4TjLV2aXqVTipfBt7WMEzUzUsyXMuY73HlGa66Wgu6G/7jNcl34dOPShvSwDjABTXLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbkQD79O; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbkQD79O"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d1ddcdf4so2321cf.0
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065149; x=1780669949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Vt6NJ/1ID8MCy+YuGg9aIM9aiVrg+WLBywxH6BVRc=;
        b=kbkQD79OHw/djIhkNmcrkPiL2v5qa6mGGYUwi1pOrsl8uSI26SF3Qcqzn40d1lsjiG
         w5v8DCfxbHefL9sHQUYvZXZhYYhl+pEcsL7obLwyfD/f/aWr147xf7W7sL0Uikhe/irO
         R4f2eAxjqkHLRuDR9WMFEc1kj2KmyFEsa2wWvZJil/KPL7jMOAtwQtRFMdC4Mn2XZetZ
         mv73sIuB4UzAZ4fW1WZEhqGX5ueTKs9Tj5A2KQPDFApvlafFlyqq0g840LfU85coT4sJ
         T2uJ3tQIG1IcVbh9q/HFO8W6mYe2O3Wb+vT2dMxl3jo06IQQfWMDRP1Hw9EFsZeAIxXC
         cJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065149; x=1780669949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2Vt6NJ/1ID8MCy+YuGg9aIM9aiVrg+WLBywxH6BVRc=;
        b=eY8i3DIu0JmEDjMRqqNBC5o6wbGC3Mot8KguF/ONQCTw5SWO7wm7rpeWWe0xnqLnHI
         GXmEFvnq6szVUXM3M1ehiJPIO7vEAG3iGKQ9csPwgyBvPxgxG0GzrkeTX2fFLGlRl2kv
         bLNrkWoI2VEbdHI9FNaJ/4OiAzfHUA8Ptzeql3T15ZgCJdc4m1Nrl0zqvyw7Qen33kcr
         L961FfS/jPuyfPIeWgkXct06ADZlMIfmIvOPPega7WUEX/Z75n+VIrPnUHjPz8fLB0jC
         PfJvX64gv8UKhZ9Fkj4A1CkdDdKE94nIz5XKZ+ltccJyNdQrV7LAN8UTzrCrsE6498Ap
         ZoTw==
X-Gm-Message-State: AOJu0YzVg93VIldEY1M7Kh7ZCq2MqfyPYXHX9saM1rUzwFR2dkgKTaf7
	sQyTk9OB21Hs5SPCbcH/JT0D34yjQEybf/690BtXkW1RWJpqEFcvWF/wWXLp0sZdtw==
X-Gm-Gg: Acq92OGSufWlKI99WTH0X8k9+7FFncKLs8qWDxCi1RmMuwMkvbJZ0jv+ZocRpt6Mqwa
	hbKHsbfXL3lPK2bfgmmgLZCknpPvhilhema4ITG6h+3XT6g9SW0roYf9EERjFkjHg1eWVND2Dvg
	wcNDRPs3PVGCjUwDKUyEoMcOC3d6yXlqSN9HSW2oVCxHHFqqGrhF6w+IO1y5iGGSnELZY5uvJk0
	+Qs9ZeDTVc78ZqBpyU0qQ9mhq6jYOpgiZUoXw9tjIZ3GE5jL3U/0gMgxZvm8p/W1Rz6AwR/MvTp
	9qz4/0WVYQf3auvcO+KswXdeV/umBceaRFgh40s+hLWh50NrZehevLRZ0GPE2w2R+WVSxVgFYgB
	Pv1akkWVGAx4r0PO9yAXpJSGhIdUOnHoZ9io3gKjqz/h7SR+tU0J0/juXmoLHU8U5jdACcTPvkG
	gOlFKkhTIZ73I0i4TKUkcZA7bdQysksLTaYZUFPiq/EnG88+WVhLLW4qwIqAD6JYz66X3f
X-Received: by 2002:a17:902:db07:b0:2b9:a39a:e5db with SMTP id d9443c01a7336-2bf22eb6216mr1645625ad.7.1780065148948;
        Fri, 29 May 2026 07:32:28 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd85dsm20999405ad.25.2026.05.29.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:32:28 -0700 (PDT)
Date: Fri, 29 May 2026 14:32:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 02/11] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ahmjdjkhCHWpD10P@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-3-praan@google.com>
 <aheb/OLd9AQO6rD8@Asurada-Nvidia>
 <ahgaQm5y_9mISKg0@google.com>
 <ahi8/7NnqW5TzY4P@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahi8/7NnqW5TzY4P@Asurada-Nvidia>

On Thu, May 28, 2026 at 03:09:03PM -0700, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 10:34:42AM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 27, 2026 at 06:35:56PM -0700, Nicolin Chen wrote:
> > > On Wed, May 27, 2026 at 10:13:58PM +0000, Pranjal Shrivastava wrote:
> > I'm planning to rename it to arm_smmu_drain_cmdq(), sounds good?
> 
> That sounds okay.
> 
> Though my series is still at the early review stage, I would like
> to merge those two functions at some point

Makes sense.

> 
> Do you know if my implementation can work for cmdq too? Seems that
> only the WFE would be different, which can be a bool?

I think we can definitely unify these. I had a similar approach in my v2. 
I've reviewed your PRI series and I think it would be best to use a common 
helper for both use cases. 

Maybe you include this patch in your series to combine the draining logic
It leverages the helpers you factored out in your Patch 2 and adds a 
toggle for the queue_empty requirement of Runtime PM. It also checks for 
WFE appropriately:

Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue() helper

Introduce a unified arm_smmu_drain_queue() helper to handle both 
snapshot-based cohort draining (for IOPF) and polling until queue_empty 
(required for Runtime PM).

The helper dynamically checks for the WFE requirement when targeting the 
CMDQ and uses cond_resched() to avoid starving the threaded IRQ handlers 
responsible for consuming entries from other queues.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 866c711b118b..cf41b3cf5985f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -894,6 +894,38 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+				struct arm_smmu_queue *q,
+				bool until_empty)
+{
+	struct arm_smmu_queue_poll qp;
+	u32 snapshot_prod, cons;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+
+	/* Secondary CMDQs don't support WFE*/
+	qp.wfe &= (q == &smmu->cmdq.q);
+
+	snapshot_prod = readl_relaxed(q->prod_reg);
+
+	do {
+		u32 target_prod;
+
+		cons = readl_relaxed(q->cons_reg);
+		target_prod = until_empty ? readl_relaxed(q->prod_reg) : snapshot_prod;
+
+		if (__queue_empty(&q->llq, cons, target_prod) ||
+		    __queue_consumed(&q->llq, cons, target_prod))
+			return 0;
+
+		cond_resched();
+	} while (!(ret = queue_poll(&qp)));
+
+	dev_warn_ratelimited(smmu->dev,
+			     "queue drain timed out at prod=0x%x cons=0x%x\n",
+			     readl_relaxed(q->prod_reg), cons);
+	return ret;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
--

Thanks,
Praan
