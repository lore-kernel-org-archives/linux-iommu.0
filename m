Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2A85274
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545687; cv=none; b=WSK80a6bEG+tnm/q4v7Go3jE4g4Y+FtehONoOzFyqyEMYblCyCzwqi7DwwNKMUaPmW2youeTbkOUdqlmHEKtZcsRlHbXfvKjhZo8xWR7ZPKO8R0NsFAzeTrmfQYXbd+yWK74XsRlQGLFPr43kzeP18FQK627Ax3YvKMJBbWdmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545687; c=relaxed/simple;
	bh=LT4xmTSiwf6MEZrgufw6Agul8BJ7L+62Ik3/4ND9/8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ReghER4F9nV12ji+lR/58IhnqkGo+fu9Ddh7RxNyMnOt3DUbSyodOig1bkowX5QaK2RP5Pdc8Cr2CPNYuYJ7MjQc1Xt7FinsJjHDjCG/BQfRLmgpkmriGwMOqcQ+5bTt+9TIsYTBMd0Y1lrg24wHDEvHV5wOsP5wYuKkGY/WL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1kV/RLs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1kV/RLs"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so72480851fa.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716545684; x=1717150484; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdJ80E9UD3JGSNwvxw6Hw9BF6gAVHfxqyyZwP/dGEco=;
        b=U1kV/RLsOgpiFre+4wVs5RjFIMYRlx5I73sUDRF5jr//eUTB27I/0MKHiKeZiFZfJr
         xYIf52yE/NSnWgr/Ju3oiFIdyvHmBxhVFh2h2Gh3R11Qwn8dcYHOAu9wvqvuTH7I4pS3
         /UtynK7Kta3S1j83RqYPdkQsV9I535g3RXccNHGyom4GmPyxVpkW9ST+kA3aRhSMrykb
         srPVj8dE45AjW50HGoOhP89JPwH0sxJ8F5XzhuMPn48KuukuHs4BG8vb4N1MQ++pqoYr
         Hghtg7Be4XIHfTPKmUQCTpo6YpztnSe36jRC9JrpCGASWRLy0na9pP93ZTnSnwcCrGtS
         aRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716545684; x=1717150484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdJ80E9UD3JGSNwvxw6Hw9BF6gAVHfxqyyZwP/dGEco=;
        b=DXFQPBT351AZn21aYmv9Qar+8CiI5UYTqMNaAhrKcHZ+85eeL4oMSodK3yi4BSPDJC
         /FA0GTa0DykGYCSZmBg1x0M/hbpUE1f1Tm3b9bTpgJY4vkg+oS8h57jL/jpFdh7jujYk
         I2t2FbnU8FwrmEgmQ8jMfbWedZ8tyAVanFViSLDtMDYDcSMUX9AavS5d/hNFDR9Ev99n
         YoT9lxAxwgXLYJTDLQAKjChAixjOnJpH8nnObuWvmPgucrz6WDpn9zayKqwOU4xapQZE
         Ow8v97rrwQgPTQRbTPwgFJLhykcASraMyHJnd5gnGNPcXmK0BQ/RPLDxVgnAWP9GCLGn
         Xndg==
X-Gm-Message-State: AOJu0YxHNYF3bn8Y/3YSUf6PhIvPiY3Cx6FMwVf7BIff4iVZEcci1Ta6
	83x83pfAkLTlrhwpSbOt55c78WXA77EHUsHeOeTB0/qhevUqgCs83bx82FV/yrw=
X-Google-Smtp-Source: AGHT+IHbT5VJkhQO82lho2721hH749SOubZ6Fqq5Z3pePM37xj4zRLoFk7dFDBaeFMSz/2GQgBp+fw==
X-Received: by 2002:a2e:b044:0:b0:2df:c0c7:9046 with SMTP id 38308e7fff4ca-2e95b24c5d8mr11216071fa.35.1716545683579;
        Fri, 24 May 2024 03:14:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f75acesm48182025e9.27.2024.05.24.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:14:43 -0700 (PDT)
Date: Fri, 24 May 2024 13:14:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jgg@ziepe.ca
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/arm-smmu-v3: Build the whole CD in
 arm_smmu_make_s1_cd()
Message-ID: <849e3d77-0a3c-43c4-878d-a0e061c8cd61@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jason Gunthorpe,

Commit 04905c17f648 ("iommu/arm-smmu-v3: Build the whole CD in
arm_smmu_make_s1_cd()") from Apr 30, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2314 arm_smmu_domain_finalise_s1()
	error: uninitialized symbol 'asid'.

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
    2301 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
    2302                                        struct arm_smmu_domain *smmu_domain)
    2303 {
    2304         int ret;
    2305         u32 asid;
    2306         struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
    2307 
    2308         refcount_set(&cd->refs, 1);
    2309 
    2310         /* Prevent SVA from modifying the ASID until it is written to the CD */
    2311         mutex_lock(&arm_smmu_asid_lock);
    2312         ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
    2313                        XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
--> 2314         cd->asid        = (u16)asid;
                                   ^^^^^^^^^^
Uninitialized if xa_alloc() fails.  UBSan will also complain at runtime.

    2315         mutex_unlock(&arm_smmu_asid_lock);
    2316         return ret;
    2317 }

regards,
dan carpenter
