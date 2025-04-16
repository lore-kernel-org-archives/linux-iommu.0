Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B051F8937
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827485; cv=none; b=NDwX+t2UDQ8x885y5deN2fFGJIzwO2Hkx7J8VF/Hpbk9IMtyVLvoVeruCZIE1QEVSvgT8q01ZIWsn41IMsIfk/Yfyp88anq0zknpiajv2HAV2ev6IoOa0WP/gsd0KMa1pWVpCaaPsOAjN/m7hQZP4tUI6EZnQOj41jBic1SJcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827485; c=relaxed/simple;
	bh=3DKkQU9Mom2lVRMeCwp0ivdrDyuKM3G5b3qIYQX+qDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6SDnADKzUpUbpKT6qvmmZNV4zf8kEm3w8Em8ZFIWSof4DaJPGrVT+ckIYVKlP4IvidAxSDh7Bx9UO0QeQ90KK9HmWlJk70Q/P2kPhISMhx6MArN7jdzpB5YirhC+XOfdWRpdlORRe5KM8axv6joIiIJNmOp2b018iecqJOM5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FKew2855; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FKew2855"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5e2fe5f17so682499985a.3
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744827481; x=1745432281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhIqXs3b02Zr9EkAcj7RO68Dtso22D3FSSNBcsVaNJc=;
        b=FKew2855kGiptUw/gIx6igJ0x3HjIdjdc/lSs8/St+CzAO0TbS4xGbcsiRTsVCWWhe
         CxDUtgPBKKoOBiUFeywViJTz/n2FYbU68xwJ4Li5e8OdlDgJMtxE8fzqfEzkeLJnaNW8
         PsGN3ESs3rNYq8Wnklo6Av0x9okhCvW3ofJz/kOqy3kF6TJr0D8JzHNYVpzIlQ5sTXt+
         N8qCQavBh/mOxrrn88BsSNJD0NcKyC4J8KtkAxtVKGDMHfQscA1LFC0YEiXRESg/D7+K
         JcRtmRbw1KfJCoZr6JcToG822RiW7UdDogoAW6BoMqRgl9a3KhTBaPJR6BgrGsPmCmfE
         9+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744827481; x=1745432281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhIqXs3b02Zr9EkAcj7RO68Dtso22D3FSSNBcsVaNJc=;
        b=csJv9YogndCv3ZsMDUXIhlEotzTEhDXiyzzoed5mS0fUKOrgD6xr3a4X0IE4Iw+/nA
         J+nHn9WqHq8KT05SHUaQ3yjbdZc8hN5hgiPK9f71ficxpWb4Q/F7NnR6l4odp/QMIGNL
         rqEaZwfwdX5Ik6tzR6OrsoFTnBBZYBeJG/7vjvQfqoz9uNVeLHGTbV70JqZ6S5ZCU4zS
         ty/YBdaRCAeL4QGAu+rl/FR37mjjOH4kbFxWQHWlJ7ol3J4QoVnteSO8qqbwrqA02lSq
         oeiKgEJUKS8rn6CJc4quRiwSrB8G6pYi7HxhAeuMiVfItkTKI3E7uF9QVL+enlMxwaLZ
         WCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVGQaoun/0dq3bsmZCwXJ6mgSp1d2eFS4qCp0R8HHX/0F/xan90HagbIIgOnI2dvcskRKsLSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf0wxiW16I7FQd/ZZ+Cs/rCifBztraq2utTijEsluRMlvqOD6s
	iSsejVznpW5lpSCVOLjut+wxw1rgKJeQjkWcKB1T9bR+UqX3bU8u0+jYlsmfblw=
X-Gm-Gg: ASbGncteHl72D5EaCkYGEpTwLEbflbcShx6LfF9JEfOykHKW96v2VqsQZFE9EHRIyu3
	uascAZhDPhHBm27ELQWmr5M8M/EZwAS1KkKwx0RgMG9F7OErdQ5yG25IxiGiDkxOvR/+xqOsarF
	UMG8tE+PMTtnQIoI4cMqaX8NnAWg2TFKR59O7YF8YWy1ahKPYP/RHA0LNCOq2BamyKhPtxYoJ4K
	mUM1OO+QxrxjtWnCgoL8iPLUfJ/IwxK5AqDGjHqiUKKqJGKwKJK4DC2h6pFFPP5IIqkfOcNqAkW
	hj03eqAcG2ybYVOVXjMPzrndMzgG/fSWMCfOTA0XAOtqzypuvnHoypnT5fGimaqO3m1Zwb1JCJD
	bKCUo1yD/3600rls3jsQ=
X-Google-Smtp-Source: AGHT+IHO7Bqf4Fmw+LiZOuVSnpTOMSKYZPCbuJqFFE5vxmLzphTTuPO4Jd1IQCZQaz4uW5OwoW3Ysw==
X-Received: by 2002:a05:620a:171e:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7c919064377mr376498885a.42.1744827481008;
        Wed, 16 Apr 2025 11:18:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de1esm1088777885a.103.2025.04.16.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:17:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u57Kh-00000004wJB-0tjv;
	Wed, 16 Apr 2025 15:17:59 -0300
Date: Wed, 16 Apr 2025 15:17:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250416181759.GF493866@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>

On Wed, Apr 16, 2025 at 11:04:27AM -0700, Jacob Pan wrote:

> Per last discussion "SMMU driver have a list of potential addresses and
> select the first one that does not intersect with the non-working IOVA
> ranges.". If we don't know what the "non-working IOVA" is, how do we
> know it does not intersect the "potential addresses"?

I had understood from previous discussions that this platform is
properly creating IOMMU_RESV_RESERVED regions for the IOVA that
doesn't work. Otherwise everything is broken..

Presumably that happens through iommu_dma_get_resv_regions() calling
of_iommu_get_resv_regions() on a DT platform. There is a schema
describing how to do this, so platform firmware should be able to do it..

So the fix seems trivial enough to me:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed1266a..ebba18579151bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3562,17 +3562,29 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	struct iommu_resv_region *region;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
+	static const u64 msi_bases[] = { MSI_IOVA_BASE, 0x12340000 };
 
 	iommu_dma_get_resv_regions(dev, head);
+
+	/*
+	 * Use the first msi_base that does not intersect with a platform
+	 * reserved region. The SW MSI base selection is entirely arbitary.
+	 */
+	for (i = 0; i != ARRAY_SIZE(msi_bases); i++) {
+		struct iommu_resv_region *region;
+
+		if (resv_intersects(msi_bases[i], MSI_IOVA_LENGTH))
+			continue;
+
+		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH,
+						 IOMMU_WRITE | IOMMU_NOEXEC |
+							 IOMMU_MMIO,
+						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+		if (!region)
+			return;
+		list_add_tail(&region->list, head);
+		return;
+	}
 }
 
 static int arm_smmu_dev_enable_feature(struct device *dev,

Jason
