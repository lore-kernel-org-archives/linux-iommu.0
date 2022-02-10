Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCAFC433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 23:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 850D640291;
	Thu, 10 Feb 2022 23:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xx-YITgIG0cs; Thu, 10 Feb 2022 23:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19745401C9;
	Thu, 10 Feb 2022 23:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCB7EC001A;
	Thu, 10 Feb 2022 23:58:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E866C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FCE040868
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ur8094QWSWDJ for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:58:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99C574019E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayCW0zz9P3G+6GTpmLmIsAbW0/OE2/WjXYkARsmL1TW58GvRIaS8uGk2INhKAJgro3lVYpJXVMNDMrwQlHoxUeOxSg4dr2sdZ+zORhjcqv56Q/Me3HAAYS6S32kgS66tqA3Hevl79zTMeLS1mSxKIi8iiH3A8WirXuHw70mdWYQBCfglITQ2X213CDLpB9LMBcfjUuIWNSMfD+kXBlk/WgJBdM4LQPGZuPbZvLUHFBNTno5Rd8B6D1fckwUhzALRoAH9H08djLCp4IH5aJqwvx+ab/4nvXwE27nH6RyLc892GmMawHRA6h9utE6hZcCnviwuwYaZr+CB+QSeG6PlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEy36uerVyeFznADueM5sIDLvrBlxunsFvauXBfW+hs=;
 b=B2Ekxrf5vk2Zsa706r6L9rQWu1CMtE3ncmmVW7YXB3I80O+g9/yJ/YlmDsIxBlGgyDrIW8fT3sctoBLjZjHj8Cnqv7AIFIs8Uem0BYjn2rO/XSEg5B6xTx498rZpxZ3SZu3iwvpbeDKNqdEyMlMCp9MvXwO8Hakx1fb2XFBip/XBIJUs2VkZUopdTtay4HuN8py/A0yEBsXnWd4uw9ZokIvhv28NGeW9p5UXuovmN2K/d0cmspwSOnMXriO00hDG4sgkEaB8XZSIWzkrLWzJ7NKNWJLGgUlml9jspOqyUNr1yZ2kAanAu+7NykIS+Q7A3etHGaQkpTSATh6+rYoVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEy36uerVyeFznADueM5sIDLvrBlxunsFvauXBfW+hs=;
 b=nwl6c7VERNSt6gyJtl+DCX7IF6IqzJoWUGC43AKwc/Jt37s7cmuDkwFn2JgD6tNzwRpcXXyrJ94wHFkZpiqm0H/YdxI4zQyG/uvOVsahtuZ7s30ZK+UIcXnzYKfWJ2S4nT2ls8GHDxvDBVIqPmAKV69im+/npBLNpYXzQMu+hd8=
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by MN2PR19MB4031.namprd19.prod.outlook.com (2603:10b6:208:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Thu, 10 Feb
 2022 23:58:53 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::f4fc:46a4:6bbd:b07f]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::f4fc:46a4:6bbd:b07f%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 23:58:53 +0000
From: Martin Oliveira <Martin.Oliveira@eideticom.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Topic: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Index: AQHYHRbxB1j8kCqLyE+mphWtfDRQH6yK53wAgAKPR70=
Date: Thu, 10 Feb 2022 23:58:52 +0000
Message-ID: <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
In-Reply-To: <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841921dc-c8ad-4f08-879f-08d9ecf14a7a
x-ms-traffictypediagnostic: MN2PR19MB4031:EE_
x-microsoft-antispam-prvs: <MN2PR19MB4031A6AD322DC310D24B69DBE42F9@MN2PR19MB4031.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epl/jFSn8mQcH3cBO4vc7nXFRPgmQtkikHdR5A2T2Srtr3kNpKezMLwpMD2TJG8ag+lKcriCBjZaXDZerWTd6MY6bKguZ3TItHesPS/H4neeDn0StQjEY6V7c9w7gxpAl1mBnbf+kqAo2i26PdsMHoEfroSz6J+3dSb3sey4Hxk8GJdHQ+C1V9yT68CeHDpof3omy+eqD/vkfBf31zYu5cWK6IIKKsT3mvSyIUFmSv+urZxoVq2brSEGBKsXVABXYbmvCgFuMQtV3D+10yo4L16lflSyMnyEh8c+UlLrDONfJ3BtWw9XGKWhH+Oqeg1l+k/Naed8DcGRD9y5i/YCeuGnvde0Jur3O7Fme202Eyr53B/jZdEWC8+VQCKpBuzk/Z9HrsUyk2FMHyLqNtdYoZltf+XR+O+y2WCETD9LVzl62rJC+BfTBlwJdWNqZtCLgiUUMMSrJMWYGE/VWgKs8Kz0B3f7zW5p4ZhRNJRkIr9b1By6V5Rv75/FoKF8ByCVS9YfO9Ce1bOv1NZNgkOdvWNyCU9wNNL2He07csSj39xDbeOqYQ2nOTNO2NQXGnFTCmhi19dn6+m6tOlKWz+z0/uJ3PcSbEJlm3Q+DOIeZpWKdzdt1+GnURSaS2h1Rhl/ewfFsDQk3MruQL1jYFEPk/b4kS3+3qzLcDCfXaOR1MM/orIy+jYjQQxu1KtDvf6wojCfheoCaSO1SVTIKqb42g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR19MB4250.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(39830400003)(136003)(346002)(376002)(366004)(396003)(66556008)(316002)(83380400001)(66946007)(6916009)(4326008)(8676002)(66476007)(76116006)(64756008)(54906003)(66446008)(6506007)(26005)(186003)(33656002)(8936002)(38100700002)(122000001)(508600001)(5660300002)(4744005)(9686003)(2906002)(38070700005)(52536014)(55016003)(71200400001)(53546011)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mMT6kDXCmNUaSLHLFebxpOb2nzYjfBZ+a0y6sjoZp+eZpQPGlKTKVBEyRH?=
 =?iso-8859-1?Q?JzxwdElXXOxNI1eZClt0fuhMF5KuDtuxbViHjeDwQ8PMLoEvJ2Iq5w0wJM?=
 =?iso-8859-1?Q?MvAVKEbA13nVvUXuJpijI3nY4gZQ5d/wmBZ0U+mPU29izBSdhm90adG8yY?=
 =?iso-8859-1?Q?7VpzycnH0einwLS17qAS9Iq0RaBDtzOpjAj7cs9v2qvNzDxdWKNOlcNXHc?=
 =?iso-8859-1?Q?sbadiEyH9ud8jEB6rKVj312wGJWZcgAY7DgwLEuz97m9JoaAieiYW1TkZY?=
 =?iso-8859-1?Q?ycNDzbONRgWdT9QCmjTUnT6Xq+hNKD/Aa3WWAZnYfJtq0mX3X6TqHH/2s+?=
 =?iso-8859-1?Q?5F+YDoEPh12+CgoGjHxKvaLyys/djeX7rQs0ACSmvCQBpOy54jYSncu75/?=
 =?iso-8859-1?Q?cTaDmZ8y8qk+lfQ4T+H+t18cpZZ+Inc9ySx0Zus9DhBKiUYCnNHfLMJA7r?=
 =?iso-8859-1?Q?JMWoIaNquikP2Pi+Cvpyj7FchZ81jPvEmxCxUvbj5bFv6nAkh9/AManTuQ?=
 =?iso-8859-1?Q?2z8s+Run+dvyNdzMgSm3BKH+2Yn4zArC1CZ+vUAEwCpIiZM+iC4Cyl+13j?=
 =?iso-8859-1?Q?ueTB2cd5CHBCZXedAj9RCfD8IPl+1UVCLoAhm05lGj3UKW9wHuh6HA+y1W?=
 =?iso-8859-1?Q?Yj+RELDQBHCf0uJNwTTkCRrD+RorNovySZFA1K6uRibT3hwwpx4L1GX7Vt?=
 =?iso-8859-1?Q?5PqHN1NM9aZ3nhWuYxWmSVy9C2DnUroSXNXdS8V9WfQiT9VW0ZWGSmVyaV?=
 =?iso-8859-1?Q?sSABD65uW5rinHvHf1/9PWxHK0TGb6T5kJ4MMqPJSHA6uIU5/zgnIXGKtz?=
 =?iso-8859-1?Q?RtsX7Q3igUXoa7E49hfPCFRjoxq1XLV46bmqwD6kZWmhLY+XVXO45LQ4f7?=
 =?iso-8859-1?Q?rOqlhbDGl4JSQ6vmHwNPvljNNpMgvparHw4gi0lekA2RbokzUX/h/QAxuN?=
 =?iso-8859-1?Q?Razmyf81nCgZH5OGQEFOa7rxii5L5/kV6HqzuRl9H9jPfaw/coVuHwQyc+?=
 =?iso-8859-1?Q?RJUfBx7D79N33V4oWjqESYQYQvyeymt6PR/fCw3DvhvVB2KdKPrFFcyuhH?=
 =?iso-8859-1?Q?E0ywTZChc9j98Q7FMB1fff48aAA1F0Bi1x1A8/BeFqzKShwiDnL/c2ZxNq?=
 =?iso-8859-1?Q?anHzcysYkhhz46j6rJ3yw73+qKkAgci1VT/bVLmpV9bXkLde1pC08erIge?=
 =?iso-8859-1?Q?LXdwfH2hj/gceC74zx80/VIHXacC+nQ+4SFW7IcSanb9Qz9uKHkdabPwsS?=
 =?iso-8859-1?Q?fsOW5+H9nqCRigr9+QxkOO+zqRBdn/SQxDZJMuySSQgq0yVkhIXD3A7BDz?=
 =?iso-8859-1?Q?53AWL3SOUidz3vwOhZ0dW06LAtYlALl+QmiEk948x5nEhA6h/WoBR6tmAl?=
 =?iso-8859-1?Q?LlhTm7TLeQUHjkwkLiX12cCcsVTqZnQY6AhBWW6dKh4FesE4LdMWYBc/HR?=
 =?iso-8859-1?Q?fb1T4ARoEse9BXaXljlxRY8ttT4KWV2R+X+hwf0vqPoNhDgZOzlmAfMeZ/?=
 =?iso-8859-1?Q?hYVAkCdw94ByMEm2BF++JpA41FrB1f7YEfKUgT5wkUEWY/FZPIz/3C5P4l?=
 =?iso-8859-1?Q?QcXFnI63tf+1Lbr/6f3ACRmMckZ7z3kLj3jacV7CmvraaBEuEMG8B+yOwE?=
 =?iso-8859-1?Q?BB2XMLeSj+y+CW7StYBC/kiqZn3jLQ0vK+SvPbVNiBwZNHdjgfIdzuh7xe?=
 =?iso-8859-1?Q?AA1Html3dmLRw0xKcNKtS5Vfsi/SMnlMX8GOVtfRHvIWdai6Qb8A5LC766?=
 =?iso-8859-1?Q?yHgA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841921dc-c8ad-4f08-879f-08d9ecf14a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:58:52.8734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRO5b+9NaJ8xMqBMxwEd427+iZipdOf+gJpUY8ukKkkWAAlSQLiFQOgPKglebZk5vEa10NGMLdjpB1C2d2Pg0yklYH4le7StyU8yuv9YbO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4031
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Lee,
 Jason" <jasonlee@lanl.gov>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
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

On 2/9/22 1:41 AM, Chaitanya Kulkarni wrote:
> On 2/8/22 6:50 PM, Martin Oliveira wrote:
> > Hello,
> >
> > We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
> >
> > Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
> >
> 
> Thanks for reporting this, if you can bisect the problem on your setup
> it will help others to help you better.
> 
> -ck

Hi Chaitanya,

I went back to a kernel as old as 4.15 and the problem was still there, so I don't know of a good commit to start from.

I also learned that I can reproduce this with as little as 3 cards and I updated the firmware on the Mellanox cards to the latest version.

I'd be happy to try any tests if someone has any suggestions.

Thanks,
Martin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
