Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83BC47080
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 17:37:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9015961186
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 17:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015961186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49825403BE;
	Mon, 31 May 2021 17:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ztlOjWr0Zm_q; Mon, 31 May 2021 17:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AD3240143;
	Mon, 31 May 2021 17:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E196DC000D;
	Mon, 31 May 2021 17:37:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4C9DC0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 17:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A71B783BE1
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 17:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LoA-2WiuG0JK for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 17:37:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A9A983BDD
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 17:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkunCc3etKZnJ/8qW2WyNn0NcLtnNtr/gJYyZtElWG729fON+CeuQ5a5AFKn4PKkT08RSYLmwJAw8oY2vLwK8pMY+SypOqJxPbrnIJ6tYdu3NtPp9v1aUqQahwNRw3mbJ3zomSKryEKVjhtuN7sU6xXrkGJMarWR2IBhI8NIlfUW+wypxsaDu6Erg2bwMzazdQ1JItGRoct+T6IzA5SgkCMQMuLWIqluRYYNvaZ0aPmhoNP7qQlIplCOZU2uEPMj2JQMmSWb+Dti3l4N+dIouLpQWx5CiQ2cM0jFjWNSwV6u9H9fWtqrZvH8/aCZbwWSFxzz6g/2DJunDG0sOYurfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOzuT0iivAR15l6hzMDo/Hltj8j4CW6FpYigK1nevQU=;
 b=iRxgldvRwJhtr8Bs4eai6qK/7w53VcHV2iOHQEqmSpAZE6Y5bzbr3T4sdoEeJpbN9kRSqwiDb5cbJA8TfjhVy6aQyEpJZu8ZPpc9FuaYFzlfXb98SrdSJi+NHOrJ8kCsCt+A026lA7TIlazwZ9nV2Qmzm/TVcJFRu/BV/gWUT7XVMh5oBegxAUEVI/SMSDUkjXKoFXT5Bno3fIZh3UY3h4ALzipVHOhbISx5C4Ly7WsHU07Lf3M7V/rADihocxwuYg7S+wJIOSLjBkeCGCoE8zp4o+AWWNQW0DtdVhKjfwrGQ/WmkK9OGEG+gYmsIseLKitRxQeogESgpqYcxV0qXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOzuT0iivAR15l6hzMDo/Hltj8j4CW6FpYigK1nevQU=;
 b=AL++PR5HNEqmBpzjuErsRTA+ErHIyIIIETGP2lYcLFbvNAknKSMKb3Z3yAnHYvhNY/H7UwEmx8zJRjP6nmdRISnpwXu/a0EyFtuBsewEIjuOeoEnpWCXHz3EOO9Qbh1iMKAwcmUC8+UVVH9DG1lJiXnm6F7vZCk2xh6Fd0pG6nVaxwHPuFEPtAoAAQRji09uVQYSpGg2SZ9GMBb+wLSkdcO3NIWMVnnR0OST4DpDdDO8spz+LBnxBRd+2Gov6J4qWvXYVkhIkCw4FJuEvEA7faEACgdh3cXzUlo8Y5ksmWmTxJNzwAIrhQTsV0/SoFF5k9EAkfZY9j3qSwh/nH6tmA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 17:37:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 17:37:35 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Alex Williamson
 (alex.williamson@redhat.com)" <alex.williamson@redhat.com>, Jason Wang
 <jasowang@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwDdOxjA
Date: Mon, 31 May 2021 17:37:35 +0000
Message-ID: <PH0PR12MB5481C1B2249615257A461EEDDC3F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.203.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59cacfbe-04c6-4a98-bd13-08d9245ac708
x-ms-traffictypediagnostic: PH0PR12MB5468:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5468A7BFB5F5CB76A8BA3789DC3F9@PH0PR12MB5468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hagA34B/IP8mTdIEbPy8whFmfzxVNRZ5d+QvdUvUsWh405vJwZsroRlLr+Z6Tcrw4TAsy/lGd0gRjrwkpoobfBMuaxeXva2l68mK9nQZwaP2tHF8jfcwXOVvoFXQ2ULTC5YeHa5lRg79o6/jtL/o/UmeR3OAz2fxEqKPMpkek7SfQlb58e35dYZBSUW/cZChAjKSm9KrDH9ChbMxaLStPW/gfRb317G9nFFXC4KXGqthcaUDoe3zFU413KUa2gTPK9PzuQqQAmy3uCiGZiDLxKT9ikT+dv7ibT0fIGWa+nXdRrzTPIkf00ZUnKa6JGbp6DFV72UzqT6YWIp6FSQyKENgyALWhbAgKzminCZCpaX/iSgXTW2zjBmnaXWaAXPyEM6zVUQJd/aynMaNFzxLgKO9tbT1aexjV297KHfEX1MExIwuJCebvTui4MHu7HZs39xXopslpOKsfbsU1dmZa4ahdo5Pp2vByh93CN867YPZIIrU3r+SsSXI72FLUwyVhshR6TolkenD6kHSi5l5Sl/wwydbdJ/IMH2e8NrGLrDyxw6tTI9CqYgGkwoSRyCilv3ZlWAKvu7LVaMejDSmBi17FMUn3Bg1sWnse34APE4pxa5pGyU8P84fcBcYiH5dJDubRF7pOEFy03fDNYlyz9nG9sMZsi1CG9WiyQx0XOVfsekJ+zRcLV7gpKuMoy/5g255V1b/PIw9d8CC8mtBm5VzqYvfT6CdXcSXwUYka77UQtz3snkxCdXQC8yMJ5HztoEVEgAPFi4Fx8EUYUz0bB5xIQTFK2RZn2OrMhVliwZ7ulTox7+WU1z+Jt93OUj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(52536014)(83380400001)(5660300002)(921005)(186003)(966005)(76116006)(122000001)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(55236004)(26005)(316002)(54906003)(110136005)(6506007)(7696005)(71200400001)(9686003)(86362001)(38100700002)(8676002)(7416002)(8936002)(4326008)(55016002)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QADzNc0+Hs1oVv4MZp6FD/o1jZmsLNp+sNAgwxDFgPhh13cSHxf87uCmT7L7?=
 =?us-ascii?Q?rkUnbQLS29gm15zUygq2ZQtqmCDm+uBPkVESWOyksL1n7lLWV1nXE6+niSyD?=
 =?us-ascii?Q?z0Wb0XupxcGoFUAJZlDOG72fvOwbpcC66Alvco9wLqzsiT1D9LbAPjoDTI5B?=
 =?us-ascii?Q?hW2xovzbZ4yr/nQcqa66mpunIyieXDi1bWKyDVBb/I9gRuxRHaRUw2YwjLrF?=
 =?us-ascii?Q?rASeXNGM6JhAEmNHfKn0Bw3pB3ummJZIh+HzZiOIi4RQvtikz1an3hDlp/J7?=
 =?us-ascii?Q?n/3Ead/prBas1hpafhfIIk4D33o7I6OOW5tU6wXtPDHlpnUxJBiHwYLO+PPc?=
 =?us-ascii?Q?+hwyEMV9NnyTjZH+JjmmGsniWGrg7zWtKusqYLDS4MkAtc6AhHjh8GnS2PeT?=
 =?us-ascii?Q?DtBw1Uet5VMRacd/fGPDrx4L6V6eaCuZVXOvL+/eUWWPMGW5BFZ3lt1xI+uX?=
 =?us-ascii?Q?gSWVv0VlZmbGU+jkw8PqanVgHN5Dzn9NH/XUI75M7mFzYoIapCBsIaZDj/KO?=
 =?us-ascii?Q?AChJ24R2bgvGEvYT1WTkst9ef9TgDFK2Tve9WEPM3wktIMnBHvt5qCjnlJHw?=
 =?us-ascii?Q?HkQWnqWkXUKeLFp63YND7JC86CUhuUOUNJ8OHsRQWsb5g7EG8s+icoK4Ocb4?=
 =?us-ascii?Q?KCBvuTAgW9hHUbd4sC9J+bRjcs1UGBeN8H9QziKnlxchf+qKCozdmjD2U9Rp?=
 =?us-ascii?Q?KMh8P2hPjbyDH/WttdGmMZQQUK5YEkS+aYARAu0TxNF6MOVwtJm6zqcCoEIa?=
 =?us-ascii?Q?WBvkqBN8Bbtx3DkkkzMFRM0TebEMmwb+IPxBXeK+NArgS6w23F1ocPAVMb2a?=
 =?us-ascii?Q?X7f4PZP8+s+WdziVZ6dnxiLc9CHXDn9D/l+Be1GJk9VwMuVwfX5TnVUHPPwD?=
 =?us-ascii?Q?JWP8FMZDCbfeS/sEdeqY3nb4u0C15T62WjBjTvcTZRRJZEdYdHRm/tyWMMuE?=
 =?us-ascii?Q?h4L6eDvD3xFfLoLbw2dz/Fc1JFPlq7o6v1PQRGvHTEKmhDLPbgZ4LrtYAQJo?=
 =?us-ascii?Q?tEB0ZMIHKwQB1h5R+OdvfuDD+oYt549bcPYn/ofRhAD4V+Pht1H1rQlPXIVO?=
 =?us-ascii?Q?eKQnMbjt5Ow+VTMrGR30tFaxstGNGWpqwvySBIf//uDUO+pRev8xOUU1n0tK?=
 =?us-ascii?Q?JfjSe0MWKsPvXrOSVCsOKF87OEQu1Yfeqpa1NZwlVfI4mWs9iSPlD2p3lX7Q?=
 =?us-ascii?Q?tDFG19EhPF37lEAq9DPwDFbWraNPvvx0gS9TJ7uJpzoG60/waABKmrzPgcdH?=
 =?us-ascii?Q?YQrM2JG9m3ZsiQfCFebdlQTUwzZpnZYIG7Uma9D3rPlKvsr23evL7aeDSyW+?=
 =?us-ascii?Q?Ide+sBvdYU6rXGz9pvyf9s8E?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cacfbe-04c6-4a98-bd13-08d9245ac708
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 17:37:35.2888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnlKnucw81EC86W52jfMq+gAJSN+T4LP/7cv0xcOMAHSeon0QommlJrBHGtaNeAHh84CYvH71dhU8uQkPY0zOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>
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



> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Thursday, May 27, 2021 1:28 PM
> /dev/ioasid provides an unified interface for managing I/O page tables for
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA,
> etc.) are expected to use this interface instead of creating their own logic to
> isolate untrusted device DMAs initiated by userspace.
> 
> This proposal describes the uAPI of /dev/ioasid and also sample sequences
> with VFIO as example in typical usages. The driver-facing kernel API provided
> by the iommu layer is still TBD, which can be discussed after consensus is
> made on this uAPI.
> 
> It's based on a lengthy discussion starting from here:
> 	https://lore.kernel.org/linux-
> iommu/20210330132830.GO2356281@nvidia.com/
> 
> It ends up to be a long writing due to many things to be summarized and
> non-trivial effort required to connect them into a complete proposal.
> Hope it provides a clean base to converge.

Thanks for the detailed RFC. Digesting it...

[..]
> 2.1. /dev/ioasid uAPI
> +++++++++++++++++
> /*
>   * Register user space memory where DMA is allowed.
>   *
>   * It pins user pages and does the locked memory accounting so sub-
>   * sequent IOASID_MAP/UNMAP_DMA calls get faster.
>   *
>   * When this ioctl is not used, one user page might be accounted
>   * multiple times when it is mapped by multiple IOASIDs which are
>   * not nested together.
>   *
>   * Input parameters:
>   *	- vaddr;
>   *	- size;
>   *
>   * Return: 0 on success, -errno on failure.
>   */	
It appears that this is only to make map ioctl faster apart from accounting.
It doesn't have any ioasid handle input either.

In that case, can it be a new system call? Why does it have to be under /dev/ioasid?
For example few years back such system call mpin() thought was proposed in [1].

Or a new MAP_PINNED flag is better approach to achieve in single mmap() call?

> #define IOASID_REGISTER_MEMORY	_IO(IOASID_TYPE, IOASID_BASE + 1)
> #define IOASID_UNREGISTER_MEMORY	_IO(IOASID_TYPE,
> IOASID_BASE + 2)

[1] https://lwn.net/Articles/600502/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
