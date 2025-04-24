Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9A1F2B99
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480327; cv=fail; b=WM62P2uXb3VX1FxtR0igfPPvta6PqeCzCGaCNPjj28Wv+bzy9w5y6ytOPkuTMGH0UmnCoFcHAcgH0Hdm1ssCSJ80IWyfvHrgy8KAIV9q10odRwb8IPPR7rZexbhYDHgaPknONybZ0MkclEBxOycoeUVCoj2BRT3KujH0ayrzObk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480327; c=relaxed/simple;
	bh=AYSyXkpYxeGew0FHCo7MzIhyOTXYKrTzIawjxslr/9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfBkI6AcIBUhc9BqpxG04msVnvHM0xmLN3rYVwhFPkWev/+mpFW/IyrsiMojI3lKn3RdZF1tEhsbspzEUe89CsE/Kn/6sVnA5Kz/cCRfvGWKr/EdXSmZxsZG1y0tGo6/qCJtKTOzfRSMD3wD94WDq2Ynmv/TRwVCeQlIIHaP7wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gvf3ivC8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gvf3ivC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745480325; x=1777016325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AYSyXkpYxeGew0FHCo7MzIhyOTXYKrTzIawjxslr/9Q=;
  b=Gvf3ivC8DHoaPl6E6HBovEZGG7C0JZcvltFv24Dh6UWdZBy/GhIbavd2
   IjSOU/teqwyWKS2O9Y2YhpEhnw/XprCXRUH5UstXk4ELbczYaSenwLBnU
   DlpzkhCzmuODXT79Pls9AbVFodT6kgVWQmq7j9bxW9yj+V7o2Ux3wBLKM
   WCvHdKsxwAMdEuhqBHlJTsw8i28MKKLlwyT83UMLPNS1xQX7SY8FFE+uk
   gne1Uy7dcQY5f9qLJo0u7Ba0ftvvXKbnwFMBnyy9ogiJEX3wS4Xt8CTtz
   bpB11j9HF8olL+oV0do9XF/iInbDUmEM+QyGK9R9vI+kipXvRtioz96Fq
   A==;
X-CSE-ConnectionGUID: ZPR+rLv3T4mPeOlN3c2j0g==
X-CSE-MsgGUID: QTGxMBvES/2NVj8LOJMTqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47232366"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47232366"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:38:36 -0700
X-CSE-ConnectionGUID: vX4Xky5YTWWp3WInQjftgQ==
X-CSE-MsgGUID: 06aUANesTuuiSNA/ryew5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="163577862"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:38:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 00:38:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 00:38:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 00:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMRP/VT6xwTuCaul60H9Vk4JsRnOcaL6JJwbcIG5etUD+vFsOKgBR3Hh9x6CxC8dn5GY4KQt4bi4jaRjvp8DfTKLiJIcH/PBOVUqXvoGk79/XKvVaBN8Era4Bl8B7um7va07KTrhNhR6bZNLdx3dFDA0ANt4ZLx2m9sRMKFVNlJZhkK3SIxMZigwwUiC7fc7dyVcpcmwcJx9gNqL7roDXk2WECpIAJVJGexsQP9gZ8gD5TtTHXUpGGkiFPUFlDW2a2d8Wz5GPND97gqAx0jftipFA4Ilq2V2hp9RwfuZF9+v5SlriczeE1RSYX9RfnNmhHF7KByk53qwZXw47xXo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYSyXkpYxeGew0FHCo7MzIhyOTXYKrTzIawjxslr/9Q=;
 b=STaSlNoUINa38miZ7CEawlMXio7uNQ4GPJkFTQHQcgEfhQHtgA3jxHM2JEkENeusGAk1T3StJGMZ2spgF1/07LpuTFIzTLGXamLCYrjI8RSu4KB+0GbAQsgSgc0E0djvgcvFXwkxRsQd7gxIuaWbfmq+QBlqm6TJJmNHpT/mVn7QtlwT4s0SQnNcG20dhN7VT6vLSxuPxE+FJl2NhlF1v2wa8wEyS3nN00FWVjMOBMWGFKlUFTotNalS3yVlqJnmVho2RukCpggnk1JOAwN7v9yhqAALU1Icvc5spytjlqkqdrmnAxeCxMkEtKtDFi4n15uB3xQ83fVH+sruET2yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8801.namprd11.prod.outlook.com (2603:10b6:208:599::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Thu, 24 Apr
 2025 07:38:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:38:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iommu/vt-d: Replace spin_lock with mutex to protect
 domain ida
Thread-Topic: [PATCH 2/3] iommu/vt-d: Replace spin_lock with mutex to protect
 domain ida
Thread-Index: AQHbs/05ZnF40s0szEWUx2H8p0UFI7Oyb28w
Date: Thu, 24 Apr 2025 07:38:18 +0000
Message-ID: <BN9PR11MB52768FF211A4E8D034380A7D8C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-3-baolu.lu@linux.intel.com>
In-Reply-To: <20250423031020.2189546-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8801:EE_
x-ms-office365-filtering-correlation-id: 11bcfe35-d823-4d89-4b96-08dd8302fb3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gP8wP/O17wO7isO+2zMhk3/pMQMSL2SJjgtUZ4Sf97vGqPLYuDEn5lPgMF9E?=
 =?us-ascii?Q?oB3Tamjeu41I1WtlGi1rIRYBQM+pzJOWxp0HpRUloHaxnbqpBYudX8xdVgFV?=
 =?us-ascii?Q?/7cRUh2uD4Dk8Ett1whrL+rmL/7AZLkAQdJvRKkF6n64i2X+BeBJB8DFmdjF?=
 =?us-ascii?Q?V1w7zZHh28Pmi+vcqApr2qrFo35OpDkTgw50Nz0ppLSHCrFD69Wfq5MJcjRl?=
 =?us-ascii?Q?Z7NPx8+iwnOgcFoLA4EWmgBA7BU3//6eGgEyIeNMIUkOBTZNIzBrh7wkGTF3?=
 =?us-ascii?Q?EhQ0l6mkSZ8+ycxpfjTlnFuURSbKFlgTejmKcPHPe8gCVPaN2lvG4ccS6f+y?=
 =?us-ascii?Q?onDI5W7OeviQOYFvBr4aaeSWzsVLGcFDs0VR19Q3WNOo3eLT01y6jo7O/FO+?=
 =?us-ascii?Q?d3McMqz4slRvGrI3bKAa+p4+jlW7Rj41NJZ4nMFRTcwh+iNoemQLqpckbl3i?=
 =?us-ascii?Q?VkJ1fTdObwXHdghLHDvo7E33J4AZGw4gBWdMXPLUm1p6odV94xW5qEKKI0zP?=
 =?us-ascii?Q?dme7yScFI5fjXhBCJSUMWsXaxLBBMLZ29Td3rFO18NYtYESDvvBMspCjC34R?=
 =?us-ascii?Q?I2hxZfmJ8YvIITkqORKPxBOanPQwkm20m9L7y6B/RCLbO48Nhm9zTzOVkTx2?=
 =?us-ascii?Q?2bIcmbez2jBMzcBnePj/od1RH2lxsxfGtlEUDJYw5lqQDYhesP9Hk2FADyRX?=
 =?us-ascii?Q?1A/oSiwxt0HF9W05gb6dri/EZ/wlkDFehkHQPT9HPEBTyjrXkRk1FxE9+M1/?=
 =?us-ascii?Q?3Gry21+j09BIT4PbMnWXuxI69b5TQ8is6bqfrwLAJbxQS9VE7Mzn61hlNljY?=
 =?us-ascii?Q?r6e9nY9kU00NS9OvR2uWrb9f0Sfd4+gJa/YLPVaSDwHYh2g9u+VMhk2DIfUg?=
 =?us-ascii?Q?zvVQwfImF+2DI7oDqEHN7EtZhZ1r0NxijjavHvvMzgvPLMlVnUZaV1TOBT8W?=
 =?us-ascii?Q?IAgbwhb85/hacSw6Th9qgEFnN7iLU9/RlvlGrbHvAwp8lYAKidjWCJS6E7pA?=
 =?us-ascii?Q?n45EvJoYb8kDjc76Ntg5Z5bNb6/1v25RT38Zb06FudDt5N5qH9rpmOhSh5wZ?=
 =?us-ascii?Q?fh1IMmbOVz7oaSYTRbJhbuMWvccGXehuvW9qaBuvOkTae3Awoz0/O5O0OpF7?=
 =?us-ascii?Q?FKm+fHEc6HMtWBLq0mheeV47Uz4e9SWx+16nOaOD5V5p8Gf26A9CEipZ4f3B?=
 =?us-ascii?Q?EjN+c4Z4zKwGJmLryq+XgqvaPUg4igSfjkCu2tJNKdgBLKffgAwzHf7adRrD?=
 =?us-ascii?Q?iBAU93fm3OzlqgciEkGnEQDWGP201jS8lWVduJiXQTEhm1qQtVKEtW1XjGQD?=
 =?us-ascii?Q?QcwQLc4udsYsvpOuZ7xzFZRpfkdrCgD4vHnVjeeXw/w6Mlj8yLvMvG0EntDx?=
 =?us-ascii?Q?QOkAjSmNXnhMx+LvXMRgx6RrQmMRoB1+ulTXD3+ns0qp6L9TZ7LZqfPR2Zkl?=
 =?us-ascii?Q?MgkzLflw5/NlskJplaQt8hWJwd68fKfTYmF8fseEmK56SASDMeI+tqRqFcso?=
 =?us-ascii?Q?t+5b+DsBo5PoZuI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6yVrJvtRX+PsnREY3HDgOkg7jlLhYF2KGYaEIilhnjdouAb/aNaUdxcrvuc?=
 =?us-ascii?Q?0P8XSeG8JRev8izShDsmQb4784UkA0Pid0kqaHglpMVe8KkUQnUePf80q9oZ?=
 =?us-ascii?Q?yJzzGm1hhk+Vzrwp919uHXQHSbVlGnjszQStVdvkKZh2GeovFQBJPMl2gseF?=
 =?us-ascii?Q?zCv67siumL2DqEqrODxkAgTckBquYen1s3b4vFDhoq1P5x+UcJXfFhrbxqe9?=
 =?us-ascii?Q?jE29qepRmnXRwAx+/6AFxiCc3bpCp+SyXuEFrvX0GzmYmSllfpWBZzYIkEW7?=
 =?us-ascii?Q?mWjH+XkZOjrWrGghX5W4qiuOsoXAxyWExVWBUMCIJ6a/x2gPY6/GiHghdurb?=
 =?us-ascii?Q?mpeySO2ngnKkdsGudFzJgZKdaBQ4tjLFJNAfftskbQo42NbR25OxNrRiu+1A?=
 =?us-ascii?Q?k0VCfhEZaNldUICo0tfG0F455AbbVA7zMysJhXKVUEaizy8vwOv5btJwPbOI?=
 =?us-ascii?Q?VKS0GKKNN1uI/V9+DUmZ/EiTgvSGkBH+We/65AQjEbGNUqnIHK6R64hNFZRD?=
 =?us-ascii?Q?tNOKku+0AmcNKdt+NmapPKWRn3+NkZ6qBl1OjWLcIfqGqsU30BrJq2NlC1E5?=
 =?us-ascii?Q?GblVA5OiaH5bZowVFe2WfKhz3SoibzwYXB/pTf8J5tiT1z8uaz2itGynjqy9?=
 =?us-ascii?Q?/8TFjGW20b9zMwbSBelm3Fq2g9yoxmsY1D1tEzAAyg+udWkJJcvLxh8rt4JY?=
 =?us-ascii?Q?S8x3wGx0LiWARViDcGcjHC69G00+Dea/CFkoSVWj3iR+lS96QV6lrcVms286?=
 =?us-ascii?Q?FEkyQ5mlwTYUIB7VDf9e5Qg0IKX599dI57COFltWApg+rPqz2IKaQv4lNSmB?=
 =?us-ascii?Q?8LzBuJaKjRAiaVWmnQ+fsauMawkRE5EEfi8EHJFzXGkXmUDHwWqC4CBQ46Vi?=
 =?us-ascii?Q?KCTvE3F490ZxhY0Zt5STz3XZKb5F/42DW0wIPecQzxtq2nCFXlOUnzzzqnCB?=
 =?us-ascii?Q?0sWc/8W/M4+EZ1sap3EMqznbc5s0IayVpXXI3YCVEkf/YQopyDS8To827m9Y?=
 =?us-ascii?Q?lG3HpyDbifz+IDFAyqDuTicuuG+cy2N8M7icX7s4PfXhfDUjEZv8QVkTuElB?=
 =?us-ascii?Q?UqvAXSCbDFNgUBGo2Wqc6gmvn3igReECDO+4zCtz/a/hUccGZ9sOzjcApqaf?=
 =?us-ascii?Q?sL/hruYhV1m0HRrlEC8wD62CsIsKDFEaZ+lFFeOEOcvNd5SPVcowW+HnH+y3?=
 =?us-ascii?Q?tUJTM9cEf7s4HTJaPg5IPcgFn+cKk8l9dFg8KNDTHQi5FF6Nf+DRVHHY2yoN?=
 =?us-ascii?Q?VsfBD8ZDNWYDYngpk6HtJHiIJdl2tmG7UDBhEUsseabizIPcwI3S9T0w2vr/?=
 =?us-ascii?Q?IfdrLnxMCQNKQUjJkl1449OQGNUr7sys6fifcHuOqGFjkxknMLtjxLejk8ns?=
 =?us-ascii?Q?otwoncQje/LM6RKWnZZmwRkaXJ0q72wqHlmQDx/UW2w94cEjwhvXajq1QgBe?=
 =?us-ascii?Q?LutAzbLO6otuWWVokDigG8X3JyYpiQu4cpVTzVnNSUsok099d+HD0Z2NRvdI?=
 =?us-ascii?Q?+qdJD9fzT0Hd617zPP+OVmu1qELwaE0EFYScRR7+Tb6teg9SiPc1YpaKe/iJ?=
 =?us-ascii?Q?Y/yKNQqINihx0a1mc32NDrOf0g1OgzfJfCigleWD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bcfe35-d823-4d89-4b96-08dd8302fb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 07:38:18.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHNJrw56Q66daNaqGq9MQLoDaosganmU9n6Y9HzdRjKtzF8AdR83EeVLNKWx70qfa0GiPdHBCRQ9WvQ/8HJViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8801
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 23, 2025 11:10 AM
>=20
> The domain ID allocator is currently protected by a spin_lock. However,
> ida_alloc_range can potentially block if it needs to allocate memory to
> grow its internal structures.
>=20
> Replace the spin_lock with a mutex which allows sleep on block. Thus,
> the memory allocation flags can be updated from GFP_ATOMIC to
> GFP_KERNEL
> to allow blocking memory allocations if necessary.
>=20
> Introduce a new mutex, did_lock, specifically for protecting the domain
> ida. The existing spinlock will remain for protecting other intel_iommu
> fields.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
