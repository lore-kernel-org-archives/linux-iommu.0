Return-Path: <SRS0=tsXo=JC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9118C43460
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 23:39:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C04561394
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 23:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C04561394
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D616040E8F;
	Mon,  5 Apr 2021 23:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmnf2rTm24Wb; Mon,  5 Apr 2021 23:39:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDF3840E98;
	Mon,  5 Apr 2021 23:39:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B188DC000C;
	Mon,  5 Apr 2021 23:39:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 928D8C000A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 23:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8087F60AA2
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 23:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ll-4Z-XcZnfN for <iommu@lists.linux-foundation.org>;
 Mon,  5 Apr 2021 23:39:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B268607B0
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 23:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Amy0g4njc12zhXlJ0F5sUuAXHrxGYwtQ3jjOyj1bUwffd1lQoTw6MOrw5PC6H/sMt35gTX02R50xqhuhsljOqFZShzBL2ki345CrCUciDM+k6Z9mbKdahqUMH9e8VBClGnCMn+lFFVFLAQ7D7KQupwDTSspiwe57k1CnqGY2z87RqFv5Tii6O9ncsL3iRaOk30R5JX6pNcuOSOJPVx2MasxuMFBqwEzZSICZLwzJPg/dqLh7FMcGIqmvXqaFSh7sMgV2YxWEv4VSBVajBqu1V6qcWqrt5NibxxsOkynDVylyCvVzmPICwbM7P6fFdmXsPSLn2gPGIT9fJCCIoJ16mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VItadmgX2dxGoxYjA+QX+QYNDBSE3/WVd0dU9S7wdFA=;
 b=hNYtX7oPfZ6Km1p7cmooKhi/Os1D+LLaLOHKCc6kjDXDiH2S/4Q/oOpq/+uE5JDCyN9mNP+rPTnay6m1wO3EafeVBTn0JvDaL1OWIuj7ame3zk883qidEzWdTJcuIgiLBpEG2XcEZx7wYyOkgVFuC3axa2RMlSwE+r9DmuPrNvX9fz1DTVW2oEvRM9HxQrUOZJCxQQI6xMpxVrEcveZIZQPUhoEvU1COi8+ytjfJ8Sgvs5J/5hTD/Ijq5ki2cIFNSG/CPnA2eUeTt7ZDiH3HzkBNsCp9cOr7Gt37FKAXQHuv9RAV5xy8vs86pzis1TpcEGa0vGWlW16Z62mpDjGghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VItadmgX2dxGoxYjA+QX+QYNDBSE3/WVd0dU9S7wdFA=;
 b=FZyRYH7nA6NCglXItm1REQHkMzVXZAFes5fpasMgm8X7DZqw42yngPWgNztmFdDGCkOkz9Gis9oRgzGxIUwL9RzcUAfJNapjIP+HoVsajjL8O2UxBdIQgegoxjY4l1aQ8UY2b15WQY/91+nAmOgahUETosMli7pityI/LXZp+rWEa4xfCJE/Iku35kSdlJdcXPbC8k40j/vYlioK6QRRiXLR2zSU3BmHYGr7lCFWG8ez8riDetCEiIoZtZEz+srHoP7EHkRTniPEdj8N5dKXPjjJJjTDF6EZWDbHYbaFhHwf0Nslb/SfhRDLNIdIgaOQaKPoq40YwQPikadoKARgjQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 23:39:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:39:48 +0000
Date: Mon, 5 Apr 2021 20:39:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210405233946.GE7405@nvidia.com>
References: <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
 <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:236::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Mon, 5 Apr 2021 23:39:48 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lTYos-000x0b-SP; Mon, 05 Apr 2021 20:39:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0979f5d9-3b1a-475f-d9b3-08d8f88c19b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43560FED819C81F5DED380BBC2779@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E63I9Nn0g+IIykaGvEwtdV1iVNG1FcxSTlwLfExnkZenIeP6mRSyQ6LI6tPtG3AXxah05ykII3zT20OtDagzhX6pjUnSZlNN0hUILI8DuV2k9n0nqwo+YkOzUvCIIO3QPjUIyND5uO6h2fxgzPOicAHfa8bCkemyQpJ/XoWEykaSIW8RAuUrx9w/yyNc+IpdXJ2Zu2jFBamQziJ8BiQWRmIOvs6ZyVZW1h5V5rhXKqrjqSRRB8mxksiwbqOtiGfquB/XxA0Xi0+6MDWdzMbMyqAc1kAE837O17x/0lvJD/jUSLgG6qDd2AI2USqz7C7HSJAlKS6r5gOhHGb0+IkqOsR/a9ERzrhMTdi9X0hagFnbKjxK8++H0ztfceXS2ZmforC0wbNVCXTgPGN2u1iAi0ZhOjmdKhWZdr03G+hMuw/jTjd9Xo13PQ3cbZSCLkFj0m7r2sT59rRMwbUdaM4z1MOZ0DOx6JeesnFGRR6rfFab3tro6SQB3sO5NMg1swera/9C+gcHHgeEng8SaDj9upiYZ6k1v8vrzEbYEj6G1NYRQ+L34f26wVbtjHgc3ZyAgzDV16h/2OPHghLSxUm9beAGWw3UfXUBZNjTDCxj/h2FPByaOaD0qqawOQK4OMo9I9T03nl740NpHJyXJfZiCPTiMueDRUB2UfRr7Z83r7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(8936002)(86362001)(6916009)(4326008)(38100700001)(66476007)(8676002)(1076003)(186003)(33656002)(9746002)(5660300002)(66556008)(426003)(26005)(66946007)(316002)(2616005)(2906002)(36756003)(83380400001)(54906003)(9786002)(7416002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eSdJyiqu6yrmRUMOpASlQ5fgQCb0boc3bWdAcPfz+Jepri+KwCIa/cnUYxW6?=
 =?us-ascii?Q?ah8ZNTaJctZglbTBP7b2/iGhwWPYHl26Ubqvf1BHogOOYAfLi/ss8GwCl5fK?=
 =?us-ascii?Q?G6eKahVHj9WN0wRHxYkpf8CVbyaFddNKhP4vhxthWEYg/ErZdNev/IxuLyzh?=
 =?us-ascii?Q?njT0DVhJTVRmMXjwfrNfaWrGSN4AUxj/A0s1DDIAvO1Dt59PXyvGdccw5TJB?=
 =?us-ascii?Q?Gr2vl5Fx4EKsphA+zyfmQYfh0cHUpV8+oQCYySVRLpxDKxWhjoUt44aJFMxl?=
 =?us-ascii?Q?FMi47OBCpkgLhLUpmbYbx86o/XyLcFCfjUG6pIeRzXTM+t/t+Yw2Ar6geT4a?=
 =?us-ascii?Q?fXsEtNvt4X1ftI4s2Wr6PZVQoe/RMO6pbkbqzv2ei94W41Q8WRNpactBWQPI?=
 =?us-ascii?Q?jBmkeOrvuY7UHORnUn+0Ih+sqeLyW96dE5IAq6XD4OJDPYKzw0tey5Pns/JF?=
 =?us-ascii?Q?rOlifFzUCrmVtXG0GKkpjSK2LKKE/RTt1JIP5ebogpy+bslLhtceHLlYAdjv?=
 =?us-ascii?Q?2WEqkTG6V6bPtJ9Un7edvlYGHBDP0xU10OS851996Ux2c6JKm04p8uCru8Mv?=
 =?us-ascii?Q?BzCRwZYyb5qMFnQh2MBzTcA++ECyKg28KTXph0kRARBk2WYzFxmw8UkezDXz?=
 =?us-ascii?Q?vWDz7crX/PWf2fdyYO0DDe0/ZP4ga2Mng5emCKlZfC0U37RxajIV5GuOEt0S?=
 =?us-ascii?Q?8DG4n6sCp3AkYwyVDSTRu2fPcES7iUHUcoEX0N0yAYuqGMEXJR8sPHTkcynU?=
 =?us-ascii?Q?8TF4CNXCIQOEbxhv5EEFaF7ixegL1HWLb5praM1zdomdOMkLtbVUbfQOsNvQ?=
 =?us-ascii?Q?iZZMqFcacfM3EqK/HD2ufLvNSdvPa6hkqmnfFtns+XyAAezPRS5e05lfVEHm?=
 =?us-ascii?Q?M3RNSBSaIiP5dXD+Q8ylqD2VBUBosxgSajoqypDOXVDd+9ncb2ZbVZFfKSX5?=
 =?us-ascii?Q?QymVqDnnKO/RJd9qBACl9/GPPhGlHkzdo0Et2nt5+tMih+1zo68izSYaKI9t?=
 =?us-ascii?Q?8k8/SCWN9Dj3ZHKYMpagM3VhkBPEmMSXAq6VfjMBlyNjcmqO7U6mhILgiuti?=
 =?us-ascii?Q?MH6R2J0VeU3XH1FuUET1yPM92c+4ZrgVlUG6+j01oBN7T/LCJV1oFMAaXVt1?=
 =?us-ascii?Q?fyZIjnJW/3rF9EPOWvKlj4DcT2vE5WC2BL7uSq82HnA3QQmMDtTCcq7t4IGd?=
 =?us-ascii?Q?PsrmuhgaXuY4fAU10es+0oTcmuXVhdUg9hgpvyNfCWaaIcx00v2fYSWmb07m?=
 =?us-ascii?Q?JZJTC9wC9AXHQkI/pPB3Lh4Sti+lz7t/qm/JHNy32+mtSmLYfm7tFkF8UhYr?=
 =?us-ascii?Q?VA89cJfU1HnsbmiQXD3WMrxocNyKSrO7fKV7wmvCA1OQQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0979f5d9-3b1a-475f-d9b3-08d8f88c19b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:39:48.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJnDbP0pb1QDylN0SdPO30R9ENG/qg/a6d1HlIDbPPtSSLCAC45kzZCEw+3fc86C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On Fri, Apr 02, 2021 at 07:58:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, April 1, 2021 9:47 PM
> > 
> > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > >
> > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > [...]
> > > > > > I'm worried Intel views the only use of PASID in a guest is with
> > > > > > ENQCMD, but that is not consistent with the industry. We need to see
> > > > > > normal nested PASID support with assigned PCI VFs.
> > > > >
> > > > > I'm not quire flow here. Intel also allows PASID usage in guest without
> > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > > > ENQCMD.
> > > >
> > > > Then you need all the parts, the hypervisor calls from the vIOMMU, and
> > > > you can't really use a vPASID.
> > >
> > > This is a diagram shows the vSVA setup.
> > 
> > I'm not talking only about vSVA. Generic PASID support with arbitary
> > mappings.
> > 
> > And how do you deal with the vPASID vs pPASID issue if the system has
> > a mix of physical devices and mdevs?
> > 
> 
> We plan to support two schemes. One is vPASID identity-mapped to
> pPASID then the mixed scenario just works, with the limitation of 
> lacking of live migration support. The other is non-identity-mapped 
> scheme, where live migration is supported but physical devices and 
> mdevs should not be mixed in one VM if both expose SVA capability 
> (requires some filtering check in Qemu). 

That just becomes "block vPASID support if any device that
doesn't use ENQCMD is plugged into the guest"

Which needs a special VFIO capability of some kind so qemu knows to
block it. This really needs to all be layed out together so someone
can understand it :(

Why doesn't the siov cookbook explaining this stuff??

> We hope the /dev/ioasid can support both schemes, with the minimal
> requirement of allowing userspace to tag a vPASID to a pPASID and
> allowing mdev to translate vPASID into pPASID, i.e. not assuming that
> the guest will always use pPASID.

What I'm a unclear of is if /dev/ioasid even needs to care about
vPASID or if vPASID is just a hidden artifact of the KVM connection to
setup the translation table and the vIOMMU driver in qemu.

Since the physical HW never sees the vPASID I'm inclined to think the
latter.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
