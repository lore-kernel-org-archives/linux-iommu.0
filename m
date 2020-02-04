Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF38AC35247
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 20:08:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B132084E
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 20:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FKiKqLJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B132084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 742D186961;
	Tue,  4 Feb 2020 20:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fRn9PP6M1GW; Tue,  4 Feb 2020 20:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78DE6868E7;
	Tue,  4 Feb 2020 20:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65364C0177;
	Tue,  4 Feb 2020 20:08:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6AE4C0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA2F2850DC
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYN9S1bBfuc5 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 20:08:25 +0000 (UTC)
X-Greylist: delayed 00:33:13 by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D1921850AD
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfjjpdq4I0M8DUKMAE3b7crxpvesulZVLtSWyuHcxkKwL6ev4M4ZQVoWlMry3BD3BUEWeEn1bO1cLoqBaQkx75yMYGe9aS5rpFoUxwlsYdiZz7JJPMNpmh0kdrZqOQz5M4rOdV905pG3ATb+okOxP/wpHkzPudS7yXzj3VbdW9bfUB2E9U8WCjFqwK7IppX0fn3Br+SwVxSUQBlrXtXa/JRScNEvtDpp5w06rza+lSGjd/x+2Abbrtw4SqYM+l3CRGADiM2edQzuxlIOnLCUaB1KjnQYOpLo4K+zyD8GSHjVpHpChLnXmTu8hLek3xFA0QMioCYulT82XLNVH0iRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTCqv7CIbLEb8n6bWDSiAwYCunqHTJX2eiwdvnI/TZs=;
 b=Dye/qR8kRAbgx0wpCzRv6cFAXvc4YVK9XtSD6Xs3yOTxyIocimkIJUwD73bDuYSvzbEenspZF/jgi8yPZm2BU7rMrwPEG3QvawYFWV9IYQkInV2T6CeU5823gLS9KLaHwEBX0nwqZSFbMYk1JOp+nohhsPL4mrbi4qf2n3lNzZ5DoUQNmt1mALD1F3Mwv1m+eCHwpDlDnbGjGjf1z9ogABPwV1jk6ei89Z/FFb8ur40loy9Fr2YmOkwXfXfABhWSVoHKDOJoL7kwjFdjl5ysnsTQMboUJ4WvgNg9v6/wvDYOPuZ9U22Y1pTWMuLEgw8vXky+QIsJsCcFHfNShjvfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTCqv7CIbLEb8n6bWDSiAwYCunqHTJX2eiwdvnI/TZs=;
 b=FKiKqLJDfSkVbaIvoRydEvTaYyHBv9LfcwXVyIoGlqlHnDZEbN6oyLpjLVZoKqazg71qs+/g5cQ3XG4wCZdxB/CQolJdJ2RJOYGnB7N5qTtS8Xjd8bK1b5AFzjk9hUPt6YluJXtP4DOE6NItVNvk2V6y8I96McZHZCSsWMBl40E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (52.132.196.33) by
 SN1PR12MB2559.namprd12.prod.outlook.com (52.132.196.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 19:35:08 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 19:35:08 +0000
Date: Tue, 4 Feb 2020 19:35:00 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200204193500.GA15564@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
Content-Disposition: inline
In-Reply-To: <20200124230008.GA1565@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0501CA0004.namprd05.prod.outlook.com
 (2603:10b6:803:40::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
MIME-Version: 1.0
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN4PR0501CA0004.namprd05.prod.outlook.com (2603:10b6:803:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.15 via Frontend
 Transport; Tue, 4 Feb 2020 19:35:07 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a38b3e2-3bdb-4f35-2f57-08d7a9a9578e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:|SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25597A480087F4823C86765A8E030@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(478600001)(8936002)(33716001)(8676002)(2906002)(16526019)(186003)(81156014)(81166006)(26005)(6496006)(66946007)(33656002)(316002)(52116002)(66476007)(66556008)(5660300002)(55016002)(1076003)(7416002)(9686003)(6916009)(86362001)(6666004)(44832011)(956004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2559;
 H:SN1PR12MB2528.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rbs21gOhmbR4qjSqpSPf65FSrOlt9JT1X4owQYd6kcFsPiUpkmWuxiaWSqlNDBZppKgJV2mOIz3QehHTN8GFmkTD7CokUfLa8dQxajJ2mYtTJHS0iERz0xJcYyP/GiR0UvTikqHBxNV6V/53Qh+juaxMOvOOYCZM6fboWdJ+UxJwZvye3kWAB/cqd1sl8X4v8vPa3i7A1DB7kaDY1eI1oOrbZ70QVz06lpxaIhPnzhhB7Spz2OMtSpEN+DS1QO+X667u38yPOrt544oTQwaWWc8YUgnJCKpkaBKInUvOOIAZ0JcdLbQn8x/kWsmGxY6g3mitS1tebPtsmybBD1xPG/WQlsdLJ7mKkqNvmIZv8hAKqjFsPgk7wq4j7CrLFdAjfH0G1cnueD7Hn+2b0WvHrzvi6p0lreoeSgeZ1sqTfp3vuuZmPH7RFLZ6G74gq/4S
X-MS-Exchange-AntiSpam-MessageData: wnSnxm5ZDgCIlYxpChf+hWTpf/5uFR4M9VCHWMv/9JGU1johEaR5cyShNJVeYj6c5eTgEz59Pa/XVzt92OaTnnlcqEx+uSd+WOmSSfT6P56x2504dZvsXTdDKUzRKI2U+Op0oOJoB9GbToOuwnNefQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38b3e2-3bdb-4f35-2f57-08d7a9a9578e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 19:35:08.5294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPlOCNddt85RM0luILDny1ZZ1DCPLWD9dQn3VfNLrw5vDUiKvhrdqJOhQfHPm/KDvWXzR9zxbw8V/+2EJEcjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
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

Looking fwd. to your feedback regarding support of other memory
encryption architectures such as Power, S390, etc.

Thanks,
Ashish

On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > 
> > > Additional memory calculations based on # of PCI devices and
> > > their memory ranges will make it more complicated with so
> > > many other permutations and combinations to explore, it is
> > > essential to keep this patch as simple as possible by 
> > > adjusting the bounce buffer size simply by determining it
> > > from the amount of provisioned guest memory.
> >> 
> >> Please rework the patch to:
> >> 
> >>  - Use a log solution instead of the multiplication.
> >>    Feel free to cap it at a sensible value.
> 
> Ok.
> 
> >> 
> >>  - Also the code depends on SWIOTLB calling in to the
> >>    adjust_swiotlb_default_size which looks wrong.
> >> 
> >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> 
> >>    That function's purpose is to report a value.
> >> 
> >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> >> 
> >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> 
> This seems to be a nice option, but then IOMMU_INIT APIs are
> x86-specific and this swiotlb buffer size adjustment is also needed
> for other memory encryption architectures like Power, S390, etc.
> 
> >> 
> >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> >>    perhaps add in this code ? Albeit it really should be in it's own
> >>    file, not in arch/x86/kernel/pci-swiotlb.c
> 
> Actually, we piggyback on pci_swiotlb_detect_override which sets
> swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> forces swiotlb on, but again this is all x86 architecture specific.
> 
> Thanks,
> Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
