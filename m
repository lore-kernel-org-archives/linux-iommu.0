Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A31547C0
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583344; cv=fail; b=H6M8xXr9aCNVCUPBTKt656OHyfi1t0C5uq9zJag5LvBXUDY0YA/N6GqMXdp/9TPP33FHgJKIjBE0Dh2gcmsA+rbSfsvydkdnh2jh+tS+dXN4kJv23GtTJnPYMmgv+zFhHFg50bgmJi9gfpwfO+vvaVdWTg6etVTvAfpl3yOuh3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583344; c=relaxed/simple;
	bh=OMFiL4svmD/22te8cEx7WKIkPlLYVNsoL3Si7DlIQu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PAmxbIRjfdtqwj29Al20jbSKya8N3gvRWW3IpcP7u36fzk+nE6xKSfRXvvwyNll6nz5jEkydXy3PHfZGC7r3mzJEKF29leZKR5YllC48I5I5hmgdQd9g2htL9y6ezPfsKyGc3eLXZWse1HuqGllUxJBrJim+Xv+vtYcuAp2IJJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5epgmPw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5epgmPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583342; x=1761119342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OMFiL4svmD/22te8cEx7WKIkPlLYVNsoL3Si7DlIQu4=;
  b=B5epgmPwFQ0f77JVN0OS8qc488ZiK3LAxmC6GqET0I5E4NE5ga0PuwjL
   3MBOw2D2zlIF40g/A88AxJwCvA3GAb67ELVJN2qW937OQCaNIRlqsj3Z1
   ifRP5VcKnuWxYZC/UjDLUMPuZ4REji1guxJnm/0A4Sn33+28/+2vhMsly
   I12Swx2/NVj+0XIv67d4oT5Eh1+3le+IMhX8VYX3Eda81BXF8F00uuyeB
   d/Iwl4XK7qMZMMggmHOYMIdL/iABCREIuR1fB1Ie8iJEIO1JGRf19vG3h
   vTn9BWoVguQWOGQZSEHZmTyzHHdVDFWedQ+1dEnkVZn3rqF0Gh8YmqYGD
   Q==;
X-CSE-ConnectionGUID: gA27cKIxQIy6b3lr/EDWkg==
X-CSE-MsgGUID: Mawma750RAefTwifl1NwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28977608"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28977608"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:49:02 -0700
X-CSE-ConnectionGUID: 1awryV9wTVKfECbSlR524Q==
X-CSE-MsgGUID: sIg6VGHyTNCr3QN8bHIvtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84595519"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 00:49:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 00:49:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 00:49:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 00:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF80vkzFE59CkA8GO7ztLZba6pfM9IZV2ZZCrY7w0D8haiUUQkegaz4G3ojSfTg9mFBOK8+GJkTPDoDHBD7NkY7sYmBQh0EDicNVklAVsSVXKXqT6MyxZ2MMIRj0XPjQO7eyVaNBlevUdzXUn6jVMnrJdIU1Kgt9Isg5VL4NCWLNNAhjpT5g8H/BhusE1LW0L1bfHR/jB7JIE0t5EtFJtCPD2grpnRqJ5p7HJosWiKEXvg4/LEYSTFZuiD/7xz0RYviatJrtucyGbsj4t333cFwKxoqlcIngYY53fEV7Ag2ITYF0eJTWpNo0KilHPgvFnITaus9Rfmvn5X9wYVaeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpsndPgl55SDQvBSohwF+mP/Ol0eYCvetY6DhxrXvgA=;
 b=Zu67bKkaciIlWfLXZXpbaAkIhTyJe0InHM2tcJp5x9BlbLqIvrVAT5ed9EggiPc8v2vKYQOzLvcSQYPt2XGOOKoyo5xvITGdYtw30efCNGbso0TNYzBdnKPPxj/LbJH3zZxTxod9WIYEtGjjg/oo4xLtuwBoxVrnK71HW80CfOuUVvAF6urXqtHC2cpdAsIm36DcSseRsPNA/pVzF3nDL+4gGm28tpX9WoDY2X4GuOIBaSk2aPjliLTtgXYevdyuTy1fJdGsuBvHQI41TXzARpPcTSQ60YkdApHXCf7O5FIZvXsfa9RJ0VLHniNF3+jW8X20B8JhTZn8ZsJUTzek6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:48:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:48:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v3 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Thread-Topic: [PATCH v3 09/12] iommu/amd: Enhance
 amd_iommu_domain_alloc_user()
Thread-Index: AQHbIJ2OJMVc/xGh9Uizmnks+ftvpbKSa8bQ
Date: Tue, 22 Oct 2024 07:48:58 +0000
Message-ID: <BN9PR11MB527625CF817D73A8971AE9988C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-10-vasant.hegde@amd.com>
In-Reply-To: <20241017140137.6028-10-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB8826:EE_
x-ms-office365-filtering-correlation-id: badc71da-07d8-4369-c615-08dcf26dfcfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xWkFJcEGS7kCblYUmBbMZAkSyx3ECDjesxuu1TaAxUG8z+7hIEX0Pg9Vm4Zg?=
 =?us-ascii?Q?aZIedGrLLFZVuylu8COObsDqJWpGLLnwfvCwmO6/f2zZoGJtsYr7sInD98OS?=
 =?us-ascii?Q?pBc13xWShWr/nKhE8JEx2En4ITfdhV7TDUK3sFnoX2NetJuqMHjDYAM1Sof5?=
 =?us-ascii?Q?UwbMQC4Df3cT5reKDPcmSitV4wfs1xp3HRwbHMFMNlH49GxkwznzycjsILEu?=
 =?us-ascii?Q?GvfWz9Kr49ZxFz6lRJ9F88hEcVFRtINTVQwUludXWUkJK+1amlbQn/a1Akiu?=
 =?us-ascii?Q?B7ZUjq/5X9Z0o23k11jx+pklNLe/KyZJXZ2Gq6ZlZ9SjJQyBZGWz32SkFIdG?=
 =?us-ascii?Q?5KS1Ljug6hXgRB/wsC7q4Ia2WgxWOnjuZwkDIUkWxQRW4MvseQeP1I+5tIu2?=
 =?us-ascii?Q?eSzkyUqfMWPgQ+TjX1jGJG1yfnmsIb9lb93tmcbP4eIzuER4lkGE+MRq+o02?=
 =?us-ascii?Q?fnl3BUkr75wR3USbBv8Xv90PMYO3ifgBhOLCZw/RS4JdSdTuyufXRN1sTqHO?=
 =?us-ascii?Q?F18bkKlbH+eGalt5bi3pJHBI+6PG02GSbK7M806ICPLeuUF3bgYm01VUCNKy?=
 =?us-ascii?Q?0TDRePgHyJ8c7NBNpJ43ZG9xtFmUTdLpAHda/OOfvOCNsRQaL0YQXg8B4uk9?=
 =?us-ascii?Q?fWgydLqQte3CiPwKMuoqvjj0eCkKyrrJ7+yaGHiD5kColPGG+s5304IhAAsc?=
 =?us-ascii?Q?F+YHov41cmYsbJnyeb+KjqsbTKKkgn9TJiaF+wQvfMHepwej1AGS/iH8VvIK?=
 =?us-ascii?Q?7CmV99Px4lBJIySU9VddDczwb/7bd1MNQhz1IAw5gBlGyEdDjXprH1DT5cW2?=
 =?us-ascii?Q?QSxFIeCIwSFdNzmRaUd2vi0klMCW32CkYulkc6UgaslcH2GyZv/0rcXjwmYp?=
 =?us-ascii?Q?o19fj6C7WN5oRZtGIcPyh6S0mQn5KdVG10tdbCyuIAajcn3Wxa92fCsktbW8?=
 =?us-ascii?Q?BTee2UqwrgAIi0Zshw/S90xZ6y2mcfWbS5XWVlg2kyQzoePhN/AOUz59UpuZ?=
 =?us-ascii?Q?Phka9Vqq8sxLI4ZVQadXM7iHBNqvvwaH53cLe2+HAhSWCavHZ06yarKhMplE?=
 =?us-ascii?Q?bXoOY6fYMKW7D+yEi1q+GHFQWBt2MmOvsuDbcykndyQ+5ahWLxkv53EFGojG?=
 =?us-ascii?Q?fO4UZrfcrn/ekZ3oUmVDhUwkHAEo1zPD3njU9YDHRAlicV4mxKlwUbIX88Ku?=
 =?us-ascii?Q?QK5X/ruvYVR6516SXRLXSu0OCD38LVnbYkDH9Jypqy2p1SO9MGCB1w+aB8Ei?=
 =?us-ascii?Q?PHdORJLTXhy+BpZPRsLxIslhw7FObYgjW1DE7kf8vSboFY6SiN+LEg0FCu0B?=
 =?us-ascii?Q?G42Gb+MERl3U2k5GyUJ2ZsxiBJHOzWdE+N/n05K2gmLxjJX67is29VmtkZVC?=
 =?us-ascii?Q?yLZlmrU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Q6mE2qM/1dJn+Rg+fShkoVXpmL0f8Y8IKaV/NWBOtAu9+/VBaBiyeqZ8Prp?=
 =?us-ascii?Q?sBLt4rqcY1GZdrW5hzMrjJ8iiD4WTQoDGD6Y9EwH8xV/T/mcoJYjM3xWFd9b?=
 =?us-ascii?Q?hjEDZbvUAl3Y72BN24BCINks9ppY7NV4ogE+mlAGF+GXx3/vNEnkYpi5u1kD?=
 =?us-ascii?Q?6sumPPUN4sIfU7jf2/ZjwDVSgJ8DKRfTqPAPR+Ca90qYC5l5uzXSPM9wPBMU?=
 =?us-ascii?Q?hXI7omkmhrr8zMh/o462zQ4ppn1UlmzSGOc1s7UjZBogFA9mREWSBmBkvdR0?=
 =?us-ascii?Q?3yv939GKGvh72RyXmT3ws/muEnX4qstVDWrSOSAJsy4gdkFXm804+zsALRvh?=
 =?us-ascii?Q?siZ8R9+7npnPSsr7RPU7MifKRqjxc+/KOVN+84GbxQJzYFF97sOkXfU9rke9?=
 =?us-ascii?Q?4tVAEfTnNkVEKr1OfLnBiiv//HdyU1A64KNW8bKkJmDADFzSRzcqemmMRDe0?=
 =?us-ascii?Q?ri2+BxWl80q8qhf2jiR3BIUBtVFZW1WdkDhUbSFgQvVX4pzXEPhl9qr92sbu?=
 =?us-ascii?Q?GbaGqAvCj4ShJ/agFEFTjbmPvB9W4ZKJzfe+Zv+OQJT9BwvZRTufaPSpAAKR?=
 =?us-ascii?Q?LXtlhLb01xu6LxiNuCAimmaNStsNHGXHlZANngY0QA3LjTFu28oRJAkSavLf?=
 =?us-ascii?Q?1n8bYjtNplkG76hHawRkys5J3exwhNYTllr3rxkuRTxWCFO/aeiS/Z9l09Tr?=
 =?us-ascii?Q?/uBv+SnrNoZ9brykHsaeqkPlevLSjX3oBZDoihON01fR7n6FrsqERY8bJWTS?=
 =?us-ascii?Q?Jivvf9qf9PA9fgPuSgr+OBqgPXXkfgMythBjtrh75/UyBZ/0cB5ubkz1iYF1?=
 =?us-ascii?Q?AzByVOTA0p9yJhUQI1UiZx2QUGEYE41eIpQtl6W4D2G9Pe/YSqL+PRiJZFAK?=
 =?us-ascii?Q?59+p4rjbEv7zt8yO2lEHwkgdHCyi0TWO8Cf08GRuddh3gT+KZVhln9R9aTBZ?=
 =?us-ascii?Q?MFqekFxLj8PY87Fnzcs7qTpDZQr8Ns/Q64UHE+z8X6cOYDSIuhsk/bWeQnLh?=
 =?us-ascii?Q?MOVXmfWX3LA1qz3Ql9jaPpm7SZnCGzR+6vC/GoHH7+htmo0fxi+aqXpwtKnZ?=
 =?us-ascii?Q?RU/kLpRpSZtf0/su2ec1DSGkBpSP23nHNrZPzGVmrYLgRh8UDXKby1zQ0EYC?=
 =?us-ascii?Q?TPEuPIQKsbUEHThNNG9umi4bxE1dm9Z7t+jvfAIiHL/Cv6CXdqPEZeRLamYk?=
 =?us-ascii?Q?uJrtDVEwnzqGaYVZdVR5meP7ymk+PlTB7szGFyF7LFnr0chD26bqK8i3VDgN?=
 =?us-ascii?Q?1mpGjDNwEUNQeZnJjX7Bh82Hta9iH/opSuUVAi+hzoro1OjH5I3WcEzeWHk1?=
 =?us-ascii?Q?rVkbk+41VBUGmpC02Ov8cQXRRcz8+HEcMQnkZd9uW9kurQ2FuqqGPPW/Y6wi?=
 =?us-ascii?Q?ypJhEfXAAJZB1ftUpj6CXwZEbk4aCyGEO/+WKEx8UjCEVhgq858X7GA5i7CI?=
 =?us-ascii?Q?p/5KN7/55A3n310MblpsHBTe5f7oAvjgAaYeCjB6h362UZ4OXX1gbx7g03Lf?=
 =?us-ascii?Q?OfKIhYOt+YeRHwrJi8ocUVe/pG/KruouQcT8+vRdBAQUumMlJIwGj7YsbZC9?=
 =?us-ascii?Q?V1y/bCEwfh6D0Ek9tXjypezUMN7F3w9S+XuCt+oa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: badc71da-07d8-4369-c615-08dcf26dfcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:48:58.9527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9w1rIto+ueIndKwiTGbaqoBq5UaijRF+ICDxNGFLNvXDm9sjM2esGnLWwdsYeQO12urDegchfm8YQ7sOUkT3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Thursday, October 17, 2024 10:02 PM
>=20
> +
> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> +		if (!amd_iommu_pasid_supported())
> +			return ERR_PTR(-EINVAL);
> +
> +		return do_iommu_domain_alloc(type, dev, flags,
> AMD_IOMMU_V2);
> +	}
> +
>  	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent ||
> user_data)
>  		return ERR_PTR(-EOPNOTSUPP);

swap the order and enhance above check to cover _PASID too.
