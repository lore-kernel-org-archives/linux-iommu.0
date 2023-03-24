Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D557E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679642281; x=1711178281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9gPGLDdjF2hrulelr8AyR8wVZEthlXYR/tJKJzGBwE=;
  b=ZL8wQfclWfOwfq0y27B9VVuHDEfcDsMDeNWV7P17e3TEDwR+VIojz06F
   TaL6hZzz5MG2ofNtMmEXWDjdsrbhdIowNpiE5puw0tSycX+kYdw/b9Piv
   I9fDWl/e0lk2IslIijcXsbrnkKQ7CiWLDnzxLyq5fvXecvunlakx5IhUu
   waswJdutjGfoQShkQmTyMjFXpz5ajj3XZhaW069oeBGCY/fRvN3KNXAfs
   MNFsSIqmAoDM5Z1Bzn0aE/yXSTDXUn/D1YLjffd0HBDPpE9KoEF/9LJyf
   zbRN/aLlYOsk67Wcxn8GjdrYoNL8pqZxBP1gQnefACOnuzYTFIEs056NF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328128419"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="328128419"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826143776"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="826143776"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 00:18:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:18:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:17:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:17:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlPr/OosHGvK2epBgZD8KT8Y2DQEW48STmQtlZm/YUgUxK0P2H+/RPtRd6oLj2GMJ3K/OJ4sSB1oDgSikWq4nONRpys+5t5tO8bEKVw4Cy4KMwdvJXIez6YDfeuscCJrriRuf+h7aSG18zxniBKV4m7uorF+ZZzGLDA/Dl+XWE5u+KLOTnJU+ea6T5BoG5P5zRtokiTe67ZQgtHC7BJSMCijEaVmCl+5kg4Lk9hfo3wL9E/MuMJXJi+09U8WM25TwX94+p3bwfHYR7ObdQZZ6rb5Yln89VEEjDuhA976+DxuR3H27fEAt+A3EMDtLOnVo7+E6qj8YRj6PYAzFgcGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvhGOW1XaudFrNQ76ujTx0ELcZNGdDClkg/xLl4UqFw=;
 b=EmcfMrHNwoB/HWunDvSsGqB4YOH9LYURRl2pl5Rxa2XmAmmDb/OwRAAu8IVtSC1wjHcmUG/S8TAtwuleppAbhZiyrb+dWSivC5cRS45qVnuX5hfSyMfFRTS/rs8JzVK7gAV4o+WqDOrbQwfKSETSG/51YqxgLDh/zmKoDk0XamjJYuvXqnuTaNQ76uYkzH1OD7qqoqc7lehUfgAsPByNgpPDaWjKGjF+k1DG0dNNq4qxbsT5OkvNpkDWRc6CVu8c9UaJ3jF+2VpFTkVT2a+DHXgGdxUby2woauM8+bTKUaU+Qtzw76jR5wTTzDrVqDU7QeiXM1j9kll8dRV/Tc3c2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:17:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:17:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 1/9] iommu: Make __iommu_group_set_domain() handle error
 unwind
Thread-Topic: [PATCH 1/9] iommu: Make __iommu_group_set_domain() handle error
 unwind
Thread-Index: AQHZXC7WCkGBhUHJ4EiZT5CsdrNfnq8JiMOw
Date: Fri, 24 Mar 2023 07:17:57 +0000
Message-ID: <BN9PR11MB52765D03BDA136594DDD20DE8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <1-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <1-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 2c41b012-0833-4d59-7b0d-08db2c37e4b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvW0Ce1byl0/XTqCJ7D5Fc4dAf8tYovnOxoNEsz0WRjbOXBozUccjU0QZ7r8vgeBzek2M7zJ7Prhf7u7h6w/LqR650W4qUkWqdKPipqWuBaHtTon/qRp0uHfx4wLHqMPI0lr27nPWmhr4xW1kLFqIukIeslP1UVFmhbzk7i4vOTYAyJT5mXx59UnuzmzG2PtP9yllZHI8HEx1fV4sCO95wt44D9KVI96iOeMAATLbSkSTiXmi8xUw5kHinCiiTtqJ1aE5SA0ZAZls+VYOthsaEhmPCbLocMCzzJD0QNaJqiFqvjcsQvZN8NXEqDvePi3uJQTrQXxdLQN78obnC9th4i7zEV3P1p4MqiT5rOlixzg9xxZ1eZPScamE3zfeVhz7nMXu3FhpRZZVm5rQUptHTY0rgUzq08ObG1FrZ258PWRxTibNZtBL/V689AyUbP5g0ZmIpttgCnM1H7IA/Wy02LbyCd+pI4wWDU+0/fXGQ/mwS1AEX/6Gxq12lFU6VWQk+KlwKw6NmHUfWlhF9g8MBL5mvgi+Cu3/+Hy0MxsElyCfeQxNoKb0OaTaE7VANe4D0/2gQG+LnU2LXtshTVVhY/A4fJtUsRVtDX41p+c+4KQEUZsBfPE4isciGoa/6TTws8xtG4cATzbqudQDqdSfT08xn223mYkJNJZB3wzebcrNA+mzvWyE+/WKaRbq2mrzHx+7EL0MbEqCkZSy0LgUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(82960400001)(8676002)(38070700005)(33656002)(86362001)(122000001)(71200400001)(7696005)(38100700002)(52536014)(5660300002)(64756008)(4744005)(66556008)(4326008)(2906002)(66476007)(66446008)(41300700001)(55016003)(8936002)(186003)(9686003)(66946007)(6506007)(54906003)(316002)(478600001)(110136005)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YhWnKG9aYmxC26FHNRLRYgqXvF7FeZHrp5poU01SfxZEubf9EqOEq9KsW7wW?=
 =?us-ascii?Q?eaD9oQfs+jtCfs21pyugkat0a84+wRb973nopKiV9yN4SPhdmj26PY5GzB6V?=
 =?us-ascii?Q?qBm6G/iiPAv0iA9HbgSnItQQHhxov1rcm6A+soc5mPgf0jvCNLE0z855l37b?=
 =?us-ascii?Q?AVptKlLkXxjyL3wMobloUKZrtLWUh6bu7ec3m7Zf2vchJxAukn73FwhyiYcA?=
 =?us-ascii?Q?j312j2zriHL7A37G/pXCceFW4tGqvAEKC4JxG635Ucn3noKonvNHPmOlTafb?=
 =?us-ascii?Q?eDuF/G+VGgXx289Y8wisKuCyfURWeyqSyZN16m3TZJc4EbzjnPv+p+bOfEoj?=
 =?us-ascii?Q?wOHYlano3oCNOGuMWDr07lvMCtpTQyxxjdT2Z+u6AZVXWfavwKpADqrqQv0Q?=
 =?us-ascii?Q?eECARUVqsXUm0aU+cJFJZFdof43eagGfLwGFtlQOeihI5Q52b5ZJqLSGXqmx?=
 =?us-ascii?Q?xHPi0C+BJKTR1L5ARyPCdQYCaxrc06c5HoEQ4cEC4Dyp+4eLQNZZWQ9m68iC?=
 =?us-ascii?Q?zqBb6fWCqUu2SWFOwIJbERAQjs5MR7P/AqseqbCunly3h64RMJ3B4q4LIG9N?=
 =?us-ascii?Q?94iuv6k+EUyeiS+lXEZzieTa141HnOBpPzQC6c0ObCiG/gOaVvOBv8Gw1gii?=
 =?us-ascii?Q?8kEADDvIlTEBK/uFj09SsyIXNwJ49EoprDChe7nOn+v6XN+gajTvJ5k4EnZb?=
 =?us-ascii?Q?jp6X0H/H20RXHhrSQ5HQ1020XV8Syw4m0MHt9mWqeWyVbLHLia+/44DQXBis?=
 =?us-ascii?Q?IUkkHeF3JtgV23alLen3Z9jVOXMJCCvxmJS5/6Ud/OmMac9noJSSGqUNydNt?=
 =?us-ascii?Q?r4XBZmjc3KFLq1APkitzHc26rq39q3wHlvbZUt7ZpSuTzyT99IHxrYdqGY2C?=
 =?us-ascii?Q?4ocWLmsJGws4vpQvCETQOlAVuWVbxCgtGs1heu7xInE29v2e9/LVFpZv2mwH?=
 =?us-ascii?Q?RuxGzx9x357hpoZaN4XLqc9nrsn3TxiPxXf2OxYUYw68fyUns4Jbct696vyr?=
 =?us-ascii?Q?6Ft8Bnh2XAxdx/e3JRxBLdXNav8JHPuHz09ddCXdtPloxA+XTaO+y6YClV1L?=
 =?us-ascii?Q?dBDWQh9kb0cBw2gjzFKey3wm4Sl9RlmSKo6UMDv0CY09SP5usZluuyTpSAsu?=
 =?us-ascii?Q?KJ1bNt3q2biTkltooL18a2GQJZoBTFSIF3yclKBBDnZg+n8RGmvX8k2jdbAk?=
 =?us-ascii?Q?99w5Ye7KsEOcSyrLEZBsU+PzGvMyAXdngjCUgp+zLP9TqE03eTrkbFuDgVo6?=
 =?us-ascii?Q?VMKyksQGvKkOoRbynFmxjLPgdMfRVRd4vEEqlDCevdGmGX8mqw/ZyupT/A5k?=
 =?us-ascii?Q?YJCj6cgxYWWsiYhnrsgSu4yN82bd6q5zSII+SkLnyQrY2L7rcxfQvsk9jhdL?=
 =?us-ascii?Q?3lSrWNi+X+gWbmhqmKkrwBQAkkTys/jDxcpx52FpJvvt3gKNMIqfeKHS7ar7?=
 =?us-ascii?Q?/cc7fPbXJsEsaPhs6X33GH9DJ4KXRrMfLJPaqoyIjkp64eGX508FOIOv0XMI?=
 =?us-ascii?Q?pC9A8uKW8jORvir/gqJ+tKtDlEAB6O4hHAtlewiFWO3s7oewya8lCzmJFo+Y?=
 =?us-ascii?Q?BWNW8oC2ISTllqkKz0EPrLIxo22WtQxvH6pI7zGn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c41b012-0833-4d59-7b0d-08db2c37e4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:17:57.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHFHK7OKx9u0YxKpdS/l19E1OeaAZaDifNq/8pk+Jo6p/S1pAHrKV/d48H5kmV50/62+AmL5IWx/NEXLX+mE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
> +
> +		/*
> +		 * If set_platform_dma_ops is not present a NULL domain
> can
> +		 * happen only for first probe, in which case we leave
> +		 * group->domain as NULL and let release clean everything up.
> +		 */
> +		if (group->domain)
> +			WARN_ON(__iommu_device_set_domain(group,
> gdev->dev,
> +							  group->domain,
> true));

s/true/IOMMU_SET_DOMAIN_MUST_SUCCEED/

otherwise looks good.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
