Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC65C433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B570983EFB;
	Thu, 12 May 2022 11:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQa64fyQ078o; Thu, 12 May 2022 11:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9572983F01;
	Thu, 12 May 2022 11:59:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43006C0039;
	Thu, 12 May 2022 11:59:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 137C0C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E87CA6109E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLQRUOZ4r_mQ for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:59:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::619])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C99B560FA6
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaaA0DJ0kUz1FlQwA4RkShoWo8urJHIxEtdxhlY8p7Nuzo5yNFFO63KhZBVGLC+g05D1F6O7C3d4GbsZ7s6tfPufPz+aMLQ3gJRP5fhf5mm1sSoRcGbZW9UtWNkDIizpPs4BFyOIA0mDRUNcT34jmw9B4FGdCRWd7MdNB4wnClbHmKv1o82s108Xoa7wi/7AHiag94KfLwLc6J4KMCbpGvXiYrfHucYR6sagC5guelJnEp/whRb9Zy9s/tRBuAmSSSQUfDYgY/sPmZyGlT9YDBAk0zNrwHM+QhSCWc7OzhwgvZV66A6euNvtAREmn61y7PZ9Qw22R7T9Q2YdHEw/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP+aIDFPnvSU1wfo1pDmRvDR+XhuPabbsVt16h1mxd4=;
 b=kpGMzgoM22AZgynJ1HNOo9rlOddHjymRLbgUWUNLqUK4mPoB7OxBNPpvxXL6GVBuX6MJEFqXcFUq7L6bKpz6R1JpQtCAr++uJah+zG+0uPsdnKtUpeGtWHpD2H9FLqdG3JSMRiKNPWLN07YpG4O+i9kJZN9QIpD0aN9HDUbyHFdIjlPvVBUzZfhkvwg7j/b5QCYRtrQLGgoh5f7u42hGdYSlaW5MhrVtJY0YW1tXsLXIOJzVIxs/LLWqb6mj45wvGi0EjrcOJlSJzFI8LSjPRFslxfrsDHJr2ngyIZ0eylJUp9Z0D+4KZp5rFQQArAHT4OnL4SkCv+S4cvPRWRa+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP+aIDFPnvSU1wfo1pDmRvDR+XhuPabbsVt16h1mxd4=;
 b=Ppzx+3+DavHUkzS7VhJPj3QLmlQlP87RqBpqtyOR5zXgzX1lTt1o/6NGANwwNlnBYyTrQq7tJqKxuVBUf0TGkF0C/kq3r6Z6dJ2Q2tJQnKAvsCZEvj2THi6/uEXFqwr5gb16MwsT0HmZHoO96W/l8dWUp35Li4X5lFaIcjMubPpGVITKTCzpx7Cr3Txf90KF/Ut47pQvKomKCFxEJobgi2LYpTxqXzGK7qIW0jw2HnjvVDA2ny+d0PjfEqrAl34UoeYBWF6T2bKfEAyUQSfsebmM3hHpWYs/7HkXPaT4IOw9iT301PFvP5ksSApWIp8abIm6FZyk+iUpx7JwPv4cMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 11:59:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:59:07 +0000
Date: Thu, 12 May 2022 08:59:06 -0300
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Message-ID: <20220512115906.GX49344@nvidia.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
 <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
 <20220512113241.GQ49344@nvidia.com>
 <tencent_64CD1D42838611CFDB6E6A224DF469C10D08@qq.com>
Content-Disposition: inline
In-Reply-To: <tencent_64CD1D42838611CFDB6E6A224DF469C10D08@qq.com>
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a258ea-196c-48c6-a929-08da340ed189
X-MS-TrafficTypeDiagnostic: BN6PR12MB1585:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1585309EC24566D312D1A1F3C2CB9@BN6PR12MB1585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcSO2g9Yi8aPMjrYtfoGVsphR82zLadTXkXzEhZKdXRbxBHgRwrJsUfIW+M1FHeTGiRSR+Y4SPAsQhlL02WqM6cSCXozu775SQL+pNdAM9MOH/LnzYPgo1UNRC+cIMmIQPI/wZkqs/tjQu5ET+Gbv0WBLGE5nn5uaTCneTazIG/0kVDhzcWm56Mg9ySfSjuzFau/Uq8zcEHdyr6rV2ybwxZRt6miBnBYusIsmcBWQpBlMMkR3RvXif9awEjNfnFN7y2xivw4YXwq7Dh/9wR1jmWIPriHaDeD56i46a4SjXOn6VXO0Ig/RXZaBfbSOPqXUnYJqIhK4l8lmM21C1a6hvAjhg50HuD5ZN8vXBBdXkL0putitTUbtu1seKd6b8rbLJYCLpVOwAFC45q6TEL/PAtK3wyf0NywsqJ0NvJzNltX6DMwGDnJs7MMuiEA9eCh/MF/rgNQ+cEnQItGFEzhBpukn+E8tqsgtpGR2DN6UHJ1GvKWPPjeBwpMZvBGvPJad+T3BGhup7x9zibDqzEV13OJU+kOP0sSHcL9iP73VhseBxiaysSLXPMuYeWZlytde/+CnyRFoCo5nC6bvcR+HQSh40mv4tbS9naVppnpxrNIQcYnstTsPqhLo+Jit46D0bUtOTx6E2QQrF2e2R0y3pnx5QgquBi7S50kPXV1tz+knlPSVPL77oocxfOJGPhwzmLtLYDJMgJhDrfSlmf33g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(66476007)(7416002)(26005)(5660300002)(6512007)(316002)(1076003)(83380400001)(54906003)(2616005)(86362001)(38100700002)(6506007)(6916009)(6486002)(66946007)(66556008)(4326008)(36756003)(8676002)(8936002)(33656002)(508600001)(2906002)(48020200002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVA4UWIwTjBXZnpuSzZVREtBZjlOWWVvZzNIZlkyUU4zQTV6MDNxNVdJalND?=
 =?utf-8?B?K2VOYy9DMlhFRGtMbDdxOEs2Z1lTOXYveGI2d1ZwT1FPdWtMK2FNbklFUWlD?=
 =?utf-8?B?Qk9HY2k3NTBmYlFQZDZkSllwbUxDT1BENEhJVXVpRU1FWi84SzlCMTJvYXEy?=
 =?utf-8?B?MW1JQjU4VUhUc3Y1RG5mc3k1YW5FR1FHQzZoME85WTNSdDFyOUE0SzhkUUUx?=
 =?utf-8?B?OTZad0Rwa0FTY0huZGVIdUQ1VkU1VkpvRlJ4ZFovcENoYUlVZ1NYZDUzNGlv?=
 =?utf-8?B?bFlKbjFVWUIxZkp1NmJjQnpaSlhJNkkyUjEwV1BCc3k4dEpmWE9ISWtxYUZX?=
 =?utf-8?B?ejJZWHd2UVllcjR2RVZTY09mb2ZXRWUxRU1XMnpac2VYWVhRMGwxZ0hZVlVv?=
 =?utf-8?B?VHNhSGRCb3A5cmQ0ZnJqMVJmZTJrRjZMT2VvcEM4NVNqelZ3d0EveWhYQUNS?=
 =?utf-8?B?alpTZFBCdzJRS096UFNUSkZtK2FYa0hXdGNMNWkyNVVTV2NYOXNreUtMdy9X?=
 =?utf-8?B?c0JLNXBxSVlUb1lWL2ZCWmNJQXVTUFg0Z3p5V0F6MnZlT0VWNDlIREFhTEJn?=
 =?utf-8?B?NWFmMkZWUCtIblpxaW1mVGUwTHBYQ0g0TUxaTC81UGZPZnhkTS9nSDc5Y05w?=
 =?utf-8?B?c3ZvbGU5OG9rMmx3RWc3VFI4S1NwZ3dJZWtuM0Fqc1RmOXBmTDdjTzEyOGJJ?=
 =?utf-8?B?MUhuL2FvUFArZ3BqdG9tcE9lVmdsbHdjeXZyRTZ5c1crQTVrTllEcU1KdEdZ?=
 =?utf-8?B?bEN2YUw2NXNPdnpWcGVRMEt0c3p4VVV6LzZjbmdRRDZpOGY5VnBFMjVYaUVn?=
 =?utf-8?B?Y3lDRW94YlB6aWxRTUJNcUNQb1h1VE83cTdLQlR6bWdTTkVLMlQzWHdRMFdU?=
 =?utf-8?B?UW54a0JQNmIvNStYRUsxbkFvenlZYklVZi9FcHRuMitPWCtjOWFCVUFJUkxO?=
 =?utf-8?B?SXBqVkRQa2JJWDdjMHVMS2U3QzNTSDRVL2tEU1dlNXEzMDI1ZXVHM0R1eVgx?=
 =?utf-8?B?dHFjR3RKMjBkODYyOWZMMnVnRFdhb3ZFOHN5cGs1OEt5SW82MFV6WFhXRG5v?=
 =?utf-8?B?K1lPRTVReGNjK0t5VU92eDFVaXBiajFLQ0JvS2cvNVpXUTdsZS9WaWhCSXlo?=
 =?utf-8?B?TjEwVWpDOVZaYk1Cd3NjRjNmV3NsK00yVWljV2hMQmxqb1o5aElENWp5OXNo?=
 =?utf-8?B?YU4vcEJhRGN0K0U2THdUUmo1VU1IWWhXR2x2VEFBbnJDS0R5ZUh2MVlPZXNs?=
 =?utf-8?B?bURGSGQ2MFZVK1ZTTlZyc3d6OGdsUkQ1czh0cXYwL3hxZWdnaElTVUJpK3hk?=
 =?utf-8?B?VEp3NEczb3Y5eWU5QXNCb3R4cUlPZFVoaDdoSTA5ZVFWR0JWQ0RTYmxiUlNE?=
 =?utf-8?B?U1VKeVoyTmtYQUdRUnM0V1Y0MkJIc3ZwNTB1OXZhYXZaU1c1VnFzRDlDZllX?=
 =?utf-8?B?dG9TR0ttUDF4Y2EyOEdLTklaUGt0ZDNuUWVYNUxQT0J0VWxiWGhiS0t6b1N6?=
 =?utf-8?B?WWFKamZPeWNuV1J4bjBIeTJySjZGT2pOdnNKQk55cGhaM2ZKQS9BaTk4QTQz?=
 =?utf-8?B?UW8vWFFvUFBXa2xvMDZCc253Ri9tenkwWGU5Yzc0dXlZSnc1TWc2MXVEMXZK?=
 =?utf-8?B?ajlUcU5lR3ZMc1Rndk1NQWdtYlVNSlNVWDJSVDJpdVhKaUMwb1JiTG4xLzVk?=
 =?utf-8?B?V1RMbGxFV0h3MlZqK2xRQ2gwQ1lYMEtEZWoyODZvbkJuN3JBU1ZIWWVXSDBR?=
 =?utf-8?B?dWFLN2Z4SGxlQ3gzY2p5NEUyU3NmMHVBV0s1WnRqUGtBMkZlMkt6eUJ4WUlJ?=
 =?utf-8?B?RmowbGFDVFJPL1NLWDc1ZmpHSm8zc2ZXLzY3d3lMUUtvbS9wZXVYazcxZEk5?=
 =?utf-8?B?VWMvdis5M3NWZnk5TVlhK2NKTjRsZnYvNWUzMk1hT0daUUJVYXNFMkRsK3Fj?=
 =?utf-8?B?UG8rNWRSUjdvR21YOXZVZkdSZHNSUm5taFFWb3ZJK3pFOTZVQ1pPWTcrVkYx?=
 =?utf-8?B?TGx4a0ZRZ2FES1RLL21BVDFrVVRjMThpb2NOKzZ4RnFpci9LcUY3cU9zNVRY?=
 =?utf-8?B?aGkrQUowYk0yYnBYQmZvRmVtWGhOL1lFVVBtMWVLdkQ3b1NneDVYTmdxY3Zz?=
 =?utf-8?B?aDhpbGFhaXgzYXdHeE5LZFo3eDkwdmtzbkdVSjdNOTl3OWhWbGtRUFFsMGVr?=
 =?utf-8?B?WEZ3eUZmVyt1Yzd6Nkp1TllyMlhLcC9jVmUxQk5YQnJLQTV6cFUxRTdYZEhJ?=
 =?utf-8?B?YnJIQ0NMR1ZIWFdjY0RKSENMVkExYUFyNDRyeS83Rm1kaGR1WkNtK2JaOHlQ?=
 =?utf-8?B?ZVFrZ3A1N29PS3lGUStjWEZRa0FlTk1FcjM3YmdSbXRvL25hZ1llQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a258ea-196c-48c6-a929-08da340ed189
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:59:07.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P088getIBo0D9CpEX/yqZD0R+NHjwc2bSuqB8q+2TNaZl5imEzSvUsCOPGA2qYT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Vivek Kumar Gautam <Vivek.Gautam@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMDc6NTc6MjZQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjIvNS8xMiDkuIvljYg3OjMyLCBKYXNvbiBH
dW50aG9ycGUgdmlhIGlvbW11IHdyb3RlOgo+ID4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMDM6
MDc6MDlQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+ID4gPiA+ID4gSSBjYW4ndCBoZWxw
IGZlZWxpbmcgYSBsaXR0bGUgd2FyeSBhYm91dCByZW1vdmluZyB0aGlzIHVudGlsIElPTU1VRkQK
PiA+ID4gPiA+IGNhbiBhY3R1YWxseSBvZmZlciBhIGZ1bmN0aW9uYWwgcmVwbGFjZW1lbnQgLSBp
cyBpdCBpbiB0aGUgd2F5IG9mCj4gPiA+ID4gPiBhbnl0aGluZyB1cGNvbWluZz8KPiA+ID4gPiAg
IEZyb20gYW4gdXBzdHJlYW0gcGVyc3BlY3RpdmUgaWYgc29tZW9uZSBoYXMgYSBwYXRjaGVkIGtl
cm5lbCB0bwo+ID4gPiA+IGNvbXBsZXRlIHRoZSBmZWF0dXJlLCB0aGVuIHRoZXkgY2FuIHBhdGNo
IHRoaXMgcGFydCBpbiBhcyB3ZWxsLCB3ZQo+ID4gPiA+IHNob3VsZCBub3QgY2FycnkgZGVhZCBj
b2RlIGxpa2UgdGhpcyBpbiB0aGUga2VybmVsIGFuZCBpbiB0aGUgdWFwaS4KPiA+ID4gPiAKPiA+
ID4gPiBJdCBpcyBub3QgZGlyZWN0bHkgaW4gdGhlIHdheSwgYnV0IHRoaXMgbmVlZHMgdG8gZ2V0
IGRvbmUgYXQgc29tZQo+ID4gPiA+IHBvaW50LCBJJ2QgcmF0aGVyIGp1c3QgZ2V0IGl0IG91dCBv
ZiB0aGUgd2F5Lgo+ID4gPiBXZSBhcmUgdXNpbmcgdGhpcyBpbnRlcmZhY2UgZm9yIG5lc3RlZCBt
b2RlLgo+ID4gSG93IGFyZSB5b3UgdXNpbmcgaXQ/IEl0IGRvZXNuJ3QgZG8gYW55dGhpbmcuIERv
IHlvdSBoYXZlIG91dCBvZiB0cmVlCj4gPiBwYXRjaGVzIGFzIHdlbGw/Cj4gCj4gWWVzLCB0aGVy
ZSBhcmUgc29tZSBwYXRjaGVzIG91dCBvZiB0cmVlLCBzaW5jZSB0aGV5IGFyZSBwZW5kaW5nIGZv
ciBhbG1vc3QKPiBvbmUgeWVhci4KPiAKPiBCeSB0aGUgd2F5LCBJIGFtIHRyeWluZyB0byB0ZXN0
IG5lc3RpbmcgbW9kZSBiYXNlZCBvbiBpb21tdWZkLCBzdGlsbAo+IHJlcXVpcmVzIGlvbW11X2Vu
YWJsZV9uZXN0aW5nLAo+IHdoaWNoIGlzIHJlbW92ZWQgaW4gdGhpcyBwYXRjaCBhcyB3ZWxsLgoK
VGhpcyBpcyB0ZW1wb3JhcnkuCgo+IFNvIGNhbiB3ZSB3YWl0IGZvciBhbHRlcm5hdGl2ZSBwYXRj
aCB0aGVuIHJlbW92ZSB0aGVtPwoKRG8geW91IHNlZSBhIHByb2JsZW0gd2l0aCBwYXRjaGluZyB0
aGlzIGFsb25nIHdpdGggYWxsIHRoZSBvdGhlcgpwYXRjaGVzIHlvdSBuZWVkPwoKSmFzb24KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
