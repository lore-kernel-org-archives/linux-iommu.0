Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0CC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:22:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D23E61131
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D23E61131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5F5D61B70;
	Mon,  4 Oct 2021 13:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZvHkJp56C_t; Mon,  4 Oct 2021 13:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7175460C0E;
	Mon,  4 Oct 2021 13:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A53AC0011;
	Mon,  4 Oct 2021 13:22:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6571FC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45C2240134
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AiSv8AfWk6Vi for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:22:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B25A6400C8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcLgTEcgaZm83N489GvkNHonV+7wjuOIw+8tdZPSe+ocdLVLMjZyno49i+/dg3pHe6wiD367yxCLsRB47wKQ0MijwRutGn6fi2nf+f7lB+R3D90g19yZQ+NbSInics2cEYpB1J0lquh7bFRx+ZEucs0JUGoyPX85w+j4Ubdmpdx0dY5NNNqrH235zNIkbgUbZ7in5g+6Byr8jQQvi3Nml2ilg+/HL8HzarSPkh3Sh/Wc4Au1qlpOw7cmAOxS1SbPEKQ+/ZV9DXQ5Yfw/YLwNq6a96UTh6W0xMydFj3L1qHUwFXImWuK1jKSWtXEnjWxp1mme5rH22W6ofZPeR8xTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAU71db1p8rdQgUjQB1Ns2sk4eURkc+wtnNP8/tDPHg=;
 b=ESuZa1gz2RbbsZr20B7mS9i8TWVRxwOemOpm4pYRu6fpQqfOC80ohXaoNmoi7O0OdUB1k8mJnXvurxumyPRMBQVGYfUBsoz3oFjT40nQoHFAZR2jg3HxVdtx/cE8Vz1QaQ6y6QAHAEtte/RF524WcX2qfmrkFpm1dV1VoPWpbUeuZKpOVW8baZ6mVAlw5FQZWoijP6N7qF6kWofWNbBMMyhksLUuk78J+g1t8ArT2Tr5sguZFSH++v64CITaSTbJ6CMpzojYBEJNViqsIPBPoB3+cMplpa2oBJZ5HHE5SW5eD/jLjKbHEjcIaIVzRJp23lubCgcolKzxPPdATjHy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAU71db1p8rdQgUjQB1Ns2sk4eURkc+wtnNP8/tDPHg=;
 b=0B0BVZl1w+La4sfzhJjZqexiinsHGuUdUHDYMc0RcAmgWapzah3OC6dczRd+Nh6FI1y/pv9XEzJwHDcUliAimRWVhJJqJKOittZP3Lna0GmtR2IaeX74tQg56fgVKINqHqBCxQqHF6evgEg6PW5ReGCV88uzHWlTeZZYpvAOS74=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0112.namprd12.prod.outlook.com
 (2603:10b6:301:5a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 13:22:37 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 13:22:36 +0000
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
Message-ID: <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
Date: Mon, 4 Oct 2021 15:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211004131102.GU3544071@ziepe.ca>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 13:22:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faa79b9-a537-46bc-3f3c-08d9873a0817
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01121264D0A33595A226C0D883AE9@MWHPR1201MB0112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BEBo5sJrqIfeOlANh57LEpsqiq87iyNtxcceTwZFjCIreP60DaaTPm64JE9zY/6n63kSzDaw/1vjkhgy0syyxpWI+KbUk6lQObiz4HDjj0ZRcKwsd8+BdNHFn5qMR4RX92GAeU7C+Y5QQ84QxMLRhdmNyl5evyckI9Y6E7h+X+wcIrFxqcU+UXQYg4qHV8lQxM7i8pFYV3fpWwAkzfFSV3SBy5ZnG9rHZFPvQiJq3VBf3sXxqyFuEBAL/BxDZiVmZ6OMBhtz+y2rPwDYrsSI/yRBEgPmopuzvOfB0DM6buisnPY/gdB/zsooF+jOWjLCailBisc5iIS3HmexktI2oVu0HKNVsyvBzu7yD1XNHEX65t357nS0xjZyME9S88SjnFW+X+fo0sctInF6uGfeQqQx9h1Rrar3wHYJHp5GqEoCZQ1W3I3u1ANmMuz7uU1P4n67sWrjQPYOdWj7IuBWI5VnW/i23UALwFI2a/Hfb9IuNtjh/IlUYVNBZh4/8r5OlgAn6nv14TcKXLc/RlavWjqBNH0WGIomsyvOT5Pid8OwMc3Ym8Rp3PmEFPrUVppMAS+lzx6H9LDcFdh2ZVBWvCYt7OqNkkgP8bVlnDHUapnPn5lbf6u8amANL6gphSuMtbNPBeOfrcxjhwhzpEOIAWhMQLmHU/Nn0xdTAbWPv5HbD9XDqSuEkl00eF0oju4oowaKpe4AZ3emfg4RGfozAQtE07z7O17UzTqXuall1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(316002)(5660300002)(83380400001)(31696002)(38100700002)(2616005)(8676002)(7416002)(6916009)(54906003)(66574015)(956004)(16576012)(8936002)(4326008)(2906002)(186003)(6666004)(26005)(86362001)(36756003)(508600001)(6486002)(66946007)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9tSTJIRXFhSXZYemQvS2VQTzQzRlhuYXBVcHdRK3RzQTIySVZ1R3BFS2sy?=
 =?utf-8?B?cVRSTXlub21MRDllZTJGTi85Ky9JUlNRSENxN2hybzR6MWY2Z2tJWW9MMlQy?=
 =?utf-8?B?N3ZydGhhdmh1RW9HcFB6VTlBNnpwLzh4UzIybldYTGsyZ0Y5VEtIUDFzaTBP?=
 =?utf-8?B?NkNJQ2dpSGJ1UG5ub0VEWmlScmtISlpTd0V3YUIzRVd6REh0UGlqOUZzbVZY?=
 =?utf-8?B?cDV4aFNPY1Baem1mRWU5YzdLT29QWUFSQ2tLOG1EeFJuZWpBNFFzazVtLzNv?=
 =?utf-8?B?U1hQMThHUFl2QzRUTHJRYXVDUzVnaG5JZlVJWHgzZ2I2K25QTHovNlYzb1Vm?=
 =?utf-8?B?Q2xFdnk1TXZhbW5BN0hZVmJzazJaaGNVRHZpUlg3eTBnVFNYNWRESHNzdU1h?=
 =?utf-8?B?SGZIMmhwaUhETWJtV1I1ZzY3RXF6RHViaGh6d3dGeS8xbk9rOGdWcE8xVHNx?=
 =?utf-8?B?dUplVzVuY3JtWUJtb3VOMC9CVmJZQmRjTS9YRlRnOG4xRngxci9IcHdmTUxu?=
 =?utf-8?B?OVRuRTV6Z3gvNjNVRW9HZm5hcmxxUEhqRDFNZ0RxQ3NOdjJJUHFYalBYbzR2?=
 =?utf-8?B?d3RMSTJIRjUyZWhpREY1N1lmMWRrc245TlRKZERHMTdPKzBibWpPOFZjTUhl?=
 =?utf-8?B?ek0zNG8rUVMyaVZkR1ZIN29QSmRZbkpncUx4a0JScElHUm9DVmFQS29WQm5p?=
 =?utf-8?B?Q2dBOHNsZGRwQXFuTlc4aVdHYm1aencvdWxPTVd6Q2tjMzBRMDJjSHVNZ3l4?=
 =?utf-8?B?SEprL1BPR3EzV3dubFpIeUNjcGE5RHBCaEJMR0ZxY1NjZEZMRzNiOWhRNGNH?=
 =?utf-8?B?SlhrTDRPNjIyRmcxYWFGczhXSkwzSXVXNkVmYzIzb0xWZWRscmg2eE45YkZo?=
 =?utf-8?B?OEdwWkVVL0d2VnRzdG93ODRXbWhMZXp0OTBTQlIyN2hBcGwrMkZ4TitRM0pZ?=
 =?utf-8?B?YnZqdnc3WHpKZ3dMUkVUUUVZclJ2MGtnWlJwRkZHMjNYeEFBdUdmVWpuQUlk?=
 =?utf-8?B?WEFPNWltSnRFejl2enZ5RWE3SmhseDZPcEIyeWtjanFaRHkzeUVPT1NQcnU5?=
 =?utf-8?B?RFpPMEdLNndVUUN3MHd6cjNBZENqK0xQRG82dm83a1RYQWF3UHUwemdqVFNy?=
 =?utf-8?B?ZllHQWtEWE9SdzkxRVh6RDlzanhsYmduUFMzZHhFUlhyT2t1SWRaRGRKQlVZ?=
 =?utf-8?B?Y01ObnVreFpncFlNQnFYWk51OUlsUVlReDZJaTJENkZBNFBRSWZRRDBENjMx?=
 =?utf-8?B?cUZET3owTnc4bHlyS3VHbThRREpTTWpwdUdmdktuOVM3T0kreWIzbDlvZmd5?=
 =?utf-8?B?UHJkckVqcjZXYjUxemU5Y2twYXJYT0hBcTBNUlF3dDZuNWsrQlFDNXgxbk15?=
 =?utf-8?B?Y25XUXlnRlNsY3gweWp3MDM0cFdSOWs1TGREaS9aVGRNWlhMODk1SXFZZDdw?=
 =?utf-8?B?MEdjZEx3VmYwY3FnK01vN2lhdnlhYVBweDlCd2tyZXRsdmJqYkd0TGJjMlVq?=
 =?utf-8?B?Z0d2TEV4SXVlUUZXTHZURzk3VHFEVVkrazlTNnZNT2pvcmpldndUbmNVdmJv?=
 =?utf-8?B?bVVaRS9TeFlMVDJoeDd0czYyUFp0U21YQ2VGY1FEaElqc25FWThMMjZ1OEJX?=
 =?utf-8?B?bUJ5OEdkQWUzYWFUOVpLOEhRTkNuYmNQV1ZGRU5OZEdmLzBsc01BemF0NHBq?=
 =?utf-8?B?MDBMMDhnWndkalFWSk0weTdGRDBsV3kySFlDZW9kVERROVdCVDBPMzVtVDl5?=
 =?utf-8?Q?cEgdy5Jv9eIgsST3VLJklQevNKq24AwJODb35a/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faa79b9-a537-46bc-3f3c-08d9873a0817
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:22:36.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuJNwMMb4NTFiVQ9F93qmMM6VkSOKuzEfFgX6jFPM1ue1eGOtEW3wDH1N1y1oITa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0112
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

QW0gMDQuMTAuMjEgdW0gMTU6MTEgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24gTW9uLCBP
Y3QgMDQsIDIwMjEgYXQgMDg6NTg6MzVBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gSSdtIG5vdCBmb2xsb3dpbmcgdGhpcyBkaXNjdXNzaW9uIHRvIGNsb3NlbHksIGJ1dCB0cnkg
dG8gbG9vayBpbnRvIGl0IGZyb20KPj4gdGltZSB0byB0aW1lLgo+Pgo+PiBBbSAwMS4xMC4yMSB1
bSAxOTo0NSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPj4+IE9uIEZyaSwgT2N0IDAxLCAyMDIx
IGF0IDExOjAxOjQ5QU0gLTA2MDAsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4+Cj4+Pj4gSW4g
ZGV2aWNlLWRheCwgdGhlIHJlZmNvdW50IGlzIG9ubHkgdXNlZCB0byBwcmV2ZW50IHRoZSBkZXZp
Y2UsIGFuZAo+Pj4+IHRoZXJlZm9yZSB0aGUgcGFnZXMsIGZyb20gZ29pbmcgYXdheSBvbiBkZXZp
Y2UgdW5iaW5kLiBQYWdlcyBjYW5ub3QgYmUKPj4+PiByZWN5Y2xlZCwgYXMgeW91IHNheSwgYXMg
dGhleSBhcmUgbWFwcGVkIGxpbmVhcmx5IHdpdGhpbiB0aGUgZGV2aWNlLiBUaGUKPj4+PiBhZGRy
ZXNzIHNwYWNlIGludmFsaWRhdGlvbiBpcyBkb25lIG9ubHkgd2hlbiB0aGUgZGV2aWNlIGlzIHVu
Ym91bmQuCj4+PiBCeSBhZGRyZXNzIHNwYWNlIGludmFsaWRhdGlvbiBJIG1lYW4gaW52YWxpZGF0
aW9uIG9mIHRoZSBWTUEgdGhhdCBpcwo+Pj4gcG9pbnRpbmcgdG8gdGhvc2UgcGFnZXMuCj4+Pgo+
Pj4gZGV2aWNlLWRheCBtYXkgbm90IGhhdmUgYSBpc3N1ZSB3aXRoIHVzZS1hZnRlci1WTUEtaW52
YWxpZGF0aW9uIGJ5Cj4+PiBpdCdzIHZlcnkgbmF0dXJlIHNpbmNlIGV2ZXJ5IFBGTiBhbHdheXMg
cG9pbnRzIHRvIHRoZSBzYW1lCj4+PiB0aGluZy4gZnNkYXggYW5kIHRoaXMgcDJwIHN0dWZmIGFy
ZSBkaWZmZXJlbnQgdGhvdWdoLgo+Pj4KPj4+PiBCZWZvcmUgdGhlIGludmFsaWRhdGlvbiwgYW4g
YWN0aXZlIGZsYWcgaXMgY2xlYXJlZCB0byBlbnN1cmUgbm8gbmV3Cj4+Pj4gbWFwcGluZ3MgY2Fu
IGJlIGNyZWF0ZWQgd2hpbGUgdGhlIHVubWFwIGlzIHByb2NlZWRpbmcuCj4+Pj4gdW5tYXBfbWFw
cGluZ19yYW5nZSgpIHNob3VsZCBzZXF1ZW5jZSBpdHNlbGYgd2l0aCB0aGUgVExCIGZsdXNoIGFu
ZAo+Pj4gQUZJQUsgdW5tYXBfbWFwcGluZ19yYW5nZSgpIGtpY2tzIG9mZiB0aGUgVExCIGZsdXNo
IGFuZCB0aGVuCj4+PiByZXR1cm5zLiBJdCBkb2Vzbid0IGFsd2F5cyB3YWl0IGZvciB0aGUgZmx1
c2ggdG8gZnVsbHkgZmluaXNoLiBJZSBzb21lCj4+PiBjYXNlcyB1c2UgUkNVIHRvIGxvY2sgdGhl
IHBhZ2UgdGFibGUgYWdhaW5zdCBHVVAgZmFzdCBhbmQgc28gdGhlCj4+PiBwdXRfcGFnZSgpIGRv
ZXNuJ3QgaGFwcGVuIHVudGlsIHRoZSBjYWxsX3JjdSBjb21wbGV0ZXMgLSBhZnRlciBhIGdyYWNl
Cj4+PiBwZXJpb2QuIFRoZSB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgZG9lcyBub3Qgd2FpdCBmb3Ig
Z3JhY2UgcGVyaW9kcy4KPj4gV293LCB3YWl0IGEgc2Vjb25kLiBUaGF0IGlzIHF1aXRlIGEgYm9v
bWVyLiBBdCBsZWFzdCBpbiBhbGwgR0VNL1RUTSBiYXNlZAo+PiBncmFwaGljcyBkcml2ZXJzIHRo
YXQgY291bGQgcG90ZW50aWFsbHkgY2F1c2UgYSBsb3Qgb2YgdHJvdWJsZS4KPj4KPj4gSSd2ZSBq
dXN0IGRvdWJsZSBjaGVja2VkIGFuZCB3ZSBjZXJ0YWlubHkgaGF2ZSB0aGUgYXNzdW1wdGlvbiB0
aGF0IHdoZW4KPj4gdW5tYXBfbWFwcGluZ19yYW5nZSgpIHJldHVybnMgdGhlIHB0ZSBpcyBnb25l
IGFuZCB0aGUgVExCIGZsdXNoIGNvbXBsZXRlZCBpbgo+PiBxdWl0ZSBhIG51bWJlciBvZiBwbGFj
ZXMuCj4+Cj4+IERvIHlvdSBoYXZlIG1vcmUgaW5mb3JtYXRpb24gd2hlbiBhbmQgd2h5IHRoYXQg
Y2FuIGhhcHBlbj8KPiBUaGVyZSBhcmUgdHdvIHRoaW5ncyB0byBrZWVwIGluIG1pbmQsIGZsdXNo
aW5nIHRoZSBQVEVzIGZyb20gdGhlIEhXCj4gYW5kIHNlcmlhbGl6aW5nIGFnYWluc3QgZ3VwX2Zh
c3QuCj4KPiBJZiB5b3Ugc3RhcnQgYXQgdW5tYXBfbWFwcGluZ19yYW5nZSgpIHRoZSBwYWdlIGlz
IGV2ZW50dWFsbHkKPiBkaXNjb3ZlcmVkIGluIHphcF9wdGVfcmFuZ2UoKSBhbmQgdGhlIFBURSBj
bGVhcmVkLiBJdCBpcyB0aGVuIHBhc3NlZAo+IGludG8gX190bGJfcmVtb3ZlX3BhZ2UoKSB3aGlj
aCBwdXRzIGl0IG9uIHRoZSBiYXRjaC0+cGFnZXMgbGlzdAo+Cj4gVGhlIHBhZ2UgZnJlZSBoYXBw
ZW5zIGluIHRsYl9iYXRjaF9wYWdlc19mbHVzaCgpIHZpYQo+IGZyZWVfcGFnZXNfYW5kX3N3YXBf
Y2FjaGUoKQo+Cj4gVGhlIHRsYl9iYXRjaF9wYWdlc19mbHVzaCgpIGhhcHBlbnMgdmlhIHphcF9w
YWdlX3JhbmdlKCkgLT4KPiB0bGJfZmluaXNoX21tdSgpLCBwcmVzdW1hYmx5IGFmdGVyIHRoZSBI
VyBoYXMgd2lwZWQgdGhlIFRMQidzIG9uIGFsbAo+IENQVXMuIE9uIHg4NiB0aGlzIGlzIGRvbmUg
d2l0aCBhbiBJUEkgYW5kIGFsc28gc2VyaWFsaXplcyBndXAgZmFzdCwgc28KPiBPSwo+Cj4gVGhl
IGludGVyZXN0aW5nIGNhc2UgaXMgQ09ORklHX01NVV9HQVRIRVJfUkNVX1RBQkxFX0ZSRUUgd2hp
Y2ggZG9lc24ndAo+IHJlbHkgb24gSVBJcyBhbnltb3JlIHRvIHN5bmNocm9uaXplIHdpdGggZ3Vw
LWZhc3QuCj4KPiBJbiB0aGlzIGNvbmZpZ3VyYXRpb24gaXQgbWVhbnMgd2hlbiB1bm1hcF9tYXBw
aW5nX3JhbmdlKCkgcmV0dXJucyB0aGUKPiBUTEIgd2lsbCBoYXZlIGJlZW4gZmx1c2hlZCwgYnV0
IG5vIHNlcmlhbGl6YXRpb24gd2l0aCBHVVAgZmFzdCB3YXMKPiBkb25lLgo+Cj4gVGhpcyBpcyBP
SyBpZiB0aGUgR1VQIGZhc3QgY2Fubm90IHJldHVybiB0aGUgcGFnZSBhdCBhbGwuIEkgYXNzdW1l
Cj4gdGhpcyBnZW5lcmFsbHkgZGVzY3JpYmVzIHRoZSBEUk0gY2Flcz8KClllcywgZXhhY3RseSB0
aGF0LiBHVVAgaXMgY29tcGxldGVseSBmb3JiaWRkZW4gZm9yIHN1Y2ggbWFwcGluZ3MuCgpCdXQg
d2hhdCBhYm91dCBhY2Nlc3NlcyBieSBvdGhlciBDUFVzPyBJbiBvdGhlciB3b3JkcyBvdXIgdXNl
IGNhc2UgaXMgCmxpa2UgdGhlIGZvbGxvd2luZzoKCjEuIFdlIGZvdW5kIHRoYXQgd2UgbmVlZCBl
eGNsdXNpdmUgYWNjZXNzIHRvIHRoZSBoaWdoZXIgbGV2ZWwgb2JqZWN0IGEgCnBhZ2UgYmVsb25n
cyB0by4KCjIuIFRoZSBsb2NrIG9mIHRoZSBoaWdoZXIgbGV2ZWwgb2JqZWN0IGlzIHRha2VuLiBU
aGUgbG9jayBpcyBhbHNvIHRha2VuIAppbiB0aGUgZmF1bHQgaGFuZGxlciBmb3IgdGhlIFZNQSB3
aGljaCBpbnNlcnRzIHRoZSBQVEUgaW4gdGhlIGZpcnN0IHBsYWNlLgoKMy4gdW5tYXBfbWFwcGlu
Z19yYW5nZSgpIGZvciB0aGUgcmFuZ2Ugb2YgdGhlIG9iamVjdCBpcyBjYWxsZWQsIHRoZSAKZXhw
ZWN0YXRpb24gaXMgdGhhdCB3aGVuIHRoYXQgZnVuY3Rpb24gcmV0dXJucyBvbmx5IHRoZSBrZXJu
ZWwgY2FuIGhhdmUgCmEgbWFwcGluZyBvZiB0aGUgcGFnZXMgYmFja2luZyB0aGUgb2JqZWN0LgoK
NC4gVGhlIGtlcm5lbCBoYXMgZXhjbHVzaXZlIGFjY2VzcyB0byB0aGUgcGFnZXMgYW5kIHdlIGtu
b3cgdGhhdCAKdXNlcnNwYWNlIGNhbid0IG1lc3Mgd2l0aCB0aGVtIGFueSBtb3JlLgoKVGhhdCB1
c2UgY2FzZSBpcyBjb21wbGV0ZWx5IHVucmVsYXRlZCB0byBHVVAgYW5kIHdoZW4gdGhpcyBkb2Vz
bid0IHdvcmsgCndlIGhhdmUgcXVpdGUgYSBwcm9ibGVtLgoKSSBzaG91bGQgcHJvYmFibHkgbm90
ZSB0aGF0IHdlIHJlY2VudGx5IHN3aXRjaGVkIGZyb20gVk1fTUlYRURNQVAgdG8gCnVzaW5nIFZN
X1BGTk1BUCBiZWNhdXNlIHRoZSBmb3JtZXIgZGlkbid0IHByZXZlbnRlZCBHVVAgb24gYWxsIAph
cmNoaXRlY3R1cmVzLgoKQ2hyaXN0aWFuLgoKPiBIb3dldmVyLCBpZiB0aGUgR1VQIGZhc3QgY2Fu
IHJldHVybiB0aGUgcGFnZSB0aGVuIHNvbWV0aGluZywKPiBzb21ld2hlcmUsIG5lZWRzIHRvIHNl
cmlhbGl6ZSB0aGUgcGFnZSBmcmVlIHdpdGggdGhlIFJDVSBhcyB0aGUgR1VQCj4gZmFzdCBjYW4g
YmUgb2JzZXJ2aW5nIHRoZSBvbGQgUFRFIGJlZm9yZSBpdCB3YXMgemFwJ2QgdW50aWwgdGhlIFJD
VQo+IGdyYWNlIGV4cGlyZXMuCj4KPiBSZWx5aW5nIG9uIHRoZSBwYWdlIHJlZiBiZWluZyAhMCB0
byBwcm90ZWN0IEdVUCBmYXN0IGlzIG5vdCBzYWZlCj4gYmVjYXVzZSB0aGUgcGFnZSByZWYgY2Fu
IGJlIGluY3InZCBpbW1lZGlhdGVseSB1cG9uIHBhZ2UgcmUtdXNlLgo+Cj4gSW50ZXJlc3Rpbmds
eSBJIGxvb2tlZCBhcm91bmQgZm9yIHRoaXMgb24gUFBDIGFuZCBJIG9ubHkgZm91bmQgUkNVCj4g
ZGVsYXllZCBmcmVlaW5nIG9mIHRoZSBwYWdlIHRhYmxlIGxldmVsLCBub3QgUkNVIGRlbGF5ZWQg
ZnJlZWluZyBvZgo+IHBhZ2VzIHRoZW1zZWx2ZXMuLiBJIHdvbmRlciBpZiBpdCB3YXMgbWlzc2Vk
Pwo+Cj4gVGhlcmUgaXMgYSBwYXRoIG9uIFBQQyAodGxiX3JlbW92ZV90YWJsZV9zeW5jX29uZSkg
dGhhdCB0cmlnZ2VycyBhbgo+IElQSSBidXQgaXQgbG9va3MgbGlrZSBhbiBleGNlcHRpb24sIGFu
ZCB3ZSB3b3VsZG4ndCBuZWVkIHRoZSBSQ1UgYXQKPiBhbGwgaWYgd2UgdXNlZCBJUEkgdG8gc2Vy
aWFsaXplIEdVUCBmYXN0Li4uCj4KPiBJdCBtYWtlcyBsb2dpY2FsIHNlbnNlIGlmIHRoZSBSQ1Ug
YWxzbyBmcmVlcyB0aGUgcGFnZXMgb24KPiBDT05GSUdfTU1VX0dBVEhFUl9SQ1VfVEFCTEVfRlJF
RSBzbyBhbnl0aGluZyByZXR1cm5hYmxlIGJ5IEdVUCBmYXN0Cj4gbXVzdCBiZSByZWZjb3VudGVk
IGFuZCBmcmVlZCBieSB0bGJfYmF0Y2hfcGFnZXNfZmx1c2goKSwgbm90IGJ5IHRoZQo+IGNhbGxl
ciBvZiB1bm1hcF9tYXBwaW5nX3JhbmdlKCkuCj4KPiBJZiB3ZSBleHBlY3QgdG8gYWxsb3cgdGhl
IGNhbGxlciBvZiB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgdG8gZnJlZSB0aGVuCj4gQ09ORklHX01N
VV9HQVRIRVJfUkNVX1RBQkxFX0ZSRUUgY2FuJ3QgcmVhbGx5IGV4aXN0LCB3ZSBhbHdheXMgbmVl
ZCB0bwo+IHRyaWdnZXIgYSBzZXJpYWxpemluZyBJUEkgZHVyaW5nIHRsYl9iYXRjaF9wYWdlc19m
bHVzaCgpCj4KPiBBRkFJQ1QsIGF0IGxlYXN0Cj4KPiBKYXNvbgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
