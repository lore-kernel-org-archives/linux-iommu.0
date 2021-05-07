Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABABC433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 18:21:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A5F6143B
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 18:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A5F6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A8CC84466;
	Fri,  7 May 2021 18:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJbidCfIOTKG; Fri,  7 May 2021 18:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53FC584481;
	Fri,  7 May 2021 18:21:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25153C000E;
	Fri,  7 May 2021 18:21:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEBA0C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AB1C418C8
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rBsr_4WcIuQ3 for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 18:20:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 068ED418C7
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKvpdakpA/Q86QvdngQd3ylFGywr9QDoKDA7cyrPerpWeLcWM5TIzvaAYvgCd/h9nk5Zwft+d4f6OWTA3MpfjcVEnUOAFC05/il2BYvL0k68pfDx+GS7Iyb185u87Aw2EAIxpgzqMa/2P8Wv6695olsCD6qfUPeZ+RGpoKYOPkMx+L7eOBLHuEiKXoo/b/h0XUvq8D0sgWqmFTLDP/vr+5Eg+lPSHNyUbj8kXFqV/jUg6dFWtxR84iArA+lEtoNJU8vQ/4xC4ceksA894RW56K8DAqbDMz9D2SDPrM11bg340c1NbAVTa5T49tEZCTKOK4L7/fACf3SMWYK6BFgxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drhlgwhAro3jEDZ2bf1UkP4l2qgy9Swo2Y2zyqfr8BQ=;
 b=CeVC1h8xbfkO0N7Fd4OCar9Ql6KHYYkPwfS3X2sGo0LlysjALljXAyGeFqk+uLjT39RhC0gYRFYuIcU6vG5q7shZQxrlyiXQ6z5YP7JFC+3DPnpjETyaNunThMlUXZpJ4cHdqnaSV8bGO397YUAoW7wL8lqHWnnG1pcmhb3D7dIaFsd7MFsP+cDjtOVVln3RHRE6RCun4OA5TGmfHPG1PhQDTiSvQbxGI0v86D7+9JIDaW+suq7jX9LVSKa9pPi+mtVEy52Y+b9tlgHmBWMozqiRZmOKf8NJ47EGbZ1lUBsSQGFmP6bNz5bsG/BWQHO+dI5erDKyCJVtWsQLBvkxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drhlgwhAro3jEDZ2bf1UkP4l2qgy9Swo2Y2zyqfr8BQ=;
 b=a+ZjnvY2JaGhjB4wabPadcagzBS4uqeFJw0Bqs1T70LhN2JcU13b5M+0np8Io/JElxtjVE+6PO2qcPzLQSE7g+6Giu3Thn+g1AFMshryEPPIi04dx7e5AzTlgmBpH4HtxeUuP33PlSlOQo8JXMvjda5xRIo+DP2U0hjCsabgnYDf8F/ykSDaKlP0KF0svFdEZ3Glr4htYJ8NLNpLA2B9/LtOa3eOfZ/PJ4937wFesmNGwRrvjITypzzxA2rtPlTze2hEBcwr1+9yWHDlUUEDhAajQJraYK9o76ssUSGph3moGOU/eAT+qKqDXEwtROMHAwrOcsj0lNpJ5c8l8/8vOQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 18:20:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 18:20:51 +0000
Date: Fri, 7 May 2021 15:20:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507182050.GX1370958@nvidia.com>
References: <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
 <20210507181458.GA73499@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20210507181458.GA73499@otc-nc-03>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:208:235::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 18:20:51 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lf55m-002wpb-ND; Fri, 07 May 2021 15:20:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4c9104-881c-48a4-b9d0-08d91184d89b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145203BA33E434C3C77E287C2579@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLVrUjSuypIfrTkMpv2tNRI+YMIw0C77hyoEDi7mJcsoeobyi2ryu5VZxumLSb50/rVborZUi9iII1wadrPART81QITpWV+GiPe+tz6mtaXmNH5GopJC89DysoUJqvi8fOj7Z7mw2gGpPRV/Gf9kRMYA7n/s4VkTelyhahs60OQc8skdsuGml1Ek8J3C4CbuaKx0CzBAgFt/Mt27347g2txMYu8GXs1cWz/MTrd3idLocbS0XoFQpowuqnryqm4CfgwaH7L1qxeczGbgpRUHvJG96Jrj01n5cME8PGY71JKlz4sIrc7OjpOzMWvPCmSZyyXmjEx9Iz/YgdRVgA3a4MZlHxMn86yVKVrQSxAxjpcZZEau42+FejGxn4z47FhthVL3nOL7k8s7HlxIKP4j+6HX4CcOrE6QOGzREvXXX1/4i73W2ab83S/EMs308brYQk3SW/iRFFCUNehpbL4PtJvdlmMBIjFw15WR/AGHfbmcTuewMeGxgsVaMYBeTEskYPvw9VXfzNE3lARxA9TQkXYdhu/EIn95w9ySqGNnCSJ4QJZRQWLjAeb3eDYv8DKRp4rKFDHmqjId/q0NYpOy4uLT/uN4OQKxnu1XWzsBfck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(478600001)(9786002)(83380400001)(2616005)(33656002)(316002)(1076003)(426003)(9746002)(66556008)(66946007)(26005)(38100700002)(5660300002)(7416002)(36756003)(54906003)(4326008)(186003)(2906002)(6916009)(8676002)(8936002)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iZ35n0ri8hvfdQpjxYgxmHRNATjJf5FNIEVpfGt2m9LfxVKij0hgaAr6MXIc?=
 =?us-ascii?Q?nnFBHG6QIGMmJXL6u00T2qdbelbA3slf4fc9xEUiHDMnPrKVyWvm5Wx87/GU?=
 =?us-ascii?Q?MdAxDk+l4n7lmRjxRubVdmQg4ivrErk1XJDUOdhmAENs1Wu9fQRQD2+91Vmd?=
 =?us-ascii?Q?Lyf83BwVEwY/cv/IFsXMx7ggC0TGwFWrXjETcZQdUmQX8WfiNeHS9RtDMv6A?=
 =?us-ascii?Q?g3XKFtDybO/wOFUi7UByfX6Cc44lO0E3uT1C1+xywhawUuqr1TRe+9ZEuItj?=
 =?us-ascii?Q?o3duJd/EgIj4fZ8ShVKS3SeLAjGljaLm92NbGW0+Witon0mTHoZyqKLySQsb?=
 =?us-ascii?Q?Ug9Sm3zAUncPqU1kMKwErARn5kh1Wp5YAh0JqATfnmFY41RhSR/vFr/gkHus?=
 =?us-ascii?Q?y8XYkV2lbP3zwW8wiVaIhq0ftpp5Jfd6ZqXDuZZmK5ccOyfHtJbK0WpuTI/z?=
 =?us-ascii?Q?qkcS5FMgmYVttqoedlqfES/zzlAcCyPEyt0eJs4dK3D1oR3EzewTgWwYSf3F?=
 =?us-ascii?Q?e3MbEJ0H8jn/UVlA0CciRN4B6CfpKtuT5DJ8Ut7/hVv/my4+8EGvIEVh/+lk?=
 =?us-ascii?Q?NRRbgTX0jY+tipu6ZZrmtzYsLLZGSWeo1J1ScAT9cbYEHPybAvKgaeQEeNTU?=
 =?us-ascii?Q?wbgSC+stx0Vk05pyoNA67MB7AbePmO57RFO68wdGwYJTEyq4TWSrRYLFityh?=
 =?us-ascii?Q?loVUsDVOvmOunOAddy5bTm8zxfBsF47VpLZYBMGIlmpr00JBfcv8GUgJNccN?=
 =?us-ascii?Q?IfjMt7gjq22thx61C/IiuSdF4LEjxWoH3pKtx8qDVNIQQdbo1ShHFg5xXcHz?=
 =?us-ascii?Q?7dxTvy5AXzUDE1PHYxNsIEBxLcCiG2LeZx+j0yKMhH3O8RX7wROsMVAlkwxv?=
 =?us-ascii?Q?rrOemCIRkfKRs/HeFANPMFxVmjkcLc8msKYvYO1nh223lZRb0OxsHFg3rydD?=
 =?us-ascii?Q?bE1gvxZb4OtvxUJF1r4Zfn+RdeIY5mIg+fzbFgHFICAXoypbzyIZbJW7TkBH?=
 =?us-ascii?Q?1B2zmjNR6P4C3b2aOy7WS9+CTK/i2EGSrdJuEkmmwr5nOEEmVxDuX7Q0/FaC?=
 =?us-ascii?Q?Nr+zGF2Bp1xwZZX7Ef11fHigQGOZj0IG2Gp1WrrXQq5PMvrTCqhhIvrwfwnx?=
 =?us-ascii?Q?1vVwuP02iXGh0o3kcKITaCCv1lNlMlldaG2WJPrlibc7cMLfOuBuzQ/I+HTS?=
 =?us-ascii?Q?pw2moaGqXEfFf7Vlrm+uYzqo0plMNT1mntnOll0MrrhKR0UXOeSIefxgTRxm?=
 =?us-ascii?Q?4NnoqQyOeqjIRNu4o91T75C8SdyBOSdJ9udXeNrq4QCZI9qXwskDtuIUsz6v?=
 =?us-ascii?Q?TfaZbky/iSPHc5CgICwuHmTk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c9104-881c-48a4-b9d0-08d91184d89b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 18:20:51.9014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTQkOuUvq1g5A+Wv8K2365qhfWK4y/kHUpphRlwewt4uZAgtC6G1GgNPv/84d2d7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, May 07, 2021 at 11:14:58AM -0700, Raj, Ashok wrote:
> On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> > 
> > > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > > global across the entire system. Maybe its better to call them gPASID for
> > > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > > in earlier responses)
> > 
> > I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> > per-RID PASID in the translation table as well.
> 
> When using ENQCMD the PASID that needs to be sent on the wire is picked
> from an MSR setup by kernel. This is context switched along with the
> process. So each process has only 1 PASID that can go out when using
> ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
> source for the descriptor.

Oh. I forgot this also globally locked the PASID to a single
MSR. Sigh. That makes the whole mechanism useless for anything except
whole process SVA.

It also make it a general kernel problem and not just related to the
vIOMMU scenario.

> > I think at the uAPI level the callpaths that require allocating a
> > PASID from a group of RIDs should be explicit in their intention and
> > not implicitly rely on a certain allocator behavior.
> 
> The difficult part I see is, when one application establishes a path
> to one acclerator, we have no knowledge if its going to connect to a
> second, third or such. I don't see how this can work reasonably
> well. What if PASIDx is allocated for one, but the second RID its
> trying to attach already has this PASID allocated?

You mean like some kind of vIOMMU hot plug?

> > If you want to get a PASID that can be used with every RID on in your
> > /dev/ioasid then ask for that exactly.
> 
> Correct, but how does guest through vIOMMU driver communicate that intent so uAPI
> plumbing can do this? I mean architecturally via IOMMU interfaces? 

I would have to ask for a PASID that has the property it needs. You
are saying the property is even bigger than "usable on a group of
RIDs" but is actually "global for every RID and IOMMU in the system so
it can go into a MSR". Gross, but fine, ask for that explicitly when
allocating the PASID.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
