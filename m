Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CB1C07DE
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906145; cv=fail; b=iVenjwqIge4Ar993scrU/d/+E0hUkMgXAYLUvqPKRZkqhGAu08E7oslNKbuaVb/2hmPxgoT+p8z3FC4aXu/2sG8Yt7CTyghcUB1zu8dVwrInqlG9q70G650ZJzJDyUK2njgjGKmxFMhju0foDkpdDp57HdvFsoDDtJv96BhHcW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906145; c=relaxed/simple;
	bh=GqIyM+OScfTIM7CJChN212ytqbvYUMmB+kVqrTZCigc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZIgAjHa8sIJ6rIPoq6n6O5YNKMp07acL+ydaR/VFJF84F4sgKV4uoAXud2sI8tsqaocaPaqaO3bE68DuGgesEhcYPPhWPPVvPPDe0JvYjQzjA5zdelMETfbpcpClx8GCehzykQfzrP89Ci29ClLxMf30hEXuNHgv4yH1YfMt8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcb5l8Dx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcb5l8Dx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733906144; x=1765442144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GqIyM+OScfTIM7CJChN212ytqbvYUMmB+kVqrTZCigc=;
  b=Gcb5l8DxmPfXAyirG2NFAvvFJDXUT+v6dE+TDTv7xgktBnxU8Znh7el2
   PHp0N6DBXDVYHjdpFPLWnx2hTcQ5wXaUHu/tYFRWDeBisdKsaRWzvWP8i
   uiGqNKa8rVsToksm+Q7RYIcMwkLvmphkoyg+BB/66UUwzqfedY8h4ruL4
   IKKJr5qvNnIELm/NqMeU+yW2Vg+5fdyLky9+59xsYb/l3h+V03ZpArz6P
   yy340z7Sm+pv/o+sC3q8MO9s/w8397+3GhMYTH6y1QtilPx5/mndct1MT
   Vy2g9yVe5gdh2JJeBcO5W8gVnyCky9Ydx+epc+5NPCbCA+1ANhJ/ffcSj
   g==;
X-CSE-ConnectionGUID: IgL97PiwRSm1jTmHNYzE6Q==
X-CSE-MsgGUID: VAy7xJV+ThKswAfKREk9Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38059696"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="38059696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:35:43 -0800
X-CSE-ConnectionGUID: 6Ax8C7S5ScKZTTPi/MZeVA==
X-CSE-MsgGUID: gVZ+B31wRiuO3YoiFNTA2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95909381"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:35:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:35:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:35:21 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:35:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxqYyT49dvpwmDGQRkBGk2YX4+QzgIG4clfOiSLK/J2Z+m0QF4XSDvO639sXUW8JIJKtk+fQwD/ODH5K1ctngkN3vSHfsbTZBQUCo0E21mTApg5xa9wCHrM7gxKpt4JhMOHT+LxGzwqaQ3xpmLcAzDGpscBAL9QRGCJG7ySUFJ5r0W7sokIIvZPG0m9CILkBqIvlXnOwQaG87zJOfWD1nNdBgAjWsZDOm8rDj1SPmb63Zk2njcTlB0mqMD8pUs10XnVVT2m/X6QyGY9gJ+e2qyV0XU1TcfMCki75vknA0mIBNVhhENcfjKq8h9bk/TSJw2Bh2RsJy2VrHqezxEbJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stwiopHlp0X68mMWAippM9A6oiXd+Oqbgl3JzKiaOdM=;
 b=c4ZXO17xxnFqn5dSaSc/Ib60MNGMhrU8sXvbPRN3XwMovGqKqISzQfjvfTchmAdtM8rA9OJmrtW17EcW/CLa6Qt8HEis0pHaAduTxN9ebuLYD/NLa6uB8PT5yj4Is/e9oY5Rd63nmme4Q+o+NBYgPsCy/gWCjnCqkpT5/q0glh5budp29JAzjVuWZ1+JcrOpjnxS5Ar9zdVwwMA5+i0E7oZiVWOFZmH00tScSWPZ5OU1EjnppU9GAFPovQn9oZJzEZsRiwTCVdhMSmTclSSFILXAY1AUuUwSIBUxB385j1taRqgkE/YXHYVlahSXZ3Yq0eXy5RLDQLGo+aE/TFjf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 08:35:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:35:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Topic: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Index: AQHbSwPq5ChM9YYSNkeNT67odQk8MrLguE5Q
Date: Wed, 11 Dec 2024 08:35:13 +0000
Message-ID: <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241210130322.17175-1-yi.l.liu@intel.com>
In-Reply-To: <20241210130322.17175-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: a178a187-fd97-4cb8-d026-08dd19bebb7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nHd0Gsz3LN6hM2rqP+QNt7ejoYVs8wO9jKYNCqN9LyzYM3zXvjdl+Jdsbvwy?=
 =?us-ascii?Q?JV+0SgRgBIQY37kq9seFVILPreDXWkufBJKIpUQxZAmy+gY26Qihte4iJ4oW?=
 =?us-ascii?Q?yiDjy3eW3KGD87hWIxxNwDmIavZRSKMOiBn/SOyttLCphAnQ6upQcIwfthY5?=
 =?us-ascii?Q?EPrwg/YCD2BjEP/BaD8z0FcBiaU1xAU5RCefsyS0lUsMTJ1J5m7Gw/xgi1lo?=
 =?us-ascii?Q?rgHI8eq0rNlVmjPn6Ki8LheGjxawoQKnlZfaxTQu2WExkD4o3kEwb0OowN/9?=
 =?us-ascii?Q?ZejDMUaNugFji8efrt0FAHY4d8wPrYxRbVEAv/Jgyk3RabEVR6BWDtRd4YlT?=
 =?us-ascii?Q?K7lMw11VB/tBuDWYwmDAVjziwWzyV7YLQoa+s3drIbMGV0h2wZqzFkxYDSar?=
 =?us-ascii?Q?7+gotG4nraunBQWw9q0ir+D27uwMlYIt0Sk+SWLVTgmRQ0hGiFBA3ZhMWf7I?=
 =?us-ascii?Q?XJ2/qyjyM6ndhOl5cL0Y5rs7OZV8TDF/oelOEoYZD+tNiQoIb0QOGYXEPPuA?=
 =?us-ascii?Q?UGXy8ZBMYq4dJ76NLIPFcvKztrqcwaaI4hzU7C+VkIudnK9f2BDn6CpKiXXS?=
 =?us-ascii?Q?7WLcwEO8PTtwjSNratnq2kIW7N08ytWYtSqvvXjtAYScgxK1ZArIorxHlQX8?=
 =?us-ascii?Q?Q49CgDMCEmmkPz07bgqAt9S12xM41SCcc1sOtCt0T5ALdKCEvK3aurY50q8s?=
 =?us-ascii?Q?iEd3/zOuWvyYTOESF6qSFyoxF+ytj47EJqvPrwC8gxmuXCmaDgFVHHSArscw?=
 =?us-ascii?Q?7ty1OT1ATh0Vw4j4gM4y2bHBqE85z+6qyKnsc05p/2dYYLISeKXTOj2803Xd?=
 =?us-ascii?Q?PMad/IPsIGWY2Sbkr3mKA1LclEnl8RRTLuB07yLDl5S1IdRab7fvP1boLd7E?=
 =?us-ascii?Q?Xif+v0Kwxo8B3vMsIvQrAu/9X07uZ4d7JPlkJ4hyYwZMKKoAQmU++u159JDb?=
 =?us-ascii?Q?o7qjUJuJf9nZT9crgD16YClNddUhggmuFkSMPJUbsVryb5FWg6PDdoUAFcOD?=
 =?us-ascii?Q?+Y4oYv5QCy01KKWVfUsbI7gWun94QlSp5N7+es1ds1z0JLBn7HTfTrYQ/TTz?=
 =?us-ascii?Q?b0oEiW1VMMENG8rFDDlEDJ2RdAwr+JPuELAmT1XnCadVBNFc1FK4fZm7e3zW?=
 =?us-ascii?Q?n4uwlQiasxITYIWmpp5xJ+Vnn53xJCGg9QvWpE8dB7xadJqYYAGRtU14kld3?=
 =?us-ascii?Q?IZdMuIDVZD9H71DBFynWb/8Hwce+uEdgpBkzy/M86o/3ptjwOnKGOg7YbF7g?=
 =?us-ascii?Q?6T0PjvPxsI/KzEpFm60dyCnL6yDOyPg765GHkoEz5X8eDJzorMhDntyg1Aed?=
 =?us-ascii?Q?dzyn6lqH7OC4fPtJg5VX5+db/7QW87wQRH3393JqGEKmP0VuxZEBqfsaVTkz?=
 =?us-ascii?Q?/6XtU1b0abBWCaKHTlTtB+mU5Dl2HEycrf2XVPMHzbZXr/gK1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jUxScf/P+UZcQB5rmxmwklodpT1hI1w6gICJ5aRcl6wfGneMjZ/6WbJgz+Jd?=
 =?us-ascii?Q?VEEIN7XeZiJbB/xLE55f9DykyPEdYZwTwjMhFHvlGXk1Bv67uRzRvHM1vHhX?=
 =?us-ascii?Q?gqhEdrdHqtPj+HV/9B5DRkGD4whO5zf30DJlWG4EGhylh8YPrYacb+JrA+GI?=
 =?us-ascii?Q?kZPoyh5I6JaG7MIjec3VbW63AGnHMnomRUqFIBDm487LH7z18td2rIYtGx55?=
 =?us-ascii?Q?MwIMVppCY6gNXo0hejYnmPI0NilRjK/JHUjmgLcBgqy6gFWvU8rOHIxSpuGR?=
 =?us-ascii?Q?/Gr57vod0VZWrzSYjvdiE88EBSJlt7u2z7ptgx2kCFlzEC42mtqoYl+3Pz+b?=
 =?us-ascii?Q?kWKs7Ib6oF5f573vqAARBgrzVvosOukD/Y1f+gqDBg8IdTI5OLl0sH8v6b2j?=
 =?us-ascii?Q?PNzEkf4BDw0AEJxVYeQVNO527PLteoqK6Cb3M774MF0DYxIBvtjXyph4151a?=
 =?us-ascii?Q?85lUt+URmg2j4cDUSuj2SSx6HKEA8kzE54SLvZ6KMofleP6zi7AljGGcMfmF?=
 =?us-ascii?Q?SY/KiDdD74DDlXa5sbjkct59F+Mrj4xm152b6nQaKxCedqLNTtnfgxWXoRHi?=
 =?us-ascii?Q?2bYs03O8HaH9Kv4vWnDlno3lq/FOfrczuDNs7uiSmSWzunvjnGudNWg3d5z/?=
 =?us-ascii?Q?ycY0vTB1sMJ/u8Y56MlzDnCvithdcMIDhblLjxpbBqJr/L+3iwK1vNrhIW9L?=
 =?us-ascii?Q?TJrl+f15Si8CBj5WdWbneMNqL5W2kKhteQHC1/i92BG6wfV2/ZeWJyGLJHnF?=
 =?us-ascii?Q?WR3f+bCARzUzBTV+iVg9091RRxqdxp9CyXu9xlK7z0H5/IFWkjwuYFzl5W3u?=
 =?us-ascii?Q?c/9RllTaMMDZNH+6Qm4oaMCeGTRreGPvi6bZxs0umrt1jqrADEgmxCTu2bma?=
 =?us-ascii?Q?2nl/Na+rrzOjZVsVESdwquqBfCDw6vIcDmWcGEV6y6R4crsK29CEOCxOvEKu?=
 =?us-ascii?Q?2xos972+w/KSXAobcvrB1E6/OnwsyoqE6jXVD8QqmCiB5+EtqMIGeZE7IFBx?=
 =?us-ascii?Q?VY1RAzXQbRgUbSBxsnercHlOEzOqYwxyEecjfcmceSkks2fy6MdX/AK2noGy?=
 =?us-ascii?Q?nWo7JnuHUP5c91dtQpXcEHROS0uK/F4df6jc1P7I/LJoJIruwxImeRCVOcbX?=
 =?us-ascii?Q?QWyok16zl4lGqYfzkk+e0IesyoZUaSQ4G+QmKTPCUXW8TRwvmz6AzGDDr/Eh?=
 =?us-ascii?Q?2UaevxDrOTYOfc5vg571VbmIaPO8qCa57r+yUsJfDKe8p24sUZJbr7GQuELv?=
 =?us-ascii?Q?h6tFclDTtPxM2U0kT/L3Kim9f+w6nu61Y504CNm2QHJBr5xZH4Zz5Lu6/fN2?=
 =?us-ascii?Q?edh3DgO+sWllpN/OM5vuJbl5h5MIAijLitrquDvdS5uSpGH+qJFhyTKZFXw+?=
 =?us-ascii?Q?M0yGucI8CE5/8RPz5taSOMh3wuH7StEID16WBva58w0AjT8zktJsCAW2HNCU?=
 =?us-ascii?Q?LRXCOzo/EDZJ1b7wU6rGe999/M9eqv0M6S2D6YDAxX9cXuNEWT11edGTRuPe?=
 =?us-ascii?Q?RiPypKW1W0qyl9qFnrlZTGqL6DqfZw4Q4gFw6pAiFVezNBbIFrU9mE+7ArHf?=
 =?us-ascii?Q?DN4DTu0l5IuM0kFCoS/rdtoUSzGmuuyRSL1WdfIb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a178a187-fd97-4cb8-d026-08dd19bebb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:35:13.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzFgE440+sxCU9mQeZgwRUd0cxD2OroNxA8JSMc0QAdrJ+3VDyYOBAVHn6WTbpmR99O7EUZwBQUiOwbCQpoRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, December 10, 2024 9:03 PM
>=20
> The qi_batch is allocated when assigning cache tag for a domain. While
> for nested parent domain, it is missed. Hence, when trying to map pages
> to the nested parent, NULL dereference occurred. Also, there is potential
> memleak since there is no lock around domain->qi_batch allocation.

Out of curiosity. In which case does the VMM try to change the parent
domain mapping when nesting is enabled? I know this is allowed and this
patch does the right fix, but just curious how it's triggered.

> +/* domain->qi_batch will be freed in iommu_free_domain() path. */
> +static int domain_qi_batch_alloc(struct dmar_domain *domain)
> +{
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&domain->cache_lock, flags);
> +	if (domain->qi_batch)
> +		goto out_unlock;
> +

V1 discussion ends up with an agreement to use domain-lock, but
not followed here. any reason?
