Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B866C4332F
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 15:43:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A6D613DB
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8A6D613DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A605408BF;
	Fri, 19 Nov 2021 15:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-s2ifrROlq7; Fri, 19 Nov 2021 15:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B666401C5;
	Fri, 19 Nov 2021 15:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16579C002E;
	Fri, 19 Nov 2021 15:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA10C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79D87401E4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QEISvugpk-iM for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:43:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 466DC401C5
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6hfN3/UPSx/wrdOQt9b/wMFv7znAf5BjI82pGXpyhS7C5dUaHGypdBhRdwhIEE0vpOPfORuMutGxy3E7U6TqlYLcSrTSraPGql9UYzSvePLyHipZsJpBOS2elCdjWD9IGHuTdKegnL9s6n6PWgB0Mgyr3gGxx/+hYZWSFYS582kaL41vyn14jWTrZfoSl7BIm1i8rkuwBCXjEgLAUJgIcyB/NkGCF0uUK390N4uP3JbVvpB8DKod/ij0rwnfUx+x1ZM372I7jSbox1TIuUiBmV56ujpVR1OH7lt2ZhBITt/DSzgg0m9bWH60WX9U35XQDcLyktlGhDco4HmmUsOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLrJtbHtjzsw1lTS8W2bBKApGBePUKm9+tkx0oIk0mU=;
 b=aoTYQ6D4RT83bgggqOe4XXa4LVKdQ8xtwnZP3OvX3H1UhGMrVLBAlv8Af7RbDAa1GBZMcTdMXfJJsaqlGK1jJsIATDWmGiYb43m6rpu48IasBh211k4gIo3bj5ycdRFLFhSWpMM/dxCvYNiOkYid8RarTY1nNuJ97Oy6q67W2FShFJdhZ/693oJoMnHytbq4zqKdEzDiFP/QGUmyvPMoocA4qssb54mWh/Ww7n7QxCpjC1TPVuusjkQLTlHzrEf3BBfJllhoIUmrGKLZhnsMgjq33etjpRjh+9Tk5/dTF1CqAJ6BcfDQ4dI47KrmMuTR4IYEmqyWuWJaebcHFy3Ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLrJtbHtjzsw1lTS8W2bBKApGBePUKm9+tkx0oIk0mU=;
 b=dH5QqIvhHGQsGG8IT7TZ6V01Diw9Y5bOxuur+MZoMaA+8a8lZMj2ReQh1F8sNkRTVHuC8Lw3kfFh4dL9oVu3prc8ajH6WMYW1ZQqFcPxSWAejKw4rJW8dGzw95MkYlNwptmzUv8dlODNdJ+LIo2V3lKqS1npgGTIQx3ZAHL1eSLDRCWEw3nFScIipFhs29WDG9wTzDPQuXgoAxFsw0Qk0T/52HiPlVzRE0pvQtbU6rZXlm2wudEOBRwD0jKBfJF6/EF6i/ifZwzopVIIR4y/qF4gv8zY6i/xhnKJ4VB2p9Yp4C2T0EdmOKh8HOViy9R2c4FKPLPTeN/xGCa28pirvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 15:43:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 15:43:15 +0000
Date: Fri, 19 Nov 2021 11:43:14 -0400
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Subject: Re: [PATCH 01/11] iommu: Add device dma ownership set/release
 interfaces
Message-ID: <20211119154314.GA2105516@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-2-baolu.lu@linux.intel.com>
 <YZJdJH4AS+vm0j06@infradead.org>
 <cc7ce6f4-b1ec-49ef-e245-ab6c330154c2@linux.intel.com>
 <20211116134603.GA2105516@nvidia.com>
 <BN9PR11MB5433639E43C37C5D2462BD718C9B9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211118133325.GO2105516@nvidia.com>
 <BN9PR11MB5433E5B63E575E2232DFBBE48C9C9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <75100dfd-9cfe-9f3d-531d-b4d30de03e76@linux.intel.com>
 <20211119150612.jhsvsbzisvux2lga@8bytes.org>
Content-Disposition: inline
In-Reply-To: <20211119150612.jhsvsbzisvux2lga@8bytes.org>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 15:43:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mo62k-00CHa4-Qs; Fri, 19 Nov 2021 11:43:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1d1091-bf1c-44e4-2771-08d9ab734d5b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-Microsoft-Antispam-PRVS: <BL1PR12MB531754113FF903404F6FE028C29C9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPNAZflQQgBXFjz0w8xG1xRFeSt1B7dZfcGQ4S5ngNdVL2BcRFDNl8Kb5MCt49DfFPQ5/M+d/DWCu5ebU/ub+YzECdUvzorvLomwhBn/LoKOKv9B1EVMdjk2oV+orKEdL7cbgL6+4NhBTvmxKK8NVaPJ9wd3b3ggjeck9ZA5jUb5mdSRLQBuyZXlcu5LbikItFTa7EkDjN3R9Sx9gE/6sepb4GCkpdoSzicKIS2Jc37nltZEngtgbMFWHBrEARogM8xi/6um7db7ZGMH92K3Ur0I6F8Sz+kQVopJe4IsxwuaUQf6p/uDjP5YwwFUGbI4mL94QCCTqFEb8HtflKw4v7lMYxZgpvl79p1u3lpo2RX5TRwYw0uTL+BZnUh3wmSlHKD5YevOt8zNy5YqOXEp4DLfkn4A0a9CCzI7Un176eTiIGGsNITJY7Iq6aguyjhhu6X8eEpWQKFEhazuXmAtMChm8V+Vsf2E2aQlbfYKLjUIASLNWWXJzsDi7QVq8GlIONUShWljSxcaLvxuF+e+Jhs3dZHPvQM2uXsiQQJWuPVHiduaW7q2VPqoR2/TrxP1uGsd0ALR9mcEpnM8Dg/Vv8NjxRttSoQHTe0svG2uPOBTbssaFKdVkR/bzzv7omculCdjUQkDSZluN7kVtBqbMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(6916009)(8936002)(2906002)(33656002)(2616005)(186003)(83380400001)(508600001)(4326008)(26005)(1076003)(9786002)(9746002)(8676002)(66556008)(66476007)(66946007)(7416002)(38100700002)(36756003)(426003)(66574015)(5660300002)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzF1cDhzcEVBQlFSbzRVT3MvS0IxNGZZNzNQeFNIdjY3dHYxbTc2OUxiTi9x?=
 =?utf-8?B?VHozdlQ5Z2xjemFqVWg2SzBuNlZYLzZncnJtY1BLcjVBbkRzUFdwRDF1OFR4?=
 =?utf-8?B?VCtqMHRMTUcrMGt6dVBxbWV0Tm80Z2lCNGlOc2hMbisrRkNpdVQ1Q1M4QzNU?=
 =?utf-8?B?MTRSaVlIbWVsSzA2cTloM2VyY1c3KzI0UThKM0RScXZsdkg0ZTc4QkEyKzlG?=
 =?utf-8?B?Z0lWRFJiczBzeE1yVE5NN1RhTlFFZGtsUnkzOGx1K2JmeXZuNExJVzd3UHBU?=
 =?utf-8?B?VzkrTlBXZGE2R1FOTFdsMWFRVXI4c3oxc1FhTE52VmVmNW1rbk9oRmxPaEJL?=
 =?utf-8?B?amhQUkhaS01LRldMRnJYeHYvRG5UTHI4SGgxek9ucHAzbktsNXVRVmp5dGRr?=
 =?utf-8?B?WFhCV2N0a296citpNjBEOGlwemhsclVkMkFRaW1kYVJWTERiaXVPRVNLQ2Zy?=
 =?utf-8?B?Qzk2c2ltcW8yVzMzZC9aQm1ha3VJS2FOblNERFhLN0Z5NUZaMHU1b2hDU25V?=
 =?utf-8?B?ODF3aUxlV0M1eUZnVXFQaGFnTE1ZaXRGR21wdTFRejlCZXhCVUtlY0hSdDRU?=
 =?utf-8?B?ekVwa3l0WCtBdjN0SC9LdUIwRVlrclhLbEduS2Iwb3V5ekNtUUdBa3YzQ2ov?=
 =?utf-8?B?Lys1RzNDUU02RkRISVR0a0tRQ2N1Um01OGEwT2tiUDBOVnZKOFVIcy9KSXhs?=
 =?utf-8?B?RG5zN0hLWUgvTGxKMUhlMnU5ZlZ3UDIza0gzWTA4TDNVWWs5T2ZCVnFjVzMw?=
 =?utf-8?B?UDZ1T094anJ1VkhQOTB6K3NPNGRpY1Q2RmppKy9TdUtiZGZrTXdKcEkvZ0Ux?=
 =?utf-8?B?RkkwbkVmS1p4U0x4VE5SVDBkdE9xMFRpM0hsdnlHMXZSdTNTY3E0aWZaNnBI?=
 =?utf-8?B?ZDloNEM2R3B0T2VTSURuN2VyYUNxS284NzgzZ3YyTmZWRitucW9XU0hUYitC?=
 =?utf-8?B?ODRFOGxFR1QxekhQaEVqTCsveHU1OFE2YkhiMHA4R3JJVTZJWDgzd1BNa3Ez?=
 =?utf-8?B?cEc3VFMyUkUwOGVjeUNJQjVQeis2S3JIK0RMZ1k0VHFXVE5BVW1LeC8zNlps?=
 =?utf-8?B?VzR4c1g3dlV3cDlPajB1QXNJUk1XalpkVmFud3E0OElIT0hXaVBZWEhqVFdH?=
 =?utf-8?B?N050S0wzdzJlZzFvb2hVcEhLK2p4cFExZDJ6RS9Qb1lubTg5Z2xBUnYwQ0Mx?=
 =?utf-8?B?YlJYRUZrZUVybGZxUnV0TW5PS0EyUlduKzJkSURCNGEyZG9KUUVVNUhNUElZ?=
 =?utf-8?B?QXBHY1BsU3F0VG1wM0l4U3pKdWk5amx5alZIdVp0UGpsdWgzR3hIVEZNZW93?=
 =?utf-8?B?c3FmUEgwaFZxWVpOSVRBOVZmUytKQ0JsRlJubXRrQ2RDL2JwZkNiRXUwcWZZ?=
 =?utf-8?B?ZllLWmhKdFBXTUdtSG05anNKVDNmeW8wbUd0cFhHYW0zQ2FnVi9PM3YvS0RB?=
 =?utf-8?B?R0tnVXBpNVJXSUJoL04wc3hvdldCUUcrVEx6QVpCUW9LalZuM0E2WjljL1V2?=
 =?utf-8?B?WkpjaWJFd3JFZDVCZ0cySEtmOUZxWExsUU9yVE1xUmROTlEzZjR4NC9pQkZD?=
 =?utf-8?B?bVMycXVDdDFYMnNyQTl3WlpGbWhlSlBFNy9LcUd3TzlVNzBBZFBuV3REWmty?=
 =?utf-8?B?YUxKdEtDQVhZNWhPaFpvcWJ5RS9KeXF5S1VxdnNZYy9Edk9IR1JpRHNjcnFF?=
 =?utf-8?B?c3lydEQ0Y1lrV1hlMHd1RDNnb09PcEtNRnBxdXJncVY2bXpRYUZNVmpVSnJl?=
 =?utf-8?B?YS8wU0k0YzJaTHJMY2ptdjlsaDJxTStPVzMzTnRNYWdpaFB3N0NNY1ZnNndJ?=
 =?utf-8?B?RTJzbVJibnZab0syclEvZlppeWtIUVJueVdmSTZ1cjU4WTBjYng0RmplRVM1?=
 =?utf-8?B?TS85VVZocXdTZ0ZpSTY4NGpRRUx3RlovbEZlT0IwbVRXOHVFcWNQWjByZEtl?=
 =?utf-8?B?T1hVQlpWYTY3WXpRVkljSm5BN1FMc2wvUUxGbEFtZ3lmWlhXS2hFSDNrbFM0?=
 =?utf-8?B?ZjJla2hqZ0FiTk0rV2FjQUhsK0JxR0Y0WUEzKzBlejhvVWplQ3BjMEFKUUND?=
 =?utf-8?B?Um1oK2ZLeDd1c1JGUFlDZjlMVWUvdmNNU1o4aUZsd21oSnNOQUs3NEJZSlgz?=
 =?utf-8?Q?SYCg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1d1091-bf1c-44e4-2771-08d9ab734d5b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:43:15.8716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FD+S709PV/BUKHyaiX73/2a3AkJDSph6E9d78J/VnbuIwU6rQlSoz9oIkRC4Agp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Cc: Alex Williamson <alex.williamson@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

T24gRnJpLCBOb3YgMTksIDIwMjEgYXQgMDQ6MDY6MTJQTSArMDEwMCwgSsO2cmcgUsO2ZGVsIHdy
b3RlOgoKPiBUaGlzIGNoYW5nZSBjYW1lIHRvIGJlIGJlY2F1c2UgdGhlIGlvbW11X2F0dGFjaC9k
ZXRhY2hfZGV2aWNlKCkKPiBpbnRlcmZhY2UgZG9lc24ndCBmaXQgd2VsbCBpbnRvIGEgd29ybGQg
d2l0aCBpb21tdS1ncm91cHMuIERldmljZXMKPiB3aXRoaW4gYSBncm91cCBhcmUgYnkgZGVmaW5p
dGlvbiBub3QgaXNvbGF0ZWQgYmV0d2VlbiBlYWNoIG90aGVyLCBzbwo+IHRoZXkgbXVzdCBhbGwg
YmUgaW4gdGhlIHNhbWUgYWRkcmVzcyBzcGFjZSAoPT0gaW9tbXVfZG9tYWluKS4gU28gaXQKPiBk
b2Vzbid0IG1ha2Ugc2Vuc2UgdG8gYWxsb3cgYXR0YWNoaW5nIGEgc2luZ2xlIGRldmljZSB3aXRo
aW4gYSBncm91cCB0bwo+IGEgZGlmZmVyZW50IGlvbW11X2RvbWFpbi4KCkl0IGlzIHRoZSBzYW1l
IHByb2JsZW0gVkZJTyBoYXMuIEl0IGNoYW5nZXMgdGhlIGlvbW11X2RvbWFpbiBvZiBhCmdyb3Vw
IHdoaWxlIGl0IG9ubHkgaGFzIGEgc2luZ2xlIGRyaXZlciBib3VuZCB0byBvbmUgZGV2aWNlIGlu
IHRoZQpncm91cC4KClJvYmluIGlzIGFsc28gcmlnaHQgdG8gcG9pbnQgb3V0IHRoZXJlIGlzIG5v
IGd1YXJlbnRlZSB0aGF0IGEgc2luZ2xlCmRldmljZSBncm91cCB3aWxsIHJlbWFpbiBhIHNpbmds
ZSBkZXZpY2UgZ3JvdXAgYWZ0ZXIgYSBob3QgcGx1ZwpldmVudC4gVGhpcyBpcyBzb21ldGhpbmcg
VkZJTyBpcyBhbHNvIGFibGUgdG8gaGFuZGxlIHRvZGF5LgoKU28sIEkgdGhpbmsgdGhlIHNvbHV0
aW9uIG9mIHRoaXMgc2VyaWVzIGFwcGxpZXMgZXF1YWxseSB3ZWxsIHRvIHRoaXMKcHJvYmxlbS4g
TGV0J3Mgc2VlIGl0IGluIHYyLgoKPiBJIGtub3cgdGhhdCBpbiB0aGVvcnkgaXQgaXMgc2FmZSB0
byBhbGxvdyBkZXZpY2VzIHdpdGhpbiBhIGdyb3VwIHRvIGJlCj4gaW4gZGlmZmVyZW50IGRvbWFp
bnMgYmVjYXVzZSB0aGVyZSBpb21tdS1ncm91cHMgY2F0Y2ggbXVsdGlwbGUKPiBub24taXNvbGF0
aW9uIGNhc2VzOgo+IAo+IAkxKSBEZXZpY2VzIGJlaGluZCBhIG5vbi1BQ1MgY2FwYWJsZSBicmlk
Z2Ugb3IgbXVsdGlwbGUgZnVuY3Rpb25zCj4gCSAgIG9mIGEgUENJIGRldmljZS4gSGVyZSBpdCBp
cyBzYWZlIHRvIHB1dCB0aGUgZGV2aWNlcyBpbnRvCj4gCSAgIGRpZmZlcmVudCBpb21tdS1kb21h
aW5zIGFzIGxvbmcgYXMgYWxsIGFmZmVjdGVkIGRldmljZXMgYXJlCj4gCSAgIGNvbnRyb2xsZWQg
YnkgdGhlIHNhbWUgb3duZXIuCj4gCj4gCTIpIERldmljZXMgd2hpY2ggc2hhcmUgYSBzaW5nbGUg
cmVxdWVzdC1pZCBhbmQgY2FuJ3QgYmUKPiAJICAgZGlmZmVyZW50aWF0ZWQgYnkgdGhlIElPTU1V
IGhhcmR3YXJlLiBUaGVzZSBhbHdheXMgbmVlZCB0byBiZQo+IAkgICBpbiB0aGUgc2FtZSBpb21t
dV9kb21haW4uCgo+IFRvIGxpZnQgdGhlIHNpbmdsZS1kb21haW4tcGVyLWdyb3VwIHJlcXVpcmVt
ZW50IHRoZSBpb21tdSBjb3JlIGNvZGUKPiBuZWVkcyB0byBsZWFybiB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIHRoZSB0d28gY2FzZXMgYWJvdmUuCgpXZSBoYWQgYSBsb25nIHRhbGsgYWJvdXQgdGhp
cyBhIHdoaWxlIGJhY2ssIG5vYm9keSBjYW1lIHdpdGgKY29tcGVsbGluZyBhcmd1bWVudHMgdG8g
anVzdGlmeSBkb2luZyB0aGlzIHdvcmsuIEkndmUganVzdCBiZWVuIHVzaW5nCml0IGFzIGEgZ3Vp
ZGVwb3N0IGZvciBidWlsZGluZyBBUElzLiBJZiB0aGUgQVBJIGNhbiBhY2NvbW9kYXRlICMxIHRo
ZW4KaXQgaXMgYSBiZXR0ZXIgZGVzaWduIHRoYW4gb25lIHRoYXQgY2Fubm90LgoKSmFzb24KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
