Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8231717A
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218612; cv=none; b=B0dKUft9m90ivhEFleQEpAMTJHAsGYSZfxLAnM2FD4QmAqYDYcXGkLY4ph1pY6TjGH7AiPbhXUXFiAhWvW8ezfc95a4JhbY3VSR1rG+cZ3kX2TcLTmpYnXjtH7c8gjaABPShYe3rJh5Yz73/9L9B5pSzNg4/6E8ROe+ggl0L+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218612; c=relaxed/simple;
	bh=AnFa/CtP+lSwUVwrjVzi3x7025GqoviKL8ywmHKjazs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uvBaBZKwMD3I1oDnIddQiheNtvsKXswFJyJbugkbhFd8rVAdeBfBlHYu5Bg8xzI7MRIALUd0yDG0IWvg6J4+q7IgZyh9abIMutputQmMI71p2qfkyOwVtDYkJoNmBdufOIuVzRvBbokppfgm/7+N5Ssoo2BOT7O8nLt54rMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PatpQGHi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PatpQGHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773218611; x=1804754611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AnFa/CtP+lSwUVwrjVzi3x7025GqoviKL8ywmHKjazs=;
  b=PatpQGHiy3GyFIetMoEtO6I8nxI1NmnBethJ5gfsloGExXPiA5isu7kj
   d4J5Jkvqn5VyOICDTVK4S0K+dY+53x9OcnOkg0M6gsIamOwetmqBn2awx
   VYR87XRpd4chkdrMGCQBrD7bX06jKxC/FuARkhDhgLoReIjvhszGufmgY
   xdl70snILEdq9MNn/jpGCy2xmRbKZj2KJ8LQ1vYt7qRnMW1/ZLpHcyAl9
   SmLvGTHpnYAAIpYYOEI6JP9o3Dv9aj2pyGxBqf5dAX/ZJOF4xCJ64VoQq
   IU+FqyiQkLuJNm9EQ7c6W1S4hY+La+vOOq+/eECb5fuBFGN7CHVRTb+jc
   w==;
X-CSE-ConnectionGUID: CMD9aV0WS4KR+aPJL7n6Fw==
X-CSE-MsgGUID: ZTU3r/pnTU68YPdIlCm9EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84911750"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="84911750"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:43:30 -0700
X-CSE-ConnectionGUID: QgHwdM3YTQe//ArwA4i43w==
X-CSE-MsgGUID: VGMYY9W+QNC/46eXdssdxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220574471"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:43:27 -0700
Message-ID: <5b4fc87c-6fce-4388-8a03-8c483c5fdcb5@linux.intel.com>
Date: Wed, 11 Mar 2026 16:42:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260309134116.GE3717316@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/26 21:41, Jason Gunthorpe wrote:
> On Mon, Mar 09, 2026 at 02:06:42PM +0800, Lu Baolu wrote:
>> +static void intel_pasid_get_used(const u128 *entry, u128 *used)
>> +{
>> +	struct pasid_entry *pe = (struct pasid_entry *)entry;
>> +	struct pasid_entry *ue = (struct pasid_entry *)used;
>> +	u16 pgtt;
>> +
>> +	/* Initialize used bits to 0. */
>> +	memset(ue, 0, sizeof(*ue));
>> +
>> +	/* Present bit always matters. */
>> +	ue->val[0] |= PASID_PTE_PRESENT;
>> +
>> +	/* Nothing more for non-present entries. */
>> +	if (!(pe->val[0] & PASID_PTE_PRESENT))
>> +		return;
>> +
>> +	pgtt = pasid_pte_get_pgtt(pe);
>> +	switch (pgtt) {
>> +	case PASID_ENTRY_PGTT_FL_ONLY:
>> +		/* AW, PGTT */
>> +		ue->val[0] |= GENMASK_ULL(4, 2) | GENMASK_ULL(8, 6);
>> +		/* DID, PWSNP, PGSNP */
>> +		ue->val[1] |= GENMASK_ULL(24, 23) | GENMASK_ULL(15, 0);
>> +		/* FSPTPTR, FSPM */
>> +		ue->val[2] |= GENMASK_ULL(63, 12) | GENMASK_ULL(3, 2);
> This would be an excellent time to properly add these constants 🙁
> 
> /* 9.6 Scalable-Mode PASID Table Entry */
> #define SM_PASID0_P		BIT_U64(0)
> #define SM_PASID0_FPD		BIT_U64(1)
> #define SM_PASID0_AW		GENMASK_U64(4, 2)
> #define SM_PASID0_SSEE		BIT_U64(5)
> #define SM_PASID0_PGTT		GENMASK_U64(8, 6)
> #define SM_PASID0_SSADE		BIT_U64(9)
> #define SM_PASID0_SSPTPTR	GENMASK_U64(63, 12)
> 
> #define SM_PASID1_DID		GENMASK_U64(15, 0)
> #define SM_PASID1_PWSNP		BIT_U64(23)
> #define SM_PASID1_PGSNP		BIT_U64(24)
> #define SM_PASID1_CD		BIT_U64(25)
> #define SM_PASID1_EMTE		BIT_U64(26)
> #define SM_PASID1_PAT		GENMASK_U64(63, 32)
> 
> #define SM_PASID2_SRE		BIT_U64(0)
> #define SM_PASID2_ERE		BIT_U64(1)
> #define SM_PASID2_FSPM		GENMASK_U64(3, 2)
> #define SM_PASID2_WPE		BIT_U64(4)
> #define SM_PASID2_NXE		BIT_U64(5)
> #define SM_PASID2_SMEP		BIT_U64(6)
> #define SM_PASID2_EAFE		BIT_U64(7)
> #define SM_PASID2_FSPTPTR	GENMASK_U64(63, 12)

Yeah, code updated like this,

drivers/iommu/intel/pasid.h:

/* 9.6 Scalable-Mode PASID Table Entry */
#define SM_PASID0_P             BIT_U64(0)
#define SM_PASID0_FPD           BIT_U64(1)
#define SM_PASID0_AW            GENMASK_U64(4, 2)
#define SM_PASID0_PGTT          GENMASK_U64(8, 6)
#define SM_PASID0_SSADE         BIT_U64(9)
#define SM_PASID0_SSPTPTR       GENMASK_U64(63, 12)

#define SM_PASID1_DID           GENMASK_U64(15, 0)
#define SM_PASID1_PWSNP         BIT_U64(23)
#define SM_PASID1_PGSNP         BIT_U64(24)
#define SM_PASID1_CD            BIT_U64(25)
#define SM_PASID1_EMTE          BIT_U64(26)
#define SM_PASID1_PAT           GENMASK_U64(63, 32)

#define SM_PASID2_SRE           BIT_U64(0)
#define SM_PASID2_FSPM          GENMASK_U64(3, 2)
#define SM_PASID2_WPE           BIT_U64(4)
#define SM_PASID2_EAFE          BIT_U64(7)
#define SM_PASID2_FSPTPTR       GENMASK_U64(63, 12)

drivers/iommu/intel/pasid.c:

static void intel_pasid_get_used(const u128 *entry, u128 *used)
{
         struct pasid_entry *pe = (struct pasid_entry *)entry;
         struct pasid_entry *ue = (struct pasid_entry *)used;
         u16 pgtt;

         /* Initialize used bits to 0. */
         memset(ue, 0, sizeof(*ue));

         /* Present bit always matters. */
         ue->val[0] |= SM_PASID0_P;

         /* Nothing more for non-present entries. */
         if (!(pe->val[0] & SM_PASID0_P)) {
                 trace_entry_get_used(entry, used);
                 return;
         }

         pgtt = pasid_pte_get_pgtt(pe);
         switch (pgtt) {
         case PASID_ENTRY_PGTT_FL_ONLY:
                 /* AW, PGTT */
                 ue->val[0] |= SM_PASID0_AW | SM_PASID0_PGTT;
                 /* DID, PWSNP, PGSNP */
                 ue->val[1] |= SM_PASID1_DID | SM_PASID1_PWSNP | 
SM_PASID1_PGSNP;
                 /* FSPTPTR, FSPM */
                 ue->val[2] |= SM_PASID2_FSPTPTR | SM_PASID2_FSPM;
                 break;
         case PASID_ENTRY_PGTT_NESTED:
                 /* FPD, AW, PGTT, SSADE, SSPTPTR*/
                 ue->val[0] |= SM_PASID0_FPD | SM_PASID0_AW | 
SM_PASID0_PGTT |
                                 SM_PASID0_SSADE | SM_PASID0_SSPTPTR;
                 /* PGSNP, DID, PWSNP */
                 ue->val[1] |= SM_PASID1_DID | SM_PASID1_PWSNP | 
SM_PASID1_PGSNP;
                 /* FSPTPTR, FSPM, EAFE, WPE, SRE */
                 ue->val[2] |= SM_PASID2_SRE | SM_PASID2_WPE | 
SM_PASID2_EAFE |
                                 SM_PASID2_FSPM | SM_PASID2_FSPTPTR;
                 break;
         case PASID_ENTRY_PGTT_SL_ONLY:
                 /* FPD, AW, PGTT, SSADE, SSPTPTR */
                 ue->val[0] |= SM_PASID0_FPD | SM_PASID0_AW | 
SM_PASID0_PGTT |
                                 SM_PASID0_SSADE | SM_PASID0_SSPTPTR;
                 /* PGSNP, DID, PWSNP */
                 ue->val[1] |= SM_PASID1_DID | SM_PASID1_PWSNP | 
SM_PASID1_PGSNP;
                 break;
         case PASID_ENTRY_PGTT_PT:
                 /* FPD, AW, PGTT */
                 ue->val[0] |= SM_PASID0_FPD | SM_PASID0_AW | 
SM_PASID0_PGTT;
                 /* PGSNP, DID, PWSNP */
                 ue->val[1] |= SM_PASID1_DID | SM_PASID1_PWSNP | 
SM_PASID1_PGSNP;
                 break;
         default:
                 WARN_ON(true);
         }

         trace_entry_get_used(entry, used);
}

Thanks,
baolu
