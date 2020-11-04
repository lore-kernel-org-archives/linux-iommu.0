Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A9C4741F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:39:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BBE20825
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wzJJDFuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BBE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 18786871C6;
	Wed,  4 Nov 2020 22:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiOQzYlIRR+C; Wed,  4 Nov 2020 22:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2AED1871A9;
	Wed,  4 Nov 2020 22:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F787C088B;
	Wed,  4 Nov 2020 22:39:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EAF4C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CA5385755
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCO-2xpNZl2T for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 22:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 49B3085754
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h16XyEYas2OUpLFSR6t43lwQPJAt+ZhERxEy1upjBmU/ou4gqZ3rVMo2TN0/8EeDyePFkB3qy0gsPYs0R2pKIxekQOjhY6/6vfS4ujXHN19w4zEg18cFxAYl4intj+US5zqH3KcfiTFNS8bkDHtq7ZqN6/2qTWhFimepWO9uQgJPSdmBdh4zJyAYDQUiEHqjwokPpNUBL5IpI+CLzH2pnC+NxQINZubEdR1COi8oP72/y5CrSztbgWVn4L7RcH7MUidemLDq6yqoE2LaN4RuHIzWh5bTEMAi7BsseBHJVZaoPpgmSoSO4S8XscOjJxjfLZokbGN2wE2YRzsFO4XoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHDrjG/CUTqhxVC5+QasbP+YeZnv/3vII33TmD3ZiDc=;
 b=Yfc2UVrL6ZUeDRfOYa0dXdhwauFtFxmpqV9SixATYxIh5ooAgovf55BJ6JagF2oqpigjpz04GTE8Fg+9PkClgBMphdaDBp14scuT9LVCUsFvvG/PsNhT6+Zrc3Q685TetT0/pZAZI1WXSaawtdBBtCBgPGewax88zG2LqKBmcFcJvskwg6VP1Z1JsRzNmWMfuKxloOXP/tAXkVbGPu8t5pjElaKfKrYkEr2YaNn37msYSanj/fTUGBSbmyFo7bGxFhPdzYlUZv+JRm70mG3fLuRP5ql7aS9a6UhPSuijcEg13T84hoUwbhoEqrpZVzizH3bzmYbMQ+o0/mnWh0SP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHDrjG/CUTqhxVC5+QasbP+YeZnv/3vII33TmD3ZiDc=;
 b=wzJJDFuwQehC9MmWFmVpuWGDi3XvyzxlL/rH/wQs9LH9Mi+WHSMaEk2x7eoPUWqayoJTz6B0YO3+vm8bUD4OPkcDiNaFWXbbwstfMoYuCkXm9INGH9upkQW5wPb3ojCwyQRk1BexjvutnkGoBFrSivCekHiEHKvkKQR2jb5s4XY=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 4 Nov
 2020 22:39:19 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:39:19 +0000
Date: Wed, 4 Nov 2020 22:39:13 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201104223913.GA25311@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201104221452.GA26079@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:806:25::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SA9PR13CA0230.namprd13.prod.outlook.com (2603:10b6:806:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Wed, 4 Nov 2020 22:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6faf477-8dc0-48aa-c103-08d881127788
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542576F242D749817F997C18EEF0@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsSDpQouBN91U5lEVnvCKa+682JlMya3RQgnUhZ105XUTy1tN528w2QMI6TlfTNCglMtM/kTb6cmrK6dQrYNZ0CMSSv9Hu3WcyvyQWc+MYiaIO9XpHRrqSzujfOcYV/Q4yDqyMjwEvqzum8pGBNhV61SM5r3vhuizKTn62KqXU6ly0Cfxn0RFHXTJJryitsWY3W86TfqIw6CuBBvR3LRZ8BR66oCpXKOWFL/myInn4qHl+M78uOcg41cWqQVr50skib8Rtl+PAl5E5bS8sPxuCzD8M4IR3u/tR++g1nSxv1cH4ljN6CxDvhI4xPrmxg0j+eriPig4/BZkwi4XS/VHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(9686003)(316002)(44832011)(6496006)(2906002)(16526019)(83380400001)(7416002)(478600001)(33656002)(8936002)(52116002)(186003)(55016002)(26005)(6916009)(66556008)(33716001)(6666004)(956004)(66946007)(1076003)(86362001)(66476007)(5660300002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OJn1RpJuy8NNzwmNimZ4IZp3GYgJd7CrftMM5Bu4UJnzzlwwB4r3fzaUIkeV+A2a4lI0PcOOC305497AYBk86sNklHSbfegg6I8mq9jfGKvmFcQekCQiq3DJv23jh+cuI/AFqJXm/67c0O8kjGBZ1fuKLduywRL4IYklt7YicnvnzUMlr8InnMA2NQVmHZ2D8piam6DHfty1O4/QtC0rM2oDvgqoxhL1Xp0kYzFBrrRhvlsDx8pu5MrpYF5L/8T+oWYo4AmOXGHi0QlH+/iuYBE7CJee2QgbN8DfaMjZcCFKf1R3aDzL7On/qeKJSXGjhKSOoNRafqhH8zeZeahG5p/JzEyiSM4t+LNd+F+R+GAlzpuoln5hcObTR21mv6Ev0EPb+rMIq1DSjT/BFeBczN7HFykr1p9skPD7woopn1jbUHVhd0+u+XLi/llQTEKVbzgnM3uf90FyhpER16VZP7eKM8tv7Z0wBgpGWjZP2eUyS+LjCOd78t7+YX3dXv9ZzMF6DqeE32uJmhuHcPswFcttHHFoOZnq3B9U42v6gau69D5sPHZr2gKeLwix6x3Kv4P/x8kM7hiudtXAB0a5u7sHaWkZib98OMUHJhG+K+CTtR8wwyZm+uQ0k702yfNhl+cNHlhmhBeiuBgsxIvBqg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6faf477-8dc0-48aa-c103-08d881127788
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:39:19.1288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8z4NXBKdnmfFXU9fu0qofoZjA/nFky02Sc7tABOI4lgd69XaTrclUqkHXPEKickS15PHL7IfYOWFTw8kLz8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, ssg.sos.patches@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 tglx@linutronix.de, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Konrad,

On Wed, Nov 04, 2020 at 05:14:52PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 04, 2020 at 10:08:04PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > For SEV, all DMA to and from guest has to use shared
> > (un-encrypted) pages. SEV uses SWIOTLB to make this
> > happen without requiring changes to device drivers.
> > However, depending on workload being run, the default
> > 64MB of SWIOTLB might not be enough and SWIOTLB
> > may run out of buffers to use for DMA, resulting
> > in I/O errors and/or performance degradation for
> > high I/O workloads.
> > 
> > Increase the default size of SWIOTLB for SEV guests
> > using a minimum value of 128MB and a maximum value
> 
> <blinks>
> 
> 64MB for a 1GB VM is not enough?
> 
> > of 512MB, determining on amount of provisioned guest
> 
> I like the implementation on how this is done.. but
> the choices of memory and how much seems very much
> random. Could there be some math behind this?
>

Earlier the patch was based on using a % of guest memory, as below:

+#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
+#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
...
...
+       if (sev_active() && !io_tlb_nslabs) {
+               unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
+
+               default_size = total_mem *
+                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
+
+               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
+
+               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
+                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
+       }

But, then it is difficult to predict what % of guest memory to use ?

Then there are other factors to consider, such as vcpu_count or if there
is going to be high I/O workload, etc.

But that all makes it very complicated, what we basically want is a
range from 128M to 512M and that's why the current patch which picks up
this range from the amount of allocated guest memory keeps it simple. 

Thanks,
Ashish

> > memory.
> > 
> > Using late_initcall() interface to invoke
> > swiotlb_adjust() does not work as the size
> > adjustment needs to be done before mem_encrypt_init()
> > and reserve_crashkernel() which use the allocated
> > SWIOTLB buffer size, hence calling it explicitly
> > from setup_arch().
> > 
> > The SWIOTLB default size adjustment is added as an
> > architecture specific interface/callback to allow
> > architectures such as those supporting memory
> > encryption to adjust/expand SWIOTLB size for their
> > use.
> > 
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > ---
> >  arch/x86/kernel/setup.c   |  2 ++
> >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/swiotlb.h   |  1 +
> >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> >  4 files changed, 72 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3511736fbc74..b073d58dd4a3 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> >  
> > +	swiotlb_adjust();
> > +
> >  	/*
> >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> >  	 * won't consume hotpluggable memory.
> > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > index 3f248f0d0e07..e0deb157cddd 100644
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> >  	pr_cont("\n");
> >  }
> >  
> > +#define TOTAL_MEM_1G	0x40000000UL
> > +#define TOTAL_MEM_4G	0x100000000UL
> > +
> > +#define SIZE_128M (128UL<<20)
> > +#define SIZE_256M (256UL<<20)
> > +#define SIZE_512M (512UL<<20)
> > +
> >  /* Architecture __weak replacement functions */
> > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > +{
> > +	unsigned long size = 0;
> > +
> > +	/*
> > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > +	 * SEV uses SWOTLB to make this happen without changing device
> > +	 * drivers. However, depending on the workload being run, the
> > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > +	 * performance degradation especially with high I/O workloads.
> > +	 * Increase the default size of SWIOTLB for SEV guests using
> > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > +	 * depending on amount of provisioned guest memory.
> > +	 */
> > +	if (sev_active()) {
> > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > +
> > +		if (total_mem <= TOTAL_MEM_1G)
> > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > +				     SIZE_128M);
> > +		else if (total_mem <= TOTAL_MEM_4G)
> > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > +				     SIZE_256M);
> > +		else
> > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > +				     SIZE_512M);
> > +
> > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > +			size >> 20);
> > +	}
> > +
> > +	return size;
> > +}
> > +
> >  void __init mem_encrypt_init(void)
> >  {
> >  	if (!sme_me_mask)
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 046bb94bd4d6..01ae6d891327 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> >  extern unsigned long swiotlb_nr_tbl(void);
> >  unsigned long swiotlb_size_or_default(void);
> > +extern void __init swiotlb_adjust(void);
> >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> >  extern void __init swiotlb_update_mem_attributes(void);
> >  
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c19379fabd20..66a9e627bb51 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> >  }
> >  
> > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > +{
> > +	return 0;
> > +}
> > +
> > +void __init swiotlb_adjust(void)
> > +{
> > +	unsigned long size;
> > +
> > +	/*
> > +	 * If swiotlb parameter has not been specified, give a chance to
> > +	 * architectures such as those supporting memory encryption to
> > +	 * adjust/expand SWIOTLB size for their use.
> > +	 */
> > +	if (!io_tlb_nslabs) {
> > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > +		if (size) {
> > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > +
> > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > +				io_tlb_nslabs);
> > +		}
> > +	}
> > +}
> > +
> >  void swiotlb_print_info(void)
> >  {
> >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > -- 
> > 2.17.1
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
