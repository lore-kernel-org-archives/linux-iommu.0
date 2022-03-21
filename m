Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B63C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 12:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABFDE60E9A;
	Mon, 21 Mar 2022 12:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQvPcIEB-0CM; Mon, 21 Mar 2022 12:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81B2B605B1;
	Mon, 21 Mar 2022 12:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6351BC0012;
	Mon, 21 Mar 2022 12:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43FA0C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A76740609
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QBux41UISJK6 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 12:43:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E743640590
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTemh7KwHM86gZrBQM1rwG9eoG+/kVRicT2/1Mj9gnjRr2N+KAIPfWYXX21Fz6jC9hz7rn3zFVhCkyeRaaHkNsWvP7tiUXGMK4UCRs7IDJtAzKMVtdCwixwcshtAcuBjK62ij06KLjrSBp60uYqvTSV2gcAh35jsikejoi766Wvx8U3jrY94dDZJhn//OmY2GukanVitqm7sdb4t4gzsvLHXoQYSTchtUmpMoH5Sx1RnZLHETu7LNPED6whbRTc/9VAguzPQDuRkPABfVm0MkiM1RTdJ0TfxfGJqgnqkGBeIGVWXEbof7DWjbLMtI8kAFxXFJniQ335Lazve5/gTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBNil5mVh8o/cmRpq0YDQva/oklpR9szRA6gragfhOo=;
 b=IFmuVcOBb2Bt1NykodnDuaHcaUMTVsqOlyFWGzB45wsBwcIsknqJhsDj/K+RmEAIx+/epG+7KOXOg6ZL8EX73fGEpm9NzrVfWM/fBPQhSx0FRQe6OeVjexxmk5hIBpUODxkofzQhL+S80h2+ZPs5E/oYB84qQIFZKzYl9W4kO7oLbFrCYr3D84L2vATI087Obb1BPeCmPDxMu01DlAaJE4OQI/i759C2xeBO8fYjNN76vZd0y5Y5mvZJ43gh9dX4f5xd1mOimPRZddwsPOQ2mswJHykF+dZ+Q55AVdcRGTKaPBe0+hm/E9+/VsEXx+YMT8EYGD3/ffULQmr2SfQ+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBNil5mVh8o/cmRpq0YDQva/oklpR9szRA6gragfhOo=;
 b=MtbS5jVAKpDEEk4Y8TbDjwb2DUnOjAeqqN/SpQhDtGfwUXRN5kNhLyYoHpJYhO4OhL5sUpHAoQMb5TkLI4HQWKtyzKqNVScttLVfW6Mihl72eY5EyT7OvofX3mLmJNjpVmmVcFKmw2JZSxhgTC3nZl0Gn+IGy1INA/qqSQCv2RlRs0f3gBz7yaiFjUymDbNxWiEkoxhpzvusgTelFNX+F7NdDVYj4Wid82O0nefiRCYlyWiGk+YTrboWAOdbqzmogJ8NtD46b7eURWqC8y87ZUsrCsWp25ZjzYNlM/B2LD2chtWP3jeY7g+3l3KjeEYJY0WbLNL8agVme3ZESD9jgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:43:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:43:47 +0000
Date: Mon, 21 Mar 2022 09:43:46 -0300
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <20220321124346.GP11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
Content-Disposition: inline
In-Reply-To: <YjhkmDEGwF4EcM8R@myrica>
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31829158-9103-452c-435a-08da0b387176
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430E9D2919DA2615B92459DC2169@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkvQhS/bJkqJE1lwqdUXWGguoMJExpwYl8buOQ9UXgeCPDSeTrfXom4vpmfNppPFKDv/GxHKyodXGKXLEN/jUF+dz9GSrHTcSVadPU8Fp1MeTViPyL2CuYJ4N17ZUzuDf6OjMJs7eGQVYrLD2A2n2QXhB7JMz4CEo3HyYTWcA49V6i/Znljk0cP99g8vuJAtGJPQ6lO5g4V3zyGb7u5izcTcfwPGHYN2us+8/PnTVSxnNeoy7gLbsBfN/QwzKWuGkk47IAHCPlpsoPgxMDJGv4/IsaJke7p5xLSWfIpHgxlKJ3MuRvzRu3vZJNwf0AU9H4ILvcJVmW11kQZyRV4VZFucCQ7BE3U4nVnryqzS4bCGxeUgCxkxVgKePciaGSylBVgAKkxZGxNpc0MJi1qYLptlbsp7Mmp3Z1402s+J9fW9EeZIbAQl9JTHD/T/aDZPk0Fv44CZjQUdMO9ukqXlJCdI++YgmZ7KubUr0WvZEaTQInnxTdZtS73fiJrQiwNM4xsBN4pzhgPQzrRh+LKgST4GPP3wzGkyjX+ppNXR/MxzOG9UkxIKzYGaMmGnVocnJjZIJe0Cz0SmlnedQnAcV8XNmqH/vmJOL/qkJvsMZh5nh8c5GpgQSVSh2APOf5s43vaNTzU+9c0cTpNs4MSIlVxBpEa9OEFJcT0ctr2S+aYKQSo5TC2/E2GBMlh3Visy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(86362001)(2906002)(508600001)(8936002)(4744005)(66946007)(4326008)(66476007)(66556008)(8676002)(316002)(6916009)(54906003)(6486002)(6506007)(38100700002)(6512007)(2616005)(26005)(1076003)(186003)(83380400001)(7416002)(5660300002)(36756003)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbauTMU3bJxQFd6iCptuLkKAgDUlKzKgY8ZsV3mzOMsdSwev9aHac+pJefaX?=
 =?us-ascii?Q?g+cPXazp3pODoFU7uWQ0eAyVlJf7AJBG3qTQ7gE0PzASyeWxPvoKv6bgYhHo?=
 =?us-ascii?Q?myMGpvL8mTlxa9R04hE/NMk73JYcIV9cZXMZOThOXsZmD5Fc87TrC+lFO0iq?=
 =?us-ascii?Q?6JbytCJdHTjRKysVCiyBiqAhOguoIKDW9Tkz1IKJElHrC6WEJBTKGqvU+brM?=
 =?us-ascii?Q?RvZXTi1xGvpRGWNZe96KpnZ1V6x8WS22HvmtjgV5IMoQFJf9JqnjULPfM2qs?=
 =?us-ascii?Q?FRh66wxbuRxk+Y9cyIt3sMPVgKzltU2SjkiHhjxUeDrMmqpKuYbmfIJEil0D?=
 =?us-ascii?Q?6ur+iPdGhVeU/av5m6JFgFAa+aJBjU8hpxQL84gYRh8omnSqfc890Uf6Y0GV?=
 =?us-ascii?Q?v5TjAzUL7tp5N0QHBv6RKkNTLhI9rrrK/4ISiMgAkYjeLpHMATFqFTgm3MAL?=
 =?us-ascii?Q?8YLAFuyyqgtJu+s56VhE5560T2qJuph+DFjpcuwPhu+8oFdhwnj5+TmdVtaF?=
 =?us-ascii?Q?/5UJTJpwJjH9O0UpmpeD41rpEWfHittj/3ShgEp/mXetVz1nAy+36h+0imwc?=
 =?us-ascii?Q?pztv7hunCXApYjsxWWuh6ZOOnZGqnefjzMV/Yr/iecfGhyD7dHmlZEKQ5LMD?=
 =?us-ascii?Q?jTWEx7QK4pTlC+sbusSGWnRdiKaPluIcocZRZYsmLXA1n7dplUKEIQgvLRuD?=
 =?us-ascii?Q?aOEqYoXfeki0voODFV1nF+QKwqwr9iO7uIvRVUgu8yk1oXTz41HzpNQVPsmn?=
 =?us-ascii?Q?lN1os0nl0sekZnWm6abO9Id+ycaS7SnBZtEvr77EDT6RxeZIoXTwLzcYUtTR?=
 =?us-ascii?Q?GllMPYMUWX5vlL3dNqia55TbBeuHjBufizH3y2aVL2gWYqPizcekepBGmZQS?=
 =?us-ascii?Q?ZEZae5d1n0iEhbmi99rCBNjixcSpRSlHAcZ2V5MFcMy5Y53SbaiNzzUq0rXt?=
 =?us-ascii?Q?UY4lRzWhxVPMDOhs+g5xQ5CKDImBZDyIXRn/Nfdq5FMGDH+dBhT/vu/9xZyK?=
 =?us-ascii?Q?quGQAJSC3KVn6fmCBPHuuvRD6Rh71CEi9+RMeBhk/DasU4kxIhguskGtIFDf?=
 =?us-ascii?Q?agpk2+a4uNs+VVJvSzJnJwO06T0/Kpgm94WhXdbWpXbuZLfjsDNcJLWpluMW?=
 =?us-ascii?Q?L8asvBVfHX5G4+8ifVRTw74uzKUmwQYKFpcAtubR40Dnjb/fkH+jdaknC1mN?=
 =?us-ascii?Q?WBTCIk6DIRnYZxdrNhiQlegz6OPerM57E5G0kYpmsQ+ohNli5+ZoiT4qF50H?=
 =?us-ascii?Q?USCWVn8jVL5M+0Z8dpStW1cvY6/E4J041IgTf/heo2+0a3GGTNwNXGIRNWlu?=
 =?us-ascii?Q?wN1gsstaBWVBG9UkJEkicjZsA2C6OCw0KxkTzY+/VfnBIRTxVmvGA1d/6oPg?=
 =?us-ascii?Q?mUG/5rufWVTyQ1hOygtRPdJsbVJO2aDwW7vR2Ocygtw+N3MCbKfhEZQaiggq?=
 =?us-ascii?Q?Nt1imsCyRV8IQytfCAlaSR2Ui1nrihVm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31829158-9103-452c-435a-08da0b387176
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:43:47.7714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfuWImIcTVdU3CB52SVn67Qc1GROdygrhCfxE0E6ouCzlPHqUPLwyphDd/SHfEDU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:

> I tend to disagree with that last part. The fault is caused by a specific
> device accessing shared page tables. We should keep that device
> information throughout the fault handling, so that we can report it to the
> driver when things go wrong. 

SVA faults should never be reported to drivers??

> A process can have multiple threads bound to different devices, they
> share the same mm so if the driver wanted to signal a misbehaving
> thread, similarly to a SEGV on the CPU side, it would need the
> device information to precisely report it to userspace.

I'm not sure I understand this - we can't match DMAs to executing
CPUs. On fault we fail the DMA and let the process keep running or
SIGSEGV the whole thread group.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
