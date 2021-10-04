Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421FC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 06:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FB661244
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 06:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48FB661244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECB654013F;
	Mon,  4 Oct 2021 06:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 94xzWb9tkhWY; Mon,  4 Oct 2021 06:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8ED6A400BA;
	Mon,  4 Oct 2021 06:58:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D668C0011;
	Mon,  4 Oct 2021 06:58:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 133A1C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 06:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F11640309
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 06:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMsTFY8LUNs3 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 06:58:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB381402FD
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 06:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnEOFCpFudbs7C9xx/GUN/tpKSrr+yiPuRZMaVgEqwafJJdUVB91pYZKFtSEyEAcpu2rx15zEeH4F295xzWEBe0SaKBSwpgUqZEwuqi2nOt0FIhxmtkX7E0d5RQlDa+vOhle+YYz2Ya1Wp9VlWL2KpuAjxtNJ0fizoS2B6567JimL7hGWQAh2KkON4vberWqo1P0veRDgZvmq5BMteUSY5SFBRI4Swkr6zfvoiITnyx6Z4DvhlejQ5w7xOKF6LA4QP6XjOoyUYZMUXRyuwairKjm0kybTEQLz8c+hoPVGQE6fLQa0JVnZSQ7Pb12bI5X5CCPcIomtPrpKriBgwo72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fJFWF9kSGiTWjXQzL5DFAVOYq6DQAhxgB51DiXzk+c=;
 b=FcpoqJuNGI6GSpLu3k2xjeS6/elGL5x3ITLUmFIWAymjoiPvfIYnwxnhmNC0hH/mQIV8JRPeqTVQbbLmKwYAxpE0QJ8G7YMZvrfUN4PHp2xbKRFwYnuJLbupy0r+MAS/i9SxhMKxXs6iiEtd7Rlh4b52IKp/Ydj5b8Yxw+YWPaIz2947NPENM+FTp1+g2Jjs+epETyRDQQyDPuEia4KZ888VG76DFZuosXkarTTo2Y1TsrhU1Q9/MpAtGjfWvygIoLtNalLi7kCS4arGc+bAeKLkhhM6eaFyfeqDURDOSAIxSPNEwQKXL07rNyu49KZ9EuzgkH/Mv+861tvoDU3sXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fJFWF9kSGiTWjXQzL5DFAVOYq6DQAhxgB51DiXzk+c=;
 b=bUsw/LDzOVgd/5pHa94zRkz41GMELPpjJR9gDsWRa2cGSH6gUtc1wlPPdRgk6VpCqjJH+RQKXiwBYYD3NE/+wT7gBZACLUIkJ1BmNWWHtw2ydh550NJje6Mo9e5tubz6+e9h28N6czaXGxCWI5OryjvcDEYuMlWFyRlEsnSOZQk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0238.namprd12.prod.outlook.com
 (2603:10b6:301:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 06:58:47 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 06:58:47 +0000
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
References: <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
Message-ID: <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
Date: Mon, 4 Oct 2021 08:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001174511.GQ3544071@ziepe.ca>
Content-Language: en-US
X-ClientProxiedBy: AM6P191CA0077.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::18) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM6P191CA0077.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 06:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272bc214-ed0f-472e-ee4c-08d9870469a0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0238B567FC44CDE3964F077583AE9@MWHPR1201MB0238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTFiKMPmtTIrJAkGxxWUEuW07FLfonpS00wBVo8WjmlZv98VrtfjAUrUDA7oL670NcRx+jIvrAP/wL0W0BgHSFmU8thMLOPFvM1mDaF24y3Kwi9QrbFcuRdkQ9TF7/cq8C8vhAvtsHDSjT/ffjlMU2C0KU91Et8xcu4NE5gZAwh/lF7yGXnD0hqujEaCI8IIn0wdTs4kGuM5endyyixR4glj8KOgZdLO2maQqfeWTatH05w1QE66MavzpHucbFCqEZp4i9GOsu4cR6CUNznTHOjby9N1874z1Px5oLGBu2OhkHDiSYSMctT7yXgwlhn9m4DPXQB4fdbuLO6eMLhmB4VtOd+mwXZGedngqcekkaEqc3GS/8C7EqmeW2Q9Omz46xXocqDvpvF96rSKW/OoeQmrEpbYqS5xwjC+6bLxqeXCiUbZQjPl+z1ZrQgoehCxpU4zKHr5JhSvqvOAtEWgBI01ZV4xsDc2A1Cr7atXYweryfzXaEQpqNl+pTimjG1/MONR6W9d/Xp+eo/px+ers7Xok5UfNm2NeugcsF58Qksxxi4ID+LSm/H+vzcwuooWEaoy63Birpo2tBx+Po9TnJ0c3Kci0o12b1+S1lV0f0RYsjjBEcPIbi14Jxh8zLpWiRtkNyPy8tY4p7/bS7yWZU+zHcR2MAvkdiiCyGgLp/QUAbYG//7G+bf7gGN19j5e02STt4OGtdWjAKM/kGepS4hgt+Fm+ko46BiqmINP8tAplRLaXUeFjBrlI1OXAL/2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(8676002)(508600001)(2616005)(956004)(26005)(6666004)(31686004)(66476007)(66556008)(2906002)(83380400001)(66946007)(7416002)(4326008)(186003)(316002)(86362001)(31696002)(6486002)(54906003)(110136005)(16576012)(38100700002)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1paWjhRZ0JiUGVNbFVQdzdoWStEUkxacVZBN0VvWFVOMmlrSldsRU5RQXp5?=
 =?utf-8?B?RStIdndubmVvVmdDTFM5SDlEWkMydDd5UEg3cnZJbnRJaFNUd05wcmFXTHNV?=
 =?utf-8?B?bm1va0d1Z0p3NHZzakREb0Q0OUpRczcrT2o1TzhTeGhvTUE4SnRtQUlubVYv?=
 =?utf-8?B?cnpqNWdGdGdLNjg0UllHQThBcmkrWENTOExBMVQxb3c3OFk3cnowTk9hckM3?=
 =?utf-8?B?Y1hLSDZTN2g2UUUwK2NaQWo2UDgyV2lzdGxteDUyRTdKbDNIWlF1bXJGeE1j?=
 =?utf-8?B?UTFXdVVKc0J4a01sOERNSnRFWWdQcnFkTFVKaGRjVzF4dEZPdFVZVlh3UHAx?=
 =?utf-8?B?ZUUwNk1DMnV2VE5DVk1DN3ZEUTdaZWh4WlZBaEdsRXkzM1hDcTZFbS82ZTJR?=
 =?utf-8?B?cVhuMlVRZENpdSszcUJGMmxOYU1qNXo5RElqTHpxVC8yRXM0b2o5a3JCRkdr?=
 =?utf-8?B?VVNlNklkTVUvSXpQSEM4RUZnUmJYTkhJS2UxUnJHaGkrOUJLbmY4UVlEK3Zi?=
 =?utf-8?B?WlJKaW9CaE1XMUtLYzA3NzFLVEp6bmwyQlhtd1ZzMHZpWkhFdTh2ZTBJY1Q3?=
 =?utf-8?B?UUR2dW1tZ2wrQ21nZnRrTFRubXcyVExDYytDbWhSNEN1ZE0zWm80ekdqUXBi?=
 =?utf-8?B?R3JFbFowNnZJZDBNdHBmVWx1RW5Iemp4eDUxZjZPUjJsUXVQblZxMlpTNmU1?=
 =?utf-8?B?VzBDZUtZOUpHd1hWbldGYzJoQmFDZ0ZkYU9od3M0SW1FNmxsdHdhMnYrSGdE?=
 =?utf-8?B?V1hudTIwcHd4MXZGcHE3UWxrcFU2VFl2blpFcTE1VlRBZUgvZU9Ud3ZmdVFM?=
 =?utf-8?B?aDU4R1VYUldqL3NBSHhZS1UvV3VORTZ0N2o2RWFkQlhzR1lXeUlMbzZSaFRw?=
 =?utf-8?B?aGJ0Qjd0MVFLS0RxdGNzYWpYUlRmblhQcDVvWGdXaTMzOFhKbW8zcWpEMk12?=
 =?utf-8?B?MFlrL296ekZHc2hXTmhMNmdkWWdqYWJQME1DdmJJM1hLc3FLWkJkSFZWM0E5?=
 =?utf-8?B?dlIzQkI1WXZ4WGZVVHBwei94TkUzYmN5d2srbkdwRDBYdGlCb21tVkhWK2tV?=
 =?utf-8?B?WnlYYUFKb2k1MFQyRDlvMjZMbk1Gd3Ruck9HTXlHZUd3d0lIOHE3UXpxUjgy?=
 =?utf-8?B?RzJubUJJMjlXb3U5ZWNSV1hSaFU2NFBOK0xJOVM4T1RDdnRqSkJHNUIyLzdi?=
 =?utf-8?B?bU1UTTBtSUxQTVcwalc1KzhBZ0t1SzFub1pURWliMTZMeks5TVo5cE10UFZs?=
 =?utf-8?B?V3FRZTBraGY4NmNMY3lndFVLZ05OSitQU2oxNm1lem03WUZmbUN4S3RPMzlv?=
 =?utf-8?B?aWpUSmdyY1BJMTZHaGZsWkxtQlJITTNBNzZmQUR1aDl1WVd5NlZESm04R29B?=
 =?utf-8?B?aGtRMS9qSFR3aER6eWN0U1NHWDQvVTJsSlF0TmF1UmZHUHJ1N05ZRkM0MkV5?=
 =?utf-8?B?SUdyeFVoNFRuc1FlUmRnaGxYdlo2ZVBvVjNGaXJXdTlvMGRmenZtZVFXejlx?=
 =?utf-8?B?b1ZLKzJ3NkJtOFZKeSt3aUQwZ3pSbUo4NWRST3NhZWNUS0psOVdFWjAyUTRr?=
 =?utf-8?B?cmcvYXN2RjgyTFZQanBmNjhLTW8rZk9BYm9LczNqYVpQSHE1U2RvY3lGekY4?=
 =?utf-8?B?VFFtYjFnZTBPTit3NnBuM21pMldtUy9tcWRUclpxMkdFR1k0TGdEOWl0STJj?=
 =?utf-8?B?Q3RYK0NSU0IyYWh4S1hMNkNZVURYZ3ZkeGp2aFdjenlyU2QwZ0hOL0RiU0Rh?=
 =?utf-8?Q?5j9oL76vGx1Kfjrox1PNBc/kI2vi808DZHjQYfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272bc214-ed0f-472e-ee4c-08d9870469a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 06:58:47.5177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDzf444iJKJ6Nnx878MptzUPzeka8PNrpTMQmR12bj3HEw6XtwQfL5cLjP1Twrui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0238
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
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I'm not following this discussion to closely, but try to look into it 
from time to time.

Am 01.10.21 um 19:45 schrieb Jason Gunthorpe:
> On Fri, Oct 01, 2021 at 11:01:49AM -0600, Logan Gunthorpe wrote:
>
>> In device-dax, the refcount is only used to prevent the device, and
>> therefore the pages, from going away on device unbind. Pages cannot be
>> recycled, as you say, as they are mapped linearly within the device. The
>> address space invalidation is done only when the device is unbound.
> By address space invalidation I mean invalidation of the VMA that is
> pointing to those pages.
>
> device-dax may not have a issue with use-after-VMA-invalidation by
> it's very nature since every PFN always points to the same
> thing. fsdax and this p2p stuff are different though.
>
>> Before the invalidation, an active flag is cleared to ensure no new
>> mappings can be created while the unmap is proceeding.
>> unmap_mapping_range() should sequence itself with the TLB flush and
> AFIAK unmap_mapping_range() kicks off the TLB flush and then
> returns. It doesn't always wait for the flush to fully finish. Ie some
> cases use RCU to lock the page table against GUP fast and so the
> put_page() doesn't happen until the call_rcu completes - after a grace
> period. The unmap_mapping_range() does not wait for grace periods.

Wow, wait a second. That is quite a boomer. At least in all GEM/TTM 
based graphics drivers that could potentially cause a lot of trouble.

I've just double checked and we certainly have the assumption that when 
unmap_mapping_range() returns the pte is gone and the TLB flush 
completed in quite a number of places.

Do you have more information when and why that can happen?

Thanks,
Christian.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
