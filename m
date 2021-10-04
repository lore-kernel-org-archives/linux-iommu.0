Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52314C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 14:54:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0104D6137D
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0104D6137D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C470A8469C;
	Mon,  4 Oct 2021 14:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Z5D0TTOfXMn; Mon,  4 Oct 2021 14:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA0D384474;
	Mon,  4 Oct 2021 14:54:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8164EC000F;
	Mon,  4 Oct 2021 14:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E735FC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 14:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E32CC421E5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 14:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rDLdV9meyjlm for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:54:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3625421E3
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 14:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amv5xp5m5UkEjN+333FKIu+3NJ2p85Y7TX0LdVgUX1GqDFTiH60o8GTQEXVBk2hpoljle6BV2fLzH3RU2tyt3YoJeyuf5vRSH614UwJPXYcMI89ycIXduXdxt6IfVyQUfrdnVN0Ao3cwUJYShSyMS50XbiCLd6/zzWVWsnR6ZfqPfJy+HfDmV3Ix8qV3mxukYWhUAdTInkeYEAl8VYMNkT1pNOhJqXOSmibF337ezjAy3GEzOVBSICb2SWNhkfWPamoPz11ROYm6ZNdp+ckV+ZHqvap6KDIMAwZgNHuKjX54Phyx8kPltY6EAQqJhYUEEY56KUZ6VlgHXyYDznWp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsKJb26U3+gtb7PIb9WqUQ/aXXPgqu5T5t8Y4vk3Mcw=;
 b=gJXRCbagAJ6DO2xaSrXzt3VBOgIhAfiJS88Olj7FAFjkKrptszPllrrljeotM4NDHi/7KM1Y+d5RWL+yjXzI+7LPIaDLLsbZmD5mVnRL0b8BDBZeKGRp2Bgd4Y5AgureVZAdcJDLwaaLIiqsHTM9RIRk9X9h/RoeMYGwP23b+yrPMN/s2vttMjh88J8rHGTVi/1Hn/1311l6bLzFb9i3g//xzS4adZ7ERr5Q07IBP79x2Bop76+6YfTqrWWlWJUUiScj+3Sg5ZbGn93Tk9N3cYU60/SwcsDHK9Ryck5AO4Ff0C0ncRI1VSQDi/5oenLxlytWvnYu0vTv3gWr8i7Wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsKJb26U3+gtb7PIb9WqUQ/aXXPgqu5T5t8Y4vk3Mcw=;
 b=TNmXPwmJnRxBygkPPXztQy0Mh2oHKCYantFRjeJUrooAzFL/sGI+V1h/aBufTs395mTkqS05qTcMU1NFQGIoBUdAzUjIzcpvGhec8aaHPnDC3c8jtzOjzOC5bMugJlahLSYg6MYfpNXUF7e0s7dCr+LH35vsD6jTRkbo0pVSnKU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1214.namprd12.prod.outlook.com
 (2603:10b6:300:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 14:54:16 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 14:54:16 +0000
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
 <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
 <20211004132759.GX3544071@ziepe.ca>
Message-ID: <613362ff-bd2f-b0b1-634a-55dc4c3837fd@amd.com>
Date: Mon, 4 Oct 2021 16:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211004132759.GX3544071@ziepe.ca>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:bd14:2b97:8d11:9c50]
 (2a02:908:1252:fb60:bd14:2b97:8d11:9c50) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.13 via Frontend Transport; Mon, 4 Oct 2021 14:54:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93229e0a-f1c3-4f8a-1d9c-08d98746d5ed
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB121461AFAB703FDAE10B502D83AE9@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeFLnLDmWC5ejqhjuN7N6FIFoll5ICLPlRVvcj8fqAaesLviJJp66dxfFTLhYlVfF8stDW4+v429qnIQZbKx5GcwrD1NrxN7K+PkpHhZynq1yN1llan0ZvRhy56hubaPJ7SbdUWG0k05CY03Cap22+ELvB+BEtBAr0ZxD26kHGtMMYa/8fhg8cJcabVmD3BG/xvr1p4+D9VxzQHjJ84G/qCPtWNUq5pID2oZQnWZmGEPt6lElFS886bEX6gdkukVc7W+jzceh7z5swiuLuqM3ohvd94wTTKOrEYmfjcfLYoQggAhO7c3v2a5jwC+hgolzxSMPf0oC6qYJJCshO9cCrldOJAUcNwcMWL2xHo+dsSqWk9tNVXmJJDuNTIMXEu5A/RZPvnh6hWABOMjYgSs1KTDiTtlpjS2EiaHtwBckvnJkzzGJM+6LzN7i2FLi29jqkyZBbnSxbqw+dxchLrhHpfxwKg/vsIGR7x09Eky01/1E97SdD5kNKtkMB85Y4+b4HP9QyKtc0TX6lMh+hm/2e0kSxtpPbHAiNlvcmMY/U/YQ1H/tYHK1HGobcgSXbP+Mr81Kbjnh+B70DADA2hUO+wbj4dsACzABX3KE1pst1vkVF6uqWGAPo36XUYJyXDXyRH0q+xz1WwCrdd6DY9e0e511FjhRqtp2wnm+w4uye3HXg1OkRvCwz6w+76OFEkgkYkithB80Pq2Zt0HbbTs8tvUnMUFGHwY3aEvFyx7qmVJOVx7pFwQXAPwxQcBW/eq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(54906003)(6666004)(31686004)(4744005)(31696002)(508600001)(5660300002)(66946007)(83380400001)(36756003)(66476007)(8936002)(6486002)(2616005)(66556008)(6916009)(7416002)(186003)(38100700002)(2906002)(8676002)(316002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVvUmN2V1FQUithdElRcTVIRlNrNm1mZUExVmQ4ZCs4QWN5OWlod3Q5V0Er?=
 =?utf-8?B?dUQrM3p5dm10M2RWQ0pETFJnWVplMmwwTnhjQVAxZjZOL1lPOWRuS0ZhYU83?=
 =?utf-8?B?eC94UnZFcmVvT3Z6TTRMTEpobk9lT1FtL0pUNWpCQktEbUM2NE5RSWh4UlRr?=
 =?utf-8?B?WG50ZkJCUEVWdXBmV3RzT3F1eU5kM2xVSEdyS1lHQTRzd3lIWCtDbjYweFVL?=
 =?utf-8?B?M2JrbmVZckhFaDFWTnpzcWtPQ21KNUZPNnJCUkltSmJSQi9teHNFRnBka1hn?=
 =?utf-8?B?T2I2VC8vZ2JocTZibzliZWNmZUlKT21MdWJvckF1aE9DOXJ6QktRcE94Qzly?=
 =?utf-8?B?RkJQdVdSZmlRRDZPSUhqUEVkeGQvMm9NU0trNDVSN1lmZndyU1dESHBlUmVp?=
 =?utf-8?B?M0VRTUhXOUFoT1pBUi8yL0lLTldUSkZaQWp2RTFaTlIvMWhGa2hYRkVIelA3?=
 =?utf-8?B?cmVtc2hzQzFBNzU5RUl3ZlByc1AzQmpXTjBPeFRtbzZwb1lhOVJWendyQnVq?=
 =?utf-8?B?VXpwWmVxWDBJaVdiU2h0Q2hOc211MWFBdjJoWkl4c2xvRnlpZXdDUW9pN1F5?=
 =?utf-8?B?S2JpcUViUzRPcTlmNy9MMGJOQXhKWkR3VC9aRjJvWGNNT0JuM2RZWWRFY2ZT?=
 =?utf-8?B?YnUxVHp6TUhjbGZUS1pITGlMcXk4Wk1Rc0RxWnVwNDJMV2VMMmRTVk9Fa2J2?=
 =?utf-8?B?MXJMNkxJNHlRQXB0QjIxUWVSeEIzY1FUMkFuYWVXUDRFeG10SUpRVkZqTXRj?=
 =?utf-8?B?NmU2QTB2M3c4N0RPdi84OUNRU3A5eUpieFhuL3pCa2wyYlNQcDFJK2xsN1la?=
 =?utf-8?B?MngvVUY5OVRtcWhwV3pRSUVhQUZPNDhaWlpCaDl2SklacEhBMjZUY3V4WlJP?=
 =?utf-8?B?a25rdTJSUU1qdEdOclE0SGFWdHk5QXFvU0cyTW5nWjhtN29rWmdJYmlrZ1pE?=
 =?utf-8?B?bGNaWmMrdjEwcWxvN0dETmpRUk93MXV2MzlMNDVnR3lCelRzcWFZRnNxbmNC?=
 =?utf-8?B?ZWJZRHhydGlZWHJhV3JUSi9yZlVXcmRnYkd6TzhtdHJ2NUFNT1pabVJLUWZK?=
 =?utf-8?B?c3JOaTNsUTZwNVZmdTBrNG1IUGlFR093QnZOMzRpSC9Fd24yK3FUR0ZhNUxJ?=
 =?utf-8?B?Sko0WXpFTTVuWHZHV2w2SGg4VmFlWmFaNE5jS2hLRGhKczRwVGlDZlRHMGRq?=
 =?utf-8?B?OUkyYmhVUUxTRjAzVkljL0tFdGFxOFYrQStRS3kyU2Z4SDRiSzE2YnY1SW8r?=
 =?utf-8?B?RkdCNm5OT0tBZjVLenBTMkVGek1rc2c2QlBCSGVFNno4a1dHZ1BUdmlGbnQ4?=
 =?utf-8?B?WDI0L1hBSHBZWGZUTUt3bWszSWQ4SEllZW1ka1kwQ2w1UkgyRmsrU1FIeU9o?=
 =?utf-8?B?N3A4OTQzM29OcnZ4NUtnNW56NXh4T2RRa1Q2RFYwMWpRUHBnUGwvRnVZU1lu?=
 =?utf-8?B?cm9GR2xHWnNPbzMvYTlnUnNjTUkwSGRIcVFaMVIvMUwxNHhJeCt2ZUN2Qy9h?=
 =?utf-8?B?SHJkemxnN1lqZXNmZ0ZBQjZpKytNZklBR1dXeVNOSGJUTmJoSEhFZXFYbHpF?=
 =?utf-8?B?RjZvY0JYRTRGeUo4UkxoT1JEamkzcWlVQWhaNkt4K1N1VGsxNUpORnJGdkNK?=
 =?utf-8?B?MWM3T3R3b0tubWNRaDlhWHh0YmZMYmtadkQ1S3RaUnB0dHp6NWQzZlV1ZVNn?=
 =?utf-8?B?TlZTNlp4cEU4bEFGWnBBWnVjdCtCUTlWL0FYQnVkak8zNnQ3aktWcUsxaU9i?=
 =?utf-8?B?RjIvbUVZTmRzaUJOcjlmL2JRNm9WZ01NWkJueWJ5OGErRDcvU3I1YUU4OHRP?=
 =?utf-8?B?K0JoUW8rb2QybXo1ZG96MEhiR1ltcVIzSzZrS0ZQWUd0dVJrL1FGQkRnUURy?=
 =?utf-8?Q?0rKI39UTTIH4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93229e0a-f1c3-4f8a-1d9c-08d98746d5ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:54:15.9771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSOru+Lpa7/li8gz64YdbiYsmZC1fN1JFtvOvogPKWG7BusoiTqVgvnSwxc7b+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QW0gMDQuMTAuMjEgdW0gMTU6Mjcgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24gTW9uLCBP
Y3QgMDQsIDIwMjEgYXQgMDM6MjI6MjJQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pgo+PiBUaGF0IHVzZSBjYXNlIGlzIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHRvIEdVUCBhbmQgd2hl
biB0aGlzIGRvZXNuJ3Qgd29yayB3ZQo+PiBoYXZlIHF1aXRlIGEgcHJvYmxlbS4KPiBNeSByZWFk
IGlzIHRoYXQgdW5tYXBfbWFwcGluZ19yYW5nZSgpIGd1YXJlbnRlZXMgdGhlIHBoeXNpY2FsIFRM
Qgo+IGhhcmR3YXJlIGlzIHNlcmlhbGl6ZWQgYWNyb3NzIGFsbCBDUFVzIHVwb24gcmV0dXJuLgoK
VGhhbmtzLCB0aGF0J3Mgd2hhdCBJIHdhbnRlZCB0byBtYWtlIHN1cmUuCgpDaHJpc3RpYW4uCgo+
Cj4gSXQgYWxzbyBndWFyZW50ZWVzIEdVUCBzbG93IGlzIHNlcmlhbGl6ZWQgZHVlIHRvIHRoZSBw
YWdlIHRhYmxlCj4gc3BpbmxvY2tzLgo+Cj4gSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
