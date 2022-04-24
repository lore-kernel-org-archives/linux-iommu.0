Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC37C433EF
	for <iommu@archiver.kernel.org>; Sun, 24 Apr 2022 03:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AC14416C0;
	Sun, 24 Apr 2022 03:38:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjq7KDfWy3g7; Sun, 24 Apr 2022 03:38:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8F5E41516;
	Sun, 24 Apr 2022 03:37:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81DA6C0039;
	Sun, 24 Apr 2022 03:37:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 558D1C002D
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 03:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C827404A6
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 03:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmgXwZd5qx6S for <iommu@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 03:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D7F7400DD
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 03:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650771477; x=1682307477;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ruj3fvSvjriGcIzjWLywfajfgVHM7ajCOFN9hKFTDNQ=;
 b=L85kbMBZ8bvEm9eHogMDym8iWMEET2o4eyaVvZB+Qq1rikGelBFkCS9A
 7oB3FtbzgzAOWB19+1Gt8hsY8/nSqXCndRtEEe9yZnezT6YOi1gQoT7OG
 M0g0RQkqJBFIvaqP4LrdU9jAAUvbpHsqpwzrwKihpHmZtFnaSBQHMfTGn
 X4LazVFTwtRtzNl+042+SWacodV75DM7Ox0l+mbCb+jWrflGN6ppnHVbA
 06SBWFRRrChJXP5DZAcEfBX7bisfSQPxv5C+MHtxQ7nBw47kLkycqAegi
 Ji23KTITKGo55erhYHAFrM3ZJ8MlO1icobegmQcj1HQx52CLUsXu9X3kV w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262582860"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="262582860"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 20:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="649192494"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 20:37:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 20:37:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 20:37:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 20:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCJJk2u2Dxlcz+0s5RUhj9xqzUs/91PO/B1CIkSR8N51hspXdjStciJd79ilsmLwUp9iQKL3niaNGpMKKHXSORn4uAaaiChW+7gNMP03PrDcdUxwbouN2EHS1w1MV1OoPCDKBTcBhNeZSwj275gw6PJcNquupyRBZQWlHNQFPmNbTfg0Sq0NrM/0Wr4jIiDBOuPohcRcMlWP+eodeZh/CdvegQpN6Q6J3FhCfNYsfBwZRthaIeiIDnB21cTHndvoRVYuFZr1QElxSkaYD0KyYpImB/sFqa9Mq/sRHSJSvoWrkxfLuY/JSinzkBOU4nzwhBIsgvfSMJ4RJCoqT+tukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ruj3fvSvjriGcIzjWLywfajfgVHM7ajCOFN9hKFTDNQ=;
 b=SCe2xWFOPoh4+wvHYJBnikB6+O0XbZj0uWes0Tr3RH2BwX2mjIQX9Piy86dScHFc4mlzMIdw82Mvyg698GCAX18f/QkhOdlz16Q1+XYZkicUE7vYXsby29Y9bfwB/SMxj3LqhaKLszMmJ1V6dHawF+5nZMd2zrZPkGBRxO2KiPuciekj1atYd/1/uTy4IERT6Hh1OZ91wRB/P9GnNN90vob+uORmphRP4omzBs71aaq8NnRWGI2piqB5L98cHnNDVBHkBkcPeDkivwMH1hGzpvuG5xBIPISKrz2FRlq0dxkgF9BqvxqfjZ549zXCSx3OH+PyD7CO0AE/WSfyD0iISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5652.namprd11.prod.outlook.com (2603:10b6:5:35e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 03:37:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 03:37:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Index: AQHYVXRiJweT3/DMakGQhv0qzMieEqz7Od6wgACuJICAAoO6kA==
Date: Sun, 24 Apr 2022 03:37:48 +0000
Message-ID: <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
In-Reply-To: <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277e81e8-db98-4f7c-fd2b-08da25a3cd85
x-ms-traffictypediagnostic: CO6PR11MB5652:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR11MB5652FEACFC8DD220FF654D208CF99@CO6PR11MB5652.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wd5QIvh7Rk+ZlYoRSAOoke26MUUSel4nHH9UaA3vG6oN+NMF8D4Im/d90mVi5g44O+PuqEsQSHKDtrSIii0mRdZT4c0O2RQJr/0uaey5qfpUw+UXo72J0v8HyxD8Xfn3S7qY/2UHSNAKb6l7c+YEf16bapZGg6EC0Awz5QqaesqbQNBRF/Rm+eMBwHihIuct7IKT2C0inA1iAEXjZOjrLzu03tyMJYRMtMAXLcdc67Ftc5/qPYgagOpBbtUwMEm1DbECUmhyYR24g82Uvb5YGecyZa2c3fTd+BrB6nyJrAURfMKgJJYT9Y/o/183U28ErXYKR4hBekWIRelexkW5HZ0SnekjfIrIBOkzfs77RjWZySnRasvU/GvmmkORErcI78lqL5iF06Nk0/3g+EgyZSioGtWfeIxNA9phWS7WZNL3EfmND7Bcwgz649vSTj0aEqI81xaI7IKIWiCuLFNFm4b2X2uHv0RAfVleDstVf/Ss64svKgs32UCYCOI+ub22nMxxd2FLa7IVsemHFNLs9o0gQ1d0gJZCqvPPhtT1iVdwPTa4KxBLf4RH5JqHp3W+jv8VsqbGUUPUnx10xJX0y41wQ+yt2ijPhUVM+8Sk2aljLuAu4yLSSuvYMZ5KiBLDtgf2l00SbrVWHKZUdmWDpEgxnQ7BJZ82WJQ26NWKWfaQxmbKLdbyhixzs6G7DKhno7zNyL6v1ZhEddX3i57saSKT1rLuzIKfXZQB0B9AN8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(52536014)(38070700005)(83380400001)(76116006)(122000001)(55016003)(82960400001)(4326008)(8676002)(5660300002)(186003)(64756008)(66946007)(8936002)(66556008)(66446008)(26005)(66476007)(6636002)(7696005)(316002)(54906003)(110136005)(9686003)(53546011)(2906002)(33656002)(508600001)(6506007)(71200400001)(38100700002)(309714004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpHd0xENWlDVU1hdFZpWFhYSTNjbXFtaXNLVi90aUpLQ2drNFp1K3V2RnpH?=
 =?utf-8?B?V1o1WjhyZVFIeDViVTNzTWt2VTNhM3loR04yOVdQNERvenlwRlVCZGkyK1d1?=
 =?utf-8?B?RzZUeDNCYlZUYkQxWSt3UldvVGpwcUVubVVjekdNNVQrN1JpSWx0N1lmSEJ5?=
 =?utf-8?B?ZXU2QVVqZ0h4ZXArOTJVdmZmWkJmQko2SWpFOWRYZks0dUR2M1oxSGhtbFZS?=
 =?utf-8?B?Vy9uY3F6WUNudHl6dmVkeFRxcysvVFEvd2NqUFZCTFY3WU95NjdEZmRyZmhD?=
 =?utf-8?B?Ny92ZzB1em9zTHQ2RkZzeENmdzhHR3VXaTRtdDhMbnZQMVdxY3FySVhFWFhI?=
 =?utf-8?B?UkNGQ1BpbHcwcHVlTk90bjJ5dllGYm9sZy9RYS91V1NKaHNsc0gwOUNCRVox?=
 =?utf-8?B?clJuZGtEZDVxaFZWUlVUTWFkWTRVVEpKVFNVaVlia1kwdmRpUmNpbEFFRmsx?=
 =?utf-8?B?WTNzMlpTZjZRV1RqYzFnY1ZBaGkwRm9jK2hDL1NwUUhER3BQQUlFQjVLZGU0?=
 =?utf-8?B?L2dYWnRVWHp6SWllV081VE9UT0d6VTBuNTIyTmdjc2hkWTBHWDJYVDFiamRj?=
 =?utf-8?B?aDRObUloK29BRDBxVVkrUjFGZCt1UW9LdndkanJvakh6RGFoUzVOeDRpQjhr?=
 =?utf-8?B?TC9uWnl5MWVqdFJ3M3pabnVCNUtaNlRQTnZRZWdqbEZPcGNSRXlkelFkSUFk?=
 =?utf-8?B?RWtmd0Z2TWZEZC8xbWI2YmQ5T2RVcnprNVhXbUNockRTOU1LY1pBQ09XV2Iy?=
 =?utf-8?B?NWtKTjkwSUpuYjA0MW5EUEJRdzZhaGFTSHFHRjlXUStXOW9rVklDcms3T2c3?=
 =?utf-8?B?YmxhU2VpaXNuYURxVFY4VHRMMk1ocENCVC9xd1plcDRKYTZFNDVldnROM0xC?=
 =?utf-8?B?eWQyZlBnWFJjdjhxSWREaHl6MGdVOXJhMkJyU0wwMGFJL0JCVUVPQ01Rck5z?=
 =?utf-8?B?MGJiakJIdW9UdUFaTm1EdzM0M2FNbVpZaTdNM2NhSWd3NlR6eUlLM28wK3Ja?=
 =?utf-8?B?alVucWUzNmNZQ0VkOExMNm9lL2QrU2xLeEkxaTJxVnhZellJYVhwWHphT1Y4?=
 =?utf-8?B?cmFuTm5sbW1DbnRHTDEwV3Z1RTRtNFQ3bE9GYVpNSlFsL2F0aEVwMWlyTGFR?=
 =?utf-8?B?eXIwWFp5cE43LzJQOHlzQ0dadTNCTGRnZ24wUTBrTFhiWW9haGFFc1AwQ2pt?=
 =?utf-8?B?SEdoZXhMWjZiTndiQnFOTkhkdElZUDhiQmRTUFB2UThzanNzcU8zWHU5Wjd1?=
 =?utf-8?B?YldHcWRlTjNGN1ZlSHZVaG1JeEY1NFNoeUVESmNEVzYweVhQY3N3U20zcmN0?=
 =?utf-8?B?K0cvTG9BRlhQdmFZVWxWRnNtQis5N1ppR3Z1Y0czeDhEZ3gzelJzM0FHYjdJ?=
 =?utf-8?B?TkF3ZlY2RmF0SVFCL1FJblZBN2dzdlNBQ3EzRjRISUlIekljTWtMaHA2WVlx?=
 =?utf-8?B?WjZtQXVSb3puRXJ3R3l4cjVrdS8zNktHMDZCWTl1Qzh5OWFOcTJCTWgvWXZt?=
 =?utf-8?B?NFRUZWdWRU12eWw2RnkxbHpiT3doQW5qSlovVXZ1OWV1TTA4UVB3U1hlZEJp?=
 =?utf-8?B?R21wVHZIL2F2Z0FZRlNRendNeUxtTERRSGNWNG9kbkJaK0lENVgwT3ZLL3ZT?=
 =?utf-8?B?L2tqVkExaURVbmZEOHBJY1ZkeWZrNDVrNFh6WTdhQm5QR1VvL0tORmZneUxO?=
 =?utf-8?B?VHpUMjNSZjZ3bVZYcUVKQkNBT3pZRm0zcS9IeDFoM2YweFpObWdzY3BOTmJr?=
 =?utf-8?B?TXpXSjh0aUNONEk2UHpNYXJlMDRFQVN0elpJM21KZ0IycTNoSHNLdlJ6NlhX?=
 =?utf-8?B?c1NremNRVDdiM2ZMZE96THVwYUtNRmFtL1ozY1NVN3lHR1VrTEpjUlRucDlX?=
 =?utf-8?B?RVUzVGxJUWZrSmNzNXZUMXZKVUE1SGtUQW1kTUVCVHh2OVh5dVU0SjRYQVk4?=
 =?utf-8?B?WDZ1emJGSjNtakZLY3J1QjgvYm9GTkVGUGJyM3pPbGkzdVJOUEhzbTdtZUpF?=
 =?utf-8?B?YlplSmN4U3RrQVptSzhoRUt2UWNkWERHSzM3bEdGQ0JpZmYrcnIwVEprWlFI?=
 =?utf-8?B?M0pTWTZDUU10VXQ0Z2UzVC84NDRvVmVWcGJTMXk1VFZFZ1BTK0dseGhJVXJm?=
 =?utf-8?B?TjkwRWw2N1VqODg4b3RJbE80SG5GNXB5RzJ1MnBaUUNuWWZUYmxwUWhGV0Vp?=
 =?utf-8?B?SmQ4dTFUdjkrUWdPSDBpY1RHYTJVSG92aXRaL1R0N2ZqNWl6VGZyOHNBRlE4?=
 =?utf-8?B?eVAvZTJnVlp3NGc3MmFKTVZNN3JOUDZqb3h0RVdERXArL28xSkd1ZFFreHJF?=
 =?utf-8?B?dWZySUZDOEVGU3lYOU4wYlFqSFhONlBkclY3WS9lTlN4NDEvcUZzdz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e81e8-db98-4f7c-fd2b-08da25a3cd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 03:37:48.4041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMhbpkngVy73d9xd22g8ovM8ceGd8sqErZRyImn6U4q11G5GRmaTGEZckYfZ+mqZtyeiHcMSywYYM/P2pKXsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5652
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, April 22, 2022 9:04 PM
> 
> On 2022/4/22 10:47, Tian, Kevin wrote:
> >> From: Lu Baolu
> >> Sent: Thursday, April 21, 2022 7:36 PM
> >>
> >> The latest VT-d specification states that the PGSNP field in the pasid
> >> table entry should be treated as Reserved(0) for implementations not
> >> supporting Snoop Control (SC=0 in the Extended Capability Register).
> >> This adds a check before setting the field.
> >>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel/pasid.c | 13 ++++++++++---
> >>   1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> >> index f8d215d85695..5cb2daa2b8cb 100644
> >> --- a/drivers/iommu/intel/pasid.c
> >> +++ b/drivers/iommu/intel/pasid.c
> >> @@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct
> intel_iommu
> >> *iommu,
> >>   		}
> >>   	}
> >>
> >> -	if (flags & PASID_FLAG_PAGE_SNOOP)
> >> -		pasid_set_pgsnp(pte);
> >> +	if (flags & PASID_FLAG_PAGE_SNOOP) {
> >> +		if (ecap_sc_support(iommu->ecap)) {
> >> +			pasid_set_pgsnp(pte);
> >> +		} else {
> >> +			pasid_clear_entry(pte);
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >>
> >>   	pasid_set_domain_id(pte, did);
> >>   	pasid_set_address_width(pte, iommu->agaw);
> >> @@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct
> >> intel_iommu *iommu,
> >>   	pasid_set_fault_enable(pte);
> >>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> >>
> >> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
> >> +	if (ecap_sc_support(iommu->ecap) &&
> >> +	    domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
> >>   		pasid_set_pgsnp(pte);
> >>
> > This should be rebased on top of Jason's enforce coherency series
> > instead of blindly setting it. No matter whether it's legacy mode
> > where we set SNP in PTE or scalable mode where we set PGSNP
> > in PASID entry for entire page table, the trigger point should be
> > same i.e. when someone calls enforce_cache_coherency().
> 
> With Jason's enforce coherency series merged, we even don't need to set
> PGSNP bit of a pasid entry for second level translation. 2nd level
> always supports SNP in PTEs, so set PGSNP in pasid table entry is
> unnecessary.
> 

Yes, this sounds correct for 2nd-level.

but setting PGSNP of 1st level translation is also relevant to that
change when talking about enforcing coherency in the guest. In
this case PASID_FLAG_PAGE_SNOOP should be set also after
enforce_cache_coherency() is called.

Currently it's always set for unmanaged domain in
domain_setup_first_level():

	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
		flags |= PASID_FLAG_PAGE_SNOOP;

Suppose we need a separate interface to update PGSNP after pasid
entry is set up.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
