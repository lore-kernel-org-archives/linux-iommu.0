Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4230C0F7
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137243; cv=none; b=t4nuQqQBaK+0T5x5tvJucmPTUA6jZ6NLk/DUoJwCXBgzSDrCxipHIn4WLwJ3k0an5MyTrkXeG6vQHpOgegO5gASLhGZd3mGogYG2gfbsVJoZROtOm3XfEqWLowyPOE2PXmgxKdOG5SjktBLNI17u6Yn8x8HIunCmCGsr00yAcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137243; c=relaxed/simple;
	bh=/lGQoGWo1oVLwX+ZWr0MhUsLDCckySpD+6GSOcPwfpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLwj8Eogus2+/DK3pQSDAKz+uJZ1etFUI4D7FC9eHuAQKUEjMTDKNX64CprWWNXQ1mdJhUi5LfVAF4jBvg++oa51wmat3ko7OTjiUfwVRbeTYHLa6HgtSPELtuYwHCr+Tmsuf1hdOXjfZXzKFxXjxoY9gUQW4UrOUs7JwN8Vtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IVyoB42t; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IVyoB42t"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-778d99112fbso1920046d6.1
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137241; x=1758742041; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZVlkWCCuCYTghm7E9xutK12OPPCXr3fuw+E/JSa8+A=;
        b=IVyoB42tLJUZyk5F1kLxwT8qlvWfEAYq+bFMmUqlbJ05j7xnDNR6OT2EsBvg+7sou4
         WKI7IinJFN6NdRB7g+a06mpmlXmdE0YXnkHSvqplMy9t1zAtvcP5wRbWb1BVzkOA7c4T
         UagqSK+qrg8OXOK7dL0lvxmmLwEZGRn8b92NcrXM5WCCkQ86rdR1JmuKqoV4X8b68BcX
         kBNsU+svmMKdqyEiV78Si3PGvkF++PpXnsagA0tbrfTiW2sgSV2/QhoSzwI1tBMqUMLC
         77NXapOc+ivvxEOaBEEhzQLm+PX8biikovdtb2lgvcVdLd9c51mTu7pdxy/9ld2d4ciG
         9+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137241; x=1758742041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZVlkWCCuCYTghm7E9xutK12OPPCXr3fuw+E/JSa8+A=;
        b=UVLrRTXlDIeEg3+TFlFVA80t3e0XaLseTxo+5fLQyWUJP/OBjODi/yHYkJajc5LIqE
         hpf34WTvBOp6kK8jqsJRVr0N75vGGLG8BhtjjBTSKxTcncCYWl1Yl0Wk5Pev9lMcU4n2
         elUaF9fJjJx5pux96Y9FYZq+UQp1cQ7twCf3HnyJWP1NuoiipkjnVU9tg0R/XB6AmCnM
         e+LX77knF3LO/CVaYLmA2rtYu8QGymw0dLvg2G7vlVRD5P8B19vFps/uB4hzsJVFzLzD
         ykkWjjw6BVSoTL6o6RItn2kVhSMhOlK772deUx4J9EOXxKm0l57u0Du7yHx6153VLZcS
         jEkA==
X-Gm-Message-State: AOJu0YxdGbpY971wCmk166cxm9BopqhkPXZ8fStvTGVukWsN1kM2MXAU
	HHQl4dz6pbz4aQoj995BasEwdFbwukRS5jCMn+nyF1aYyinvVCD1e+6xMEE6wJjpeIM=
X-Gm-Gg: ASbGnct0vdq3A+dnInyw+qCiap1Kjz0h5SIotKqoJNYH9EbsQtMzcvWq6JVbHp9R8Om
	XAqxOewxOvijL9zyRYM0hr722S13MvBDGJm1D4lZAuN0ehcehPd79HfjbxLpL9s/2xrIJlGIoQe
	KFJAoe0eUMnm/Vd6ZTlm2PcFBrGDG0T95DTAjqpqJTMuLnDFlCdI5jJaFBAoHr7WgPF30gDHzBS
	coi8v8WbQMXvEr+ERteunS0bF8LhQoMJUgTocuKnMHZ9AuTibM9cyTaGoFUX68o7Hf+utLroY8m
	k+siiLCvL/hfqaUm22OSajsmRZ+H13sKxfdkrMSmI5jEmN3LwImtVKYq8BxaS0U43NrJJzn5B6J
	ZVDA+F/BPwmUo19VkekKf7dc8FZcRpwl+6w2jqKBgXTCI8j7RgUPJknXGU5Cet6EB3YnL/vO4ZM
	MMFddZ1XhA+4u6AeRZYvug/A==
X-Google-Smtp-Source: AGHT+IGM3xhmzXDRFrNe6F6REL+f8AdNqllu9mwFuh9hgnJJGII/zf5nl5KF8jaDrmx00pWc9hQPkQ==
X-Received: by 2002:a05:6214:1d23:b0:711:4042:9484 with SMTP id 6a1803df08f44-78ece45eb76mr37540046d6.35.1758137240831;
        Wed, 17 Sep 2025 12:27:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm903096d6.53.2025.09.17.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:27:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyxoF-00000008n2r-3JSd;
	Wed, 17 Sep 2025 16:27:19 -0300
Date: Wed, 17 Sep 2025 16:27:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 0/3] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917192719.GJ1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-1-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:37PM +0000, Mostafa Saleh wrote:
> --------
> - With CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
>   It will automatically run at boot as before this patch series.

I would drop this kconfig, kunit does everything required including
run at boot if you want.

> - Otherwise with CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=m:
>   1) on module load:
>      Once the module load the self test will run
>      # modprobe io-pgtable-arm-selftests
> 
>   2) debugfs
>      With CONFIG_KUNIT_DEBUGFS=y You can run the test with
>      # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run
> 
>   3) Using kunit.py
>      You can also use the helper script which uses Qemu in the background
> 
>      # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
>        --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
>       [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
>       [18:01:09] [PASSED] arm_lpae_do_selftests
>       [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
>       [18:01:09] ============================================================

Suggest to include the above instruction in the commit message adding
the kunit so at least it is in the history

Jason
