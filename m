Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA29FC47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:07:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6331061921
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331061921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3018983D1F;
	Wed,  2 Jun 2021 16:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uxwJlXEEUaa; Wed,  2 Jun 2021 16:07:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0731D83D1C;
	Wed,  2 Jun 2021 16:07:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88419C000E;
	Wed,  2 Jun 2021 16:07:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 495D6C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A74E60ACA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZwH2Gvd1XbD for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:07:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC6F260776
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moE/tftfOuQl/n3wpVOmUomv3GNGo64894oNQgLmTpojX2QPKWUQz2TVYpGB0QqYZWCbYJqdjfoa0GQOtMAQIdK1KxJ/1zQjUIrAeZFTylCslEHeMdCC7u92gRX9fdkn5SPLOKg60+D1V1xsoCqv1dFHDjtsim4CnWl2Wen6aUBq6Lmrf41UL5QTh5CD6x9aRib61r1+PQPT1gIR4GqpcF5eiQon2g5XRLBBkCEgMogoy3RYNSVASE6WiFBjF5GUM7etthmEJzhOk6aaHcLll9aYzo8yN8Znnj4oiimv/rp4HrRf6GxhN+iUrcCcatBX6IxYqCK2x2gMOEIKK17MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXxVVVjsUITA1BeRCS65X1i6eOYr+zynRbuJtxbzyzE=;
 b=K2zoTH9T5NmVVzHzb+TrSSRHkrGRuaFypr0oj3j72GH7q5TcN7EnF+EbcFXeZggD4WipdVUuQ0rM6V9HhXBlLbEzgugskuk3GSjzLNBA3zgSuM5L3n7htNCLNrXacNgQEbTrZrUxm2Zyf2qUyEHKAj/x4CJM2/3pJMBkoUoj8xOk0E+dCCgo+qfOJ1yk4AC+0KIsjhzDC0qW3BF+CB7MZ2nDYW/MSTcWKWyEsQIduv1opEX4/h0mFRGdfeg1/+ladA+tJWpGp+hN5QAC3n2TYD7y6jSGKqRfht5j/BICKo4JfBbrvuVMnVoJcWvr2fSHXmG953GXvAqX+ebkK5N58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXxVVVjsUITA1BeRCS65X1i6eOYr+zynRbuJtxbzyzE=;
 b=f4Ib+M/GYvejCZRkKzTuyoHG20hsE6x42HZItoWOFBK2pCLS9FT2BFiue/jSn/QWg+vPzby+izDaekFmtyHmFm7OABLn7UZhkr4FwWO+rF3j3NpX9mwMGMF3DAZZeSZN8W8lpwovfVoHJ6wInriq8IRYTm3Dw2yiI7eakeKRl6zjEi1Jl4udGRMCcOtF/6gt4L+sz1ngwuDj4OK0LReC3jpI3TU8iaJLuJE9ONj9uAYhcLAzUWTQfULcM/l4ufAvlMC6SwRsQjVKvwPjng7lNGb7GYkRiJMzxKDI1MHmFhfMx2xE8tOIWt4jX9tLN+DRFhTK5Q9Gk/jft40/Q0+JmA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 16:07:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 16:07:10 +0000
Date: Wed, 2 Jun 2021 13:07:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602160708.GW1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601202834.GR1002214@nvidia.com>
 <1a3b4cf2-f511-640b-6c8c-a85f94a9536d@redhat.com>
Content-Disposition: inline
In-Reply-To: <1a3b4cf2-f511-640b-6c8c-a85f94a9536d@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR22CA0005.namprd22.prod.outlook.com (2603:10b6:208:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 16:07:09 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loTOe-000HKt-Kn; Wed, 02 Jun 2021 13:07:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffe30a4-594d-4e64-9a60-08d925e079e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53618763B03E2F6D5F33CA3EC23D9@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wksudrp7SltA9HDruyozKcvqhpfUN9n4eoPtGVqDQzdhNyOwcUK5voQkJ4k3U0UbkcUVMYCSksjkLHCqeP4ar9E8mgcsJCf2Xp3VaPK/vuGbuymFx3uUukXeNCw3R7vaXLKJBQUl+2ClQoy+2j5uxx4TK31udstFbEuS8m0GmlA050QYzQn5hdDEAZyjd+QeUF7N6GT5cgnHkTjzayvPuySFeVp2HRziDJy8g7EDHAJ/oWpc3LIny9gyZK3LLi8VsNsWlvETLUXvZN2ldZBK/Y5+S1eAwgk5FNANxZRWdjMTQnF4WjnU3icpOm3gag3nyn+zz6PE5vz8X98ZoNZUxZEzayVBCFlyVqvlQJf6PzHY3gNOpLUtrxIb38FQnMigkYGVLnP+hu6MiheryQoLqrW1ANYdzmiVQh6nO4CG1oXUEX5BehQy6ANidM9CxQ0GeBNqJn6MFnpTPmC7v8ZHlbKDa/CQeLUIs6mdCKZqZ0g//TPA/Tg75Pt1SCdcMr0uqCMVgJe4WryNDFU8TICpgeB5PFFRrnYeZDDoBVRF5kR6+OWZTJrq0SkjGfykcatJgir9cbTEY2WvS0zU09pMOf1E4FnVyEmsgcjZQ/D/HZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(5660300002)(4326008)(426003)(7416002)(36756003)(38100700002)(66476007)(54906003)(8676002)(8936002)(33656002)(478600001)(2616005)(6916009)(66946007)(9786002)(2906002)(9746002)(186003)(86362001)(66556008)(26005)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHloUzhFVjFrbGZaWFV2Q0NNOTFVcHBOaXczZkdwSGNOdnc5cU12N3NiZmhY?=
 =?utf-8?B?ZzRlWktoUEV1TUhRRTI5SnpYTDd6VHFEMWZiZDNJK3FtUmRuZW84VFErbVhH?=
 =?utf-8?B?bTNiT2tvOE0xZWNpL3A2UmQ3VFBrTy9ZZW5oenJlMDhPNWtydk1PbWVhb3JQ?=
 =?utf-8?B?Uyt6RmNtMXJBbGxiKzlidy9QcWlxMkwxM2tudUVmQTN0R2FQalJQNDU4ajMw?=
 =?utf-8?B?OGtpOEZlclhmYTdsZ3cweVp6UENyUkQrcC9DK25aYld6WThzeUVpMUtLNWZQ?=
 =?utf-8?B?VmJ2WVFhMlRtcXZwTmpCQ1o5ZUZ6KzJwdC9wdnpobE5yM0ltQ2dZRTF4NGli?=
 =?utf-8?B?V0hhU292ZzBqR2w3NXNCWll1NjlobktBN1dqRTdlWGVneXVlVkZyMmttRUJV?=
 =?utf-8?B?Qk9GSFY3RHJ0TWZIZ005enZUMEJQMTJxckFuUHJOUEJBZzE3aTVidmcxd3cw?=
 =?utf-8?B?UHhZYlpFQmtseFFzNlhjWnhnYXYxRHB2N3dKUHR2QVRLSUdybzdLclpMSFhm?=
 =?utf-8?B?bXd0NE9hSmxVU2lCeDN3RVpLZ3hRRlpKb3AvNTB3Tkk1SmlINDRqbTl0SmlJ?=
 =?utf-8?B?RWIvNTRqZGJsRDdiYUxwRThzYThaYmNXWE42N09rUnN0MzJhY1hlS1JtU1dQ?=
 =?utf-8?B?aVpHb3orZU92U1JESnFVSi9Mc3ZheXB6WWhRbUFnbFdWZTJIeXhCWlpjMEYz?=
 =?utf-8?B?VzhsY3RFZVlka3d6YXVtTHA5c3YzSm10TWpPOVpGczJLZVZJWDdZeUVqMUdi?=
 =?utf-8?B?cHBrS3JUT1dYUWFLS08wQjk2dlBXV2t2eU1iYWk5ekNJS0h2UmZ6S0syREp1?=
 =?utf-8?B?VDhWMFVrNnMzaFFlajJNNjFtMXJhdklvQ3V3QVFOeTNiRjRoQ1B5QlFhT1Fl?=
 =?utf-8?B?Rm1pdnZRNm90SHVwdmk0VTg1L2d4Z3JncytSS25lbHpxZk9lUTFHa1Nld3Ay?=
 =?utf-8?B?dEJjaWxJNThZdlFsajgwcWhpVHFQdGJoeGtFMjQ0Sm9HMS8xVkRvdFNtOVZn?=
 =?utf-8?B?UkRodDRGcm55UVN5WVlEUmZMekJQakdzVlJPTDNsVW5YR3M1TXg4TWV3SHVE?=
 =?utf-8?B?L0taQ05JQWxHczR2RU83cVF3S0syYkt3V1NBZ0h6TFhNQkx2T0p5RnM0UU5U?=
 =?utf-8?B?M3A0U2Vacmp6NzNBNFRpbDBaT1N2RTJGN1grL0lOR3hCYmswSEtlVm1RZUNs?=
 =?utf-8?B?bjh5N2h5NDJRdmV4UjMxWGY3eCtnb3NvZVhLUGZXMmIvMnd6QmZoNlI5L3JH?=
 =?utf-8?B?elNPM3ZMRlZvZlBXMVdGUTl1dHh3di9OTnAwWVdxWERKVXV4NStqbW9Uelcx?=
 =?utf-8?B?Y25ROE5uRVFuWkZJbjY3c2xKbFVYRStxUHhqMmJHaTR0RHAydGtBNUVVVUk5?=
 =?utf-8?B?eS9lcXRvR1pMMnZ3SVRZbkYzOXpzMGVYVWJtZG9zZGdzRnN2QTc3TUMzeGxW?=
 =?utf-8?B?NVVLWkJKcDExVGZyQ28xN1I3N2lTR2FOSkpzNDc3UE01a3pkd05TUWhlbTgw?=
 =?utf-8?B?UklSSEh4Q2R4a1VybFo4ejdkODZvcS81TWxtNG5KTjN5TGZwWTU4VFJrR3Y4?=
 =?utf-8?B?NUw3Z2lLeU56QWdrenhPSnZjc2xwc1B6dEZzaVpKZURjLzJsb2JUNGFRbkNX?=
 =?utf-8?B?U3d1TGhrN1dDdVVIWEtBOVpKYTJTY281YjlSNElRWDJndGV0VlZyeEpRTytO?=
 =?utf-8?B?VXJpN1JoZExVRkY1YVJzNHQ1R3h4cGJxeWU5cVI3di9LcGxaOUI2Q3N5OUhw?=
 =?utf-8?Q?JWiqRyDNgNPDxGgmC7tFDuMoBDccZI9UMc7POpE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe30a4-594d-4e64-9a60-08d925e079e9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:07:09.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCGhwrbb4QxvyKypzrvDS0ggAqW3UjQ0udJpNtipnD9uKSDzCjLKNPzUljxIQRI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gV2VkLCBKdW4gMDIsIDIwMjEgYXQgMDQ6NTI6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzIg5LiK5Y2INDoyOCwgSmFzb24gR3VudGhvcnBlIOWGmemBkzoK
PiA+ID4gSSBzdW1tYXJpemVkIGZpdmUgb3BlbnMgaGVyZSwgYWJvdXQ6Cj4gPiA+IAo+ID4gPiAx
KSAgRmluYWxpemluZyB0aGUgbmFtZSB0byByZXBsYWNlIC9kZXYvaW9hc2lkOwo+ID4gPiAyKSAg
V2hldGhlciBvbmUgZGV2aWNlIGlzIGFsbG93ZWQgdG8gYmluZCB0byBtdWx0aXBsZSBJT0FTSUQg
ZmQnczsKPiA+ID4gMykgIENhcnJ5IGRldmljZSBpbmZvcm1hdGlvbiBpbiBpbnZhbGlkYXRpb24v
ZmF1bHQgcmVwb3J0aW5nIHVBUEk7Cj4gPiA+IDQpICBXaGF0IHNob3VsZC9jb3VsZCBiZSBzcGVj
aWZpZWQgd2hlbiBhbGxvY2F0aW5nIGFuIElPQVNJRDsKPiA+ID4gNSkgIFRoZSBwcm90b2NvbCBi
ZXR3ZWVuIHZmaW8gZ3JvdXAgYW5kIGt2bTsKPiA+ID4gCj4gPiA+IEZvciAxKSwgdHdvIGFsdGVy
bmF0aXZlIG5hbWVzIGFyZSBtZW50aW9uZWQ6IC9kZXYvaW9tbXUgYW5kCj4gPiA+IC9kZXYvaW9h
cy4gSSBkb24ndCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2UgYW5kIHdvdWxkIGxpa2UgdG8gaGVh
cgo+ID4gPiB2b3RlcyBmcm9tIGFsbCBzdGFrZWhvbGRlcnMuIC9kZXYvaW9tbXUgaXMgc2xpZ2h0
bHkgYmV0dGVyIGltaG8gZm9yCj4gPiA+IHR3byByZWFzb25zLiBGaXJzdCwgcGVyIEFNRCdzIHBy
ZXNlbnRhdGlvbiBpbiBsYXN0IEtWTSBmb3J1bSB0aGV5Cj4gPiA+IGltcGxlbWVudCB2SU9NTVUg
aW4gaGFyZHdhcmUgdGh1cyBuZWVkIHRvIHN1cHBvcnQgdXNlci1tYW5hZ2VkCj4gPiA+IGRvbWFp
bnMuIEFuIGlvbW11IHVBUEkgbm90YXRpb24gbWlnaHQgbWFrZSBtb3JlIHNlbnNlIG1vdmluZwo+
ID4gPiBmb3J3YXJkLiBTZWNvbmQsIGl0IG1ha2VzIGxhdGVyIHVBUEkgbmFtaW5nIGVhc2llciBh
cyAnSU9BU0lEJyBjYW4KPiA+ID4gYmUgYWx3YXlzIHB1dCBhcyBhbiBvYmplY3QsIGUuZy4gSU9N
TVVfQUxMT0NfSU9BU0lEIGluc3RlYWQgb2YKPiA+ID4gSU9BU0lEX0FMTE9DX0lPQVNJRC46KQo+
ID4gSSB0aGluayB0d28geWVhcnMgYWdvIEkgc3VnZ2VzdGVkIC9kZXYvaW9tbXUgYW5kIGl0IGRp
ZG4ndCBnbyB2ZXJ5IGZhcgo+ID4gYXQgdGhlIHRpbWUuCj4gCj4gCj4gSXQgbG9va3MgdG8gbWUg
dXNpbmcgIi9kZXYvaW9tbXUiIGV4Y2x1ZGVzIHRoZSBwb3NzaWJpbGl0eSBvZiBpbXBsZW1lbnRp
bmcKPiBJT0FTSUQgaW4gYSBkZXZpY2Ugc3BlY2lmaWMgd2F5IChlLmcgdGhyb3VnaCB0aGUgY28t
b3BlcmF0aW9uIHdpdGggZGV2aWNlCj4gTU1VICsgcGxhdGZvcm0gSU9NTVUpPwoKVGhpcyBpcyBp
bnRlbmRlZCB0byBiZSB0aGUgJ2RyaXZlcnMvaW9tbXUnIHN1YnN5c3RlbSB0aG91Z2guIEkgZG9u
J3QKd2FudCB0byBzZWUgcGx1Z2dhYmlsaXQgaGVyZSBiZXlvbmVkIHdoYXQgZHJpdmVycy9pb21t
dSBpcyBwcm92aWRpbmcuCgpJZiBzb21lb25lIHdhbnRzIHRvIGRvIGEgc29tZXRoaW5nIGNvbXBs
aWNhdGVkIHRocm91Z2ggdGhpcyBpbnRlcmZhY2UKdGhlbiB0aGV5IG5lZWQgdG8gbWFrZSBhIGRy
aXZlcnMvaW9tbXUgaW1wbGVtZW50YXRpb24uCgpPciB0aGV5IG5lZWQgdG8gdXNlIHRoZSBtZGV2
LWVzcXVlICJTVyBUQUJMRSIgbW9kZSB3aGVuIHRoZWlyIGRyaXZlcgphdHRhY2hlcyB0byB0aGUg
aW50ZXJmYWNlLgoKSWYgdGhpcyBpcyBnb29kIGVub3VnaCBvciBub3QgZm9yIGEgc3BlY2lmaWMg
ZGV2aWNlIGlzIGFuIGVudGlyZWx5Cm90aGVyIHF1ZXN0aW9uIHRob3VnaAoKPiBXaGF0J3MgbW9y
ZSwgQVRTIHNwZWMgZG9lc24ndCBmb3JiaWQgdGhlIGRldmljZSAjUEYgdG8gYmUgcmVwb3J0ZWQg
dmlhIGEKPiBkZXZpY2Ugc3BlY2lmaWMgd2F5LgoKQW5kIGlmIHRoaXMgaXMgZG9uZSB0aGVuIGEg
a2VybmVsIGZ1bmN0aW9uIGluZGljYXRpbmcgcGFnZSBmYXVsdApzaG91bGQgYmUgdHJpZ2dlcmVk
IG9uIHRoZSBpb2FzaWQgaGFuZGxlIHRoYXQgdGhlIGRldmljZSBoYXMuIEl0IGlzCnN0aWxsIGRy
aXZlcnMvaW9tbXUgZnVuY3Rpb25hbGl0eQoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
