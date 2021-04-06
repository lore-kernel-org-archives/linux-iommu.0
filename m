Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F718C43460
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150A4613BD
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150A4613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3A6640519;
	Tue,  6 Apr 2021 12:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bDVS9eAzlAG; Tue,  6 Apr 2021 12:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65B4D401F7;
	Tue,  6 Apr 2021 12:21:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B438C000C;
	Tue,  6 Apr 2021 12:21:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D2BC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F5AC40517
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQEuQUC8ArUm for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 12:21:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE3EB401F7
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ2v00lvkU7+2xWlE9kl641naytLHUtAaJBQHE6GBAwvfPZ1PLMFXA7ip2d+sWkN1PNAaVIDu8pRW4pj9htzyVuH8PxaCJ7RNWZ4ZjrvS8b9i/B3pswK0mjsGaVX/H6Fq0aH+s2A0++DA40E2JFqaJpQytLG0cZm0YEttUQrMGfUc5JyCLdcrHybUMY1IhUtaGP6B1IFo2Kbl+UxekJKYDmOqX3Lp/yfojAB8md0G2tdvaOPoxYyyTOyZH3y/aKGIQRR7AzKsxe6LSP+2pVEJ0XyCAh+Bz3vdyvhpO7+s0po5R31wgtPNIs7esCvG9D1PAaJkLDIcJJFOk8u2E8Eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/oT54Q4k4wleDks1dCIGA4AFa6WWiYAjS6/HnKe9XU=;
 b=ICxnqYxQSsGNPmUnCYQTptwjwmgrpj2DWejIwUcv3pxbS5feeQbjQj+IFz5q4Y5DFi8jf3+l9VrZNjBtSKX4UkkNcIxNLDWo6EczCF/z3clOhd2tXWkYfpSBWY2j9Ve789u9uCaHhgCP5VauyuAIEvEFfgHC9GUpiooNUuersj8ub5pIselaFfADlKEiRwpSDpGRv6bM+BorHiCSSkRZOljRoC5KSdl81AcWXl+qltBxihGxEgz+P9o66VfjYcNC9nKYfX2N4yIKIWI5OSIhhy6THuVDyhUiepDjS1avNWS1UiICWm3KLmFOxDJcq6g6UWabfN6t5zcqK/75EooNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/oT54Q4k4wleDks1dCIGA4AFa6WWiYAjS6/HnKe9XU=;
 b=UlybRfqMAQUqtRfJ8RvtUDKpILTok1S7P1oNfnaOVOkv8ZEpOhEvl46J0G9yZZ5gtS9SS4v9zIel+QWKY4z3w1WQiGNkQFK8mp96mws7hq0SCvdOoy7QVYaJDdoMZaa+w5or491C4plnyCFM4OexSt5L6TVJ/qd/X7l+X2tRTTr5Gd293+Go/fX2Gfg4mTTA0BqlpxQ9RgNzVVSC/V6FmmPPSRTqkE2RlQmMBstkzcFUsWCWmPQvxpHyLpHThzj/L4mLK7Opjit/A8haRyGtR8KsbbbUSo/Y+BvQEt+59unyVIktyrKv3QKLdb14zfIeB+gMrkNLAzXsB7ANsaIL3w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 12:21:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 12:21:20 +0000
Date: Tue, 6 Apr 2021 09:21:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210406122117.GM7405@nvidia.com>
References: <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
 <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233946.GE7405@nvidia.com>
 <MWHPR11MB18863645C2C63A89BBA200B08C769@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18863645C2C63A89BBA200B08C769@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0347.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11 via Frontend
 Transport; Tue, 6 Apr 2021 12:21:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lTkhp-0016t1-V7; Tue, 06 Apr 2021 09:21:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b8dd700-d5ff-4369-2c1e-08d8f8f67bbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31145C81DEFEC01B1DE7724FC2769@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+p0+tHojXTJ4w9I8fgmuuyVKdPRIlkH2SIb+YoPz8y0FLFMeot+Zu0wzxxlrp8knwTWwZ5C7DQ0kbmx4MnY+Fw98WnLWrblBRtdcoJ5rL9PkDbikITwEMnFfIV2IIfAIlJasH9kEAoA2Ye/aysmmsuineaAkATMtV1a/8DBfY9CH1asGL6MO1SdmmSy6oMbQkcewf3XxYZZzSJ1qtQffERjwMDdCim6sF1weVsacf/N65mY1UznIiNIMQxZN07PWd2VrdtwJrDa53nJHseEfPtejPTb/gRKeGtXSR47eHaxXyc4P94xN4fc+DfnNCUs3DOwZQVXvkFWHx/drwUR0zioXYWTAbZmcJwPSGMST4IQZGJoNQqqJLI4LIsw7zohxtOFKrK9TooU5qIc98z8jL0wBcdRb771UNgtoGEYqPyUoDzeyqIVo9ggeXEpBEU5wn+M1/9Ze2o/VC0V7ZFHcDNOJUI9gpTgi2pNhGUK87Jj6GO3gCKfxagjbo7Ga9U9CDBEOl31EaLqNLxO/a622pgvbm/zTHzULu7exWyRZ7LkKE25dVM/wlpdOmC0RieGAfUtgGo6p5GyxfMPx3SzXHEHb57CW6RvaTmM5lR/Nsp3sx6bXnitZcI8F7SklEIHX2i5dsX7ppuwycZpr/x276v+v9tL/j8o/UwUd59djQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(26005)(5660300002)(6916009)(1076003)(7416002)(478600001)(38100700001)(83380400001)(66476007)(66556008)(426003)(2616005)(186003)(54906003)(4326008)(86362001)(9786002)(316002)(8676002)(33656002)(2906002)(66946007)(9746002)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9eXOHHzWnTa1MwyN8LH70ZFrS3ajKbT9gDg4mmexYH2QzQgpI/vDD2Vxa78I?=
 =?us-ascii?Q?x3vNaoNLbsdUKRlqORigD9Upf0tHDWH8E78/M85jGpMS/X0e094WF3TVNvK8?=
 =?us-ascii?Q?UQ1zweRDDD8tXdrP6MJSRK4QVirSjgbxC+qtwnO68PJ9sN5CbK5rkJ81Cmw8?=
 =?us-ascii?Q?WJSCGlgGBgIFKX9JWWqcY1rTodYVFQpA2cAZzaf/DwP5aTKVWz0BuE8WoPFD?=
 =?us-ascii?Q?rZLlS+pgdeRR+wXGohODLdaJfyWQLS+rwFLjUq8IW4hY+RJnpPAVacrJL0EZ?=
 =?us-ascii?Q?ykFCHfCD8enGbYWcL9eXQBiNvb79VK+qAPKCxso2/6rHgoKY9azgwLrAUCdI?=
 =?us-ascii?Q?SYCTBE3UQnC+eVertAt1bZus+W92oyEJj3gB2RpfKa4I5zQvx+aXnifE7hrc?=
 =?us-ascii?Q?3Teb+29BOE4bKXM3PmfmFedXJdrUHRAiiH2jnS0G1mqOuoVz4u940cHL+xoV?=
 =?us-ascii?Q?55A22qB9F0RWhg5A+ay7MumWh0wrzV6+vN6SxNULQcGQf5cRWybO9ndv1vRr?=
 =?us-ascii?Q?jvsXW+6G7K4UGiJfmUMnB4Mcn3WUPjW6mpbW1uzRXyVtNWWQRO82TyJ7/Wfu?=
 =?us-ascii?Q?qUOBOFjMnJncqcMj2eNTUS/rQEAfPmrA3iblcD/SFnAaprFmRjsqWms01P0P?=
 =?us-ascii?Q?QrEv8lRqdkC9Nqao3RlRFItpn4PzD/wdrPBSvH+kEZ0akuc25gBX49tOHEOe?=
 =?us-ascii?Q?xfEJ/WNJI6Bqr6yzKvK+7eItM8xCpfSjlm2Yb9LlfUNihmo5acS3CkwkAFNi?=
 =?us-ascii?Q?Am3t2C/MBzBqjaCFbfsyZ3MsWuwbbKLQly2VGY8XEg9uLIMV28PRatZk9EWZ?=
 =?us-ascii?Q?7/8wxEPaJi1hL2+0oQleXsm/vTWkwcaWgNOe2MHu0LSZRQFJoi5Eklheb7rC?=
 =?us-ascii?Q?SRgVG9fYNzGbkhqwJEa/qTvxQK9wNIeUKXY7UxYU6/XRQVtVFaDLtpAX32RE?=
 =?us-ascii?Q?vv9UF4LEjl/cGWZj/DNsGv8i/0/8q5EqCjvy/btus49ysvyRMfYbSm2D1L8o?=
 =?us-ascii?Q?iSxoGNfMS19ntKT17e20vBfp9TbnDFsLY1g96AAloGgVjftXPWO9HYeYqcmm?=
 =?us-ascii?Q?hUMmxls0+KhwaliJ+7Fao6GVfCWBg5dpaWCqVbi1Tso0n7O5494U9XvQIjGS?=
 =?us-ascii?Q?mtH3uPOZS3tdnJvIuLjqssIh6BdiuwTdAzoxgk95opEA6g6fmtFDur9uI4Ei?=
 =?us-ascii?Q?uwNRR1N6o/Isw/PoGEtQdUz1Wpys4JIK4PQMDbs0WkWPOfSNVlW+nQr2UyDg?=
 =?us-ascii?Q?04CnPA3+jgmWXVvqyzHbTnDi9Kj48fgxb/xvx0JqNYQ08998lvNcURfm/OfE?=
 =?us-ascii?Q?oyHw7O9L5ufwniHoH/K52GM7B3DOYszLEtWDwZpg/5Gojw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8dd700-d5ff-4369-2c1e-08d8f8f67bbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:21:20.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgkrwI8cRr8DMz92H3lONU//gW2/op+i7kctbZxfwplW1ZHJQeinAr3Tap58ljQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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

On Tue, Apr 06, 2021 at 01:02:05AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, April 6, 2021 7:40 AM
> > 
> > On Fri, Apr 02, 2021 at 07:58:02AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, April 1, 2021 9:47 PM
> > > >
> > > > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > > > >
> > > > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > > > [...]
> > > > > > > > I'm worried Intel views the only use of PASID in a guest is with
> > > > > > > > ENQCMD, but that is not consistent with the industry. We need to
> > see
> > > > > > > > normal nested PASID support with assigned PCI VFs.
> > > > > > >
> > > > > > > I'm not quire flow here. Intel also allows PASID usage in guest
> > without
> > > > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > > > > > ENQCMD.
> > > > > >
> > > > > > Then you need all the parts, the hypervisor calls from the vIOMMU,
> > and
> > > > > > you can't really use a vPASID.
> > > > >
> > > > > This is a diagram shows the vSVA setup.
> > > >
> > > > I'm not talking only about vSVA. Generic PASID support with arbitary
> > > > mappings.
> > > >
> > > > And how do you deal with the vPASID vs pPASID issue if the system has
> > > > a mix of physical devices and mdevs?
> > > >
> > >
> > > We plan to support two schemes. One is vPASID identity-mapped to
> > > pPASID then the mixed scenario just works, with the limitation of
> > > lacking of live migration support. The other is non-identity-mapped
> > > scheme, where live migration is supported but physical devices and
> > > mdevs should not be mixed in one VM if both expose SVA capability
> > > (requires some filtering check in Qemu).
> > 
> > That just becomes "block vPASID support if any device that
> > doesn't use ENQCMD is plugged into the guest"
> 
> The limitation is only for physical device. and in reality it is not that
> bad. To support live migration with physical device we anyway need 
> additional work to migrate the device state (e.g. based on Max's work), 
> then it's not unreasonable to also mediate guest programming of 
> device specific PASID register to enable vPASID (need to translate in
> the whole VM lifespan but likely is not a hot path).

IMHO that is pretty unreasonable.. More likely we end up with vPASID
tables in each migratable device like KVM has.

> > Which needs a special VFIO capability of some kind so qemu knows to
> > block it. This really needs to all be layed out together so someone
> > can understand it :(
> 
> Or could simply based on whether the VFIO device supports live migration.

You need to define affirmative caps that indicate that vPASID will be
supported by the VFIO device.

> > Why doesn't the siov cookbook explaining this stuff??
> > 
> > > We hope the /dev/ioasid can support both schemes, with the minimal
> > > requirement of allowing userspace to tag a vPASID to a pPASID and
> > > allowing mdev to translate vPASID into pPASID, i.e. not assuming that
> > > the guest will always use pPASID.
> > 
> > What I'm a unclear of is if /dev/ioasid even needs to care about
> > vPASID or if vPASID is just a hidden artifact of the KVM connection to
> > setup the translation table and the vIOMMU driver in qemu.
> 
> Not just for KVM. Also required by mdev, which needs to translate
> vPASID into pPASID when ENQCMD is not used.

Do we have any mdev's that will do this?

> should only care about the operations related to pPASID. VFIO could
> carry vPASID information to mdev.

It depends how common this is, I suppose

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
