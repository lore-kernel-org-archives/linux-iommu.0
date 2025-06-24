Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116C170826
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750740257; cv=none; b=LzeCUGDBXckUJ2KNaZwjw8DLf0MwzppdreYjjw5sq3QNzCdA3d5lmxsEFZesX20QFMEYDxyWNkFfCcFQgEzIV6TmTm2NmDN7OsNSKi0J2v3hez4Bke8W20iw1tS9iLEU1gXeOTPTQdlVdz310JjlMckm3V/oRh5etHJQ1O0sSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750740257; c=relaxed/simple;
	bh=70vF/+LDkN4q7jTfHlGAIAhxNTippQO8QdvV+YYKln0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ+krbfzJFJXTnuT324anmRIgToSYgkFNB5+GKiQfCvROOfV0x4Bgig9eU+qcb5JElHTjbE77bcvUtdOWGjLeSMxbDnwFqFw067kqA0cjOG8WGSClK3RyvKTTfvFueZ4Tx5BEKG+b0SqMEoiyb7rw5/dzDiYgW+c5y9tce7H1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtJg/Vod; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtJg/Vod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750740255; x=1782276255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=70vF/+LDkN4q7jTfHlGAIAhxNTippQO8QdvV+YYKln0=;
  b=LtJg/VodfdOJE0vsCBm0M4TQNyrN5nxq20QX2i5afMTULXVLmiHC9azW
   1bbBRV5aRdiPdCxhmk1i/VmAEFTPDikYXq+RVBk7Qpc6FFBhMMw0clXcn
   f+JxwNu8kJG9+gGgX7DrLbWj+rb3wBZJyp2+fittPdZpNRpKTy+WdyQyf
   acgfAmLpuuhr6wBpHVhwUDW03GDtsZ41YSPz2e4e539FcaDUHDtekXxdH
   Xzva66R3IRroVEN/1+Ld4fbb9G5I96u4zVg8DRfYxZGFbMHDx09/LMoaE
   hAXQw27z7s+/UU2FY/D+eoVF8/xU+Q3ZKnszsDz6JDWZjb8FZ32SaACMh
   A==;
X-CSE-ConnectionGUID: 12pD+JysQRWQR6pU+2M/yQ==
X-CSE-MsgGUID: N7XC/r1tQ8WK0rdu0rl+Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53097157"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53097157"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 21:44:14 -0700
X-CSE-ConnectionGUID: /IMDF3uBQ862VPPddpuBuw==
X-CSE-MsgGUID: ZdH+2z/NRSGVG1dkvjtRHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157578062"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 21:44:08 -0700
Message-ID: <06992407-0c84-4f3f-a89a-5986024928a4@linux.intel.com>
Date: Tue, 24 Jun 2025 12:42:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] iommu/vt-d: Use pci_is_display()
To: Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Wunner <lukas@wunner.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 "open list:SOUND" <linux-sound@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250623184757.3774786-1-superm1@kernel.org>
 <20250623184757.3774786-5-superm1@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250623184757.3774786-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 02:47, Mario Limonciello wrote:
> From: Mario Limonciello<mario.limonciello@amd.com>
> 
> The inline pci_is_display() helper does the same thing.  Use it.
> 
> Reviewed-by: Daniel Dadap<ddadap@nvidia.com>
> Reviewed-by: Simona Vetter<simona.vetter@ffwll.ch>
> Suggested-by: Bjorn Helgaas<helgaas@kernel.org>
> Signed-off-by: Mario Limonciello<mario.limonciello@amd.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
