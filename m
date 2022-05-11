Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BACC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 12:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83D92418FA;
	Wed, 11 May 2022 12:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BxzlMWwG7oA; Wed, 11 May 2022 12:55:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7E6E418F3;
	Wed, 11 May 2022 12:55:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B77ACC0039;
	Wed, 11 May 2022 12:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC94C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B19CA403CA
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnI8-lddfS-C for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1161400F1
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652273725; x=1683809725;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4SCq5jNODnNvFlP+UNpEZgdaRmoOmAVIL8lsGwva/Jw=;
 b=GnW0zCO4cdNS0QUncXjqGKjdMYci9ahkHEh3rxCigJZiOTODH5k0/Khy
 v0Irz1vD3V+aBr0nBtTK02Bhmk1ERLmOlHHc1CfVrjcOT3moRlZ1D/fkT
 lsCPwrr9A7hAvqOe1eUxTRgMPmNXiqb2ccZX7WYqtU6eReXmQaOt4qjWA
 +UbEU5EwJK2xYlz/fsGhfDHMBDUMzNfCjKfiW04gqpTb3UHYvu2THSCja
 nw7aRrQzZjeKOQtGNXLpEMWkZmvx/ExTkdJLk8dbgPZSXC3bpLOpG2O58
 i6AcXw3P1AtcyvtE+JqCEWKkbhgDnKn61+VCR3UHH22fkKZDeE+yXT6Oa Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267275339"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="267275339"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 05:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="814464001"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP; 11 May 2022 05:55:23 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 05:55:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 05:55:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 05:55:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 05:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsR1EmD50im+rkalhrjrTp1PMMt60BFqf3rYh06eGB1qH22DJAYny+sWVbt4mW+UaFF5hl18oPaA+dHtS5SZe8tmgWwUJv7E22O0OagRFOPd3zziCVYEI0sS2vppxAETB1Lp+WHHR93bB/wbiLvIFbICEV751WOhecAZJhtL+0cSzFJeMRa1sCO+lZYYAz0SFlcAylFoni0wvChBpLTgr6MXjfiW0esD4NChspa0P//XbnkFDhsHGHJFS3rfPEnvXeF/pE1if3D3sI5gr1uJ3dHsLbaAPA9hwWbAuXrrtZjjhhIVNdamQTR5PHGlgVLTy6Lm/GmUcvPsgMmio9W+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fC/JsqF1D+IlSVy4p7tM2Q4orFA3fEzrgLugcKTnzU=;
 b=DmkdJrI+LmU+7gDKdLjINK5/l/c2Z8iz4kO8lqbP/rbuotuq4b2zRb+wRCfk/DrLGFgDMjGAc9S5ID7+7UQaUhzYHp5RoHRfEHrsBw0/yxBhurWMPhIA74mBW8ZTcgjCUy89mFrMVop6sSe1ejiChHNn6vnPvlAsAsipwX1Z68O2qgTllXAFPBgJs+Z93v+dhwlXEdKG5ZMSxzaF51Y2AgL8wsEmwVcnbevPXJsvsLihYZxG6aHouRXwAozje7+mdnZ3VmtxtfKVyykkTVaTsXRQxFBQNnn8sn20AhOZTRyruElCl52U1bwz+2SWo0UvVXWSLuRU3idD0vpPSqvbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by DM6PR11MB3337.namprd11.prod.outlook.com (2603:10b6:5:a::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 12:55:18 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::21cf:c26f:8d40:6b5f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::21cf:c26f:8d40:6b5f%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:55:18 +0000
Message-ID: <301d9b4f-3793-6b7e-76bd-7b1b359e94d8@intel.com>
Date: Wed, 11 May 2022 20:54:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 10/12] iommufd: Add kAPI toward external drivers
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <10-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <10-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35f10117-9718-416a-c6e2-08da334d7fe4
X-MS-TrafficTypeDiagnostic: DM6PR11MB3337:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB33370D54308AFEA5E2D82EE8C3C89@DM6PR11MB3337.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JgrL8ciWnVnGxo9RXQnG9i1Hf1IaASlPm/e5pCcp/xwN9CAnL7UiNxGa7SJdxwKaF+d7cyjvwSKkmtcg0JLBr2de5SlDCeBBN2UMiZmSHGCYzksW5eEATcwgIAiPPWYpzpYLbfxdC+H9g1Cb03HMh2q1L5fe4F2nBXLNlIv6a1mZyEDGnRzCW8GBixnQv8Ny/8xZNY07Cm/WVepwjtC597yvSndUYEedUysBRRqFdzhlBLRfBKiXGpbZbbqNdCjUTOE2Xw6LCQzIdR2SnjEZYWWC1ZZA/YJwLaHV/+deoor3hInpEl06Gb/djk4Q7BLPaEvrPYub8mT5Pt58hjMqOzLE/zGK4sZThxsjIZV7HeXQC4p/r3nm/8cS9Wk/71mwr9fCn7UvtiWGF6DcEnuYw7gR1VIc4yFkSJdVYvqfue1wnnUz9391Y5ayPKisiC5xb9TbtJZFOyx2MhPAIZWmZUxVMJeDAE6dQYvhf7aECgXOzYUklWmDnMvT52F2RPecIordmJMYtNwFrn66ZHgytYzDIL0g+yYpqreeIrmI4yWtZLWDHgSPpZSD5aE536W3yW3gdEPpYXc3ufYjhjnp1aN61H9SfcOlq3FkS0ApPwv/qjGMVDA4qtQ8VO86qCfgalC4CtmDKETapIKPaHcIy3XihPY08uD5Px3zaLQxyaaYBmFxwtGG7XuuEhnvyNSzb53H9SACCl1HENgs2TK85bXIyGIVnmJSniHjgP5BIgC64+rFWr2BuOB2sgZmxog
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(36756003)(8936002)(83380400001)(8676002)(508600001)(4326008)(53546011)(31686004)(66476007)(66556008)(2906002)(66946007)(6916009)(54906003)(6666004)(82960400001)(86362001)(31696002)(316002)(2616005)(6506007)(38100700002)(186003)(5660300002)(7416002)(6486002)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enB2RzhkOXRCZmM4bVljdXZMMFhyOEpWekVEUng1TXM5YnM5SVdQUU90ZEpS?=
 =?utf-8?B?c0d6dGcyaDFhZXg4cnZEYllIamZzdC85VkIzQzFNUUlQMXEyTVc0cStWTFdj?=
 =?utf-8?B?TWRydWkyb2R2aFh5cG91SG1XNDR6RStaeHcxSDRueDFUaVc5c3hKUXBna01D?=
 =?utf-8?B?RzJzK1M1MHVVdHQyTThBSGwwZCtaVzFBQXZmR0wrTDdMdDhjZG9SWHlhKzhr?=
 =?utf-8?B?NWQzN3habXgxWGdua3BIb2hYL0wyV1JsZUdrM25yd1Y2UlpNVXdwYWJwcFRr?=
 =?utf-8?B?c1dMVFM1YnNVUjNORGc1K1Z1QjYyMTR2TlE2VTU0QXdIOUFDMlNTUlhHSmUw?=
 =?utf-8?B?UFVTQ0JJc2piQWp2L24zUWExeG1Bb0s2Q3Nla2ZaMGw3SlpubnZyak5tMkxx?=
 =?utf-8?B?SUVKUWdYb2o4UVR0SkU4YTgrYzdwbDNJTWg2K1BKQmoxN1dERzNoVURaZFEw?=
 =?utf-8?B?OWpHS0l6eHV5eTRQSDkxZmhaZHA0QzErbVYxbEJwSTR0T290cFVaaTZvdjBS?=
 =?utf-8?B?NFliOTd0TXpmOUJCdGNid004SVF3NHgxYkEyS0hVV0lpblFSeXJLbjAybjBU?=
 =?utf-8?B?RTQ2QWlISGhOeUt3MmowaDFrc3YxdWxsMHJZWnNCVHBBZ3Y0NnNhUGJkdnps?=
 =?utf-8?B?SEN4YjVCallHcVhUazQ2MW53S0YraWhoVXlxSk9uZGlmSDFVVTJIRVVmb3lk?=
 =?utf-8?B?SDQwanAzL01jN0JlQUtxWExjNXBKeHBMWmNyVnFlcHdHaCthdVkrZ1EzQUdn?=
 =?utf-8?B?bUJ0cFhhUWs2d1kzNHozMjZtVHBhcldQSDB5b25Nd08vRHRTb0t2MjVLd3ZX?=
 =?utf-8?B?Vm5nNmVoeGhrczYxcnZ1K3J0Q0hEYWVNektPVkgyTmswT2xaQ3pYWThWVjdw?=
 =?utf-8?B?MkJxR0c2d0dscEhmQmJxQ0lMay84T0Z6NlJpQXFqcWdWRmt6a0xaYStDYjdu?=
 =?utf-8?B?bTBidWRXYUJ5RTNqcWx6WmY4TG1sc3h4Q1F2M3FrbG10WXdMYStqV2FxeWt0?=
 =?utf-8?B?MEcxbUFQWnE1dGFiNm9IWkdhYTVhRk5VSXEyQys2di9xNGVud0JSSXYzdFNP?=
 =?utf-8?B?aFVVbHFaQUQ3NUlHS01FOGpCTnBoRlRJdEhrZGhqazR0YUdRbUFrcnJOZEZ0?=
 =?utf-8?B?S0dWZ01xOWpUd1cxN2NkaTFUMndWT1lESlZUUGd1enhRWkorY0gzYjhubHlH?=
 =?utf-8?B?RmFGMXQySEdmQ0lrK2NjYjRja09xRXNveDBUUEhUN2VQS05BZTZKVGxyOUtU?=
 =?utf-8?B?cCtoYVJCK1N4QTY3bmlFKytwUWdDTHBnNjdjaGVLU2VVbEZrM0hqbXg5ZWFC?=
 =?utf-8?B?emdUM28zWEhmSDZ6UUZGd1JhQitiK0FOZFZDWUJKdksxVVpDZ2Y3RVkrc2Fp?=
 =?utf-8?B?TG1Vc2ZWeGRHanF2MDFjWXV3bTVCOGVEZkZuenJVcnYwYVBrOXFZenV2TFli?=
 =?utf-8?B?VTFlWXlGVTRJdGx4SzM5YlVNQTByaXk5dVZsMXhvZS94NkNsZ0R0KzkzR0RW?=
 =?utf-8?B?UnFkUVdyS3VhdXhnMU5ENzlDMVhxYTdBM0JPaE5HL3o5ZHRWaDlPVTZic2Zp?=
 =?utf-8?B?R3VsWE96SVE4VmhhMVVXejlIdVZQYVpuQzlEdGx5Mm55RVFFSXJaakNRMGNx?=
 =?utf-8?B?OWxpVVFjS0dpTjc3aWI0SGVPMXI2NktXY1NhMERMTDZlc1F0VWlIWWRzcm1x?=
 =?utf-8?B?RmV3ZmN4T2ZoVDNaOTl6RXg4ZUhnQkU2aDU3NzhGZmxjQ0srWUc0MFVnNE01?=
 =?utf-8?B?WkhpbDZob24vWVRXd3hJUFFPK3l6eWhRZERYR1lxT3ZSTXBPbGVaa3ROZmw5?=
 =?utf-8?B?Z1BEbEdBcXQxSE5NcSt3ZFJ0R1h6ckVjQ0hldzBObWtsSDM2VWJiNFBMb29h?=
 =?utf-8?B?eVE0MU1kR01GYmV6a1FUMUplWjJVR3lUL2dpRVZnK2pETEhHWnY4eWlhWVVG?=
 =?utf-8?B?dFUrSUVVMDUrTnlFc29uYVl1VHdFY2tySlgzc0RaRG8xWE1VN3k2T1UvVjh4?=
 =?utf-8?B?cUljNzB3QTBlVVBLcnRFVzNkNURqcG8yd2pOYUlOQU9XZThQcDRiTGZueFlM?=
 =?utf-8?B?MHVsY21LRTVDTzlXVkZLTy9Ya3kyalhRWjlEdTVXUGlLeUhXYURXRXczSGVt?=
 =?utf-8?B?cjRnQml6a01HY1hYUTVoc1V5MmQvQ0piZTRwUmU1bjFna05wUFpLdW9KZzRV?=
 =?utf-8?B?YjBqd00xZm5rVXZUQWhWSzIyNGZxYjA3bnJ4eHpITTZPcHd6NWx1TmZ0Umoz?=
 =?utf-8?B?SUNBTWJNS2syL0xUNHpvd3RMdHVMMXJSdHZTWTJPMU1YNDhNdEhndEU5Mlox?=
 =?utf-8?B?anorY0JuTk5zdnpMZ0dEQnVqRlRCamU0d2s2YTVSd0xvN3kyM3FqaVJqRnh3?=
 =?utf-8?Q?emc+pUe3YqiQ7fw8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f10117-9718-416a-c6e2-08da334d7fe4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:55:18.1293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omZAuXkhM6Za1tcKLc2wT/8eT3kY/TJpxCUIg9KabIHe1X18QyoYCgwxz2iXjHVZuxzb3dWSlBOX6QiQhzBNow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3337
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 2022/3/19 01:27, Jason Gunthorpe wrote:

> +
> +/**
> + * iommufd_device_attach - Connect a device to an iommu_domain
> + * @idev: device to attach
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
> + * @flags: Optional flags
> + *
> + * This connects the device to an iommu_domain, either automatically or manually
> + * selected. Once this completes the device could do DMA.
> + *
> + * The caller should return the resulting pt_id back to userspace.
> + * This function is undone by calling iommufd_device_detach().
> + */
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
> +			  unsigned int flags)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	refcount_inc(&idev->obj.users);
> +
> +	hwpt = iommufd_hw_pagetable_from_id(idev->ictx, *pt_id, idev->dev);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(hwpt);
> +		goto out_users;
> +	}
> +
> +	mutex_lock(&hwpt->devices_lock);
> +	/* FIXME: Use a device-centric iommu api. For now check if the
> +	 * hw_pagetable already has a device of the same group joined to tell if
> +	 * we are the first and need to attach the group. */
> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		phys_addr_t sw_msi_start = 0;
> +
> +		rc = iommu_attach_group(hwpt->domain, idev->group);
> +		if (rc)
> +			goto out_unlock;
> +
> +		/*
> +		 * hwpt is now the exclusive owner of the group so this is the
> +		 * first time enforce is called for this group.
> +		 */
> +		rc = iopt_table_enforce_group_resv_regions(
> +			&hwpt->ioas->iopt, idev->group, &sw_msi_start);
> +		if (rc)
> +			goto out_detach;
> +		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start, flags);
> +		if (rc)
> +			goto out_iova;
> +	}
> +
> +	idev->hwpt = hwpt;

could the below list_empty check be moved to the above "if branch"? If
above "if branch" is false, that means there is already group attached with
the hwpt->domain. So the hwpt->devices should be non-empty. Only if the 
above "if branch" is true, should the hwpt->devices possible to be empty.
So moving it into above "if branch" may be better?

> +	if (list_empty(&hwpt->devices)) {
> +		rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> +		if (rc)
> +			goto out_iova;
> +	}
> +	list_add(&idev->devices_item, &hwpt->devices);
> +	mutex_unlock(&hwpt->devices_lock);
> +
> +	*pt_id = idev->hwpt->obj.id;
> +	return 0;
> +
> +out_iova:
> +	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->group);
> +out_detach:
> +	iommu_detach_group(hwpt->domain, idev->group);
> +out_unlock:
> +	mutex_unlock(&hwpt->devices_lock);
> +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> +out_users:
> +	refcount_dec(&idev->obj.users);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(iommufd_device_attach);

-- 
Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
