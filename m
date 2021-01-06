Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B616C433DB
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 17:23:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E6422BEA
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 17:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E6422BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 478A0865C1;
	Wed,  6 Jan 2021 17:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYp5Abr88T_T; Wed,  6 Jan 2021 17:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58F5186594;
	Wed,  6 Jan 2021 17:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F07EC088B;
	Wed,  6 Jan 2021 17:23:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAA04C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 17:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AEA0586C7C
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 17:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5gRl+sBBXB8d for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 17:23:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E65E86C70
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 17:23:34 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff5f2160000>; Wed, 06 Jan 2021 09:23:34 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan
 2021 17:23:26 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 6 Jan 2021 17:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmJPrnlmFX7oIEaO2USfZhu40EucFWkBEJAxMG0boh0WYZnM4imHZMF2CYc0LaZBWG45HuJvTbM3FNt/B36aZu8WLv08y4AJBGWmal/BPX6OOsklBxn/kWz2NjIOUpQxYxefqYKAm6yaF8GOw/lP0cvnnM9gMDNnzEktca/LmxCt3hnAAfPrjo4AmbNIQnE1QRA73CubiP2EFc2pxmJDCbEwCBjs2lkRd1r7EXA6hVSxwd0xy2gRIvvzDxY4XZSKfU7sskxj/9U6H+YEkO03/4zNFfVxPsaUOe4oEu7VBEVP62oEGplDXwW7xbfTQe1GOtZSEUZGhJNP6XJRR2cJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZO//3K9qCXmTKQ20PWb2Hp4/3P/QUxgBssUnTjsHFI=;
 b=iw2kQCEnkgu1JG72D00UyxnL6zg8rMSoFJjS8FAaSRyUQPrEQwmXzXSKkFs/io/9x9TqY5m3WKYgaAeNz+sO2uZpQmDpRW3FzogewACdzH4aT+13Ys4hEHM5nVMMaB6O5X4wPPWiPMV65l3zVEZbvDpkiXu456dL93zPo40z8TmIDeXecpfTISRIGEAO09L5Qx2fu5yk7Ju2m7x1svvGnUUtc71tZyr9ZL2SrfzWGKpIDsN7Xk1WBrYU4kef5e8eZUnM8lRG/miLTVS8wDmyUa6RL3I6ZbktjC5D5TXysdOdGDgyIQuEp81L9W1831ZyTdnzNu9ic/tpc9RGdD+dhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 17:23:24 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a%7]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 17:23:24 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 11/13] iommu/arm-smmu-v3: Add SVA device feature
Thread-Topic: [PATCH v10 11/13] iommu/arm-smmu-v3: Add SVA device feature
Thread-Index: AQHWjaV1d2KW4azDX0GL2jXeKmbeXan3zrBAgCM+HgCAAHTdwA==
Date: Wed, 6 Jan 2021 17:23:24 +0000
Message-ID: <BY5PR12MB3764FCE7157C2343324AE94DB3D00@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-12-jean-philippe@linaro.org>
 <BY5PR12MB3764F5D07E8EC48327E39C86B3C60@BY5PR12MB3764.namprd12.prod.outlook.com>
 <X/WMZgVFs0F2H0vy@myrica>
In-Reply-To: <X/WMZgVFs0F2H0vy@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0aeb15a-97ec-42b3-8c88-08d8b267c620
x-ms-traffictypediagnostic: BY5PR12MB4065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40656E0CD3CFB20143EA2DC5B3D00@BY5PR12MB4065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqjNkv7w9a3vbu98VIOGuTHHgOGd6UX40/TCqlAzQ8sAK6blF281SS/dX91FH3JlNxUUI7f3vqcULT0rh6TC2tL80CdeMNMLsI8ZNh0sYr0N6FClxDbrgiKbL9Z5AAHzbde0+UvsNcfnDflxTF+wFAFRcbr+t6lUsxNcvMgC9c4LZ91tL3zjQIvumDdetmS4l2DOUfVRnzpdkCtt5PFOtIHZEAhqF5d2E+aULc9EENR49dEu54LK7Qpo0o6iaWmfyD22upHm5COAynSqPvUAWZelLVW3wNG1akGUNQzIxZyy6AMdcS4/VxZWdAxR9ihvmxfMCEzv0zGHzi5fhTBf/sxvoY6iTE6xnvszMBQI4SQs/QNcNkWuUlSsvis50xaiocUrLAhKzu4Gxt2KqDuuPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(2906002)(66446008)(86362001)(66946007)(316002)(6916009)(64756008)(54906003)(52536014)(4326008)(66476007)(66556008)(76116006)(7696005)(478600001)(33656002)(5660300002)(4744005)(8676002)(8936002)(71200400001)(83380400001)(186003)(6506007)(107886003)(26005)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aslfLlVcfNr81xWfRu8Q6BQuZDZhKo0gXKk7XQ86WAbQ6nxXSpcvrWFQ70Cv?=
 =?us-ascii?Q?XBwOemkgSROZXTtUq1AkxQONcl9paz3AXTmuTSRVyjyj8OjYC7op05xri/rp?=
 =?us-ascii?Q?ajLbpyPV1ue5ruEasdD5K+EAYRofGoomZZOha4pY/WYaHfHWa8mOuOogSD/V?=
 =?us-ascii?Q?AdtJKx+iFmspQPDERjBShjGJw7PrZgdVQpr3CvNIvjYt10/vh7ne1BlV/8CN?=
 =?us-ascii?Q?xN1GrZ9j3FHOHWY2i3Jlop1u1lEGyjuOSjkpsuYjobDgOmGHWQRM1kpU8iBr?=
 =?us-ascii?Q?7AE6qb0CGQ15ytsIm1UY1VJS5JaqJJHe8m/Ons316Mc8oVNJvvUBZfi2eWRw?=
 =?us-ascii?Q?A9xTLZK7pSTIWvpIy3Mvr0nYAcduC/uH32bSukH76/XIXW3i5W+RWZ6V9ne0?=
 =?us-ascii?Q?y0YwThRIg07Miky/4PByeBLuhrf0vpm9bS/po3s6yTfHtpfLL3M3u7ooeoAN?=
 =?us-ascii?Q?RiOd4bAbZ7X2Og3skdQBN44KpGbEVGSKMbIIb9IQoHycAle6Pnul0KphPhLL?=
 =?us-ascii?Q?jdRNX7Ll4jfUXUc8O/E49yIevgUigB4w9EKY30jNnrlVi1Wf2tl8dI62e57n?=
 =?us-ascii?Q?bNLRQ4cHBnBl6rO/RlD3/ZguQ51Ob/n6cQsVveK7jKUQ6B+Ork99trqkwebZ?=
 =?us-ascii?Q?1MLz1oxg5P+JPx0gFoZw+pjlj1j6yl7hpF8zLkHI7ZfVn/fKP2EV26InNRFF?=
 =?us-ascii?Q?gVdbT5OXSFclHMVzDTx2l5s2FogfN03slFfZFcvVWPoFg9AyxDdLhVl00b8z?=
 =?us-ascii?Q?aA5cGfMYtd43rM0OT84zxgZVY0HN5WqzrvJ+LgUb14Hv1adtGcjwQD1Ie+sz?=
 =?us-ascii?Q?PVlFMzEgyukrZosZci6LRZpIRcDkzhhWaQpOg9KVRQ34eBz342nvFkKoiOTx?=
 =?us-ascii?Q?aYsjGPSjRZWbxu3mpt/KAH69DJ+lZxXFKFwp/WoIAVkJ3Ic3eHAbsE5cHazP?=
 =?us-ascii?Q?+WhjMk8fu+V6EqOxV0FwWGGs5A02AEI/yvUCGeeopjQ=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aeb15a-97ec-42b3-8c88-08d8b267c620
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 17:23:24.6143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xNTw3ThpANP90tzbGoIbwbmstgeNTWETGGQ76ZGvNan2XlAPtKeGl/rV5Eseo9OPXKOQIliBJq+VzkB3d+DFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609953814; bh=bZO//3K9qCXmTKQ20PWb2Hp4/3P/QUxgBssUnTjsHFI=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=J08N7tBqMFh2dGDaPoqWuoSRt6s/LxYBRkRnEVeWU6UJeRaW4FhKyWsTz3N0lWM9z
 oDUjC2yCGCFNMWSZKSnLyQWz/Nxt1fggtF0eA7d1Ez6AashPxzxwZfySUWHohlsdlz
 Neq4/l5coQduHSzBXSDRQ7UPJLFLMlsJlf2oK9+KveT6/70ffiRHsK5iEZLNulPzn+
 RtOIA586qEMQ1RjbJfALpcrC8+BEkPMaLUEQ7nUU36lpWZNUbni4OzaHN+NoDFkagc
 ppZcJOMaIm3eZL9Z452m37bkMXMUeQRf71NqXn7W4nIIEBuNGmxne584x0fFJU3q6u
 spHi2gJzjFd6Q==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, Terje
 Bergstrom <tbergstrom@nvidia.com>, Nate Watterson <nwatterson@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Alistair Popple <apopple@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

> I agree that we should let a device driver enable SVA if it supports some form of IOPF. 

Right, The PCIe device has capability to handle  IO page faults on its own when ATS translation request response indicates that no valid mapping exist.
SMMU doesn't involve/handle page faults for ATS translation failures here.
Neither the PCIe device nor the SMMU have PRI capability. 

> Perhaps we could extract the IOPF capability from IOMMU_DEV_FEAT_SVA, into a new IOMMU_DEV_FEAT_IOPF feature.
> Device drivers that rely on PRI or stall can first check FEAT_IOPF, then FEAT_SVA, and enable both separately.
> Enabling FEAT_SVA would require FEAT_IOPF enabled if supported. Let me try to write this up.

Looks good to me. Allowing device driver to enable FEAT_IOPF and subsequently SVA should work. Thanks!

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
