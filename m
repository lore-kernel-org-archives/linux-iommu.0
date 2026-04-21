Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C7347520
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754751; cv=fail; b=RoAqe53FBQicVdciqG+aKo6h3yoh5oGBnJ0lD95rriVQTUq+vpKCgMdSHA7j/Qbg/+CR8KPQxSnegvP4MZGec2hu6GhxXq4XA28ogCMJVMUNhnedgiJlcr0u4FOQHoosny/b4he8csa/p1CEl6ODgbM4nHmL66WKpKgl7qaHtRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754751; c=relaxed/simple;
	bh=9nDH43znq1A4XBPChik7sHeWlRx6qK/D3ouLSSCIzpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VLLtVjGWCAH3zef1Z+cJ7ZtNugCwlK+63JWFy8C1ebFvZVQ8rZlh6zLhVKqvY1Pe98Tl/NHPPkGkuebvHfA8raOoAytdXGRLbaxYL7AD2VvPTa0PXLtqHOUP5Y2M2FEMwg9B+7Zcl4m8ml2M25QUxiwaE7m2L2Y6ucSQtXNUkWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXZO6Ehn; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXZO6Ehn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776754751; x=1808290751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9nDH43znq1A4XBPChik7sHeWlRx6qK/D3ouLSSCIzpo=;
  b=QXZO6EhnCQQRp13NXGA8JONkLn6L0eSwkYR8V0bdEMlVb+IWMNy7N3RZ
   oqvQVPfQ5iEll+R97J0xCJkEvRo9n+Cso8knaR5MufXAB1hkRp8MX5uPt
   dFGqWPLetq5k9JoaYhW8dd76HprH/P2IFQmjNE6R2bohUcpxhpi6bpvNg
   XpDatrBg3AfDBcU8J4d2EtSk28Ax9YwqsYTgtLD1TNy98a1c3YqOd/8+4
   Fny6m1xWiTbHXxIPpLYVvMJsl4x+1tLNcJf04d/yzmgNQg8b12Q8LudQw
   alBrCz1kkTEaTxUYLLf7HHD8JtGxVNi/7Btc7ayg3i6C5pi1Jcu0/u8zZ
   g==;
X-CSE-ConnectionGUID: ZRGeQyBoTbiBz5rYw3uApQ==
X-CSE-MsgGUID: E0pcS+AoQtubK6SREdBx4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81293312"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="81293312"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:59:01 -0700
X-CSE-ConnectionGUID: mn50Ll8NQ664P1Z3epB5Mg==
X-CSE-MsgGUID: 5tZYGTraR++uZvWDBTg8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="225463269"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:59:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 23:59:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 23:59:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 23:58:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhHUEB73modvpXvQfrZ1agrl2T5IyOnaXqyqc/Wtm5gosjy/Qv1NmOb5SGs0rGEEyQWbFf0nI2MeNHFKvZDd6hsOw9RPrSfCmWJ2ZocO+xQVdCQxrmhCP0pfagikKhxajUdrLJA2QfaSeXV33l2GEniMG0OjD8OPjGyRSw8FNtCC9hm1AK1ck3meFyERZwJvDsFJ6RrVkcb/NJxEf97ndu9zXsgalz/O/ABESgGHd/fxeBKbHGCahKqnzemiFuzxPldTrHJnwS2LjoCyE0ZlNKpXlNmf9CyRGzAkECzhmiTYt0/lHlQZW5egNidqS6LNHS6l9EEhH8cL3e7wwyET5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nDH43znq1A4XBPChik7sHeWlRx6qK/D3ouLSSCIzpo=;
 b=gkdxECk6XSNIjbfCX11DyYXL9w4xRACuBl6OnBuCLMQEOzZRohBgb3rkiBvU/usuwG4m8cjHnYGU7/nrA0nHWifUIgbzcmDm9yEkuFpVgPRM1j+Z6R83jhSZ/MN78VwXXGzooHLBGxXQJpXRs0OK8DMPTu9f9TJMWQzYYi4h6g1G/CL0dT79+09CDHvbsko+AZHnZ7zr7Mb8rhqRMLa5bushv1evs6zYiFE+Kx7MRr7y6HFcKCiYG2qLkjCWc0oPUbWp3MVITfjmUsdEehfXi34vI/+nBSIH1sDfUoWa0F2LioCSK1ZrJCvYGm2dqQ+Ln5AJFz5XXhEi7qmSjRV7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 06:58:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:58:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHcxsd+fSZdlW/fuEiEW20N2tsP4rXi8owQgADmqQCABVF+MA==
Date: Tue, 21 Apr 2026 06:58:56 +0000
Message-ID: <BN9PR11MB5276A8A765CAAD7A5C3B20AD8C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeKpxLiykT8O4k1X@Asurada-Nvidia>
In-Reply-To: <aeKpxLiykT8O4k1X@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5957:EE_
x-ms-office365-filtering-correlation-id: 1e7cec86-f3cb-4476-1137-08de9f737505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: Ww7cA3tbFioJuqpbpsKB1q5MhFRFfjg8nd5APvPKNp7TZQD7mxOgLuR5oLM/DXOBiYFBJVnaZUW55C5ztYV/NwFbj/hmDkjONHaLpnp+41FBcsBiAciKIpxskuic1cR5tBOv1mhyLJF06D0Iv1rplAORX4oYeJsMAOV5sOiuE2um0HJvfugVeptgBPjDma+/EMNT0S9IGB87WvpRwdjSMqpmc0rShEIz9+vG10JfvzfE1FSeyva0WYG39VcBEkKSuVPR0Kv9wyJtAjSAUwXtymS4lkcYFFwHjTplWm7piZmnwHBcE4txdCSbcPtydWlLjZS9VSaR/oresqp8oo80YkekjA62KVc0H3wWQ2qV3IgYD04MykXN9KKGR8Ans77+ASdZlUs640h8M2yr90GSydV3DiQaS51/x70LB7YOo51qs3lTkK4krdRChkx1A234UWhTwtnlGwphVPykWvzm+jPkwdQ0gcidxp8lq8y+4/DnnWuD6ZWejhOaMWTVlja/XQY8MjJpYkQ3wFlBytBoy21Q0GbshQiWjxXJmnZCY/10QLlzxClT1Purvw2Fo+DvoynDIUce1GVvdKTaCSpcKAQdfih0dfdMxjOq3+xVtin7/r3A8/MmNhIBQupMd6Rvg2OsD0OPsXkHXqtZpAakGpYpFTblX6mJwBKdgS2Ju2yKPmdfQc6Quo3KE7eJg4QWmZw1hyCnifUivyZQr+rvsRIqV5xx3FkX5W+rof1rlqWOa0iAjkIsFc+teVZO9cl3sUpd6ahmfPDUmf+bRJNoT4pZ8jXAkEStHkUJ9y0isV4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ef5FTgYUoeHRfaLU1QYPOC8Z/qaIuvYYBG7Sktnh84+H3g13hEfD3gZQxCrI?=
 =?us-ascii?Q?YOIbqSuYsNgA8w0V2daKKiCznm9dEWDJXTX6PCKEf+xoDEsaD6Pt6KgV0ZuU?=
 =?us-ascii?Q?zqCl9yCZ+UYP+RKf1yO6yqodVY0b+t2qoadCk332j4TUkePIveKE+fz++Cpi?=
 =?us-ascii?Q?88APllVqopJM5XMzHcFEdbRzb/3A0ZDMGZmjTawDmZWU1HbatiaDzwBBDlfc?=
 =?us-ascii?Q?bV4qozLjqsn7hi4flMqiHUpoSLI3wRLeqMgQbdV4zIleRjrxbEdE4Myz0LbM?=
 =?us-ascii?Q?v23Psd3htzPKj8+WqIXOmHcLktN2GpGLPV//Tuth34RnT5VR6kjSNOSkhS0r?=
 =?us-ascii?Q?eSS9Fw5Gyc2Rsykxsm2iy8806JAsUXLGINT2iletM8NXveMxZBaxbRy+THN+?=
 =?us-ascii?Q?C+XnRXq42uvPMPwu0pyN29h2NtGrsKXTM8qLOnOkqENVU9P+OZdXcxWOWoWY?=
 =?us-ascii?Q?tsPxwcc5KQ1eZrRMQABUI4MGHLx2qh3OthYhfFXRd/dHllkO25FYqa0b7eSX?=
 =?us-ascii?Q?ow/Mtr2dGbOnGNZpNtYEpWvO28KIUrBWdjgmbc4iTIGGpQi1D7FLa/O97r/c?=
 =?us-ascii?Q?eKKvNZVdUIlJ3snAxY65WoP6adtVhTnjmVgzBWWRRRLhvC6QkVsHKe9uwrwk?=
 =?us-ascii?Q?qfeZiY97xh4cHtD8B3BZIG4+FbZmpIck9bKuzfyvwjABNv6R/xERJbvUSV2x?=
 =?us-ascii?Q?dt9RjThI7StpjtpY1Dq3+OS0OkIyyawBJal9C9j6egH8PnsFcC9rEVpWDe+v?=
 =?us-ascii?Q?RoDBiJSTpFogmqw1QmErsjbeSLkW27mzf8TjGedKLcakLObJavjDRIvYJe/d?=
 =?us-ascii?Q?aoPwlg6aKPa4tXhCIHJ0Di/q1WTp+813WymedFoQg7TYo+qVoavLkO0kcAu5?=
 =?us-ascii?Q?9Ci6V3BEw5WECvJq6LC6ug6fx8mMaoOx3jLhA6m4cINHIHw67mqMzIi8hLfU?=
 =?us-ascii?Q?hUoeblg/N22m1+O6zpc3sO3nTd9isp/1FaDp0bks5aafP6kd+2TCwfIP7AqT?=
 =?us-ascii?Q?OOlVoC2jfKjlXN0QQF645N6fqpMdbqmC+X/Ii297MdCh7aJJrSYX6C1rEnXw?=
 =?us-ascii?Q?yYstbzeb2uaXWoxuuUGPT+EsjDSn1P9vlvenOiXWkemIiklJCfKWxFPpBRlK?=
 =?us-ascii?Q?xN3ENkwE4M/cH7V4q3zuTMJZ7L4M2g3DrGA2+QlIC66nWcq99gWahLNAbfjV?=
 =?us-ascii?Q?ouwSNoIa/fgibtogGW2ndFxXkhxA58zEZddHCVysaR833AJfuRWNwqTLF3Ce?=
 =?us-ascii?Q?4IX5m4jooqq7ms1SXWXUM6eSeRSJg34JG82FyAhatqUn1+oHJ8Z4o/bsRl6V?=
 =?us-ascii?Q?GUaseAqoQDUUKWoGzhwg2ZfzgtCbuNBmBGnF3L3zYyroquH61Zg7f4E18Db2?=
 =?us-ascii?Q?7buoOWanKfItcW+bb8MnPyAS3FXzz4+laRCIex02SFxdlGqHkv1iQ9akkIPn?=
 =?us-ascii?Q?qt7ocV6uO06rlAdbLbnBRVWyjusC8RYORk5vOLf5gyAnRL/vNE7N9H6OUsZp?=
 =?us-ascii?Q?007d+3YRalcA5Clb4ln4zBaaC8fOhWbvj1BrttgzU6gffS9XsFH4pw1unKDU?=
 =?us-ascii?Q?0stsLnm2QmM3kYF1y2902lHvtgyxqCZimnTuktx/uB30KWyzVEDXQPpDAWTm?=
 =?us-ascii?Q?uWWxBGpTMnnDeEE2xI4gqIta34+hDssr8ECt6X/u7kLBkyU4cj5AW2oq7U77?=
 =?us-ascii?Q?9wsaXpoBUzTLijqA0rV1wRmGh/MAvbhb+u6bL6ijnZf6DCP7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ut1ItZz3K7GaYj+aeMblj87yF7ujJY70wEzficig/5YLbGZ8hBsTJ5FU2xbMUxemEioehr2OREGpMDHgwcnywgiuT5WFGSSE0QYup+EHGFOka16fQ/Spp9O4oyJ3XRVIyPcsqz4hDLmGZI3up14vpRygaBd6NuwZhqtZ99k3veiRTB1lsAtjDRqKcqC3sC+15QLreRgj7+kncxT24xRlwKnh1qNRF2APZr8eAQBSpa72ekatsEpwzdcDZpjhTP7IVrGaMtXjLhbhAK31KtahtPvaexHUprC0nUDBXBJVIw0EcbhDTFB53gV9GJKKde1z+JzzbLz+IpUOXDrmCpajOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7cec86-f3cb-4476-1137-08de9f737505
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 06:58:56.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHt2X9KZrViLNYRhia5P8EAufc+5TDnCykxHRbxk+lmODIiKPsCu5K/1eyCZuZmE9hVt7+rXmWup+e+twFiDqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 18, 2026 5:45 AM
>=20
> On Fri, Apr 17, 2026 at 08:24:27AM +0000, Tian, Kevin wrote:
> > the last one is trivial that goto and guard() shouldn't be mixed in one
> > function according to the cleanup guidelines.
>=20
> I don't think this is mixing. The guard is protecting the entire
> routine including those goto paths. So there isn't any goto path
> that is outside the mutex.
>=20

Here is what cleanup.h says:

 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.
