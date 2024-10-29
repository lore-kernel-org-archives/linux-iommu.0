Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A728E7
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164562; cv=none; b=qHNs9ou6pKeODVvuoTBwp1on9NxVKOyLepG/PETqtz4ZwN4j60ASCFX0yZiTp37bFTBw2KVT0H330S3OwLJUFlSoUbId0j+2w3BCeFnuOoC2HZ04FcCcH/IFn0A5muV50WnPahPf+5ZGoRNociKNxaNKTI8lhjpd79kEV8UMbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164562; c=relaxed/simple;
	bh=qtvhP3BM/6oaAqSjF70JQ+bcY1BSugwvuvHfI8/Y9OE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=brjYyUwZdaqt/JUo6zJETOIS3GqnxToXXqzrK2Ss49moQQpzOfLZeDIKQVFwu6hU8AKeUdVR/QPUM4eKiJ5ut2AWx8676LMPMU4UHepntkcovrrcCCoPJvkrbAsgR4q9+qQb0rvhrlNUIBDE7tdrNf6Vd1ifbGkYpAV2HCLsCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSW7dYgU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSW7dYgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730164561; x=1761700561;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qtvhP3BM/6oaAqSjF70JQ+bcY1BSugwvuvHfI8/Y9OE=;
  b=SSW7dYgUvgrNQlGDW9FLcM77ZxIWvFCss8eozV75S74s7bYGbwRjoQSh
   +oxdVB2jTyuzxPhaQpUiS/DfhTl0QyVWVf5vQTCL1euMyIMTu651fpVCD
   pICcjXcCqZZQtRhp69w3NGKbKznSEzOgV935OZGkmWilF0d6x5BMQ0vo+
   WQlhHZjI6d35R9NvMftjrPO87xnrf1qFDAWuoQALzai/WAKQxt1B95AzK
   z6OWt71dU2vNLPXLZQBk/pmNQmb/4TMDf5TtvvZTED8JJZJPJnVxhreBn
   xDyvrLYr1orS/uwBPw7KzCVEnlZ+G/xM/koIrNbuxznQMpd6cHHK4gXoz
   g==;
X-CSE-ConnectionGUID: 4WllnRv9RSmQOrCEdiaNIA==
X-CSE-MsgGUID: Ypa2pxpySbChV2W+eOCDTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40402191"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="40402191"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:15:59 -0700
X-CSE-ConnectionGUID: ITSvMkV5Tee/M7dZMFMK8w==
X-CSE-MsgGUID: GDZxkv1oQFeQqJc47U+aLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86927010"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:15:58 -0700
Message-ID: <a45ae593-20b0-4604-bf2e-2870b2c7f11a@linux.intel.com>
Date: Tue, 29 Oct 2024 09:15:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, tglx@linutronix.de,
 peterz@infradead.org
Subject: Re: Suspicious RCU usage in enable_drhd_fault_handling()
To: Ido Schimmel <idosch@idosch.org>, iommu@lists.linux.dev
References: <Zx9OwdLIc_VoQ0-a@shredder.mtl.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zx9OwdLIc_VoQ0-a@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/28 16:43, Ido Schimmel wrote:
> Hi,
> 
> I have recently enabled CONFIG_RCU_EXPERT and CONFIG_PROVE_RCU_LIST in
> our debug configuration file and started observing the following splat
> [1] on one of our machines during boot. Searched the archives, but did
> not find a similar report.
> 
> Not sure what is the right fix as I am not familiar with this code, but
> I can easily test patches.

Thanks for reporting this issue. I've been able to reproduce it locally
and will work on a fix. I'll let you know as soon as I have an update.

--
baolu
