Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6B2BD11
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230679; cv=fail; b=hy5sWiCG/lFz0sJwNwr3yxsZ62G2KTn2umdkWe/AG8dYZe6fpIwjD86epqsR3FWklP0OvIpOXAuRAPSHfhrSSfF69EWcD+/xItmqR4YSR9ugJLDVS3ifDB008YcVF6pk8EXt8JbVxZ/0RwVcMczSxC+FjmsJkVDbNSOH89Undd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230679; c=relaxed/simple;
	bh=SzWPN83qxaCle6XgxSdy+2dXRXgm6davXCvWkSmXWJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQ22yH4ptkZi/5lzsOGrXcT47mUfhBbWeX0ud0Yb0uoQ9RZxANGxW8eGN7TrOBniJe8vhyQJrDNSE9taQHV4xQcJegmAyDZM0ss5odIL+YyPHYj9YptuEKKrRoCVSz6VZzFqmRlORnuADjoDDx+drfPySlSPX9/7+ptkhMCOyoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr7zvC1S; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr7zvC1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774230677; x=1805766677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzWPN83qxaCle6XgxSdy+2dXRXgm6davXCvWkSmXWJY=;
  b=Mr7zvC1S9X7SKlDAwqV/MyhLHZBDmZBTJYVxKKycWMQo5Ohfe7j4nQv3
   1nbKETJGv5J5YOiu/FLfiPtpL44kn/Vnbe4hHjAhXzY0kGMjiHUJOg1Nj
   chXrG66CRLFS9JdoHN8eNghhAhdfCIWPUapC0lAIHbLcT+DLM1xO+ALAx
   L8v2Ez9PPGSGOni1MgyTzW+uqqt3TkmX8xRB9bcpqjyXBs5JyHv46Ku83
   ycMieANjVjtRSSKxndwhUc3nz5QMnOAJH+UrgbYPxL/fsOGXo5uXpJQ3D
   NpQsDOjojfTNEZm0d4HO5Pixy2z2O1eT6pQVmeCW2hN0w7zYl05IqUg4X
   g==;
X-CSE-ConnectionGUID: 9WlI5/fIRfqxFhNDm1uxmQ==
X-CSE-MsgGUID: T5Fh0h8bROKEpcBliv0TPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75133447"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75133447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 18:51:17 -0700
X-CSE-ConnectionGUID: nJwpFDWET9yxIYg14FFWvQ==
X-CSE-MsgGUID: QbRVSFPER0SX1u6SLxw3FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="224091954"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 18:51:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 18:51:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 18:51:16 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 18:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCVvTEur25oW2TUfLRquF9Qc6Yt2ljPR6qc2y43AlPI1kJ1sXeX6b/lrPtKoalEKlzFNZ9tVVKahKvN8DrB7se1Hv9NhX2nd/R9yVxqzLr+mNvvLL8M/qb81/IXEM/JPZLvb8GYSWvdD3maGcaTRzHxKvXeYCoFp6HDV+JtbIUJlp9WaGncZxvi6qbuiPx/gbMY9jXOv2zUViodrCxJ55rD7cao29KXCdaY6zZEBHMabIe8yV6U2z8VUNi49AVjSufmkAwLVAimwAdewEQ9RVDarj/SsIZOQjQIStlX+rmDMKurVxETcdoYZHYmkq002ofrjTq4gkwJrY7pkR/d3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNw3T6NGTFaP5rwpRdcMLQgCS80ufGSt86tv/9ct8gU=;
 b=JIurAdhXT2FhTN0gsi9m0hLiWeZ3X1vK2UZmNMkK86qdyzk6vwz5WDXt9HkoGQFvw+E6nXSNpaSCErAHHaENJTttXZor5jAQboOBB2B+HgVgrXhXl03p8kOHQuOiRKhjVF12mxaVy+TUmuTojwRiU797TmN042hzlDLX+wCs+mhryTl4tdVRSQuZeqdQJ1Az8ZFFigYg40Yzf4TMe4XRkRpEZjFCerjgc3XWNsI/4sWe6J5htMyKoBHmYzHrTiQK6KwG4R4ihVf+Ws6j3BlvSzPTUN5jGyFrQlv90TbXUdkuY/3tbckUkSiiDaWeClooU6GkTyj9Cb+P5jhNQMFirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 01:51:08 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 01:51:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>
Subject: RE: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHclkfxNsmY1XUSU0OoVQI0Ea3M6rV01qSAgEbK54A=
Date: Mon, 23 Mar 2026 01:51:08 +0000
Message-ID: <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
In-Reply-To: <20260206004325.GB943673@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ1PR11MB6276:EE_
x-ms-office365-filtering-correlation-id: fe61e5fa-1e43-4dd6-59a7-08de887ea706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: g4yuapuAJ7PAmhaAf73oF92/p3TTaHm+jzUi2Ml03/8F5y/GlmKIBqIGe4ezI9/+aid9b8sY7D6QM8WEI/pQtRZ11LJjUBcjWFJUwNzdxXuhLHMpniiVqBbkr1ZafN8ZsXQx82MmQNhoRy3n8kbRWOPfAxhRfq4kbHVZWleiRHQefFgqPHRGUkLdKSjcJQTpwgLoQY/SdPV2LHk55kJ8TEts2jYPjEwYIHdmMcv1IeCh4TJDN6nnDnTuYVmvhR2vQHmnd9yNFXUgMGDgLz+2K7XHWsO5ZLrx9Tc0+05ZVqnUyIQZZe8ZnsMKYPapTgDH1XtSwLS5A91vbT1EAEMIH0/3ID6kMiKjD8qkPFs9j2KbtiweNVgkYrwc0eCJvIGAv0+c/GJkOlEx5DjLyuepya9fjQB/MIQqOZ0OGtvYZgAESVqICcvXtuvq5saLbHRVCVmYnsBPKTH466FkI+mCz1bLhZGFgcgKGT0LJPssXjSdiA2ukjwXDkLg9hlk9hWNwXesKqrpRGj0CiEtQos/U8JzQV44s4pTsgpqI7kojtwan8HKRmhZnh2KJpU7J5QFy0MGvcarb52tEv9mk6sXIAKcGhqSTzWaUZze2Tt9p+OBpkZKFYnInmId+HQLwuG8v0zFVdXgaWRuJ7z4L2kO1sxYJF1lckWMTc7DZ1I1ysT5JqkVgiBffPUNk6VME0Qemx73exZc5qhzIbikvm/m4li/XeOKm5px25rUPTS26vkaQ3sJC3DFtfu0kjruVRN2SJJyjb/y1kPbQJ7Pu8n0ManBlwRqSWdMJUVyDXpNny0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zm7Bh5+re05p2doyDaT3o/MIy03VHmwSjBVtdPU10x5Lukee64++EHG+foG6?=
 =?us-ascii?Q?VYsTmaOratmKxy+91DrnGW3Z6QkcrM1NnW+s4qykp1zLel5KfoTdvxMVQFKF?=
 =?us-ascii?Q?0St4qYxxMU6r2IRoTiueK7Vg4lexE/IrMC/EFZrXVV/FpoctWOGPryFSfsXP?=
 =?us-ascii?Q?IzA2B6CeEYiui8ftbYi2OmGTC4h9ZXi+F2u+ZP+dbEcLqvJot+PRdT/LWnFV?=
 =?us-ascii?Q?S3aAi7YDI4SGtB/2E+SwmACWqPpjR6UPSvD6OGCyKwgF7Z+upCPNEDxciWiz?=
 =?us-ascii?Q?a0th+Zqt9LIy73CzsON+jj+8GQT12tm+qKH/MS202COPERbFZJREhv0tEQdF?=
 =?us-ascii?Q?zL+zgjdOTg3ZFqcXWh19NS9VMIOptllK3MhepVolkmvby2PCSd9wTza9iR4t?=
 =?us-ascii?Q?W+Fb2gjhxJpDhOrx/B/rfGpAD9IIVwDEu2C6Icj/rA4/fQTyoWCuNJBIByKk?=
 =?us-ascii?Q?qbAAYNaMtnOKJkNE3EAsBkbz298jh5H+g9wVgfVDkaSuy305L5L6rCMW11nb?=
 =?us-ascii?Q?Z5lfku/2FO5H4qoJ6f3zV+rEmlrnesF4sjcdhzWq04SXkFR85NgByoka9b4X?=
 =?us-ascii?Q?alhUp2e8IOuc8SlvZtlrGxETQxjtDZXJf1RkrencJaj0fJPbgx+QxFUDCRj4?=
 =?us-ascii?Q?93zhzKhaWrSsIXKy9wv0q9MuXcI464SGdpY/wrTBPA9TY3EMM0+JdOUpfv6/?=
 =?us-ascii?Q?4kVOMvNmi1IuK+8nps5S0GzqeC+FdXvhTUMRM734ARughGpbqI+AdxDMxMDr?=
 =?us-ascii?Q?anZayfAilrJjg5qNy0fFcshamCc88OhqoXPpfCnZDAleaIs+O49bPWeqe/D+?=
 =?us-ascii?Q?pI/RNv8r9Nbl88815ypvKaA72TELSYIEXKaIICR5RLt8nNbPf0b+x45ND50x?=
 =?us-ascii?Q?W2fmkbOQn/xa1CNYdUAoL2zT145m5TL6rkl8b7r1MZ8hCk0sKnIIynKumgu8?=
 =?us-ascii?Q?wajjEO1Mkgy8IK4G8Ea6wlcak+IYPIHHZLJPqjG/NqM0P4X8NWT+0y51VAJW?=
 =?us-ascii?Q?Fk3bsXHXhHEWALTMeQKy+hCmqro7y2ylkowDB0QUfhkHdpgJCtfA8XQPnZPz?=
 =?us-ascii?Q?8cPMehX8lCp9DLRrT9LY2t8ztU1SueZ9H4nDrKvToVmWFI2Q0eY5GpnLOyDW?=
 =?us-ascii?Q?CwFARU/6n476300SojHhXKyp9PXnaCmhMtZ5/fKshoO30uVcWLhnXpX5bqfP?=
 =?us-ascii?Q?fWK7iEWFWq4rC0zV1RYWkt53gVmXklCWZsaZ7sZRvl66adeuvIRo3VsiG8MT?=
 =?us-ascii?Q?AO73H2bcYVtUXNGTtV+f177FvZqO1PyO2UbdPqrd0oDEyxOsdNbJTJ62HruS?=
 =?us-ascii?Q?ExHoTms3WvUr3tLU6n8JAyAP2CkV8Ae6gwYB+sMyUtT1fEZWcq47gyfuMRXQ?=
 =?us-ascii?Q?Ow1YMTchzTCaSm0fx9HBUdQBexG4h37CdFz/poNmhcEOz6foNjLqNCnYwypG?=
 =?us-ascii?Q?jupEtL0L1p1f4UvFZCSeQlgLQQ3LpZOJrjZcDH62rIZZdBu7rZ34sqAhLruf?=
 =?us-ascii?Q?QauJG+Iv+GRzv69z9yu/FMMqI0teCMe9lvehEqhWwsp+ioAVzHlQsbv0YDb4?=
 =?us-ascii?Q?swrjwCWTXRVXZrAAbea/S3nitOacle48vbM0GrGVSITP7cMVhqkVpB4x3bTr?=
 =?us-ascii?Q?AEI6+agClITzfIoo/alObS/LcgE0aMJ9j2SQAPFYOUE/oLxSUES+oPnabP+J?=
 =?us-ascii?Q?hh2fEfuuVXE/i+MFTVvUsIlHbecSXJl1N4Eo6O4FNJuWneb26xTgqwRoFF04?=
 =?us-ascii?Q?CORbW4ICfg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M6gpgV/8I5Pgphs9UQ+5jDgjQ/7CqGsoNgMODHkanMzoSJn426FBTfDoZeVcZ4oQjIwgZYsXcDRzVqbImmy43TrlOLy/nJ/mJJqb27GTgHYZbpUaxbQYHaU/IAI1dniUrN+EyV1Qm4m+C3tHpPcAWQodyCsqBxbypowAUiDC32PbwbpsTzrCQzf7l2ouSFw0SnmrdY/WfWrSDbQVy+4bxafuDhENeECGCQIExouMlW/j38lpoDEqj0mlsutLd35wDXRyXHj8qgFWmuQHWgk8Er/ehslgaNebBpiLJJyPROwZdazIeTbSuo/s/04nHAXE/1ucu3bMF1IJ0ao6pDjREQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe61e5fa-1e43-4dd6-59a7-08de887ea706
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 01:51:08.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tF3NOP3WbrqJP5XVKgEIhpkrCdABWyfbrYOOlFUUwblJtXtoAaSjxTigiBIllQ+xjepVlmaoK1fhzXxNgQ2/HJRXXALgF9WQdkfeeS2pGNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com

Hi,

Kindly ping, any comments?

Thanks
Zhenzhong

On Wed, Feb 04, 2026 at 09:34:01PM -0500, Zhenzhong Duan wrote:
> Hi,
>
> When we add pasid support in QEMU for passthrough device, we found
> PASID attachment to a nested parent domain with dirty tracking failed.
>
> It's because PASID-level dirty tracking is not there yet, by adding it,
> we can enable PASID attachment to such domain.
>
> Thanks
> Zhenzhong
>
>
> Zhenzhong Duan (3):
>   iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
>   iommupt/vtd: Support dirty tracking on PASID
>   iommufd/selftest: Test dirty tracking on PASID

