Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D23630A5
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597456; cv=none; b=BEBfo23ZOqi53Jge810n3ys+PmwHkGhMVU6IdXLscBrC/DMNORFnNckFUj02yPDFN2h3/jjHQaDUbcJctfYUsKXvl4bhsJge0sdFvOFoL6FnspUUt9HJ7HbhJZlIiRaNtPyBINoNy9myTllXtI8QYZ4r0YBFpiJ+COY6fr5eq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597456; c=relaxed/simple;
	bh=ibRcrrNUX1YQVaKyCkEgXgQu163NPrN298u0jYV89ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFjpDadl6KMWDpZ5V5YRbQTsLpEriRR0KCTKFf47Mg3ePDN+N/ivo8vzCCiU5ebyrd1fe16SECROUg4t5sV6w0GacKPD96epNoYc4+9+kJcwdenham2mP+xu0iWJxSG/X/X4hSUQ5PhSD+SUWwjKMcPuIpg2MWBesLyoMbYw350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NlFRLrht; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NlFRLrht"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778597451; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=oA/BXvxtFGaJxDC1eZNxER6QIuAZ16AAMSjiGsJs4uo=;
	b=NlFRLrhtkQNuwN0twIFkq1HBF43D7pFSkOLem9QwZgR2/+YsU8HKbQrFOuuhxYPCPHvOBKa+EldJBjy7TIY1JCdbvXFbuKsBe/trtBakicx/Z9zjCDUHcuHtum4429eU6EdxHw9qtwJYqT1t62WCtHT3XCR+71MjoRiTp/c31dA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0X2qnRBI_1778597447;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2qnRBI_1778597447 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 22:50:49 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: Re: [PATCH v4 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt  
Date: Tue, 12 May 2026 22:50:43 +0800
Message-Id: <20260512145043.92214-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <3jtnhvij7vv2wjep42sijdwy6ax4fr4q6w4fwpyh2cpgzvbpel@w42zuvjl5cy7>
References: <3jtnhvij7vv2wjep42sijdwy6ax4fr4q6w4fwpyh2cpgzvbpel@w42zuvjl5cy7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Changes in v4:
>>     - Fix build warning on 32-bit configurations by using BIT_ULL() for RISCVPT_NC and RISCVPT_IO.
>>     - Link to v3:
>>       https://lore.kernel.org/linux-riscv/20260417140746.97817-1-fangyu.yu@linux.alibaba.com/
>
>Please send this as a diff to the patches which are already in the IOMMU tree.
>

Hi Joerg,

Thanks, I’ll resend the fixup diff [1] based on the current IOMMU tree `riscv` branch.

[1] https://lore.kernel.org/linux-riscv/20260512144330.91113-1-fangyu.yu@linux.alibaba.com/

Thanks,
Fangyu

>-Joerg
