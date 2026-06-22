Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173492BD587
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171033; cv=none; b=s8g0UfQBZZn6JyVGk1Bc+1hrI7+CwQE8TzszA3XIMskDjGKQSYYfvnISoIFUJrc/fU/s76MNZCioIcRqewNiFnrYYJX4UVZw2rIFlMYTBwDzuFSJTo+6KCzjg4AHyrQI9Gj2ELVx0uiG9TaRMfIYD4Ye0t14+DhAoLA95h7xopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171033; c=relaxed/simple;
	bh=Id55ZmT3Ny8JY/8w5j8U96LeMpdqCvG/wazyNv7Ousw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7O2focYZ8n/6XEctLITFuKemFuGXV1e3bW5sm/3XycC3clYtiNuv0lBuZbGhgb6w97QwBFAW2pwPzuvT+pAZobTsYgrgceClISjEYcI1UprYDMFqJ0PBDKqJFhmEu4Oa74gUVwybFIA60jlLinJ0OhVDWK9oyFgIKoMSxnI8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yg5oIQtT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yg5oIQtT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso18465ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782171031; x=1782775831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BLj+HmvLjzLOHpEqRh1wn6kUXzQVKOV8V8gw6F5PDGc=;
        b=Yg5oIQtTH9R1gxLb7fEhvEHXchjO7a17yXmFeiKzO5UCugOHlqufo3PhY6EQdquujq
         0obO12TVuO6Hxw3JVEoqyvFffsjFQrk/TMzWU57oUDUmSspBv4Ic1AOxABskXN5i7WEi
         SlFInTsuOpQfYoZ+unrpDZ0QlQMdriEveZM2Kh7G2xs5KRRkIOMmpN1RBfvLawWVin70
         cyJeLUj6ME1E8E8QrMUGhOtxbmDmSecJdzZjTuVObxs3qMOSUc8t8lqthUYSwnakqmxV
         h5QsidBLeIdwetfYQv9xc5SlU3o9Y90QqZ5Jr8n0LtJ3TdGV9ehJUJd6cxUdhJkL/h3F
         Y31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782171031; x=1782775831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLj+HmvLjzLOHpEqRh1wn6kUXzQVKOV8V8gw6F5PDGc=;
        b=DTieNwksTbGKqCuHEWK8WsDe/Twrb/TCodV0BJpuM5r1CT6Xqc6goZvDFaz9WcCoci
         FrQBmhU8eXsr64XyuQ/3CFFKS9UbKZBuBqx8lNOLEXhXX5h11sc2UzFTmUH3+pI/adXJ
         +Mc6kItVlrCPuEFTbmStCG0VhMkfoQpUe8iQlq2XVo4KlxrlhJdKsosD8u36VFFgmy+L
         LzZsAtccttLwPSYlXxDmJkVoKK4hijJTz6jsuUAP2VCyNaIBottlaagiEc8YchWy+1Y8
         kye6laKVn5qhgalyVZ/UfhXCh5zVPkL7z0rGlpmSHVGwRMZWJWEjHFJ/fppP7l9+CLKB
         UMpA==
X-Forwarded-Encrypted: i=1; AHgh+RpOegnlR1a/9/OftgLwFb0SxdxZQS9PNjWsH+YqUNaHvp3eorWbJL/4PEedErZZcdFfXRC7Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv1NQvLI6nlQ74GghvicfwHC8e9YSbvUQAShiGBEER5NY4X1k4
	Ga3qp7vjwJ69ilD/1fCrBceoV+ZfXTLRQatiuuAu3rsNwCbw5/vVkflvV+NHQms7ig==
X-Gm-Gg: AfdE7cncs9fGy39wv9IfdMZWS9MUGAmHVX+QFCmDkBc8rIdggK2UNXrdpFT3CensSRo
	uDbpgu7sOIo8JzX6Btykp4RrxnIHMbdoq1VLcXuNI/jHjCBiQkVB64QrixS5TzFkECr4Krwid6u
	Now7LAK5t3N1MOKmFkp3DSnWZDmLq3Dzo+XPuK5NU9uhh1pqmLOIoegbBD5ofdULCEBGbFJ1zss
	lgwwtwFF6BBBxP4CJwpSmDfWVVZvF9OIfZAojwtYbDYNhrWl7vvo8o1yymLqA2RLLlrPSb7eC0m
	MESYTE2DTzM81BMMofvy+rU/+auYj/hZ/z3PhaKMp17zubgruAGG/IzConrWcbxNwHJufQzd+Dk
	83d0K/8MQzszf17d9/SfXqy86U4mVN3d8xdRZACb18sWmmlv8Fhv3Z2t/YtmSZHH2wQ1owOT2Gu
	QdNNNHC9E9fQn9cSPrpnGJiwPTFIPB4vWANKCxpRGic4S2TfRpjVolfAUFGcHvytt1MjW8yFMBx
	nxUQI/F
X-Received: by 2002:a17:902:ec88:b0:2c1:ee6e:4e4e with SMTP id d9443c01a7336-2c7c713f231mr649335ad.31.1782171030705;
        Mon, 22 Jun 2026 16:30:30 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1aa087e9sm2638998a91.2.2026.06.22.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:30:30 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:30:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ajnFOZuL2WXrZCLd@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-11-skhawaja@google.com>
 <23d4a3b9-41ac-4e05-ada6-01b6ae5e9f04@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23d4a3b9-41ac-4e05-ada6-01b6ae5e9f04@linux.intel.com>

On Mon, Jun 22, 2026 at 01:14:48PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 87 +++++++++++++++++++++++---------
>>  drivers/iommu/intel/iommu.h      |  7 +++
>>  drivers/iommu/intel/liveupdate.c | 60 ++++++++++++++++++++++
>>  3 files changed, 130 insertions(+), 24 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 26258861e3bf..cd40e274482b 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -990,15 +990,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>  		iommu_disable_translation(iommu);
>>  }
>>-static void free_dmar_iommu(struct intel_iommu *iommu)
>>+static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
>>  {
>>  	if (iommu->copied_tables) {
>>  		bitmap_free(iommu->copied_tables);
>>  		iommu->copied_tables = NULL;
>>  	}
>>-	/* free context mapping */
>>-	free_context_table(iommu);
>>+	/* free context mapping if there is no serialized state. */
>>+	if (!iommu_ser)
>>+		free_context_table(iommu);
>>  	if (ecap_prs(iommu->ecap))
>>  		intel_iommu_finish_prq(iommu);
>
>disable_dmar_iommu() and free_dmar_iommu() are always paired in the
>code. How about merging them into a single helper that is aware of iommu
>preservation? Something like the following?
>
>static void release_dmar_iommu(struct intel_iommu *iommu)
>{
>        struct iommu_hw_ser *iommu_ser =
>                        iommu_get_preserved_data(iommu->reg_phys, 
>IOMMU_INTEL);
>
>        /*
>         * All iommu domains must have been detached from the devices,
>         * hence there should be no domain IDs in use.
>         */
>        if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
>                return;
>
>        if ((iommu->gcmd & DMA_GCMD_TE) && !iommu_ser)
>                iommu_disable_translation(iommu);
>
>        if (iommu->copied_tables) {
>                bitmap_free(iommu->copied_tables);
>                iommu->copied_tables = NULL;
>        }
>
>        /* free context mapping if there is no serialized state. */
>        if (!iommu_ser)
>                free_context_table(iommu);
>
>        if (ecap_prs(iommu->ecap))
>                intel_iommu_finish_prq(iommu);
>}

This looks great. I will update this in v4.
>
>Thanks,
>baolu
>

Thanks,
Sami
