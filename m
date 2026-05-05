Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33678311968
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988934; cv=none; b=uZzjp19OdiKlf/uU150l8MDqXCo9b7X3OSrZkaCpzcjcelJuliRvsDoxQrJZT3g+R98eZWDKzm/meV9fwws5SkSFQ6OaKIFg734GhsHqloBM6RqC7xHSvu/8wuhZ5l5vuXP052T8N/x7ZTgq0gT7JallNtuUsGx8Y/e8tsmvASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988934; c=relaxed/simple;
	bh=Zk/1K+MnMpA92ul7kl0jDIMKnTfYzSHa9pyZmtvAxfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPLzHIPA9nId61SzCNiWtbCn1Xa3t1nIW8+gZOl7+Ze7YMIpE7vEKPUd98PDPxF3v4D6jTMwwIxg5hragGakuy0zq/VzNvuMNOzY39vpzD2nQ4KI13sc1zeZaY+aT+UykyjDUYjRDDSO6VhE7SMgxFqTWKUkBGY0yKvRCn9ajJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LLJa0R2N; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LLJa0R2N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777988927; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=AIhBTePeyajf+I+K0EBW6V9IUyGlhUFNxPuEI2KpBN0=;
	b=LLJa0R2Nq4uTZI1OpwoEOBViMjpdxtfErSZFnGpw1Al0PjMqX4N3IUszUj+FO1W4ZVx1vWMbmjOngaXQhcmSLIioLScukvhqThUSePKUoEBdiC/b5zb1lLYi8XVsTPqYNvQYrI9nZGHyZS1NMIRogVLufFHP8K4yZ1eosR7JN3Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2I-OJb_1777988923;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2I-OJb_1777988923 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 May 2026 21:48:45 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
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
Subject: Re: Re: [RFC PATCH 00/11] iommu/riscv: Add hardware dirty tracking for second-stage domains 
Date: Tue,  5 May 2026 21:48:42 +0800
Message-Id: <20260505134842.23549-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <tdcd7276ffsfc6vh3expyfcajnfkowknbtkpyplb3xe3dcukj2@tnhi6jcwrfgn>
References: <tdcd7276ffsfc6vh3expyfcajnfkowknbtkpyplb3xe3dcukj2@tnhi6jcwrfgn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> 
>> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
>> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
>> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
>> autonomously sets D on the first write to a page mapped by an iohgatp
>> domain.  This series wires that capability up to the iommufd dirty-tracking
>> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
>> reports IOMMU_CAP_DIRTY_TRACKING.
>> 
>> Design notes
>> ------------
>> 
>> * The feature is scoped to second-stage (iohgatp) domains only; these are
>>   the domains created for KVM / VFIO device pass-through when userspace
>>   allocates an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT or
>>   IOMMU_HWPT_ALLOC_DIRTY_TRACKING.  First-stage (iosatp) domains are not
>>   touched by this series.
>> 
>> * The page-table side plugs into the existing generic_pt dirty hook
>>   framework (amdv1 / vtdss style).  RISC-V adds the three required PTE
>>   ops – is_write_dirty / make_write_clean / make_write_dirty.
>> 
>> Testing
>> -------
>> 
>> * Test on QEMU RISC-V, a virtio-net and an e1000e device was passed through
>>   to an L2 guest via vfio-pci + iommufd.
>> 
>> * generic_pt KUnit: the existing test_dirty case now runs and passes for
>>   the RISC-V 64-bit format.
>> 
>> Follow-up work
>> --------------
>> * Build a dedicated end-to-end test case that drives the full flow
>>   (HWPT_ALLOC with DIRTY_TRACKING -> attach -> IOAS_MAP -> generate real
>>   DMA -> SET_DIRTY_TRACKING -> GET_DIRTY_BITMAP -> verify bitmap against
>>   expected IOVA footprint) so that the behaviour can be regression-tested
>>   beyond the KUnit PTE-level coverage.
>> 
>> * If possible, rebase and retest on top of the updated "iommu irqbypass"
>>   patchset.
>
>Thanks for this series! I was starting to go down a similar road myself
>in order to limit irqbypass to IOMMU_HWPT_ALLOC_NEST_PARENT domains since
>I wasn't happy with other approaches, e.g. continuing to use s-stage, but
>activating g-stage too with identity mappings since the MSI table can't be
>activated otherwise. Or, simply using g-stage instead of s-stage in order
>to get the MSI table enabled. In the end, I think the best is to require
>nested for irqbypass and this series will provide a good base for that.
>
>I'll rebase irqbypass on this series and test it out.
>

Thanks for the feedback. Jason has provided some helpful suggestions on this
series, and I am in the process of updating it. I expect to send out a new
version in the coming days.

Fangyu

>Thanks,
>drew
