Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2031AC433B4
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 14:35:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E69610CB
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 14:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E69610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 449F840493;
	Fri, 16 Apr 2021 14:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fG_yZ5BtCtmd; Fri, 16 Apr 2021 14:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1CD4404AD;
	Fri, 16 Apr 2021 14:35:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79EBC000B;
	Fri, 16 Apr 2021 14:35:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1493EC000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 14:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFEB86065D
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 14:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UBLhJVoo8df for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 14:34:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E732A60645
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 14:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To442poxtQVzzFj1LTJo4j9IA88B8Se0RX3alZ0qLzE7svYCEDum9cOuck/1BR0F3Y+yfataM8SWKJFqnBQtpccvc7aNbJWL/WOKoADJdh7076lx7AOxfPvEnen4SzR/fovcXBY5wtL7Qgd4tZMEQrEViiQZNVscbtdylS1/+4gBSvSehYkswZnQEodaaooBbSXgdjBNdzppDl5TrRd/FfymobkHHMEbsqgJmUSaxebMJRrfqH5vs+Y7tOgDxs5aglMkrz7D3mulRPRrOwJ638b1yy5tW9Ck9xbPefmh4AiyNGN1c4NsROKaipMUVlAt9ZH3Iync+zh4s6dIBz7ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4LNGlrRsxG9zQEEEZa6+Bne03W6a9ickZfs5pg8nSg=;
 b=gi00f+Vj57ld6EOQ6lz3w1KdeEgV7CxG8ppnABSHblErEYrq7/T8le/OSmqcmozgefykYm9/Q+FjPy5y4JXTPvNjwflanZ/4YF2PZxqYrtmPFdoipIJGc29N8bW/gayH2QHa1fp9zb0bMLZicTZ8FbBYSxHEXBjxYoY0qTcur03fM/11HGN/FhD8iTkezlL/lEpTVc7BqWAX2fcRKSDNflu+9tnUjIEjXzhu46ZtBhQLrhLJ7APQ8es1GkCU61CiWcVC+PsFutkYFiuWvEx/xEATvZBfFXFbCU1ZYCbQc87RqU7CNjCJe56bBzc1lQQ5o0PwqpKznrkeIuns0j9FTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4LNGlrRsxG9zQEEEZa6+Bne03W6a9ickZfs5pg8nSg=;
 b=Dj/KTy5udnJBo6o0ERzhVT8rnNlNXF87o9B/2QnIxCkwNbIvbHwyRZiU5OcA/58x/M7yj7xJfHFNaX8PG/NFXLa6BEvSJ28WLi+fDybdbxkk9hjkdEAy23TNM286MmdmlbPm5Ivf3v9OX5yyMbxl2zl8dZT1mAoCLtlra2qtZWiBDBugE5bp/4ZquUk2VP4kzYisjdQJgZ/KMsrWZdOjf/7vKrfEN5Gv9A+bc1xgYiSwiSfaOiawNiu1ZaD6NsnWNx32XwQ+FGwlUtZu/TGl/hJDPSBgitI0H38Bjn+UbF+5NjkSeOwks0d4yTLq26cZMlMm3VP2/hvKbAOI0k+Ydw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Fri, 16 Apr 2021
 14:34:53 +0000
Date: Fri, 16 Apr 2021 11:34:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210416143451.GJ1370958@nvidia.com>
References: <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
 <20210416140524.GI1370958@nvidia.com>
 <f71c1e37-6466-e931-be1d-b9b36d785596@redhat.com>
Content-Disposition: inline
In-Reply-To: <f71c1e37-6466-e931-be1d-b9b36d785596@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0257.namprd13.prod.outlook.com (2603:10b6:208:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:53 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lXPYZ-007Kg7-SK; Fri, 16 Apr 2021 11:34:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca4d51e-6233-4ef7-b2a0-08d900e4cc68
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1146D3699C9AD695B9A0856FC24C9@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtOD/G2g9WLqFN9AcRZnvwCJAQnN7hC7RFhCH+eW/MxU2+dlyWn419aEc+o12aDSNS5eIFPlPLE1Jx5UPM9I2XYWByRdvwk1WlabAVCSWajIdHQKH8ENqNylJk2qbbWVxDKeiLjgYp5AR8CPUj+jlTAQjOhWmF2z4JPmbUKA/vli8yriaHkPiRHILdGyHDNt8DMrZcNRf5UmE+Ic8Yd+2IsdkmY1xIJH+2VMkzLt/oBLHs3NfGVzZWvTGncIl8s09gw4eRnxJiTBtHOKibZ86diXdAxYIZNQY3G+LMR8fZGhWarDMiYHIDP1FZf7QFCMtPWVFb87G8XPzNhiIZdwCkF+rIDLralg5gyrSZ+fWF+tUh1zWNlZgXc5kJ4OKEnQl5jHUJHFhtSDps7iWGXq+T8nQIRpBTnpNHvkbQtl33/1DWaGUS7udrSzw4NvnDa9eVxs1OFHtYoHbI2CNvVzfsyuHnYnhwm3M+TxPQCDNTsotahF5cOj9qnSqzHarIBlCxn+q3cpD1WgSOAKkbqmUYwZkvHx8yF4xVzcEOI4AkM5/uadG5hdrDIXvhATkjLlrBtliqadiWeuGu39OMdAsz72oi9RpPZn1Xdar+vv/OQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(66946007)(66556008)(66476007)(478600001)(8936002)(33656002)(54906003)(9786002)(316002)(9746002)(86362001)(26005)(8676002)(186003)(4744005)(36756003)(4326008)(6916009)(2906002)(1076003)(426003)(5660300002)(7416002)(2616005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tv+inDxGQseQ+iHCCNCF7y0Yzaj3PovNlIKSajxiX4EJxGSBx+j/wUpl8wYP?=
 =?us-ascii?Q?X6Q/b7yoby/tuCrVbrVU0/skvYSxrEnCN3DvL+WdWuihrmWH+5/9ufPAiPy+?=
 =?us-ascii?Q?9EaMxlly5nuUl71K5IWoeT50H82tL6Tab8vwVyR4Wl3NQUrSTGoMHX4Kj06T?=
 =?us-ascii?Q?9UplDY4iZNqXLrN04aGvl3pVhz/RmnebSewopgpZmHd+GDlWmt4ATItDAcgk?=
 =?us-ascii?Q?sslz5QNxf5GDe6JlwnSCyiVWEadGeV6gplQYBZbvDw7G2xko8qNlQZZL0hw+?=
 =?us-ascii?Q?e7Uq6/0JG7eSTxrtpKBd6m5T7014Cs2JmBYSs6XPRyRdeXxze9/tbVpDNVTQ?=
 =?us-ascii?Q?CmxLQ+BR6jV0g/EKr5xe2BFTvNRr+sxApgdEIg4mJlDa0WJsEqKI9QY/qwF+?=
 =?us-ascii?Q?CCgvoAV+l6qFj8bk0vk/taHNm/oTrihB9+LCP0ZzvPioAglngEI9sFP0a3Dl?=
 =?us-ascii?Q?cu50MXoahU/EpPKQ28wArm+0hvfmaZujTC2503HGgsHdswwBIUK5k3MHrLxd?=
 =?us-ascii?Q?34X6NzNRWVipm/3iZblC8w1KHkzWw/BFNHk3q+7BxQWbYkoLZt8WBoG9RKRv?=
 =?us-ascii?Q?Qb1snexAmu+Xp9s5JyEEeybXXq/WvXvbMH+cWVX4WpBf7TUMbPkZUuu5DMS4?=
 =?us-ascii?Q?dApS5MKgFuhD3qmpt5wSZU36fYjrrp7W6wnk4DyeSbxtiibFuJ2I7asdfXVU?=
 =?us-ascii?Q?/WwibeAVtBFZpPD9XvYN46VIOwLVibpeoZytPQFfgv+T6eczxsPSpJI/nwzU?=
 =?us-ascii?Q?Wf/lBpmGvgOrlpxlGSeJUqnrFjB6YUjSV1dNHaFJ+aKlVfFLDghaEqOgWZrm?=
 =?us-ascii?Q?a80KnhjC8B/wKObyEyyRF/2pHqLPYfJqwsdIESKV9gyPC4Uu6TqHx1cS522g?=
 =?us-ascii?Q?aoxAfhP7SASclVLYU2JmUwjnBxU0NFQUAmCYI5hytcJ0SBIG9kMgfVTceXXa?=
 =?us-ascii?Q?ggrOx5wWELurlVmZf6CdMk/i1lZy00VsjRKf3RXQtwb7thB48Gu4mZvz1keZ?=
 =?us-ascii?Q?mfzB2KxDjE+lhb7XjE2vIILugFQnn0rP8wlrUKnCjGwNWbl6vuaz7TTD4oo8?=
 =?us-ascii?Q?Lr+3HGQC2jE9FpuiD7AkUOSuASmJ5dHmgIAJ+5QnKHLiPMQ8fkOeRwXZmVPX?=
 =?us-ascii?Q?4NTprkF0rlcWeG0cqXUHVeAnPFlNFlPZOGxyQwrZisVBHtV5JMPqgiVU1Ava?=
 =?us-ascii?Q?TITWq1zwdZxL0b60uwl4hBNDTB1BBAbektSFLvQXF8ZeVePSIDRpoC4HsxRA?=
 =?us-ascii?Q?WerPsIL2Hc07Ntk00DgPBH2BRinAYHQrdc5Wa7n7z0lq3AlQBEkOOEIBMh5z?=
 =?us-ascii?Q?IHnhadxteJ83yN2WzyR9StZKMKbRxNA/qlzjwCPgnQ/v+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca4d51e-6233-4ef7-b2a0-08d900e4cc68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:53.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyQUFfuY214+c61l6rOG5swRevxnP4wx/LI9DH2MGT9K8YUxK3JKbAYR8Jwns37n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
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

On Fri, Apr 16, 2021 at 04:26:19PM +0200, Auger Eric wrote:

> This was largely done during several confs including plumber, KVM forum,
> for several years. Also API docs were shared on the ML. I don't remember
> any voice was raised at those moments.

I don't think anyone objects to the high level ideas, but
implementation does matter. I don't think anyone presented "hey we
will tunnel an uAPI through VFIO to the IOMMU subsystem" - did they?

Look at the fairly simple IMS situation, for example. This was
presented at plumbers too, and the slides were great - but the
implementation was too hacky. It required a major rework of the x86
interrupt handling before it was OK.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
