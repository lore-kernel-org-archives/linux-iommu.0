Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB414C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 04:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B466610F3;
	Thu, 16 Jun 2022 04:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pjiS7SNMeZr; Thu, 16 Jun 2022 04:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1079A60FC7;
	Thu, 16 Jun 2022 04:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D695CC0039;
	Thu, 16 Jun 2022 04:01:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A028DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80DFB610F1
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z60kKOBPE6oY for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 04:01:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 312DD60FC7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655352079; x=1686888079;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4dT/hWTlpHN3a+tw+RrESxrmn8rLeC2p8LG9mcbsEu4=;
 b=gD8qX+zFuPrihslRv4kzMcToYWe4CXxuXos0sNFUoXfSKcpfwxufzMUk
 SkshBc9Irybb3ZN+b0dQYvjKr1D0vNNbnPnMJ8OmDVqzsmLYg7iwR0R6C
 St0wu7TwQP95RTIeGVy7PyZu9jemyIlUefU/GRf52Ky15RgQfTFS3jLtX
 rQ6xpLh4tGjOgJZjOvUPf+FMTAGA9ew+d/W9HE0V0I651IdC89wAzbbor
 IjVNJkUs5aHIA7vnV97Ip1VK8cOs7McGwqz6l6v9XP7DedAdy6t6lLkIO
 ICgW6Fq48kZU63TsIphenXSTJ5ii6PWZRawJfOZCEw7OK+qrNWy1IC0DB w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277956139"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="277956139"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 21:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="652985664"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2022 21:00:43 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 21:00:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwpZflOpZfXK8gsp90jqZLDM/HlkJUfJzKscCXK0k8K/ujGi5szdOwaut6K1/B6rkJGYOD7x3oRZwBJibhd/gLSxKbazgmYEzPOHlLJ4mvkv+nYoSF05NQ2HT0y3vUvFDrFDdFVJTRo92oHNif5h0ZRsL0HQzN26r+aM2vdpGkjeX/zk3NJ5Q/ePYmrPlGdsuggiuvE5OuZnbDN+5eoo3Z3yvtHL4RPk3QBJFr7eKscDdSBB5TTqW+QoPzcdJxPR7O4vLm3mbHUMvYvAae5ZIIeLGS/c+AtIkNCGHi8kWtnBBiQSPhdFkFM6rtiXzQPpf8splZ/k9gJlRhL+DBliCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dT/hWTlpHN3a+tw+RrESxrmn8rLeC2p8LG9mcbsEu4=;
 b=c05P5laH04gHqwW5ze9gQ9nojts929G2B8Y/E+cpdHFbBBqqtnssoSgY1dWU5ZW6bRsgnhbLU+aYVMmrDMatcoucoiDrtA5H8VMVPzYDSgDDCm0eqQNpIeHul2zWJ7Y5gS7ER38qYXtaM9ycOyL+UauO5sR4ZKRMxWt6vk21VYCo5vjX0nviflEMe3aR66hCUFUGmDP8Vaa2pOZ1N5lTbohWRWsDfKEE8i8hgswwoa/hNdbWHyU7io3y4Cv73h0q2hGb+k88A+QczHmGywQwaqCpzffJ5RVlxFMwxJte5iCtOqJJG7lQFlbU5oLA+HZdxVeqYktw5++aL2eS5FYKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 04:00:41 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 04:00:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYf5pCZKyuaZgwUEG5kY3NWG6Wj61OdPXggAAKioCAAX90EIAAdF6AgAD4S5A=
Date: Thu, 16 Jun 2022 04:00:40 +0000
Message-ID: <BL1PR11MB52711A71AD9F11B7AE42694C8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
 <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
In-Reply-To: <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9160ed0-2921-4708-cb2f-08da4f4cc77a
x-ms-traffictypediagnostic: BY5PR11MB3912:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB39121E2F530BAD1B1680E1978CAC9@BY5PR11MB3912.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3z7pcCInemFZ/q+PJfwbku8jY/lKU4buks7UMJ9Xw4OwMIoR4XKSAfi9TR8zkO7WR4ettQtBPdHT2w4KReuQhGQvwe7Cs/AKnhG7OvotrmeZNlGuUKUp+GAQzFTqvaAMtZAE9N99wIVdiZSglwB8ZRosGn1pGKhsdh6R+Y2xP229eUI8bW3WoHzbbB03brByzgmjFFPdb2MeIjuwUNWSJ10iaw64ACgHH5ZcC0MvJM0m2DOZk2Y5pmIMLoeHqaQAHFh3xTtUqjsNrNvHHR4BuU9+LMDQWBR83PqT+k8Qfd65U/Gl3phfitb91uFByJgp7oU1gp/um8Mz1isjyzVyk3gvqLGsDXoCv352kKGxV7JIpkNnBq3fpWbQOj0/+Dbnp9xdwM88Z0vlqEqnoGSd1QwUQOGuBd6sEXyKvVyA3Pk3jGw3W3r/nXEAiO5rXWdFr9Ju0/RZrYjSewwEvdn72WDLAaWkoPxEFlcpz8hd3OeCqPq2EuwpjE8B05K00Nb9hW0wcWiF9SHPe93sydIOBAEkHUDHRlPo8XJHzaiWtBvx7WHxNOUpyXGz9pfppXkzbvez23JG5zW2oC9KHQjvKJ0Pnybq5Hc97RCHKGd2ORXi+1qlQyyJtVxKjNc2Z2CMjEIe57LhrkDt8g4poqn+2jmjQbAG9Qm9gqAtv7wkdDvrF8LtW2619orB+1HpKYWQBE/XQ5mTf05H/mKhn0+SQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(66446008)(8676002)(86362001)(4326008)(64756008)(26005)(82960400001)(33656002)(122000001)(6506007)(55016003)(5660300002)(66946007)(8936002)(2906002)(71200400001)(52536014)(110136005)(66556008)(316002)(186003)(53546011)(7696005)(38100700002)(66476007)(9686003)(83380400001)(54906003)(38070700005)(508600001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1NNYjMzMGF0MnBtRmZyOWpjM21ZNDNPRGNtUmt0NzB0bno3bVd6cHA5RDZ5?=
 =?utf-8?B?K3k2bGQ5Y0NhZzN0UmYxdWNodGF5RVhaZGNpWWdxMEJ2ZTU3aGJsZ3hpYkZZ?=
 =?utf-8?B?alI1RU9vY21oZW5tNW0xUlR6UldHb1hMK0hNQWZpM1QxVlhxVm1oWWM2dVh1?=
 =?utf-8?B?eGdWWFhsUDJDZmhldFNOcVNJeWlZN0plamVTQUZPQ2xLVTVWTzNoY2xDdkRO?=
 =?utf-8?B?NDc1SGMrYzZKNitXQ3BlSXUyd2wvUUVIMVdyYjZ5MnBPUHVJbzBpbXVPSm9E?=
 =?utf-8?B?ajcwL1cxVnBhOGdLVkFqQ1JqYnFzazk1a0dGR0VhREZVaXhETk1LalNISGxZ?=
 =?utf-8?B?SC9HcXFyUzBDVUJSTE14dUlGbWVaamNiZ1Z1eStKbGRTWnRaYWVjaDI3NzFT?=
 =?utf-8?B?Z1V3SXptZlNyclZCSmhheVpPSlZwMERYOU9rcGdwUk5wT0FZcUwyUWI4L2dE?=
 =?utf-8?B?b2dVT0RDVE9zTGdIeGsxQ1B2MXpXU0ZJU05MckxnNzFCOXhjRGFIa1ozdDZq?=
 =?utf-8?B?YWZkT1lKMFVvbk1sQ0lqTGxoYnZybVM5eUxvRkl4RlBOZkNPNUZPVHZYS2hE?=
 =?utf-8?B?T2VoQW4zSUdqVGZKUlkvNUdHNGt6eXFIYkhXMXN3N3Fxc0lodTJuUXc2MVdt?=
 =?utf-8?B?TXA4eGNzV2YrRjNVM1RjaTRGajZMTFVEaEh1MjdQeTNDeHppWHZpTXBaaXhl?=
 =?utf-8?B?dnUvbEpsNmdZVm5uVUgwYjNHNENjcnl1TkJPUVRQZnNFQ3haN29uN05wbVA1?=
 =?utf-8?B?MnUxeWY2VTJmcUxBV2JQemY1SnFJcXpVVStkc1hNV1ZzK004V3VnZFpNRU9M?=
 =?utf-8?B?OHZpemEra0JpTEV3Uis1VWlEK3FEN0hmdHJHSm5xaElJN1pFWGpwSSs3OUZr?=
 =?utf-8?B?bjM2alRGKyt4V1JuMHVZK3NpcVhiREZCR1oycGQzL042Qk56eHFVQmxxQ054?=
 =?utf-8?B?QlVyWEZJVmVDalZTU1RmY2tnUXhtL2Iva3M5QXNoMVFidVB5czFkODcvYkJ4?=
 =?utf-8?B?S0NTRndMTVVTc1UrTWMyM2JXQzl5THJTNktvUThxbXBXcDJVUnl5ZnNkZGZJ?=
 =?utf-8?B?N1I1dElKUUxxLzJVdXRISlZyUUlFYzFOSnowTnU5czhOUWVUeHVRM2svZlVL?=
 =?utf-8?B?OUxMeFlzeU5XVFdrTDExUWx3bFNrdUtqTkZyeFdGS2N4VGZoMlZEL0tYY1B4?=
 =?utf-8?B?YkdBSDl6MVI0b2pNOFRDK0E0VWJRK1dIZTBZRWxGUVJaeUNYaXVwcVgybGcx?=
 =?utf-8?B?TXdNWWFpK1lxY1M4RkQ4M2wzbWtFelpTK3pGMkxsVFB4L1lZUGV3R3lQM1RE?=
 =?utf-8?B?Um5NTUdaeTdRS2VHbkhzU3FTYTZvdGM4M0J1NGdIaDBCZ3RxNncvS1Y5cGFM?=
 =?utf-8?B?VGdFNVhvUkUxK0xhbW5uYlIrOHVBbXJvOWk3S2RJTXVrS2Q1TFNKcmFlNjgr?=
 =?utf-8?B?NkRySDRMMStHdS9ZSi8rZDZrNEJEWWtvdnpoZk9ZNWhWV0xFeU1hbnVxMGhX?=
 =?utf-8?B?OWJiVTNrbFVWbGxHQVRnUnRuLzBDbUQxaFNwbFFQM0FHWnAwVUNCR3pCb01J?=
 =?utf-8?B?ZVQ1ZmwwNE1nTmdPVVBnVDZPYWowN2w2U1ZOZFZGQ1RiSkxLSzd5TThHSVhL?=
 =?utf-8?B?RUJJR01SRTdoOHpKRTMvS0dJU0ppYy9NK25iTnQ3NDFJUGpJUThXNzROaEJm?=
 =?utf-8?B?dXI5dEdDbDIydUdtVno2djhLSnpvVGY0enVHMHdZVDE1Y1BIRjJaVGNCb0tr?=
 =?utf-8?B?UTBPTzREVTI3am1lTjlwRTBHREpGL0ZqdHBPZkdEUHZaSHRFWXBvdCsvcjMw?=
 =?utf-8?B?dXByN2VhM1VzTzlUZStvZEMzZmFGL0RvMDJjOFpIMzJIMEVxNlgrZk5vSDNj?=
 =?utf-8?B?ZEp0RWpadExFcmcwVlpSSWk2VXcyMjIzc3FWc3F1cHJDWit3UkZ3Vk8xSDIw?=
 =?utf-8?B?dUtjTXBSTXdkSGtYVjJlNmI4NDkzcnZKU1h1SkJwOWJUcFFKQi9BYUw4Qklo?=
 =?utf-8?B?cGhBUi9wYXZvaTJjRUlqeGsxNmYweUozVk1UOHNFTTd6RHAxblluUjRIVFJ4?=
 =?utf-8?B?Z0JFeE5aWlJia0FFUkd1S0JnTUdlOW1CRlYrSVlzMnRqUzNyUHd1MEFRcjhH?=
 =?utf-8?B?Tm5PS3lpYy9wWEdEWkI1MTlETUxDR1Z6UjJKdERSQ0svZ1dWMjRPUEh2M202?=
 =?utf-8?B?MUZnSHAvVTlUVW9VL0pnM2N5WEJpaitKdWhrTmx5VWVFL1ZLVmtKRjJkOTVs?=
 =?utf-8?B?dDAxYjVPcUhkQVIxS282QjNxRmszWUljdXBIZzdCZXJ1S29Nc0NYQjBYZVE0?=
 =?utf-8?B?WVB4M05EZFpvNkQ2OWhPaVFiWHBST3RjcjFLQ3dObG41N1ZnY1FHdz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9160ed0-2921-4708-cb2f-08da4f4cc77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:00:40.8999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FBhG9OcbkOpZdjqEKv3OPRqfMCHmAc5DSztp9LzIbOskhj2XzZ3NtLdJN3/7viUF2Zud9dLmowxWn8WHYwEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
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
> Sent: Wednesday, June 15, 2022 9:10 PM
> 
> On 2022/6/15 14:22, Tian, Kevin wrote:
> >> From: Baolu Lu <baolu.lu@linux.intel.com>
> >> Sent: Tuesday, June 14, 2022 3:21 PM
> >>
> >> On 2022/6/14 14:49, Tian, Kevin wrote:
> >>>> From: Lu Baolu<baolu.lu@linux.intel.com>
> >>>> Sent: Tuesday, June 14, 2022 10:51 AM
> >>>>
> >>>> The disable_dmar_iommu() is called when IOMMU initialization fails or
> >>>> the IOMMU is hot-removed from the system. In both cases, there is no
> >>>> need to clear the IOMMU translation data structures for devices.
> >>>>
> >>>> On the initialization path, the device probing only happens after the
> >>>> IOMMU is initialized successfully, hence there're no translation data
> >>>> structures.
> >>> Out of curiosity. With kexec the IOMMU may contain stale mappings
> >>> from the old kernel. Then is it meaningful to disable IOMMU after the
> >>> new kernel fails to initialize it properly?
> >>
> >> For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
> >> driver will try to copy tables from the old kernel. If copying table
> >> fails, the IOMMU driver will disable IOMMU and do the normal
> >> initialization.
> >>
> >
> > What about an error occurred after copying table in the initialization
> > path? The new kernel will be in a state assuming iommu is disabled
> > but it is still enabled using an old mapping for certain devices...
> >
> 
> If copying table failed, the translation will be disabled and a clean
> root table will be used.
> 
> if (translation_pre_enabled(iommu)) {
>          pr_info("Translation already enabled - trying to copy
> translation structures\n");
> 
>          ret = copy_translation_tables(iommu);
>          if (ret) {
>                  /*
>                   * We found the IOMMU with translation
>                   * enabled - but failed to copy over the
>                   * old root-entry table. Try to proceed
>                   * by disabling translation now and
>                   * allocating a clean root-entry table.
>                   * This might cause DMAR faults, but
>                   * probably the dump will still succeed.
>                   */
>                  pr_err("Failed to copy translation tables from previous
> kernel for %s\n",
>                         iommu->name);
>                  iommu_disable_translation(iommu);
>                  clear_translation_pre_enabled(iommu);
>          } else {
>                  pr_info("Copied translation tables from previous kernel
> for %s\n",
>                          iommu->name);
>          }
> }
> 

I meant copying table succeeds but another error occurs in the
remaining path of initialization...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
