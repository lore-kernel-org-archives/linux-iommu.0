Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94EC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 11:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5253E40BA7;
	Tue, 17 May 2022 11:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jy9XvC620Mjp; Tue, 17 May 2022 11:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06ABD400B9;
	Tue, 17 May 2022 11:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC39FC0032;
	Tue, 17 May 2022 11:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D15C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8279740592
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj2r7ZmcycOP for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 11:16:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F380400B9
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAkJG2JfFaYpwnKmXjJ+c0CSpV80ku/EpcCgdOr80JQlt+r19mVpWB8AmXm8hyjGxnunzmzENTDIrXJ0+fp8MOC3cvvPNIJDwcvVXx3t7t17jOeccHByxZup0KwQrKa7ccDDiq8Hj2qd6wdOGFPj22FSiWepZTp9j2Xr1U3TEOdje33arJsVeidiHzAtZEgDn2RBJbY3JO6T8mO4o8Mh8mUEoMxvKtjyT6tchgZLfDHG6ORe6kW2YWXLpRJymyF14vmyW4Yd5Osqp3lJ338GUAo1i63x/NecJNz3ffwHXBHJc2KZNiJ3HOOtb/gwtj4y7n6cRnZ6WhjhCxgAyyqnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtO1PxXvwu6e341/QuIIy6C+ZgImvMwf5LBqoP7AGTw=;
 b=CK4/GVeVgwkJJopG+lUe7vhKu6IyyMhcuDAR6wVxZviUxfgSL1zaLptv+l6EXWZPrukJWO9swRdPT78Bp5EKMVK7zfmlcEL1xo6+2+TM6+73frKYoUyl0N/Ipse2Yn0bIa5x9MhYQ3iyQrsCFJQrA96fcFxzOJ7/EnLHj17wGwIQJOg7AhfhSUBR5jGgh23SVrs/Q9+0P8P0ky0nMFOxOZM+ddGCndlt1XNZcXYu1gvNCOytJvy2Ww3ykmxDDd8d145jOsW5lkd4PBlD2nNUNoVS1xLxYNVvEc+4YuW+qwDwTf369QA9UJSHQ5OMv3qwBVq4ZpL3wun6FklLEA9P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtO1PxXvwu6e341/QuIIy6C+ZgImvMwf5LBqoP7AGTw=;
 b=Rcdt2GtCAN38amVW02hIdwR2YGoMBQ/sIcv/8rhmhFVoCTheXQgJs1RNPcxvshScZbPmpxSUF2lFDjMOtEqRV5ST3YlwYZbrM+734aHcZFJH4DNPZVm2KE1wwLvKf11W3EaEHeNuy7zJJqId5gxuJ+zbFg/IUmNcYnUuWj96FyIZFV4gOfp+8Bgy8ACiijxB/RdnsIKo+wMi7Ic6lcrOPQhbIuI4EXyY2yiTafu2Jwe+gAoRp+PC6+rZswk7GdVq52cjXosRMBel24nktSgsfs5G6mzYnChvbQXjYE6A19N8HagC7jkCz27xK8fXjtCmfJWIzY1AlgXTjh1pI3chLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 11:16:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:16:43 +0000
Message-ID: <920e58ac-6a57-fdb1-a2c7-b6fef388917e@nvidia.com>
Date: Tue, 17 May 2022 14:16:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-US
To: Mark Ruijter <mruijter@primelogic.nl>, Robin Murphy
 <robin.murphy@arm.com>, Martin Oliveira <Martin.Oliveira@eideticom.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
 <3F2D3249-79E4-4CE1-940F-E1E0719EFAF0@primelogic.nl>
In-Reply-To: <3F2D3249-79E4-4CE1-940F-E1E0719EFAF0@primelogic.nl>
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26125b37-c92c-499f-d60e-08da37f6b913
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54257300E4B6E17BE590B0D4DECE9@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEdenpqKuAYNe5Mbwke0w/hrIlIJJN8MKy/n+N+AQ0TYulRY2eINGqztNfYIAW0uVCqvxNwyzBumUMQs4cF21aRf/W7ZJvWTjTOIhIfQfXw+2DnSh7p3tixXex4gdg8B4O2CI0ACXTRvjTOHYty5qTD5nI36Gvmok+SJNGd5SIaIQoBckQs/qx02EMkOxTBjFVz3gS+Ei/+CB4ATIh1nDnWH/BBjA4mmSAoI6rK+nbDdWbXNUkGuI+lLpqN/oIq68anBRrNOoYXzHmCajPNOrb5hON0sKGXd51poJvm039TRGAzn0GCTjYYU8Ne/YT1MhYeYLTitsh16ubnsgBM6Cgh/OHT75JtTqUicX/j8bbuULcaQvGQ15mzi/EI+FPicrxCaTWCltne6kNZpQxD+K+Z99PHyX2y1ladpCwYAjGnl17PeCvlz1AukzLguc7m/R/Xzp8oJqsS0YJZvMgXzdQ1INi8argr9yAfZ+DdsvOu8ShJcklji40WCCuhpYej2ruN09xKCKHi8kCB60GYzdlzzOFeDEMCACKAmVJZBLoNcV5DRPlUoI+lG068r4IgL5M25/qmBgDAtzNooSGywuJ6jT0PJ7GAljil1lAE9PXVg9kHMImM46ZwfCFI1FKfHRddsle6Lwx/Sf98H0nWn5HiMK93HMEDQFg+tfXceKKeqEvlUlXCn4P1aEFyiC3SzVmb8kNbNbgApPD3dZUvijVOFcFMgKiwPHSPXekJvGh3TaPGk+wvl2lCg5VYgr/ZDWVVPjb+4lmpKwKG9Jcu8WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2906002)(186003)(2616005)(508600001)(5660300002)(31686004)(8936002)(36756003)(8676002)(83380400001)(6666004)(316002)(110136005)(26005)(6506007)(86362001)(54906003)(31696002)(4326008)(6512007)(66946007)(38100700002)(6636002)(53546011)(66556008)(66476007)(45980500001)(43740500002)(505234007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NqMXhwSVZpYkVqVURBT1puZnh0Z2xtN1BKZ25FSStxQ3dwQUJjRWdMNUYr?=
 =?utf-8?B?VERESFVOejJxdTRGQnM0dTBVNW4rNXVMRThHaU5TaGEyd0VIdmRBREkya2Fx?=
 =?utf-8?B?NUF1RlBJb1dIbTl5cE13WTUyakxXWUVaN1dLNmNwQXFEZTkzcjRtUnRaWGJw?=
 =?utf-8?B?QlJoRU92aWxLU2FHQnZqOEVwSVU5VU9kVUhKbHlYTTRYWlBmMGwwU29jWkoy?=
 =?utf-8?B?UDVxdEc1dUwxc2lzUmllNmZpN0VaSmZwYmUyZDl6dWF2SSsrY1llRDBGcXhR?=
 =?utf-8?B?K1RzSGszQ250UTRmR1BPN1ZyNWZpb3p1Z3RWWU1ueXVGNzlUUXdQWk9LNkVO?=
 =?utf-8?B?UW5FY2dKVUp3OU1uSUlpeEFydjV5VXJKL2xEYjBkL3dlbkU2Um40ZDhvSzNO?=
 =?utf-8?B?WmI3b3p3TmI1RDRBWEZOWjhzN3VsZnVKTCtYZXd0SkJXZXNaeGtHWmNYRVpr?=
 =?utf-8?B?SWRmd0J2U0d1eUlkaUlxbTBjTVZKaVQxeDgvQTlITnU1UzMxTTViczF6Vm82?=
 =?utf-8?B?eHVsS3lJZjZlYU04eFlSTWl6bkN6cTFiQ3Jvc2ZIaUtBdnBuNUNkTUNxQmpB?=
 =?utf-8?B?RCtrc2xLZnd0alFFR3hzWFR4UStJWXRtNmFGWCtwVi9SQ0RWK0xhWElIQWVN?=
 =?utf-8?B?T1o4UXVvUldXRUlhUjRkbzNIakJpREhPWmNDbjlrVW9ERUhWRXdTcEROVUor?=
 =?utf-8?B?TDVrQmZhcnB0OXZ4YWNPV1lidlJLSE56OG11d0pOMEtZTjF1dW03TWVhWERl?=
 =?utf-8?B?WU5HblBPWUkrZGdIeGhuMDdZc3h1TEs3bWhRbkMxbE5SOXM3YUJjZUVBME5B?=
 =?utf-8?B?MHlIanNqamlpNXF0eWZQcFpCWW5oN2lBdEUydUVEVS9RaXpVN293ZG9hdnB3?=
 =?utf-8?B?SWxXTDF5eHpFeWZ6akMyNS9kUjNGQ29CcUVSZzNCdzA2cXNNWmo2UVRRWDVl?=
 =?utf-8?B?WjRBV2o5YU1HdXB3TE9CZDhQWFl1OE4wL1d1L082R08rb01oUkFpV3k4RFF3?=
 =?utf-8?B?OVR4aHhySEkrdWhUTFFKU1JtUGR2MTR5bTVSaG9EOW52NGNDcFozSUNjUm9z?=
 =?utf-8?B?cytsSDhEVStGV0w1ZExxandxMWZ0UTRNK3prZVZqOVZFNUQxUjQzZ3VUUExs?=
 =?utf-8?B?ZHk0QnRqMmwvR1hGRUIrMlRGNDhmTUUvVTFNNW9QWG1mam9zU0FOSFNPMGhW?=
 =?utf-8?B?Q2FqWHFaL2FtOFgyNFVST0FHZ0tzNkRWbGJ4YUtjS2ErT1FQcGJaVmtvQ0xr?=
 =?utf-8?B?bWJMTE42UVhIVDNwZWZPemR1cHFEM2hycVk1elV3czJaai9TNkxRTVBsMlQ2?=
 =?utf-8?B?d2UyTEVXUzl6MURmTmJMWXRrUzBrcWRlc3NVcWdqUXgramRvMDV0b2NzWml0?=
 =?utf-8?B?YTUwQi9iU0NCT1NYOUIvaGZsQUNveTU5UWRYUjN6VjdweHV0blE0QlZwZ01x?=
 =?utf-8?B?bVdmL2pIRkwvTUsvZlNoaE1QWmluaCtEdGdweGM2bTZKTTBCaklvcUczeTUx?=
 =?utf-8?B?K2MvSys1dk9KUHZsSHJtNXhTdUw2S3l0LzA4R0RENnlWdjZNNGc5OFVucXcr?=
 =?utf-8?B?N0txdU8wNEtEUndQUCt0YUlqV1IvckMyTVNvcmQ0WCtleWRYMWJWZG9oZ3oz?=
 =?utf-8?B?UzBiYm1SalFod2JERHR1L2FTNC8rMDRCdVlwUFlBaU9mU0M3Nit0eDcxZmQ1?=
 =?utf-8?B?d1JMWXFHRjNVVUFjdWwvTk4yTC91Z3krZldkMjFONDE0MHVHQVN0Q0xHU1Rp?=
 =?utf-8?B?TmdpR0hhNFEzWkM0cVN4ZHdSays0RHVQY0thTzYvZ0ROS0tuajU2LzdaU3RU?=
 =?utf-8?B?bFZLUktQQTZsR2YralNoblBlLzBpZ3hnWFNFSkVlK3ZQRUErRHFDeTkyOHlr?=
 =?utf-8?B?U0I3VFpZNk91U2p4dlRUbE9SZUM4QzNIc2t1SXFmYzFZakVZYVAyNXVuK0E0?=
 =?utf-8?B?TmFCVFFhSjUzWHZXZkJGTStXYURpSGgzTXI5SjQ1RjEwYkhEU3pqVFAvS0JO?=
 =?utf-8?B?TnNoeWpGTVY4Yy9oeE02aENkOEoweTh5S1pyVjZHUTJTbzRGNDJIa1hnZ05Z?=
 =?utf-8?B?QjVncm0xY1JPNEJ4U3d5QlNXTGdLaUIvaHNpRENCZUNMMkdLSzdnM05DWU5O?=
 =?utf-8?B?dUczSUpNblFRbUcrWmQ3UzRMcU12ZUZiOFlrTkE3ZTgrVVN3aXc2MkoyUjFE?=
 =?utf-8?B?MmtIME1nR2JvRkZQOFVyMm9xaHVKTW16cmxROUw2cFhBSG1RR2pUeUR2U3E0?=
 =?utf-8?B?ajRaMStvVk9SbVZwVW91ZHFIYUJGcjJ0eGZja3psM3RFU0xPd2JVZkdPQW8x?=
 =?utf-8?B?dFBvUFI5ZXNSWHlrM3V2R255UVNNOTE1YWlxRXRNYVB1MXBtY3djWGlHS2F0?=
 =?utf-8?Q?aeyAO41ZLlLATr68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26125b37-c92c-499f-d60e-08da37f6b913
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:16:43.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M2dL2q/CqW7DXyYR9C4EPfLm9puBnL2QHaRvfiBoGLJFLQs9bXuD2dkJ5VNpDbT6CIbNLi7Cg11FSF2A7lCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Lee,
 Jason" <jasonlee@lanl.gov>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
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
From: Max Gurtovoy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksCgpDYW4geW91IHBsZWFzZSBzZW5kIHRoZSBvcmlnaW5hbCBzY2VuYXJpbywgc2V0dXAgZGV0
YWlscyBhbmQgZHVtcHMgPwoKSSBjYW4ndCBmaW5kIGl0IGluIG15IG1haWxib3guCgp5b3UgY2Fu
IHNlbmQgaXQgZGlyZWN0bHkgdG8gbWUgdG8gYXZvaWQgc3BhbS4KCi1NYXguCgpPbiA1LzE3LzIw
MjIgMTE6MjYgQU0sIE1hcmsgUnVpanRlciB3cm90ZToKPiBIaSBSb2JpbiwKPgo+IEkgcmFuIGlu
dG8gdGhlIGV4YWN0IHNhbWUgcHJvYmxlbSB3aGlsZSB0ZXN0aW5nIHdpdGggNCBjb25uZWN0LXg2
IGNhcmRzLCBrZXJuZWwgNS4xOC1yYzYuCj4KPiBbIDQ4NzguMjczMDE2XSBudm1lIG52bWUwOiBT
dWNjZXNzZnVsbHkgcmVjb25uZWN0ZWQgKDMgYXR0ZW1wdHMpCj4gWyA0ODc5LjEyMjAxNV0gbnZt
ZSBudm1lMDogc3RhcnRpbmcgZXJyb3IgcmVjb3ZlcnkKPiBbIDQ4NzkuMTIyMDI4XSBpbmZpbmli
YW5kIG1seDVfNDogbWx4NV9oYW5kbGVfZXJyb3JfY3FlOjMzMjoocGlkIDApOiBXQyBlcnJvcjog
NCwgTWVzc2FnZTogbG9jYWwgcHJvdGVjdGlvbiBlcnJvcgo+IFsgNDg3OS4xMjIwMzVdIGluZmlu
aWJhbmQgbWx4NV80OiBkdW1wX2NxZToyNzI6KHBpZCAwKTogZHVtcCBlcnJvciBjcWUKPiBbIDQ4
NzkuMTIyMDM3XSAwMDAwMDAwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAKPiBbIDQ4NzkuMTIyMDM5XSAwMDAwMDAxMDogMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKPiBbIDQ4NzkuMTIyMDQwXSAwMDAwMDAyMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKPiBbIDQ4Nzku
MTIyMDQwXSAwMDAwMDAzMDogMDAgMDAgMDAgMDAgYTkgMDAgNTYgMDQgMDAgMDAgMDAgZWQgMGQg
ZGEgZmYgZTIKPiBbIDQ4ODEuMDg1NTQ3XSBudm1lIG52bWUzOiBSZWNvbm5lY3RpbmcgaW4gMTAg
c2Vjb25kcy4uLgo+Cj4gSSBhc3N1bWUgdGhpcyBtZWFucyB0aGF0IHRoZSBwcm9ibGVtIGhhcyBz
dGlsbCBub3QgYmVlbiByZXNvbHZlZD8KPiBJZiBzbywgSSdsbCB0cnkgdG8gZGlhZ25vc2UgdGhl
IHByb2JsZW0uCj4KPiBUaGFua3MsCj4KPiAtLU1hcmsKPgo+IO+7v09uIDExLzAyLzIwMjIsIDEy
OjM1LCAiTGludXgtbnZtZSBvbiBiZWhhbGYgb2YgUm9iaW4gTXVycGh5IiA8bGludXgtbnZtZS1i
b3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmcgb24gYmVoYWxmIG9mIHJvYmluLm11cnBoeUBhcm0u
Y29tPiB3cm90ZToKPgo+ICAgICAgT24gMjAyMi0wMi0xMCAyMzo1OCwgTWFydGluIE9saXZlaXJh
IHdyb3RlOgo+ICAgICAgPiBPbiAyLzkvMjIgMTo0MSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdy
b3RlOgo+ICAgICAgPj4gT24gMi84LzIyIDY6NTAgUE0sIE1hcnRpbiBPbGl2ZWlyYSB3cm90ZToK
PiAgICAgID4+PiBIZWxsbywKPiAgICAgID4+Pgo+ICAgICAgPj4+IFdlIGhhdmUgYmVlbiBoaXR0
aW5nIGFuIGVycm9yIHdoZW4gcnVubmluZyBJTyBvdmVyIG91ciBudm1lLW9mIHNldHVwLCB1c2lu
ZyB0aGUgbWx4NSBkcml2ZXIgYW5kIHdlIGFyZSB3b25kZXJpbmcgaWYgYW55b25lIGhhcyBzZWVu
IGFueXRoaW5nIHNpbWlsYXIvaGFzIGFueSBzdWdnZXN0aW9ucy4KPiAgICAgID4+Pgo+ICAgICAg
Pj4+IEJvdGggaW5pdGlhdG9yIGFuZCB0YXJnZXQgYXJlIEFNRCBFUFlDIDc1MDIgbWFjaGluZXMg
Y29ubmVjdGVkIG92ZXIgUkRNQSB1c2luZyBhIE1lbGxhbm94IE1UMjg5MDguIFRhcmdldCBoYXMg
MTIgTlZNZSBTU0RzIHdoaWNoIGFyZSBleHBvc2VkIGFzIGEgc2luZ2xlIE5WTWUgZmFicmljcyBk
ZXZpY2UsIG9uZSBwaHlzaWNhbCBTU0QgcGVyIG5hbWVzcGFjZS4KPiAgICAgID4+Pgo+ICAgICAg
Pj4KPiAgICAgID4+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMsIGlmIHlvdSBjYW4gYmlzZWN0
IHRoZSBwcm9ibGVtIG9uIHlvdXIgc2V0dXAKPiAgICAgID4+IGl0IHdpbGwgaGVscCBvdGhlcnMg
dG8gaGVscCB5b3UgYmV0dGVyLgo+ICAgICAgPj4KPiAgICAgID4+IC1jawo+ICAgICAgPgo+ICAg
ICAgPiBIaSBDaGFpdGFueWEsCj4gICAgICA+Cj4gICAgICA+IEkgd2VudCBiYWNrIHRvIGEga2Vy
bmVsIGFzIG9sZCBhcyA0LjE1IGFuZCB0aGUgcHJvYmxlbSB3YXMgc3RpbGwgdGhlcmUsIHNvIEkg
ZG9uJ3Qga25vdyBvZiBhIGdvb2QgY29tbWl0IHRvIHN0YXJ0IGZyb20uCj4gICAgICA+Cj4gICAg
ICA+IEkgYWxzbyBsZWFybmVkIHRoYXQgSSBjYW4gcmVwcm9kdWNlIHRoaXMgd2l0aCBhcyBsaXR0
bGUgYXMgMyBjYXJkcyBhbmQgSSB1cGRhdGVkIHRoZSBmaXJtd2FyZSBvbiB0aGUgTWVsbGFub3gg
Y2FyZHMgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uLgo+ICAgICAgPgo+ICAgICAgPiBJJ2QgYmUgaGFw
cHkgdG8gdHJ5IGFueSB0ZXN0cyBpZiBzb21lb25lIGhhcyBhbnkgc3VnZ2VzdGlvbnMuCj4KPiAg
ICAgIFRoZSBJT01NVSBpcyBwcm9iYWJseSB5b3VyIGZyaWVuZCBoZXJlIC0gb25lIHRoaW5nIHRo
YXQgbWlnaHQgYmUgd29ydGgKPiAgICAgIHRyeWluZyBpcyBjYXB0dXJpbmcgdGhlIGlvbW11Om1h
cCBhbmQgaW9tbXU6dW5tYXAgdHJhY2Vwb2ludHMgdG8gc2VlIGlmCj4gICAgICB0aGUgYWRkcmVz
cyByZXBvcnRlZCBpbiBzdWJzZXF1ZW50IElPTU1VIGZhdWx0cyB3YXMgcHJldmlvdXNseSBtYXBw
ZWQgYXMKPiAgICAgIGEgdmFsaWQgRE1BIGFkZHJlc3MgKGJlIHdhcm5lZCB0aGF0IHRoZXJlIHdp
bGwgbGlrZWx5IGJlIGEgKmxvdCogb2YKPiAgICAgIHRyYWNlIGdlbmVyYXRlZCkuIFdpdGggNS4x
MyBvciBuZXdlciwgYm9vdGluZyB3aXRoICJpb21tdS5mb3JjZWRhYz0xIgo+ICAgICAgc2hvdWxk
IGFsc28gbWFrZSBpdCBlYXNpZXIgdG8gdGVsbCByZWFsIERNQSBJT1ZBcyBmcm9tIHJvZ3VlIHBo
eXNpY2FsCj4gICAgICBhZGRyZXNzZXMgb3Igb3RoZXIgbm9uc2Vuc2UsIGFzIHJlYWwgRE1BIGFk
ZHJlc3NlcyBzaG91bGQgdGhlbiBsb29rIG1vcmUKPiAgICAgIGxpa2UgMHhmZmZmMjRkMDgwMDAu
Cj4KPiAgICAgIFRoYXQgY291bGQgYXQgbGVhc3QgaGVscCBuYXJyb3cgZG93biB3aGV0aGVyIGl0
J3Mgc29tZSBraW5kIG9mCj4gICAgICB1c2UtYWZ0ZXItZnJlZSByYWNlIG9yIGEgY29tcGxldGVs
eSBib2d1cyBhZGRyZXNzIGNyZWVwaW5nIGluIHNvbWVob3cuCj4KPiAgICAgIFJvYmluLgo+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
