Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452CC56202
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:46:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9ADF20BED
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CDxnmBra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9ADF20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 89D798697A;
	Tue, 24 Nov 2020 23:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ObgBz2-+sBt2; Tue, 24 Nov 2020 23:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D4D586978;
	Tue, 24 Nov 2020 23:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30F3AC163C;
	Tue, 24 Nov 2020 23:46:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73103C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A259232D2
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H03BoFnf2Q2l for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 23:46:35 +0000 (UTC)
X-Greylist: delayed 14:02:53 by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by silver.osuosl.org (Postfix) with ESMTPS id 64ABD22844
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em5KLt4IaWbAvdVaUCUZaRF+vgFWbnaa4NWE2tlusO16/x1y50PR/m1ppjpJLNqomiL3N/IEgZUmdfMW+9emBdzzK2YjgzKVFW3y1n/LBnDfv7vaXu7el0tv3tbvk6fXfWY4NSgCObVdw9504uBB6eU9TMqoYrgTYucZaDpvHLI4zFuDOmdAOeGHe7D67DHQTD1+C8pGHNHRZyLe+HOagqoMQD/rgm9xFskwWoNgBrgOhXxtvtGJ0GQKvZpK0gTvAP6kWCYlJncBtzHLxTMZ1AQymfL7Idp7U1vkotmDFewtlvhbefrbeTaZaNEXH/IRAf7Jom6RVLYfptyN55Y+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQB3TzcSHFusmcxmChj4Q9VJ6xBFdyeiVnrb6Np0t3Q=;
 b=cK9dFgvVUGnSbAQAvJwiMjVH+VksnoDfoVaoQEAmsdctVh120/K86+d3z3b6TCl3Rxz+QL7yUqF8Hzd4EF4lzvW1983DAmVei1YXwqBn0qk/rGBm1B/fJnO8x2Lsi00VNrhiBFx7RlwUfToRzSY1w6IG5ABFRcKx0ySY5TLBubt5p/giRFbLC7B/s7TAtlxqsjVcw/8Oqp5X93ugXQZuV5A0qFeEjcBrWnUM6eeeLCrYaQMKvOk78Bjj34c+qi8rgu43lKFtiKR2BEF5sgBtRBYlPYZeKkTWiNmyfv5nFnSG61cPeQvlb5MhmRFCndGqtXRGFb36828wrYUp69EKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQB3TzcSHFusmcxmChj4Q9VJ6xBFdyeiVnrb6Np0t3Q=;
 b=CDxnmBraSi/PnNOZa9GV0Ui4DXmudOcaL1Wjf5OsMMZOTShIas3EK95fjyBe8Ok70UTOjjaqwVNnGYq8TYTRRkCQzOJ9ngkSUA60dv3L1MGk+5jzN1SYOpOuAW6Iw7AGAuYh+n0vixwcUENOHv4lZ+cIbjygQCKNsLUL7SE/fCg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:46:31 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 24 Nov 2020
 23:46:31 +0000
Date: Tue, 24 Nov 2020 23:46:22 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124234622.GA16867@ashkalra_ubuntu_server>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
Content-Disposition: inline
In-Reply-To: <20201123225631.GA16055@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:5:120::36) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM6PR06CA0023.namprd06.prod.outlook.com (2603:10b6:5:120::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 23:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67079098-311c-426e-d0ce-08d890d32a77
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2415FF44841E1B23F2161EA38EFB0@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CmIUzkSYuZKDFswjZNCn40zU9WH3q8ghzgjvtCV9Xt8bTZy11+bHfMcog00GIHcwPM9utf99CgESikg+HE9Gp8TOycZY3np9eZq2VP2M60O0IByuGn2YNhJHix6M9jRFZ1lmggruY9gwkCEXhf92DE3zLZ1u114Gw4uqGnn+WCK3J2fcXH7APuD3ip74PQy5YOtfnQxkLB6OPMoqwMoTshF3vyxQiHy01SKXTYiJud7kRephn2zhSGIGMcl0S9h9KShJwAhczmZ6VB9pYfzWoq0mVrFhkTaXM6eWgfd1nKLQD1IUkmAh0zAIVMxgZ3lJwtDvTabTXgAnE3OdX6hClFYp3/6eyMYa4pM1QJWo8emWsKW/eL7Pcj10gJ402gT2vC2plAV3+Mxixtwjochnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66946007)(16526019)(52116002)(33656002)(6666004)(66476007)(66556008)(7416002)(44832011)(45080400002)(6916009)(4326008)(83380400001)(316002)(8676002)(55016002)(9686003)(26005)(33716001)(966005)(186003)(8936002)(2906002)(1076003)(86362001)(5660300002)(478600001)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+cNg0HrcN+DMo50TiC3nOZQ7yBGbVWasqibKcFZ1SX13/I1ExGpKkNEgxh7y?=
 =?us-ascii?Q?4PNys1zGt7fo8DCrrGHSmJ6uksm753Iah8cs5foWjV7iKXB18Llc0gZRUeXI?=
 =?us-ascii?Q?qO0c6llw+pJIgZRUfV0umSY4NQFD0IHkGHRR+FL2hbOP8Td+a/de4UOybGvW?=
 =?us-ascii?Q?u6U7kRYXNPqqqnygVsP7Fc7ZWbaTZQtrhHFpYugPlUc9U/uU/yH8wIpUsrLc?=
 =?us-ascii?Q?f9Kyaj3Jmn6FYfO+YY8SmOvDVx6Pv8sVIQIv4vyrhmn6lKv2H1gvKDZGJ88T?=
 =?us-ascii?Q?8c1+BfhfBbVicA3VPtgx6NzPI12JhqoHB0CCE7SQ3S/wInxv537cghjNxPr9?=
 =?us-ascii?Q?2YDKeTsfDGh59lBY+u6uLxt+jC8fooWRgh18WR88EJ0uOP3gmTZFjH/WP/2r?=
 =?us-ascii?Q?VHwH6JSfAN/dUiYe2Jdc2sXRZZj7l/J0TmVNTI0Mk5/vuxJv4EdYlM9Z13K3?=
 =?us-ascii?Q?30LDSTC/tIsepDajnfENVSVqPOo1/Z+U6QBlNZ9LGwNpPFQ2j6USifLrnQ8h?=
 =?us-ascii?Q?AE5Sl9oNaLJVZHVYvihTWLy0Y8PnfP/KpEFNHZU6y1+ptsz3aJhl+cXqwNFD?=
 =?us-ascii?Q?i8CxTql5Tm94pB+o2YnJ+YlzLK3nVpGPc1BbgubvJAjIctyAI5iJRywoVMIa?=
 =?us-ascii?Q?WA65ykJyCYEI6spLo5oEWiuwJjFjWIJyWGKrm7Vfbyv5mAGHBW50hyIZj8dM?=
 =?us-ascii?Q?sgKLYXE/WrtQ2inFRlaL1/hHhoaDqK9OOpZDP0j8bL0HHw8AxQgbzB6aU7kC?=
 =?us-ascii?Q?ljn05bdVufjUMxn9vYvy7RAPLTvv0goqeq2q5R4HczjFqd76MIe8hBROL2nj?=
 =?us-ascii?Q?WtFu9tSl2KQNCtSxS/zifMSXgTNsA/tW1v6S3+8DLn8nWh4nhAIgRFAoX88a?=
 =?us-ascii?Q?FvDcCIycuq1ZJANUje83KZ7Fi7Y9LqH5Fh3Jgonw12JqAz9aK7Xk5qTZ5bGY?=
 =?us-ascii?Q?xqgfLQOE8WLx1mLeRxFsMQ9KP6hXa/BNpDeaeZwubKATOccyd+X3XWp7y4O4?=
 =?us-ascii?Q?+ykM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67079098-311c-426e-d0ce-08d890d32a77
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 23:46:31.1442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2BC+9G0hKS2A0YRis86Lf1rdCp9yO9dAUSc7HNa2ymZmvQml9bqikj+V5Safz1J5GJWhrnFz1eipmycZKMBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, luto@kernel.org,
 hpa@zytor.com, rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

On Mon, Nov 23, 2020 at 10:56:31PM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> On Mon, Nov 23, 2020 at 12:56:32PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Nov 23, 2020 at 06:06:47PM +0100, Borislav Petkov wrote:
> > > On Thu, Nov 19, 2020 at 09:42:05PM +0000, Ashish Kalra wrote:
> > > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > > 
> > > > For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> > > > SEV uses SWIOTLB to make this happen without requiring changes to device
> > > > drivers.  However, depending on workload being run, the default 64MB of
> > > > SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> > > > for DMA, resulting in I/O errors and/or performance degradation for
> > > > high I/O workloads.
> > > > 
> > > > Increase the default size of SWIOTLB for SEV guests using a minimum
> > > > value of 128MB and a maximum value of 512MB, determining on amount
> > > > of provisioned guest memory.
> > > 
> > > That sentence needs massaging.
> > > 
> > > > Using late_initcall() interface to invoke swiotlb_adjust() does not
> > > > work as the size adjustment needs to be done before mem_encrypt_init()
> > > > and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> > > > hence calling it explicitly from setup_arch().
> > > 
> > > "hence call it ... "
> > > 
> > > > 
> > > > The SWIOTLB default size adjustment is added as an architecture specific
> > > 
> > > "... is added... " needs to be "Add ..."
> > > 
> > > > interface/callback to allow architectures such as those supporting memory
> > > > encryption to adjust/expand SWIOTLB size for their use.
> > > > 
> > > > v5 fixed build errors and warnings as
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > 
> > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > ---
> > > >  arch/x86/kernel/setup.c   |  2 ++
> > > >  arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
> > > >  include/linux/swiotlb.h   |  6 ++++++
> > > >  kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
> > > >  4 files changed, 64 insertions(+)
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
> > > > index 3f248f0d0e07..c79a0d761db5 100644
> > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > @@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
> > > >  }
> > > >  
> > > >  /* Architecture __weak replacement functions */
> > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > +{
> > > > +	unsigned long size = 0;
> > > 
> > > 	unsigned long size = iotlb_default_size;
> > > 
> > > > +
> > > > +	/*
> > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > +	 * drivers. However, depending on the workload being run, the
> > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > 						     ^
> > > 
> > > Use words pls, not "&".
> > > 
> > > 
> > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > +	 * performance degradation especially with high I/O workloads.
> > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > +	 * depending on amount of provisioned guest memory.
> > > > +	 */
> > > > +	if (sev_active()) {
> > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > +
> > > > +		if (total_mem <= SZ_1G)
> > > > +			size = max(iotlb_default_size, (unsigned long) SZ_128M);
> > > > +		else if (total_mem <= SZ_4G)
> > > > +			size = max(iotlb_default_size, (unsigned long) SZ_256M);
> > 
> > That is eating 128MB for 1GB, aka 12% of the guest memory allocated statically for this.
> > 
> > And for guests that are 2GB, that is 12% until it gets to 3GB when it is 8%
> > and then 6% at 4GB.
> > 
> > I would prefer this to be based on your memory count, that is 6% of total
> > memory. And then going forward we can allocate memory _after_ boot and then stich
> > the late SWIOTLB pool and allocate on demand.
> > 
> > 
> Ok. 
> 
> As i mentioned earlier, the patch was initially based on using a % of guest memory,
> as below:
> 
> +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
> +#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
> ...
> ...
> +       if (sev_active() && !io_tlb_nslabs) {
> +               unsigned long total_mem = get_num_physpages() <<
> + PAGE_SHIFT;
> +
> +               default_size = total_mem *
> +                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> +
> +               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
> +
> +               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
> +                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
> +       }
> 
> So a similar logic can be applied here.
> 
> > 
> > > > +		else
> > > > +			size = max(iotlb_default_size, (unsigned long) SZ_512M);
> > > > +
> > > > +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",
> > > 
> > > just "... for SEV" - no need for "platform".
> > > 
> > > ...
> > > 
> > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > index c19379fabd20..3be9a19ea0a5 100644
> > > > --- a/kernel/dma/swiotlb.c
> > > > +++ b/kernel/dma/swiotlb.c
> > > > @@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
> > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > >  }
> > > >  
> > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > +{
> > > > +	return 0;
> > > 
> > > That, of course, needs to return size, not 0.
> > 
> > This is not going to work for TDX. I think having a registration
> > to SWIOTLB to have this function would be better going forward.
> > 
> > As in there will be a swiotlb_register_adjuster() which AMD SEV
> > code can call at start, also TDX can do it (and other platforms).
> > 
> 
> The question is how does mem_encrypt_init() work ?
> 
> That uses a similar logic as arch_swiotlb_adjust() as a "__weak"
> function and i am sure it will also need to have added support for TDX,
> can't both arch_swiotlb_adjust() and mem_encrypt_init() have specific
> checks for active AMD/INTEL memory encryption technology and accordingly
> perform actions, as mem_encrypt_init() currently checks for
> sev_active().
> 
> init/main.c: 
> 
> void __init __weak mem_encrypt_init(void) { }
> 
> start_kernel()
> {
>    ..
>    mem_encrypt_init();
>    ..
> }
> 
> arch/x86/mm/mem_encrypt.c: 
>     
> /* Architecture __weak replacement functions */
> 
> void __init mem_encrypt_init(void)
> {
>         if (!sme_me_mask)
>                 return;
> 
>         /* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>         swiotlb_update_mem_attributes();
> 
>         /*
>          * With SEV, we need to unroll the rep string I/O instructions.
>          */
>         if (sev_active())
>                 static_branch_enable(&sev_enable_key);
> ...
> ...
> 

Your thoughts on this ?

Thanks,
Ashish

> 
> > > 
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
> > > 
> > > And when you preset the function-local argument "size" with the size
> > > coming in as the size argument of arch_swiotlb_adjust()...
> > > 
> > > > +	if (!io_tlb_nslabs) {
> > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > +		if (size) {
> > > 
> > > ... you don't have to do if (size) here either but simply use size to
> > > compute io_tlb_nslabs, I'd say.
> > > 
> > > Thx.
> > > 
> > > -- 
> > > Regards/Gruss,
> > >     Boris.
> > > 
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7Cebd4a85f98f44bdfcb5408d88fd8dfac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417508926083910%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ub9PjAPzhDWr7K2iQggTAXwgg4VbORxP%2F%2Fcg6gQreCc%3D&amp;reserved=0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
