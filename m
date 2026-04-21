Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65B1925BC
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757269; cv=fail; b=d7981rIAZtcreguXPguSo4GorEsMIivMJmq1nvUvXcNgrM+fEoAicVAJDTUXUkcc8QEZPLkfYqcjtJqV2SrwluUAeEd2Xd5S9qRoHAnu67l0WK8A/qhfqdibhqDyJSSEcEBjir2NwtfxlD0I5vWN4g8Q/AKHGTMIWBU8WaEOq3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757269; c=relaxed/simple;
	bh=1d7RjR2AVEifp2E4H1VyX2YZyulYEN4bvLj54Lrj2BU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnZ/sSPvU5PYs9hgSWUQ/dIGplzzx8RJunYFITQz0x/hkXmNFdLBg47xecSDoRkYMpsUd6oqXCvH0XRDC5jeFmZkM9n+r9jbWwu0kRgCWeZaPOhq2MfRh8/w/YNmtoKpMtpvrSLYBYfCqBxA1Z0qcCoXRfJwVy765scNdeQH/wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPdFfRsx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPdFfRsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776757268; x=1808293268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1d7RjR2AVEifp2E4H1VyX2YZyulYEN4bvLj54Lrj2BU=;
  b=PPdFfRsxWjUk/WzsAaM1aaWZYm2syqkmNqyZ6S6SqcH70jMMadfpVnGn
   2QNAf7CaOu8p+lJW3+yMlxP/702KZNsn88mBcgTuP/bvW6Zig9QKolev9
   z+TY1VP3Iz7fAWBP/fZH0UAsF+K39e5QCKsY0JJm/We26TzCcRsisZST/
   7+mENWlvo6PgI7h/9HEF6HayOjGoqs5FTwggP3TrVJzex7QM50uwqqyWM
   1ebgtDmtr38qfXN74I5uaOliS2sBgZn+ksw5uvpLfxajo1Bld89g2riCE
   t/4F1Y4jcuY7q9lmZKQ5N1XdYzNdbJpJ1Xcb8zh0ga984iKMKPClYawBM
   A==;
X-CSE-ConnectionGUID: pKsDwm7tRzaiWkppm6x0dQ==
X-CSE-MsgGUID: suT449ORS5aIdQqZlV9KCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89155458"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="89155458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:41:07 -0700
X-CSE-ConnectionGUID: 2NgZpE2vRwS89Jx0xAoOdw==
X-CSE-MsgGUID: 0XGnCSYyRPCKsIMDk8B8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="231835349"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:41:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:41:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 00:41:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGNfwMh0aY8lSCuXV67mwqaHCnD5YUIG0jkbUNMyRlX1IWX8yhcU0ycf8JGGL0ZHk2PXE3F2LxiK8EjsTfmyiv1WKl7kPjyiZEjV8uMY9DAIMN9hb5yQ1K0FsxjEzpc+C3vMgjrI+r3MOTsQ0+r56EZbgwNzevEnw4btHXHKXNA+MFE18LufSQgOLdqiSDNKbpiAC2EliP7QkKkGoeMBnei61/AIE72zRxcVQLRjhFcjYxRWb8GuPcUHPf6NRsqFZuh4JsHMaB9/yyaAdDVgKVRdrDucwSeOfy9vG6eXw+UWgifYzo68aLKusH/6rhXWkIf2BzGTtVsVlxDl2YIViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc+Da4Ks2pU2qdZ60qfeqvQHGkqISiECpMLi9/7IwMo=;
 b=ibVPMDeDtK6+BiwmO9ERu8bvI3F7h4XPjIp1IUqi5uWjkd6RmNMucKTqmG2t+EKlrMb6oJxhnw98m/14oRWJSEZy87+yQk9wZJnMowttfuCs8tmh5p/q0Y9yHofAk7cnSgNVQjJ0q5yGNKkXjkZHiU6r2/ZgZ1a7Il9LbERvTo1jT4xeiKdGyVhi5nhEib8MhIMClmQsqsfWtt8ifetb27mweC7VhDK/2Jr4ER56jl8LL0AYEXSbAvE637ll8/Lz/EVwkrBy2BJXKxKjeB/e/a7MW3O0ojrmNzw2p3xwhu5F9kOdEBCWJ+jnltfQGWdivPKhTc9GtzlDdwZNvl8tkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 07:41:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:41:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
Thread-Topic: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
Thread-Index: AQHcz40BheYeargagUmdr0A7c4I0KbXpHnTQ
Date: Tue, 21 Apr 2026 07:41:03 +0000
Message-ID: <BN9PR11MB5276B1F1CF1BA54FE69B8D968C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
In-Reply-To: <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7251:EE_
x-ms-office365-filtering-correlation-id: 85c2c8ee-7ed2-48e1-ee06-08de9f795737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: pvwtzM/too/4ll1Oti8kbTutdWmH8fdMoqQTIKzVCWO1uBOe/RzA2ZhNm7pJCyi4GR1H8ML/EZEsXSuMMOdEW7DrWYeMgTy1S/100QpibJg6NYugDss3P6nadWYqiwLEL2wvzsNWAiBlJ5SYvmIflPknmfasxAAA9fXLmcCjefDGqJivqOP8eQmzcVuh9bpSU+Y27Ma9rYktQCdIww9eOYFBwo9knObI1zDotJ7ZoB0uW/lstjxJt8pCv6rljZI+UrbOW7Y4TnLzu3+AGMb1qNaXx+1eY4oB3OSjbq+KcjKUzBNZPQ1qFXhrpY+25pH67zQu5Nkw7suOkebipvCqXMi6kzJ4P0QPaMS8o+VKxexlCQ0Ht0mAP3ux8mLIcFqR/xnL2VURHyHkCmKpZo0s1MWdIZ5abUyYa9+vE9U6bvTUYZhOt77PC0nF+5/v3zATTMK2+TveJDfzIugP7idzir4Jo0S5xaqQa5+m38Q6imypsbVXSjGRDuqCna5catr/AaJjCh6wqZoOv4UZRAr4QCKEUaxy6ozGbbXDHshQHaTd0co2dnpqD/NkdGLCEeyfgE+I/1HDR0ZILtrDk/5noRFj6kInjEiv0a0WNeY92YkClQbyEWVzXgP3LYD1sOmIDFRvsO6rP2mwAjPxPCWg6SVusyfxBAYcCbzvHn6EeAp8dZQAuDQOC5QtqxYwUyfzj32p3AL9cSLrXkp1eQzUBY9Ez2LCiZ63EW7Rk5daVZE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HOLSWbR60haLsIdgRklyzARAyIIc/4CpTxMjR/1eSy+6VolTm7lAhbC5bcR?=
 =?us-ascii?Q?gJNa9p7Z4+TTWmhnCyAbiaJ6alW0qD0O6tGSNKQBg+/Z0JE3GHL4sXE287EV?=
 =?us-ascii?Q?bE4mrhOk3IrmS0JbzTSn6AkODvvJdfwA79fP28fUPs1oZ9jL2H60vPWvBeCw?=
 =?us-ascii?Q?r5uGUvVeBmw8RQ8TJ0AiUHbBT4lHBY6wqDlsuzr4JenKhjDFbDlNL0EwY++n?=
 =?us-ascii?Q?gjYgnnu7PTyg4bY5fNX1Y0hiaLUsDuTAqEtzQkRgl9pye3hI6Q7Q8tm64p+0?=
 =?us-ascii?Q?2TZmwtRChdLo2YFU9FkKEgD03valOH/f2GjZwBjBIgZngZvOZmzfAXyzJScz?=
 =?us-ascii?Q?69okDd7l/lMgNF0x8/f+PQxdiVdxNxIbQrVV/Aa1ZjrfFr/+CR2nVQ2FA87C?=
 =?us-ascii?Q?R1WDBzZPNPNZGqIcWq4bozedqpKzfbPU4Sm6yPYVC3hqlKfJHIoEhwVoqfFS?=
 =?us-ascii?Q?njUdkatIC5DhRhnIqRG7Pdr8X7CWhYdAP2NkjckLZsRY3mFFZCBSTuAWNKj8?=
 =?us-ascii?Q?jzYQtSka7s7aeit3cxIYpzIQdrIELOZXuec4UnQs77bXvKsCyLEHIsnDxDeZ?=
 =?us-ascii?Q?HpUi3TLRMFNUluHv4jg8k34A/hsWZKNIRXDDPDvKGFw2JPlFewWHl2N0X5OT?=
 =?us-ascii?Q?PTXvNwLLseMfQycv9SmdrmSIqTyx7knLmTO4tvcLic6WKendXchI8dXSDMDM?=
 =?us-ascii?Q?LUCAbJWpC0JjmThmNAxl0DRZrcgfhYaeo8xZMtrJIo3/70/iKn4ApLXlMgyh?=
 =?us-ascii?Q?bMgzXx6M7xMuibd/Ym2j9UdUXb+/ZkwRjB1B8pchEg4Hu7VxQgxX2g4JvFUq?=
 =?us-ascii?Q?C47ADJEhExj0TUg0M43B8mcDzwpo3MmcmUmkC49qC6yHERVLeS9z3ElSDL0X?=
 =?us-ascii?Q?QnqazNGorBCli0O0fLLnXIjY7PiJHVRE5OCxsHMh8YBtH21ZtnyYIZl1FiZU?=
 =?us-ascii?Q?9JXR5NUh3LOAbYycH2v+93lxbovNvSwmWwMTfHRci7l2vdrC6cDgOdG6gUVX?=
 =?us-ascii?Q?lKXzTV2qJ+gBXKDEIA6LlptpQyoXyZYUDotOHHeucJlsCUovBrWCmjX0ursv?=
 =?us-ascii?Q?zr0XnOw0hi0hxhaUlvfRIcjfX9MTfezNZilYm60cvBOtulWg/erZN2C3lMtu?=
 =?us-ascii?Q?6xJAOW1HAuT/zGBgAAFH01Q9RP+o2wTiuRhw81SE+ax9BJb9hoQ1+tGKozWA?=
 =?us-ascii?Q?ubD/m/oDu4kB8eiRSZqxUSTUWr3f+v4TeGSA+fh8F2l7oI3rDzZ4eXFwlPVP?=
 =?us-ascii?Q?IbviTG6aVXLcmE/DaOjhhN7l+V1az13CNH0P6z4CBs7nlhWsX2o/6bEFSV/B?=
 =?us-ascii?Q?j3pNjD4fQVWFp1TN0EeAYDQyvrg846SSG285Yfro42bHlb6mSn04EV6k3DYB?=
 =?us-ascii?Q?gM8O/3v34zia92s/ZPd8ymh9WlXcw8EhvmojSgIVg5AQRYIcpdyjSf66+pd6?=
 =?us-ascii?Q?9QPW4a0WvHeE7YkS0eFuVAhHAl4zJht+TaJ6D7DGs7Al1YxPC+EXYBPtlOhk?=
 =?us-ascii?Q?CVjQGgagrFE/KqzxT5aDNERVyQBH3l3I8Xwb4+vPcuOr1WU/AttsNRrJ2gPu?=
 =?us-ascii?Q?o1Esod/vDIsMCKIBUw8oEVdub4fnH+vpmBcDjA0fIIN6NNUeiJM1ngxsrRid?=
 =?us-ascii?Q?K5Sh3ZWnymjm9EPH+y7NaB74/wWDFNBtY38gvCbj2TmPxQZrzQzsI7FAVYK/?=
 =?us-ascii?Q?lLTrHIg/uyYEg4gLWcRt3b22XJ1XT1MMt4fYNrRIYqxeNId6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SgzLIlHS7+sfP0mFxOlCAktk1HKnPrUzU/BndskUNQ+yrtPF9vf/AKs6QdepTvJhIlEpv17qIlZFatsrfDsBsC/798aeaX5zRhdvITAGUHJn7QWk58YZb54/H+1TtXI+mDS2CMmru9U4OmbbMGmFMBTDAY1VI6l9YCHyNdVUsEAAycVd4k6JBW+eDXLTvCjPKxwZnkM6Ri4IVJy4ZMSFtY8LhnVzkcAwl2JFeXEpLvQYXkYFJAsQJ0+pb3HbPXYhVS65QGbE8QqoC5q0OU6rvyO5F39E1LRhBDTz4q27pRYKQO5a+XH3PhG+ovQx82jFjjeVYwb/gQsBCn7DlWKUJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c2c8ee-7ed2-48e1-ee06-08de9f795737
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 07:41:03.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWPNWM5f/MONUbRb+sAOc/ZOGnwOZlHw1q5QtDuSZkDr9bUrJRCqOtAJPDGFdMNhOxJ+EeS6dit5FYRW6zuGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, April 19, 2026 7:42 AM
>=20
> In __iommu_group_set_domain_internal(), concurrent domain attachments
> are
> rejected when any device in the group is recovering. This is necessary to
> fence concurrent attachments to a multi-device group where devices might
> share the same RID due to PCI DMA alias quirks.
>=20
> However, IOMMU_SET_DOMAIN_MUST_SUCCEED callers (detach/teardown
> paths such
> as __iommu_group_set_core_domain and
> __iommu_release_dma_ownership) should
> not be rejected, as the domain would be free-ed anyway in this nofail pat=
h
> while group->domain is still pointing to it. So pci_dev_reset_iommu_done(=
)
> could trigger a UAF when re-attaching group->domain.

As I noted in my reply to v6, a WARN_ON will be triggered before any UAF:

static void __iommu_group_set_domain_nofail(struct iommu_group *group,
                                            struct iommu_domain *new_domain=
)
{
        WARN_ON(__iommu_group_set_domain_internal(
                group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
}

> __iommu_group_set_domain_internal(struct iommu_group *group,
>  	/*
>  	 * This is a concurrent attach during device recovery. Reject it until
>  	 * pci_dev_reset_iommu_done() attaches the device to group-
> >domain.
> +	 *
> +	 * Note: still allow MUST_SUCCEED callers (detach/teardown)
> through to
> +	 * avoid UAF on domain release paths.
>  	 */
> -	if (group->recovery_cnt)
> +	if (group->recovery_cnt && !(flags &
> IOMMU_SET_DOMAIN_MUST_SUCCEED))
>  		return -EBUSY;

MUST_SUCCEED are used in other places too:

- iommu_setup_default_domain()
- error handling=20

I'd just remove "(detach/teardown)" here.

>=20
>  	/*
> @@ -2482,6 +2485,13 @@ static int
> __iommu_group_set_domain_internal(struct iommu_group *group,
>  	 */
>  	result =3D 0;
>  	for_each_group_device(group, gdev) {
> +		/*
> +		 * Device under recovery is attached to group-
> >blocking_domain.
> +		 * Don't change that. pci_dev_reset_iommu_done() will re-
> attach
> +		 * its domain to the updated group->domain, after the
> recovery.
> +		 */
> +		if (gdev->blocked)
> +			continue;

This reminds me one thing. Ideally the blocked device really doesn't care
whether group->domain is the one before resetting or a different one
changed in middle. It's blocked then doesn't refer to any non-blocking
domains. After reset is done it's re-attached to whatever group->domain
is at that time.=20

Then sounds there is no reason to block attach/replace too. Just skip
the blocked device and update group->domain then it will be picked up
later at reset done, just like done here for detach.

Did I overlook anything? btw even if it makes sense, I'm not suggesting
to change that logic in this series. It's more an enhancement rather than
a bug fix.

Sashiko [1] gave another interesting comment about dma aliasing caused
by PCIe to PCI/PCI-X bridge - devices behind the bridge share a same
RID (then same device/context entry in IOMMU). In this case unblocking
devA could prematurely unblock devB which is actively undergoing a reset.

[1] https://sashiko.dev/#/patchset/cover.1776551790.git.nicolinc%40nvidia.c=
om

Honestly speaking I don't know whether such configuration exists today
(having an ATS capable device in a PCI/PCI-X bus). Probably for robustness
pci_enable_ats() could add a check to prevent it. But given it's niche and
this series already fixes several real issues, I'm OK as it is now.

So:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
