Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B940C4708D
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 20:03:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CBD613D1
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 20:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CBD613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 864E3608E8;
	Fri, 28 May 2021 20:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5hlrIV6kMf4; Fri, 28 May 2021 20:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31A35608E7;
	Fri, 28 May 2021 20:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 074DEC000D;
	Fri, 28 May 2021 20:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 086A8C0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBA0F4033F
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lGj76v2DMPM for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 20:03:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8032A400D4
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPpw/Oi0qjY0sOB2ATYpKyUyery9f26M9asf61zpZ2M3EE4yGg7mnlD4hhVi1Djrfl75A0EghoP9RJRwyBiqW3ApOG9QFNJS4cTdaKWBUG/oud5W+izuybIsN8e+790GVkAhm+Hx6QT7mRAZ8Iqs/JYTMoqf1fe2VrJNvhCt0rlJijjJdd6QlGZBnHKt9cjx6NtphhwIyJ8t2Bzw68XD7eYtB5lO9dKeH4FgM8PaGgA7irhajRz7zZBRieRk55QPujN73m3nenK6U19MabPeBGQSO+fdDe9OIWx49bJ2AFUiE1vAFXheblIMH3J6R7YyCpAjOtknNjpR/pzCc9Rqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbtmhyOnbL5DT5+UgUZWKq4GLzWKrrVP/zOucFUdycc=;
 b=kecdQZzR9Usf66vJjo0BdFK9pfBWMcee2NFPcjd9cK+6lyVVOhwLzQki+9dwNIB3Bc0wvkMuTzuiQC3kh2Sxb7aJIUV0+rzr39WWM0DY6iuJGSjnl+sh9wcOHkXmeamVPWSyGLsWlkBzma6ySd4Y+JA9yHRqiGgSPZCWlFai8mtenxXULBrVHqLGZ4jwfzrn62lxCYpsdsSmJAOhwOKx/A4rcRgGlaQ2mfiJSrO1SZaLEeQFnliuFuV1bmGKVH7mQYR4FrXQVBLjOff1fhtFTX/7BGHjOWrQuJqxRdf9JIrvSxPg6UvvvdjkM1fV5bwjqqcxnXjQSd05N++GVrth0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbtmhyOnbL5DT5+UgUZWKq4GLzWKrrVP/zOucFUdycc=;
 b=jiO+3Avl1gThLWDLV/Ozes9yBzIjv7q/D653KdgWJnf5ub3Wv5lOZdV1p8I0y1nmDMlhf5wkjp3TmY7Br6qe0sNQ866LBIXtCqqPdxk5EoP9mKjkIKVitzUgHm8e+nBZ/DmssQ5q01glI3h4RRG+8WVCoAw10CkT2AgG+490tRXW5BkzAYSpegohtN6CpKXqTOK8tglGwZNoGejj/ImcRPyXd9T7COqBJuERMw421LAQiceD1ifd95GZ5Avm4amPpOYE5iYthDDPFNDvwFdfbHYG9Gq2J5HfXcTC5nFiOvTxp1Q9sVhp6CRFvHRYNpPbBfgtE45TST97cxGEHJzgmg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 20:03:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 20:03:12 +0000
Date: Fri, 28 May 2021 17:03:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210528200311.GP1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR02CA0127.namprd02.prod.outlook.com (2603:10b6:208:35::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 20:03:12 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lmihL-00G3ty-C0; Fri, 28 May 2021 17:03:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d721bf-4603-4641-c3fc-08d922139f4e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB517301F23BB3CD079782F3C8C2229@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WFcNVQeH2ebbub5LSGh2CHrZAO3GG2tWZ0ELuaGnUlsFeMNxHKqxMMe3swUDgmdiIDO0XqAfypKp7j6oVwnK7hLT3yaM+6/5FrL+WWbK6i5fi2c8kNMkRk2LdE/n4eguuGVBbu00Li9mUQo2QZNkBj2mYiHFD8vE5ton8O0NGYqwrOGFk3gQOK0RMsOdCI5n6Zbo/py4H4ZD3KDrogmCJaRId2QlmLyfzRx13UCizrmmMtmoO58eDI24sGPu60lnai3vjAZeyu/xRVPK1jQb68Rgp2YxtX0bGkr5tc7YSCLSoD27Zx/i9N32EfKf4OUEFY1azlO8F0/IvblRyHVQ/O1smy4mAAH4JclR6XXk6yhu/DS+Y7PR/0pbmm4lGqIg6pCJPl1awmjhBrR3vsLdtnjhKpxsNmMv0mJCbUIohn1oRYd60MAdm3CzUUQK+FLM1pB9hy8cUI2qJjON7AmYPxI8CurCI6YJLPwOrWpYZu+C/EoI4IgOwi4wBgBCZURR3C5VUXNs4DQ3rso40TO59IVSh1JlSPdieeh1EfB2zLhK2fZpKfXxPKg8BUQzH61DP4/RYORb05JaZX0MrYkxUf/n6j0ceo9wGR3h5Bfhgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(7416002)(86362001)(4326008)(83380400001)(8936002)(4744005)(33656002)(6916009)(186003)(5660300002)(9786002)(426003)(9746002)(316002)(66946007)(66556008)(66476007)(26005)(36756003)(1076003)(54906003)(2906002)(8676002)(38100700002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hPRmwoQa/rNMo9AaurBrWqlBdF+TIhhb/prTgQHvLnm5aIQ7s+XkqgoZENwF?=
 =?us-ascii?Q?MFldTHBqQ/YOv7j8EFMFRvs9LQDaaf672J5Lgrf4tiSX7pO64nobHrCgpxVs?=
 =?us-ascii?Q?v/a4jm3Zpp9Ff+8VWSIUqSAU8RfpYJbBmi4kR3KC5u4WK0oVLVidU8UL/BkG?=
 =?us-ascii?Q?5npZZ+j2YMIcwrWARxmtyWuKMcbxoWv1IxbIHPKc8WXzxwg6q1cS90xN+Jfy?=
 =?us-ascii?Q?ofbbndu4nNXcdkFKinyUeArlV4nRzroEImE1jA8nK3pqfk+rkSGh3m4FIfHg?=
 =?us-ascii?Q?iPZ9ctoz4GEliK0TAr8dNVTabUG0s6iAZlkeQM2IxAk4OKxRLQ4PObcVBJPg?=
 =?us-ascii?Q?cgRNslvK/9BkgqbPTo3VRjgKHvhNPTGrPyyhZ7N+KpoQOIHfvTAj8xFdtIQq?=
 =?us-ascii?Q?e7rO4ymnZpDSFQ/6fWa/aT7fjPOvjyGUv5rxoFm2xdiT7c/FLOwJUV6rmCmT?=
 =?us-ascii?Q?BiVzcQcxKY+q7/ZS8xBbDMX9Ilk/s6fkBqwpapFcAQvDL0pivN5VwEiBtL5j?=
 =?us-ascii?Q?wNwlz1NmB+Cxtz5Rg9QjLbIAUx6pL0GB86sa7VVYG0FcxQRh3AEQGflnNuqJ?=
 =?us-ascii?Q?XasVgCky2guIPhPSO9zB6kCvkXDGYK7DdE/XU29+En8xU4XNW85Fc0sj9TUA?=
 =?us-ascii?Q?WuXvgpL070h43BKn+UE8jx+7jUrX66JRapYNf+GGvZqDw5Gms//xtbx1BiAx?=
 =?us-ascii?Q?dSLgOhFCrXBPxVQ0R+L7KBstGLCj/G5pDrhc6iaU6ayGaMrziyvwFvrWs3T3?=
 =?us-ascii?Q?dHwfpcJXD0FV1RRhRrBvhOJ0nYHtjD6vw8sZ54h1JveN8bk6PqjqkTK9IEJm?=
 =?us-ascii?Q?zsXcJka6jZ39wpjrztyx8xF14adJSm+xMrwzlQ+RnewBxgKeY0KB2vg6Ek8i?=
 =?us-ascii?Q?Q2aaKnoudmrnKfcQTRWElkx3XKUNsNQP/i7VG7M4LklZNnq7C2IEmaabJFec?=
 =?us-ascii?Q?NTMenJG6NaZONcUpw7bljPUow7qSDIlcuBCbqyhf5cUsWQiqCAEQFhrlLRUo?=
 =?us-ascii?Q?jrKZ5oj8ab/MPIk7K4G7pbP9wChHdGRyT/YhSfuHMvBD99TI1z+kxUHzlBPe?=
 =?us-ascii?Q?IXhujW2NkB046l+zxeL1xH4KgnaFB6tVmJGcGZjQXFxNkh3ZZG94KJ8zrMkW?=
 =?us-ascii?Q?4yvXu8sEWfEQKA0wGSyhQjieIcpgqzBVBJiQQSGN0EhqRdAdRX+qa/Y4Qjw+?=
 =?us-ascii?Q?Fx5X5Uk3XC2Eqy6j8E0kjPoRRG61hejrsbP70wTBcGHMzRWbjlFd1fPCk7cK?=
 =?us-ascii?Q?Rx2owTAKgASaZ/g/dGt4uUxD0EVnhfNAoj94iaCzs3SYzsTJIeI8hNpsT5XK?=
 =?us-ascii?Q?wjWhBUvsUp2NvFV0CHRmsaTL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d721bf-4603-4641-c3fc-08d922139f4e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:03:12.3193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p66pGC01qGgOGOXlGj+JZ5L7GBDJxmU03ppFW9nfKoNxAh2nV/pegMP09tf7L6LL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> /dev/ioasid provides an unified interface for managing I/O page tables for 
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA, 
> etc.) are expected to use this interface instead of creating their own logic to 
> isolate untrusted device DMAs initiated by userspace. 

It is very long, but I think this has turned out quite well. It
certainly matches the basic sketch I had in my head when we were
talking about how to create vDPA devices a few years ago.

When you get down to the operations they all seem pretty common sense
and straightfoward. Create an IOASID. Connect to a device. Fill the
IOASID with pages somehow. Worry about PASID labeling.

It really is critical to get all the vendor IOMMU people to go over it
and see how their HW features map into this.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
