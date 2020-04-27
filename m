Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A9C4CECD
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 19:08:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A4920B1F
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xFdE/rzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A4920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B4FFB85629;
	Mon, 27 Apr 2020 19:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmGWhxvQ2XmA; Mon, 27 Apr 2020 19:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9EC0582405;
	Mon, 27 Apr 2020 19:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 898C0C0172;
	Mon, 27 Apr 2020 19:08:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B76CCC003B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 19:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A26AB86044
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 19:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytQzyBQdueti for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 19:08:41 +0000 (UTC)
X-Greylist: delayed 00:15:12 by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C67E88600D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 19:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijGfa1pA5twLsZxxB5HK4V/Y0/YXoaHeQqYRgSHo0CcUTOn2nHRtC7MF/K+LaRWNZIPGd/oN1BObYr6iw2fBtOED+ifHLF+tTeplmSKKkToQxbd7gqZi0qV/xvZEn/35rXiu0qXiQpMmuVU57LfW1gyLn4/KV7ae0ST1X1SoMKyOO8BMau8SG1sF/poKlpcSxNzT5tEGu6D9SiIuJfkTuq4QyeUzjbvPg3wS4icALOrvkf6gKkAvN52C1DeZspZ2bJBQILHPYiNNon66mJ19oJp42WhVap+GpVJC0qdZtOVkib4itYaPgXNgPBXAu+8K9p9zoUYBf3TzetygH8LinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlJ4bnjm9/wa/56/akTvPxicRMFyo9uJ1cP7zBskTY=;
 b=ea5faPz+oF4wuHwiSDEgCMTVp5U4evvZ/ZlgT7euX5mJ7fJL18iLK4FFgSuef/oquI78a+CKUKZ85EtFysmekvCDJtBLuv5xYPdgK+gfqPn9YGsMPlTvQkAZMDfPGqzUWnwF+8440vBj4dv0MlP4efFryKjtYHjPGiddab+VYohed0zlZ1NUVShGn+JBP9cWelaOdmJwQ97zifDJvUxkJcFavhz2c1G1zh7CG2JR9MJ9EqCIIyjBojJQsgdOhDt7QPBwSJj0qUre14xTOZqWO83k7CAmQFj7HY1q5JE+9NpXYdTY8kvDzzGhBSgxUY8al5wFIQfnYtIp3QqOWT2KpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlJ4bnjm9/wa/56/akTvPxicRMFyo9uJ1cP7zBskTY=;
 b=xFdE/rzgWBUm2xFqV3UgoXlKMm0aWxEN+PQkLV3TrtL+8XiwiBhov3ZQXzYRDknZ/jsEo4NfuZ3KgDTAnHlgLid5nIg2PhJHrcXCaSepSaCC1OafisozJTrFSc6+fd7VOL6p01HOlkhcd1eWxDVbgUM+3ITJPFvSZyreIjmNCP4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) by
 DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 18:53:24 +0000
Received: from DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c]) by DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c%12]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 18:53:24 +0000
Date: Mon, 27 Apr 2020 18:53:18 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200427185318.GA8253@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
 <20200330222551.GA22743@ashkalra_ubuntu_server>
Content-Disposition: inline
In-Reply-To: <20200330222551.GA22743@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM5PR21CA0032.namprd21.prod.outlook.com
 (2603:10b6:3:ed::18) To DM5PR12MB1386.namprd12.prod.outlook.com
 (2603:10b6:3:77::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.3 via Frontend Transport; Mon, 27 Apr 2020 18:53:23 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a8e4a38-c804-4152-ea2d-08d7eadc4337
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:|DM5PR12MB1193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11933269B42557D8311B4C838EAF0@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1386.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(26005)(186003)(86362001)(66946007)(6666004)(16526019)(956004)(33656002)(4326008)(66476007)(66556008)(7416002)(5660300002)(6916009)(1076003)(2906002)(33716001)(6496006)(44832011)(316002)(55016002)(52116002)(81156014)(8936002)(478600001)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jjg2bUnVeQcq8Zl876ymWVBLf0DT6PE2GDNKdVUR4ECV0Mz7Eea1dPyF6VcSZMkPib7KPbA4A9+b66daNJZQiP/UgyvlIUMPdi5ffIqgvw2gvvgR+D5jhTO6syTdpU7xLgghOHN3xn2lq5Mpz8rpApIC0Vn6QPodo/D/jQ5wdEFppzb5Niand/Hp2JaA1wvcN8LSP5p1R5oA6CldscW8FJi8X4l5/wnMZRZL6d3t8A28cB+GATgyHPXK7IPu5QUumJTzVVzv+TKxgINsaTHIntxicf84h4fBcZroDkCUjwxAQ9wJta5yPlFSsdwG+NrqdapreuiZPtaXT8hJk9uaOktOf60Sw8Q/idk96vjxhVYbSMGPsfwDRQBG67ecWe6zr8YROY/IiOCFD4sv60Qyv91LjsIstkY29G41VdE80WWuYPPfDljed1pbYGLGUVoM
X-MS-Exchange-AntiSpam-MessageData: wBnN082YGA9QtC9zAmyzoWQ2uCih0EpcOM85wnx+LeoSJOZin8zgZQ3sLr7MAl4Dt0+YtKN/TexE4m05LcjM1CZPiMwFKTkW+CobL/uXr5boNSt/Jx3Jjat3LX8i3yqgI+JGQgMuKOCoveea+69X6WVaKYzPNC6TZy5aq8Ww7pNRCeWZ6e/froE+5/gcwJMjJR5mvfGiNZct9EmdPgi+9aI9+TVg8fi7or8fxguKseaq/9Erc7fDsqdy6fsleopyh2jrrgj4XLiIyCpAPiIDw1Ap+y5HnESSjMmJS58nzK2QTvcE1ZixlJUXXrGdbhnumixeiVQaF9DLf1LK3nvxIqN/9NQ/gisspgLlDBuvTtavBu0zzUBGSic9DE2cPdEdrnWBhwMnqjaLtjOjcVUuSEYknRKntqs5Wzt7NswogovSuNOVTHoqtsMI2Jx81kg79N3JDSvOCc7JFHIfrbVb5jFKchGZGmO0jSYoTZ3Utm8UvyoQBRH5mRiwsgCg6n8/w6r8W/CJm8kNcX7d4OQzrK8BVjJVbCEZZi/kd9W8p7c+8QPoqGbdSdwkpGVoXNpGtHpgw+auHk4HmuUA/CVgMHnzQMA8lvMGGsI2iAiV1dBFYODulpXQZJR6uOzahjXIZZzDCwWSnABWWmEJLyxyJrVoOwWebQuep5dNzL46MDTaulUQU0N13giaIhSr+/eCMKQk7cF0YyglOYNf+cWmNQ1mB60PxLsUQrQVdihZ3xmRjnBsNCpuBW9dxy4jZAr+4HvmzsXgGcSvMoJxmsZVzeq7Oy6cShzar1aDUcBalsY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8e4a38-c804-4152-ea2d-08d7eadc4337
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 18:53:24.1245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jv/svNbLDHOzBcFdQsc9vLK8/LnGlO5cA0Negn+AcyK1nbOW3gb2/z7o29OQsXc/c155fumO/MvCKcWA3hPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 luto@kernel.org, hpa@zytor.com, Konrad Rzeszutek Wilk <konrad@darnok.org>,
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

On Mon, Mar 30, 2020 at 10:25:51PM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> > > Hello Konrad,
> > > 
> > > Looking fwd. to your feedback regarding support of other memory
> > > encryption architectures such as Power, S390, etc.
> > > 
> > > Thanks,
> > > Ashish
> > > 
> > > On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > > > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > 
> > > > > > Additional memory calculations based on # of PCI devices and
> > > > > > their memory ranges will make it more complicated with so
> > > > > > many other permutations and combinations to explore, it is
> > > > > > essential to keep this patch as simple as possible by 
> > > > > > adjusting the bounce buffer size simply by determining it
> > > > > > from the amount of provisioned guest memory.
> > > > >> 
> > > > >> Please rework the patch to:
> > > > >> 
> > > > >>  - Use a log solution instead of the multiplication.
> > > > >>    Feel free to cap it at a sensible value.
> > > > 
> > > > Ok.
> > > > 
> > > > >> 
> > > > >>  - Also the code depends on SWIOTLB calling in to the
> > > > >>    adjust_swiotlb_default_size which looks wrong.
> > > > >> 
> > > > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > > > 
> > > > >>    That function's purpose is to report a value.
> > > > >> 
> > > > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > > > >> 
> > > > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > > > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > > > 
> > > > This seems to be a nice option, but then IOMMU_INIT APIs are
> > > > x86-specific and this swiotlb buffer size adjustment is also needed
> > > > for other memory encryption architectures like Power, S390, etc.
> > 
> > Oh dear. That I hadn't considered.
> > > > 
> > > > >> 
> > > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > > 
> > > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > > forces swiotlb on, but again this is all x86 architecture specific.
> > 
> > Then it looks like the best bet is to do it from within swiotlb_init?
> > We really can't do it from swiotlb_size_or_default - that function
> > should just return a value and nothing else.
> > 
> 
> Actually, we need to do it in swiotlb_size_or_default() as this gets called by
> reserve_crashkernel_low() in arch/x86/kernel/setup.c and used to
> reserve low crashkernel memory. If we adjust swiotlb size later in
> swiotlb_init() which gets called later than reserve_crashkernel_low(),
> then any swiotlb size changes/expansion will conflict/overlap with the
> low memory reserved for crashkernel.
> 
and will also potentially cause SWIOTLB buffer allocation failures.

Do you have any feedback, comments on the above ?

As such i feel, this patch is complete otherwise and can be included as
it is. 

Thanks,
Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
