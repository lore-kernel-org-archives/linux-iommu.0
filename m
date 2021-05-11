Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44337C43470
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 11:48:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01F9613BC
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 11:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01F9613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F832843FE;
	Tue, 11 May 2021 11:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyJF1g0nf1qV; Tue, 11 May 2021 11:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 418348439D;
	Tue, 11 May 2021 11:48:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08836C000D;
	Tue, 11 May 2021 11:48:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F3DC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74F2D40232
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KnG0KeIzkeHC for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 11:48:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DFE34022E
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2I1hR35i+cuyqYtw1xdqNojy/qm4jubiBDDqSaRZQkD86Kvhggdh18qWLqaOAXAC+Ma2JcUfJ5woNehq+FIzXDVK8NW1gXqIrXnDW+yYgssz51s3R3Vd9mWZzBFiBprti+oNQAi3VOyWB3R1kuMAXVFtzAhP5kjrA9jBE4sMggCQjkYpO+p1tDDPXgXc0HuTPltHfyt18tSK+M9Of08JJPW6iPgcQDWJ0rBB1pNvpfP8eN/XZ003Fe0woXVm0iC3g+04VRu42uS+weCqMVXjgBVz7on9hkvOszu+bT84gNBWkpqi6D5Fo+Yr+rDYcgDXLQmSIOI9nDfiFDjB9wyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1uu4WWF+Y9oEfI7PCwJNR8A1DC0pNqF02DFNORbzQs=;
 b=GgZ2w3EkfGJkwquE7SHp/4Zf8O8A5uaIBuUMW8zpxwTBCmcRbMp8uaBKCTdKv/VMCLv2FzxNtQQr1+DMoXuxoTrKOEtTe2Y43GLrD9kF9FWMGi0UImRFGfvEOK2CofKcbrP1gsUxp6ab6tQlae2RsZPxcnIfjM/F73sUqRXKw/t/byu2CKV0MId2zKSxrdU+iY2viVtCBh0S4Aw7a9puHwSKcC8ltl6CzXjyQPw3EZK9uhrOsMJkAE8aUyLGmqvX8zes8EL2vRmBkahdGbThMB7gZ8mxUUQJ4Cp/fCL3xScn1QmUuB7L4CvTLb5QjeHpMhjQ31CWpV9GS5LuO2jBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1uu4WWF+Y9oEfI7PCwJNR8A1DC0pNqF02DFNORbzQs=;
 b=Zy6FMHgY3Vi7PQufVLqBcfw+D11c8ORDYx/uLjSHo7qzhKOff9wShBlZgRUUe9GzwGeP5A8s9ydDGuMQfC38Ncd+iRC+ujDk1IyLNAHCEpIrXvxYWZgakda/pE7f32GD5943Ly5XNyM0G9RKtnlbPI48x3PYxmIEWJ1kqphPd7GDahdMcL0ImWApOHR9GiJNOJbDfDndBkIMrwvcreeqw3Mrsz4s7kMX2h6AkY6Z/R5yVEGvIKs8RO3iXGZ3qOwBsOQwRV+s36qgwK0L2VV2aRIxKWFwzOtkJcTFaNwBj9iE1OYQcALXbgAJAjjIEuu4N8Mqo3jS2tNwofWRfJ4fsQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 11:48:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 11:48:49 +0000
Date: Tue, 11 May 2021 08:48:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210511114848.GK1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210510203145.086835cc@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend
 Transport; Tue, 11 May 2021 11:48:49 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lgQsa-005GS9-AN; Tue, 11 May 2021 08:48:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5318360c-f9f2-47c4-3aeb-08d91472bdee
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860B063A97B0C2D85D735A6C2539@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55XKXK9sDad7oO6+tkQ+RZbquJVHGOzskbCqsAjDhHmnLyRsqBPv5xWfkw5y4cOSTT/zH8bv2sBBVhH78TZoN+GEpMiT346RaJzdxvBMaYtOgxtw1YZEb8+6R1137IRNzUVUEawwbfsx+BeXnu+dY4DAl9YFZXAMm9XBqS3uzyXS3+/PMYzHKMVDwZCN1JB/3VCICBhDZLefE0KlR0v9q48TTnPTHlxtW+Oc21RmZnQEsbLIatVXva8LNO8NPnjeUO8syRJnnv++Od3Sk5hlB/SAsljvS14ibQxciTU5pZbNWVNArpm3gM9cgd8Nm/SKhNzl3BsaEIdE4WH2Nk+4GAHLngrhuBL9FPN1L5PM231BQ2b0uqqLOcTozEV5klJTbJoRuuEQfMVKPwvH8XNsqhWWARaofmjcTb3vQyPcOXIEucLBV3CKrftIrf8UQy43PcM168csgd6GxrJHfPhO227Y3pdp4SqM7EqD0q6NQMTr5kX/4PzjTiLhhT/jg+KYflMHgcX4no3cA4b4EOgmZUa/2uxWrd5QkbwfxoxHLLN+5d/0BZzM9RAyn8L6Veot1MumO1YauUrl8UmYAlrFIX2ypLWE3Z99rnjhOKJPkjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(8676002)(86362001)(4326008)(26005)(54906003)(33656002)(8936002)(66556008)(478600001)(66476007)(36756003)(7416002)(9786002)(426003)(66946007)(38100700002)(1076003)(2616005)(6916009)(2906002)(316002)(5660300002)(186003)(83380400001)(9746002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUM4TmhmN0pHN09nbWx1d3RoakI4RmlaK1BvUG1IeCtYTVFaTjdTWXpZTWow?=
 =?utf-8?B?clRNY0M4eDdIQVd4N3hWUzIzU0xpSjl5MkxySUhBaWNxYW1XWXQrQjIxUjBP?=
 =?utf-8?B?Q3NTUGs4QTNmbkh6SWlNNTlsNW9iWVdWbW5HZlkzcGlDcGU2cnZIQVE1QWtK?=
 =?utf-8?B?RTB2VVlaWDgrdFo2R0tYQzVrcDQzVUFlKzBNS1hQdndUSTU1eWJmOUJxbEQ5?=
 =?utf-8?B?bmtiLzBhRzlmYXI0aXM5WU40OHRQQmFOQjIvVW9OWHVtSWM2ZXJLR3dieW1I?=
 =?utf-8?B?MC9nWHJvVm01ZVhxektiYjlWVklSQk05V3hUQ2VoMzloSzEvNFVSa0hwV0pn?=
 =?utf-8?B?enpHdUc3V1VLT09hNjh2bzRDQWVJeTRyWlJvN3E3azhabzBKREMwMWFxaUJv?=
 =?utf-8?B?M3ZiS2tZeVFCTGFkbW9OWmdMRzZLS1NkRFM3V3NZOSsvQ3Q5R29iNGdYUlFZ?=
 =?utf-8?B?TFlhQnVIcWVubkVLb0hYS3lxNTdPdmkrNzdjaEpEb0I1Sko4TnVRSDNYUVB3?=
 =?utf-8?B?dDBLenlEQTh3UWdxWlJkS1NYVkpnd0U2RWFzeGhyaHVqUnhvZDJVOTNvelQ4?=
 =?utf-8?B?b3NoT0laWGVyWUFTTFBDTjY1ajlRM2dNaEgvVXlKSzErTVNHZE01a291dUZI?=
 =?utf-8?B?cWFJakZPM21nZE1VbURCKzZPRkRBejNteWxRTUxQZGY2T2hNYWdvUFRWc2xj?=
 =?utf-8?B?dDdhVEtJUk12ZXlnNVlxRzdqV0cxR095K2RCUHd4bmJPRHdnREVSZWx0QXNZ?=
 =?utf-8?B?N2JMRnRXWHNTRDBLbGVzYVYvcU1FVklySDNyWmp5azgvMHFIS0tWRHl4VGk4?=
 =?utf-8?B?Q0FxSEEycDJ5b09ROU1aRGZtSXFKZkV1cWpZK0gzS0RteEp4ZHVoVHpWYVhX?=
 =?utf-8?B?bkNzT2htelRHNkttRVczWXlEblFFR0NPTEc2VzJqYjV0TTRRdFdqekdFMWU4?=
 =?utf-8?B?Mlc5RDdjYjJWL3RST2VkTlNvVEx5bnNtWDZFL0Z0cFJYZE45cTNLNXlFWVFV?=
 =?utf-8?B?UDBDWko2blY1MmtaMW84Y1lOZG9pWVdXY3YzaWwvdnRPTnVwT2dxaVJLaXpO?=
 =?utf-8?B?TmlOK1NJS1N2UnJOb2lhTUN2V2hkcDBlRjM3dmVLMDZBNEVLa1lZWFFhSU04?=
 =?utf-8?B?eWFEaldZK3lPWm14WHc0R1JSaWVhbTVLRjJwMjh2T0p4ZTN6M3lUb0ZrVXlX?=
 =?utf-8?B?SUtVQTVaM3pibG5aZ0JzalRTS3Y0cGVhczBvcDNnUUZ3QU9pSzArVXlLNGx0?=
 =?utf-8?B?ZVAwT1F4T2dINlpBRnJ0RldBRjJhRGhTQ2VVWkhNZmNTdkdnNlZZR1JWM0px?=
 =?utf-8?B?U20vTTVKTzkzL0hvKzdJcFFHL1NlRzkxWVRkMUpicmd6cGFDdnFFQWQybGpZ?=
 =?utf-8?B?RjBNa2J1NnFlTWgvNkI5VFJwYzYydEdxVDJVOS9SRDIwa3Y5MzRtMTR1L2tU?=
 =?utf-8?B?R3lUY2N3ZzM5ZnJWQWEwdFloVytnRXAzSkUrWllEbmVQbWtKZ1NvNWkrOXNX?=
 =?utf-8?B?OG9zNm9UclJFMEd0M3pudDJXQ2czVHE1anZiRDFpRzA3aFFmdGVoUmRzdTVQ?=
 =?utf-8?B?V0RlWTUwdTZ1bjdZcmUza0NwbUFJMGxIcW5IR01HZGsxZGt5VWRBOXFTNVhO?=
 =?utf-8?B?dVFlVkpCWWw5UnNDTVkrVVE1UlpvRjJDVHduNzAySmprbDU1TEFkeWlBMjR0?=
 =?utf-8?B?d1Mvb3FqdlowalpuRnNQMEFneGdnWVZGaGRvRXVtT2x0UzBwMnFjWDFyVEQ2?=
 =?utf-8?Q?LaE+zNzoUZOK2u3lTlZ/GSaf1ywmjiWOxRH16SD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318360c-f9f2-47c4-3aeb-08d91472bdee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 11:48:49.7158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir6URekscKE0P7ddugSm8A/8yKTAGVvOa/ZP2BFJuHjlFm9tJ7/no9f4wIoq2f+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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

T24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgMDg6MzE6NDVQTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+IEhpIEphc29uLAo+IAo+IE9uIE1vbiwgMTAgTWF5IDIwMjEgMjA6Mzc6NDkgLTAzMDAsIEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOgo+IAo+ID4gT24gTW9uLCBNYXkg
MTAsIDIwMjEgYXQgMDY6MjU6MDdBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+ID4gCj4gPiA+
ICsvKgo+ID4gPiArICogVGhlIElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1IgZmxhZyByZXF1ZXN0
cyBhIFBBU0lEIHdoaWNoIGNhbiBiZQo+ID4gPiB1c2VkIG9ubHkKPiA+ID4gKyAqIGZvciBhY2Nl
c3MgdG8ga2VybmVsIGFkZHJlc3Nlcy4gTm8gSU9UTEIgZmx1c2hlcyBhcmUgYXV0b21hdGljYWxs
eQo+ID4gPiBkb25lCj4gPiA+ICsgKiBmb3Iga2VybmVsIG1hcHBpbmdzOyBpdCBpcyB2YWxpZCBv
bmx5IGZvciBhY2Nlc3MgdG8gdGhlIGtlcm5lbCdzCj4gPiA+IHN0YXRpYwo+ID4gPiArICogMTox
IG1hcHBpbmcgb2YgcGh5c2ljYWwgbWVtb3J5IOKAlCBub3QgdG8gdm1hbGxvYyBvciBldmVuIG1v
ZHVsZQo+ID4gPiBtYXBwaW5ncy4KPiA+ID4gKyAqIEEgZnV0dXJlIEFQSSBhZGRpdGlvbiBtYXkg
cGVybWl0IHRoZSB1c2Ugb2Ygc3VjaCByYW5nZXMsIGJ5IG1lYW5zCj4gPiA+IG9mIGFuCj4gPiA+
ICsgKiBleHBsaWNpdCBJT1RMQiBmbHVzaCBjYWxsIChha2luIHRvIHRoZSBETUEgQVBJJ3MgdW5t
YXAgbWV0aG9kKS4KPiA+ID4gKyAqCj4gPiA+ICsgKiBJdCBpcyB1bmxpa2VseSB0aGF0IHdlIHdp
bGwgZXZlciBob29rIGludG8gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpCj4gPiA+IHRvCj4gPiA+
ICsgKiBkbyBzdWNoIElPVExCIGZsdXNoZXMgYXV0b21hdGljYWxseS4KPiA+ID4gKyAqLwo+ID4g
PiArI2RlZmluZSBJT01NVV9TVkFfQklORF9TVVBFUlZJU09SICAgICAgIEJJVCgwKSAgCj4gPiAK
PiA+IEh1aD8gVGhhdCBpc24ndCByZWFsbHkgU1ZBLCBjYW4geW91IGNhbGwgaXQgc29tZXRoaW5n
IHNhbmVyIHBsZWFzZT8KPiA+IAo+IFRoaXMgaXMgc2hhcmVkIGtlcm5lbCB2aXJ0dWFsIGFkZHJl
c3MsIEkgYW0gZm9sbG93aW5nIHRoZSBTVkEgbGliIG5hbWluZwo+IHNpbmNlIHRoaXMgaXMgd2hl
cmUgdGhlIGZsYWcgd2lsbCBiZSB1c2VkLiBXaHkgdGhpcyBpcyBub3QgU1ZBPyBLZXJuZWwKPiB2
aXJ0dWFsIGFkZHJlc3MgaXMgc3RpbGwgdmlydHVhbCBhZGRyZXNzLiBJcyBpdCBkdWUgdG8gZGly
ZWN0IG1hcD8KCkFzIHRoZSBhYm92ZSBleHBsYWlucyBpdCBkb2Vzbid0IGFjdHVhbGx5IHN5bmNo
cm9uaXplIHRoZSBrZXJuZWwncwphZGRyZXNzIHNwYWNlIGl0IGp1c3Qgc2hvdmVzIHRoZSBkaXJl
Y3QgbWFwIGludG8gdGhlIElPTU1VLgoKSSBzdXBwb3NlIGEgZGlmZmVyZW50IElPTU1VIGltcGxl
bWVudGF0aW9uIG1pZ2h0IHBvaW50IHRoZSBQQVNJRCBkaXJlY3RseQphdCB0aGUga2VybmVsJ3Mg
cGFnZSB0YWJsZSBhbmQgYXZvaWQgdGhvc2UgbGltaXRhdGlvbnMgLSBidXQgc2luY2UKdGhhdCBp
c24ndCBwb3J0YWJsZSBpdCBzZWVtcyBpcnJlbGV2YW50LgoKU2luY2UgdGhlIG9ubHkgdGhpbmcg
aXQgcmVhbGx5IG1hcHMgaXMgdGhlIGRpcmVjdCBtYXAgSSB3b3VsZCBqdXN0CmNhbGwgaXQgZGly
ZWN0X21hcCwgb3IgYWxsIHBoeXNpY2FsIG9yIHNvbWV0aGluZy4KCkhvdyBkb2VzIHRoaXMgaW50
ZXJhY3Qgd2l0aCB0aGUgRE1BIEFQSXM/IEhvdyBkbyB5b3UgZ2V0IENQVSBjYWNoZQpmbHVzaGlu
Zy9ldGMgaW50byBQQVNJRCBvcGVyYXRpb25zIHRoYXQgZG9uJ3QgdHJpZ2dlciBJT01NVSB1cGRh
dGVzPwoKSG9uZXN0bHksIEknbSBub3QgY29udmluY2VkIHdlIHNob3VsZCBoYXZlICJrZXJuZWwg
U1ZBIiBhdCBhbGwuLiBXaHkKZG9lcyBJRFhEIHVzZSBub3JtYWwgRE1BIG9uIHRoZSBSSUQgZm9y
IGtlcm5lbCBjb250cm9sbGVkIGFjY2Vzc2VzPwoKPiA+IElzIGl0IHJlYWxseSBhIFBBU0lEIHRo
YXQgYWx3YXlzIGhhcyBhbGwgb2YgcGh5c2ljYWwgbWVtb3J5IG1hcHBlZAo+ID4gaW50byBpdD8g
U291bmRzIGRhbmdlcm91cy4gV2hhdCBpcyBpdCBmb3I/Cj4gCj4gWWVzLiBJdCBpcyB0byBiaW5k
IERNQSByZXF1ZXN0IHcvIFBBU0lEIHdpdGggaW5pdF9tbS9pbml0X3RvcF9wZ3QuIFBlciBQQ0ll
Cj4gc3BlYyBQQVNJRCBUTFAgcHJlZml4IGhhcyAiUHJpdmlsZWdlZCBNb2RlIFJlcXVlc3RlZCIg
Yml0LiBWVC1kIHN1cHBvcnRzCj4gdGhpcyB3aXRoICJQcml2aWxlZ2VkLW1vZGUtUmVxdWVzdGVk
IChQUikgZmxhZyAodG8gZGlzdGluZ3Vpc2ggdXNlciB2ZXJzdXMKPiBzdXBlcnZpc29yIGFjY2Vz
cykiLiBFYWNoIFBBU0lEIGVudHJ5IGhhcyBhIFNSRSAoU3VwZXJ2aXNvciBSZXF1ZXN0IEVuYWJs
ZSkKPiBiaXQuCgpUaGUgUFIgZmxhZyBpcyBvbmx5IG5lZWRlZCBpZiB0aGUgdW5kZXJseWluZyBJ
T01NVSBpcyBkaXJlY3RseQpwcm9jZXNzaW5nIHRoZSBDUFUgcGFnZSB0YWJsZXMuIEZvciBjYXNl
cyB3aGVyZSB0aGUgSU9NTVUgaXMgdXNpbmcgaXRzCm93biBwYWdlIHRhYmxlIGZvcm1hdCBhbmQg
aGFzIGl0cyBvd24gY29waWVzIHRoZSBQUiBmbGFnIHNob3VsZG4ndCBiZQp1c2VkLgoKSmFzb24K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
