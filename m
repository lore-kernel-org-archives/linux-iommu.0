Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E60C48BE5
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 11:47:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699FA61426
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 11:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699FA61426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3694A60727;
	Thu, 10 Jun 2021 11:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyrcDRsxTd7R; Thu, 10 Jun 2021 11:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23F8C606E2;
	Thu, 10 Jun 2021 11:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08CAEC000D;
	Thu, 10 Jun 2021 11:47:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB52C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 11:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F97540129
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 11:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oF6V6X_wdlWA for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:47:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F11634000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 11:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWxBLm3hkS/FtYGXJOlq3v9YD+YXsxbQu2yFlKDGDsf6PI9K4vImTMGg7O0m1U5h36RMppfn0h6duh4v6lFkwccdSmL3JalD4+58BZH+7XW19QtJPiy0ZMzL6lgsu43OxEyTpeYFPVLBdxNoaq+c4VGSNJVpsPL3R6e+mGB4OYMTiHCnBqQGxuEVzjWotPoTfJ/TBHX+van5hVHubfzWHsA2cuxNrfj3s8+C9f+0owiLC8lxkVOqlS7dHpIpOK7ehFNBNjnkS9FMUmGlBOVhTCh8Q65oZkeRYB1OG3UFG7gdjyXeAwiefIIzXg40tHBD/cNEtyBvXsNj52fpm3iKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcFNTVy8G63q5bzrF+zipcuBFltMQ5vgtmlB7b9r33Q=;
 b=II1Ht3fh4c41orGHdnDcB7nPm3kUsdiE7I9CmgZLtwAE9e8Lvvod0EgIzRbnmF8OkOCantmAXtjAVTudxuCyJGcVN7xq07MB/+PVgmr3fFuPxQXCQNqtLWKKNuibTLapAicvqCrDcOUSkNZ0BM6/ZBsSFqwfHi5KFyyP3D/m1ROtS5nWhc7ijQ6QD43agX/82LenFtucMs8Q4R0Lsn7m03JI/6RfRrR2GJ9IVA2Q5sGa0IRNFL9zbO1d4TQmsOwDHffsI74bVtHHEdrsbUDRW3hE17mQxwgmYfLB53Iwht2/ZpW0oxO+LlrXhWdj/pOrI3ClETXtTBz8WcCRehN3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcFNTVy8G63q5bzrF+zipcuBFltMQ5vgtmlB7b9r33Q=;
 b=iX2i+UA3wMQ+3lIa+V7HI0GNja1TLUeMed3t3FYZ61DhUYItFZIq896kuN6QUfD7VG1RIZ0Jqcf87pPjkQW1pxCtLk6ROhZ/H9lDSqczo/d3j6Qh12XuM8oMRdW2zrHM/wxvg2hDjxmPcfflqRSGdf2uKvL2LsiHIGhNEXNRT2MbOD+tCaRcQqshIvtdoEsCk8FEVCVrbVqow/orKdhnBjfwlDcHxWrWslL80z0H3tAKnNWa8XjW+eP3s5uO5fyUb6yp2gbGeR1QFiXhNAr7GvM4owf78ALHfmq/qBL4LCCCy7JsSkQwjSL4A34h0d0N4R1q7mgFTqCAn2OZ15aRYw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 11:47:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 11:47:52 +0000
Date: Thu, 10 Jun 2021 08:47:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210610114751.GK1002214@nvidia.com>
References: <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
 <20210608132039.GG1002214@nvidia.com>
 <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
Content-Disposition: inline
In-Reply-To: <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 11:47:52 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lrJA7-0052MM-FQ; Thu, 10 Jun 2021 08:47:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320ff649-ed44-41ce-72de-08d92c05943b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5223A2C70C7C74481FD9B7A7C2359@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McUxgUMsQdlI6Mt4C+DIsm1i4layK4bPiArZxvXLzUjY4UJXXxXoq/vX+CruW5QWA48N4z0rFJC0vmikCK/ozohUrMgtMlOF5vKUyGrMW7zkuPwrcWvADWvB5nJj4pm0niqhIX26IGpZxcKdixhVcF9w/npvQVrvNgSV+Dg+2KRFi4jlkdYrkNIBSJRBmR8vO5ASyJUzlBmJtQa/xpnqt1GTyH0jXuU73LKebagm+xUuH66GzL8sGgbBes3mEYf81+3qolC6D9MF+l7UWw0ZmhccveV0yeRdjNe0VbqaFX3kMFKjx6uEq14UGaoH0Zsb38gAGWueCNnLsgnWqn6XtQFaf2WDkYBrdoFvTXSi/gogjvYqzRKwNACMQnC2/4eZjGpY4wL/DTb4hz95pwqPr2fX3mCG/lL+inhPRuGpdnnLxpbAZHwDJ2970kKjuKh6kXmdpe/CLZIArZjW+M4N7RbwyWQSJYAG7OX4wGgMSwW+ui+0qu1tnbQTM4UUGRfak7hQcM1EPnN1V2fkGpTKzp4RroC5k5ui1cLnC1ALF4gB3SbF7s6Ytc0UluTcBndKUfh6X15x4GW4rLolQF4MVqtIeXpbpD0EOmZgjNuxqYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(426003)(8676002)(478600001)(1076003)(86362001)(7416002)(316002)(54906003)(8936002)(66556008)(5660300002)(66476007)(6916009)(186003)(66946007)(2906002)(26005)(33656002)(38100700002)(9786002)(36756003)(9746002)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpsK2MxOTlZUGtlUEk2eERESlZzdm1KbXdOZXNYeUllZFVLWHc5K055TGNX?=
 =?utf-8?B?enhBV1I5a0JKT3Z0aE52U29ENno1cUpzZys1ajhUQmVkUm1hTHZiaFFIdXB3?=
 =?utf-8?B?OWxHR3paYWh3cGsrVzRndUw0MjZMTS9ZdDJDTGxMVmpNOUw1bi9YMnZKckVL?=
 =?utf-8?B?cGxjbi9wTXlOenNpMmNzdmNYMG1UVm9TUGlXRXJNZkxCYVAxbFF1NVNFNTFW?=
 =?utf-8?B?TS83TG9HK0o1Wi8yRGdKWmptRjNuTEU1NVo5RThVNTBrMWVBTmhkYzJVcFhE?=
 =?utf-8?B?RGUyTXBFN3Awci9lWlZLT2NCRUdUdDBueVdkT1ROTzFnWUFVWGVJa3JzOHVQ?=
 =?utf-8?B?Myt2U0Q5cTh0NVRUSjh5eWIrQTdmUDhKa1VxMFE3WDRLK2d4cFhwQm5tamFr?=
 =?utf-8?B?enFKbVlyWUtsSzVWenRpWVZ2eVdYMXE5VSsyU1NjbGdiTmtvQTZPV0tyKzhX?=
 =?utf-8?B?SGpSY1ZvcCtHeWh2T1JaMFFESEdTaU5iRnhTQmxEbjV1LzYxd2FyaW56SVFR?=
 =?utf-8?B?eEtnWWxEeTc3WjlWalBVMmdLRDIraFV5d21tOFBjS2NkSUhMbGtCMzFXcUU0?=
 =?utf-8?B?TmhzQWNtU0o2TzlUaTQ3Yld6MVZ4Vk1GS2pXTEtPTjRRMXVXUGFISkU3clNZ?=
 =?utf-8?B?WEp3TFlXKzdlUStTRkNZOTRxSkU1VTdSL0tiTnR4Yy9EZHEwZzVlZ3d5d2Vs?=
 =?utf-8?B?bWx5K1Eyd014YUF0QTRSbVZOczNMazkrdG5uVHBMZDVkYzFvazBESFFZUHl3?=
 =?utf-8?B?ZG1hZ3NZUUhUTnFKTzgwSTZjWE9iT0xEQm54WUFMMTZDUk9hMFVkZHlCQ2ts?=
 =?utf-8?B?bW5UNW9Gbm95QjJWOW54cldEcSs3QW13QjIxOFF4a0FRYjdRM0NpSG1LSytw?=
 =?utf-8?B?dlFYMGNrOFJnQjRnYTkxT3U0dXhNTWdCdUNqRVJKV0pjdVNMOFcyWkxaMDVu?=
 =?utf-8?B?cktBUmN4WENpYTdCTUZndFN2YjBlY21BdDNHWlplMnVxVXpkN0VpaFlwREhL?=
 =?utf-8?B?WE90YkQ4Z3Zzd1NwV1FtKzg3YWpnK21wRWpFR2pGdVFXRkVYQ3Z6cklwNXJV?=
 =?utf-8?B?R01UMTYwRjdKeGRjUDRDM1dPVklZZjhZVlFTN3RRcDlEWWlNbzB2Q25sV1hx?=
 =?utf-8?B?OGdYVm9mcy9aR3AydjVDcFlZbloyaTlqVUQ0Y24vamRjd29aeFpObmkxUVY4?=
 =?utf-8?B?dFczVTVQeDlucmlzN0sxU3NHZGlXWUNGVGJha0Ewa2tESktNSGVpK3N6ZEZ6?=
 =?utf-8?B?UktEektoaFo1eUxLVU5mVTY0cFEwUWo5RytNdUNxTG1naGxVQ2xib21sNW1n?=
 =?utf-8?B?U2FoOUgzcVhmNnFXRjVyazQyWDlVTSsxQWw0MWNlNC9ZUmQ3WHh1SGdJc2JV?=
 =?utf-8?B?ckRVeFE5R0o2cmY0TnAvR0lTZUdmaVlkYzhNa3dMZFhyUkgrOXJxdStXT1hF?=
 =?utf-8?B?MW15UGFaYlp4R3ljNjM0Z1M4VnRLV2tSOEMyOGpxM0Q4U25nMzBUVTJHc0NU?=
 =?utf-8?B?Z0g0RXpmTXNhZytsNitmcEg4bVZwQ2s5dE55ajJxVWRjMnJ6QWdTdGl0RHBF?=
 =?utf-8?B?R0NITzJpaWMwSlhseDBKQzlwWmZZM2NtbGN0OWZaT3krclc2MzFlcHpWUGNG?=
 =?utf-8?B?czBuM0o1UWVvbmNRT2pRcjJVWENJSEVtVUZlZTR2VUlZelFseUVHYmNUb1J0?=
 =?utf-8?B?R0crYzBTNGk4QVBZV1BRZFdDcHRwaDZLYWJidDJmSlN0ZlN6NTFpaFJUZnUv?=
 =?utf-8?Q?wTM2DrTXy8neoWA6/C+hEWOZLMKZ3XaIHiSBXdL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ff649-ed44-41ce-72de-08d92c05943b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 11:47:52.4631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfg71pXjfJmazsSWgslkuLiqEDy6AFcAEclbM/PZp3d7OYl0feIIiBTojRgZiRCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMTA6MDA6MDFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82Lzgg5LiL5Y2IOToyMCwgSmFzb24gR3VudGhvcnBlIOWGmemBkzoK
PiA+IE9uIFR1ZSwgSnVuIDA4LCAyMDIxIGF0IDA5OjEwOjQyQU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+ID4gV2VsbCwgdGhpcyBzb3VuZHMgbGlrZSBhIHJlLWludmVudGlvbiBv
ZiBpb191cmluZyB3aGljaCBoYXMgYWxyZWFkeSB3b3JrZWQKPiA+ID4gZm9yIG11bHRpZmRzLgo+
ID4gSG93IHNvPyBpb191cmluZyBpcyBhYm91dCBzZW5kaW5nIHdvcmsgdG8gdGhlIGtlcm5lbCwg
bm90IGdldHRpbmcKPiA+IHN0cnVjdHVlZCBldmVudHMgYmFjaz8KPiAKPiAKPiBBY3R1YWxseSBp
dCBjYW4uIFVzZXJzcGFjZSBjYW4gcG9sbCBtdWx0aXBsZSBmZHMgdmlhIHByZXBhcmluZyBtdWx0
aXBsZSBzcWVzCj4gd2l0aCBJT1JJTkdfT1BfQUREIGZsYWcuCgpQb2xsIGlzIG9ubHkgYSBwYXJ0
IG9mIHdoYXQgaXMgbmVlZGVkIGhlcmUsIHRoZSBtYWluIGlzc3VlIGlzCnRyYW5zZmVyaW5nIHRo
ZSBQUkkgZXZlbnRzIHRvIHVzZXJzcGFjZSBxdWlja2x5LgoKPiBUaGlzIG1lYW5zIGFub3RoZXIg
cmluZyBhbmQgd2UgbmVlZCBpbnRyb2R1Y2UgaW9jdGwoKSB0byBhZGQgb3IgcmVtb3ZlCj4gaW9h
c2lkcyBmcm9tIHRoZSBwb2xsLiBBbmQgaXQgc3RpbGwgbmVlZCBhIGtpbmQgb2YgZmFsbGJhY2sg
bGlrZSBhIGxpc3QgaWYKPiB0aGUgcmluZyBpcyBmdWxsLgoKVGhlIG1heCBzaXplIG9mIHRoZSBy
aW5nIHNob3VsZCBiZSBkZXRlcm1pbmFibGUgYmFzZWQgb24gdGhlIFBSSQpjb25jdXJyYW5jZSBv
ZiBlYWNoIGRldmljZSBhbmQgdGhlIG51bWJlciBvZiBkZXZpY2VzIHNoYXJpbmcgdGhlIHJpbmcK
CkluIGFueSBldmVudCwgSSdtIG5vdCBlbnRpcmVseSBjb252aW5jZWQgZWxpZGluZyB0aGUgUFJJ
IHVzZXIva2VybmVsCmNvcHkgaXMgdGhlIG1haW4gaXNzdWUgaGVyZS4uIElmIHdlIHdhbnQgdGhp
cyB0byBiZSBsb3cgbGF0ZW5jeSBJCnRoaW5rIGl0IGVuZHMgdXAgd2l0aCBzb21lIGtlcm5lbCBk
cml2ZXIgY29tcG9uZW50IGFzc2lzdGluZyB0aGUKdklPTU1VIGVtdWxhdGlvbiBhbmQgYXZvaWRp
bmcgdGhlIHJvdW5kIHRyaXAgdG8gdXNlcnNwYWNlCgpKYXNvbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
