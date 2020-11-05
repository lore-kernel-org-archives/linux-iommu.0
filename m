Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84954C55179
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:57:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D90206F4
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MSSopkaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D90206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F063870FF;
	Thu,  5 Nov 2020 18:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-ahCi3wQus4; Thu,  5 Nov 2020 18:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 071B6870F7;
	Thu,  5 Nov 2020 18:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB5C8C0893;
	Thu,  5 Nov 2020 18:57:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 402A4C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2741286410
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9e0eEcn1QN0 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 18:57:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD303863D9
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFJ0Ly9I9vpmDjGZVaxG41na/S0pQCBKNJQyGXuijg3lSCYZGmxamav36dLSc32XEhPWJzo1SL5M+4ADnZ4VoV/GbIZKSVL8p2InweEkj1YNsImXHSL9K4zfJcqkWEGvQwiRxxdYbNsnFI1SDqAGqVABS+x5JAK0gMrKgyOHPcKlRL2uAWieRGx7W8VCfmFpvOfMuPNTLRizqs1OIBIZILzfNJNpYtaxQ9fkAgGv8wijw1ZYvBTT6T119ReaxY3s1tNS9whpew7zMiE5hU4JoWNrw8bFNmHDgAn4fMAPQG4IflcDwik+RixbGpA4JCZtw/z5mc+yx47qrFD0u5OCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xGwj7NM66PRDcWuWWfAnjbZAkqb9Mh1hO3kbAIsQts=;
 b=j58ZXhQEjJYy0leiUMVlkc4phgOHjFdHE6ixmTaLGfAOOuxijICRIB4XlawggKoC4zW308UqoX8QKqlG+NKF0yOUHdgZzisPesszpB3gmkWjb5PtkA7xAS2zMksF6pCGRQgW4k+oC6XCBJRvP0Qd/eZA6f2XxPFnGrLe5mWoKXsPpm06ZUDOaKK9u8N6f0mmgA+RC3eouZ3Ax7CH+xBHd+VHPidM/wwg2gELVAtFVtWkvpa/WzaYDy61MJkg3apN6B8ioU3/LQG0vnH2JktwKdC/aAzySDjap7eyUjCAHxxyz3MVCYoTk0eQ/aZhUIwO5NI9y1Q2mBNu8SsQkItZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xGwj7NM66PRDcWuWWfAnjbZAkqb9Mh1hO3kbAIsQts=;
 b=MSSopkaayeOv02CW5ytwssoFV+suqs8pexHWpxCOY6x2Xrclgbliuy+3D0O5vruiUzjirCfQ7sSAoNCIupemNGuZHsdhia9T1gvQF+vgcP7+XiNjXb5bwhN5J2PZ7kjh9gqePEWEMINeA3XRZF6CQQ7+1FOOZwxywpnopD3QdV4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 18:41:22 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 18:41:22 +0000
Date: Thu, 5 Nov 2020 18:41:15 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201105184115.GA25261@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201105174317.GA4294@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:5:190::22) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 18:41:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e28b6c65-1b02-49cb-386f-08d881ba6454
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590E6BBAF74E4899672E5728EEE0@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFBEBE9eLZLzYD+M5z5UlE/V8XkmPsyl6LuQ+tRS1JWjbWC1LnRVDNM5MkHRmZqIbNn6JwHCxOGLKeTLZiBmraGNVYGRJTfxzSZIFbh/Tz+n7GW71xuFK4cPBymb27TVU8jDPYXPd1evp4kyvwL9Id6OO6cIXDBLJTWXVujcLIYJk3SvjzS6MlLpI5ESkEasv/j6AhEnW4eYPR+yCwFG0FmCV9l/LAxEqdgmVmL75DFrik2y7vicAevspqDgy6AsQ9lZM8JmtVT8jDXHXPiVeBlG5D56liEJz41CRzBKor72Pma5WyIZCZ/vB0BziUN5H6CWLJQY3t49+6f9i54hmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(66946007)(55016002)(66476007)(2906002)(52116002)(6666004)(44832011)(8676002)(4326008)(66556008)(7416002)(9686003)(478600001)(6496006)(6916009)(33716001)(86362001)(8936002)(5660300002)(26005)(956004)(316002)(83380400001)(1076003)(186003)(16526019)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +KSAZxqvCiA/NIIEKbr2eCpB3UvqJitYYKCfxyGTY2dmzMUHNUC+ET+3eIRikXGLc4HWkVnnfj7EECkBPyobec3TzVmNLozpL1kePWzJ6yTnKLJP9pSRDedbQUQbp7k7YPTmeSkX5Vvgy75Hxc5iYzl/K1E6G4bsGvQeZHmXWOvhlbod2WUc7ULx5qyWd4b7vwKWumd78bxVNVmL6I5TXLVyGTkjlRDV3YzeBlySUBYq0u3gjsGiESQMLvNco1kqrsNMqiBdJpXHggH/z1li3f0+6k3t88RVjfeuz/F6g/pBWWVZyMb10Mtq/eqUgq60hlOCpAeISXvdbKvaxeNOC8f4Xqz3Q1wwtDOugtZmrXLN9cJrdS+rgp6wwVKHb1VjlLEil7jo0YopG0Zno5RPXQsZ33xREFtCKFUOtEpqh5VMyFFI3KyI0TsBe0RlZp6tbX1uOQkvcNRBJ/q7a74wbHLWO2ALchyEV2CrkKV3z1YhJfj3MWLKxeKvnkU9Ot0HdcOpSY8g8iEK7vr7vG+9NuxzJxk175HgGrJnZ5rpz7SdGtSUfnolio8iMCN+2yKOhDjaykrzFDklySeJj3LVFGG7zrq1qc4y5qSABVrRHfLF4i0fViyL9Bdz25M4kV9N1FcrAyzH+Fmqg9WnrP/K+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28b6c65-1b02-49cb-386f-08d881ba6454
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 18:41:22.2475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvGfk0dxnev2TrbIFYFH3G5wFpAoblSVwRsn3Z6tJaxtjRUdnuDgJdNdiDhbxLJK8weennzDkfmG6tch3EIcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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

On Thu, Nov 05, 2020 at 12:43:17PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 04, 2020 at 10:39:13PM +0000, Ashish Kalra wrote:
> > Hello Konrad,
> > 
> > On Wed, Nov 04, 2020 at 05:14:52PM -0500, Konrad Rzeszutek Wilk wrote:
> > > On Wed, Nov 04, 2020 at 10:08:04PM +0000, Ashish Kalra wrote:
> > > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > > 
> > > > For SEV, all DMA to and from guest has to use shared
> > > > (un-encrypted) pages. SEV uses SWIOTLB to make this
> > > > happen without requiring changes to device drivers.
> > > > However, depending on workload being run, the default
> > > > 64MB of SWIOTLB might not be enough and SWIOTLB
> > > > may run out of buffers to use for DMA, resulting
> > > > in I/O errors and/or performance degradation for
> > > > high I/O workloads.
> > > > 
> > > > Increase the default size of SWIOTLB for SEV guests
> > > > using a minimum value of 128MB and a maximum value
> > > 
> > > <blinks>
> > > 
> > > 64MB for a 1GB VM is not enough?
> > > 
> > > > of 512MB, determining on amount of provisioned guest
> > > 
> > > I like the implementation on how this is done.. but
> > > the choices of memory and how much seems very much
> > > random. Could there be some math behind this?
> > >
> > 
> > Earlier the patch was based on using a % of guest memory, as below:
> > 
> > +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
> > +#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
> > ...
> > ...
> > +       if (sev_active() && !io_tlb_nslabs) {
> > +               unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
> > +
> > +               default_size = total_mem *
> > +                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> > +
> > +               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
> > +
> > +               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
> > +                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
> > +       }
> > 
> > But, then it is difficult to predict what % of guest memory to use ?
> > 
> > Then there are other factors to consider, such as vcpu_count or if there
> > is going to be high I/O workload, etc.
> > 
> > But that all makes it very complicated, what we basically want is a
> > range from 128M to 512M and that's why the current patch which picks up
> > this range from the amount of allocated guest memory keeps it simple. 
> 
> Right, so I am wondering if we can do this better.
> 
> That is you are never going to get any 32-bit devices with SEV right? That
> is there is nothing that bounds you to always use the memory below 4GB?
> 

We do support 32-bit PCIe passthrough devices with SEV.

Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
when there is I/O pressure, because we do need to support device
passthrough of 32-bit devices.

Considering this, we believe that this patch needs to adjust/extend
boot-allocation of SWIOTLB and we want to keep it simple to do this
within a range detemined by amount of allocated guest memory.

Thanks,
Ashish

> What I wonder is if we can combine the boot-allocation of the SWIOTLB
> with the post-boot-allocation of SWIOLTB to stitch together
> continous physical ranges.
> 
> That way you have the flexibility at the start of using 64MB but if there
> is pressure, we grow to a bigger size?
> 
> > 
> > Thanks,
> > Ashish
> > 
> > > > memory.
> > > > 
> > > > Using late_initcall() interface to invoke
> > > > swiotlb_adjust() does not work as the size
> > > > adjustment needs to be done before mem_encrypt_init()
> > > > and reserve_crashkernel() which use the allocated
> > > > SWIOTLB buffer size, hence calling it explicitly
> > > > from setup_arch().
> > > > 
> > > > The SWIOTLB default size adjustment is added as an
> > > > architecture specific interface/callback to allow
> > > > architectures such as those supporting memory
> > > > encryption to adjust/expand SWIOTLB size for their
> > > > use.
> > > > 
> > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > ---
> > > >  arch/x86/kernel/setup.c   |  2 ++
> > > >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/swiotlb.h   |  1 +
> > > >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> > > >  4 files changed, 72 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index 3511736fbc74..b073d58dd4a3 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > >  
> > > > +	swiotlb_adjust();
> > > > +
> > > >  	/*
> > > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > > >  	 * won't consume hotpluggable memory.
> > > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > > index 3f248f0d0e07..e0deb157cddd 100644
> > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> > > >  	pr_cont("\n");
> > > >  }
> > > >  
> > > > +#define TOTAL_MEM_1G	0x40000000UL
> > > > +#define TOTAL_MEM_4G	0x100000000UL
> > > > +
> > > > +#define SIZE_128M (128UL<<20)
> > > > +#define SIZE_256M (256UL<<20)
> > > > +#define SIZE_512M (512UL<<20)
> > > > +
> > > >  /* Architecture __weak replacement functions */
> > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > +{
> > > > +	unsigned long size = 0;
> > > > +
> > > > +	/*
> > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > +	 * drivers. However, depending on the workload being run, the
> > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > +	 * performance degradation especially with high I/O workloads.
> > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > +	 * depending on amount of provisioned guest memory.
> > > > +	 */
> > > > +	if (sev_active()) {
> > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > +
> > > > +		if (total_mem <= TOTAL_MEM_1G)
> > > > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > > > +				     SIZE_128M);
> > > > +		else if (total_mem <= TOTAL_MEM_4G)
> > > > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > > > +				     SIZE_256M);
> > > > +		else
> > > > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > > > +				     SIZE_512M);
> > > > +
> > > > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > > > +			size >> 20);
> > > > +	}
> > > > +
> > > > +	return size;
> > > > +}
> > > > +
> > > >  void __init mem_encrypt_init(void)
> > > >  {
> > > >  	if (!sme_me_mask)
> > > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > > index 046bb94bd4d6..01ae6d891327 100644
> > > > --- a/include/linux/swiotlb.h
> > > > +++ b/include/linux/swiotlb.h
> > > > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> > > >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> > > >  extern unsigned long swiotlb_nr_tbl(void);
> > > >  unsigned long swiotlb_size_or_default(void);
> > > > +extern void __init swiotlb_adjust(void);
> > > >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> > > >  extern void __init swiotlb_update_mem_attributes(void);
> > > >  
> > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > index c19379fabd20..66a9e627bb51 100644
> > > > --- a/kernel/dma/swiotlb.c
> > > > +++ b/kernel/dma/swiotlb.c
> > > > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > >  }
> > > >  
> > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void __init swiotlb_adjust(void)
> > > > +{
> > > > +	unsigned long size;
> > > > +
> > > > +	/*
> > > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > > +	 * architectures such as those supporting memory encryption to
> > > > +	 * adjust/expand SWIOTLB size for their use.
> > > > +	 */
> > > > +	if (!io_tlb_nslabs) {
> > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > +		if (size) {
> > > > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > > > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > > > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > +
> > > > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > > > +				io_tlb_nslabs);
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > >  void swiotlb_print_info(void)
> > > >  {
> > > >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > > > -- 
> > > > 2.17.1
> > > > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
