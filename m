Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93E4BE43B
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554339; cv=fail; b=rHEwqkc6Bg3kKt4KkfNRrvSFTz2W9D3zFEdJfu0x1qjHyClHMlVPPerJBN+f1bNSnEwyWxJRxk5hbd6loBm9gQNb4UDRnLTELwPdl9ra7bDa0NfWnTH7qJj2Rr1UO4ecZYDLDVgEJz8msBXsRW17TG7Ho+GoOul7A6RDiVgZFhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554339; c=relaxed/simple;
	bh=QFhHN7GS1oHErZPrjDT3B18Ra/RGiUYuJG+pLh+OUu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeiX6aHhh5pGFSbBvG/G3/6ZHT293NtR5Vi4BdlE0h4tZU7kB52zQA7KFkptubFk7ol42Nd8kGjTR95SSJUpn5EcKq0T/OIIsr0ohK4ZCCk47zNB5mKwwMjNUF7II8drNO+j2cl3wiTz4rW80ZBLDtCDeLo1RNPyshXtb9OfueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzQ3eRFq; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RzQ3eRFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3KVtM2iSbKSFeFuOJ4nVGMVW1VNT01JoVnMRFROnzaGW0eOOFLEu3FQQSKemrkxbTxE7bMHVVhiATaXwvCvcJO2BHrFyDw6/JiPtb6nXQCwOeRyWzxyQtsHOQfJr93gIu/yftAIXOEr3T1kyRFOo4k9hjNhZWUdV35fVoNh1SVUTcNszZrD2Jo+x7ebw+asmHcewnp7bBHZA69NEfeM9C0kr1Jkd2a5ytpEK7vrBu27+t5mO4mhAXNVtHwWp6b4wiL5mvpmD+ZN0EyObSuaWPytxxo8I6wrmGEcrXpkZf0v6jzNVMTa+uGlSRKY0WaxxIKuMfsRF1XUUg6Bghjebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Osfa7JiFUzjs/sviQL8ZEuzhHZIIKxscrQ8XI/ab9X8=;
 b=SrSuoQ6IKszkbGnJvYuOoK0SpvO8cIhPfbhv/K3wxaqOhFW4NV9jPRwlVtTaK9s/pFVIgrexo9rbD6wrB+x0PhrMrzdRwVjwu8e/dtMmfzlCOheLddd1pJO8w/xYCbxflJ+2J3Z/S+LhzxA1q86BLgIVaqVXTd7FMBYzp847jUXCGQydqIQWkgdtzp/7QJuhVTCzatSzDKNz0cvLl56RtRYr9Z6ks0UtCcewSDWU/tkPd6cYjM7Jjt7KUfr2zIXlOiXwVrWaKEO6xawolG5e5R4z8hVIUZnl+hqelYkGeEQM5hVf6zY8KPe8Ls/jkMW8AURLraIL4gEY6/wUI/gcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Osfa7JiFUzjs/sviQL8ZEuzhHZIIKxscrQ8XI/ab9X8=;
 b=RzQ3eRFqz/nTsyV2JOK5vjMPXXFhdyZKYqzqQmIhu9+JIa/kBVuZLk3pLN7GWNt/3rrE/90MydOmQJyDpr30woEK444E5SFeAqg6zTsL97Yqsgad5HDZK+EOai8xGkGHynMP0SGUBhz11PePbSMTGJrYcUtS8uaN7LWRast+q6s=
Received: from SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:58:50 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5d) by SJ0PR03CA0193.outlook.office365.com
 (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 13:58:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 13:58:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 08:58:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 08:58:45 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 08:58:38 -0500
Date: Fri, 9 Oct 2026 13:58:38 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <skhawaja@google.com>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <dwmw2@infradead.org>, <kevin.tian@intel.com>,
	<dmatlack@google.com>, <vipinsh@google.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] liveupdate: parse the incoming handover tree
 before late_time_init()
Message-ID: <itmq3hzl2thrmx4hsp4q4d73fevfzw7vbcbdvalufksbs2u7pf@ncou6nvcjmsj>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
 <20261005064018.1558-3-Ankit.Soni@amd.com>
 <asdNbLNz7zPaQYXX@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asdNbLNz7zPaQYXX@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1ad2ae-dad9-4865-645c-08df260d723f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|36860700016|376014|82310400026|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kXdGAbgVpE9JG10HS8k748jCtK4ppjmZXoeRhEnbnDMyEP194mSN6z3cCAaDKJXX5elJTv6t8cAOzkFNDVNUr1PGhsHo1lkh4MD4j8vD6+tQwALaJofg40+YOBbnEr415eDin7lln4841RtcQEhHY5sKutH6ktJU1fago8V7IRLd5LkRBy4Qg3/NtpLUFpSS0GTvMWvyV7IbcvSoMyO/ULRWdZ4Dyep6e6MM+QSmxvvz6AWwZhkGDohqn84COZEbhZboBctRZxsynBT6MCwFS/l+LHveCwSfJuZPuTteiF+ovE8C9GitSAhBswR2VhbILbwpG30MU0M+zIR9zctOQvxw6PUwvbEd+n7I5T1X5Sp9GP/1Nm3qJmt8u3QM8IVvghq7xRosm8YnUnB1oQCXqZb+J0P/0XZqZ0WjsEZ4wzBAVBxihhOBLp8f1YxLCTQ7Ryp1+MfTDWehGSW1l1+0LPyjUrjlnSD73EYm7tqrK+w4XGPdEXoYMARVxQgvxjGVWNY00I6RR22+vzeu7XJbItF96+WtVPzOq7japeJNijmkkkm4wgLaJUvswNczEINKQQ65i8COHhnda5nncRVAOPcf8KlZmWzr0EDQ10C4JQwYT3aFeKQMTm9vti06eaNDPao/OxSZZ5twG4yAPFWEvX5FlJFnaJ+BzsBVH5Pjzao9aB2xp8vSbGZSEu7vrHkRpfQmp6VuEE5kTBGBT48RUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pNkpposH5hmlscoCTfRBUmsbmljuHkrXvCN7Wf9mXxeyxCMDT5DaEMMinvjED8Z6T5o/cqe6QbrsIpCheRWW9+y00sQ6bwP+2swd0v/AY9+dB9i9jaSvONvpNzfoml1m1kqnh3ClOaJbjhV0ac0p5w2a3hnS4UFEYN8LLarh3NNafLfE4lAgTHFuPk+7A95m4mt5VwlG0vB9ahBrFhugTLV3+a537uJy8hBJLwH724LMX6/diYbrPO2pW/cwB9jYWRA3uiSabrut0Mn+8woMi6zqYanKG1S7+u3Q42LTjxnAC+CMw9JAL6N43IDE3e+H6NvoyR0cCPaGBgM2ILStaDHZg19HsSG1EvUT1MGF58g4J/oAT3i8MIa/jqFpLalrKMPJ/NuBs55lWaDZEjXAhfL5sArR0Nf6kwDYTXlA8B7fx4OKy8SkvJjVKPiEuJsC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:58:50.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1ad2ae-dad9-4865-645c-08df260d723f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

Hi Mike

On Thu, Oct 08, 2026 at 09:59:40AM +0200, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Oct 05, 2026 at 06:40:12AM +0000, Ankit Soni wrote:
> > LUO parses the handover tree from an early_initcall, which runs inside
> > rest_init() -- the last statement of start_kernel(). Anything earlier in
> > start_kernel() cannot see the incoming state, and cannot tell that it
> > cannot see it: luo_flb_retrieve_one() returns -ENODATA both before the
> > parse and when the previous kernel handed nothing over.
> > 
> > On x86 the IOMMU is such a consumer, because it is also the interrupt
> > remapping provider. amd_iommu_prepare() runs from late_time_init() via
> > enable_IR_x2apic() -> irq_remapping_prepare(), and reaches
> > init_iommu_one_late() long before any initcall.
> > 
> > Fix the ordering rather than teaching each consumer to cope. Call the
> > parse directly from start_kernel(), immediately before late_time_init().
> 
> Why do you suggest to call it exactly here?
> Order of the calls in start_kernel() is quite sensitive and placing a call
> in a certain place needs more elaborate explanation.
> 

Fair, the commit message asserts the placement without justifying it elaborately.
The slot is bounded on both sides, and within those bounds I took the latest
point. I will fold commit message in respin.

Earliest:
  luo_early_startup() ends in kho_restore_free(), which goes through
  kho_restore_folio() and folio_put(), so it needs struct page and a working
  page allocator. It also reads a preserved page, and kho_memory_init() is
  what calls kho_mem_retrieve() to take those pages out of circulation; that
  runs from mm_core_init(). Reading the handover FDT is not a constraint, as
  kho_populate() records it from setup_arch() via parse_setup_data().

  Second bound: luo_restore_fail() is a panic(), so running before
  console_init() would panic a failed handover with nothing on the console,
  which is exactly when the message is wanted.

Latest: on x86 the IOMMU is the interrupt remapping provider, so both halves
  of its early init run inside late_time_init():

    x86_late_time_init() -> apic_intr_mode_init() -> x86_64_probe_apic()
      -> enable_IR_x2apic()
           -> irq_remapping_prepare() -> amd_iommu_prepare()
                -> early_amd_iommu_init()
                     init_iommu_one_late(), __disable_iommus(true)
           -> irq_remapping_enable()  -> amd_iommu_enable()
                -> early_enable_iommus() -> reuse_device_table()

  All three sites that ask whether this unit was handed over sit on that path,
  and all of it is before any initcall.

  So the window is between console_init() and late_time_init(). I placed the
  call at the end of it, on the grounds that it perturbs the least: every
  existing call in that window keeps running exactly as before, and the only
  code that can observe the new call is late_time_init() and later. Nothing in
  the window consumes LUO state, so moving the call earlier would widen the
  exposure without buying anything.

Anywhere in that window works for the AMD case, so if you would rather see
it somewhere else, I am happy to move it.

> > Rename it to liveupdate_init_early() at the same time, since
> > liveupdate_early_init() was named after the early_initcall that no longer
> > exists.
> 
> No strong feeling about this, but we do have other _early_init() functions
> unrelated to initcalls.
>  

Will drop this.

Thanks,
Ankit

> > Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> > ---
> >  include/linux/liveupdate.h   | 4 ++++
> >  init/main.c                  | 2 ++
> >  kernel/liveupdate/luo_core.c | 5 +----
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> -- 
> Sincerely yours,
> Mike.
