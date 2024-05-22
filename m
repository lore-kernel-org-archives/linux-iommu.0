Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E22E631
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421775; cv=fail; b=Xlg4/O2350kk7pyURORy1niFSEcq2//OXMPIGVcQjqjNq2geopls+m8j6nX5tr8QFVGly+f3ElQ0tp+FmNvxfID9LPk/Ntn9p79fF191c8y8tiYH3utvv/YKfBXXfcDMsIE8x/iVcisRXJdINxqkrkV0XqmHdXu7+oMjPIN0Qr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421775; c=relaxed/simple;
	bh=QV9DbTdu6psPgdtqf+Fz3Ssk4itHYUnolOYqsyMkWVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sruFXJN4cAdvkbu9WgYMM4CP4hd+VSAZr+QyS6Od9m87FAPqq5EjCYDID4xCwL6cYC1SD13PPkFhPRYh9BeSYZp+eSnDNC+XfeActuzA0UIr1hOH5jrppGSFIAoqy9QS2zSCRbPQSt8u7NQ44jaN1SN96eK2ZWnByuo6yldsIm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnBN9w63; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnBN9w63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716421773; x=1747957773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QV9DbTdu6psPgdtqf+Fz3Ssk4itHYUnolOYqsyMkWVw=;
  b=LnBN9w63NJP0mkPHfeHCB3ab4M98b16Qx4liv321Gl8fQF14+KbJXh9v
   ZlXx2ZeabO2A6dJmhIolmXZf5XpMqqXq7z3GSi0xl/w8xgaly7xXo9/79
   /4Xak2ZcicMbUpjT17P/bgo8rc27c6ebHdckSej0el8oGXyMHUFQeuQ8d
   zuVD+/M1KwKIdgkstiXgJYQe8BoTFzsBGzlmkV2+QY30wCJIwbH5ce8XC
   yzDn9LeB77E2cmHCxUm3mwWLjlfitpq77IlXbHkYzlIy/jKZQdR5BB+I3
   EYlMGDl8jeuAtyHZwkZTFPt/79KeiPfgJDWbg6FAL+JHtpL5NqsAp7X5V
   Q==;
X-CSE-ConnectionGUID: oL8f3pTcTFaOCEiWSEPXtg==
X-CSE-MsgGUID: u4+re/DUSE+xuAWXLlVzTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23375786"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23375786"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:49:32 -0700
X-CSE-ConnectionGUID: QMOWTZZWQTaESFwY0JxQXA==
X-CSE-MsgGUID: tHFjFqa5QK+6JzV4OP2/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37848814"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 16:49:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 16:49:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 16:49:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 16:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ill5xYZzo2dieMVWwrHH7cVHQH+YAj6uGnBiLCIQkXuG1faJHwyIf/gbcL1AeAJKD9gNxq0Gf3/znekslMcHFkofkomhAEa/jMKMNvNCXaufmIRF0gqdcz4FHp4vVwJbr9UONOS6iGxGY0Hhl2QcMaOkt9SBLtgKwT3iMD/QYKKr1L/3eI26OGS0C6tU7wq1D1LKSza/eOtAHEY6bXn2VrSm99A/OOEXpjNQxB/aiYNZLZAg3iBSCi04tT/AAshkoOTgL95zAYsQKCFM42AhbJsDlQDL++KKAEnk+fHx8WU0Mcp/N0ocgvmAnWg+ikHMjm1mtgiQgNGNZQV9KqnyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k23tnYUPm+ZzXP8lzZqmGKNXHfUGg5UxtzQVMekvEms=;
 b=khFAPV91rMpjKVI0MACpHyf/FT0C3UPkrJBF41Z2DjzreHNXvp56XHRq8JwNLXm2Vpe+jx0swrzDkmjHAK9gLgmjzkHBJwpFrcSHksbipJcmAapdBddBRTOb7lD0oqpQ7q5wVT/gZ9YrJcmN6JydMwRlZOiN8PVMrZdWexP6jXbRIxHXjWuMBoc4gdI/1ZM+cau37yi3zg4Ix4jqJLW5IyTMWA7ubbXT0JFJjCdqAB23x3YfrCsB+CWw8GK8NRvAx6tb0jGTD877zZ9fK2yBrBtNOCUHpnJON88aIV/AWN8tMJbw/6TXYDIw3r8Bvr4wzsKFLTYlS4/Nafwn8L4gqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 23:49:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 23:49:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, jiangkunkun
	<jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Topic: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Index: AQHamwTEg+Pdwp5qm0CVG/YUDoVRsrGi+PcwgAB6I4CAAJwUwA==
Date: Wed, 22 May 2024 23:49:24 +0000
Message-ID: <BN9PR11MB5276F057023FFE6E314578938CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d08fcd087e9541a2a77733ec52ff931a@huawei.com>
In-Reply-To: <d08fcd087e9541a2a77733ec52ff931a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: bf4a3f6f-7130-4e0a-f6b9-08dc7ab9cf96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?0z30GPExcKGaZOXNHHjjpzlKqjXbx4oOmYcIYMoXmKv3JirsmQ85McewWHhJ?=
 =?us-ascii?Q?WA+LkkM4MIWJ9plN6UvaB1tT95w5XzYa31mldfVMe5gEEqAnhhdZCMBctU1A?=
 =?us-ascii?Q?eWihWaYnpWu7u1288AoCQGsOpFmunF2SZlCJ2HNnQqddZLt906vzekhC+qkh?=
 =?us-ascii?Q?3UeBSAbyiwEu9mWXBeDIuwg3wljwHhFH3OEbBW0RJETl37fKWqvtktD6Y+J6?=
 =?us-ascii?Q?qNdrnXbnF7b6XgZxOicEzdFE+2/1wlzne1VoiHoOBGt0S4Rpr4s2l/xSvw+3?=
 =?us-ascii?Q?UJcY/1MdHQWgx25+/5+AJN8MtZWZ6JZk4wZcYfRGBE77R9e9vGOvEZDbJdSb?=
 =?us-ascii?Q?XyJEv8AX8P137dvTZQS68NUqHG4v7+J6lZolSN3T1MjSUT91F47DPvcBiZAb?=
 =?us-ascii?Q?k1WDNUOSsmsV6Y8+7/Maf4NQQi3580SfX26G1MbtmFffY7cBGsPA3xIs0Skp?=
 =?us-ascii?Q?vAgMuCEYPjJQw0+7+eahmMM5Imp/PQcxzzys5pOErpw/tjIGftSzarjtM8RS?=
 =?us-ascii?Q?l56l5Y5/Z/tlF1tUxei9ZAW8hjYZv4jb0wpyTQE0g6W7jqi0hza4D+WV7x9G?=
 =?us-ascii?Q?XpeMo+xbz/b1/UC39fNowcpAdcEl7xQnjTDiQ2+AGqBnhI2bEAf7KKGP0rOa?=
 =?us-ascii?Q?bcwdIi5NHx7TG6frjWoxDJUD71A9yQdoHrUi6rU1ImaTA/dhfJ6+QlXlk2nu?=
 =?us-ascii?Q?tqARhoTBk7PuKyndS2uNciW+CM86qZD7SZznR7XpWewnNOSfypm6zk/0gcd1?=
 =?us-ascii?Q?iU/jev/OMN1QE1mudgTuZ63hXhLkEbbWttnwS7roJk9DSbUEkzqo7FvIDVWM?=
 =?us-ascii?Q?cBFoQ/Bmdjyqw5hcuefCdOmLgpQ9o5mbVsba6N1T+xF83bYXrHh+2Kgm03ZK?=
 =?us-ascii?Q?T4D0yvryl5w03VEntyzP9rIWsuhmP2kGUif77kSiqy08Ot+ejQkTvr/h3Dhy?=
 =?us-ascii?Q?FmJO1m8JcLvcLs6ZbB1DfhWf3Asf1U6uPqOgi9YPhb+TU5fA6qMTVCkFdwSp?=
 =?us-ascii?Q?pWXPBUt8jcqvs8kiva/BJDTt9aDjf9RKEwsFtFclrfRwGlmAl6y237NMsuDV?=
 =?us-ascii?Q?XMohtxP6sEak5sepVSrp1dQGfAzzMxr/BAf3pPnFwQA6SARFINfeoO8DwoJD?=
 =?us-ascii?Q?FpYaYd4WXQI9bgqGUJeCzamc5GcVDpN1LBacd5thGDgjwxtZsUv/rUSPhpCe?=
 =?us-ascii?Q?WEKa/qpPBLpA3+w/21FoPlrqcMh5lyGbQ2jp6jLdN8JhkDWrT+6+mRaQ8icF?=
 =?us-ascii?Q?Xh7KhpCAmZSnPRoBipke5KW7JHCdfWkSrkbaOG2jjw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z7cFirE5xGIpAIDexRV2ojGd082uSwd3xsS4PdR/t3zOMF1Z9T4rDB9hTYdO?=
 =?us-ascii?Q?DRcGnRw4TTDo90WuozH3q3qUuBoActxuI4FRuT5AbrHSkQgQJ9RXxkXloqNV?=
 =?us-ascii?Q?MfypqRhqVHrF5rgOdbD+RleYhuGz35AXksAq8+SpuEYyzmuHrKHIZxdMDGSA?=
 =?us-ascii?Q?1JyvfR4WcKp9ro2X3rQYL9Hjw17aTVbvHpETSrPgGAQJ/pNz/L005t/rSIUq?=
 =?us-ascii?Q?qkgWJ9F0ZylmvIkSbY3wG+eyxztL211Z9312b3M19HEfwzYdOXrw12FJSbLl?=
 =?us-ascii?Q?cJzcyK4hBsy+T1YiVfxtQhibFaiYpHqIQ3oDUEEhqeHGoMz7cWxYYetEKMbX?=
 =?us-ascii?Q?WOvw9CoxVVJPKgaDlJUgWHH8gUlVumBxYau1xcIgrmXWbsjV7st/dQPWhOuB?=
 =?us-ascii?Q?Ue3pifzj/vQyzse4X/8ejAlPeQeSQtY2fxuFBJ59TRTceRQ98gQU4H+Jr4UF?=
 =?us-ascii?Q?5rfBfpXTFZsyW3nMmbz8OLf0ZXQHKBI3R7+fOu/JSiV3XL0Cn75NG702PSBu?=
 =?us-ascii?Q?JNzoGT6/PAnyEFl+kTdB/7QobOwuyAPJ1cCevAjCPyk1TSf/POvhrfAytkOa?=
 =?us-ascii?Q?wXoocWUjjjIMzUibX7txZksr9IO80fq0J6WGvFNK4WZUcPB2O5UgwlcEq2Sc?=
 =?us-ascii?Q?GLeZvibHT4x2fB9rowIc++RwkDcJHR6ZAk9G0Osxj3zUMrxiobClCDsPg2RC?=
 =?us-ascii?Q?q2Gou/Dcu6nopeiVJoI2KJphlcctzbxFwl1uX7dbhZXjOVJMO380u/jsn1Zw?=
 =?us-ascii?Q?CCuVNARm/tiknZIMyb03e4Z2Km3HSM7tmq60Sw/1f1bZOXGh37OltQuEZVJY?=
 =?us-ascii?Q?3jlfW/Z66+8JVjOmDsPzTt1UDMr2JtpR+qFLcGzGM1AqeuRrmtDi0yrOEVvn?=
 =?us-ascii?Q?vp6z26sxa4wk1apnyufoCkhW7x9wCBwu6d20znt0P41XXHkrVjQoZTjlxODm?=
 =?us-ascii?Q?bOJHIvdMnBpQ5aLXY4zHv7KgRfCEU1h1pUdAxIs+SeW7MbLWgpjBrnqcV5UA?=
 =?us-ascii?Q?NH5Ku3Bat41//4KiErbvt8lE0ksTUnr+BV5rvFQN87mDNSaISovrNos+YO0M?=
 =?us-ascii?Q?G184bNOv9KGzNjeTOqAf0xL86PJJa/m/Ru75HxrSD7dNhnGgxuXSjdscuP+2?=
 =?us-ascii?Q?6f45a2+Ni0vsuP2ipha3pC3yyOiFdCjC1Ozn5/CZm/9AJRB2zqvwJyv5n9dk?=
 =?us-ascii?Q?KgWcdtNj3lY9Dn7u+qCaTCAtQw3IbFd0aBh/kLCIBKPbyDoFLrfdrKReE9DR?=
 =?us-ascii?Q?gmigwT4dFoFK9AfjZHCKzGDrTfgl2+UlaWxscMRkwF1M83p8UJ/dCSnsSSNd?=
 =?us-ascii?Q?/UbMSgJb4oxGX4YDicXQtjlVfyND3hEGXyjAAd3VDxKdHasjNaZ0SmeF3gsZ?=
 =?us-ascii?Q?4X/Opc04rtHYGUFTnZhJpPAwz/GLTudL/pZcafIe1qzMmvyKo2c1XS33xay2?=
 =?us-ascii?Q?da1t3mpj5Pvz1KgSbghjiuuIYCCZk+lXTK00C2ilVNU+60k0d66FQqzYCP5T?=
 =?us-ascii?Q?DVH2ci8M0/Oe3YL/oYUF0/J0tGX4+lF2CYvT1vTtyHvqjFQxbY24qIrKzu1M?=
 =?us-ascii?Q?SFqzzupkwz+M6wG2zR21hrE4xFZoNCfyQ/CmNiUX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4a3f6f-7130-4e0a-f6b9-08dc7ab9cf96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 23:49:24.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCx9ssVMZNRdGe1G6PAsDiKZMivpiZmB9wkXcRU2HajM2YetMDvPv+wIEqmGADNjattJdncox8pJiequANWDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

> From: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
>=20
> > -----Original Message-----
> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Wednesday, May 22, 2024 8:16 AM
> > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> > iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> > jgg@nvidia.com; ryan.roberts@arm.com; nicolinc@nvidia.com;
> > mshavit@google.com; eric.auger@redhat.com;
> joao.m.martins@oracle.com;
> > jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> > <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> > Subject: RE: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty
> tracking
> > in domain alloc
> >
> > > From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Sent: Tuesday, April 30, 2024 9:43 PM
> > >
> > > @@ -2422,31 +2425,32 @@ static int arm_smmu_domain_finalise(struct
> > > arm_smmu_domain *smmu_domain,
> > >  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> > >  		smmu_domain->stage =3D ARM_SMMU_DOMAIN_S1;
> > >
> > > +	pgtbl_cfg =3D (struct io_pgtable_cfg) {
> > > +		.pgsize_bitmap	=3D smmu->pgsize_bitmap,
> > > +		.coherent_walk	=3D smmu->features &
> > > ARM_SMMU_FEAT_COHERENCY,
> > > +		.tlb		=3D &arm_smmu_flush_ops,
> > > +		.iommu_dev	=3D smmu->dev,
> > > +	};
> > > +
> > >  	switch (smmu_domain->stage) {
> > >  	case ARM_SMMU_DOMAIN_S1:
> > > -		ias =3D (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> > > -		ias =3D min_t(unsigned long, ias, VA_BITS);
> > > -		oas =3D smmu->ias;
> > > +		unsigned long ias =3D (smmu->features &
> > > +				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
> > > +		pgtbl_cfg.ias =3D min_t(unsigned long, ias, VA_BITS);
> > > +		pgtbl_cfg.oas =3D smmu->ias;
> > > +		if (enable_dirty)
> > > +			pgtbl_cfg.quirks |=3D IO_PGTABLE_QUIRK_ARM_HD;
> >
> > why is dirty tracking considered as a quirk?
>=20
> Yes, that is a bit unconventional. But this was discussed earlier and in
> SMMUv3
> driver the word "quirk" is considered in the broadest sense and there are
> precedent for this in the driver already.
>=20
> From Robin:
>=20
> "Indeed these features aren't decorative grooves on a piece of furniture,
> but in the case of io-pgtable we're merely using "quirk" in its broadest
> sense to imply something that differs from the baseline default
> behaviour - ARM_MTK_EXT, ARM_TTBR1 and ARM_OUTER_WBWA (or
> whatever it's
> called this week) are all just indicating extra hardware features
> entirely comparable to HTTU;..."
>=20
> https://lore.kernel.org/linux-iommu/5ada4a8b-8852-f83c-040a-
> 9ef5dac51de2@arm.com/
>=20

I see.
