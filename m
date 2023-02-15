Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1D7B
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676449587; x=1707985587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r1p1arCN1VICg192Rs/CYl/Fe05o74K2k3v1Jas5HU0=;
  b=hXqs+7i9l6r+wv9B0T+VitvFmHYkH8Ezsc7G4BafSQsBIpOP+8e/zb/S
   yDeRjSlLZrV9vhA2WzUKtGuxkWx2q/2esTXWaYNvzvtv05sNZxouU5uuO
   sal3l8JN8+wixjkhXR39GHpahFijkjEKqctc83QIoWC1dQgpup3xXTZHt
   ii+VfrBgvbu5D62xmO5EGebAt5i2GJ22nhIPmWw3Yr3LFZ5wdIGE0mhMU
   NUWMsUy64FjhCCuaO8kAKfSZojvSZ2nnnL8HGozjkJl5StQAMQj0xFAUJ
   B5IphrxlbSLwNJhoTi8OZ+hnkHfGQxl23qDvVbgbVaYL1NFNfQMMNYxzv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332684316"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="332684316"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 00:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669523340"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="669523340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2023 00:26:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 00:26:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 00:26:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 00:26:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 00:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=con4e6OC/p7h4MjC+e6SpcjD6lkywk6ppBFlH0ee4P6ZjeRr0kH9BJjPhk9uETGEo5QzRbURN2D7WbR5a/CDIcqWFGMSGEGBGeZhidW8kFJralllLoc7OwAUNfekEUXNbHDPXVc3bdJIYWoUIkVLt6pgKjxXkYwx6wSGvgOeRZpU/RJAP7IXXORBM55lt7oEQl0+7jgpWbYD9wRIkGKG7kOtA81U2S97qyaQRcet/xj5oB11tqa/34fNsqCxCZjVLVAsnty0ERgctv0ctQf29b15oDN9eMdJ/2vMZpQDbI8e0NJZYNrcMFYn8geqCX4T6oZRCfPcpd2TA2gY6KUmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWAu7npS2lxZckSZ7o3y5jQibeUREJDEWD/qoVKG/U=;
 b=cr/r29k2J3KuTMhrnOwf81GtyKHfmyfggPDkryOGCyWV7T6EqFrnGCwOo3cybK2R1hsISQ7qhkCinTnyk5ZUTw7M0P/aN2g+j+us0fE9/22r0hjFWaEDxIrdVmeOPxFZDuJB712r+7BMhC+YJAU0GpDqhqwl1zhVraVEuTBC3svIb6AAEqpy/VeMenCzzkk4Ta1UkVfgHjSPyhoS4NhCCrgQKi4nMR1FufkvreyfkhHlhZgqrYGe9RNx7UobObIh2ksDl9yJoFXeq3WIU3XKarpku+gc17FWD5I3VfuX3WrVYHq5nl+Gpwrgz+176Iz3f+N1fgUhMQkBJbZMBmDZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 08:25:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 08:25:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Zhang, Tina" <tina.zhang@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	"Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Allow to use flush-queue when first level is
 default
Thread-Topic: [PATCH] iommu/vt-d: Allow to use flush-queue when first level is
 default
Thread-Index: AQHZQCQvD2eE8y9czUS/pGh/fzpY/q7PrcEA
Date: Wed, 15 Feb 2023 08:25:47 +0000
Message-ID: <BN9PR11MB5276F6A2676A7AD4D769D0898CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230214025618.2292889-1-tina.zhang@intel.com>
In-Reply-To: <20230214025618.2292889-1-tina.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO6PR11MB5636:EE_
x-ms-office365-filtering-correlation-id: fb57018c-4ce6-44a6-c62a-08db0f2e3d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzPmHVP0DgtKVjZj8eGpn4BELCsT4r6uRS0Ky5PY2eYC1gmtjf8UtHO3v/D8hKX9/ZGyoGi1hRckxz2zzIRi8sA69kl0nX/0ZCjJhjw0KMQpWvDVK4G7PmlUaX5SE5OU+OCVdeFvFa4atzvRAWvDXBlNS62i2ksw+bWxT8YkXpeaVupCirQcdKrPT3KI714Q/ygKCsKZ/ZLh78C6GIpQTqfDnFsYQF+D47uKmJtohZ0CnVfJFrvEQU96W8dcO61YbJbbSnwKUY3b6TTUe+tR7Zsewy9gnkivHxA4qJi46dPttFGkp3ho+nq6v2uRxzcm75KH2IwAiQJvNtjT6wtWIvXGXxDUVdEyxX4Bs7lSuNe0O5Bju96j+mo4PQeLIpwZLlK8tns4UXaM2QrznyFWTUMWAgL7wkfPQfQFt3NOI/qJ7YFsEjqbbvZJqjJbikB0RxUqwFlYGKG2ggUHLtqESU7od/Hzprl+ri8S5vAQI+3Pgvqp464wjdxqclTiP9ld8fiAQ+8syHM8TTMzLEmoAcr4n+CgOBtnMis7Vq8hkLi9YOnyEXcAmP0s9TZr1MqxcPpm4q4VP8pj1DkOkYLxENr9qOZ4pZeu4xSrjECSd8X9jpUH7nGQouNCeEB58hR3+Ck5R5cqghlz4/Y9kwsVlkhKk47l2r5W4yOh26DGRscfpuPPNEE+SxtPt+l0ZdKvGTUyYzIbwpVqjHofWizXeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(9686003)(7696005)(82960400001)(38100700002)(83380400001)(8936002)(76116006)(52536014)(122000001)(66556008)(66946007)(5660300002)(41300700001)(4326008)(8676002)(66476007)(2906002)(66446008)(64756008)(55016003)(71200400001)(6506007)(26005)(186003)(478600001)(316002)(38070700005)(86362001)(33656002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTrn1Y8cxD3l5UtdFS+S3qjbVQF5eW1WA6xLkLgO+KC8YBjFdmLvPiVumU4E?=
 =?us-ascii?Q?byu2W4kVg2TVdKQwbewPCZfaj267q/WnBj9nVT+TKZxG4yOZAwpajuZY+EpR?=
 =?us-ascii?Q?PICXvrlQ8oKHEkQCNsw/Ak2sNAG0YN9QWJhCnRFhNjfJDLb6j4z3WjKvtmPb?=
 =?us-ascii?Q?B2FoScJ+hXTRI1Bb4kgGCYBl8EfAKzn4RDEjRpoW8HDqlNLenRNw6dNzg+qj?=
 =?us-ascii?Q?u/+whg9LKDaCDXIhVYQXm6b2JsGyvq2q1Gt4jtpZCR1+ABZQCSosks+y+ya4?=
 =?us-ascii?Q?JAAsY3usdH8ZTzrtDw91ZisrsSS2jtSehyV15uJvS/Gm8WWUVTZb4vznGa6d?=
 =?us-ascii?Q?P/UnCkrDYa7JiLl1kYx1vx+UBunl9c56zOPDHndqmDq+tT5uK8ydbGakm/jv?=
 =?us-ascii?Q?usVDkC62FQmbtjiOt3d/pS13wQ8Dok+ikAYhBcGF4DL1Nqqfh9aWnuu8oBl4?=
 =?us-ascii?Q?Co1Fx98s69Su6NrTO/tDLkAbg3j9EFrv0IK15bo+plK0J0PklAtAt75/5RFy?=
 =?us-ascii?Q?AB8cNc6oEttXkLs6Tpz8hxq4Nh+HypfQ3UUxdGH+Tami7rK+wbS7W8EdlhSU?=
 =?us-ascii?Q?ZNEQSqshxuYu/1nTaNxBMMXtqoNPDrEzj9Xup98aI8vtf+t29ny7Hk7Ur9Em?=
 =?us-ascii?Q?EMPvFzno5ZGC0TCvflKZ8v/9Zru2L3FjqK01o3owkJ3A6rkpwfdtimbkXJx7?=
 =?us-ascii?Q?8YuEcNRIOiTxFffXkJuyfxYdw/6S1KW8LoYXxCuql49TUdqQZMCZ9Xw+vXwi?=
 =?us-ascii?Q?a863jcZFM6nX2Vp+/nFnENBuI3jysP1CdZP+FXghzIOd1M9tgu42iWxW14fS?=
 =?us-ascii?Q?I5rPF8OlHhNTx1YjiZeS7/JOIuAQYW0DVT+myIubhB/e92pUGqDUvhlRe1R9?=
 =?us-ascii?Q?NYs0+wGzGnt17XhMfkQFNjyxh5i1V3Tc7SCvOWz5iopEtEMUCul476d/4Ve6?=
 =?us-ascii?Q?3/E5EDFTiXuGhhkc85k28zwjXQEr5kliKzd6y90dmFla45o5SOiYMG+bSDL6?=
 =?us-ascii?Q?SygZ9ArT7AaVCGtAaOHKfBErh4kZ1/1f5z8EpOQyUJWejE2CXfL1zK+o6fp5?=
 =?us-ascii?Q?dDlTN+zopzS9FPbCJZCOrCdhcmtOrtwYTQSHa9aw8RBIyF46P5hszqCfaHsP?=
 =?us-ascii?Q?fHKqhlGrqYjbYanOlPEiOp5Om2xA79/Na1RFETkqkovdqedegXcdXlbLK6QV?=
 =?us-ascii?Q?a5J4W+pGQJJkwVfkDyuqoE++LV8jp4vVu9CjLaEN0fDQcfilXnLIsxDmYlgH?=
 =?us-ascii?Q?GQakRTpTo3m+fpZuKMWQxUaMT7rMHQ7CX+K3Gws/asxt3cEPJQfrL9gemFkY?=
 =?us-ascii?Q?/mj2vqh0H4fMMnd8OsgK/lShUrU46CIbabFNV8adXOdIHJ4bgALGJp7oB/no?=
 =?us-ascii?Q?ELuSkQYYguCuN8fFVHSbRYpsJB/8YPNBalu9N/TcoaXtEBn222J+lzb5tsjA?=
 =?us-ascii?Q?h7FJv90YnusM6J0qddm2PrevwYbfffU7E7Mese3sbI3/HWfoMKv4obC7qOK6?=
 =?us-ascii?Q?lmgddpe+n+dx5yqTTkrCb5FjqZVX704He+U26Idg4p3gr7N5kjugi+NSfn21?=
 =?us-ascii?Q?tcb8AYI/mOaZ81vSPa3Yc1vrDBVI7lwd4AIC+BCA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb57018c-4ce6-44a6-c62a-08db0f2e3d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 08:25:47.2616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iC3PrQeMeOsfTzVn/qcwayjpRvVf41GjO00CTnTZ6Zebfbnv/413MAz4CJfC6GB3x/xvNH1pcBWMzrzFsN0enQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5636
X-OriginatorOrg: intel.com

> From: Tina Zhang <tina.zhang@intel.com>
> Sent: Tuesday, February 14, 2023 10:56 AM
>=20
> Commit 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-
> mode
> is on") forced default domains to be strict mode as long as IOMMU
> caching-mode is flagged. The reason for doing this is that when vIOMMU
> uses VT-d caching mode to synchronize shadowing page tables, the strict
> mode shows better performance.
>=20
> However, this optimization is orthogonal to the first-level page table
> because the Intel VT-d architecture does not define the caching mode of
> the first-level page table. Refer to VT-d spec, section 6.1, "When the
> CM field is reported as Set, any software updates to remapping
> structures other than first-stage mapping (including updates to not-
> present entries or present entries whose programming resulted in
> translation faults) requires explicit invalidation of the caches."
> Exclude the first-level page table from this optimization.
>=20
> Generally, vIOMMU can provide first-level translation support in the
> following ways:
>=20
> 1. Generally using first-stage translation in vIOMMU implies nested
>    translation enabled in the physical IOMMU. In this case the first-stag=
e
>    page table is wholly captured by the guest. The vIOMMU only needs to
>    transfer the cache invalidations on vIOMMU to the physical IOMMU.
>    Forcing the default domain to strict mode will cause more frequent
>    cache invalidations, resulting in performance degradation. In a real
>    performance benchmark test measured by iperf receive, the performance
>    result on Sapphire Rapids 100Gb NIC shows:
>    w/ this fix ~51 Gbits/s, w/o this fix ~39.3 Gbits/s.
>=20
> 2. Theoretically a first-stage IOMMU page table can still be shadowed
>    in absence of the caching mode, e.g. with host write-protecting guest
>    IOMMU page table to synchronize changed PTEs with the physical
>    IOMMU page table. In this case the shadowing overhead is decoupled
>    from emulating IOTLB invalidation then the overhead of the latter part
>    is solely decided by the frequency of IOTLB invalidations. Hence
>    allowing guest default dma domain to be lazy can also benefit the
>    overall performance by reducing the total VM-exit numbers.
>=20
> Fixes: 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-
> mode is on")
> Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
