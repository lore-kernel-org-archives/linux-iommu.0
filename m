Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E34414
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640746; x=1689176746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8HjPXg0vMWijjAzqReQodiFn+1+MvBU8lI9SQD+sr0=;
  b=maqgdLc8oH54EmLUZsXJAJyxC5oL1Eh2GIMdjJ3xBOJtJuKevw6Uabg+
   QFDX5uOTHcIfcAuNplA4OJcamfcXfiKiGgFutMghNSvDjAU+TpliK0BHF
   lUYaCuk1V6S9kwvilheKGBFjsnpqeqEuJWpjIpT+LdE0yCWV2ZfyHd/rO
   s/Kjwy/E1DDn9RsT1XndA3aQRbR6sAE1+0hKnHz5D5gIjjUydJ/yJQ6Hb
   v3InOBk9sbppfDTIQOMz9OZQuqI26OqCDaAz+9FEg27eKIqb/Of0q6QYr
   1LQI9MzDtElqtEawnTpTAovlkBY286py3z9UpVFOxgCXRv8BEgHFZDwl0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310593209"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="310593209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="592674036"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2022 08:45:38 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
	by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 26CFjb8E024821;
	Tue, 12 Jul 2022 16:45:37 +0100
From: Alexander Lobakin <alexandr.lobakin@intel.com>
To: Yury Norov <yury.norov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        kernel test robot <oliver.sang@intel.com>, iommu@lists.linux.dev,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: avoid invalid memory access via node_online(NUMA_NO_NODE)
Date: Tue, 12 Jul 2022 17:44:07 +0200
Message-Id: <20220712154407.42196-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712153836.41599-1-alexandr.lobakin@intel.com>
References: <20220712153836.41599-1-alexandr.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 12 Jul 2022 17:38:36 +0200

> KASAN reports:
> 
> [ 4.668325][ T0] BUG: KASAN: wild-memory-access in dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497)
> [    4.676149][    T0] Read of size 8 at addr 1fffffff85115558 by task swapper/0/0
> [    4.683454][    T0]
> [    4.685638][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc3-00004-g0e862838f290 #1
> [    4.694331][    T0] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [    4.703196][    T0] Call Trace:
> [    4.706334][    T0]  <TASK>
> [ 4.709133][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497)
> 
> after converting the type of the first argument (@nr, bit number)
> of arch_test_bit() from `long` to `unsigned long`[0].
> 
> Under certain conditions (for example, when ACPI NUMA is disabled
> via command line), pxm_to_node() can return %NUMA_NO_NODE (-1).
> It is valid 'magic' number of NUMA node, but not valid bit number
> to use in bitops.
> node_online() eventually descends to test_bit() without checking
> for the input, assuming it's on caller side (which might be good
> for perf-critical tasks). There, -1 becomes %ULONG_MAX which leads
> to an insane array index when calculating bit position in memory.
> 
> For now, add an explicit check for @node being not %NUMA_NO_NODE
> before calling test_bit(). The actual logics didn't change here
> at all.

Bah, forgot to insert the link here. Hope not worth resending ._.

[0] https://github.com/norov/linux/commit/0e862838f290147ea9c16db852d8d494b552d38d

> 
> Fixes: ee34b32d8c29 ("dmar: support for parsing Remapping Hardware Static Affinity structure")
> Cc: stable@vger.kernel.org # 2.6.33+
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 9699ca101c62..64b14ac4c7b0 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -494,7 +494,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
>  		if (drhd->reg_base_addr == rhsa->base_address) {
>  			int node = pxm_to_node(rhsa->proximity_domain);
>  
> -			if (!node_online(node))
> +			if (node != NUMA_NO_NODE && !node_online(node))
>  				node = NUMA_NO_NODE;
>  			drhd->iommu->node = node;
>  			return 0;
> -- 
> 2.36.1

Thanks,
Olek
