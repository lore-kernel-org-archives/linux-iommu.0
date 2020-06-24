Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6AC433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 07:20:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D31206C3
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 07:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gi2hKJ2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D31206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0F47F2052A;
	Wed, 24 Jun 2020 07:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VVK6v9kSVGy; Wed, 24 Jun 2020 07:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A01A12038F;
	Wed, 24 Jun 2020 07:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCDDC088E;
	Wed, 24 Jun 2020 07:20:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00716C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF14486FD5
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ds0bZACI70jI for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 07:20:22 +0000 (UTC)
X-Greylist: delayed 00:15:05 by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1EBE286F6A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFfL5QsnCArRLbpa51p+uF73i/lBIdh1tVGvwQAUHX5cxr/0wmsKaBP5Iw6T70XRJrQzB7x3MKmzvomZpxf+sz7JRup64ji11OvFosWJo8FN124p71cUXdRZbt+7u9+PEDO7m40JcHDCTEEuCPZQkDthdUYnJLw88EjCg1LstGD/ApXDdOPvtf8LbZEcaUJm7L/4Jt3aZ5gDKa8mxBpdfSXGJ1eY2EVvjBDKfvX+sW2TEeWRfJibIDprd69nX10d7GbXfFNNKu2FtNY6DVZdtXBAMoVMKRPMcZfT6U1DzR+N+4ejN24VfUypmJvBnbz9mM0Oo+HBiINumxwef/BIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5NwVmwgYzjlbZdGcNLk5CFH7K2ZdWG1nu/isxcGes4=;
 b=Y3DbYRh2Cm5/xJOEfIOfdEuj72WYik9y98TLhZhHIYx+rFEyhSrJTeQscQAvxDqMa76SU9HXf/Qqrr072JFf3Cl9TdakRJbZrajF+6S3evi1tuHYTbiZ6A+Gj7Q6z22rmug/DR0rrg5+teUbMtcHnK2N4O0SO0qTuoqY0JH7SkVXRHhI42RBy0UsA2cGythOuuAege2dzsWgk7Vdb32WJ71dI1JYoIrJrtRFR5tYNPQFf0gKuTGKLVmp7sJYFN6VBNB96QvWuKkqGD3AII3PSH/j+9Fwjx9L3YEt6IKBgiKqiMga617z82WJN0AVS0WWCvZlpG+pnyK2dit16QVmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5NwVmwgYzjlbZdGcNLk5CFH7K2ZdWG1nu/isxcGes4=;
 b=gi2hKJ2xnnCvPlichxWklKuNOoDiz0b+Cyun75RTr3e77GOMqBhPZtM3Hs0veKdQtRHE4h8j1AN6GTMhKG19gye1Sfiq43cKx9UB4QxqAGSROQszgr7j0j33o+oXDDZcfeXC/P9xtrNMnLnxO82K36BH6H3bgxKbt+NlfKZMrwc=
Authentication-Results: darnok.org; dkim=none (message not signed)
 header.d=none;darnok.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) by
 DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Wed, 24 Jun 2020 07:05:15 +0000
Received: from DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::6962:a808:3fd5:7adb]) by DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::6962:a808:3fd5:7adb%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 07:05:15 +0000
Date: Wed, 24 Jun 2020 07:05:09 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200624070509.GA13381@ashkalra_ubuntu_server>
References: <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
 <20200330222551.GA22743@ashkalra_ubuntu_server>
 <20200427185318.GA8253@ashkalra_ubuntu_server>
 <20200623133843.GA5499@localhost.localdomain>
 <20200624002357.GA9955@ashkalra_ubuntu_server>
Content-Disposition: inline
In-Reply-To: <20200624002357.GA9955@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To DM5PR12MB1386.namprd12.prod.outlook.com
 (2603:10b6:3:77::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SA9PR03CA0002.namprd03.prod.outlook.com (2603:10b6:806:20::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 07:05:13 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 216569a2-f656-43ab-d3a3-08d8180cf1c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38178DE30C37CEDC9C620DD48E950@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6VJx8hs/IdXDZil/Z3WOBny1VjrBl9FpIMtsKs2ksS/HxDKWAdeR8l3QYUcXGXUyZ2MUHAbKavm62m9PUCqzdrAKWtCPXMbj/FYgD0e7PSjsfgnLLr5zdcFjGG6Xpua3bRf+Gambnh3CQl+Z7ynX9sA1n68YJVuO2Oz6BRukRD1vZO/vKvj3n8QBD+dmaBb2PzguAk26wmnX1kK0cvA0G5wls58YnI50PKpybxExVSVN9JJ0cgeHWP8vM6VA39f9tBRfDyjBFT+fo8vzoR2r/oUSdEtk2vNx3hAajqdm6jSUOyLT/kt5t2Rvz3PwcDmFVyp6d6xeaprmI74SsusQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1386.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(478600001)(186003)(16526019)(26005)(1076003)(33656002)(83380400001)(8936002)(66476007)(66946007)(66556008)(8676002)(5660300002)(7416002)(6916009)(9686003)(316002)(6666004)(86362001)(33716001)(956004)(55016002)(6496006)(4326008)(44832011)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U9gN9EWcly3lVYLiIVPsgJ9VkyKOFCIuu9b1nBFGmdVWWPrrLG+gRW1NOBIrdBzGFepvXhpYO0SHBT0exFall6/Vi2lUkSCWKvkLvfOdfqra3YxYvnW6vxER/Tegj3781tr6amyx2LtOtUKcpMNp/fY5DCzF3P2M51ymnkPJC+yIbW54ROowTBDX7Tp0RDMTTsjEp9v9r4w+1O972QcTOAia4G8IjproBDEmYEErEOTFzNzMhZ0PHBVPV3a5uwqHg01ANVcsbINd/i7ygALE19Gu9Wia6dvyU81rpmwyexlOu67Wfubx8h0OlnhPagWOgcaGu9ZmHWLAkzLHNwkx+wA0UXMUzffMBblD6wm6G99qpcpym7zSCPJjhFpp7tdyejW5pb9B6kGUN15Ir3HtBFuD6d1u3nfaby7FhBB0vYukpHPJqeMx+ORXo5LaRPUyATVFXgRmhIooUKMALUWz+mC3+db81i2SbdW0q/qmC2k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216569a2-f656-43ab-d3a3-08d8180cf1c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 07:05:15.1222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vOuL1KCs09bENCxSx6rPAKEicaxmQSXZGCDIp1A8ec70xuYRH+zxjJ/PZwZPy0VdZfjFgucQahD3u+8nGZOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Wed, Jun 24, 2020 at 12:23:57AM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> On Tue, Jun 23, 2020 at 09:38:43AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Apr 27, 2020 at 06:53:18PM +0000, Ashish Kalra wrote:
> > > Hello Konrad,
> > > 
> > > On Mon, Mar 30, 2020 at 10:25:51PM +0000, Ashish Kalra wrote:
> > > > Hello Konrad,
> > > > 
> > > > On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> > > > > > Hello Konrad,
> > > > > > 
> > > > > > Looking fwd. to your feedback regarding support of other memory
> > > > > > encryption architectures such as Power, S390, etc.
> > > > > > 
> > > > > > Thanks,
> > > > > > Ashish
> > > > > > 
> > > > > > On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > > > > > > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > > > > 
> > > > > > > > > Additional memory calculations based on # of PCI devices and
> > > > > > > > > their memory ranges will make it more complicated with so
> > > > > > > > > many other permutations and combinations to explore, it is
> > > > > > > > > essential to keep this patch as simple as possible by 
> > > > > > > > > adjusting the bounce buffer size simply by determining it
> > > > > > > > > from the amount of provisioned guest memory.
> > > > > > > >> 
> > > > > > > >> Please rework the patch to:
> > > > > > > >> 
> > > > > > > >>  - Use a log solution instead of the multiplication.
> > > > > > > >>    Feel free to cap it at a sensible value.
> > > > > > > 
> > > > > > > Ok.
> > > > > > > 
> > > > > > > >> 
> > > > > > > >>  - Also the code depends on SWIOTLB calling in to the
> > > > > > > >>    adjust_swiotlb_default_size which looks wrong.
> > > > > > > >> 
> > > > > > > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > > > > > > 
> > > > > > > >>    That function's purpose is to report a value.
> > > > > > > >> 
> > > > > > > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > > > > > > >> 
> > > > > > > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > > > > > > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > > > > > > 
> > > > > > > This seems to be a nice option, but then IOMMU_INIT APIs are
> > > > > > > x86-specific and this swiotlb buffer size adjustment is also needed
> > > > > > > for other memory encryption architectures like Power, S390, etc.
> > > > > 
> > > > > Oh dear. That I hadn't considered.
> > > > > > > 
> > > > > > > >> 
> > > > > > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > > > > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > > > > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > > > > > 
> > > > > > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > > > > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > > > > > forces swiotlb on, but again this is all x86 architecture specific.
> > > > > 
> > > > > Then it looks like the best bet is to do it from within swiotlb_init?
> > > > > We really can't do it from swiotlb_size_or_default - that function
> > > > > should just return a value and nothing else.
> > > > > 
> > > > 
> > > > Actually, we need to do it in swiotlb_size_or_default() as this gets called by
> > > > reserve_crashkernel_low() in arch/x86/kernel/setup.c and used to
> > > > reserve low crashkernel memory. If we adjust swiotlb size later in
> > > > swiotlb_init() which gets called later than reserve_crashkernel_low(),
> > > > then any swiotlb size changes/expansion will conflict/overlap with the
> > > > low memory reserved for crashkernel.
> > > > 
> > > and will also potentially cause SWIOTLB buffer allocation failures.
> > > 
> > > Do you have any feedback, comments on the above ?
> > 
> > 
> > The init boot chain looks like this:
> > 
> > initmem_init
> > 	pci_iommu_alloc
> > 		-> pci_swiotlb_detect_4gb
> > 		-> swiotlb_init
> > 
> > reserve_crashkernel
> > 	reserve_crashkernel_low
> > 		-> swiotlb_size_or_default
> > 		..
> > 
> > 
> > (rootfs code):
> > 	pci_iommu_init
> > 		-> a bunch of the other IOMMU late_init code gets called..
> > 		->  pci_swiotlb_late_init 
> > 
> > I have to say I am lost to how your patch fixes "If we adjust swiolb
> > size later .. then any swiotlb size .. will overlap with the low memory
> > reserved for crashkernel"?
> > 
> 
> Actually as per the boot flow :
> 
> setup_arch() calls reserve_crashkernel() and pci_iommu_alloc() is
> invoked through mm_init()/mem_init() and not via initmem_init().
> 
> start_kernel:
> ...
> setup_arch()
> 	reserve_crashkernel
> 		reserve_crashkernel_low
> 			-> swiotlb_size_or_default
> 
> ...
> ...
> mm_init()
> 	mem_init()
> 		pci_iommu_alloc
> 			-> pci_swiotlb_detect_4gb
> 			-> swiotlb_init
> 
> So as per the above boot flow, reserve_crashkernel() can get called
> before swiotlb_detect/init, and hence, if we don't fixup or adjust
> the SWIOTLB buffer size in swiotlb_size_or_default() then crash kernel
> will reserve memory which will conflict/overlap with any SWIOTLB bounce
> buffer allocated memory (adjusted or fixed up later).
> 
> Therefore, we need to adjust/fixup SWIOTLB bounce buffer memory in
> swiotlb_size_or_default() function itself, before swiotlb detect/init
> funtions get invoked.
> 

Also to add here, it looks like swiotlb_size_or_default() is an
interface function to get the SWIOTLB bounce buffer size for components
which are initialized before swiotlb_detect/init, so that these 
components can reserve or allocate their memory requirements with the
knowledge of how much SWIOTLB bounce buffers are going to use, so
therefore, any fixups or adjustments to SWIOTLB buffer size will need
to be made as part of swiotlb_size_or_default(). 

Thanks,
Ashish

> > Or are you saying that 'reserve_crashkernel_low' is the _culprit_ and it
> > is the one changing the size? And hence it modifying the swiotlb size
> > will fix this problem? Aka _before_ all the other IOMMU get their hand
> > on it?
> > 
> > If so why not create an
> > IOMMU_INIT(crashkernel_adjust_swiotlb,pci_swiotlb_detect_override,
> > NULL, NULL);
> > 
> > And crashkernel_adjust_swiotlb would change the size of swiotlb buffer
> > if conditions are found to require it.
> > 
> > You also may want to put a #define DEBUG in arch/x86/kernel/pci-iommu_table.c
> > to check out whether the tree structure of IOMMU entries is correct.
> > 
> > 
> > 
> > But still I am lost - if say the AMD one does decide for unknown reason
> > to expand the SWIOTLB you are still stuck with the 'overlap with
> > the low memory reserved' or so.
> > 
> > Perhaps add a late_init that gets called as the last one to validate
> > this ? And maybe if the swiotlb gets turned off you also take proper
> > steps?
> > 
> > > As such i feel, this patch is complete otherwise and can be included as
> > > it is. 
> > > 
> > > Thanks,
> > > Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
