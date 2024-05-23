Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552A3C0B
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446582; cv=fail; b=Kt8DKHk9ZRt/FA7htgipZxIQ1X5dvAsjrh20shqruKvJ9d0KzGV2+F1XOa3bSyZMk8G+xfbkrQz1bR7OX/l3QK5Evbj3PJm1vrZybyzgV8X3vcyuws6dviEyXTm0WCizDYas9EViqCa/uJbkPx8KmO5GS1TAVdKYS4Pohk6fZ9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446582; c=relaxed/simple;
	bh=dHFG+6woMwkOZQOwUT3Whwvazsvg4ov+NBNC7tw0FZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcruAfk9Ra07KA2h7TmKIdWVDa8/rmSIgHOfSkFJ4tyqwOU8854AN/o84kohkUDkZLWMEdsv5W2eTNNlXHCJVeVyuqTxNwuE6DB3KdpVpwRgQkKA2k1hO4mFc19iYqoBD2yY+WZqHVd7/y3wTh+Q6qpq9GTnQmofNFkPnqWLET0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4A33cgZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4A33cgZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716446581; x=1747982581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dHFG+6woMwkOZQOwUT3Whwvazsvg4ov+NBNC7tw0FZ0=;
  b=l4A33cgZaGfHUqd+kScpuNt0C7O0cjPhXbSyhPV2vJ5kt4mlhVKc+CO/
   wjOGT0myQEle2EmUk4b2bmTijEupOdU2+V9/XCED72YCzhWEt6ojJrTXW
   Fjaw4hNKDjF2zDg6YCA+8miaPTBldpUQ+Rs4JOpkC34Cdmnmt8vK96lLG
   jzUaEqNZMinksdKR83uLEPbj8Kc7hnaAC7EKkDVFtC2urZ5RCNxKRaPps
   m1LcXWACtN0k06oQb3NQ1G3Nhl+Mipqej6SR/86lW+ejcF4jZMqRsAw5a
   H+y2g9iCTfM05+EnkONuIjh1GSgLnnLAN8NgQigBfmiswfh7bKvd4zGwK
   g==;
X-CSE-ConnectionGUID: G3UBxqOrQhmQSgekSRtYUg==
X-CSE-MsgGUID: Nsr5rtJ2QjOCwBgP6TS3Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12919243"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12919243"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:43:00 -0700
X-CSE-ConnectionGUID: lpTD6138TaaUaa0cU2613g==
X-CSE-MsgGUID: 6wfgNWSpTB+bDiz42CSxuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33669117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 23:43:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 23:42:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 23:42:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 23:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOUBqWYfKBcC5RFEG7EZQQ9Y1XA/AOnOVBIF3suNTZC7pKKThrILpMggYRyWZtLbFWZdo0MtI4Kwxc/dMTJrxMQU1HUJIFlEQuDCtKBavjdcI8yeSW4xrDaP39baSh+YIWfuQEMTP0JGbva387ryi6ddurJ+iJcwVBQI7uwF2eYz48YkK32DkHWDVbq/Fwd5yV+osTCpB/gtgHjZZPve+J5Z+msbCbElpgFgWy3rkon7WNI2qj07b6eqraKzm+l+N9MyyRg7UkJiNonyW+SXvEI7iyOXAdsQqTu5x45WAgxKWh0MRy0cR/VMSR9fAtJRjxVmTkg3Dqibs8xg0xfI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7mLJeBtWL9JNWbgK2GGTe5FQJoDznHCQ+l2eM2H5ws=;
 b=I8QQ4i3PbWYdNBr9cTqUNIdLGj137NWnl149Sw5OqfSlS7osENCDpxsmUiLv1NLRuvhqvY4K74TCR2PMZap5IdTC9wDOZN+cttXsFwHRmRNcyMhIr74jol4mDk9hHFo9ELr6XivO8+a5OLRqtZa2/WwrB80sAh9Q7V04AtvEK4UeE//rU/e8qDTPXXt408dglQo2pA7i37XGQsxZylBfJRdYA/+j6MBQoCkvV46wNHYh0lG1xzR3+XbmBVAxrbbaWEbEIqRpVLL0efi8AcuIuj8HptCGjD2ZEevK4/Wg4IjXmv6fqh3FlrjAE93+N4pcLuFv2JBKhCnxDGFXhtZLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Thu, 23 May
 2024 06:42:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:42:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6A
Date: Thu, 23 May 2024 06:42:56 +0000
Message-ID: <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
In-Reply-To: <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: 98a88f43-52ce-4e15-b863-08dc7af3948f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CCkGEdfbQrBfzL5Z6UFFwhgG5a7fIKhWFEZoWNpqzhd0KLAAdiHYIxV5+D+l?=
 =?us-ascii?Q?XmLFR3aqvksdVrIxl0Nt6IPy/s9cSRA2HPDILud4IJEkXLnDiRjIMCg4+/Kh?=
 =?us-ascii?Q?pBlqr05PDXLvNdr5RjpFgeyJr794qhzPWt3QIoFs67CD/Jym29N86Ztoc7Hb?=
 =?us-ascii?Q?avp6ZyGSBBEEoGhTWx1buzyrI5arj/YSFgJlHHzTp8QBC01A4PQOHs1VhNNK?=
 =?us-ascii?Q?4rfbl4zvoCGnau7tIWjwlertazW11S5qoYIIftGByomIFf3IfY13G0UKPuUk?=
 =?us-ascii?Q?MWWt3Yi4jGIEnF9WTe/Mcnm42m7WbBfdy/PUsaBAIoIK3Z1Dx8HFnWwyvul1?=
 =?us-ascii?Q?65L7bdKuImPm+yKicL17SZoVryNk1bp3slkmXOjdKQsAucTMnEbFmH+owoAX?=
 =?us-ascii?Q?BGmERHTfgRvtz7JBUak8b2IOiK70BIzbtXL2/nQImLkxkhHLDlAMndRlOK3H?=
 =?us-ascii?Q?MZbsCJAZ7k/AzENwEMZmj1jTWMg1N4SM+AjwnezmXYQ+QfXkN2GP2amGyEOn?=
 =?us-ascii?Q?e3nlF2tpYujx7GPQ/gB6ImpzA9mk2SlnUhIYzGNda6T8+NC/n9MOdif4bPcp?=
 =?us-ascii?Q?E8IQzPNDNm3W96Q0WlyYWG3KI1O7m39ycYUy8fXI6gByMOukQBV18B8SEpn8?=
 =?us-ascii?Q?fb0/4yeo4KAaZCWU1pQVypXjZ6e5DHaumvDBH2Sx8AmmhUQTOuMBW5Y7C+Z5?=
 =?us-ascii?Q?AHhZqXefIt38aAUxVtbtbe+cBok3QkniasYZttZERx82G7nLau9194TQ5iBM?=
 =?us-ascii?Q?1XGVoiGsA6DKJjNCpS1EDH7/HNCNxE7/z9YttJUvo2DXOgrlK1i7TYrK8Xdn?=
 =?us-ascii?Q?OZULLJQUNtHsdMrOEeUVCOw/74KtTOOIE69Cxo+Q88J7xhpDIKY3pASWZV+M?=
 =?us-ascii?Q?gMG4YT5+DdhpYKxGdG+i+1sJwSr/QQYchnqVAKJBtMYG6F2UeSAKYIFPrJ2q?=
 =?us-ascii?Q?LUDrosYDnlGX3/QuEj1FYBwtg55WDnIJFmCQwZSFWpwAzUo1YMhF6mEjnZeW?=
 =?us-ascii?Q?vjRawgyVrcOhKMq7a9Plqe1Yh6SZoHtxNNjhESYuRBTnTtLVObEQRw+iPq1k?=
 =?us-ascii?Q?gyVFSvvEqcnllU9Fw2EuqX2OhbWvOPmIadTtc5jfqQX0mad/9z4qrDbeaP+B?=
 =?us-ascii?Q?Ojz7Yy28R5B3F8FjA8IYAE7dIBX3okN/wASfIntsSoaCdZkkLt+RKaHrbvID?=
 =?us-ascii?Q?4/A5LYFJzW+WAsGqJgydEJsP3uPCrDkWA4LcRhT6yI9sL2j0BDBQL4AxvXEi?=
 =?us-ascii?Q?GANRWQjCw+gb8ve7mYyL2rS3XZ5WkexJNaab0lHT+YwjJbQc9G6qgIWlNnUR?=
 =?us-ascii?Q?28bNFiODw69tFEl0vBUl/FR1H+p9VXAkoP7QVgGpI/5dqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xh8sWaHJ8gEf7KJqMIBRdIUZkwck5c0EhoSYlTtflvH2hia33lw5UPxfRVAp?=
 =?us-ascii?Q?Zxd0pKmP9T9fnBNKxbK4AjLIcLSPai3atHfOMWwYXhLWbqsbixevEXUzYcy8?=
 =?us-ascii?Q?Q7BTYgw67OdtS2FkXzGrAw8GAc7TQYPBaFmm+IRoR3GBztjntxdmfQ0k4hsU?=
 =?us-ascii?Q?gW01R/TP6g8HZnSQw3mg/ey31F1yo2rPDnXKUu1XCL3uU/h8Gv0Xi0F2sAc0?=
 =?us-ascii?Q?uFaE3ud5uRk5na3ZPTfsgioRxSoW49d2mfCzaDTdfynpogB5NwbdIa78xcUz?=
 =?us-ascii?Q?dV/vcty2ZM/8klOTmDjJmdzCF/AyN+XNzkwuSCXFOjzD8Ml+K6PbeGDVbmGi?=
 =?us-ascii?Q?46wVXHcsZLGoeqtoqHk4R/oQfh34WdQg0DkmfrjInSvTR3IJLB/TUpMDuAdC?=
 =?us-ascii?Q?DuLtIUQpUmP/oDG7fXuUSiyUNt8bGhp21mgLC50gpxZ9ZbAb3w7WHaSPns1N?=
 =?us-ascii?Q?1JwWS3+s6keK6fNZmO3S8qGA0QRX8eQmU5hDlgMRFufELr7m9PNe9dLSW6C8?=
 =?us-ascii?Q?daRnQadCcqomH6pDzi+t4e8zSDu7rAjc3zIv+iDe/FDQkC89ZPKzb6sOePVF?=
 =?us-ascii?Q?m63+eyR/BrSCOzDRNrX6/0EuM/KwhBEIVGSBrYU3y1XqeV8dXg6EYMqpcL+d?=
 =?us-ascii?Q?TgdMYvQO2VMfrQQfnbtOA2gEYRTUyo22VKPyFmgCJKjjqceWTzNqnLED5E8n?=
 =?us-ascii?Q?0jlZOi1wXQJnEWphtU9mZob2etVg7Yf8pEUx7a+GT8YZwTYUCAcUD9lMYlJ3?=
 =?us-ascii?Q?1w5lKaGKORXui+sohIIV6Ybn6iNK1ZTmWhyhZ16PJjr3tCQ5gy/9W3+FXRrT?=
 =?us-ascii?Q?D7O2l/4zprOFZTYkXxup0/fI1Vd1ukL7R6zCh9noaeWCj4E1u2LwpgE4FCbe?=
 =?us-ascii?Q?9cgNYAH4OAnpbzD+UgUfjTpjhHCaYkJseC4cT9WQJhVUufav33H61Ed9tcN6?=
 =?us-ascii?Q?8vnmvepy+7bKfdnGqQQ6lZpNGTbhCl7xtd/zSg7E6/lVHU24IvXgDMAj7xlS?=
 =?us-ascii?Q?m+7gPb+q8md2I3IREOSuCXN9WYCOkO12R6PesaylxH2jzpgXOp6iR3CnXcHg?=
 =?us-ascii?Q?k9GukL7r+jQVJ8LDiWVThQZImfCKpnWhvhPsfyngyuVh+DDbsPNc1UCC2cRb?=
 =?us-ascii?Q?wOtmezP654ui/P4hR25oFMIkpEMKpZNE8Pu7UH2V6lTqzELnGvm+DNeFniy+?=
 =?us-ascii?Q?lFZRO7rTTTVDXumX6kc+ydO+visN5/aQp0eAVxy7uUuSBTvQTHyxeLG7irQP?=
 =?us-ascii?Q?4R0r2bIFYFiDx4uJVmIj5VcvVBrT4pd81x/1/ev5wCEcdpHCWKA9TIDjY0Av?=
 =?us-ascii?Q?+otUsbPmHdmN1dz6rVOzgfQxGMabq72HKWOHiu+7KlU4/s3mmj4aQ5eQmQXk?=
 =?us-ascii?Q?4Wzu6kTPkO/9u2vG2GN1rnIqm4oIszfPqkbxJ/Yz6tuDqhYtt/aXQPQIK0jv?=
 =?us-ascii?Q?tDH3j5C00xTc++lDcH0yAN+L9s4PmGN/cddMSzVK4dMEE19OClJDatkui0P8?=
 =?us-ascii?Q?AzoMFCbIGdodNN72FF3kI+cLVztjQLW09CHMXM83ecAz3G4tdlVD4nlQV+ri?=
 =?us-ascii?Q?Bn9gMhbBS7Y4Yhxs3yfWrceReEIL3NzHWBY2HATr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a88f43-52ce-4e15-b863-08dc7af3948f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:42:56.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFKbI1VvUj3TaNZuw0bPxMFin/rX7/7ZGksHRQndwIACUDzvx5T6UDnm6pKHT0yn04RIbCCZb8RekOfB7xbUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 13, 2024 11:47 AM
>=20
> Introduce a new ioctl to set a per-viommu device virtual id that should b=
e
> linked to the physical device id (or just a struct device pointer).
>=20
> Since a viommu (user space IOMMU instance) can have multiple devices

this is true...

> while
> it's not ideal to confine a device to one single user space IOMMU instanc=
e
> either, these two shouldn't just do a 1:1 mapping. Add two xarrays in=20

...but why would one device link to multiple viommu instances?

Or is it referring to Tegra194 as arm-smmu-nvidia.c tries to support?

In any case a real example might be useful as this may not be a given
knowledge to all folks.

btw there is a check in the following code:

+	if (viommu->iommu_dev !=3D idev->dev->iommu->iommu_dev) {
+		rc =3D -EINVAL;
+		goto out_put_viommu;
+	}

I vaguely remember an earlier discussion about multiple vSMMU instances
following the physical SMMU topology, but don't quite recall the exact
reason.

What is the actual technical obstacle prohibiting one to put multiple
VCMDQ's from different SMMU's into one vIOMMU instance?
