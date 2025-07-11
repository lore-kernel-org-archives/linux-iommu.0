Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607770814
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203599; cv=fail; b=rWjdSc6a1fXUCqPiaK7mYowHawluNyXXJpiUVKnnyIArUsOzxOFh+oRzOvJocmuwKe7RfOp4KhNnOGHLdGdrn5i3VhOUubdb5Hh0M9OL2vVl/bA6ZLizyelD9/BuH+j0+hT4aAjKfOEeKwbxhJOx225EPTLOpVMwqxZylXUWYxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203599; c=relaxed/simple;
	bh=YAMsd8yQ4uNKrFTNC2u47QbcdcJZN0+26C0Dwdy6R0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbVvzBUyDyap92cCGIdR/85BkSf1uCkhQHKCzw8inbpbcxa7x4RacdT4rRvUpjDpkp5YAgXD0R/20pQTxWCmJv9mpDIL+MWzM1lJOcWXVb75/t3xJj69k7LJJoql3G09fNV7LwCMYA5R+trCvny1q7pOnr3KQ/e9/GVThF62bh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+A3gVZ0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+A3gVZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752203598; x=1783739598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YAMsd8yQ4uNKrFTNC2u47QbcdcJZN0+26C0Dwdy6R0Y=;
  b=V+A3gVZ0NdBBNl8f75y9y9AGGYV1mZi3tbZg439flVoQrTewb+tOWo1k
   vaUYh1W0m3IscZUKDl2EYIpyu1wvly45y4dfjhX3uaaWADBTG5oVzoKu2
   2pDHyH196fumIvV24c5ZO/9pLANLs0X3LB++PTgykDZlJBJAi2u2ntjmk
   IENV5NR1tMXpo6F4ddN3uZYqSmyEoqL4S3kscmvCq7W3vOtE0ad8Mm8Mt
   fPVLBtKeOEAYkfczBYJ8k2ypulzPcqMePN+0ymXOqGKgVDhwWZtGKdldy
   8ZrPMhU5ry16LkEE+csxXPmL1TypNVh0ixPbK/oQCrbOfvsuojUqZwoc+
   Q==;
X-CSE-ConnectionGUID: dHGksocfQsqqgNzsirg2Iw==
X-CSE-MsgGUID: /NKxFzVIQbSOqpvDNpSNFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65080662"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65080662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:13:18 -0700
X-CSE-ConnectionGUID: z7uh0J4ZQ/qTg5CwGJNjwg==
X-CSE-MsgGUID: +bANF5vQSYersN+e2g9XVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155673984"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:13:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:13:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 20:13:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAdZM13Vftg8tDbtH9+Emm9qLoiSDB1pPLoj8x9KZLJ7C24OzErpTXPSCZg4CCXGyFDyfrCuSO100f1owjtOLAFpGc1iPGMDnvVDiUpdrMiJYb/+dX9APgyrgeCu4DMrf1tcdg+DIbsNrRc+thVQlOvaXCd3/YzveSn+rYaS+aaQtpiHwmP+Ug6jPaFuAhGZNVqVPKBxzTUbzT1CTbF+kRGgpBX5nO4g3ehoFJG89GbwbJDLomMrrsHRrmT0jWp5ejishi8THX4oElxHXxK+/bWii11Kay8nCMdyNQgP9KTU0FNnKMFz9r3Ss7W7gIE91smQ172oV4O3qMKGw79+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA8gIKM1VRn+K+TlQmmavCI/wsDlf0Sxnxrx7YxluNQ=;
 b=ndU2FDxKuNxPAN+n7R/fZoPrjNGLz2Xv1IcnlDBvthWGoY9dwq972/Z7pXaOQyfR1SA9h9utDDGDf8vmYDsMrcEtySqixdDAjdvZsVGdISM9roir5HhJPzKTXNRvX37AUXCsAWAP4A1EBDhwsM1+dwQPUGXimSC4pQ/kfKAvnDbUUwKrBS25f2qWy605bWTgiOtidLOdsL4NhjjaHN2pPU77EU6J8YxoahaeBcef6XdIUSnOroq5IW2A+AuE+Yra0xaPaSoQhA+/YHDcfH7WBtMjBOhX4cbOUX7FwZceUzD4EpLPErN7ARGiZHOmWjwDyBFKXpxmKF1rLXMAAcgFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 03:12:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 03:12:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"will@kernel.org" <will@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice
 tombstone
Thread-Topic: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice
 tombstone
Thread-Index: AQHb8IeMjjiKawlT60e3cJBUAJDZtLQrAvDAgAAVCICAASo10A==
Date: Fri, 11 Jul 2025 03:12:52 +0000
Message-ID: <BN9PR11MB527691DABF03AA1D04B899698C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-8-yilun.xu@linux.intel.com>
 <BN9PR11MB52764B86489423F69AF617B88C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aG+G76s3gw5/U8iw@yilunxu-OptiPlex-7050>
In-Reply-To: <aG+G76s3gw5/U8iw@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: 39b32fdb-a9bf-4c16-ad95-08ddc028d2c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TA7rPKhJS8UA8OtDYusONCTmsUyBIW9syriBR0vNjcILKyZZ12FkELEObjsW?=
 =?us-ascii?Q?a8Lt6Ubn28X7F58gMBbjFIGVnW3ncH7GINgcLZPcWEoCVtNd4Mqni8tayPc0?=
 =?us-ascii?Q?agYQrCBVgyJeADUAaUmHgKcM4hD2nt83plzz6Ux6s0h7TFGeaUkF+hH2Czf6?=
 =?us-ascii?Q?Mnw93zMD44tu7kOVPrIP/DB+zQvevrpETxLQ0ADiWd+M6FSPtQmy5GDoCihp?=
 =?us-ascii?Q?1N1hdlSLjejtjoeMa2df+Quw9Ri/yhFsIwnMni20d0Ab3YubhxG/oEqXYZz1?=
 =?us-ascii?Q?OdaprsffdzQJAxBjkZL6LpyrJ1jQnnja5EdSwRoqkv/IJrkUw5DaZuYarldH?=
 =?us-ascii?Q?vamqHLqqtaMzo/HN3WxcERR3/k4YS3I6MJh02AU3haLSF7dSh+xA11SYj6hc?=
 =?us-ascii?Q?ahyxUUOk2IcrqHMpfn+Jq3gdHQrFhO7IxfzcGEm2hipd4wi56Nybyy421ufm?=
 =?us-ascii?Q?SlYrGelWeF4FA8gm6IhSh81ERBWS5Pjo+W0UzkdmHkUBbkKmrIJD6Jm4OGh5?=
 =?us-ascii?Q?3D74OMEYYq9ppLkK65pOGM4hMhr1MeFiorYEISmgD+FrLLfVw8F38r+A+W/s?=
 =?us-ascii?Q?VvmHNmGvhRBB9Qcsd5RxMWFjAgPm+edmOkmwy7BjRnMJYwIIY57L2QDxEyFq?=
 =?us-ascii?Q?KkkI84EAdfEo3i4RbMSGfu2XqkqDfkdQDBxNmhx6SQfkN3sydoVr8Fl3rS7v?=
 =?us-ascii?Q?e+QPW3jccqC1StHjh9eu3sgUEY+4dsHC5dDJGgsBynVoqaP7V053WLtoDSst?=
 =?us-ascii?Q?s1JUvPgRwDuLw0maWPeCJH8CdHfN2a+hZMYpvXJodnSN6oArhbDvbs2aGp7W?=
 =?us-ascii?Q?1a4MWAYEJ83Pu1/H+yrRqfo9fdaEMJJGuR+6zouBzJhgBqbMIH2g+g2LpGrU?=
 =?us-ascii?Q?UBzdzhW/W7e4VyQkVARDxRuTvYKtd/lXJ9bj2aKRwc+VgSB0qWYXxxizxDFJ?=
 =?us-ascii?Q?2RkJpnOOPW7M6d6Z1wwFpbrr13PjDoU9Zc2sxyWpIOe5oVFQMFERDz1twf8A?=
 =?us-ascii?Q?de6nA5ba2SlYh1jkL2DCERT9t3NIoKctfOk9XUHmozKXbEZAJc41GmxK/1br?=
 =?us-ascii?Q?8mZTVBREc57YRrYhqiCInMyxotUNZFbS/5b2ByWb/zeUaYbOuPkk2+roFQgm?=
 =?us-ascii?Q?/fEifJTc72tp/SbsnwbbwOwJumIZACRaLIaQavo5md4VpYASM+eduIaIc8xb?=
 =?us-ascii?Q?hIH1wdmug1MCIQGvDkcgAXL2tdY8v8Thp4e4q+8EqACiAsQFKvFHDRK+XmmZ?=
 =?us-ascii?Q?yUteW4A1FptT48iZiAYJU72D8LqB+vm98bm6udSwC0ePGQ1qyIlGd3o/86ky?=
 =?us-ascii?Q?X+JBancwoKzZOuPpfYtFSQUI1fHa+qD3uK/XlwjEm/zAr57e5Z4U4dJ+Qy4p?=
 =?us-ascii?Q?F2RFV22D3XSU8VwKwYFnaBcQWUQ2RqEwNbUSzL+RhKfBzBy+fMmsKUrr8WTJ?=
 =?us-ascii?Q?Gp8YwXWPD6GhKsG3Tdq03GbFaQaVSK/dJEGHDNRJo6nPOuvD6IKHlRSgigDx?=
 =?us-ascii?Q?C0rS+RHCOnVLe5E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PEj+I8ua/Wh7Yxq79/foVJyUYXFyH+mMLsbMzKShSAntENoEZC9qg7I1BW7p?=
 =?us-ascii?Q?VS1PlNTYgHmh4aRdlOcPuyuxgyLx9UXNJFe/r5EysV0Vqg25e3XLhJQOVN+T?=
 =?us-ascii?Q?+OZnbS2MrrQlIOQ3RAvqE0cx0kfjK2sxzv3Qy3dGiJqKOvpAAjsWWusvij4M?=
 =?us-ascii?Q?223yKfqawnbgxRHDf7y1kvvJ75Ze9dIHSnwDZJI47PNx0z15CF9KB2vW4yYy?=
 =?us-ascii?Q?0bIPzZSwt7AbZAvedA2VHb+PLIENct9kfJ04GxjU0zUlpowc11AHdq00VwQP?=
 =?us-ascii?Q?MTk0K0WzH6n7oEleRnaDne/H0qW//p6jua6fAz2OOhZvUhlLO3ZTL8GTVUGZ?=
 =?us-ascii?Q?J+qtYfH77WofYURpRFt5l2w8ylf0klCzjQzxc5VcbtAtimrHT7lu+iAp7mjN?=
 =?us-ascii?Q?wldL2+HvN359c4ii/JqewfqQGYILR5eo1t9LgpFfCULEW24qtm9nl/zppXy7?=
 =?us-ascii?Q?bpL2jfSJfY6VsoOA1FOwz+hFlsNyaMgKW9XLg9NjKUoHpYUfmrbIY7DctoLy?=
 =?us-ascii?Q?6Qwd2LwbD0Ct/eABExWMMgvhdzq1kfESygjfSC9sebm9GI/ilLflvU+H+jRP?=
 =?us-ascii?Q?szMOhe5UcYW6acWglm3AuT3VHQkYapHTnenVD5oynZMRjmzrUw/zhs3cJgZT?=
 =?us-ascii?Q?fkt6G/UwJjIqmq2fwS9oLs7Thnqsu2UGkMCE/gfJzAaOrP6zTBUwLsd4G0pU?=
 =?us-ascii?Q?7bhLQhr/D+mHAScpm6ru+Hj2EUUTukK3dfzqAxddc6hUjhlT3YktPXQfAx96?=
 =?us-ascii?Q?CTZPJPa7DnPWlc+WM0KD54xh78yQ1TUVNOuTOBjTfdAeeM/6ZtGwiHWntDaS?=
 =?us-ascii?Q?u/s0NiKs5ckcYQavprv3e+BuJwveBD2C6RW/cMID7BOaLu03Cw5rx7LkDf+Q?=
 =?us-ascii?Q?ppY/pk7DdKhc78oPdv/1Zym8ZXEhpDhoN/5UvpGG9HHyL3q4RXPmxw5fs5Vd?=
 =?us-ascii?Q?2qWou6++03z6W+325qFHnZfodHpNUhCn3Ia66Kpyhe3SdCBo9pSidiDeTb6E?=
 =?us-ascii?Q?6xFlVAVGoEvlS+Om4EsLo9mVJBe3BPq5RZ/8NOxeU6hyTPpz5irdxjvpxo6o?=
 =?us-ascii?Q?6H8GDI+NILR2lb+Vl983j8qYQ75XEOI7SRTXurx+Bnx7kZ9EisZcpkmCO32R?=
 =?us-ascii?Q?F7M3v3ADAt+ONbthNWKW5Zbh0IdOGAonXjFaaiS9jPm6jP8KmYbhw6bqLgHG?=
 =?us-ascii?Q?wrNikCNrGYonR0CBW+vuvq7AmMtm6mVaPIJ+nmDI0j+2zkW7zgEANsz0GuxE?=
 =?us-ascii?Q?B+0z+dnaRBQ9dVbbeahY/gh+OKBIcFUs1mwNJVmvfmxL+iGJQ3qZkYSUcvdF?=
 =?us-ascii?Q?UkFagKSfve0/V1pSdtbl/dUCTa2X1dr8j6OOrznuFq14NdRRr/KlMkTKAfi9?=
 =?us-ascii?Q?I9/76xtrodW/a/3pz/oi8Zw7oBmOBJgRrZd83UEQWIPYtJ7LgzJ1CPwxL7Ho?=
 =?us-ascii?Q?+5EQ/vzWf0Jrsl9/ajYCaa7WPnaLKcneM0fFbqutgqLYZ1QKj6YNwtAz+w90?=
 =?us-ascii?Q?brc9Zut/Q0fnNt4ychSfks3dPnCul09spBrvQxq3jMxFx2NqDkDctmhSZcvx?=
 =?us-ascii?Q?LHBR64UbvNXBmTz9o2f8cYIieATESUdL1A5REwo9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b32fdb-a9bf-4c16-ad95-08ddc028d2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 03:12:52.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo8XkpHRUWx+nQ4Ow7eQXU/Cet2xj66SE0xhWpyjlWnZzV1BjFMAbJCFXDyaj/thzRTEkVBGQ8laEJeV72bNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Thursday, July 10, 2025 5:25 PM
>=20
> On Thu, Jul 10, 2025 at 08:10:34AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Wednesday, July 9, 2025 12:03 PM
> > >
> > > This tests the flow to tombstone vdevice when idevice is to be unboun=
d
> > > before vdevice destruction. The expected result is:
> > >
> > >  - idevice unbinding tombstones vdevice ID, the ID can't be repurpose=
d
> > >    anymore.
> > >  - Even ioctl(IOMMU_DESTROY) can't free the tombstoned ID.
> > >  - iommufd_fops_release() can still free everything.
> >
> > but the test only checks 2) instead of all?
>=20
> It tests 2) & 3), 3) will be executed on
> FIXTURE_TEARDOWN(iommufd_viommu)
>=20
> For 1) "the ID can't be repurposed anymore", I don't have a good idea how
> to
> verify it. Allocate 2^32 objects and verify no tombstoned ID is
> reused? That's too crazy...   Maybe just mark it untested in the commit
> message?
>=20

not required. Just make the commit msg clear.
