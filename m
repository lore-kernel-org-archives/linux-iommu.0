Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04587C433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 23:38:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EF7611BF
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 23:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EF7611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EA15402B6;
	Mon, 10 May 2021 23:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgjznV23Fh6j; Mon, 10 May 2021 23:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 335214023B;
	Mon, 10 May 2021 23:37:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3F7AC000E;
	Mon, 10 May 2021 23:37:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2499CC0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 23:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F352F40270
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 23:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjvWUbg6-RrS for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 23:37:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 038A74023B
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 23:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDDHNixxmbJ3eayt/xo1JSY74DmOj8Gn6bOfSPkFGgSm2c17gNxwqk51yw/GH9+v2Hye3uyfTvhkDPliGoaVHg/UQta5l3E4+v2MpdGZ+Ef4ce49un5gLv45C5NbKtu8S6TB1TJHnHXE37AJp/L4nPFNuZ7sXN4pniz3sRmJdWN+VyLMqcFxGJNyhkQmD5et9FQUDaMh5jCz1qgUhlezFAXyAETyxJDfDwZcrSksBVmnUGjJn2CnsK95ktFe53HAX5AQWKawY3i42xgtsdNmP1bRaCSIZUkiT9Qdl4CBFhOo0QQrc/2/l00IcL96BNkbFSxZOaWFENI2wbzzlw/2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblVwsImx1hzRvOTWzY1SXFxUniUag82fEnedoc0nXk=;
 b=jRBSfF13pldtSTQ89Ha+nIFwt8hHWkIvOhp7ENrrrSM4xOUc+jPubij08gP8KSuQqK7c0j9a4PUpRFCnh96CtuxqrbukDOIAVnvfD/3l7mgX+cXpvdMeacqUginEIKhYAtVEqUgS5zzQo+Wb4MXVm4axrXtALJjTcPdZBfxQfBu5Pu/8TWV6EAEOn38ueyVKa07SPZ/9KiUulIOj5DGxuLD9MVqDK1KWAfXktxlD4y+lJCS4Jtp2AqLBgxIrEfr6VQtqIeg0ZQVOdFsVSRyUASD8J7Pr0PU/MUg9TqVuTyIo2otOvqyP6wx3Np6yp7F6iYMo9ciz0sajSQ5NDuNuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblVwsImx1hzRvOTWzY1SXFxUniUag82fEnedoc0nXk=;
 b=Crhy2vIsEqdeBOg3OcEUCsIaQp+ZzOge7IziiKU4wJzsGh05MoYNOlDDRC+t4V0ZFn3D5+KebkZQvLVVM5yxj+4XvfEp7nQCTwZTmaytUV2jiIX97NOv7BORojloLTQY+YtYvGkPRBk7WwVW4HdfI6qs561oyGqxvW1hChQsnJ2kJzh1kNeWgODSxdTbype3ZTFMyOHfJHwaz7tMGRd+f2Sb/kp8QaoUK87/1c0/47qrDJ5eE0eoOm95u7kfwnuJr7oH9GZ04BPtZ1Z3OPRYFohBKjSwLBQywP7XS/+tmAum/aNd4CIHLDBOWpBvkKc0nIL+U/NDo9Wg3EYxLmJaYg==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 23:37:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:37:51 +0000
Date: Mon, 10 May 2021 20:37:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210510233749.GG1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24 via Frontend Transport; Mon, 10 May 2021 23:37:50 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lgFTB-004yge-0w; Mon, 10 May 2021 20:37:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bde8ccb-029a-4d9f-7a9c-08d9140ca013
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435FD0257161490C18B32B9C2549@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ku8PCPPusA4/xW1QsD2GEgXFDfQeNNVEQ3VwLK4r18e92CY+W6tjtjmR5THP7G6beXBTMq+Aex8OENFiV6tFDj1elhPiA7VBf/KeaSMNE+Zav/tLg+UxurN5NDHGrzsSOOsW5HlCeAlJ3Pxkjn4bYhZ11ooJpgLbcScAxnJZZilMPiSw9i/7uadaohP000+xX4dS8jxVqrv8B5xduEWlG956WQ1Fs1JXMZD4zIzaNcX1XgnRomnqt2Cjy0czVfMKAQXAQwM5OGwmPHFCRv+AXe2KpM3F42f6Qru6jfX3eHmOXC4V25vOOaWjyyC2bY0yFb26USqQmBMmjaQR/9lJ8xTXjVcZ1WlniLW/V8chslWt5j3Rj1nyb+36DSWbPf9GzTxgk05NXOGQjSw0okaaHZavZMl0f8AEfooPTnS5nKtEsX+FFJ6doatjSnjAiR8WAdzNBs6Vp44RmLV6r5QnuHecwzKDPRDo+NYdxU8Q+y5G0VwQ6RZiPsIxfowpyZeiWS+h5wmoSMFpsfqwAbyO/nTyIn/JEPUM9owuKbjkvRWMg3ZFs51IXAGYDu5AubzYMzyqaJduPbSzuB1cuc1Z1TNu/kzx1ZyLGHsmKIdwMIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(8676002)(83380400001)(36756003)(316002)(478600001)(5660300002)(7416002)(2906002)(54906003)(8936002)(4744005)(86362001)(66556008)(66946007)(33656002)(426003)(4326008)(38100700002)(66476007)(9786002)(9746002)(26005)(186003)(6916009)(2616005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2ZxK3A2aGZPdzd3YU1KK1E5N2I5a0EzWnBHbjJLaktFWjJEMXJtSHlnOGht?=
 =?utf-8?B?SXZhMFo5ZXdreGxDbktCWC9GTXhQcTZjZ2Fvc0FtRkxZM2FVUmdmbld5R1lJ?=
 =?utf-8?B?YlpCbDh2YTRuaHg4VjJIa1B4bEVWakhOODFyR0NDYXM1OVVhV2t4QS9ob2dE?=
 =?utf-8?B?L1k4bGYraCtsSkJOYmhwZURybmZheFF6RFV3eExSZVR3Z3FkMDlCcThwTEJB?=
 =?utf-8?B?QzlGL0RUUEpUU3dtWHFCcUR1OTRETTdlbGtEZkxYNWRJMjBPTm53ZUZtUVJF?=
 =?utf-8?B?N004U0VQZGc0VWR3NDV0T2FiQ2x2TlNJVk01Q3d1enhFOHlKR3ZBQkhqbUtM?=
 =?utf-8?B?SnJFNmJUdW1xbG1lSDNud0p1VXZ5WnUrSEZqSVRCWmRtblgxak1FQlk2MS9Z?=
 =?utf-8?B?SDV5Z056c01BanYrRjF1aCtaN1pvRlVOVmQxOFlYbzlKZ2UyWnFBSGVtRVFv?=
 =?utf-8?B?RDNsNWNvZlIzRndHdEQwZTZYNFhPZS9uczV2d01TZytnRC94VHZVMDgwM05L?=
 =?utf-8?B?NlN2VnZTN2R2bDl1TnZMS0VSK3pHcnZzUUZOTlFSVXlTQWFkeDFiS1djRTQ1?=
 =?utf-8?B?MEd3WWZ2QTB6eVZiK1Q2ZEY1UjJNVFR5T0dTUWFpdTArUkN2RDZzQkFRUUUv?=
 =?utf-8?B?ZTRmYzc1RUhkVGlMTG5DMldYWHEzUmhnV0tBaFd3RzYzcHlKVjRxOStlN21T?=
 =?utf-8?B?cThtS3d2M2hhekJ2d3FnY2E4aGpzb3ljcG8veFBXSGp5dzUxVllFTlJ2NGl4?=
 =?utf-8?B?c1Jrc3JqL0lJdXpXUXk2QjVCTm1HcVZlOXRpU0VkOE04d3E0dzVOSWFzR0xH?=
 =?utf-8?B?eit5UHA5a25BQ2xxa1BVOXladEVHYTltMWNWRXIrQWowV1Mxc01rVXVjTE91?=
 =?utf-8?B?aXZZTEFVVGlDSFdOTnZId0xYc0c0SVdiYzVLRlF6TzJMT3FwbzVSZGplTjdY?=
 =?utf-8?B?WmJ1K0VmK2gwa1l0cHliVVI1V3RrL1BpVVVwQ1NjYkRSSjV4SGlPSzBnQmVp?=
 =?utf-8?B?MTVQOFJpVkRjRXBJWSsxQUMzUVNVVEdIeThyYUx2ZlJsQ1IybDA3bjFiaGNS?=
 =?utf-8?B?VXRhSHVHcHN5S24zLytJVFA2OTNUajFjYm5FTjdEc1hCYXRjemRYZ0s3WlhM?=
 =?utf-8?B?blBSLzdnMW5QRmxFdjI3czZPMGNIQjRJMGV6dWxSL1p3R1AxT2RmaEtDSEs0?=
 =?utf-8?B?R0d2OW5zd2twKzM2eEM0QkM0NHVFNktIankxOHpXbXYxcU9BWFB3V3BmTC84?=
 =?utf-8?B?RUFUQURoVVhxdzFrRjFKeXB3SE9UcnErT1k5NE9tMjhYeEVRc1QwcDA0SjlC?=
 =?utf-8?B?UmoyMGFkeXI5MEJqL1Q2aVB3ZDc0RzVNUDNvV3pORFRYcU53cGpHR0czRzgx?=
 =?utf-8?B?Nlpac3JzMHBVMEdybzFONUpGVWdpRDZwbDExM0FtY2oxRE1vQk1uZ2FycldS?=
 =?utf-8?B?bEVQbEpURzFZWnE1bFhnb2plbWNGQVFjYUF6eTg5eUFUYUZVc3FYQ29kaGZT?=
 =?utf-8?B?dDV1U3hMY2FyMFZsL0kyN21GZGlWY2xzbFZwZVRWS2o3MGwxdHNXRFNzczF4?=
 =?utf-8?B?dzhjSEQwUVJRMkdpcnQwWkREVER3a2xPTEt0OWdiTXQ0cEtWVjhjYno2UHZD?=
 =?utf-8?B?M05Ia2pxVnBTT2ZjK3ZDM0FjWWdRdmZGcmpDZm9xYW5TUHNEaU9RdlE2SGJ0?=
 =?utf-8?B?VnE4WFF5ajlCc3NJdmVVUFN4dEFEOFlMekV0SEJySUNPV1lkRHFXbWtJU3NN?=
 =?utf-8?Q?UYK3qPMhnHJDFz0PaAF5Z6/1xio7P1Lcp6QrXnC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bde8ccb-029a-4d9f-7a9c-08d9140ca013
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:37:50.8309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr8W75SAARW3PxM7deYfO4OCD3GyOi5Y8r2xoM3nwaY2Ei3gM8Ha/05Ht4Cot3IX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgMDY6MjU6MDdBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
OgoKPiArLyoKPiArICogVGhlIElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1IgZmxhZyByZXF1ZXN0
cyBhIFBBU0lEIHdoaWNoIGNhbiBiZSB1c2VkIG9ubHkKPiArICogZm9yIGFjY2VzcyB0byBrZXJu
ZWwgYWRkcmVzc2VzLiBObyBJT1RMQiBmbHVzaGVzIGFyZSBhdXRvbWF0aWNhbGx5IGRvbmUKPiAr
ICogZm9yIGtlcm5lbCBtYXBwaW5nczsgaXQgaXMgdmFsaWQgb25seSBmb3IgYWNjZXNzIHRvIHRo
ZSBrZXJuZWwncyBzdGF0aWMKPiArICogMToxIG1hcHBpbmcgb2YgcGh5c2ljYWwgbWVtb3J5IOKA
lCBub3QgdG8gdm1hbGxvYyBvciBldmVuIG1vZHVsZSBtYXBwaW5ncy4KPiArICogQSBmdXR1cmUg
QVBJIGFkZGl0aW9uIG1heSBwZXJtaXQgdGhlIHVzZSBvZiBzdWNoIHJhbmdlcywgYnkgbWVhbnMg
b2YgYW4KPiArICogZXhwbGljaXQgSU9UTEIgZmx1c2ggY2FsbCAoYWtpbiB0byB0aGUgRE1BIEFQ
SSdzIHVubWFwIG1ldGhvZCkuCj4gKyAqCj4gKyAqIEl0IGlzIHVubGlrZWx5IHRoYXQgd2Ugd2ls
bCBldmVyIGhvb2sgaW50byBmbHVzaF90bGJfa2VybmVsX3JhbmdlKCkgdG8KPiArICogZG8gc3Vj
aCBJT1RMQiBmbHVzaGVzIGF1dG9tYXRpY2FsbHkuCj4gKyAqLwo+ICsjZGVmaW5lIElPTU1VX1NW
QV9CSU5EX1NVUEVSVklTT1IgICAgICAgQklUKDApCgpIdWg/IFRoYXQgaXNuJ3QgcmVhbGx5IFNW
QSwgY2FuIHlvdSBjYWxsIGl0IHNvbWV0aGluZyBzYW5lciBwbGVhc2U/CgpJcyBpdCByZWFsbHkg
YSBQQVNJRCB0aGF0IGFsd2F5cyBoYXMgYWxsIG9mIHBoeXNpY2FsIG1lbW9yeSBtYXBwZWQKaW50
byBpdD8gU291bmRzIGRhbmdlcm91cy4gV2hhdCBpcyBpdCBmb3I/CgpKYXNvbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
