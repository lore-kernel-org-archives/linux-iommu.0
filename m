Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D33C388F7
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:54:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F399220728
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NhQgY4V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F399220728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D84385E83;
	Thu,  5 Nov 2020 19:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4HuLX8nnfDa; Thu,  5 Nov 2020 19:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 577F085E60;
	Thu,  5 Nov 2020 19:54:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 264C2C088B;
	Thu,  5 Nov 2020 19:54:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 830D0C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 771F48674D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mJc6KGQPkgZ for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 19:54:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5F07086742
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFK3nybzlh9Q/yZazQcBAaWKXrBHbchtmFuImAPuj8sJpz+ry0YmyQjRZ2GWGw85/fySWkTC5vHZswks0ZumFL9kXZwBXYzNXWlG9yjBgLzW39gtdBCK+30HyUd5HpncjIDS9TDMC+d56pIceZt7Hurx7By9m+3yD+gRhymdz3019RKoQQnCF8+OQpSj/NjHm/Bf8zRsidu3kuYmS7YvXG2Oot8NN31bf90QXPQFRlBmc3S8KOzx2NrviJvCWW0m+yZ87wKyEX/wQohV/Y+EsHllv0efO+QuWUBVbqJPCC/4i6NYjAKeKX/ZA+Nm0L5T0uUsGZzJFSiqB3rMhqCE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iYF4xXPGPnruHtKZbxDygkCRJ+XfGEZD63ZuXg/i/c=;
 b=lhzXG7ur+aTODzEjz1rwWcXuRTdx2qcDS77RBbopnY0t5ZEzGy9ZONpuwMJlM3dF+FoIqme/SUAE4oAKFD4NDxMsWVVD/myyFejtGsC4t7vbg/JpD/N27rJGa1Jyr5TVHGtKkpx7n1vmh39mwLomu1WanblJNJKIEgCr+R1eMs2JpBvmGAwr8ew+7Yl/aZ+AH8ajfRPcRLd5G8xYqMBW8CWl+/Hi2dpCFNxNi9w6R3TvOCQuBv3tdtjf4vpe4UzRNuybcJNqcMHLQIYAS1GpSBTuiwMsUnzrKEpoPXCc4RU4OO+qmVPoyOrQfTUwVhE+tvC9rfhoP7N4Uem+jXlNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iYF4xXPGPnruHtKZbxDygkCRJ+XfGEZD63ZuXg/i/c=;
 b=NhQgY4V0XPI+wsjSjJ9fzw8h2aUlZFGy31z3kNjdUpwwwohh6Oe4SiGCYvHvj+zDDCknzXf0LkN2duWznU4PlCGu5H6H/TMPKZr5B6u/F5x/TTnOTKJDNTWReuGaPZ3eb5L4NhHwwWCfhUlngPYjm9uPUvVU9rsvO1kj6FcsQug=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 19:38:34 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 19:38:34 +0000
Date: Thu, 5 Nov 2020 19:38:28 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201105193828.GA25303@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201105190649.GB5366@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0049.namprd12.prod.outlook.com
 (2603:10b6:802:20::20) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN1PR12CA0049.namprd12.prod.outlook.com (2603:10b6:802:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 19:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a5c11aa-6efe-4489-cdef-08d881c26219
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27669B4126E765FFA2BFC8458EEE0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyBvDA0dMwK8RDqP8EdqzIg1TGgAAclowALv6Q4aHBBfNjazj+ePUBdICRnZnzmhQqUue6eW56sjZormk10EE8HvyJGN571psVYhPywjAxKfdMN5JCYggaR/WxN2FTmy625RRpIt5BwEO0ykVzELtXmAqxZpgbYflSgr58skyQCCrWBOQlxoWBHMKUsqqMbbz9M+u7HE+PK1mFw61P1jfeGQMz94tyTeKBgkxbqSXXaHVw2hYMzysCbdcYiSbkPsiebppyeXcPMtDxisRYdcAZR5J+dzBHpAWxMdCquagDNITprGoCJBphN6G6ngOepJPRa1Sqtz71CcMwRej5zFUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(33716001)(55016002)(66476007)(4326008)(2906002)(186003)(6916009)(66556008)(8676002)(1076003)(478600001)(316002)(66946007)(16526019)(8936002)(956004)(6666004)(6496006)(44832011)(26005)(5660300002)(86362001)(83380400001)(33656002)(52116002)(9686003)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ohb+V40taCoIj8UVGHbjZD23AJ5rtJW2LiYJH5gNPBY2CwqedohpFs/JQnLPCg+AiAvy14sdCXo10m/AizLTCh7AT854UTD/fOrLw2DV3xZ9S/kehA3uq7VLzWP2jjRAsuKbTo6OBOXNFgUMAvm0B12k9MEGDrQHf5ldpRy5k89i+NVp95r1NZXQaDkKctCQKs3MIDuTs5JTMaUuD/YXcCAsEfoKt6GA4EVvn3uGL4Fx/A2eDwkFhCoSLVv+hfZkk+baqhqoGU7gZMff8DOHU34ZJ+aQLGjtniVuznCtt7bEJJvTR2giOhQ6w6vDe/m2nvFZwH1mPKFTlAhQ6gufuEWZuXxFaTn2E32vezKIAwScVjNYMDdjJiFEQLjNwPIR+AZ89LHs8oTgqYHccaJAHkGJqfeLE4elsJjb88vAp9uZXPe6xh6M57i9SLUzhGl6l4JlpEMa7UnK0Q9DKSg37rcCuMAdj5MxJrzlk86J7hqfualQ6cjCt46S0iorZeZLjXKOAeTaevzJuYo9Ql0rLBvHJagqxb6LRfC6CXzFcRBshFZ4y9vBZrdoeaQwRN7Hd+2nv6i+UpupLVB8vKxn9ZQt+dHAU0bpDqG4j7dKnoqU+CPZBEqALs+yKIZl3JxLbta4U/WydTMOWNTPkrkVvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c11aa-6efe-4489-cdef-08d881c26219
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 19:38:34.4460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgHOR1woaujPHrIvv9pnJIyUyCp7Sp/li/HZXsReHzj4a0tYB3a5+I1NczBL02ud1lJoCSxStv6VkVh4yi/y8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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

On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> .
> > > Right, so I am wondering if we can do this better.
> > > 
> > > That is you are never going to get any 32-bit devices with SEV right? That
> > > is there is nothing that bounds you to always use the memory below 4GB?
> > > 
> > 
> > We do support 32-bit PCIe passthrough devices with SEV.
> 
> Ewww..  Which devices would this be?

That will be difficult to predict as customers could be doing
passthrough of all kinds of devices.

> > 
> > Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> > when there is I/O pressure, because we do need to support device
> > passthrough of 32-bit devices.
> 
> Presumarily there is just a handful of them?
>
Again, it will be incorrect to assume this.

> > 
> > Considering this, we believe that this patch needs to adjust/extend
> > boot-allocation of SWIOTLB and we want to keep it simple to do this
> > within a range detemined by amount of allocated guest memory.
> 
> I would prefer to not have to revert this in a year as customers
> complain about "I paid $$$ and I am wasting half a gig on something 
> I am not using" and giving customers knobs to tweak this instead of
> doing the right thing from the start.

Currently, we face a lot of situations where we have to tell our
internal teams/external customers to explicitly increase SWIOTLB buffer
via the swiotlb parameter on the kernel command line, especially to
get better I/O performance numbers with SEV. 

So by having this SWIOTLB size adjustment done implicitly (even using a
static logic) is a great win-win situation. In other words, having even
a simple and static default increase of SWIOTLB buffer size for SEV is
really useful for us.

We can always think of adding all kinds of heuristics to this, but that
just adds too much complexity without any predictable performance gain.

And to add, the patch extends the SWIOTLB size as an architecture
specific callback, currently it is a simple and static logic for SEV/x86
specific, but there is always an option to tweak/extend it with
additional logic in the future.

Thanks,
Ashish'

> 
> That is the right thing being something less static.
> 
> Can you work with me on what that could be please?
> 
> > 
> > Thanks,
> > Ashish
> > 
> > > What I wonder is if we can combine the boot-allocation of the SWIOTLB
> > > with the post-boot-allocation of SWIOLTB to stitch together
> > > continous physical ranges.
> > > 
> > > That way you have the flexibility at the start of using 64MB but if there
> > > is pressure, we grow to a bigger size?
> > > 
> > > > 
> > > > Thanks,
> > > > Ashish
> > > > 
> > > > > > memory.
> > > > > > 
> > > > > > Using late_initcall() interface to invoke
> > > > > > swiotlb_adjust() does not work as the size
> > > > > > adjustment needs to be done before mem_encrypt_init()
> > > > > > and reserve_crashkernel() which use the allocated
> > > > > > SWIOTLB buffer size, hence calling it explicitly
> > > > > > from setup_arch().
> > > > > > 
> > > > > > The SWIOTLB default size adjustment is added as an
> > > > > > architecture specific interface/callback to allow
> > > > > > architectures such as those supporting memory
> > > > > > encryption to adjust/expand SWIOTLB size for their
> > > > > > use.
> > > > > > 
> > > > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > > > ---
> > > > > >  arch/x86/kernel/setup.c   |  2 ++
> > > > > >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> > > > > >  include/linux/swiotlb.h   |  1 +
> > > > > >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> > > > > >  4 files changed, 72 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > > > index 3511736fbc74..b073d58dd4a3 100644
> > > > > > --- a/arch/x86/kernel/setup.c
> > > > > > +++ b/arch/x86/kernel/setup.c
> > > > > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > > > > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > > > > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > > >  
> > > > > > +	swiotlb_adjust();
> > > > > > +
> > > > > >  	/*
> > > > > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > > > > >  	 * won't consume hotpluggable memory.
> > > > > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > > > > index 3f248f0d0e07..e0deb157cddd 100644
> > > > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > > > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> > > > > >  	pr_cont("\n");
> > > > > >  }
> > > > > >  
> > > > > > +#define TOTAL_MEM_1G	0x40000000UL
> > > > > > +#define TOTAL_MEM_4G	0x100000000UL
> > > > > > +
> > > > > > +#define SIZE_128M (128UL<<20)
> > > > > > +#define SIZE_256M (256UL<<20)
> > > > > > +#define SIZE_512M (512UL<<20)
> > > > > > +
> > > > > >  /* Architecture __weak replacement functions */
> > > > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > > > +{
> > > > > > +	unsigned long size = 0;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > > > +	 * drivers. However, depending on the workload being run, the
> > > > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > > > +	 * performance degradation especially with high I/O workloads.
> > > > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > > > +	 * depending on amount of provisioned guest memory.
> > > > > > +	 */
> > > > > > +	if (sev_active()) {
> > > > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > > > +
> > > > > > +		if (total_mem <= TOTAL_MEM_1G)
> > > > > > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > > > > > +				     SIZE_128M);
> > > > > > +		else if (total_mem <= TOTAL_MEM_4G)
> > > > > > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > > > > > +				     SIZE_256M);
> > > > > > +		else
> > > > > > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > > > > > +				     SIZE_512M);
> > > > > > +
> > > > > > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > > > > > +			size >> 20);
> > > > > > +	}
> > > > > > +
> > > > > > +	return size;
> > > > > > +}
> > > > > > +
> > > > > >  void __init mem_encrypt_init(void)
> > > > > >  {
> > > > > >  	if (!sme_me_mask)
> > > > > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > > > > index 046bb94bd4d6..01ae6d891327 100644
> > > > > > --- a/include/linux/swiotlb.h
> > > > > > +++ b/include/linux/swiotlb.h
> > > > > > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> > > > > >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> > > > > >  extern unsigned long swiotlb_nr_tbl(void);
> > > > > >  unsigned long swiotlb_size_or_default(void);
> > > > > > +extern void __init swiotlb_adjust(void);
> > > > > >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> > > > > >  extern void __init swiotlb_update_mem_attributes(void);
> > > > > >  
> > > > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > > > index c19379fabd20..66a9e627bb51 100644
> > > > > > --- a/kernel/dma/swiotlb.c
> > > > > > +++ b/kernel/dma/swiotlb.c
> > > > > > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> > > > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > > > >  }
> > > > > >  
> > > > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > > > +{
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +void __init swiotlb_adjust(void)
> > > > > > +{
> > > > > > +	unsigned long size;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > > > > +	 * architectures such as those supporting memory encryption to
> > > > > > +	 * adjust/expand SWIOTLB size for their use.
> > > > > > +	 */
> > > > > > +	if (!io_tlb_nslabs) {
> > > > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > > > +		if (size) {
> > > > > > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > > > > > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > > > > > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > > > +
> > > > > > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > > > > > +				io_tlb_nslabs);
> > > > > > +		}
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > >  void swiotlb_print_info(void)
> > > > > >  {
> > > > > >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > > > > > -- 
> > > > > > 2.17.1
> > > > > > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
