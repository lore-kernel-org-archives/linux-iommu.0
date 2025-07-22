Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECE6D17
	for <iommu@lists.linux.dev>; Tue, 22 Jul 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147959; cv=none; b=Ig97OlzyiWrcYcMXXiA/lZVQVksCxbleS0ItcGQGr4xLteSeaJ8hfHR02YYASAR4/mLs7PqcjMnriyp7t7Pbe0VtXdLyeg4966LHReVP/umU05uLC0dNRPsjZoaMm7GYygHa8xEe+DN0E0z5NQ2UMZSCKHySwq12AOSMg/zQ0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147959; c=relaxed/simple;
	bh=aChH1HgJ4eYmwJAR2ddTTkWAtifsgMmCJotxgFV2FZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfl8T0Whuq3GPrGBDhBfI2g7r6vBg3OJVmuSQtcp9gDRt4O1YnYfBj8aSKedAUbju7XA1qesMDGhDAULIN9HGU6v8/GSNsDpUbR2vnh7x0vMdQ6r6fEzb8QOrfKTz/ZVi5Djo7vaYlIKXH76s4KRpVWJ1EA0vBmUJmYealIw4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtnU6VVw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtnU6VVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753147957; x=1784683957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aChH1HgJ4eYmwJAR2ddTTkWAtifsgMmCJotxgFV2FZs=;
  b=AtnU6VVw0tkWNArh2Jb/USlBVEl/+G5P5bKfgV2eHYTJQJ1yjUwp/XEo
   Mdba5p6kKlwYm0tDEDGMuPw5Arh8WDFTQGQlgcjO/AUbXZayDYMmBrEr+
   Z5IxmoZEtdovI5n14a99rX1InFMl+S6eHtcbabMcHNysQmYU7YK/5cG7K
   37I+1MN3nx1o/+OIM1XaCbOZK0CiIWmKUkzn19Z2ESWNoMBIUeUpxLp6k
   8M38GZNd0bTfQGHQhDB3mSAEYhZ0ZuPulkSVPsXtnyBvss5gedy/XwHGK
   ChU4zYvzxdeo9JUuWVE6xXOJ5yu1yUXvPoRC1i1kKN77diFELsnxCrcIj
   A==;
X-CSE-ConnectionGUID: HEEH8xoARKGBsuWlwf7vCg==
X-CSE-MsgGUID: 7OapNcbXQNaeSrdTr8VssA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72951917"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72951917"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:32:35 -0700
X-CSE-ConnectionGUID: UyX/m00NTLSJ0ovVv+o2XQ==
X-CSE-MsgGUID: iirtQ++wTyKGToq86UnOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159086479"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:32:33 -0700
Message-ID: <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Date: Tue, 22 Jul 2025 09:30:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_PCI_Passthrough_/_SR?=
 =?UTF-8?Q?-IOV_Failure_on_Stable_Kernel_=E2=89=A5_v6=2E12=2E35?=
To: Ban ZuoXiang <bbaa@bbaa.fun>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bbaa@bbaa.moe
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 17:59, Ban ZuoXiang wrote:
> Hi all,
> 
> We've identified a regression affecting PCI passthrough / SR-IOV virtualization starting from Linux v6.12.35.
> 
> A user reported that [1], beginning with this version, SR-IOV virtual functions fail to initialize properly inside the guest. The issue appears to some MMIO operations not completing correctly in the guest.
> 
>> [    2.152320] i915 0000:07:00.0: [drm]*ERROR* GT0: GUC: mmio request 0x4509: failure 306/0
>> [    2.152327] i915 0000:07:00.0: [drm]*ERROR* GuC initialization failed (-ENXIO)
>> [    2.152330] i915 0000:07:00.0: [drm]*ERROR* GT0: Failed to initialize GPU, declaring it wedged!
> Here is the|git bisect| log:
> 
>> # bad: [fbad404f04d758c52bae79ca20d0e7fe5fef91d3] Linux 6.12.37
>> # good: [e03ced99c437f4a7992b8fa3d97d598f55453fd0] Linux 6.12.33
>> git bisect start 'HEAD' 'v6.12.33'
>> # bad: [b01a29a80cca28f0c7d0864e2d62fb9616051bfc] ACPI: bus: Bail out if acpi_kobj registration fails
>> git bisect bad b01a29a80cca28f0c7d0864e2d62fb9616051bfc
>> # bad: [b01a29a80cca28f0c7d0864e2d62fb9616051bfc] ACPI: bus: Bail out if acpi_kobj registration fails
>> git bisect bad b01a29a80cca28f0c7d0864e2d62fb9616051bfc
>> # good: [35f116a4658f787bea7e82fdd23e2e9789254f5e] drm/xe: Make xe_gt_freq part of the Documentation
>> git bisect good 35f116a4658f787bea7e82fdd23e2e9789254f5e
>> # good: [261f2a655b709e59a8d759ce9fa478778d9e84f4] crypto: qat - add shutdown handler to qat_c3xxx
>> git bisect good 261f2a655b709e59a8d759ce9fa478778d9e84f4
>> # good: [4d0686b53cc9342be3f8ce06336fd5ab0d206355] ata: ahci: Disallow LPM for Asus B550-F motherboard
>> git bisect good 4d0686b53cc9342be3f8ce06336fd5ab0d206355
>> # bad: [ce4ef0274cb66a4750000f33f2d316c0dbaf4515] KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY
>> git bisect bad ce4ef0274cb66a4750000f33f2d316c0dbaf4515
>> # bad: [8d0645b59b19d97a3b7c5a3fb8dae0c89e98cde9] parisc/unaligned: Fix hex output to show 8 hex chars
>> git bisect bad 8d0645b59b19d97a3b7c5a3fb8dae0c89e98cde9
>> # good: [fed611bd8c7b76b070aa407d0c7558e20d9e1f68] f2fs: fix to do sanity check on ino and xnid
>> git bisect good fed611bd8c7b76b070aa407d0c7558e20d9e1f68
>> # good: [8a008c89e5e5c5332e4c0a33d707db9ddd529f8a] net/sched: fix use-after-free in taprio_dev_notifier
>> git bisect good 8a008c89e5e5c5332e4c0a33d707db9ddd529f8a
>> # bad: [3f2098f4fba7718eb2501207ca6e99d22427f25a] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
>> git bisect bad 3f2098f4fba7718eb2501207ca6e99d22427f25a
>> # bad: [fb5873b779dd5858123c19bbd6959566771e2e83] iommu/vt-d: Restore context entry setup order for aliased devices
>> git bisect bad fb5873b779dd5858123c19bbd6959566771e2e83
>> # good: [81c64c2f84ab581d1c45dbbbca941c13128faee6] net: ftgmac100: select FIXED_PHY
>> git bisect good 81c64c2f84ab581d1c45dbbbca941c13128faee6
>> # first bad commit: [fb5873b779dd5858123c19bbd6959566771e2e83] iommu/vt-d: Restore context entry setup order for aliased devices
>>
>> commit fb5873b779dd5858123c19bbd6959566771e2e83
>> Author: Lu Baolu<baolu.lu@linux.intel.com>
>> Date:   Tue May 20 15:58:49 2025 +0800
>>
>>      iommu/vt-d: Restore context entry setup order for aliased devices
>>      
>>      commit 320302baed05c6456164652541f23d2a96522c06 upstream.
> This commit was introduced in [2], and the issue only affects stable kernels prior to v6.15. Besides, the Ubuntu v6.14-series kernel used by Proxmox also appears to be affected [3].

Thanks for reporting. Can this issue be reproduced with the latest
mainline linux kernel? Can it work if you simply revert this commit?

Thanks,
baolu
