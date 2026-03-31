Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44911256C6C
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933948; cv=none; b=NEXqB6D3+GBOtFexEDVgoHhYc6prErJfdc5WPp8VyP1FlbjGkQeS4CKTHwFJEm7U2Cz7QWIrVuEgSnzDscpRxpjgHbGICunXjPrTwBEI7q0XsyE9E7nE2hF07L1THvrTIHfjuIBN6Wz/47kBQWEJ7GP3QhDnBm9x+NqCWrGqMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933948; c=relaxed/simple;
	bh=zcl02xu1BYTixmNxt91kz8xP1HL47BxhYUlh05sD+3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e5f4v/33YwwUO7yGG+fi5QsZE5pzYyTTAl5ccn9jsBc9Q51Q3wOaqCdSevei4IXFqBz4iPSYyOtN7hDGRTne3BVFwFTBN7pnfDwHjA8Ck/h4JJwWwuxMprQkYo5dKkq3nDDccwVLalNgdGME8QBUZJqnO24GzLRSs3t1nQL0rfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpA79tyD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpA79tyD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c7130f88e3so10411771eec.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774933946; x=1775538746; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fNqPUT4y31sfxi3EaoVPyLAMBJL+AOFGM4l5YSc4ak=;
        b=RpA79tyDkklpSJ0xrDfNs/GHqZYyJT0cP8DP/WbPkgqqKCUJtb1MC25VyZpeYCAryF
         JL84Puc7PmwOMKzDOoa4V1AffWW7ByfbkFw+9UYqmhA/ezYdIQjOFgH629/AI6Y05J/W
         /S1fghTqcMMF4dngbJaTom5ydK0fnpwHXS1ByXKXRZxu85ABGyOuqXqTYQTuzuOJF5jb
         +BUEabZEtZDQhybR2IvdCbw+neMdIz9aHSPIbJG4ilJ9xABVoUjUTiggV+PmybuUQKBA
         Wd7Wm8XNe7QSzHmpBXEdY/Z0B0IuexKPQo6hUZ1UVXL7Ekmd/aLSzws5kntaSDZB7Gaa
         mCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933946; x=1775538746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fNqPUT4y31sfxi3EaoVPyLAMBJL+AOFGM4l5YSc4ak=;
        b=rxWc8jo9rf9Dzvzp2cOTFsVMnXP216b8wV5Nprhqsc2TNmTgmRn3ar3BB3XAJDfNtx
         EDtlY+JHtXUWAEVbq20oD202qyavESpq5AyRgkGUkDn7XPDsBe0183fP5PVAJzOjjvXE
         1VdsXjVFCAmvYoRrTZk4adt/cKtFLbpN+gGgWYsjSQkblY1RjgE54jgy3eN8eORBR/fO
         EdSbPBG4VfhuVeJ0qFyffY2rykUWaKYObHDntpPXWNz3F4k4L+v9Po45mZzrhK6ricwX
         djnNq7nH7n8Q+Z7SfhvZZrsxkCuHk0DA984Dn6wfpZ+jsqJjZtk+b01JVcjODpVF8ca3
         Awsw==
X-Forwarded-Encrypted: i=1; AJvYcCWZcBwJOfPpWyBTf3odQnGGoRZxRxfWVQaogFaBhPzjYhBYsjEX/z4YfECLuKlIXVQDFfkY+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8wQymNIXNomLSyu3ZG8I5OvYfOpEUELKekCis4hX+Ug3fgDdp
	RLZGtdfNO0u2MRI3uHIlslqeBtmKqTEHUrO1YdsP4QcnMDm/9rxDzBe6j/N3wisbjx5jWGN/joN
	PDg==
X-Received: from dyb27.prod.google.com ([2002:a05:693c:631b:b0:2c7:1a46:6250])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:724c:b0:2c1:3e6d:2e6e
 with SMTP id 5a478bee46e88-2c185ce8409mr7961323eec.7.1774933945939; Mon, 30
 Mar 2026 22:12:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:12:24 +0000
In-Reply-To: <20260330084206.9251-4-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331051224.3993081-1-wnliu@google.com>
Subject: Re: iommu/amd: Initialize IOMMU Private Address (IPA) space mapping region
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> @@ -2198,6 +2202,10 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
>  		return -ENOMEM;
>  
> +	ret = amd_viommu_init(iommu);
> +	if (ret)
> +		pr_err("Failed to initialize vIOMMU.\n");

Should amd_iommu_viommu be set to false if vIOMMU initialization fails?
Currently, the following logic will indicate that vIOMMU is enabled even if the 
initialization process does not succeed:

 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -2291,6 +2299,9 @@ static void print_iommu_info(void)
 		if (check_feature2(FEATURE_SEVSNPIO_SUP))
 			pr_cont(" SEV-TIO");
 
+		if (check_feature(FEATURE_VIOMMU))
+			pr_cont(" vIOMMU");
+
 		pr_cont("\n");
 	}
 
@@ -2303,6 +2314,8 @@ static void print_iommu_info(void)
 		pr_info("V2 page table enabled (Paging mode : %d level)\n",
 			amd_iommu_gpt_level);
 	}
+	if (amd_iommu_viommu)
+		pr_info("AMD-Vi: vIOMMU enabled\n");
 }
