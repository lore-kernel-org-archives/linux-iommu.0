Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC534C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 21:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89362613CB
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 21:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89362613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55EB34002B;
	Thu, 17 Jun 2021 21:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x6djbiT0eYU6; Thu, 17 Jun 2021 21:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 669BE400BE;
	Thu, 17 Jun 2021 21:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 418EEC000D;
	Thu, 17 Jun 2021 21:18:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E58DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 21:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40036400BE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 21:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SY7JpyIrIumg for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 21:18:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F6974002B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 21:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVD0zYdVMAsm650zqa3JTuIsUEnm5Dut82axcWBLDlVuCDsgMSiIfaZOlP5JJG4j3UbDOGDY8l5TlKzFwDCZv4amosczNxVE8wP/3MaVT5268dLpsO+/OLlGOnrvbMa1D1nHDdBSGqvBJps8jp2Ta8aIq3ikBMjp+EZDOKx0man7rbBVo7Ccy0ydnwL7J+meEgtMhy9VGV/w8A6NJYyKLKqzC30iWLi2YR/cXCWGORJ891IfKj0nFnCv4e12UpRmo6u+HBC/BkLHzG0WVOjXZS+FKKXZOQ/o1b9lVtGND9shAswcqKzIQ1tu+3g3TYz2lf6FbcAlvhIOuKex8bCbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmEYs5v60QAHo5ExFrjtYxBat3AJyZqfrxvA172ryeY=;
 b=du0IL+IK+xqDx1BqVuLRyhL5TtZi5O2WvCMRUPs0xSctQhv7J9xPBZMjKrt0Bc84SLJ39c8h/9ai2A9RU9C6zZMnhPAKFzY0CBkyRicW2p6u9J1pHmv7s5tIZt4ZjF6LBnpWxG0vxyzF73pVZUc0/tw5UpeL2tgzTLjawEQvG4cecGNOZO1Frcav3+cERFLdRjT/tJoWkLzyFHIhycvU+1kAsGhlN97nBLE5WmtxcVnMNBk+K+6k/TJFg6qjSH8NdjXMZmv0FTpd3ssfMJH/9DJB1newsdYreqZKuTbMlvwUkRA/YRRGb+XlUQVZNUM6Fgentba7BTWj/JnhXcp9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmEYs5v60QAHo5ExFrjtYxBat3AJyZqfrxvA172ryeY=;
 b=KQOWCBhwRsKfqjnudpp2zF+sbOv1f2JDmL5vJvIRG8WG4xNOcZy8SjCvaKAQwGe8TJxFPyFEBd6kRTua0i4Vfw1wI7aAvN+WslEQbaLQ5HL96t3TudbfZ9dawj2ZzMMJPSgVhsripgN6meELYQddor+HXsToL4KpaD6whiipvKOSaQQoQQwhc9mdR87SI5wQgfPPrRZ2ijIWGAFegxQ/1cUXMCSAWAJKolsIcSkfmJ4aljnO+fur39NjFV6NoKcK5/vb+QbCv9CQATuYaF/8I+z+dTneb8zrbtGGtI6xHj5COQL9qq2c2UmiJfBOXGJtWP1MjDRto70ZEl5BHlQaeA==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 21:18:34 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 21:18:34 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, Robin Murphy
 <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Topic: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Index: AQHXXT84btg0466hEE2rkvq94oyuZasMBHAAgACy+QCAAD6WAIAAB6mAgAAg2ACAAAWcgIAAPESAgACQdxCAAA05AIABAqfQgACvFQCABA+AcIABP6aAgAAiRoCAAR4wgIAAIu4AgAJcYlA=
Date: Thu, 17 Jun 2021 21:18:34 +0000
Message-ID: <BY5PR12MB37641A153EAAC556C85A411FB30E9@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
 <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
 <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
 <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
 <da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com>
 <8535b6c757a5584b495f135f4377053c@codeaurora.org>
 <d9226f4349c445c6ca63dc632b29e3e0@codeaurora.org>
In-Reply-To: <d9226f4349c445c6ca63dc632b29e3e0@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0176fb-3b05-4fb2-6ee8-08d931d576ed
x-ms-traffictypediagnostic: BY5PR12MB3843:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38432AF1B19C9FAC1FAD814DB30E9@BY5PR12MB3843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ObuA49ycSJxXAUZBlWwAT0RSJvw6qIpDQQvJHoE0wGF25aO9QLlA7Zb7I+tPWPsdDh4tyiQQpIwCTCMwtHzsmShTrKkApDM7UP1DhSV2PEg1Xrai3bUG85UJTa8CcaFYSmAMw2XHI/O3c8gwi5cJTLo4VeSDaSNFFXkUiaLvngvqheD5T3TPlqjOuxzNv5MvwqEtCt0RmBM1f5MbXiT7SHUkMPFTruzNkJeQp20rCTEMcxRbHSvaHo1h4vTX0kQCuXIUuJqqjMmASb+eIxLUXIKxTWDCnYWwtjcrHDUGlc14IhXwLMBYuYALh4kM2tVuS2rwMuO57OXz/8ynRyvP2A8x7Kmzvj59k9cWv2NaTRDtfDUY18vh7uyFWNfXI4YD87yEKX7ArSH7mMTmw9EmYXospIBHV7QECbca0HUj3btZzbdif75FhNUnHFrc7wexFETW/KYfZnK9tCjMhDS6GYdqjeuhr7EXO63ymVIXp1IRVGamXevRtLZ0mO+EgxFYx746GAjmF7Psl9umNnJyhCM7hzFijyhnczCnIQvo7jZ9jW6LtbKciNKwfdMRNTEeBJzN3IX4t9hGnLCmHZsQYjGwKDP/5nD6P53CDFhwn8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(66476007)(66946007)(64756008)(66446008)(52536014)(66556008)(5660300002)(76116006)(122000001)(9686003)(110136005)(86362001)(478600001)(2906002)(54906003)(316002)(71200400001)(6506007)(7696005)(107886003)(186003)(26005)(4326008)(4744005)(33656002)(8936002)(38100700002)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09reG7Jx2x22eN8UhmvdMyi2SvTzgvseRUbJ7rKn8f6/LnLEKKtBiCkh6Si7?=
 =?us-ascii?Q?ikCKN4gBpSnzzvwd6t4CAzWAsdgrVTsswJbrqhn3tl0ulCRgSdiXmZQ3vpJQ?=
 =?us-ascii?Q?l0C87qGl64lsjHshC5LC9iPDmN22eh7pYHCy4jLJLPlP2jfdc5Eo21sJ7rZR?=
 =?us-ascii?Q?6+pEdtqAOEz0ZZbFgoyuzH5YSNEKTdotIjWRqiA1NuRQ96NTirk5M4YyObgz?=
 =?us-ascii?Q?Mdxa1qecQQ06PJQ0h9+XXsnpkQT/8Cyn3d7aQI/kYm3Iv221ruUwnfNrx6Ko?=
 =?us-ascii?Q?zBXnZu/+SCxKHM4wUjbVUEl1W5Vb6AYNzFLzJDl6oK40h5SKRA8SDuBb/k4W?=
 =?us-ascii?Q?cBZLB+gfaVzRpbeAFE5VXNKQA7E30Bz5z3Mv7TeSnNzMMZjsVsmdmq4eXAq3?=
 =?us-ascii?Q?1dNjcjYujm2Z+r9qSsAsBK0pLTjS1061L1ypt6RhaYSaq4V8tnEl/s/9kUPM?=
 =?us-ascii?Q?wu8EnCyT2rwIDcAoOdbds7gb8ujm+suGEMZftzvX5E9R3JnMSvC7fiq2BKZ4?=
 =?us-ascii?Q?tHCGDhNsnTKO1u+nbvU2dL6VXYdQPCTwFnK6wBoIcsWS+126eXUsAjnvaM8M?=
 =?us-ascii?Q?0ZgI4zkTF9KInFsF44al7wDKEPH3f7V4JCaGtpFs6MP82YAAuiujeJvbs94f?=
 =?us-ascii?Q?zylM9ims50Y0aftbvs58Uuum8Ak7J67rrLU1Z0ghas5BVVlogSaz6J/oe/zw?=
 =?us-ascii?Q?SeIqNqiTc7v2auT6LB7vTvMZihYOWQNnh6WYku8/dcZWhY6Kq3W1QY6Pn+GN?=
 =?us-ascii?Q?cgpotuAfucb4meJlQJWDSeybbvFryS8HGPdsmZiNHztGQtYaOcoxUcsg10wH?=
 =?us-ascii?Q?gzSy3ArsOp+1943e0/4SZ72WkioZnVKhEkrvX7BTmBlv9xB6goJjeSvHBN93?=
 =?us-ascii?Q?5thgl9b2+pYm5Q2/XaI4+/FgScr6CcTdJb6Xv5wXUsABkG8XnBrabv8pM/6g?=
 =?us-ascii?Q?eMFxeAiGTygcrN38m/6+1Ze9Iu2GmLuEyeuy0fcHPcEBDbf2CcWzZ4z454NY?=
 =?us-ascii?Q?jktQ9zmMckiZqvgUBHPqMNdIn8Cd+C67+gbYh9AvHEL5FhK4Aw0gHM7r82JJ?=
 =?us-ascii?Q?+iStDeEfkHixP20alcqu3DWEzhHkKFtLc3y2eD9eH03gG5ZJ5VJHV5f2Xxe1?=
 =?us-ascii?Q?j4CX+f/Eonh/cJBqAaSpMG2c0pzrcIrWdqZq2QgpX4mRe/112Ox8IPT6FIzA?=
 =?us-ascii?Q?PCpo7ZbIgKVXhvJvyND5rxhZVfzCUKq5wsQqRoDr9lyCgHZJmnGAI7Kb38Ci?=
 =?us-ascii?Q?OJN7rZw4dEYT2SU2Ny796aI4J/ZCZwMlcu7EXeSkZHeX9ZkYLv9vvo7ESukt?=
 =?us-ascii?Q?O3096XMaq2taYzCu6mmUDlXZ?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0176fb-3b05-4fb2-6ee8-08d931d576ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 21:18:34.1503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7TXhFuEWZfzHl9qDDRrvalzDxFbLRetf+2/7e/djz37447pjxKe/6KulBr50lL34wuBSnJfE5Zzkx5rZ3v17Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3843
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> Instead of flush_ops in init_context hook, perhaps a io_pgtable quirk since this is
> related to tlb, probably a bad name but IO_PGTABLE_QUIRK_TLB_INV which will
> be set in init_context impl hook and the prev condition in
> io_pgtable_tlb_flush_walk()
> becomes something like below. Seems very minimal and neat instead of poking
> into tlb_flush_walk functions or touching dma strict with some flag?
> 
> if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT ||
>      iop->cfg.quirks & IO_PGTABLE_QUIRK_TLB_INV) {
>          iop->cfg.tlb->tlb_flush_all(iop->cookie);
>          return;
> }

Can you name it as IO_PGTABLE_QUIRK_TLB_INV_ASID or IO_PGTABLE_QUIRK_TLB_INV_ALL_ASID?

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
