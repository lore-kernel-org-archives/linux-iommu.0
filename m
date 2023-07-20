Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37517FE6
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689859111; x=1721395111;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=StnBaGaOlRqqTLgANOZt5SAXy2wagVOHiKTaAVKHt2Y=;
  b=NESimaLjYzpdcbjHU3VdRjEJS5kh0K5WoiaiWm9yqxP48ui06Ej0rGOn
   D6VAguqUew3vkoeT6D9z9/Rg2dypjx/tQDblLMYYNq792C5eOkABOBvDq
   f0sbfwbFFa/m8Ju2MvsZjjVYj4fICK3QyZGW38IKkUN+XZefeUCowM1lG
   qYytyDzJgKF3/uRaAQMR4BucZtZGMTIgjnkX9S2cAbtkAqticGK3ZHQhF
   T4X17xX0vesZXA1evnfvgDbKrb2IqibmNd2S0xpXnlhQCE8lO2B6W/dlh
   bWKRPNWdGZZZNjbRqN7Hm/nNLjXIOHxJQ2fEqB/+p8EQrXQbfkW4dUkq7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370297811"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370297811"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 06:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727684950"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="727684950"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 06:08:28 -0700
Message-ID: <d766f11f-45a6-9d47-3bfb-b3632a0b0f0b@linux.intel.com>
Date: Thu, 20 Jul 2023 21:08:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
Content-Language: en-US
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> Enables message or wire signal interrupts for PCIe and platforms devices.

If this patch could be divided into multiple small patches, each
logically doing one specific thing, it will help people better review
the code.

Best regards,
baolu
