Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A634508FF
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175316; cv=none; b=jmQND9NU0dnn4/w0EAEWAmiPSOgGTCBR5ZPsZI4kiW9z+6YjdR5UxLtqKNPBtzBpwrjPbjLkt35UITEuK/K8xFJQ82DyebaDN6oPiuCh5kUwASlpZWYMcSuaVxxelwZm91oKLVpDjY2DPWck/TTR52Y08s10prDnNOGvk8xGPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175316; c=relaxed/simple;
	bh=EFNgio5JOWMY7NVPUg55HwK19tquNLhBfax7Cr3cf4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icfpnUtEsOelaDpuilXNbdzNMfDMVafrdxVhk1HC3rsTfJz9eXuhgvA8YJUoX2MpHQL5Iw/6hv6+FBm2vvRoKFwzDE1mJIOmYPxXGwNmbtrTKa2eq8pg/JSwxCKgCEdr33z+wgUiw3ILYGFJCH3cSx8NO9DXg4SwuwawAF+DVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGayHzVC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGayHzVC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so9905ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778175312; x=1778780112; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qijXZWUS9BjAUoaFT2HJ56UCiXmU4uzgefuSiduaZ1U=;
        b=NGayHzVCUDyLOP8PX9U6vxPc6p3gfzYjvXCf8ThFgL+1h3ZoPKum6Xi8xKq9GCgd9t
         LEAxlVOVGqWgY/deeKSmwPN0JyEn5nd9hv6tybqq0J9u3L2/I0l0Stwaf6IschdbQe7C
         /Tdd9Qvv6fdqLfdUykw+abrRerEpBlOxMumo8I6clDayK7YTAdxzHGvp0CObQNTfj3PV
         o7461xOi5NLqsAR39FWdNAlGiZyky+G45ltF0bDSY8oOVOPGtHp45/dqXmnlOBxv8pN0
         rlXEcMD5I1ufDColHZcgBtfFfGZeefIkhXFTYS5mmE71CegPK1a5yqf0wnIRJYZECMnD
         TEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175312; x=1778780112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qijXZWUS9BjAUoaFT2HJ56UCiXmU4uzgefuSiduaZ1U=;
        b=PgrD6rO9TtQvAFH0U8mIaeVLawDNEiwC2l8Jg7nLSuWP/+LygdKtgxQgP4lD84IzrQ
         aTyNOUALgq/izLmsBOPci6OKfynRjjOmS/bqACO11Qzh6KaLoNbYyzSOkeJhln6cHebp
         qihyXffChOra1cniWhAKyFfzA7OkT30IAi5hMxVuEcJXE11jLyWOAEPt5cYJRwbLatOp
         sYrQGrr3srnMZSSvym60X62lgCjNdQrq4vKip1/rm5eJQQybAUdwpK/qfBb319mFwL8S
         Fn8Zd3jphxmotAX6CspnwaouqYdqCwxDx+yeGOmkcXiZDUjqwCZBkXTWpKSs/nBBr1c6
         uhkw==
X-Forwarded-Encrypted: i=1; AFNElJ+WKEHI2AIH5pVs6snxTx6Lo0lunkEHgzlUcB07EeIYyQfC65CO0T+y5fsoklAAJGwwtLXa7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb8buUjjmBULHmTyYUmlRd0P7OBL5O/P5jkXchE5StOmKpUAN+
	4iMwXa/Q37210v+Z3+hzLOvJxxIz10sDu4eLmQWZujP24KALKgVoTJ6lAmphFI9bAA==
X-Gm-Gg: Acq92OGcc0yyfx0oIj02da5E/QpfGf3Srs6IfwLZUdRZzxjcwbqIaIs1ljGHugHH6go
	2o7tt43WEOVS2EjHFyjrKmCbIo1tNtFiolO5KOI6jcQld/yxqf9CfMZHb+PK+7WGrfbFFQbaClq
	TP9LOBvMW+X8BJlumwqL9VNxKiduh3oeoKaHmdiRbGMI/bOp8TbaQbNvYBcrNW3Jpy9CHL6UkeX
	CBtorO7n5EfEiTFXPPz3hlWJLWFFV9YE0wz7NiBw9ELX0AkAEJoKbm56uxBuVskjUlc6EvfSPGu
	aJin28aI2r3eqMV2f4GWFWq6GjatoX4ZiyQMOScEquAaXRasRPED425LcA5zzH3do82R68aOVFY
	3GWAPX+EUxNromuF1qgsstlbXVBaC98u9iK0Q8GQ8DinR+zGd6yHxLUNgiRy/WufOUvLKIm4mhQ
	OLsJeqKobcLUQgBmcGXZg4pOU4ovIDinr5EbF+/1//orjAl2j+LS5Vqok839VcBB20mlimImuM2
	2rBXKVP
X-Received: by 2002:a17:903:a45:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2baea433256mr102005ad.19.1778175311724;
        Thu, 07 May 2026 10:35:11 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm12708841b3a.49.2026.05.07.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:35:10 -0700 (PDT)
Date: Thu, 7 May 2026 17:35:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <afzFJmpYQ35vJ-dI@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <ad4f1b2c-a79a-4dce-b891-c0df92664a56@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ad4f1b2c-a79a-4dce-b891-c0df92664a56@linux.intel.com>

On Thu, May 07, 2026 at 05:05:07PM +0800, Baolu Lu wrote:
>On 4/28/2026 1:56 AM, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>>  drivers/iommu/intel/iommu.h      |  7 ++++
>>  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 14 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 68fecd4e57fa..4118a0861f38 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>  /* iommu handling */
>>-static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>>+static int iommu_alloc_root_entry(struct intel_iommu *iommu,
>>+				  struct iommu_hw_ser *iommu_ser)
>>  {
>>  	struct root_entry *root;
>>+	if (iommu_ser) {
>>+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>>+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
>
>The root table is already active and being used by the hardware at this
>point, correct? Since the CPU should not be modifying an active table,
>the __iommu_flush_cache() call seems unnecessary and potentially risky.
>
>Furthermore, if the iommu state has been restored, is it necessary to
>call iommu_set_root_entry()? Calling it would essentially replace an
>active, in-use root table with an identical one, which appears
>redundant.

Agreed to both points. I will remove the redundant flush here.

The set_root_entry() is done outside this function in a separate loop
after setup of all iommus, I will check whether the iommu was preserved
there and skip set_root_entry().
>
>>+		return 0;
>>+	}
>>+
>>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>>  	if (!root) {
>>  		pr_err("Allocating root entry for %s failed\n",
>
>Thanks,
>baolu
