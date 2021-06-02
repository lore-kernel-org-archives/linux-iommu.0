Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E6C47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 17:22:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA87561D34
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 17:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA87561D34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98BA8404DD;
	Wed,  2 Jun 2021 17:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f8gV1ML6QHDr; Wed,  2 Jun 2021 17:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3691D404DE;
	Wed,  2 Jun 2021 17:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083EBC000D;
	Wed,  2 Jun 2021 17:22:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9628EC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76EED83D21
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1LIsSzFcBnk for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 17:21:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A199083CFC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Voyae/w4hfdRUtXu5cHLpGk6BsbTGScJAdVnujgqRjrrrQbhbIM4SxhAKcsdrWytzrGbEQeTCO0Fub0NBY0tioFaLnkmv3ZbXWvmrBPAQfYgEh6lBgRMTE1QUf987fGRfMEklglIDte3HOGG5IbGZY1Ix+h03O56LURhUNVBFCttUMlfJvPL9Pghwz2H+X/R8ZU+rLuDA5MQ5SyhHoVfUzweTRmT//ukEhw1XBoOJQFtmTktTA6m0xtU8fXZ+pXgSCEaQ09QCc5fhO25rA+VvP8s23uaQLBVxXxwcIDISn5QtD6wZlFIHLOkgN8JhpzYhb4G6NEBsTvzDsfTrm4koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAFOBvu/BHMIz42D60r0XvW0IDdMrJjol+tMYgaINCA=;
 b=HeQDQ20LMF4ZJyQi7TrgLDhHAovjlHA+l0GNmxgHo2OWEhNDnk5CMR8chPlAnFhZHSi5UPRCQbN4ABxjcRXynpIIJzHwzBFio1yDIKd6e7Ehyp5HwkyxFfMyMRZt6bAuARPrrDGqySHBk5X7cZwB6u8F4xi5setQx3qVC5Zq90JlWQMiUfITIg0q2FFtguruCuI3SRZG579c0pUnEjbQMxtwSMF+8OCqQJVewPEnLPi4S16juhGqWc5cYKZyIOJ+t5LIZN/WAQtFI99xLEmrvN4Y9JwR1wio2PTDNVbfabbjiyU38u7VbbkyyP/SaYmetuH35v+217IqPVWYyZJGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAFOBvu/BHMIz42D60r0XvW0IDdMrJjol+tMYgaINCA=;
 b=M/hYcWdHlsYpf1wNESp5i1CfCoBVKba7MWtZpou57qqWq2ESLBs239r7bVDv8hQ2kZZF50eXTvP1Am9mIA5wF1hF1KpANpdl3UBx1qjbfV1GA1JJ0o1Z3Yr7qzEVZ+EvV6fUCrzfPCXAhtwt5591wvdqlb/Sp6O1sFRIJ97pdN0vAYOkKQW3JZxNmXWr5b2N2WidNB/U3169TvjZcZi6bsPf07e3goztcooFqqki8PAfTp4dMLazWPsaKUsSrNRpBDqwlvxoRoplPHZWYmDLqunBBnQueba6WbEhRmLurWNOKPTAaJzLJFp7mC81X4sY6/aSyQxiHiUAqsC1f1X1WQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 17:21:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 17:21:55 +0000
Date: Wed, 2 Jun 2021 14:21:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602172154.GC1002214@nvidia.com>
References: <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
Content-Disposition: inline
In-Reply-To: <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12 via Frontend
 Transport; Wed, 2 Jun 2021 17:21:55 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loUZ0-000IRj-OY; Wed, 02 Jun 2021 14:21:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77dad0c1-b9c7-46dd-b9ca-08d925eaeb9b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5144040F20A049DFB80B9F32C23D9@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrjKq+sKueuQNPTHuS8C7Cub7yla+fleEvyVGbv5v+ifSnIFsRW/lwqUgdwktPk87nxdcJW6nYVwhPzGPaDDSMdkhGhcqkSF55I1IA0TbLEpPxcq3AqVSBJBf7p0YGjvTpxU3bV7B/nR2WKF0Js673BiF7ecI6Ioh5I5vahb4LsstG23Cwc8xiK2UwVWWhDak6QHvqklPgzbQWlD1gd4lSHJ05qXbxFJ9++gVRqHvQDjljq2Z0Wb7g/cpm5diLisNkXGfp0hInDFjuRYXqsk7UshgxRlmfxz5EKNYt6t2LhjuNXQzyjY+SkkWLk2+hNJfY5qcOp3z8dCDHMUxkoTxmKXb6KNwHyuYFh34vDHqL04kQl7WB5/YBCJkkO+jpdGICTuIhCSb9jvjswR/MRxitKsJ6YgD/SXcqm5mN7CklvQbwgYyZbZO+NyO+X1SI5/PHfJhF71oQs5hkhY+qfgfxla+5FVT4ZtdppOC+eyZXKXxxBuRQGDdzbUPRvs0FhaUTDGIy/67/XGlEQqanhDsYYE3DwHkpJsGyQj+AEnshOO6ignArA3ldIOQHhPgMNsKC4MujokGcrLQwyXvK1aqIPKegjQuBG7RwEAJIzd8co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(36756003)(478600001)(2906002)(4326008)(7416002)(5660300002)(8936002)(9746002)(66476007)(66946007)(38100700002)(26005)(8676002)(2616005)(9786002)(426003)(66556008)(316002)(186003)(54906003)(1076003)(33656002)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGk2d2ZQVTZnS0oyeXhuMmR4b2NBUEdyd3o4SjkrZ0d3cThtdXNKWXRrc0FF?=
 =?utf-8?B?cFRlcGpPbDlrdmZ2RCtZcnkvV3c2MmNJYVUrdHRXMkREclB2R3BZSngva3Zp?=
 =?utf-8?B?RGpsQmtXZElpMGJEMVZxVnowNnlCZUtOWEJFOWo4ZytpaUhadk1RdnVGU1RY?=
 =?utf-8?B?VS96OVFCalVzY2pBaTNLWHlCclJtdnpIblN2cHU3T29yM0dHZG9QOW9nMDZx?=
 =?utf-8?B?c2Rkd1luV3VMWCszWkRrYld0eVpzM0kwMGoreDJrekhobFVnSHZIRFd3ajc5?=
 =?utf-8?B?TitBcHBVSmpNalVSOFlMcUdvaHZ1K3dYQWwxYTZ0dWszQnRQMXFjM0ZWUFZi?=
 =?utf-8?B?ZFZrYmQ4MzBmcjgrSGtSYjkwQVdPVEkwbU5TeisxVlBJQzZHeU13dGF3blc4?=
 =?utf-8?B?bHRhT01rdTZjWmZ1VE4wUjh6VTI5L2VQUzREUnZDS0ZkazJ1TjJhQ0hmWXdy?=
 =?utf-8?B?Q0pCVWhGMmpFUEVLcE9kRXFyb1hSRDd3VEdOL0RLSTF4ODMvOWRrMVM4cE9p?=
 =?utf-8?B?eUtzWXo3K0FXWXU2dmQza0hpSUpod1J2K1hEN2o4Z3piTVJNdnIybnQrWlV2?=
 =?utf-8?B?Y2F1b1hidXN4bHJHVEtUU2tKUjhiRkUxSlFyVnl4ck84YjRJaWJ4T2Y0WCtJ?=
 =?utf-8?B?d3VERmNhYmp6YzFWVW80RmRLVE9hSURqMmpMYml6MmdjRWxBN1pmMVhuSTFh?=
 =?utf-8?B?QnAyZkFFdTJod0UrMWJQTCsvNHlMVjd1Qi92dFU1RXlHcDg3M2U4N3FjdFBD?=
 =?utf-8?B?T1NDYjdIZWVMREpZZ2FVSkhkRGtSSUhEdFF1d1BSbEpZWE96Nk8wVkR3QmRa?=
 =?utf-8?B?L2NLNytFOU91N0U2NG9WV1cwVFlHVTUrRTFRakV3STR3dHVjRENEbGdMQkl6?=
 =?utf-8?B?VzRUZElOU0g2NGlYbXN0NVBQM1lLYlovMnZ1VWRNRTdZQXdZd1JlTUxjNDdJ?=
 =?utf-8?B?clBlbENsRFViS3dmQVNGQ1hXUWdsMGFhaS9KZStmcjdWaXVTNENFRUVQM2lP?=
 =?utf-8?B?aXpzcjVwRXV5Tm1xSndGTjVRcVJHcmZyajNzR1lwQnROZEYva2lYSDA5a2N0?=
 =?utf-8?B?MXZ5eXBLL2IxRUIyckhzY0xiT0s0MVpQamJ6c2JkQUZFYW1zM0ZjbkNkdU1p?=
 =?utf-8?B?NForYlVhZDY0NG4wM2grSitGRlhENE91VS9tWHBSWTRCR0pES1lueGxydWZo?=
 =?utf-8?B?MXVVQ2ptdkowQ1AyWUl2RGd3NG1TMHE0N1NWVkZ0akNIb1lxMExZZG1FalJN?=
 =?utf-8?B?N24vRFJtVXpyd2RkcVZMRzZNTEVhbnhKY0xCTVNXclc0N2hKMWxBdW1SRjFF?=
 =?utf-8?B?ckd3UzlzMG9obk1Fckt1UXV2TTA5dXA0aTRFdmhaeG1RQmpBWWRwb2FCMHFl?=
 =?utf-8?B?TXYxUXNwWmZ1S2JITFRMd09IazQrYWRTenVSSnFSRmtnc243SzBlMUdvdlI1?=
 =?utf-8?B?TlVPS3Ira0Q3TVZ0N0pBaDR5T0x0bUhjSk1oY1B1czM4VFV5c1BjUEdObjAz?=
 =?utf-8?B?R0RIaEhHc3g1aGVLTisrWVJMWC9SNlZmc1prejhLMnJwNmdJM1YySWdSdm5C?=
 =?utf-8?B?clZWU1JUVHZRQjNlSmdCeWoyeHRPTzFVc2ZvcFRyKzF4UzNRZXNVbmdtNStU?=
 =?utf-8?B?YlZkc2hYckVUOFAwNjBRSHhoYmU0NXpvcHozdVlOK0ZwRGxIMVd5WVluQjNP?=
 =?utf-8?B?YU54ektHeDZLdTNDNE9WdjlTakR3bkRLdHhHaWxBK0lkakR2M3dtM2tUWHIx?=
 =?utf-8?Q?SbQhp+x3Pgjq2P3gMi3fGmbJqvjIdR3VWp7UmQt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dad0c1-b9c7-46dd-b9ca-08d925eaeb9b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:21:55.6067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zp5LsK5rD8jI9zrYrH/zKc4lYzm5pDr/sNq3I3WAGJmQxnpoNDhCNFfKQjClrfjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

T24gV2VkLCBKdW4gMDIsIDIwMjEgYXQgMDQ6NTQ6MjZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzIg5LiK5Y2IMTozMSwgSmFzb24gR3VudGhvcnBlIOWGmemBkzoK
PiA+IE9uIFR1ZSwgSnVuIDAxLCAyMDIxIGF0IDA0OjQ3OjE1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+IFdlIGNhbiBvcGVuIHVwIHRvIH4wVSBmaWxlIGRlc2NyaXB0b3JzLCBJIGRv
bid0IHNlZSB3aHkgd2UgbmVlZCB0byByZXN0cmljdAo+ID4gPiBpdCBpbiB1QVBJLgo+ID4gVGhl
cmUgYXJlIHNpZ25pZmljYW50IHByb2JsZW1zIHdpdGggc3VjaCBsYXJnZSBmaWxlIGRlc2NyaXB0
b3IKPiA+IHRhYmxlcy4gSGlnaCBGRCBudW1iZXJzIG1hbiB0aGluZ3MgbGlrZSBzZWxlY3QgZG9u
J3Qgd29yayBhdCBhbGwKPiA+IGFueW1vcmUgYW5kIElJUkMgdGhlcmUgYXJlIG1vcmUgY29tcGxp
Y2F0aW9ucy4KPiAKPiAKPiBJIGRvbid0IHNlZSBob3cgbXVjaCBkaWZmZXJlbmNlIGZvciBJT0FT
SUQgYW5kIG90aGVyIHR5cGUgb2YgZmRzLiBQZW9wbGUgY2FuCj4gY2hvb3NlIHRvIHVzZSBwb2xs
IG9yIGVwb2xsLgoKTm90IHJlYWxseSwgb25jZSBvbmUgdGhpbmcgaW4gYW4gYXBwbGljYXRlIHVz
ZXMgYSBsYXJnZSBudW1iZXIgRkRzIHRoZQplbnRpcmUgYXBwbGljYXRpb24gaXMgZWZmZWN0ZWQu
IElmIGFueSBvcGVuKCkgY2FuIHJldHVybiAndmVyeSBiaWcKbnVtYmVyJyB0aGVuIG5vdGhpbmcg
aW4gdGhlIHByb2Nlc3MgaXMgYWxsb3dlZCB0byBldmVyIHVzZSBzZWxlY3QuCgpJdCBpcyBub3Qg
YSB0cml2aWFsIHRoaW5nIHRvIGFzayBmb3IKCj4gQW5kIHdpdGggdGhlIGN1cnJlbnQgcHJvcG9z
YWwsIChhc3N1bWluZyB0aGVyZSdzIGEgTjoxIGlvYXNpZCB0byBpb2FzaWQpLiBJCj4gd29uZGVy
IGhvdyBzZWxlY3QgY2FuIHdvcmsgZm9yIHRoZSBzcGVjaWZpYyBpb2FzaWQuCgpwYWdlZmF1bHQg
ZXZlbnRzIGFyZSBvbmUgdGhpbmcgdGhhdCBjb21lcyB0byBtaW5kLiBCdW5kbGluZyB0aGVtIGFs
bAp0b2dldGhlciBpbnRvIGEgc2luZ2xlIHJpbmcgYnVmZmVyIGlzIGdvaW5nIHRvIGJlIG5lY2Vz
c2FyeS4gTXVsdGlmZHMKanVzdCBjb21wbGljYXRlIHRoaXMgdG9vCgpKYXNvbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
