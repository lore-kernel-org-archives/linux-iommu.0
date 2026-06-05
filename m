Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A44404BD5
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676289; cv=none; b=MmUtYyjsh2bkY8m6lvnVybbjen+5mC+A2JeKpBhlVD7u19ypBe3F+9yekMNT5Py5GSTSPmoba0RvNKsW8Pn/1lPbl0PeTtkiD8zgG7VtFA/pZcwHq54DlPOzDwk0hgNKWvYisvTfB0pLTcF3DHiFAnLdfTksBTLvWimOtdy6dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676289; c=relaxed/simple;
	bh=XRGI76MigkpSmoBHVTbHez1J+BmuHbL3tcuBjvVJSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvEzeu93A0JMyTP3qwwiOdhR2XM728siT8yv9RVUM4WXx0c3yDkaWH9kUGsWxYaxEWGYrCsuVYrkpXMYmxYyr+Bg+FqzmIvoGE31YjUoKASGPiMG0GaYlr2hnCrIBKp0eCjttVW7ZSt0c04KGnhOSe5IMLOvsvaptKY0bOafeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWUiuNjV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWUiuNjV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0b1a48855so142135ad.0
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780676287; x=1781281087; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kt2tlKaxHAEAtMQ5U0c1x3clX9wtZ7zN2hv6EXts24=;
        b=XWUiuNjVg+e+DF3Ut7N2V3GRg/JKHMHfZZeylwhY8N0hq8R932RW25p4qvz6Jjaqu5
         +LCqObEP7uwUUH4WtNauT8pr+BQY9eUvp2IZj7MADbY8mMnu4MYu98Ux01GR80KeVWiE
         nU4IMtMwB1PHboqJtggH4lpuwpFp9KC5TwZhVNj7ft7wwwQCS0tBqX6n+1alugG3R9Mo
         GtSgSKeGMhaem87QOXSMCEh38xwEPJgtUDeglJ+Bg5xBcGepx7UXeSza56usWfRJ59F6
         hCaGlhM+Iedy50uSj/KV/HoLIS5lz/HA0fXwT/iGfBySG+KixNPlH4frzlHQo5FFi6U7
         SIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676287; x=1781281087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Kt2tlKaxHAEAtMQ5U0c1x3clX9wtZ7zN2hv6EXts24=;
        b=QJAQ4paAGbHeBX2lMLapVtS+T3YIoplBAzoqPL6vLLTn/TO56elqJaSTdcZMRsc7Qw
         X27wUjia7Mb7tfZoQeG1nQKoultvMytgFul9um5i60cAB6EhWBg+34Sb4QdRyg30L+iv
         3fVn5juBuLKq+8aGVD3eUmmqfBBWJiI0c6qArEk+LE/hmbRIeD8Vforf3aJVkTEtI/oc
         2JiRGcLbBMKkoMrwelSZK+E2RESIf+nA97DpIArCjBx4Q4wAe+DHfx73xG/zp8jTvT2N
         sQyrCp1YqN8hKD5bVBKCaHhUZPNhYF2DabKm35uAZQn9xYkPa65Xh6JYOEtPukBsiclH
         t5zw==
X-Gm-Message-State: AOJu0YyTvajoemH2pq5NPClwxqF3P93EPbIuiHFtMfz4ZbKWYB1Bn42/
	865LXV4z9003ZoZaplTaWbvGUE99Hjb0TcR3bruTBt8owCYXQ1G3xlVHDZuE8gtJbw==
X-Gm-Gg: Acq92OE1KmwV8gbVUz1vzMN04oKmD2nFUyPt/vINP/9hLUb51NVYDmYmh5YmAZGcz2Z
	wM8WMtJLilcHg+vcvx0ewSoKgo7XFa1B8nZ13+Af1GZmMPYVaJV04wbehaIh0JCJnK4utxiOM50
	S4Lp85KDUdSpWupZmesaC0bXrTRTWXBwndiwcWeqxBxFqqAcbrcjcVr13spThqU5a9PxAp6GbbO
	iiaLwUfj5g+8O9uTJ58L+ibZxL4ZH3QqvFinu42K08nUhji3OKbWMR/oIQ1wt8aSdR+AU8fvKWl
	UumX1fd1l+325o/FslX3y4Fpn784TsBMEK89qSIrDggl5d0mxUobCy3Bjss9pm/TG6F31YROREI
	EtVaWwdh5pXCxx5hFZD8f5KDfevzv2jWE3O60nYFEW6Teo87qrWnUlt+wFvyLvnPLN4Vzv1EOQ/
	dy7DU3vqnfJYhd9Ti+BTZKFZ2XelnME1f2K/5V68M7p8omabVZl+iBcPNX5BNI9ZRuy9EpPqVwV
	qU/dbaPtzJWj4qclosnvQ5yXcslAA==
X-Received: by 2002:a17:903:2349:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2c1eb74103fmr1371525ad.6.1780676286817;
        Fri, 05 Jun 2026 09:18:06 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm97716405ad.26.2026.06.05.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:18:06 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:18:02 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <aiL2spW1i0cwqh-Y@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-4-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
>Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
>WARN_ON(). Since probe-time checks now preclude configuration errors
>any failure during hardware enablement is considered a kernel bug.
>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>index a10affb483a4..0494c68daa19 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>@@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> 	 */
> 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
>-	if (pci_enable_ats(pdev, stu))
>+
>+	 /*
>+	  * Since pci_prepare_ats() has already verified the HW capability
>+	  * and programmed the STE, pci_enable_ats() should not fail here.
>+	  */
>+	if (WARN_ON(pci_enable_ats(pdev, stu)))
> 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> }
>
>-- 
>2.54.0.1032.g2f8565e1d1-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
