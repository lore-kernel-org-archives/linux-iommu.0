Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B474C43460
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 05:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7217B613B3
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 05:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7217B613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 094B641994;
	Thu, 29 Apr 2021 05:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5r0rMWKMjapL; Thu, 29 Apr 2021 05:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9269541961;
	Thu, 29 Apr 2021 05:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7125AC000F;
	Thu, 29 Apr 2021 05:51:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB0E9C000D
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 05:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4DD641961
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 05:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glX0l9fK3ndF for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 05:51:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A55D64197B
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 05:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2G/0HR97+GNoEFwH3S8t7jwNOLCrNT3Bz0d9dZLtmePx7DLwhXPSt2rGKJsPpvL8niIXCHlSpb2OJFoDWfL5mSeMnM5y0iG0p2+7oi4CD8YSz6qi8TUCxYlDJExIiu+VwGPOBEx2J2iFqJbgBkuI2Ntqdncd9HldsbXOf5+L2SxxWMZklwduP0eSsffF20ae3kby4CngD3QhbQltk4mQ56MxvgTnbAwt3OUO63WE3kDGxoBAJCSAHxElAdxjW0DgRbYelqUB/D/eSFEm3jmHmy0TzMJbbTgvizkhZNFYGSdsDFeJZ1vWLe0qOiWKWWrah6vAqTvSgWzPg3nI0/nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm7sDfRGhPpuTbCsyY5QpOp7bo1mF3Iu5poUu8QkNsU=;
 b=Yd8Cal+tWk88/i3nyeqjCadHgslJGCeM7C45uKCGv/TP8PrjxARQEhLDPng4dq8GaJPPemxa/Y8+BN4PrdQHHCFUiwfkcik1Cq2PHpqC86w8Itsj33j8RVUWUDRmwcW8y8Xp61+bMTVkjC/hgXO7MzWxvJHpiHwQvJv1mLmh3jCedoOC4arKWk9chiRuUDOBlRSVaScdhy4hzu0DHZxrjcgkXivkgMbM8/QjH6dzHCsFJERA36W0AWSzCivxIAVvFWWq32Ll/0m80ROwCI8/a5xuySkSCKc9Y5/fh+sIBkQkEaejRsZ4C7VRf5HJZ9Qdkb4gmUFhZWNMZ9sy6emxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm7sDfRGhPpuTbCsyY5QpOp7bo1mF3Iu5poUu8QkNsU=;
 b=XotlWKcbSA2EWgLk+1hVuDLjbyWqhBgv9fiHjcbZgh3HYZH5yhZ1pc4rZ952LPTxmjw9ej9neFmHervm8x14DekCtJ1VdRniPYIKAEhzZn3nPjaLs73+dUKxNQxGi1ynwWvoK5ZaCaBIk4K3krMQc2h402FCENjjnF5csMe9oZ80lnbfKSQKh6aDoRUAOQdW8fBLKwcB+abxxjWgDc51EToV5sHW3relIiGJ3vwq5xOZId8PEH85+Yv+1AO1Vxka3wNVMzjIHcioDntYjOMKHeBbmeXHGt9uvb/L6lO4EQ8rsQefBsOSkJVDByEGYGU9Kgv/ghAXWKFJrJgdcML9bQ==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 05:51:04 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 05:51:04 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>
Subject: RE: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
Thread-Topic: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
Thread-Index: AQHXOF4qB/GkhG0T5ESzLET/7zFLw6rDRYEAgAVgmoCAAMw2gIAAywnQ
Date: Thu, 29 Apr 2021 05:51:04 +0000
Message-ID: <BY5PR12MB3764DC583BC2AFE0CA674DDFB35F9@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <869ec3a2-26df-2ce8-bd21-b681d6ef3985@gmail.com>
 <BY5PR12MB3764DFDEA8125650799DC76CB3419@BY5PR12MB3764.namprd12.prod.outlook.com>
 <bbcf6dbe-367b-38b2-91bf-9d5f4cd2c57c@gmail.com>
In-Reply-To: <bbcf6dbe-367b-38b2-91bf-9d5f4cd2c57c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad8acda4-644a-4ca7-938d-08d90ad2c705
x-ms-traffictypediagnostic: BYAPR12MB2997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB299712CEA6CF425BBC7FEF9BB35F9@BYAPR12MB2997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZG7vzEQKwpkTX+6fYgKIT0bJYkTnaXWE7TkDVVLEqnPQNojaFuSPlZnd2mRHYPwyUW6w347YC3wMoaNCt1NXZkwpIY8s4BT1tw8GU6Py2goWU0crvdgKUmyVs050/72nqz7V/41Kj4u8ejW5kxWUk/S/+62JmRhFBY7RDY9qhewHMVTKHILPUDB89gx4yzvrl1RZOGDRJfSqZgDn0fWfY7nXPikAucFJ49RseXAJnvkBtCJXAWveiz4s1MFH29twYeeKfJiDYT5L9ObCfwd/S+LCZVxQfLJkEDmG7FclXrpLKv+rW9EpTGdgHUMdqCqnMlsAWmEoNgYyfvad3MFs+hGR3WdRZj/yOS8ue17XOKF7sjqdRM+s9E7IZvHsk4q2DLR6oTQGC/UEL8qlO1wMP1CoCHE2m29WlRjiC6qtewZd/MuEWvD9iaXXkIs8mVDv50ActCnnuOHOop+hXsBNqhQf4/f0MD1oBasPLeQpvO5dg9D46lO+GousbY/sO0v6y2fBBAj+aSPswajUtLBfhEacAQRea9To6Of/wnwX486BRQvF2kaDii8l3TfWOH+pHk4xYI8Lkc/iq0nl2xHiygYWJVsijCqj9GoSDkgs8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(2906002)(52536014)(7696005)(86362001)(54906003)(38100700002)(64756008)(9686003)(8936002)(83380400001)(66476007)(66446008)(4326008)(66556008)(33656002)(6506007)(110136005)(186003)(55016002)(76116006)(71200400001)(5660300002)(8676002)(26005)(478600001)(122000001)(66946007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDhacHdCOWpJcjJIeEhmS2RSY0RQTFk0bHBndWRFZW1MWEE1MXhzVUZLM0ZE?=
 =?utf-8?B?T3pnNWl0ZTJyVVJKRmk2ckRNYlRyMmZBOHMwMEllTFVSUUZ3M3VLZ3A5TkJo?=
 =?utf-8?B?SDZtUEpoWFpFWCtxejIya1F0Nyt3S0hnYzhNVmZnL0VqYWZIOVBWU05uYmNM?=
 =?utf-8?B?S1o0NGhEWmpVaXBTSUlQL2lINGtLRjVqQTA2dTNLRFNCSzhLNE9KMTlQL1ZK?=
 =?utf-8?B?Nmt5aDlNT003YkRpSmM0SUd6Q3dwb2k5RHdCQkhnMlh0QXVMM1phMXF4VDFo?=
 =?utf-8?B?cEtLN3BCT3ZCekNwU2h6c0pJTDUrdDZBeVMwU2NQUHUzaDBFeWhHdmJ1ZHA4?=
 =?utf-8?B?Njd1S2owZE9pUnlEOUxUc1BLQjFUT2pPODdhTVZLeVN1dGNjUk1xOEk0eGlu?=
 =?utf-8?B?Q1U3MTc4emlnKzEwWjNQYmM5NE84cmlFQmN0YzY4Qm5nSGkrSVJ1ZVRJdTRh?=
 =?utf-8?B?bDVzdmVEUFpBYkpQSEI3UzFlQWhBY2lqVmJ2eUZqTjNOQjNheTIrSWxibnJ6?=
 =?utf-8?B?M2R1V2liZXhuSkdCMDJiTDZGdEVTUWpmbDA1b3ZTYkF3VUgrRVFRSTdoS2dL?=
 =?utf-8?B?dGNIZkp3Y1ZTR2psQWV4OGVxVlZKTGNPNndZUitYQWtWRHlSQXBYdnY1YzRj?=
 =?utf-8?B?cmpTSGpvN2pXUWJtaXBwVFNQTWFVNGpwVlljd1lvdUJGUlVlV0lQMmc0N2p3?=
 =?utf-8?B?TEQ5YjRRRHhSMVBlbFk3cGtFQ1o2TjBydmlTZE1yem85ell5dFZEa09sS0FZ?=
 =?utf-8?B?M254SHVNRU1ySTBWbUFtMnFFb2VKeHZCemhhZGd3cXdIMlBhaktZOEFRMzhS?=
 =?utf-8?B?OEZSTG10N2ZQZnlBbE1id2Vzai9RYk1FdVhxaXdoZUhndzdQOTdmUXd6Ylpm?=
 =?utf-8?B?M21jOU1hTVA0cVBxbDdtVDZEaDdLY0Q4T1NBUnJKRGFkSzM5Z2xaZDVaMnpt?=
 =?utf-8?B?a3ljWGlhSlh3WUYzUnlISEdHSXVFL0dxTGo5OUZUZGVHYzlBQ1dvaHd1eHZX?=
 =?utf-8?B?TnpQQTg0Q1U4N1pBRXZtYW5MOXBXajRkeGNKRXV2UXUrdEpaaW5UclJoUzE5?=
 =?utf-8?B?eDFub01PMzhxRmZKWm9JYmRqMDl4bmdpUnN3cHZYSWUzbWdEYW9XMitnRkU4?=
 =?utf-8?B?N1R4a1R6NnN5SHpIWFZTMmMwRS9ybE41Um10Vk11eWc3L1R5dlVRUVZiK2g4?=
 =?utf-8?B?SXltcHdKTzh5cWlFVHVGQm5SeVFQNWVWa2tKa3Z4bUMzbnlyWTVYVzlNM21k?=
 =?utf-8?B?Q2tBWXJMMlA3Rk5lUFhqNTMzeU5ETGc2Nzk2VFovT3dkUmJPclB3Y0VEdnJu?=
 =?utf-8?B?a1l4MldUa25ybDNzWTVYalZQSDhMTDg4Zm0rSjMvU3dmaWZSdHpNSTdLeDNM?=
 =?utf-8?B?c0dEeUpOTU1EQ2dFR0Z1ZllkdTQ4VHRMdWp6TkllSEg4V1JjQk5ldTJqQ2hj?=
 =?utf-8?B?K2czRVpJeG5uNW9LQ3NWa2QrTkwzREk4TU1HQVFEVms0MVZuNnh4d1k1d0lG?=
 =?utf-8?B?TGZhT1RhQUtZUUlpcmYyb0ZzU0MvZGpJZmh4dVhrWU93Zkxucm9Ua3BBck1s?=
 =?utf-8?B?NFZZWXlLQzZyQnJzUi9SSUhleXpTcExjSm5VR2U2a0R0SE1NOEprK2J1dU5j?=
 =?utf-8?B?YlVNNkZtblRWRFA4a0s1UklsY0VtMlhZZnlQNVZkekVNaGZUU1A0OHBoSSty?=
 =?utf-8?B?dWpONWF3bmIzVE5jenNwMGY4dzFzWGNKUytFajkwZm9SQmNHYW9OazBXSGhM?=
 =?utf-8?Q?NMKgcLwpxcni7MvKU3sWcU9+vuCcpeuHCL9EYNf?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8acda4-644a-4ca7-938d-08d90ad2c705
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 05:51:04.6578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2cU2LAypflEGc1pYIzqyqk8TDVB432aZ7eTMAn3QnsiK8fgx4HMM0A2ADvI49IeUUoXlERP9MDynHQTu/gCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
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

Hi Dmitry,

> Thank you for the answer. Could you please give more information about:
> 1) Are you on software or hardware team, or both?

I am in the software team and has contributed to initial Tegra SMMU driver in the downstream along with earlier team member Hiroshi Doyu.

> 2) Is SMMU a third party IP or developed in-house?

Tegra SMMU is developed in-house. 

> 3) Do you have a direct access to HDL sources? Are you 100% sure that
> hardware does what you say?

It was discussed with Hardware team before and again today as well.
Enabling ASID for display engine while it continues to access the buffer memory is a safe operation.
As per HW team, The only side-effect that can happen is additional latency to transaction as SMMU caches get warmed up.

> 4) What happens when CPU writes to ASID register? Does SMMU state machine
> latch ASID status (making it visible) only at a single "safe" point?

MC makes a decision on routing transaction through either SMMU page tables or bypassing based on the ASID register value.  It
checks the ASID register only once per transaction in the pipeline.

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
