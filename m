Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A20C433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 14:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E4BD83F05;
	Mon, 13 Dec 2021 14:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NguHxajhLTQm; Mon, 13 Dec 2021 14:06:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5294A83EF6;
	Mon, 13 Dec 2021 14:06:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BCC4C001E;
	Mon, 13 Dec 2021 14:06:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2A5C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 14:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AB7483EF0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 14:06:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnFdD-0oT7vs for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 14:06:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4DEF83EE6
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 14:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNR0osBeJ/xnfcB9OdE/defjMSmy/SNoedJzUTAaPUM7u6z3AmcKSBdUl6tlCi2OY9eCxcv7RNNw5L63mDf+Zwop7FKETRi5Zb/4dHKadsxGgTEOXXrzaMi3vNW5uIWkHrJaK4PhBz0Z3wAOWwf/KeYg6rCWadVExI46xkgMc+0WCdKr/a+F1Ief9u4N+DOQ2QkDYgqdWsfrNM7WGz+75uhwBVMXUFTlWyh8TUEbv53Tg+l3oC9/EnSsNRXVlP0XQ+pUz/tQTFhNK55PcorBwxTCanmQqRT9lhxVuZRKbw/jWr+vHSaaWQL3txTJuXM8twuXNrKP9jz9CuOJ6gAw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=proizXdp8kJN21h3QN2ScDg/8vSLfKY+CDRRljhwb5A=;
 b=W+A8usOy3nfr4+ek32xsh2ii4tdyTHNg0P3Utx/3T64x6GxTzafkpejUXQLmZOyDg1m6ZOiccOlU3TI0X5prBXb/usZ+mekH3x2UQ8Af+jcuy2h+K3zRjFgOxL0V/p1pRbvYzlsrWPx076zX5UcoEykFB7kkPMDaZeyBzlp51C1B9UmQF0eqd6t0QP5cUOa0QuH5r/Bl3ixM+dwElUQZDNtvlQz4vG/NA4eofpXVaIySa2QurudnCulcGEC329g45DwKumErldoGoLQguw+EpPco3UX7o+GFuFQl7N36ixO1SWjfCHvwaA7JTRYZbI0Sjxvqy7Nvha0dvbIN2N6t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=proizXdp8kJN21h3QN2ScDg/8vSLfKY+CDRRljhwb5A=;
 b=PHggXsbSfVtiqgKOEV6AtutxsZY8qeSFdiXA+3/oibd+jnNOYfbDC0bJtvcfnVw/RPGjvse8RCr3jG08idOjRm8ajaJKxH7PJbwAE8dF+frWebgt/WVgoOvodbGahohjFPe8/cBxmAKEg+4cC2VCqQpc6poyA3dEGA6Hjg/aYSQ63ZYt96of1c4uyb/+guPLP7hhyZbzq7J3OLru2YjBeuSAZlE9HBvKkWjcjlGy/kST7gVlfBTScHpNmveIsoCU4ce9TIU4FhKG3r/K4/xFrDvN9ybs1N6FPodHS0dYtpQdwWPdtuPUlMFw1CWZjzA7pWxiG1zFQ5U1VAEF6zGRpw==
Received: from BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:06:02 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 13 Dec
 2021 14:06:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 14:06:01 +0000
Date: Mon, 13 Dec 2021 10:05:59 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 25/35] powerpc/pseries/msi: Let core code check for
 contiguous entries
Message-ID: <20211213140559.GA6385@nvidia.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.720998720@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20211210221814.720998720@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0ded4b-8b89-45fe-905f-08d9be41b1ca
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_|BL1PR12MB5063:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077785CCBF529927B384CFBC2749@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJI2TZzOpNBRQYIWGw1WgTy4otpPQndYD+e00WIQIiIC09QJ6PrR+11VINVn2DO7uEPYGpTH1M6j7Lb7SCts6zR0D3E1f6DvK3AHyqBgfcfrdIKFj6RKPFMNgD3sQebyVfT+sKEk+ive1rxkOsgTPThybMq0mx/TlbqBnpTUHbV2nsTuA1ZBhJ5b30ZfNtuagXchhott9xWEyTR+zmWY75LitQLypyAfjwyqMq3lORypBrYtxgCC38qyfLjvY6EenMJB0jvOBxScJWho+PU45YO8bImF+l4Fw81ZfR699tVH+iwQZEpMmgmUH12YdqMBMor0MAigDmpBL2ZTu8YhLVt8PvOtxLJZ7heH6/K2VQH7qjDl+phbJsWC5xRzUhlddJ1LEKMxRF3qs+vv9IbFzmL69ci2nhcmNMW2Pz7OALSInj15DHKbEfeyoCokY4Tgt9j1H8a5bpRO9O+Ir6JC78W5eM/CWRD0OQS9dW6ohXdEGUk0xWQ2kuyR0EaeK1bjDjrENlLqyl0iq8wWKV9kjiubhGBh64CcgpbHJu1Kl97X5bH6hpxp24F0A9k86XdV+dFYDSKDz4VdwirSTMTPZkXEjROqFFvYiU8GoZiqsCpQfBjetfOqIgMH2aHhE/KU+m0ogmEsSnGaRq1kH5ZCKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(38100700002)(83380400001)(186003)(54906003)(6512007)(2616005)(66946007)(4744005)(36756003)(508600001)(6486002)(316002)(86362001)(1076003)(66476007)(2906002)(66556008)(26005)(8936002)(6506007)(7406005)(8676002)(7416002)(6916009)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBnS2Y4ZzczQmpMeGlUaXRzeGxjbGtQUXdMU1NEb3hVNm1JRElhT1lGZWEy?=
 =?utf-8?B?ck4rMFlLRjd2YVRnb3RNeDB0UnY1TmRza2tlM2R1TXVtdnpQSlRpK04zYlVq?=
 =?utf-8?B?S0x3OFlhUkUrV0JzenBVaVprUDBUY0ZYVkNScmc4bUU4ZDUxWkVsTFo4MXh0?=
 =?utf-8?B?ck93RWlhYTMxcXhSQjBOUmNZekRtU0pMeitoY2c2ZXBaaTJOSlA4R0lNNkxU?=
 =?utf-8?B?Nk81VUtxandkQ3FxNUVXYTluY3R0V1hUWFNtbFhIYUc2MGU3c0NXcFh3Ymk0?=
 =?utf-8?B?VUE1NW1kYTgremVlenhtMzY2akY2a1RMd0lsNmZrRWV0SmtHVWl4OE9CUjIv?=
 =?utf-8?B?eEszWHRmbXpVWVFnb0FOMmVlS1BqMXVNK2ltSHpHMkpLWWFCSU5XWENZRkM1?=
 =?utf-8?B?YitQdGNOek5vSUk2Y1ZpcGd1RllyNnpGRERFa3lkQjhqeHRHNTIxdVhMc1lT?=
 =?utf-8?B?QUpZVG9EZGZDU0J5Rm1raW0wUlJ2L3JCNUxRZmJ2YS9FT055VDB2aDVhRDZG?=
 =?utf-8?B?RnhUaG1uSzFTSGcyVzgvUXZNQTd4eVlqQmlxaTlsOFJsc1lZUjBGZDcvSmdS?=
 =?utf-8?B?WnZWamNzN3QvM0JVSFloRUhlbDFBNnk3ZktLd0ZjU1l0WEc2UnU1UmYrNGR3?=
 =?utf-8?B?WXVteHdTMVBHcVFscmpQdG5FSEJRdGVDSkNxNTZtK2hwdmwvYWV6VTM3bnlX?=
 =?utf-8?B?MlNHYnJvUzltWUoxQzZxcGtrN2lDL1B3RSttZjREdStjbHJPWGVoTDJEa1I2?=
 =?utf-8?B?ci9YSW5Zb1Y1NmFwTEtqS3k2VFU5UmdDcWhZTXhhZzV2N29xQlpicm14QlJ5?=
 =?utf-8?B?UDhGRzNlMUxtREx5b1VjMkJkSFNOZzlQZTdSNUVhY2xvNVBqaXpxUFlzN2lO?=
 =?utf-8?B?bDdtN21nTW5XWlV1U2JKeWxuMlAyQllBNnJNeG4vKzVDME0wRElLM3k5Y0xB?=
 =?utf-8?B?ODlQa3VYbHlIVlhmMm5PRVpQd3Q2MEVUbUlVZjVVT29PMFovb3IzdmxETVQx?=
 =?utf-8?B?UlZDZ2VEMmJDakVKWUtWS2xOUWp6aDNwTHJGc09uSE5XekIvdEdHQno0T3Vu?=
 =?utf-8?B?akU2TDRUS2ZmZXNPNW9rYUZrQm1CRHpDYUtydHN4V1h1eXkzWDFzbVZLbGNV?=
 =?utf-8?B?UTI1S0VMNXRmbytXU3ZQTldwQlZ4S0tnRWFWNTlKZkdDUmQ4blRIU05JdkhC?=
 =?utf-8?B?Y0ladHFZeWNZMXdwUnlUZnRnVnQvSmhoNmRNS1JZWURSajQ0WFJyUTZXYXdL?=
 =?utf-8?B?VGtiN1dWY29XQUhMc3pML1p3Q1k1R1JORVVPc3pjTHlrQk4wWkZpYkJSeWJZ?=
 =?utf-8?B?YzBnMXlRaUd0eit3S3o5eGhzS3VZbWdZaDcrOVBGaEhGWlBkVm0rTzB3WjhG?=
 =?utf-8?B?T2h3LzVOUnNrbkZ0YmgwWC9qYUc0Nk01bWJNaFJnQUxVL1M4cWVzakF5VG9l?=
 =?utf-8?B?cHpPWXNEcUdYV3p2WDVyeGY4cXlSZVI2d3VMTktzd0gyY2dvS2NYOWFGSHhi?=
 =?utf-8?B?RnJ5aWptaGRXcXRmTFVpbjVnWFJqYUdoNGdEMWZ6SWxRbWhGODNoSGxsRjN5?=
 =?utf-8?B?Q3dZT1NZalZ4anpVemR3eUpDdWl6UFlvLzlVWXYwM3lQRUNLZGcveVFTL3Vu?=
 =?utf-8?B?WXJUeFFCdWYvTlltak44b2JKTHhtbXdxMk93elIvNDI5cWVOV25pWGdYTEo2?=
 =?utf-8?B?RlNyWXZtRFlERjZCRHo1WXFCYmRidXpkV2pBQ3JSR2hsR0xpV2dDc2ZUQ2Rl?=
 =?utf-8?B?OEQrQldoVGtvWEhJelE2ZDVnY09ITlZxSmRlcXdlQndJbVRiM2RNZGxkeFlQ?=
 =?utf-8?B?UU92NFBBTkI0NjNXVmtmVzZiVFVsbTF5dW9PT1hZK0NZbG1TZW16Y1N2bHNi?=
 =?utf-8?B?dEJzaU5PWFpVOUhqeDRMUjVyZ1A1dHpjODNBZHRkaE5FR0xtMmJsRitOMWJv?=
 =?utf-8?B?U0RyRHA2TC9qUDZpMmJJSmVoSEZHN1ZKMEJlei9nMTA1MjJ4YXlzU0JBajJ0?=
 =?utf-8?B?UWZxaTBZVUw1QnpicEg4WEtDYkZDR0MxSzFybDI4RHVUYUZhQ2pDdU1YZzZT?=
 =?utf-8?B?bTdtSGtybkV4R2UydzZHdEg2N1JxbnlvaEF4WEhtcHF0UGVPUXNMMWMvZ0ln?=
 =?utf-8?Q?mV08=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0ded4b-8b89-45fe-905f-08d9be41b1ca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:06:01.6828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40bJpPqRRPF2i5X+mtFiS5EUePG3uz/PEf5FTcFgzDxKXFnevSYh2HV7vx0N1jKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

T24gRnJpLCBEZWMgMTAsIDIwMjEgYXQgMTE6MTk6MjJQTSArMDEwMCwgVGhvbWFzIEdsZWl4bmVy
IHdyb3RlOgo+IEZyb206IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IAo+
IFNldCB0aGUgZG9tYWluIGluZm8gZmxhZyBhbmQgcmVtb3ZlIHRoZSBjaGVjay4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiBSZXZpZXdl
ZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPiBD
YzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pgo+IENjOiBCZW5qYW1pbiBI
ZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+Cj4gQ2M6ICJDw6lkcmljIExl
IEdvYXRlciIgPGNsZ0BrYW9kLm9yZz4KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmcKPiAKPiAtLS0KPiBWMjogUmVtb3ZlIGl0IGNvbXBsZXRlbHkgLSBDZWRyaWMKPiAtLS0KPiAg
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL21zaS5jIHwgICAzMyArKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
MjUgZGVsZXRpb25zKC0pCgpSZXZpZXdlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlh
LmNvbT4KCkphc29uCiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
