Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C2AC433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 06:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0B4040510;
	Thu,  2 Jun 2022 06:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OipqFvbkKlp; Thu,  2 Jun 2022 06:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F1BA40025;
	Thu,  2 Jun 2022 06:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53BC2C0032;
	Thu,  2 Jun 2022 06:29:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62F1C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EEC5813BE
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YqmV-aIZ4Qnz for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 06:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9A6B813B7
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654151386; x=1685687386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CACt+NqSvTuS5kcLawOZGr1REKwBP421MpXryJmzQl4=;
 b=HaVQGTggQcLEK/sBEs1ig3NivBXOl09WaAMoSYsIJu5xJcfDGKP1l6y2
 meLnAf2poYmKiCq/WvrpKjoAs0mt3HVhsx9CzKeHa0443WeEVORI/dYyz
 TTUQLPrfwTNamZ9tYwEmswN7jeUzIzrEPy+lYxLBE1zleHMCKe3fqYk2M
 3MoIc03UJ3rKaSZqtegKRRPfSCoA8LwCzjw92Ym+HbeBG84Sgyje8hfbG
 obszGDENwkYWGydGw3nNqleFLqo6Oef2dxo5MHOea9T1G7Xqk2DeDJTGn
 7K99YHdZ7hFJ6VnLW4tMQOSzSNZtiLuc/Cz0v/YXMdffMbkhgkCGerqLS g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275848599"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; d="scan'208";a="275848599"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 23:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; d="scan'208";a="581938095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2022 23:29:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 23:29:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbnfGKlAXQZf9rJRs1RcXhDbjOAa/TW2oqy0+S5uiWq0thNVFOH2XXSjfmH0KMtwT2HI5OhmMRvN1aj9Cto8wkiXgnyAtfHnLQStlKPzXJpPFEkqgaTk3govDLEc+A6sg95Y2GulWj2OeIcp7/hv3aEhdGLU+6vJVO2zPjXq+yPwp2u4xmT9m53y+aNwzcwChlI6UfXncgHt80pLvsVbZwTLPRCqB0nyUu5WcAA0BpgghUcbtihyV1HPzyaTRfcOofU5fsNXGdiRnem4VWPmgeq4PCPR7syO+NWxFAONqOMPp8qywoFpXOtiGIJHXdZm/1CVbaW8mpuEgcGGYgC90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CACt+NqSvTuS5kcLawOZGr1REKwBP421MpXryJmzQl4=;
 b=b+rMJ+x5+UXwXZW0hs4s5oF1dzct5Jm9GF3wDAG550cT2gBVyQfcpgq/Jk3QZ8pymDzajtxyyjrZWp1zMyTSmfR+MjtbLLGfoo+p6cfEBtaUES80Q+34uHoizysMLpc0OrJHKpKQS+an+h8bpQutN/s5KufvwOE8r3c7Q3UF+4Klaxy2hlYEUphuEKWp2JKr8n4nDEmjxsw+SR0Dkqhyk7LzhiyhXxAizsawwZkqXsQbA378KbrGYlgsYLwlDyx/BjtkpVsecCJhBNchQ15MhVeCyDqQTkoQ1q69zsepl9/9PXFONRzWSXNKOVp8il2QqUcz8mK5qfA/87DOFQR7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR11MB1341.namprd11.prod.outlook.com (2603:10b6:300:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:29:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 06:29:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Topic: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Index: AQHYcZPVYxDxhgtiEEikhmCfUbpnPa06TxHggAAb8QCAAT3ngA==
Date: Thu, 2 Jun 2022 06:29:42 +0000
Message-ID: <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
In-Reply-To: <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf53e4c4-d937-41f9-aa99-08da44614738
x-ms-traffictypediagnostic: MWHPR11MB1341:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB134155E18CF8E6297ED7D55A8CDE9@MWHPR11MB1341.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1JAzDvkba6HdRnGDqblKxd/I/Ova29WdJ2+XVKe8Xz7h3xIVo5hBw6VMh9fHqWc2ouaq5BncAsXhXpm3dhmCokHhCS1wOjNxWlcAV1KOXl4Pynzvb1BcHN8yI6cAWKs71Td4O4QeAmRyE/uOtFwP/mVkqPXBj3PwzN4z5QmbSRSeaODFVY5qIzxUJtuhoXbfnGrxyA1J4NY7SSWs86tcIXzAy0cmjlDiyWeU1cto72ZdWI43tbTT8HFaT2c2y34pdgUGdnvosd+0JtMd+bGk/LGBnf6YsRfT7B03d61DcR3lRHLYOwOnRYSXv8gXHgDEaJ45r6+E1b6r+tPhZHyAd0IWOK5qDT++L6RXyOW6/tay7VENUEYXRE7H78eWCpAn5px/rBi3jUacXMbRq85Oazj2r/UPtX6xo7uHu2LAyEdrZ5otrdmBeF3qN/aoXK6OYo+Vtiv3W6JymPrSNK+eBTS7RCQAV5iGrL2yXATUDNRwje9pVjiW+cOy/VS9I3HPc/nl5Y2mqWL6OxpB6LDUVcde90qHR8LPHAogUyjNWfl8jywau1ZomqKf/98ZOxA3i5I3gQ5LWbmzptU+IIaDBeXsDN7UXorgWmNHPNf0ICkRNmHMkakJoc99bJA5E6MNl7pkE9jzeuPc8J22+wpESmU0PfrJuD+Y3VYUXkCFUWgB/DrZMNLa5bPHYw99tbyHOiQqgV7FbhKKwkK7XJgMzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(9686003)(38070700005)(76116006)(53546011)(82960400001)(54906003)(38100700002)(33656002)(66476007)(110136005)(6506007)(186003)(122000001)(316002)(64756008)(66556008)(4326008)(66446008)(8676002)(7696005)(5660300002)(2906002)(86362001)(66946007)(83380400001)(508600001)(52536014)(55016003)(26005)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlNRWUt3SGI2YW8yeGd6cTZ1bWgraTJVcGFQY0sveXEveURBd3UvcHAwRFdm?=
 =?utf-8?B?bzRkRkZCVGFqYXROdS9wdzduMkQxU3cyZGU5Ukp6ay91NTlkQVBGS3ZYRm0x?=
 =?utf-8?B?OFU0ZkMwV3dFd21mZFR1anhNQTNJamEwOE1iL2VtM2N0d1lLZWRha21kK1FW?=
 =?utf-8?B?bXpXczdOUGFyZGhDTDIwdzEzS25pbmgvSjRCNnVkVGdsT3ZsdUdXVUZFdk1I?=
 =?utf-8?B?VDNFaG5HdEt2cENuTU5jSjhLM0NlWHo5STRGcFRNalVZSXVwVXhnZm5uM0ZE?=
 =?utf-8?B?ZjBMR3RONnU2QUR2M3F3L3ZzQ3V1ajRQd3VWSzl5cjFKNXZxYkdZYkFJRDcv?=
 =?utf-8?B?RS9BSmxTd0twYnNOdVJ6L002MUY2MkhLWTJyM1VINHNudXd4am1NV1h2Vit6?=
 =?utf-8?B?eHR5S2dDVjJSTUtnWnExcXlPR3RDb2hXMGR2bXZPU1R0RVBBbnppcEs2dW03?=
 =?utf-8?B?QjE5anBhOFJ0WnRUYW1YYzJHbFFKOEQ5VW5TSjhkVlM3cUhDTWNEdHpSV1JL?=
 =?utf-8?B?REt1ZzQwaCtoWksyYUpSQ2lSZUxBUk5lTW1IMkZuRHBqZ2ZqSldLWmE4aWNa?=
 =?utf-8?B?dEdKR014VEVtcFMrL05xZVdnbUJBMmNlUWhTL3J4UkhFTWlhUlZ4U090cFhJ?=
 =?utf-8?B?UnN6UFFlNCt4VzBjR3BVV1VxSW5KOGo1NEwxVkg4N1dyV1liVnhVZzdIL3hp?=
 =?utf-8?B?ajU1UlRzN0tQajRHcWJZODlzcjMweWFvWkVaYWtXT0RReVNTVmx2TGRCRXFu?=
 =?utf-8?B?QzE5UmtILzE0ZDRGMHAzay9CQlQwL2NjWG5jWVkzYVhnZlZ2Qk1rTk92RS9K?=
 =?utf-8?B?K21uODBpUDdadGM0MmhlbnNIWDNiWDkzWGEvd0N3MjVtOHkzYzlvS0taa2RF?=
 =?utf-8?B?enYzejNJZks0RjFxeTBDV2xKYXVhbExUMk1IR2pEMisxK1hsY01MYkpWcnNB?=
 =?utf-8?B?UFhuNDYzSzVrbmZaWC96S0tIdExlSTlUTWdmSGVVNXliaTVHNzdRMmlWR3Ra?=
 =?utf-8?B?RkZ2Z0FaSWxpcWlISlNnMzRINHhhSkRjbmxwb0JMbmd0bjBKVmNkRHpHUGtO?=
 =?utf-8?B?aE5kS0tLanYrT1lidjVkWm90bVFpbjNCc0duVG40dXBwLzQwem5ENWhYV0xw?=
 =?utf-8?B?V0dzVEQ1VkR3NkZNc3pXYURMcUJkN2ZFM3ZTamxCaUlnSUpiMHNmSVVFajZD?=
 =?utf-8?B?ZkdnKytPY2llMVNFVmhyaDJFNGkyME55NDNBa2tzbVlhU2xTSDh0OTlsNkhh?=
 =?utf-8?B?akNnUUVnNklyT21ybk8rd3F0QS9kTlNhWHZXQUdpdmowTDByZXExNXBpVTg5?=
 =?utf-8?B?SjNFbHN2bTVuVXg2RjFyR0tiVjdPK0twcy96aHd0eHErclFsaldTSVN3VHhx?=
 =?utf-8?B?L0VqVGxGZkx5SHdNTjRUQ0Y4b09XQ2taamF6Uk4ybjJsMUtLcHVObmF4Q2VU?=
 =?utf-8?B?UHdMaXpNWXVEUzRNS2h2RlMwRk9SQlBkRXRaK3drZFVpdmczS0M3V2h6Tmww?=
 =?utf-8?B?ck8yZENQaHVKamEwcTZtR3BsUWpyWTJGR1NhMCtZNkx1Rkt5MXB2NjZ6V0JX?=
 =?utf-8?B?cGo2YnZvMDJoMmZIQUE1YU8zMU1zYTNwVnJpazhNZFdOa255OTdROEJzUk1X?=
 =?utf-8?B?M2lGL05Yc1BhK2FvN1ZwWFp4WVd1c255a2pJSVBjc2k4OENyWWxPYlFxQUl4?=
 =?utf-8?B?ZXpQbzVwTGphV01seUxxdWpwNEJxb1NUSW9ycFlvSEN0dU9XTXRlREJobkla?=
 =?utf-8?B?UTFCRUxFVEZtUVBvSm94WDU0S0tjbGpnNCtyZld3aGMrb0hpYXNZcWNjYXJv?=
 =?utf-8?B?YklEbmIrS0RxbHUyWlZaK0xuUnFTQ2xPSzZLOG8yaE9JZkY4WEtzN0hUYmtl?=
 =?utf-8?B?VG5VMjltUGdHNitob3cxVkFRc3dqZDdmV1krVDNXZzJFcW5EVk9ZZG9Ebis4?=
 =?utf-8?B?UE1lSFJXZmVNWStFVlJ4YldHZ2JCMkV5YlAyeEtJOUF6MzI4STAwUWswQ3dY?=
 =?utf-8?B?bmhIOXh2M2R6dkZYcW9scXBUYk84Z1p6NjBHVDljY2I4SzdZbVNzamkvTmVS?=
 =?utf-8?B?VzQreTJFdzQ2VHhnbEsrcHpkZk9oYm5rK0dQVktoUFhvRVRiR2pTRHlkbWFR?=
 =?utf-8?B?eFR2YkZjSENlTnVJUVpyVFVlQi9BUkRNckpxMG9TejJ6WmdYN0pHY25XbmhM?=
 =?utf-8?B?SkxiQzZ1dkVJRjNEVnQyTTcybVNzejVhQVBUdnpQaTRuQ1R5VU8rU0tZR1Iy?=
 =?utf-8?B?L2VVM2JCSmprY3JmTGF3TXlzNldnR3J2cVBKTWZRdmlSQlErcDcySHQwT0t1?=
 =?utf-8?B?Y2lESDU1WHRMSmNmeVFHN1kybGtXdGVQR21tWTJZVU5EekF2YjFJQT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf53e4c4-d937-41f9-aa99-08da44614738
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:29:42.3446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suGbWwQbIWcJRdNhdFUB1JHz/wZGqJyCJNsjfa/H5HiWm5X6oRPxdJ8TONSWuHR0V7F8DJxR+vAHF8YvIcs3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1341
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 1, 2022 7:02 PM
> 
> On 2022/6/1 17:28, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Friday, May 27, 2022 2:30 PM
> >>
> >> When the IOMMU domain is about to be freed, it should not be set on
> any
> >> device. Instead of silently dealing with some bug cases, it's better to
> >> trigger a warning to report and fix any potential bugs at the first time.
> >>
> >
> >
> >>   static void domain_exit(struct dmar_domain *domain)
> >>   {
> >> -
> >> -	/* Remove associated devices and clear attached or cached domains
> >> */
> >> -	domain_remove_dev_info(domain);
> >> +	if (WARN_ON(!list_empty(&domain->devices)))
> >> +		return;
> >>
> >
> > warning is good but it doesn't mean the driver shouldn't deal with
> > that situation to make it safer e.g. blocking DMA from all attached
> > device...
> 
> I have ever thought the same thing. :-)
> 
> Blocking DMA from attached device should be done when setting blocking
> domain to the device. It should not be part of freeing a domain.

yes but here we are talking about some bug scenario.

> 
> Here, the caller asks the driver to free the domain, but the driver
> finds that something is wrong. Therefore, it warns and returns directly.
> The domain will still be there in use until the next set_domain().
> 

at least it'd look safer if we always try to unmap the entire domain i.e.:

static void domain_exit(struct dmar_domain *domain)
{
-
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);

	if (domain->pgd) {
		LIST_HEAD(freelist);

		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
		put_pages_list(&freelist);
	}

+	if (WARN_ON(!list_empty(&domain->devices)))
+		return;

	kfree(domain);
}

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
