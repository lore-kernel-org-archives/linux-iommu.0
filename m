Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF018A6A8
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424823; cv=none; b=ba8y18sED6woJMW8Np75OmIc5DCTHOHMJAXun2xbCUFpCIQ3L4QTbxnUMTWyEzH5hYRcpG+BiXWZfWgBFOqbWvoqamaYeSJxvGK/Bgfh+6ZrQColqma3Aa9fn6dr+/sQZokFkoXbJnBPBIQbyeHy/7p2/FLQffJ8cbU5lkfdW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424823; c=relaxed/simple;
	bh=dR0nfY6GEZ3yOr/Ehd4BMntDHEqTN2fTGWOfpFmvskU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CF9aHLlaQW2aiAfY00OPDC01linIl0pfRFbqG2hxLs3JgfOOMVueTZgwIxWqJ1SjRv5Ham+lQkwbvtOxJmIQ89scpHvOO5hyJmKRwQxvhCy9oVoyy52uL2aCqZd1Id7g5Q45SoRmr9rFweeqGecciNjKnhnohPB0CD4c+KkQf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ltoCIyug; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ltoCIyug"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777424818; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZIGgm1LnnTKQYeHSW75Afg46i5j+k0U/fuPrhUWSwJ4=;
	b=ltoCIyuggRdxHP386ZWGJhSRq3bqkpitH2iY0Zf91TfX8dk28HOqzfEHSI+Fh3cp3dkuVBC/1/ndUjAVNSQWZyCsJqDsSSaBjFEJ1G7xRPfV1UgIG2BhjjG5ZkqHfCd6dm7RrOI7emjsTVi/SEzLeOuDIeTyVgDx6FT1iySJAZg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vlBef_1777424814;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vlBef_1777424814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:06:56 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp) page table support  
Date: Wed, 29 Apr 2026 09:06:50 +0800
Message-Id: <20260429010650.61646-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133239.GC849557@ziepe.ca>
References: <20260428133239.GC849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>>  	case 57:
>>  		pt_top_set_level(&table->common, 4);
>>  		break;
>> +	/*
>> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
>> +	 * The top level is the same as for the first-stage counterpart.
>> +	 */
>> +	case 41:
>> +		pt_top_set_level(&table->common, 2);
>> +		table->second_stage = true;
>> +		break;
>
>Second stage needs to be an explicit PT_FEAT not implicitly deduced
>based on the vasz.

Agreed. I will add an explicit PT_FEAT_RISCV_SECOND_STAGE flag and
stop deriving second-stage semantics from vasz.

Thanks,
Fangyu

>
>Jason
