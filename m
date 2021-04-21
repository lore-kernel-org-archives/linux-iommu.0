Return-Path: <SRS0=vV0e=JS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C1C433B4
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 16:23:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803AC61445
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 16:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803AC61445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1456760D4B;
	Wed, 21 Apr 2021 16:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WiNDCcleTN8e; Wed, 21 Apr 2021 16:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2797D60C1B;
	Wed, 21 Apr 2021 16:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B88CC000E;
	Wed, 21 Apr 2021 16:23:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06FA5C000B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 16:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBF9D83E81
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 16:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jI1FePNj_pfv for <iommu@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 16:23:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DF4983E6F
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 16:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuXTEVv1Y0GqIXzoMlRDIURUc3hSlMSUFFDekkVGhumg9pLYhiX7BQVs/jZoUSYx5GQ/MtvVQ5ipJ5A0rU79J9WBMdOW3jtfpROe5VRtxLBJcuQx66NhbYXTlJU2ZbYFt2w+v9JCBstiR9hwDfL/MULU1jqnA5OUagAGInWcK46o5KxNjyMoRaIS/agL+v3SUu/QS1v741PEY//893Y/iRj00jav9jW9qpY2txaG1DBEezl4DipdaxSBFhygbISl53U/YSwmLpT3qTq+JZPv0VipOE70izsrDMbtw85K1XZv8nBClv7CZL/PFNXmQ0NWVOF6GL2OnYckT0UEQGJ/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEGO5RBH2sUPVwBKyxNAKyTj+IAAzSfo5YCvm0bhJlw=;
 b=B0W9gQFBRQPc499dXKQvbCxKdjrH/Eew16Lnpqn7eeLy1jlwycSEwdUloGv5YdExKYEi2b5184dT5c3LALprWrSfsahfsgX9WMsIY2ibAKXeuomUO0V3XpBnbWLmsGC3RtM90VrnSVrtTNy/VdtXRm9X7wjSGs8cMtVzpGBqSi1EM95IGdUyTkI0/FRzQPr7VOkRtux+CZoj2Q7RKYCQ+glwFcVVOl5Rb+b2T3BZ9xA09CSiWs5ask5Wp7ML/bqU3bd39Ar5WN77ceDYxACBMwXZjFI8Abmlaf16hC7GLItVmj2PUeXRXko/zpzCJvWCFx0H0yryD5st9y2Apk8rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEGO5RBH2sUPVwBKyxNAKyTj+IAAzSfo5YCvm0bhJlw=;
 b=eorlwqlCxDaqTuZ0DJjUBD99utiknW2TLDUz5dND62Q8elQZ+quB5a/HgFG4el2Txn6567duLfRKwp9rxCQrla+mP2uSH3Rz0yZVy13LcDTvylejXwjrTGrYzsLEtGu++rBqXK9jfg+U2LA7Ac2NFIRulOIabcHRjJcOlnJkEkLxfmtOOyIXfCAHpcmAZoD9qG9PgOqAiwudCpXYRUkRfgXsxVwUoI6g1QgMvx86u6FELlbgASm/Lgzl3GaAMoPJqxRz2WHcosHelqtyd2qRuQk/VgNld5XX5jvbxrrSO/WkYy2BO/zBlBb/R1WwYYYZRmOD7OCcwEBLMsUZg1/Jyw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 16:23:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:23:10 +0000
Date: Wed, 21 Apr 2021 13:23:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210421162307.GM1370958@nvidia.com>
References: <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0045.prod.exchangelabs.com
 (2603:10b6:208:25::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL0PR0102CA0045.prod.exchangelabs.com (2603:10b6:208:25::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 16:23:09 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZFd6-009ZAu-0G; Wed, 21 Apr 2021 13:23:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a321fdd-e120-4ac0-c64b-08d904e1c0a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38367045C1A2C24561ABE842C2479@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01Q4kWmeSLblzAjMWqYpvTgb/kvy3qGdqEH/3HdirPg45z4ejMbCzUFmOgmcZD2e6oxZnrZ2LF3n0IcX7fQD/rAHCYgUnDpBS8mOmG0+eag0dJtZ6o8A7ECWNqMXsS+t7uNnP0iY+2fWblhv0W+aQAiGlu5X/cDtCBOIZ/SCyVWbjUl99EDAi8m9rk1EaxsQj9oROvIechMaUyhkyhuoCt7NmICogUvL4rjY7WZCizHwnQN7OAP1WuBObVu6S+C17OvavkC7DSFvfLCAPnsUuTfA0BiVHfnsBnfgQCMXj5rcJQRnBS7l01ouBmNn2y7MamYPgqV13paSNcYzJue/OMUp4PUOvS5saRpK/aINrbUoqLFvGQS+0/gEqjQOL/ia4muXmMVFO8BQBLNGPEc5jkxD4iOYmzysP+Sby2ac70sTLtDnh9E+MhufvtpUB051NKNkvqdTkyHiufX52GRwif5/JbaWD3j/LYFaD/fDjh6OBT5JTcOs+Q5OK1wVc6NLThpsEUJ+M0nAFwL8Iqf1qBcZlGWhS1kfCuPtIGjqp1hivdWOmqo2CFZF7Ny/x0DzyqzqVMtfTU7/x1epWRL7I9oU3sNlfqiDk9aUQIZDfSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(186003)(2906002)(66946007)(6916009)(54906003)(38100700002)(4326008)(36756003)(2616005)(498600001)(5660300002)(1076003)(426003)(7416002)(8936002)(33656002)(86362001)(9746002)(9786002)(66476007)(66556008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qdy0coNKdRurIChXR9HQhxppNZ3s1SRpNd0IiY6rxzJeeBcsAJr6Ng2tM0xs?=
 =?us-ascii?Q?Kv8O+A9NTR3Xc7nLgTzqTaWCuHcJqZN/8Am6Xxks6hD32tAZuKCamln4Cyh+?=
 =?us-ascii?Q?gzUosEX4gTERBCsE+nuOgZVLDffuoaOPHMifPP8edApaQJ6RUMfeoYRgUyZn?=
 =?us-ascii?Q?tNP8ua3ql7JDlLnA7R8W3hVXfeMTdP8On4mylNrNk1xSSK7Pb1vjCzt3S8ZG?=
 =?us-ascii?Q?81GN4cce/yKlQuM1wTwAwgz3O4Eu7YgVT4PZeIZiXv3oyo9Y6xERus0GTDUN?=
 =?us-ascii?Q?dyE29MQjbNZHvJejHVhXKhjJ7unPpfH/EsPUcX0fX1+UqMERwYI3ZwdInNBc?=
 =?us-ascii?Q?GLgOacSARdJ/hEM1f6F0G2ye/T048s0yDFj6AKr6sCK6At1dD+nzYaoDWMPk?=
 =?us-ascii?Q?d55rrbf1vhtCSjJkPSLLr8/ZppFqZzMIZpFrZXdRHfotIER852viRbzJw07d?=
 =?us-ascii?Q?TS8ry4tRZnrX2BvJdHUSMiMd+Nx4jz/VheJ1vEdVovrDi3OpWIWq7SJPZkEK?=
 =?us-ascii?Q?yjbNYji2y+m7FitxAynlM0B6fSLj4m/KRyF806+svApcg7UAESeiNCmp/kfo?=
 =?us-ascii?Q?PyL8q1ekFkFwcrd/DB1fQkj5kKIDJEKuCQBTsxMmrOIp7FOJQJXaylUX8GiK?=
 =?us-ascii?Q?vEPj2FRQR65OkAbRpnRO+s82NUSF57VgYqjY+CQlvIY0nGPTztTwLRsuq8VI?=
 =?us-ascii?Q?0wFLGvKIso9VAdLlpD3rKLOTS/BSJHxTxI+uYa1w8KiWTKZ17mzcT7VFkb4D?=
 =?us-ascii?Q?zzE9tZlQ+seo744zlei8+mYAQB7qUB996/LUgTOw7ZRJS+nDuc/FyOYkWMrb?=
 =?us-ascii?Q?oilqQ8uLvMK+YybzO56tocNn4CcsbnlVG1v2aVF1heko3RscsOvvBfASFlw+?=
 =?us-ascii?Q?1LXN4Jaxfer6EDyC+42ulhxcASAm3XLoEd7agirvP/29qmCPQT361vXpcqmO?=
 =?us-ascii?Q?bVmZLExlxGvM7ucxtd1cggkQWXQg4FiWBCCQzDw6dRghyUSZGx6bpzBmAXEN?=
 =?us-ascii?Q?PYwhvwr64qgMMHE5cWMoF6s+3QPVIDTw6v5IUBKZLQqO5QrbOQnWfcyIFMtP?=
 =?us-ascii?Q?ujdi2JidBI02P2iqwW0C0fJSXX4h0G+895mhXF5gR9rtRZk0MVdb7XHL4RNB?=
 =?us-ascii?Q?TDt0BlXwmlAwnzQJbG/ZFGmV0YS6/Dxd/4BoJnP8YE4jXKgTObaT90HtUYc2?=
 =?us-ascii?Q?uOFqXkMQjPKGWlY3ygblp2UBawysVRAluZAJTX/L/y1s9zpVctYT/j/qRgJa?=
 =?us-ascii?Q?JqrK/CEO4tqxmHLzNioslPzfePRKKBon5hZYx5jcXJ3bnpun/SA7H4rN7H82?=
 =?us-ascii?Q?rbgYPSgbb5ISBSzIq5G56bupuXJ9lGrLgYgvoxfLhCOCFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a321fdd-e120-4ac0-c64b-08d904e1c0a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:23:09.9658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxPn8dhETmYHugFZLcw9YG1cg5R3yYee7TeJYniRcqJ/i6FqSY3Zw0jjxh3RYnl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
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

On Wed, Apr 21, 2021 at 01:18:07PM +0000, Liu, Yi L wrote:
> > Ideally this new /dev/ioasid interface, and making use of it as a VFIO
> > IOMMU backend, should replace type1. 
> 
> yeah, just a double check, I think this also requires a new set of uAPIs
> (e.g. new MAP/UNMAP), which means the current VFIO IOMMU type1 related ioctls
> would be deprecated in future. right?

This is something to think about, it might make sense to run the
current ioctls in some "compat" mode under /dev/ioasid just to make
migration easier

In this sense /dev/ioasid would be a container that holds multiple
IOASIDs and every new format ioctl specifies the IOASID to operate
on. The legacy ioctls would use some default IOASID but otherwise act
the same.

I'm assuming here there is nothing especially wrong with the /dev/vfio
interface beyond being in the wrong place in the kernel and not
supporting multiple IOASIDs?

Then there may be a fairly simple approch to just make /dev/vfio ==
/dev/ioasid, at least for type 1.

By this I mean we could have the new /dev/ioasid code take over the
/dev/vfio char dev and present both interfaces, but with the same
fops.

The VFIO code would have to remain somehow to support PPC until
someone from ppc world migrates the SPAPR_TCE to use the kernel's new
common IOMMU framework instead of the arch specialty thing it does
now. But it can at least be compile disabled on everything except ppc.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
