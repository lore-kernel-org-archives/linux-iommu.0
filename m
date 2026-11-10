Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312094;
	b=HnXaJwojp1k5kkvv0eQ4kSUpGIWOOoy/6W1dF7Sl08Hh1e0T7Q9wIzh0nYdECFkAB5YT
	 QR6gGGulkbOiWWe/hHjbbc9ZIrXkZNGOy/5lmjSpbNo/3nufhWCwQ1Ayy0mJwhm3HzqdO
	 ZtJoPvp9LwjuoA0XgetULCCO47eVVkTDVf2cQih+i3duCLU7PkWUpWjd984fnVbNwC9Ec
	 SLdoJQ7M+s7ZA50W6pi9Kj4MAHfpA5/vZOoTDcIRGt+0KQmaFuebKh8Ql1SIC82ZHT0or
	 Cb56uYppDNoL5LlDPXUJWud9BVy1/bGpq4dpe0S/WQGHY1smhx5J5Qg9fz+AiYArtpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312094;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Sr00mrMSg6piJCO3T8q8U9WcCFkg1g8vXSLgSLEAszE=;
	b=rOoU+TJQrySSspA/oPU+isbmZy6SvIakTMysYprmNWukYqPrJzvU2tdu4ABrF67RvREL
	 KFn/I3/RDmDq1h5OqrpPPTbDbX9703VHA6amB7FxUcA8rFrVcajdpO9p9/9z+YVy/1e1I
	 7WtH9Y0/SlMIe7iRN/g6kTEnzQU3e6Cb1WQ42h08KPjVXLx0j+CbD0RAhm8rXwx8qI64v
	 w7HqYOfBqLZM4JLWNndNK2OoK+8PLfFQ2QaD0zOiWc/4yxtoL4vyTl/+UoiXqGefxVePq
	 eyn0pf+7a3LYSPo1kThE8o8RPPDne+KFuw9uhDL88yIlcWfHjNmYeXyoHRMPrDkZIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDC606A333
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 12:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDDC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP4xl36c4z5PkGn;
	Tue, 10 Nov 2026 20:01:31 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 6AAC1K6X083645;
	Tue, 10 Nov 2026 20:01:20 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Tue, 10 Nov 2026 20:01:23 +0800
X-Zmail-TransId: 3e816af3078a02b-e5a48
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
        seanjc@google.com, tanchi25@mails.ucas.ac.cn, tomasz.jeznach@linux.dev,
        will@kernel.org, wu.fei9@sanechips.com.cn,
        zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Tue, 10 Nov 2026 20:01:18 +0800
Message-ID: <20261110120119.184759-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105183222.GE663069@ziepe.ca>
References: <20261105183222.GE663069@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 6AAC1K6X083645
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 20:01:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3079B.001/4jP4xl36c4z5PkGn

Hi Jason,

> On Thu, Nov 05, 2026 at 10:49:44PM +0800, Tan Chi wrote:
> > Hi Shuai and Fei,
> > 
> > I noticed a potential issue with fixing the physical DC's PSCID to 0.
> > 
> > In QEMU, different VFIO devices can have separate stage-1 HWPTs while
> > sharing the same vIOMMU and stage-2 parent. This means two devices may
> > have different first-stage page table roots but the same host GSCID
> > and PSCID=0.
> > 
> > According to the RISC-V IOMMU specification, DC.ta.PSCID identifies
> > the first-stage address space when PDTV=0 and the first stage is not
> > Bare. Could this cause the physical IOMMU to reuse cached translations
> > across different stage-1 address spaces? Even broader invalidations
> > would not prevent such cache aliasing.
> > 
> > There also seems to be a related issue in patch 6.
> > riscv_viommu_cache_invalidate() unconditionally forces PSCV=1 and
> > PSCID=0. However, an IOTINVAL.VMA with PSCV=0 also invalidates global
> > mappings, while PSCV=1 excludes them. This appears to narrow the
> > guest's requested invalidation scope and could leave stale global
> > translations cached.
> > 
> > One possible approach might be to use the PSCID from the guest-provided
> > DC.ta when allocating the nested domain, and preserve the guest's PSCID
> > and PSCV settings during invalidation while substituting the host GSCID.
> > I'm not sure whether additional considerations are needed for PSCID
> > reuse or domain lifetime, though.
> 
> If the guest is issuing invalidations you must always preserve the
> guests "ASID" or whatever your HW calls it. It can be virtualized and
> mapped from a guest view to physical, but it must be preserved and
> physical must be 1:1 with virtual.
> 
> Jason

Thanks for clarifying the software responsibility and the 1:1 mapping
requirement. We will not drop this "ASID/PSCID" or collapse it to zero
in the next version.

I have outlined the approaches we are considering in my reply to Tan Chi.
I would very much appreciate your thoughts on which approach would be
preferable for RISC-V, and on any potential pitfalls we should keep in
mind.

Thanks,
Shuai
