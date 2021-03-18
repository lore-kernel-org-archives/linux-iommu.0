Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA76C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 00:00:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E13F64F45
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 00:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13F64F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38AF160699;
	Thu, 18 Mar 2021 00:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVPp6TZsKqv7; Thu, 18 Mar 2021 00:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2080B6064D;
	Thu, 18 Mar 2021 00:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05191C000A;
	Thu, 18 Mar 2021 00:00:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF193C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFD3983417
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47TqcgewXe4e for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 00:00:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D24298305C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 00:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFjNkXfkUatmzBvnb/8aMVB2ptgGVtX0iCzDcgqhwcWs/or0cJdqW0izt1yf0qnvKnMVt+GEkwBoE4FQRBZm+6qtRG+r77PAB8qTJbgDP1BH63YcparXJdIl0N2qOt8PpQ/lYaTUrp7GwvJm/pTV9ZMtiBRnh+HGeJCgTFeh5JpfY3eXoPveFiLxAG1Nm4CBiJSe9sNBP7Xxo5hIp+rjEG36aTTh1s/vRgF+4hL6I4dQ570R53Hn7pqCRN5slHPtD6dlu+xIF+9s5Qt1++alwh1M3ePapefNwlcckm+wvfOioB+TxL7Ep4hKLna5xHmu7+Es5WepaVEImNOfc4CSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoOX0+1cYBs5W9FMUxXX8XsF/A63kw5z7FDellyu9oM=;
 b=FqEcfVi7hjbp/gElCh77N8Qflj20zJwz/eEjJbsqKASZU3frj4+mJgsIBtJxpuAId5dPVO8mu3KkkwefEFwKoBfrieAClWhI8fJkEyLH7QC6AXLkRwMSFrb1/fLY0X26bLLF1v+j1pH6mToDgM+nGiG0nhnYldpvLkS3FBPnGbCBG/t5sgBWyiiNcYnKSycqz8y37VX8jB2BV93bnG4XHQAqzNlZ/Dl2adJdnxGAHb4RpfscsC3ZyzJLTWBnAcfg7G2gXfq/VurZklBIZg5o4KTGEEQ2Mqx2naAHQVXAPTu6A5zUrVbQeRUIfmxe8U0S4223WsMNRKFOVoJn2SPCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoOX0+1cYBs5W9FMUxXX8XsF/A63kw5z7FDellyu9oM=;
 b=VnllamvSQwaup5TUf+MrkpO3DMxEVpw/B+zMD8VdaN5hA+ZtpORYSc4rLcW6GFjcR4dpqEDrvo2++W9ztDg8Uem+hyQQycQjIA//ByITFpa6XoDyUyo+KlpNm0y5oWWLvPurHo2q3q1woudXy5yb72rwPU5GRCzjBkjYjjkyybQH+tgJVuKEKhVUWf0/Oq2XaT99Jb0Y7hipqJReb3UX0ykYJ7TlnReuINwNFdILGrhNNatyrO7vAVU6JA4E4W+5kjsKwOs0a4EmnXFZ34ylWXigZwKRGkjszt24H1H0az1rIJx82YmrCErPAwf3Uq7xXcVxkZ9T0MHgdd9iW6myag==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 00:00:30 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 00:00:30 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, 
 "tn@semihalf.com" <tn@semihalf.com>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>
Subject: RE: [PATCH v12 00/13] SMMUv3 Nested Stage Setup (VFIO part)
Thread-Topic: [PATCH v12 00/13] SMMUv3 Nested Stage Setup (VFIO part)
Thread-Index: AQHXCihQnUqzDFTrxEGOO4/cVIU6g6qI+xPQ
Date: Thu, 18 Mar 2021 00:00:30 +0000
Message-ID: <BY5PR12MB3764F91C594F666260D7FFECB3699@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
In-Reply-To: <20210223210625.604517-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d806201-03d6-4611-ad43-08d8e9a0d864
x-ms-traffictypediagnostic: BY5PR12MB4148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41484FDAF749E09CA6E6C729B3699@BY5PR12MB4148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Mv5Kh5b4JU3SYjvffakPwvAmdO51wzc6T4ZIitcyozXL3tmY5uFWPLqU74aLIRxcu260KoKWJjDovsJd7hmKc2dcXkkASpowaOBw3Sbewmr0RzrjoKa3W2t+oJd+7ekUZlS+eRxIhr/dlH1FOPdwYpKHmAR/LFRUz2aHgxJo5m5f+/dewx65YrLoAiUH6rF3XltnvE1huIy0KWztfTz9plG8AWFxFxRdnaAvBeAOUY8UYbFeRbQGH1T78Ec0GeaIgbhS6uCvA9BBUBVOIhG5VxgvrwNisCrPooE/WPLS+5A0F5VXCYa/t9TwLKjjJYpJ5zyOjFp2DZWqW3KhQ5DASMRQqv3aq648eBaZTNa1AbBcTT/eYlGZXr98eIoL/H10xkXhJaWzaEuVuIahnVFI1PX0lFI4XZIl3giL1NJIWcGiKpF9azERFDS4/hpcn6WwZV2+ugtE9v1mLFrmcpKDlKsnQAQZfzeXxRo8d6htwAF7Y+OqIictRynQ+MyAaRdGHF5JlHiGhOrRya0+rOQJUa5IUpGGB2rHVP+cUxGypn/kra9Z5tEpAJXgi08uJLH3zdmYTED9pQwOggi9qAEseFVVpFU6Oic8sSaEoZLfRfqSJyXRRjzupaQXd+GGGrVkuxEF9+9Oy7J7rrdtXfmew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(64756008)(54906003)(66556008)(66476007)(6506007)(76116006)(66946007)(66446008)(55016002)(9686003)(5660300002)(110136005)(52536014)(7696005)(83380400001)(316002)(33656002)(38100700001)(2906002)(8936002)(8676002)(7416002)(186003)(26005)(86362001)(4744005)(107886003)(4326008)(478600001)(71200400001)(921005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9hZrdYom431rnFfoYdEOT2GI6MASDMfmidzBOEydQCvPdc/X3uoYEaFoRGeQ?=
 =?us-ascii?Q?q/FCtgb4lCDLTTbm3HUc+qfVNaL7o/zqclz7XasVz+y742zUkDMZWkw7Y+IH?=
 =?us-ascii?Q?LvwYReOfGFS5m9w2KmSMnv9snvsXUOQO28smo6PjmQbGme/iyRpt5nF0l0WO?=
 =?us-ascii?Q?1Wc6o2WdxY4NK2HmUsDJuaUwaimHUHsm4hL4Ke0aZbmcsLr7p9Nvd05eo8Fh?=
 =?us-ascii?Q?k77G8GNF6PVhXqQgE++mYMYegxynFypMHbjWu7iuCLYFJ+EyVkjysmCGZkNZ?=
 =?us-ascii?Q?rb5WpuvM/R5gO4yVtEeh9pSQAOYLByj2dX/E5+7ladxA3uTe/dfXBkaQ7xwC?=
 =?us-ascii?Q?Yq1nZCN7CszNaCPVtKWV5C75Qe9q4e67NGoBCaG361kXe77lKtF3D7cu2gha?=
 =?us-ascii?Q?WwUKOJo+xBidIp7kzgFH7gdZBWj250W3LEgL2+YH/OFG9z6yfYYQcCH6FfLZ?=
 =?us-ascii?Q?VyoO4DFzgjHiiXhIPIx5Hg3DrQSOAx4F8zy5wfhqH+PzvY7fBpKxpWYvLl+E?=
 =?us-ascii?Q?AmS3LAiACtBfFcIa/N94i6brcqlIoz7GkAgUlPeJbk3C9qKsxZBM0YRhAj+Q?=
 =?us-ascii?Q?cBF4gSGpWcmhyfgJ0VrSrsZJk0k53sQIWuINTKWXto5iMZjhoI0djau8pWec?=
 =?us-ascii?Q?Uy41YtXYmHukInc702fYGLSIOI+vwp0iPs2h/BjjU0ZSPgceD0Gp8Dc4zo/c?=
 =?us-ascii?Q?e6AFDEjjGUyvQOAKndLI4GXKZ4w/mDt/kqQy0TH7Jr7lXq1W0oiMZ2GKK/RX?=
 =?us-ascii?Q?Wy0mP5Wku21UHaPcsEsZ26s/sojs6lkQWdcuBYTRm9THDyZdOKCfzM1NH+UK?=
 =?us-ascii?Q?Gy06RY6tBQw+O4y6CqpjjmOxoZEovJsY8cB34POEBnSLxfATpEmHvyASe3xI?=
 =?us-ascii?Q?SQVV1KTRFSg9hreVOQ18xl2VxIygbYGgvttRLbkTulqQIAqDrtlgIq9Zku40?=
 =?us-ascii?Q?Enfe7mH+QY+qSjqZeOArsLDqdAKMKG6L+4WrVIF+SLNrbpDYJD8r8Z60HT/X?=
 =?us-ascii?Q?RNUU6sZPm4HfqklI4JELg1O6DnnOjlkMjsE2cv1ga/hoi7eUrzXcKHyfyrlr?=
 =?us-ascii?Q?GARX1TQ7uD/buChBR7Tg9ug67vfVbSE342lQPeK0purei9T3q2f7GiFGC8Q3?=
 =?us-ascii?Q?EdxY2DnkV3Il4BQ36xJCb8st/EOCqb2sdOFcTeqLJTrhcb9BukKIs3B3ez92?=
 =?us-ascii?Q?gfxSbc9Wu0thggw6nNECRfaujLRnlgtVhI7xe+6ahHfFKY14EuZkErxGMuf/?=
 =?us-ascii?Q?mMpDRezIZDqcnyPD7zAyNqk9J+6/4QcGjrAI8qChlqK9EX0G/jGBWqwQxgAg?=
 =?us-ascii?Q?foKdJunmggTalYofpxLxN2ll?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d806201-03d6-4611-ad43-08d8e9a0d864
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 00:00:30.4302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPBymNbiRPcchysXXllgsVPWYzJgYZHs2DgO+cYQHPr76MUGE4Z62bKCQoaMY32pGVT9ykB/ZYIPxmQV+Ubopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Terje Bergstrom <tbergstrom@nvidia.com>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 Sachin Nikam <Snikam@nvidia.com>, Pritesh Raithatha <praithatha@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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

Validated Nested SMMUv3 translations for NVMe PCIe device from Guest VM and is functional.

This patch series resolved the mismatch(seen with v11 patches) for VFIO_IOMMU_SET_PASID_TABLE and VFIO_IOMMU_CACHE_INVALIDATE Ioctls between linux and QEMU patch series "vSMMUv3/pSMMUv3 2 stage VFIO integration" (v5.2.0-2stage-rfcv8). 

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
