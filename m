Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98737B41B
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060248; cv=fail; b=giQ7jQIwmyypd0XAFC5bdP6OTqQP7yk80PazjW8q16x+HFeQBvJzRu8yYpUVE9AXj6q1KB5OySMXiBrJfRh6cT/RWahy3JsWERdbGs+C2nQrZ41e5iHATEH9zmTRTMUzO1BoVVqkgHd/eA0l9IFVAWOTmbfkgC+NAbebVxwF3TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060248; c=relaxed/simple;
	bh=/AJsEreI8Z/EYXrGnfuFnrecOwm/QhJznY5hbkWyWP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjFjOobGJ6NiywNoUcIpZ4kWHco+fQ3J0rKGQMqChSfOS8UQNQLLO1ctYbBbdCpSoGgTPUppzhn9n2XUUfdI3FoUjf2VN1hNUP7kn83eI8PLMM3PNnTT6SLUY6e2oP5f4wxNEigBv6qJPpBCr+lrAVjyai6E5Y2NjszAhVKIyE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMMCPM0r; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMMCPM0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783060247; x=1814596247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/AJsEreI8Z/EYXrGnfuFnrecOwm/QhJznY5hbkWyWP0=;
  b=HMMCPM0r6QaSYrmkA1ywPKQViEce5vfywmQZT+JI9+uwVobW/ikN1k8S
   +LnaeAWNuJW9ovVjaG8094lSTcD3lbQQonDwGlTLd4pGOFGuZPgHxfOMf
   d4jYV4mtEc86QdCbmnbKsX25QQIPAEaDODPQDKdZ1qlr1Zofqe6D1vD/m
   IM0c5emT9mn7Ao5Pbz3n43IXbmqbNN/kFEE59mdEcQwd/CE9lExzK3SSq
   Dd0ZURaUjVOq9zLiewWrEW5yigk64/WEbIV7gtKHkDPsVblJ2HhXpfRpy
   nJ8Q0g2ShR12viiq1HA3UEx/fsF0aQRUydMeJi5yoFJEmu8+bPuLgOGMn
   Q==;
X-CSE-ConnectionGUID: 9fX0s2GfT6eZ9DS4HbDNxw==
X-CSE-MsgGUID: chdWCqXPTJWfzQ7bvs1kYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="71331089"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="71331089"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:30:46 -0700
X-CSE-ConnectionGUID: egfIANbJRwe8UJQ/ApB/zw==
X-CSE-MsgGUID: rwsvL68dTU+G1q3RYt62vQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:30:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:30:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:30:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuZ2lqaAOBTbGF2x7NqVhpfhOXAFO26JLbyuJxszg+fsuEynHZbVuzBuzbPaA4wkShPrgw4YYs7hAn3uLCbyM6ywGBtG3hXR74HUz1kvCLPaBIoNhh3D3IHJdZ+UaFdyPu9xDwUWCy7B6ZCu06WLYmmRjz0KCl9ryb29CgwU2t1DZErOEFUmA5BBkUAlU5uHoePDHOcmd2mLTH5yC2ynw/RcNSLg9CBp4V8ztteqErddNcWzDy+aavqQneeTq1XdDMQml5vtubqyk7CcZprQZGUSRq30dSKeqgSBqnlmju2OnSlZJEfQwFw5cshExFpoi3xuoh7C0pQoy4jAGG2Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hYWlpYbcpuNI1zeEdAD8Tl0Ii7ytqO73IKUHqa17PM=;
 b=s/A2/itB7DAkunqmYTHy+BVqR4jHdyWq+v+CgDIf0+L7zBFqSmAQbwpUvcvghbA2Lf9ugq6m5grprnDwlpdtpvzQ/Qtl6NX15andAbr2ZXVvFGenpVP7y2tYL7Ky73PAfo7Xjt3FtklzlvgZ3L7KZKbmx8RLuB3k163p66HfXnkLwvKAFzDWaK94zLQWKy8GMpFcGr/unabIyd0+E2gmT8395nU5zt7wKLkcSoraMgsL6YdZSjfHSWx5ty67e242ym+wRNaSelMuYcHlG3wUkSp/PWQlFf8buhowOjMB/f9ur+5viNkK/KdC05Os+TTevbl4LbomuRlP/DcRAfdMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:30:40 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:30:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/5] iommu/arm-smmu-v3-iommufd: Convert cache
 invalidation to the core array loop
Thread-Topic: [PATCH v1 4/5] iommu/arm-smmu-v3-iommufd: Convert cache
 invalidation to the core array loop
Thread-Index: AQHdCAyTgXbqLUVrG0qD+/h81XKSKbZbWl9Q
Date: Fri, 3 Jul 2026 06:30:39 +0000
Message-ID: <CO1PR11MB483563632B48C94130EB039C8CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <0e89c623d10ba40e317067e304e30f52866fbe49.1782767398.git.nicolinc@nvidia.com>
In-Reply-To: <0e89c623d10ba40e317067e304e30f52866fbe49.1782767398.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CH3PR11MB8751:EE_
x-ms-office365-filtering-correlation-id: 16776f89-a395-498f-0dd0-08ded8cc99eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: s3uOiRz+1DqOUtIdpYUZyd7PvzDrZ2j3wgAnOzhnRqcuWmE5UmzQtIyKm031uw0AqZ9NLDA40udWMu5TWLLDXoRwHMUV5MfMh3vpy8XqHO0nwGrv29fQJmxDgs1DrUHPMz4AfyjBPoeGeSuimhtGEwQhKHKfAlNUHtcMUY8fGmizyh7PjNA+wU45bp/dkgtNzXhM0Mdz2xfuLM/HTsm86d5d6C9qNYnAI7OsxinYTkXDtAixrpyaJ2jDBkAzSLxIDCsO3NMhLbjOCMBn3in9HySIUQtQArIi/gD7cZRS9T2M6WCiuKW9Y6NQMzx9wwNoyudO6kowZfZ1HI9ijPawftpianySqeRKcgCVQVLmblmVnc5CEDxVCnQofXbC6gw6DZCkYSAAoLm8tW0b2Q83vV7bWkV0FQQaG2aBgMFRbUCRB6/31u7rm0dDEI30AMCQAAlSMYdX3O5wu8dQN0DETjw7jAeggkQNeUU0bBnReOc/WH0RO0SQ17eX2h8qx7MrQdzPSdE9XuRuBqbIL33ZRZ2+TPTkPI/yvdgNnjPfwVLCJN3U4r3QzrdnQHQwErsqgEoTfLCbH5max9mnaDdy0cnI3iuvFK6AL7gIO+v4Ylz/zZYdL4surjtPA8d+TPTDPsvvw6qo4yzI/6a2JgzrUS/VpN0PQFHK3HAd05AWrscaIi6X5sGcrkVGi4ru3In3DjSued3Kha/eA1eiZpMo/uiWZ7GcHGKGxc3iLj/lls0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q8dJvnnnWNnD3mfRqiVZEPiSVD/mgRROynUUcE9FkOK8n1aX7c06/FG7t3mJ?=
 =?us-ascii?Q?Cure8AzfKhI7ex7dvjiAa7uQLBylmchT3FZbPDt/wncD37jTXeBl0lJ/guqs?=
 =?us-ascii?Q?1Juca8wYtHTsjT700/N8mL0Wp2cJ6n36S0oxvC1V4IZZYVPygDtplSdmltOA?=
 =?us-ascii?Q?bhiiWWKNMNi4yX9Ady3E/JY8yjyQkqPCmfeI6uPUluYnUjtZWxCw6PjqmY4j?=
 =?us-ascii?Q?lw3M42JpG+ePtB/MPhoAD1h8v9jjUsjwdFFcdHPQREsfnKeBNPN9HeIKT9tI?=
 =?us-ascii?Q?IuZlcA3Ha47H+Lwep3aP2Cx2PGvNplcBs/cVtao97CztkLjTaYSClzpeGC2A?=
 =?us-ascii?Q?hrMo+lIhgXvTWu6MwTaLcZuiruyw4rRfh+M5Ev6K3EEq9sr5eQgwBaiJ62ij?=
 =?us-ascii?Q?yi55SGWaxchrXOA3nmM29r5zzOPpCGNlt9wj/0d3Y8jcj5iSBcPatHFxctxr?=
 =?us-ascii?Q?4NLzwcG0W7VFwLAtDJxenezP2jc4w+X9aqzsoXRb9eLLojZcmtnjhHDJq7/C?=
 =?us-ascii?Q?pDjD1tQN2me8r9K4vEddp18qF4CAxfnhfAGS868PoCZtsGFsrfyJsNPZr0Dm?=
 =?us-ascii?Q?ODNBDua45stC+8db+PMX5CVlcyWOEY7rF9vUaJJfLD5UB1e1bTRsiOkeJTrU?=
 =?us-ascii?Q?Bov4fsgGRwF5W2UCE+7PWfOFeFz21cQo6CZJgEBX1NrK4BH8c3D9NUFremmw?=
 =?us-ascii?Q?9V9WqKSKpNovbLUf64334J+XYtxCjDGWvvEl7oRM90Nc4iya6go61RXZ+kDJ?=
 =?us-ascii?Q?dY/PO5uKmqK1JjHW1igz09zhDck1ZoK3l4kEpfXqt2hvbE9KSH7iKynipAHJ?=
 =?us-ascii?Q?d5K0rPl/mNYlrWnMDQSLPPuVbGFe2K/EFP7/JIThhb47Xruv48LLudscdHBa?=
 =?us-ascii?Q?shKHu0VI59tYjdWWP2l4dGno1ND5Nn/hrW+RMX2sl2dEKrQx9eLDJ/M0cv3G?=
 =?us-ascii?Q?UjX6NL2HQWsP3eGbWrKlh1by7JBwBvlK7TVvSRURw9uUi+KnS/H7rDhEYjGY?=
 =?us-ascii?Q?A2f1WWKOW0VbEcHGiOn3whnmplcuJUPH+EPCSHQIcS3GCSjPCdiarNrgoLB0?=
 =?us-ascii?Q?Nia1olil7L2xVaSXzhlR/kJdr8E0Yxacnqcsl7JC5XII38HCsDsWR8nzQr8Z?=
 =?us-ascii?Q?4WMYDlsKYvn0IfW2AQr/Zz1za4k/4LsSFpvAUq0vdiRTYT4Cb6s/J73RllO2?=
 =?us-ascii?Q?tJoz5f73TAHwuxS3gazjl3NQA0iK0D+J1jGoLgfAkTwROyIcWCqpLOm9PBoy?=
 =?us-ascii?Q?f71KWTDGwG8CFrtJSg2joFZAfvRxEcGXOvfkZieOrRKyz12hYwlv6Z7zEX39?=
 =?us-ascii?Q?uJh7k7ewa/ed/kYCJO9WZtnSWmP1SW1+Z40Ung7F8qwvEm/bfQ9FrorFavi7?=
 =?us-ascii?Q?V3FpJxcMllz+FQoE6HUzLQqlMsc2yJJsVIifkp6F1+Z6Z7dzumA9cSpZ+RlO?=
 =?us-ascii?Q?UJ1Gym3xGNrh9RyGwGIHBUHZP0T3GwjJJGSgd5+W51PG5sv8vCZtUPFz5nCR?=
 =?us-ascii?Q?sRD4VAwGukPyZbxAS45WP5ZWqTcZiInaGyxva/ghpnljlEXx2etU+HeQOB8E?=
 =?us-ascii?Q?XwqI2yn2kSFV0hFL+xC5PShQhAqRw5Ws5vpudQGst0saPfrdVqMmjbQ/Aimi?=
 =?us-ascii?Q?mqk18HMeW9wizZqt1SrS0M4aq82EvBcKTB5gKMW4AhWoOGs82zz5rni3chUQ?=
 =?us-ascii?Q?+LQUP5L3NNR+LzQNTLZHpjumTmt3OcShzix2ikml8vhE6C0x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c0GGAWGphS8vh9saWCqpWQn6VbBQ5BH1csynZk+MO+649DNYvDR+PTPZ9OKZb1m/sGnYTbRFSuU6uEG1cswquqfy+L3YLdgZBN3NEp3PoQllumq6pXtPkHsDkguANrEqYiZI/FtJ9jVcljXxoqEF7quVZL00xjCs7jX39zY6mp9SgAGetjAPa5HsJcK7MsqRbQ/Q1E+M7lCqoTfW7desYkwb3CipOZ3hvjRJnWcZLrP/aKjZrMisJRA5McQ9xWuhF1ibpxcpKYYAAMb1hIYUfJjXG7ArxwMs4DcCNhm9N+7IVV9XvQ/pdRp90OAKGgsHz1Vw4FvLNQAqUI33IylmlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16776f89-a395-498f-0dd0-08ded8cc99eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:30:39.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlNqKcrD+irKkzXFinOprHOMLkk9Nr/GZWr2x6rKBrKSkmOjoHI5y1cFeZfSVc+qGcwzcBjV0TH6ydypqyup/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>=20
> +	if (ret) {
> +		array->entry_num =3D 0;
> +		return ret;
> +	}

this could follow the mock driver to have a 'processed' variable and an
out label so above and several other places just use goto.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
