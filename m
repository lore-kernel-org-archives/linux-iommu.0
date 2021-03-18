Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F9C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 00:25:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AFE64DDC
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 00:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AFE64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78F666F65A;
	Thu, 18 Mar 2021 00:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6p6nMMjTLEqG; Thu, 18 Mar 2021 00:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5830260667;
	Thu, 18 Mar 2021 00:25:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDB0C000B;
	Thu, 18 Mar 2021 00:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C472CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B8CE430A8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8HEQbKgwvMo for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 00:25:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680084.outbound.protection.outlook.com [40.107.68.84])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 996864308E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDTRLvEvzbSUQJOK5Ul+iflQ3+8f1oyWyhbOz836AS/NNMMcBTjd9lj3UEy4wUpdse7tLXHorKZiY3xxvCsr9sQTHkveFqy32p+R8J/zmbrCI+yvhSe3ZP9a1uoCy/9VcicrQ5gwOy1jkl/s/ET3Pbj6G7jeMEEQ9xb2PGe8Wxu7H89g7JBjscoohKq1oVzvICGss0espSWdGrJpJIOlSy3maZyQ2XwQKov8ZCMeIvKM4hD4yBzsR7qtnxMuGyuTjQv/R73umN5JSCBbTu82raGF7foSIdcw6Ls2BCK4Cl3pjXN1JSQcGXTFAV0QNlTOaoSRP/Ffba5wi8uu/kYYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHOdsLutLeX3JfUXLmTv+ny7fTWfYCZ8Yaf6/lT0LTQ=;
 b=SQ5SEFrDn/8fklfBT8McNdppAWNUsiOC0Yd33WgbqqOnqJtJgFSf9CiaFLS5RDgpFzX9xuYtLjMk1kBmczcWqFiQAmg6g5r1Xz+IRH5yRl4Ti5G3MDkjS0Q6nMhZdbkZXv79NuBNlq+iV0QeXRGR8C7aXJozWkXxGa27m12RfG23UxHHzAlQ2sKcSkvm14bGRX7iLic5v6fI3EPr/T89VEY0x3JUaQ2Vj5DkRQe77wBVSI4dx7LKARbfFOO8BU6qon4ijn4KdnZMVwf8LkgAIMPqMx1+6jDKR+USB6HIHJ0c3aeln22DKFXXfcKP7g1A0nq+l4QAjvJLxs7AYNBGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHOdsLutLeX3JfUXLmTv+ny7fTWfYCZ8Yaf6/lT0LTQ=;
 b=p5Ljjs1kbjP/nSOf1xiucuEW8fquVfOkHXN/l2GfnzBPh0TgSTou/2jVGmHS1coGWOTlBJY81/GF7u0s793ra2g80yAzo0Ptcog+NJIzn3CIB5YhKFw1/iai/jvExaTzF+Waa+FM6ivVDAvFj2FJSGHj3JrgLenBcJarZc3TLbDY76btpksCVGCH5GKOqm97BTYzL8oSNysU/pdHNO/BqBfnb+16SbZ+Hj0c5Thi/13q7twB2fcrYlJ+I22B5Oll4DMa1HvHvRoPtMkeZE5tr0bz5kaCp5LfdWKlkPWESM0ojCT7QjEfqpA4fzGbZlVdS2TRdw7eEeUQUb+94VA60A==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 00:25:48 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 00:25:48 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Thread-Topic: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Thread-Index: AQHXD0drlTdxumYxFk+ZFSU15kg2EqqI+WNw
Date: Thu, 18 Mar 2021 00:25:48 +0000
Message-ID: <BY5PR12MB3764F891751224804232725AB3699@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73015e1f-e84b-4fb4-fb1f-08d8e9a460f9
x-ms-traffictypediagnostic: BY5PR12MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4869E84D6D5B475B0DA60AC6B3699@BY5PR12MB4869.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvgZc90fBJz51fyw9reG5N579j0W+oEVlHMhXylkUEFIB/kOSWGt2QhHv1MdTVwv7B+1K7vOmRNJIwemfzSQE9yZ1U0hAjKBwOPiVwbvru7bIzlkWWl1tVBFijbVmknC2rySRVxZyQOIe/Za96x05mRkTbr367aQnulvlGdJOzlzzYnWwU5L2NxDW917Rxjx2mbhmutyEjGTqOHh3h3q/Yh8C2Y7Dn1gSpYNZ1pdkWIDOfbhcASEqUXNzPRpvbprh+wCdI3t6mkslUgASO543lzGRHZGXkiyaLvzkjDSETadKkv9fVNQfMnuwMkKkklJbS0kN8XiyaxDjZx+ZLIYmhwhe4l6fpOIAQvm+T8evwVqqYI0+FaTGQhmy8RxS/PwuWRoqdU7O3ig3jq1VxRFXOJioonEa1vhiXyXQr+gSj0E+5nHUzSyL3qZm8Gdrm1zHOi9hHzwVBDrZENgSml5CKlTH1cVQG/G376iuwK9w1c+PwHnTUXjqOHRvvGGyGjH7A5kiB7djDFFNMA87A7KPn1vTn3wB03qsBg2/twAaxcgpOKancJf6b9ygJXe/p3Ka8CngVe3OtNMdh4MempWYStmTHIOxI3nv6WKIUvuwW23rLStk/fRrKwmCp8XCjaf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(7416002)(5660300002)(2906002)(55016002)(83380400001)(71200400001)(186003)(4326008)(8676002)(9686003)(478600001)(33656002)(558084003)(86362001)(110136005)(316002)(26005)(7696005)(66476007)(66556008)(76116006)(66946007)(107886003)(6506007)(8936002)(54906003)(52536014)(38100700001)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?umGjHxGPPjoF6fW95E59yn+CmKmOoq4S7F5Ao+5OX1ddiD3He1eaMa4Sn//m?=
 =?us-ascii?Q?QYl7VlpqzfxePCwHFgR+c7+OBW2ke9YC2i9vU6W0frLQX2NwRM30mjejjtKV?=
 =?us-ascii?Q?vazwzD+m0isi6H8/I58sJlTKCYP/6fFdnKma+7Jbvp1Cpa0chuRi85GJQJ1j?=
 =?us-ascii?Q?c8Qfea/DP7Evj6zBcCWHpiXLcmoKhJuHFgZWHbE+yftmKojKJL7MmINQzqk6?=
 =?us-ascii?Q?GlJXDHsxCEh/sT+zfVB2R9CHddZvF+ST3Tv4rk4tBERv+Bq3cciw0Fd2yIp/?=
 =?us-ascii?Q?uzhSImG8yvYBuUNWa3OuQBTbd7Smffv57FKCYK3kpAD3RwO8mNW20FmVmICl?=
 =?us-ascii?Q?e5pfQDln+A6J4sr9Re9Vv/xQUepDSlZKXmzXX+T5fKkEdp4Ub69irDPAZu4v?=
 =?us-ascii?Q?lz6ZEyBGFvgS9x9/sC2JH6GZ3/xttTxL5upKxD/bSn2KLYQ86T+owgYPO+zg?=
 =?us-ascii?Q?SZZ8nQu8wAv2XO+HJ6qCGkhx0KJ3eV8Qn5od/yjkX6z3q08Vsyeh73IpRpyt?=
 =?us-ascii?Q?+jdnxdFSPrads1AmdLxJUPDRqIuhz/QAf7H9yFVd5pbwSPyoRR4t1kNuTOFi?=
 =?us-ascii?Q?D1fK3OlrgF6EqLqQOPVXuYDHBksCv2lbGtEL+ygyECQKhXgULF9fyu8PU+o1?=
 =?us-ascii?Q?tPsgimcBcgKmkmcwAcSPTz6lNB+1joHJcFkzMI1+ff3NEzCVoJUhy5f0R8HI?=
 =?us-ascii?Q?/MVjaHJ2oDj/3Sd6q0iR3XdTZDLM1d9sAH2AzIXjgdN+y/EjjAxakeN46qiX?=
 =?us-ascii?Q?vm8cm+Q+CGLSu5dJQsYHbtKLARNRvY3BKFctFbTtP3Wv9+DaflFLOH/2MN3M?=
 =?us-ascii?Q?ae7J7Hg0lD8NYLj0tqTge+vgDAgxaiFoytUM67YWJH3Oej+lX5a1AtPWUxrg?=
 =?us-ascii?Q?WwbxSVHdxqD5OypkDb2SD+ZyoV808LnfBbL79jAgpTINyzq0/1AjLPwOaJWv?=
 =?us-ascii?Q?1HXg/ZpCmgeg6LZPt5VfkNYeHlkpSJJx5+xGqbpgBnbtcbX1/B8c3XrxzUhL?=
 =?us-ascii?Q?Go6VsnxS2J3Ez2iNIcFe4pMws4vIPhD/Yyjxtro1uQda/p6N2UBSDx1q1iap?=
 =?us-ascii?Q?DPgIv4g6Cy/B2l1Yw6q1ZRTeh2OlXYZdfH7V9O3xOx3Q6/r3mxfalWY5hKW6?=
 =?us-ascii?Q?d15u3aYBPulkKIOZpJGlMo1NU8n0FmY1AzzyHVIoq8ZATRM9X1pZhnhHDnTk?=
 =?us-ascii?Q?71zqbwxC74m39jVPNCgzWiazYBaiIcRA14EQI0SNLUCIMzg7bXnFpnIyrA2U?=
 =?us-ascii?Q?fZsc3CVwwPV1NqplSdZ2cLfESZkAfiD9ly6BKiuVg9eP3KAx8v3TXsWvzRGN?=
 =?us-ascii?Q?rSxcVaKgRRzx4tKK68qtdV59?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73015e1f-e84b-4fb4-fb1f-08d8e9a460f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 00:25:48.0211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pC5lM2x0MYQ2nQGaz0lydUhpUhU3K/u57z55PI0gnv/9bIXDIgScmBfCwXhtoI6r8lyS52tyKQuFjllQWABLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
Cc: "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Terje Bergstrom <tbergstrom@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Vikram Sethi <vsethi@nvidia.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

Tested-by: Krishna Reddy <vdumpa@nvidia.com>

Validated v13 patches in context of nested translations validation for NVMe PCIe device assigned to Guest VM.
V12 patches(v13 is yet to be tested) has been tested for SVA functionality on Native OS and is functional. 

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
