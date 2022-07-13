Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D44681
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 16:13:17 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id d17so5160292qvs.0
        for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GaxfdpGNL8YRjj66No72cOJoJPEZtfBFVgsIyJmO4lU=;
        b=TbZQrMWzqmV2q4cNpeo632IJAuAP8p7vPi3HkNkBr45GfCmJh7BB5GThjXLE7e1i2F
         Os6MdPT3kcLGAJegTHUPeeERf2seJDyDc0XLnMY13LqMj/AVXd9GZVyhtU4g7LjEDBzK
         c5C+WDU6rcsm7/tktRdYH7I5mYZmReTokI9t2v5016SGuHDKaAZMVCDaDmeRKY71zo5B
         E7d0GN7jE+bUgHEAAMqxMRZ8jpw4UMOWgqHjrBZnxarnhdFiVzNvqd9a3laCtUP/b/Dj
         poiZnJ5p9ghaEPAM+mpeuJx55zSiArOPY/rwnr7hipglemmiijtCNtkyWUYUCYfvFUDv
         w4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GaxfdpGNL8YRjj66No72cOJoJPEZtfBFVgsIyJmO4lU=;
        b=dYNtmr7kArWAqmIUgBT8hbyF1Dx2Sxe0dPzvw/CvT2tiaW7u7mLzUO33LXJkuxf8hC
         5a6Zx+LHpmo46iqIUbqIit13DGRtZrIY1pacPdLtNn53oS94sVCKDxVxSYSziNSVn9Iq
         MACEGoINe2wdFKsIeFjsL37NOOq22GSx7fLUjofiANenWfRjVJuZBTPcMM1a0biyVrBg
         IWOZlHBRXqZlXaIaBpwbToPij9+T1IsLqdL3ESPQOkx0Lm/V23UcH+aUABZ1PO0euv9u
         +yerIfNNUEirBiMCbBY8UEtbJgYY5OkLEIxUTY7kMOEe39wwhFM9z0ShzD/A/wMFUv88
         tUWw==
X-Gm-Message-State: AJIora8FpyeTYsHtGdSbn7cx8yKTloldCPCKCFUHvfj/fBTY31VZ9mTS
	/7qoqFyHJq2BjLWXpdyAMso=
X-Google-Smtp-Source: AGRyM1vX34USIrp8zyxD/WoTxnYaFdwszxXudT/G9ndO4Sj9LiwO+1hRlGftSRoX9GgdV/Okq+NYDw==
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id c10-20020a0ceb4a000000b00472f9363ea0mr4017113qvq.43.1657728796043;
        Wed, 13 Jul 2022 09:13:16 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:7360:5d5d:6684:e04b])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006b258b73eeesm11558730qki.120.2022.07.13.09.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 09:13:15 -0700 (PDT)
Date: Wed, 13 Jul 2022 09:13:15 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	kernel test robot <oliver.sang@intel.com>, iommu@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: avoid invalid memory access via
 node_online(NUMA_NO_NODE)
Message-ID: <Ys7vG+CvJKEggPpM@yury-laptop>
References: <20220712153836.41599-1-alexandr.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712153836.41599-1-alexandr.lobakin@intel.com>

On Tue, Jul 12, 2022 at 05:38:36PM +0200, Alexander Lobakin wrote:
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
> 
> Fixes: ee34b32d8c29 ("dmar: support for parsing Remapping Hardware Static Affinity structure")
> Cc: stable@vger.kernel.org # 2.6.33+
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Applied, thanks!

Thanks,
Yury

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
