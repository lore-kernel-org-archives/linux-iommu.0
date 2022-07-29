Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB93D9C
	for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659100242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8ig4hrCoGaeMWK4YPryecvGDibtJlBBHniW+VGCItM=;
	b=UJ0t4+w4jnygIVWgpFJ/75TxAvTkefrSWGPWkvWD1fOKBJzpZbjRWscXhDZ4zueNy5e3fG
	HYPOYpd2uZUfwuS7ck9uBi7pQ1HLexjbncG+0yHEtmQaU3uKM9gLT/36V/DEkKzO/FqXBe
	ZKaQEtjCLKDjv7JOnZZ5H9/WoQ/PS18=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-jhFi_n9XO_WtfxNge5-YEA-1; Fri, 29 Jul 2022 09:10:40 -0400
X-MC-Unique: jhFi_n9XO_WtfxNge5-YEA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-10e88633e1cso1188890fac.21
        for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=v8ig4hrCoGaeMWK4YPryecvGDibtJlBBHniW+VGCItM=;
        b=I528rB1PFnEmLDfZsbafm3es7zeL/kSpPSQe+tvIlAyqdFoJNoRxEXQDXA+L5hwLru
         rEdLJW3ljlSaguGtEAi2axw0NBhNMtM6TVUv/WfpacTlE8a55HxKI7DjzX/Jt4aOlfM7
         GRDHYENvyuUOJ7FS726QIp427r2Q16DUE1VjK5K/eWaDahMp+BzaalcuL8/kQBYiXFBS
         MI/jPcn5iCsGllNn5IJJqVqhMmlgu9EY7DVypF7I7DzKTc1IRukRXJfp43mYs81d9xbn
         YzlIpOIjM2/IvLYJzIu6zhVbBziR4G35hpKwwfyPWiLsJe/wh5ORFQPT/o+olFbmTuE9
         iQ1w==
X-Gm-Message-State: AJIora+rkfU1YhRLFpoNQeW52V0n+E0B+vEXj/BUQoDp7lYgTeSo6QAo
	X1SL3E07y9CTlUlTGjU+d1KBBKh3ljnrsaXSk350zc8MMlZ20HNyCltGxvpHdT3o2UZysxxmezo
	fdzi6Q9Hw9+UCmjo=
X-Received: by 2002:a05:6808:53:b0:33a:5992:9fed with SMTP id v19-20020a056808005300b0033a59929fedmr1628567oic.255.1659100240245;
        Fri, 29 Jul 2022 06:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sskkD2KSk/CCMvR3QauSQuWOM4R/zYnXyj+9pmberneLWu6xXbIbhYL8jvVPQtny3wNw7+/w==
X-Received: by 2002:a05:6808:53:b0:33a:5992:9fed with SMTP id v19-20020a056808005300b0033a59929fedmr1628551oic.255.1659100239811;
        Fri, 29 Jul 2022 06:10:39 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bc31-20020a056820169f00b0042857cd4cb3sm1277353oob.17.2022.07.29.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 06:10:39 -0700 (PDT)
Date: Fri, 29 Jul 2022 06:10:38 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Fix compile warning in init code
Message-ID: <20220729131038.loximy7k3dl5ontj@cantor>
References: <20220729100432.22474-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220729100432.22474-1-joro@8bytes.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 29, 2022 at 12:04:32PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent commit introduced these compile warnings:
> 
>   CC      drivers/iommu/amd/init.o
> drivers/iommu/amd/init.c:938:12: error: ‘iommu_init_ga_log’ defined but not used [-Werror=unused-function]
>   938 | static int iommu_init_ga_log(struct amd_iommu *iommu)
>       |            ^~~~~~~~~~~~~~~~~
> drivers/iommu/amd/init.c:902:12: error: ‘iommu_ga_log_enable’ defined but not used [-Werror=unused-function]
>   902 | static int iommu_ga_log_enable(struct amd_iommu *iommu)
>       |            ^~~~~~~~~~~~~~~~~~~
> 
> The warnings appear because both functions are defined when IRQ
> remapping is not enabled, but only used when IRQ remapping is enabled.
> 
> Fix it by only defining the functions when IRQ remapping is enabled.
> 
> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

