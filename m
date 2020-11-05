Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F5C4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 21:20:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95BE20735
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 21:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dv3tJ7PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95BE20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 59345273E1;
	Thu,  5 Nov 2020 21:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JtqT8sFEMPm2; Thu,  5 Nov 2020 21:20:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C59720449;
	Thu,  5 Nov 2020 21:20:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C3E1C088B;
	Thu,  5 Nov 2020 21:20:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3378CC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 21:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 19C99873D4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 21:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W08CL4zUfaPp for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 21:20:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B6BCE873C4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 21:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br7UBV5VrXPXwpkLou6i0YKxdvztrEeLUuK2JJ8rSdc/2ty7Zp7dzD0egc6aBSt5iAVuElFGIfo46TOG/hhNwW9pDEFyCv7u1x08DhO1RcYNLzoTZ85JA9wUuNlMaYSQZ/qzZudXZT+rjrNoAyYuuu/K13P/44G2QIwLqklEnTWagSj+cc2uuejD19TxHVAFoVpqUSgzd1r9qTV3pzx6TiDtdPT66Z8yaKlfxLWgBOInWnKas3S2l34pkbuuflNImyeFTFylc435uoICCZj+Ixjb37yQck6K3gDY+4B58+AwdLBDZ82df5/liD2AZxdOv5HivO3ftXgE8yR49FlHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHNlqiWbTGNlslK9Bb1aYnoft8FbSO1d1tYeK9aOZhw=;
 b=avNqmmIHt0ppc5PQEncqTHD4VafceLLrvS/mKjnt3KgYqPk/Y4EuvsiFis6aPDKpx35sxqbv8F+XV1n8lNKUUbKvYAMvY1BVv0Tx3RfGdUe4kbwSQD8hywB6Cs1gc4QpswXoGWBCvePWXTtK/HZcJdTqQgfE71RFcmbM7ZfosPu2YtHJPXRDj27fjPk31BUEdVhHjVAS79ZW9SbXD1dmktZ6GliI0A/r5BuJRQDhL4D24SIauP9cygwA3Nl4+hg2WTtDU9S4JUb/QTXS9EVoKe5Kgj1Sjt5kZ0NPTHkaSqdSRLvaaEBbUo20FZYAukKYePQ1FdSxlv6qBTzB/A9Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHNlqiWbTGNlslK9Bb1aYnoft8FbSO1d1tYeK9aOZhw=;
 b=Dv3tJ7PNM4jpFNATwezloRMbPLGGFfB9HprxK3cQ3dWX0UFrLbMlz+d/DkrtQgGo1hxfxmEBwLJ759v25haeG4EkKQ4UoysHA+FVFxh4TIRwNLcyYXy+kucjMGqvvlhwpR634Gv3jIIMeodWm74ndyPeVgl4JpeQ6pIr/qitL6k=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 21:20:48 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 21:20:48 +0000
Date: Thu, 5 Nov 2020 21:20:45 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201105212045.GB25303@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201105202007.GA6370@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:3:37::28) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM5PR06CA0066.namprd06.prod.outlook.com (2603:10b6:3:37::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 21:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b62a1f4c-5b68-444a-41bd-08d881d0aa4e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44322A7390E405C45744B03B8EEE0@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz7HSJnRHSLNZfhkU7dXcfMwnYwL2VQbP6aleaIkyPVU98HdBhUxNvbYB4QtR9On5KOmWWA8zi47MHQ9JHj+WPEdztnQ9UEgWkPjfou+mu5dE3mugM/7U9/qKlbulIQVb/GUBPknmpSzSavx4VwzRMoZV3SHvedTRvQMTKlf38VPjGEuaby8H1rfFn0RZ1ZkXm51ff/2avy0b/o8IQbud1CaTp9hGy4AvY7Muakx8xBpSZMyfZYeXD9yiOs9kJ/7YK2z64KMj9WkZ+Z7YFCGI/u1dHvQO0seILvepCZ/Hbrmf0PhkjpApZP7er5DlTAnnBu8+mADmMrcUWidUjJ8GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(8676002)(26005)(1076003)(16526019)(66476007)(83380400001)(5660300002)(956004)(2906002)(66946007)(30864003)(66556008)(8936002)(316002)(186003)(478600001)(55016002)(7416002)(4326008)(52116002)(33716001)(9686003)(6496006)(33656002)(44832011)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M9oDfpTZtW9dXywU+kghudKITr6eF9KKO6Rw6zdE4mouEYmTYB2ILFVjv/E5PitnNQeM0hqNVjdFFDdbFylwS1mkdkLC6HIberiiAHJxJQVKsRYKdFuDDWX0euRLQukYkvtTIZdf5HNqMx0YcjARi/H0QJX5vzH0EyC5cL0g6qZ8bYLN1QSpBFbO0aIxPeu9F8oDD41G9JQCxX/ksZsAebppLyGRMWfRSyaSTGfAewHcTzh6weH6M3yVDxmF90wUvf8e8PJskdlYADNksHheO6OPTGVGg4XDRAkdWVXpHd5UyCrcvZA74xLUo1L1tTLWgvuvOCkOWQ2CLQ2aeurkPkYCUSS1COSzyY6JjteSzi12YpYGmMiKYnq1JT4xCSbLkOr2Tmfi53H68Hz4K1dgHwJhxww2lXRVdLQunJXDr0z5cYGc1zYlYMyHBMHjBh9wIw5Y+M8G46QA9vBW4cerwxKGe3bCnqBJcqMzZpGWrfi3kPdAASoEoJAJT0gVJwivqxiu7p9U3urHEvqRUzWQ9UnyS2PpTvQfVMHGe3DyKsmnPau1SscBWQsvK+bYD73IX/ZG4S73LjpeZyNGAQ9pyXnbYaah/1utY+86FCsGn7Ct4s0gK0ayVFquhi6QQDoNxHq4alSxxY4GP6KdJuMxAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62a1f4c-5b68-444a-41bd-08d881d0aa4e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 21:20:48.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiMHDUGLjL46sXLNuS0EHxwu7Zb4/MXKLWXULvkyj54A+a/3Nz9W8Ks8YIhujCzqEaVpuGNN14EEXh04Oap+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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

On Thu, Nov 05, 2020 at 03:20:07PM -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Nov 05, 2020 at 07:38:28PM +0000, Ashish Kalra wrote:
> > On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> > > .
> > > > > Right, so I am wondering if we can do this better.
> > > > > 
> > > > > That is you are never going to get any 32-bit devices with SEV right? That
> > > > > is there is nothing that bounds you to always use the memory below 4GB?
> > > > > 
> > > > 
> > > > We do support 32-bit PCIe passthrough devices with SEV.
> > > 
> > > Ewww..  Which devices would this be?
> > 
> > That will be difficult to predict as customers could be doing
> > passthrough of all kinds of devices.
> 
> But SEV is not on some 1990 hardware. It has PCIe, there is no PCI slots in there.
> 
> Is it really possible to have a PCIe device that can't do more than 32-bit DMA?
> 
> > 
> > > > 
> > > > Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> > > > when there is I/O pressure, because we do need to support device
> > > > passthrough of 32-bit devices.
> > > 
> > > Presumarily there is just a handful of them?
> > >
> > Again, it will be incorrect to assume this.
> > 
> > > > 
> > > > Considering this, we believe that this patch needs to adjust/extend
> > > > boot-allocation of SWIOTLB and we want to keep it simple to do this
> > > > within a range detemined by amount of allocated guest memory.
> > > 
> > > I would prefer to not have to revert this in a year as customers
> > > complain about "I paid $$$ and I am wasting half a gig on something 
> > > I am not using" and giving customers knobs to tweak this instead of
> > > doing the right thing from the start.
> > 
> > Currently, we face a lot of situations where we have to tell our
> > internal teams/external customers to explicitly increase SWIOTLB buffer
> > via the swiotlb parameter on the kernel command line, especially to
> > get better I/O performance numbers with SEV. 
> 
> Presumarily these are 64-bit?
> 
> And what devices do you speak off that are actually affected by 
> this performance? Increasing the SWIOTLB just means we have more
> memory, which in mind means you can have _more_ devices in the guest
> that won't handle the fact that DMA mapping returns an error.
> 
> Not neccessarily that one device suddenly can go faster.
> 
> > 
> > So by having this SWIOTLB size adjustment done implicitly (even using a
> > static logic) is a great win-win situation. In other words, having even
> > a simple and static default increase of SWIOTLB buffer size for SEV is
> > really useful for us.
> > 
> > We can always think of adding all kinds of heuristics to this, but that
> > just adds too much complexity without any predictable performance gain.
> > 
> > And to add, the patch extends the SWIOTLB size as an architecture
> > specific callback, currently it is a simple and static logic for SEV/x86
> > specific, but there is always an option to tweak/extend it with
> > additional logic in the future.
> 
> Right, and that is what I would like to talk about as I think you
> are going to disappear (aka, busy with other stuff) after this patch goes in.
> 
> I need to understand this more than "performance" and "internal teams"
> requirements to come up with a better way going forward as surely other
> platforms will hit the same issue anyhow.
> 
> Lets break this down:
> 
> How does the performance improve for one single device if you increase the SWIOTLB?
> Is there a specific device/driver that you can talk about that improve with this patch?
> 
> 

Yes, these are mainly for multi-queue devices such as NICs or even
multi-queue virtio. 

This basically improves performance with concurrent DMA, hence,
basically multi-queue devices.

Thanks,
Ashish

> > 
> > > 
> > > That is the right thing being something less static.
> > > 
> > > Can you work with me on what that could be please?
> > > 
> > > > 
> > > > Thanks,
> > > > Ashish
> > > > 
> > > > > What I wonder is if we can combine the boot-allocation of the SWIOTLB
> > > > > with the post-boot-allocation of SWIOLTB to stitch together
> > > > > continous physical ranges.
> > > > > 
> > > > > That way you have the flexibility at the start of using 64MB but if there
> > > > > is pressure, we grow to a bigger size?
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Ashish
> > > > > > 
> > > > > > > > memory.
> > > > > > > > 
> > > > > > > > Using late_initcall() interface to invoke
> > > > > > > > swiotlb_adjust() does not work as the size
> > > > > > > > adjustment needs to be done before mem_encrypt_init()
> > > > > > > > and reserve_crashkernel() which use the allocated
> > > > > > > > SWIOTLB buffer size, hence calling it explicitly
> > > > > > > > from setup_arch().
> > > > > > > > 
> > > > > > > > The SWIOTLB default size adjustment is added as an
> > > > > > > > architecture specific interface/callback to allow
> > > > > > > > architectures such as those supporting memory
> > > > > > > > encryption to adjust/expand SWIOTLB size for their
> > > > > > > > use.
> > > > > > > > 
> > > > > > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > > > > > ---
> > > > > > > >  arch/x86/kernel/setup.c   |  2 ++
> > > > > > > >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> > > > > > > >  include/linux/swiotlb.h   |  1 +
> > > > > > > >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> > > > > > > >  4 files changed, 72 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > > > > > index 3511736fbc74..b073d58dd4a3 100644
> > > > > > > > --- a/arch/x86/kernel/setup.c
> > > > > > > > +++ b/arch/x86/kernel/setup.c
> > > > > > > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > > > > > > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > > > > > > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > > > > >  
> > > > > > > > +	swiotlb_adjust();
> > > > > > > > +
> > > > > > > >  	/*
> > > > > > > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > > > > > > >  	 * won't consume hotpluggable memory.
> > > > > > > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > > > > > > index 3f248f0d0e07..e0deb157cddd 100644
> > > > > > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > > > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > > > > > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> > > > > > > >  	pr_cont("\n");
> > > > > > > >  }
> > > > > > > >  
> > > > > > > > +#define TOTAL_MEM_1G	0x40000000UL
> > > > > > > > +#define TOTAL_MEM_4G	0x100000000UL
> > > > > > > > +
> > > > > > > > +#define SIZE_128M (128UL<<20)
> > > > > > > > +#define SIZE_256M (256UL<<20)
> > > > > > > > +#define SIZE_512M (512UL<<20)
> > > > > > > > +
> > > > > > > >  /* Architecture __weak replacement functions */
> > > > > > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > > > > > +{
> > > > > > > > +	unsigned long size = 0;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > > > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > > > > > +	 * drivers. However, depending on the workload being run, the
> > > > > > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > > > > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > > > > > +	 * performance degradation especially with high I/O workloads.
> > > > > > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > > > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > > > > > +	 * depending on amount of provisioned guest memory.
> > > > > > > > +	 */
> > > > > > > > +	if (sev_active()) {
> > > > > > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > > > > > +
> > > > > > > > +		if (total_mem <= TOTAL_MEM_1G)
> > > > > > > > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > > > > > > > +				     SIZE_128M);
> > > > > > > > +		else if (total_mem <= TOTAL_MEM_4G)
> > > > > > > > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > > > > > > > +				     SIZE_256M);
> > > > > > > > +		else
> > > > > > > > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > > > > > > > +				     SIZE_512M);
> > > > > > > > +
> > > > > > > > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > > > > > > > +			size >> 20);
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return size;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  void __init mem_encrypt_init(void)
> > > > > > > >  {
> > > > > > > >  	if (!sme_me_mask)
> > > > > > > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > > > > > > index 046bb94bd4d6..01ae6d891327 100644
> > > > > > > > --- a/include/linux/swiotlb.h
> > > > > > > > +++ b/include/linux/swiotlb.h
> > > > > > > > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> > > > > > > >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> > > > > > > >  extern unsigned long swiotlb_nr_tbl(void);
> > > > > > > >  unsigned long swiotlb_size_or_default(void);
> > > > > > > > +extern void __init swiotlb_adjust(void);
> > > > > > > >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> > > > > > > >  extern void __init swiotlb_update_mem_attributes(void);
> > > > > > > >  
> > > > > > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > > > > > index c19379fabd20..66a9e627bb51 100644
> > > > > > > > --- a/kernel/dma/swiotlb.c
> > > > > > > > +++ b/kernel/dma/swiotlb.c
> > > > > > > > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> > > > > > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > > > > > >  }
> > > > > > > >  
> > > > > > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > > > > > +{
> > > > > > > > +	return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +void __init swiotlb_adjust(void)
> > > > > > > > +{
> > > > > > > > +	unsigned long size;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > > > > > > +	 * architectures such as those supporting memory encryption to
> > > > > > > > +	 * adjust/expand SWIOTLB size for their use.
> > > > > > > > +	 */
> > > > > > > > +	if (!io_tlb_nslabs) {
> > > > > > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > > > > > +		if (size) {
> > > > > > > > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > > > > > > > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > > > > > > > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > > > > > +
> > > > > > > > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > > > > > > > +				io_tlb_nslabs);
> > > > > > > > +		}
> > > > > > > > +	}
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  void swiotlb_print_info(void)
> > > > > > > >  {
> > > > > > > >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > > > > > > > -- 
> > > > > > > > 2.17.1
> > > > > > > > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
