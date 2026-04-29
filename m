Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E813371CE3
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477372; cv=none; b=Z2hAgvrTE1tQawU8Ln1Oxl7OzoyQUJPQgMyZBhZSuOUvfGJGfNv0Mf3MIDM97de0Ntfy46/S8QynP1+Lw3f9kN6i/k3u8eDOhrKexoLQnMxs5TqEoUk0NxPIO6geE3d+RSfI4PLP3743kSPSFDVeifkui4t7x1fIR+lHwbfp5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477372; c=relaxed/simple;
	bh=PyNvOwD2dJEs/yLY0BBdwdZggAsAqPY9cJbAPTGoOys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcRs9JmzTk50gUkJnye4NI0CPFhXQO4Omq9mTODDjJGSNgFXKvKzixTXNnDKviuHy8Qhl3LTnpvXGFwrsXjLUh+LlosdaxIJfIRZ9ybfDeDRWB5AvEyVeFlqDFfV68LrlWgbLMvcJQ2RmfpRvpOJ4JEr5+YYJtvIH5mg/LfiZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GAF0p95/; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GAF0p95/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777477361; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=tas8BUWZ8wM+1fug3uQFtJRlvMGVnHXKsmJWRGCqFW8=;
	b=GAF0p95/MWmZKlOLaUlAev022rsdpNQL2TEqtHJT6B4pkyGXdNTRt769Ya+faowviMfZzjD6tm0QCX+RKzXLFkbJgB0k1CBRu4qXFdssKF3SNSqasS5GYc1i7KxU3rX4AjtQvbHdiwGwab1xKZHZBLLoMCTaC8AW2qh7aXn8kSg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1y9STm_1777477357;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1y9STm_1777477357 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 23:42:39 +0800
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
Subject: Re: Re: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp) page table support 
Date: Wed, 29 Apr 2026 23:42:35 +0800
Message-Id: <20260429154235.47462-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260429121820.GL849557@ziepe.ca>
References: <20260429121820.GL849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> >> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>> >>  	case 57:
>> >>  		pt_top_set_level(&table->common, 4);
>> >>  		break;
>> >> +	/*
>> >> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
>> >> +	 * The top level is the same as for the first-stage counterpart.
>> >> +	 */
>> >> +	case 41:
>> >> +		pt_top_set_level(&table->common, 2);
>> >> +		table->second_stage = true;
>> >> +		break;
>> >
>> >Second stage needs to be an explicit PT_FEAT not implicitly deduced
>> >based on the vasz.
>> 
>> Agreed. I will add an explicit PT_FEAT_RISCV_SECOND_STAGE flag and
>> stop deriving second-stage semantics from vasz.
>
>PT_FEAT_RISCV_S2 would match what I have for ARM
>

Thanks for the suggestion, I’ll use PT_FEAT_RISCV_S2 to match the ARM naming.

Fangyu

>Jason
