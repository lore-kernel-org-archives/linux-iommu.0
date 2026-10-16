Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133F54704D
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135847; cv=none; b=d2t26eadDP20TJQNAjpKhFvyvbt/BvuiWRjwkKyClOOSVb3Vo12H3IdU2cRJ7BqLBrp5BHYWzoWpppXgXKu/eGE/jCZSM9SToVacLH/0NbGDOJ88TfgsikneuAdgYsC1wDsB/1c3lAiICe2L5LeYpVt0+jespY553Uy8R9KY4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135847; c=relaxed/simple;
	bh=YQUAcePEFyxkfd6DAyPwLNOssGB0vsZVP0P4//lK15E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcoaP5HBGF04QA0MfD/SqnWel5xWCBlWCxnNDMl+mFICwAIT5K/LbHne4llhXEKjGPQXV/1Ux1ECGRhurY8GJT2cjjUACctSzRk32OTHRHgTaUpVo5Qp4LS8wsJ0FU2MgWOfb4q12Z4ndPmTykBeUjXziCT4Mo9kw0g+xgNuVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j5c6Y2TVkz5B0lT;
	Fri, 16 Oct 2026 15:30:29 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl2.zte.com.cn with SMTP id 69G7UOtm070340;
	Fri, 16 Oct 2026 15:30:24 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Fri, 16 Oct 2026 15:30:26 +0800
X-Zmail-TransId: 3e816ad1d28c024-b7501
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: jgg@ziepe.ca
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev,
        fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn,
        gsh517025@gmail.com, iommu@lists.linux.dev, joro@8bytes.org,
        kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        pbonzini@redhat.com, pjw@kernel.org, robin.murphy@arm.com,
        seanjc@google.com, tomasz.jeznach@linux.dev, will@kernel.org,
        wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 02/12] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Date: Fri, 16 Oct 2026 15:30:20 +0800
Message-ID: <20261016073020.10119-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015235400.GZ14213@ziepe.ca>
References: <20261015235400.GZ14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69G7UOtm070340
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 16 Oct 2026 15:30:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD1D295.000/4j5c6Y2TVkz5B0lT

Hi Jason,

Thank you for your review.

> > +/**
> > + * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
> > + *			     (IOMMU_HWPT_DATA_RISCV_S1)
> > + * @tc: Guest device context translation control
> > + * @iosatp: Guest device context stage-1 root page table pointer
> > + */
> > +struct iommu_hwpt_riscv {
> > +	__aligned_u64 tc;
> > +	__aligned_u64 iosatp;
> > +};
>
> Like the others you need a spec reference explaining exactly what
> these fields are.

I'll add references to the device-context sections of the RISC-V IOMMU
specification ("Leaf DDT entry", "Device-context fields", "Translation
control (tc)", and "First-Stage context (fsc)"), and I'll also include
detailed field information, as ARM does.

Also, I'll rename the field from iosatp to fsc. It holds iosatp when
PDTV=0 and process-directory-table pointer (pdtp) when PDTV=1, and the
two share the same layout, so the name should cover both interpretations
and the uAPI won't need to change when Process-Directory-Table (PDT)
support is added.

>
> Usually it should be the entire guest structure, is it only 16 bytes?

The RISC-V device-context is 32 bytes in base format and 64 bytes in
extended format, but it is not entirely guest-owned in a nested setup:
iohgatp, ta and the extended-format MSI fields are configured by the host.

The guest-owned part is therefore exactly tc and fsc fields, so 16 bytes
is all we take.

Thanks,
Shuai

>
> But this looks broadly right otherwise
>
> Jason
