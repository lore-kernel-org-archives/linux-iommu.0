Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E32D3A88
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663954; cv=fail; b=aHdAiw3P3O0qSUd7/xPFuSXguCSUxNhjvRdVcmpmxul35UfZFo8aJU2KhaBCamo1CqHqUpQZVXTCy2QLPDskmQnb3I4YUBbaLQoUC0WKvJFU90aqMQvqrnTDuKOJSgaRbguTok+xcUKbr4i6mWd5ZkrzPeKm5SQ54HbPPiv7yBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663954; c=relaxed/simple;
	bh=CvIw5QLKgEQ54AP8ckPB9mL5dtdTonnrcxFwNs4mf20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N8eY4ksdY/3E/r1ljTBIxTRyiN00qbpc7tYzYTpPbLhg+TKWmojDXQOSKZN8YPryq8NVVXnfMrJ09pBjFfpWl7fr55eZO6AEpZVjP9d4Q1Aq/1egwB7OgScQIlQZm4gcc1uaQ46jJgWhHjKPNOVQO50LmAIQfW9z7DtemYWfYjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQvhng7X; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQvhng7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757663952; x=1789199952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CvIw5QLKgEQ54AP8ckPB9mL5dtdTonnrcxFwNs4mf20=;
  b=HQvhng7X/PBvGHajDnDg4uwEu+qhVQxeSCVCOhPfWcaWfLthOQ/nM+PL
   nvDiW+5zc7uS0MKfQQX2A0cBCsZkuq2PGK12QjTT2/XUdIfwMfVX9rGif
   PlAKkOMjdeJx51mcHkjDB9no+gssrQM0OfCULt2WtjqvLmwK0KJYSag/f
   UlFHoDP/5IayML2VsTPLLp9R2ph3mwzspS62mv8C7gN7v8Dw/2m+ecpy/
   FtuvSqFfUxzKdTF922XTHsyVDJSQdq7BgCe48RWlS4ccjwVPNew+8FXxU
   p4utGBDbv3/q7u3/bmmHSd0oURvYgEptAXiQBw+X3zknKkoLkEox6AUum
   g==;
X-CSE-ConnectionGUID: eLUEANj+QLevWdbX85tEug==
X-CSE-MsgGUID: SfkPUtoyTbScgSgAsmu/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60080418"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60080418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:59:11 -0700
X-CSE-ConnectionGUID: jNPTu74fR3C1Czbc6zYXsw==
X-CSE-MsgGUID: tSq3gPlZT6eK9apcAbiuUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="177941899"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:59:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:59:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 00:59:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8/mccozuUStQGwp0cK3ltAJy2EeGvdc//9HhqSlY0ln8cysDDzyaOJ1hx03cGesj44vnkXQWHZPkALuyaRA32G4od6WaHzoce13WFHuS1f9VA5IeOI79ZaTGuqGQNF8umnaNzoPOAwvZzmiJ35nlFUX249OS0TjYCEsiPBchBDb8tTx/+2aM71AZhLODk1hBiamwPs0hT5x7puhdB6ZdwA91WF8T4+4KMK1Adtu35VSWhg3g1+5XsQlSt/2ki4WgP58DCOL5ofSVIL/tDF2E1SDZr5w28K+cbQiISFNLHo0NhIOiFt6h733ds7NZcmb/WB27Z3yO+SDrn/bBjoQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvIw5QLKgEQ54AP8ckPB9mL5dtdTonnrcxFwNs4mf20=;
 b=cIB5XPlBaG8Uclxl3RGX906o4YA4QKuKaKop+WfwsbjJ4VcuYaq1X0B3F0AfCUZyHlFfsXgTpyzi+pxPslUylpEN2+KZJPKMpKoGMssRTHVV8eufCj2A9pPrrmcuiPt41asAJJzst+V6abxTnpM6NL98+HPmrET2EPuXUvKy6SHjDVv+yI/6Vtsm8maE2iQm+m6UFWh0fXpdt+nQSae38qt1a1FU5u6JP73q9XmP3yxh8zSEU/CAkvkGY7CKArbVpOHwlLue6X/LjqxswuAuxfsf0G2HcfEM7u2PSBsTlWNBa+lJ/OY2WgTN9K7QOF1lTl18aWWoa+kcGrZWZ9H+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 07:59:07 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 07:59:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 2/8] mm: Actually mark kernel page table pages
Thread-Topic: [PATCH v4 2/8] mm: Actually mark kernel page table pages
Thread-Index: AQHcHilqHD/mDa0Y/kKSWL1gROaBzLSPOdVw
Date: Fri, 12 Sep 2025 07:59:07 +0000
Message-ID: <BL1PR11MB52711D9B7A0458D45868DA688C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-3-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: 779069f4-829e-4677-9438-08ddf1d23ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q8P4NQWldUC0EEJ2KZhpVcS4k7MMRpRHDr8z8xOFYx8f7UvHwKc6X1MT7xmX?=
 =?us-ascii?Q?LvO8z0uXAQriiXQrYPxnTuimQotNKfY0wTAQ2mpJO9+VPWK8CdDjmAx9DZoB?=
 =?us-ascii?Q?ZeGXa3d0jWhKcPP6S+NzgQMGvw9fUr6K/OeCYM6GVovFgEFl9kEziBAacP00?=
 =?us-ascii?Q?V3FX0X4gNiYId59qhZAfFh/tyMDlRCMv9zLTl8y3h/JxdCV9WWx8/seV0OZe?=
 =?us-ascii?Q?mQeOnRHN9R07EJC41QaZwD8oyvFiSihs7EK+X4IEug/zE8pxCKR6+okwBci5?=
 =?us-ascii?Q?VCPqHlzrOCQ+dFFwIFkqTVvk2OsvXQBNzQVoCLQXIm6sYF96TeN62bYOEy8o?=
 =?us-ascii?Q?scMgpLYoZ5TePyOWU38KyflM0CKATVAiLnbfenjfXHCB6tyLBwORCG+3iK1s?=
 =?us-ascii?Q?JRBsrTxEFYpy+w8D+vw8i97azUo6aaZU2ISf3f0uc8/tLxcd0JOUU3RaMdLZ?=
 =?us-ascii?Q?AV9uMcnj1AQ+7bEC9a1kg6hi2FklOW6oiVUdBpC53vBzb9iBfuvtYyvTUbjQ?=
 =?us-ascii?Q?NTPQdeP+XCCfuKPFk6ldTZ0KOmDLKpvt+1hQV1o3QsTQsELMNgrIT1KXGkc0?=
 =?us-ascii?Q?Yg6NPTtLG5US4uevtcR1tbvGXzABi9aVxXYtdzjSiLJgWUf6IOcThH3QMiak?=
 =?us-ascii?Q?gT9ICF1vwShPMNK9X8sCnzMNw7y0ECPI51GHPkWJdLUtVlxtooz7v89nfzIx?=
 =?us-ascii?Q?LyLLnzgE8eoYPXZSy6Nto9QyGxiKWLsqN9Up/9la3wxPAutgAlR5MGpFCDLR?=
 =?us-ascii?Q?CwJZ/5b2Ti2703b+VxyD7jVkrDyQgNOKVnPz9pupUg+UuS465L26Vm7Z5xay?=
 =?us-ascii?Q?v2CH+rAxaepR5nq5zA4vIsyzoGvBDEjuUAx2e+BvEw+gO2XxaiOii5euQfWG?=
 =?us-ascii?Q?uSUkImkpyLMTS4P6I5JL+arDHQKerDySdQ2jy0VsiUZufu67T41roLotl7aD?=
 =?us-ascii?Q?82db6ET/q+2ZiHTKzcL8KPNc4lF+IGDlERrrx9TFu2PMijJm8FWSsUp1qJDK?=
 =?us-ascii?Q?LfjH6Eth5v+ueIZIAXgV+vA/wNb2usQ9NV4RnVhvOm5sEuPTnLnJwdCvlv+H?=
 =?us-ascii?Q?TbfFTzmrF9OJBetf80v11R4ia7IvFXeeGb1AJBTEjXEQf+mbIqt9rDR5lvHf?=
 =?us-ascii?Q?GGBHMHWsNoWn8dl59p1a/B1HgW0Urpz0GyKxAhMK2nU+dVnTR/VMLTecWMwX?=
 =?us-ascii?Q?eluld9W8DajXT6IaiWC7pE0La02NeG2jz9vw4MEhDG51djxao5asa3/hCso/?=
 =?us-ascii?Q?4/dvPaAxPVbTERubkqo57Ma91j+Ybamt5itARV8SPqd6NhrOmm4PY2EGywVk?=
 =?us-ascii?Q?67aJYn6YLJPfnRGTlBYfdChpItiuMEUuDwnfqcn4b+504v+09jqpCuUlsk19?=
 =?us-ascii?Q?G/Q2/GY+3CJNRXAmP3WHsuaKXhn4lwCZDlRQUN5Aw+pZF3BR1jWQGBXgx234?=
 =?us-ascii?Q?WgUG3iAYf1b6Pe5YRtJGKIy8djinkLNhs5TrYXqlvkAqYF+6vy5QdprD86xC?=
 =?us-ascii?Q?wKq+u5FxB587Qfs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jve4GfKhundq/0dMIupLCeaaS4C0XMKxNn2qDhZeFJRPGtv9SF562aEXFvbg?=
 =?us-ascii?Q?OuDmCjznoyq3gtZLsGUjSqvinfDtDeVjYOiFMPqDTrj+Q2j6GHTDjROsugRv?=
 =?us-ascii?Q?aSr4+DDttDb9OGP/ktX8xUmDEaBnRLxCRi09+iwWOAi8G/PYjUiWdWEujkOK?=
 =?us-ascii?Q?qMDw5a8Neeg2+970VkG481a/37nlQEnUSwyADnEoMAqPz0PLdd1ZsDHUrYXM?=
 =?us-ascii?Q?CO0YXnZD/XkLkw3s0CdSOKnkqQp1UJj5ZfAWbKaGcBqbBD6FSxVZPE5LVqrd?=
 =?us-ascii?Q?A6GKYYh7Qt2HehhU1/FlLYU8CU8DxW5Cwmld33C5Zyi+/qDOslocZbUzp5Vh?=
 =?us-ascii?Q?aye3tBEEFfxaU7g25sBlLVCYQhxhXFV9+IE6cYHd/w8tnt/7G8rCeO/x6acS?=
 =?us-ascii?Q?lPJ11rZXGlXjWUY2/bOxv1bcrY9VTQBQMAYGDJQ0IHd4OQNLc6aEdfU4oxXw?=
 =?us-ascii?Q?boEfNEbgsFSE+AR1F6P5rRu61weUJLmw+FW57W6b5pHWH2zh2IHAt2YLqyFc?=
 =?us-ascii?Q?Obv2cSh0JtJg0abyDftw1c9wzbVnH7UdagmCAWTSmi65czMfdibBihnIeNwS?=
 =?us-ascii?Q?wnnRRSmA0ahKsoigcgcPSNVFf8bI8N8v06SSGjCA708Nfuq/o48jepAoF0iv?=
 =?us-ascii?Q?H6Z8o4du+5B+roMarJ05InpgUN7eFE8g9WXRUkrsb3ErZXwMA383oVf48Fo9?=
 =?us-ascii?Q?MMWlVH/DbeAA/H2YqjNh5amyKR7my5seM1sfWbalr3OYCvbqFXXku3fCEvja?=
 =?us-ascii?Q?WY7BDZ31My8kGdWEEC0YgrUWWG+PY/57M5Dk+gsMLiPJLvcJxYLd6NdFKDdD?=
 =?us-ascii?Q?pb1sweXlgaONVVBw/BU5+yF8LoPBCEyJBNFGloQlDKdO/FidRExmSBq7wJ/J?=
 =?us-ascii?Q?/A6E3m9kNl8KaE783cErr5r8U76Svs2ijSQrvkNzZSVGgaF4BIuaaSKiHf0L?=
 =?us-ascii?Q?doz2r9F4Inni+s3GLtEQVH+Bgfbxlpama/E19AKUO+O7siXRaRXCujBZrIgF?=
 =?us-ascii?Q?nef1ie/1Xs71G4SGGS8sZkqsmbes3fUcWmnM/aqHS5Eg7KsTupOpXnwEWW6w?=
 =?us-ascii?Q?AA/G8hojB6b00N0CxyhE5g2LglpehzlAfFum9WoHBxHNjELE0BlAqgtVOLw+?=
 =?us-ascii?Q?77/U2MBoqWAQjR9jfDy/tBZ8XNF6ycbOBq99fwPAK4unTqT7RtzHv6PVW0zp?=
 =?us-ascii?Q?CbWLtDmik+F1OcXW2tWwCLgBOjgD8it1HVzgtIWhp05FZpqWl6xh30OVv8Dm?=
 =?us-ascii?Q?JoloH3vb5c7dWXV/GGWcsVaOfuCwvyew9lFd1VXx3d5GTKfDaGzWTo5mL7eS?=
 =?us-ascii?Q?iXrUM3GMrIyx1os6KHiup76/Te/WvG3MeE8lBHE2dOpNGQoQfht3gLB+r1vO?=
 =?us-ascii?Q?CbBGTQ93kP8mfq7Hr4CxVNZh9RADZOARLI00rBMblIuJKMmgDQ9qSx2JWCXh?=
 =?us-ascii?Q?xvnAFt0YVTwF+u0MIXt/3JvaJ09gM1aOyPYHc3cgMAz+dTuZ3Sjnrx3AEQfk?=
 =?us-ascii?Q?SgJROcTipxsngZ1belvxyStQdAvMbLTeFNLQUoBce20UvuZZgjvsIROOffSf?=
 =?us-ascii?Q?8t9g3/pb0IHTfwUKDN4WHsWFTckrrf4lUBZ/S8Hw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779069f4-829e-4677-9438-08ddf1d23ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 07:59:07.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7o/7/+9BaJk/B9p0bwnRmc6fwElIkAQBR5VtKKnzKtIZvip261P2F10jFRtlb9hBagOBc4ZZLQBEkfCcBJ6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> Now that the API is in place, mark kernel page table pages just
> after they are allocated. Unmark them just before they are freed.
>=20
> Note: Unconditionally clearing the 'kernel' marking (via
> ptdesc_clear_kernel()) would be functionally identical to what
> is here. But having the if() makes it logically clear that this
> function can be used for kernel and non-kernel page tables.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
