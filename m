Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDCC433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 00:38:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A8120CC7
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rv4o7Sz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A8120CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D76E021080;
	Wed, 24 Jun 2020 00:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D32IZ2oNFnTw; Wed, 24 Jun 2020 00:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 65DC520798;
	Wed, 24 Jun 2020 00:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C8EC088E;
	Wed, 24 Jun 2020 00:38:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83CAFC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52A26207B0
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfnrdgfgJ1xM for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 00:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by silver.osuosl.org (Postfix) with ESMTPS id A7FD120798
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz3X4GN/vtSrEieIsnFRTchK5H8lhVSdLMn9yajynqDfZ4p5Dce4tQMTMmpklK8HHC0ti6jpgl4zUjDQ6+vZmkrtu1BUUveZEFZz4VMvGLBGnoOnRISf3CPhDgJ/9H+V2LXoMBL5vIbwJAp0QW1yKwBGGMNCHQB6mTAaEco7Bl4qcxV7xbLRZIwE9PqFe6rBqQlDntWqtdx3PeRM07ec8SXRgBptk0kQLnHNbaRbNjbV17bZHQ6DorrrkeJOoF8Qy5oCLvz1ul0y4VNKm/Gr46NNRof27igvWMaIjW/+1oGZcYfQBHxvQxmN6Kb4KEpqgxWVbOuztH57iyHdGSU4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsRk6ByDnc/aM10+z64zaAkMoNA2z3eq/0DXdjFHKh8=;
 b=jPHXLNFT2Qh1sw3OC34a/THUr0NkkivRVwcrwaWYwXfMpOEmlsaLDc+jN7pRny+eVgGhNZrmq7SFoaFvIBMycpylayOkiiMGR+WPhUVSJKI8RiGLDdY1t9bYdGvGAvD6NTxpYpZ0KwDVM4CkmnlDxT1wJydYSuVN4WftrwDKUMnhxs1YwI7r5n708gFJZeYxJaUeuoqtOFHhihlnE+tKRxtSEDKKLCvUlCbf9rlL1hdTZFFqGflw6yThrQj5opaYIMuRaIl6bZHCM8TBuy5owJ3hSlMeudLtHqOqqo2dAT4RqnDxrpAEW9SCqK+Kp2W68E/rWAEtoO7mBjyJGDdLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsRk6ByDnc/aM10+z64zaAkMoNA2z3eq/0DXdjFHKh8=;
 b=Rv4o7Sz3PADs3T2uKJok8N0U851T6/7szPop0oRrm7DicUU+UUJVlyLzliemqGrzwvdm98Pd5dE5BVxw5EmN2hiH4j0mcSu3Dv6lKwQgK0PTQxSDex6pccMSr/2UFYghbKi2vJ2L10fnTnsqQifQJhCQsn/hNKHdltQa7UCUTi0=
Authentication-Results: darnok.org; dkim=none (message not signed)
 header.d=none;darnok.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) by
 DM5PR12MB1610.namprd12.prod.outlook.com (2603:10b6:4:3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 00:24:03 +0000
Received: from DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::6962:a808:3fd5:7adb]) by DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::6962:a808:3fd5:7adb%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 00:24:03 +0000
Date: Wed, 24 Jun 2020 00:23:57 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200624002357.GA9955@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
 <20200330222551.GA22743@ashkalra_ubuntu_server>
 <20200427185318.GA8253@ashkalra_ubuntu_server>
 <20200623133843.GA5499@localhost.localdomain>
Content-Disposition: inline
In-Reply-To: <20200623133843.GA5499@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN2PR01CA0013.prod.exchangelabs.com (2603:10b6:804:2::23)
 To DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN2PR01CA0013.prod.exchangelabs.com (2603:10b6:804:2::23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 00:24:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f72a391-48aa-4504-38dc-08d817d4e5f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1610E538EB3EBB9D16F7B7E28E950@DM5PR12MB1610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nus8OZH0E3PXx5/1cGl6vvVjXu/i+egSdYKsqjEBAyF3+134A6E0dwt1RKE6PzK94wYZi2ehYsGzNDfjaq4p8WZOu8ANO7NegQsr7YpFaQY1VCotHYJ/xYGm5XfcnoTHYjP3R5al1fXwamJLSG57EiWJv7mOlQd4gE8FOGvlBKu6XVPvfQMVDqCcCKP7p1hijDiRG7U68Jqro2H26dMU5crYzlLG46YBKUPrPeshKua1HzDvzFbtMnWdueZ0QYMCh+l4zawSyWrnBk06HBp9YuYU5MlV22/dgjexTUP+doo/2F7pAP5cDRkMmasPsAnUrxKvNL8QivRapwwZaXZhaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1386.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(346002)(396003)(376002)(956004)(316002)(6666004)(478600001)(1076003)(86362001)(2906002)(6916009)(5660300002)(33656002)(52116002)(9686003)(66946007)(55016002)(66476007)(66556008)(6496006)(83380400001)(33716001)(186003)(4326008)(8676002)(16526019)(44832011)(26005)(8936002)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: o0Is+fxl6sWNpWQ6Gz173q6U5byL56SQDqJ0PSilAK/pB1EG+0XVBmeMf6OUXrN8ew6Qx15hfOT3DHXSBArH2McImaBz6qVbtQA12HGv8f8EOwe9SNTemLycZAmSDehQM5nI489+ivP8ez767wkNmkhHY09ItnGJ0WGNJrfqdY9KWt4yIrOpDJrZpjWGMlMmuMtearD2Efhl7OCBUkkyOW7V/xKUGQXhWY5bwvNRsDP7kzWeLTQGg/ebzGorF5rXZ2vsiWqT5fKNFck77ge9f+9nHQS3fTxzwnXwpiPk5Fb4hIa2W6qfQ96E7SLrtrhp3IEKt/McugxkPZNCs2CiRGrTH6K7aAsafIGbLxUW+HVBoF520hfVMZkfc+5i7z2bfRBip/9JOtJ1IWRhZq4lYmAPoh3K4eL9GAOIgS5uDKOupzAKC6FXiIW28+w0xYmfV2N0sYujrCSuo8xv4UOxzeKGr/WfmfWaRXHcr5AgPG0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72a391-48aa-4504-38dc-08d817d4e5f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 00:24:03.4940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/h8lwwyHwGmLDJpyR/slx+FfrRzcU28Wu8O6dgvJjbUwQmr29bREtHuCIgLRdBGZoRZSQOv59aM+zXbPpC6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
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

Hello Konrad,

On Tue, Jun 23, 2020 at 09:38:43AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Apr 27, 2020 at 06:53:18PM +0000, Ashish Kalra wrote:
> > Hello Konrad,
> > 
> > On Mon, Mar 30, 2020 at 10:25:51PM +0000, Ashish Kalra wrote:
> > > Hello Konrad,
> > > 
> > > On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> > > > > Hello Konrad,
> > > > > 
> > > > > Looking fwd. to your feedback regarding support of other memory
> > > > > encryption architectures such as Power, S390, etc.
> > > > > 
> > > > > Thanks,
> > > > > Ashish
> > > > > 
> > > > > On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > > > > > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > > > 
> > > > > > > > Additional memory calculations based on # of PCI devices and
> > > > > > > > their memory ranges will make it more complicated with so
> > > > > > > > many other permutations and combinations to explore, it is
> > > > > > > > essential to keep this patch as simple as possible by 
> > > > > > > > adjusting the bounce buffer size simply by determining it
> > > > > > > > from the amount of provisioned guest memory.
> > > > > > >> 
> > > > > > >> Please rework the patch to:
> > > > > > >> 
> > > > > > >>  - Use a log solution instead of the multiplication.
> > > > > > >>    Feel free to cap it at a sensible value.
> > > > > > 
> > > > > > Ok.
> > > > > > 
> > > > > > >> 
> > > > > > >>  - Also the code depends on SWIOTLB calling in to the
> > > > > > >>    adjust_swiotlb_default_size which looks wrong.
> > > > > > >> 
> > > > > > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > > > > > 
> > > > > > >>    That function's purpose is to report a value.
> > > > > > >> 
> > > > > > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > > > > > >> 
> > > > > > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > > > > > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > > > > > 
> > > > > > This seems to be a nice option, but then IOMMU_INIT APIs are
> > > > > > x86-specific and this swiotlb buffer size adjustment is also needed
> > > > > > for other memory encryption architectures like Power, S390, etc.
> > > > 
> > > > Oh dear. That I hadn't considered.
> > > > > > 
> > > > > > >> 
> > > > > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > > > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > > > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > > > > 
> > > > > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > > > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > > > > forces swiotlb on, but again this is all x86 architecture specific.
> > > > 
> > > > Then it looks like the best bet is to do it from within swiotlb_init?
> > > > We really can't do it from swiotlb_size_or_default - that function
> > > > should just return a value and nothing else.
> > > > 
> > > 
> > > Actually, we need to do it in swiotlb_size_or_default() as this gets called by
> > > reserve_crashkernel_low() in arch/x86/kernel/setup.c and used to
> > > reserve low crashkernel memory. If we adjust swiotlb size later in
> > > swiotlb_init() which gets called later than reserve_crashkernel_low(),
> > > then any swiotlb size changes/expansion will conflict/overlap with the
> > > low memory reserved for crashkernel.
> > > 
> > and will also potentially cause SWIOTLB buffer allocation failures.
> > 
> > Do you have any feedback, comments on the above ?
> 
> 
> The init boot chain looks like this:
> 
> initmem_init
> 	pci_iommu_alloc
> 		-> pci_swiotlb_detect_4gb
> 		-> swiotlb_init
> 
> reserve_crashkernel
> 	reserve_crashkernel_low
> 		-> swiotlb_size_or_default
> 		..
> 
> 
> (rootfs code):
> 	pci_iommu_init
> 		-> a bunch of the other IOMMU late_init code gets called..
> 		->  pci_swiotlb_late_init 
> 
> I have to say I am lost to how your patch fixes "If we adjust swiolb
> size later .. then any swiotlb size .. will overlap with the low memory
> reserved for crashkernel"?
> 

Actually as per the boot flow :

setup_arch() calls reserve_crashkernel() and pci_iommu_alloc() is
invoked through mm_init()/mem_init() and not via initmem_init().

start_kernel:
...
setup_arch()
	reserve_crashkernel
		reserve_crashkernel_low
			-> swiotlb_size_or_default

...
...
mm_init()
	mem_init()
		pci_iommu_alloc
			-> pci_swiotlb_detect_4gb
			-> swiotlb_init

So as per the above boot flow, reserve_crashkernel() can get called
before swiotlb_detect/init, and hence, if we don't fixup or adjust
the SWIOTLB buffer size in swiotlb_size_or_default() then crash kernel
will reserve memory which will conflict/overlap with any SWIOTLB bounce
buffer allocated memory (adjusted or fixed up later).

Therefore, we need to adjust/fixup SWIOTLB bounce buffer memory in
swiotlb_size_or_default() function itself, before swiotlb detect/init
funtions get invoked.

Thanks,
Ashish

> Or are you saying that 'reserve_crashkernel_low' is the _culprit_ and it
> is the one changing the size? And hence it modifying the swiotlb size
> will fix this problem? Aka _before_ all the other IOMMU get their hand
> on it?
> 
> If so why not create an
> IOMMU_INIT(crashkernel_adjust_swiotlb,pci_swiotlb_detect_override,
> NULL, NULL);
> 
> And crashkernel_adjust_swiotlb would change the size of swiotlb buffer
> if conditions are found to require it.
> 
> You also may want to put a #define DEBUG in arch/x86/kernel/pci-iommu_table.c
> to check out whether the tree structure of IOMMU entries is correct.
> 
> 
> 
> But still I am lost - if say the AMD one does decide for unknown reason
> to expand the SWIOTLB you are still stuck with the 'overlap with
> the low memory reserved' or so.
> 
> Perhaps add a late_init that gets called as the last one to validate
> this ? And maybe if the swiotlb gets turned off you also take proper
> steps?
> 
> > As such i feel, this patch is complete otherwise and can be included as
> > it is. 
> > 
> > Thanks,
> > Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
