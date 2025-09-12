Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0627279DB7
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664236; cv=fail; b=Zo7Ry8V/MGBgrlsITiKJmayhQbfZ1M92/Q+Iq49rBI8cSy9c3Hi/gYNyQp7pV06BiGiUDqPnrnoVknfI2rs5iIKXoFRN+vWveMfqaJuc+nwQgaMoirKLXvBy6no1InIpIkSgOkAIO/vwCA9aXSP+oI4osWihkRE4xdcCBa2ES+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664236; c=relaxed/simple;
	bh=YL2GstcGYsg7dCqS1fEBJChgJCDb6fgMCkvDx/hSkqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jr0Q5bB/PMQQ3dk2QPC3ZcuENkvrJe7/lJIesejkT3gfFCUJTFGXTLUEmisS/IlXnCQm37LB0OG0/BJzDkmsVdyk4pbYBfMYO8wK8jcD33qc035iPg2t3LmL8lKymKfUn5fEtUbtRaeSBOO0y8RTvVRBDB++ciEF0jh2b+ooE+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+BZocVA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+BZocVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757664234; x=1789200234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YL2GstcGYsg7dCqS1fEBJChgJCDb6fgMCkvDx/hSkqs=;
  b=V+BZocVAL28GOCQu+O9QPIxlvG1FoVxPNnkbIpqNBRm5iJeKr0V2Y+mA
   ixEJS/HrjPlos0wOBUp37vTx98/VpBY0elyrdkK0dFXsFAujNe71GmrAK
   RRP5xpdoItAZaP/BoMNamr174mPddNstYVu6joSNhP81JA1JGMfyIIMnd
   NClDnePOWkPeUge22QgGbomoZGwyleR0BS3/mrEsgHUnGl+7PrFDaFSjp
   CAVtIJGfNRSVVjMscjh5efVFUgIKwUnyWDRJfdqNUmGNkPAMzwmAj4vYF
   RalCd3/bXFjpqBWyUqcYPiRX0HYRfO+IgTX+ycBbLDU0DEK+tab2xWcZa
   w==;
X-CSE-ConnectionGUID: tmjmwQArTPu7XWg6ieQhlg==
X-CSE-MsgGUID: cgjjxMpERCGjBkbQqzUd1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59866169"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59866169"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:03:54 -0700
X-CSE-ConnectionGUID: sSeR2g9CRgaTL5nlhavb6w==
X-CSE-MsgGUID: 84mc9qTHRamATu/yvyiWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173076674"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:03:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:03:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 01:03:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiuumqYip/O3++9u9Bh2x4pFt4/47VyG1+djnzgQoqRIm2HWYmEsz4pZOA2F4Kz6FFOIaX8xDot1dVJfyrpU/tKXlD7+GUGbLd+U3yxNwzdnJseF4trMciKi1YdzJpMJLpOE6vbXZLj/J1nE1hG8aZS+FAnzIRWCP+Dsn6y7X4ZVFzXBQ20qH5o5RTWVYxLNVdf5NbdMOgQkUqmKp2EIhHxJfT9N9NE+ncNW8QB/ho4lUoztWjLkdsPeXZXx1e6tfchdTbRXxMPOLysBv86y/25DIVcH0pYD8iCxcdM2W8cI8Tt657gaqrNLBX6iedEq6TgOwk7DbRAThOSlHPueTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w70nifIrFfYrUBaola1etHKZpmPTLwwYPmR4cEnirN0=;
 b=RQ/4i8YDBHY8YdRvYQVxzCWd4GAwROCqJ69+dZDErZw9WXsxoM25JvhxZe5yAr7itYEJXSZnkBw8i3EsYBYNTVhJlAjxmi4CFPHn7hzwqlLWVAf9KK5xj0L62RmA61bVj5KepD0q2gwyHrYIe1ZZ8OS/gxF/tCkLR6DfweNZzA/gWixzLzXkbkCCJm7j5JrRcpsIldWle5xAJcOhs+k1YBsZSGEJd3+x/Ai9KgqIFeGDBSX6RBlrVMAUDAHgz4izYgvdxkJb0EO4WngGcioR7JFqTlKM336+2dvzkgDtjVWCwu0YQX5d+peXK5vvrSneYmsRPDPJXlCtj91gA9oKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 08:03:51 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:03:51 +0000
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
Subject: RE: [PATCH v4 3/8] x86/mm: Use 'ptdesc' when freeing PMD pages
Thread-Topic: [PATCH v4 3/8] x86/mm: Use 'ptdesc' when freeing PMD pages
Thread-Index: AQHcHils8F8okkd45UCwNEIq/7pAa7SPOtig
Date: Fri, 12 Sep 2025 08:03:51 +0000
Message-ID: <BL1PR11MB52711BC4FB805F572FA7260C8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-4-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: 7f67dc2e-81a8-4856-215d-08ddf1d2e901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?UthFw1OzidjakFoMMmoLLM5trG6vTMUASKwEJsz5qiqd8R4AIAdNKLJOpTYX?=
 =?us-ascii?Q?T80Ve5ts6B4CHVSczvFT1fZABVkcCt8hIi+sIyx9F+WKRMu9KwRHoZkffAho?=
 =?us-ascii?Q?4AHKmAz88dgBZ5S+75krqKBiZh8pluUvAYD6bpB6X+JHJR6F8J/MbFQFU1sZ?=
 =?us-ascii?Q?Z1cavMo+DiHhIu66eEySpCvYYr/O2ZKxFEPognvhpxAkhRE6i7RSAYhOuQk8?=
 =?us-ascii?Q?Y81JRkyJALXd+O8OMnr8inIHck5RU3pIjmd+bKwXyDcepBp4ZG8szZkJJrGu?=
 =?us-ascii?Q?pMUdm+RggiIjx8qin5y3WtVqW0vaSRpAds8flgbwwmX628E9j6qcsX0n6K8M?=
 =?us-ascii?Q?lfzJN7hSO2vMewPT1msisV0y9GtdokpFCOBmyU9oXjSI3HxJlVvYvBNeZVp4?=
 =?us-ascii?Q?wcQttFvQobqe4nExsmx5FJbWLjtnD3LFf8QJr6FUHJUEDsZJq18TsiNqkB6G?=
 =?us-ascii?Q?WY9YAYYFQjxk0c4RfvXtjxz7wEwbBDIw7+afv0OYq8BXJXlZ8qDEZS/kkUZf?=
 =?us-ascii?Q?St5Xl58bkjJjDJal+RNOE0sBXpgDtrT+JALzN7WOoq6Sc/vwTE3fOwF3G2iY?=
 =?us-ascii?Q?ED6ugpTopupZjKn6tj1CEU0jpY4Tnf0QrLVy1RqC9ea+NpgfVrrZaJHTxaCI?=
 =?us-ascii?Q?HSus3q6oihq92jLlhiKdqNnxWzerAZGeUnd2Bh6RkXQKCu2ekNeln4x/0wb8?=
 =?us-ascii?Q?hJNvpeaqpW8QwH5GaYKmuLI4wSm01z3yVr1fbkE+V8FC+VqJmexOwnuM9tc/?=
 =?us-ascii?Q?dAOJgbG0zsfayVAFYYyo9oF8mLY/QnY6WWSJXs4tWR+/m8kqFDFSCfPtk2Sq?=
 =?us-ascii?Q?kEo2+bJvaWEfM+InGUwVrXLtWtkruYLAKS29N9MmE7dKg3mgFUvfXwhPa4Go?=
 =?us-ascii?Q?y6SI4dpHUcOdcuWmvuE3zS9zbvjKxk4zLTi15f2AsoPUCqTup+ouBxUdAW1C?=
 =?us-ascii?Q?mEPUG0+1vCfZhF22pU+Qd/2MvoCtvepgWBon/ziUCcrFKX68jpMDj457Us7E?=
 =?us-ascii?Q?t4xpETDR2KCtoHeVKlXGCHTXArl6eRM0R4RfDnfYNhlKTFWl/Q0PqOmlUfXM?=
 =?us-ascii?Q?fqbj53xUlteZ6X+cjbSs0jySBCEfnR9Wa2t7KgwH69ZPs6MIfEwWK3Ahxrms?=
 =?us-ascii?Q?mdRfAzl2mcMGgejr+k0yNp1aZQHWlWAuKASOU1SvN3k7poTp9WxvDny7njeE?=
 =?us-ascii?Q?GvAnwp4/gfdt5AahTV0Y5lE/HeU33OBCP1fTIstiXaaemQ+MhJyaepSecIIh?=
 =?us-ascii?Q?rEibyxM6wk99N0nKkpfkbTbQ614iv75V4tfgCpiJkiu+HwLu4JQ5nBmQoJ9R?=
 =?us-ascii?Q?Vrokc5spE+hZAceU7gkYctr6sHRZZXw28ScKMOpWoDCtufz0vVOU5/WJB7si?=
 =?us-ascii?Q?QB9N9la3cO0MdV5HN1MSkzE2UqfPDcbZclNs0q0OmFivCiRXrSVSjWz7gOFl?=
 =?us-ascii?Q?zBn6clc3FPTqbI0zr2uRLsQFl46qLzfiM1YcYFhpq7LoaPBuRRIIDoPrmRG0?=
 =?us-ascii?Q?O2q4ORoV1mkY6uc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1G9t7f4MIjkFZIZ+kiRTzzXjvdg589aF8H4C5vxQYt+AZrmh3IJcdNSa6AG?=
 =?us-ascii?Q?qIgzR70nrCShYBT1cSLNNktaOb4VHJex6wQetLHaIJ41TcUjDDYpwkdYZGjo?=
 =?us-ascii?Q?lOf3XTFv0ZhK1946vQG9mi6FmfKi3/4MlCDwGhn2VMRvLFl2jjweRSCb2Bow?=
 =?us-ascii?Q?edIjQCaD6VHfj4M9sy0kv3sPjz4otCiAYOg9wcjPv8W2G/UqsNnzcvoyUnHX?=
 =?us-ascii?Q?1dSxD2jeXSpmFz1upNNlSH8j0CdxqhRGtMGfjuyXV7A/OkIoBNWhogdvWfU7?=
 =?us-ascii?Q?5bnj4+RkkzmgE2lUjTZ2xzv13K5H0tGD1+BeaKzx+sDhG+VOKc7TcQYf/QHG?=
 =?us-ascii?Q?lQyd8uhbOimsLVSdPzhTXeXogEVgAiaYbS6F5N9FT1S172cNtJMAd9dW3AZM?=
 =?us-ascii?Q?5KBe7F1sACObm2m/8xnEzJCpLZ4wKo1Lbz629Ppf8GXZGJYdv5TWyF1jxzB6?=
 =?us-ascii?Q?Z4+PJ5yt1SbwJfk1CBTuGd4D+Bizr9vc6vg6cvD6RLIn5c9QNouJWb6emqRd?=
 =?us-ascii?Q?BUuwhdmluD3Lsdh/iAi12WEAfSdPq1CMWmmzU5zxUs60uOehwpzDn2ox7ZYB?=
 =?us-ascii?Q?1WbNJbWRDkawwY/jM2IFPVB52eqMBZEB0vm1ohEcg/IPNoGigfUxxcjya2z0?=
 =?us-ascii?Q?XPfu2zMZg82mF4H7b9PrqTMtrn55kNW6O74TqZ9CttwIqeKG/5pP1wj5UxYt?=
 =?us-ascii?Q?o0vWUBfUJz9uvRd3gErzIGrFYlrW8iC3tzDJg7Zg8jUY6wB9GXyi2dSLf3XL?=
 =?us-ascii?Q?lg3DvT7/+SirSBV1JsjQ///mkTrt7Fqe5q+CXWR6AXBUxRdXWw0RB8hRDOLD?=
 =?us-ascii?Q?wo1L0XyNkmWF3AfcGeMDj/AeSnCyw44bM0LahCvjwNWWMrE1d7S/FnWE88Kn?=
 =?us-ascii?Q?XPVLJsyckA1LZtr+amX1ikB0uHEGnIOMOtGzffjCEVWv8/zkMe28g2PO29pU?=
 =?us-ascii?Q?jt/i9PjfODA3XKv7N/jxXGJifWC0UgRKnbafr+7PuxTTddq8vATSfYOhx55P?=
 =?us-ascii?Q?BxW/MY/lgBvzQYrMX/UR3NCVvNKDoFY1MVDrhkCKI2v3Rmmv9SRTg9PTkNMf?=
 =?us-ascii?Q?lnsPUiH1+PGcO++dav8cxve7x654VUsk82fjgGjT5H9TuOzdFb/cOS8xsC69?=
 =?us-ascii?Q?QCDLIegAG387xzYZLy6F9K53N6L6QVQIc2whv81iWruRvdxbkeytnaHrs/F3?=
 =?us-ascii?Q?EgGEEDfWPe7q/ufSbljti3RiVVMMJof2YDEp3bP8eY5jagd1QxUhRz9KdBRW?=
 =?us-ascii?Q?awNwqN5doy6Yh0Ib7gP2picfdQ7bdSE8HVeqNRAzrSws5BuH3R085YTVPNT6?=
 =?us-ascii?Q?CoR9Yq4tfuOnw4sjAuKlD3j8jrsEVKQ/Hdl7E6MARak3ZKaPlwmv/vm87DHb?=
 =?us-ascii?Q?dGvj+DwAEOmw4Qz7W/IQ8PBeOUjOlo03Xyoe0TjV9VEhtiMeuO23cPJvNwxW?=
 =?us-ascii?Q?ovlW9/sYvOJTJAJiKcGPver5D3nPYgGJniU5vdKbzTedxi4Es1ErcKd0duOX?=
 =?us-ascii?Q?IvwSwuBqWP0zm0nCHBhg5grgIOgHTTEmfjJWN8E2HICQti1LToCvTpuN8+fh?=
 =?us-ascii?Q?xJUyafwJKoe/hZdY/1Lx92xwZYPM4dhpNjTzXBhI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f67dc2e-81a8-4856-215d-08ddf1d2e901
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:03:51.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFT5QR7h83ySXajdSHJnTvCEpvrhb0SPhFuy836RIW6t3WJRpFZThT7CNY0TNziEYqAEpzQu12wlFdNUnIoJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> There are a billion ways to refer to a physical memory address.
> One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
> point to a PMD page and then call a PTE-specific freeing function for
> it.  That's a bit wonky.
>=20
> Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
> to page table pages. It also means being able to remove an explicit
> cast.
>=20
> Right now, pte_free_kernel() is a one-liner that calls
> pagetable_dtor_free(). Effectively, all this patch does is
> remove one superfluous __pa(__va(paddr)) conversion and then
> call pagetable_dtor_free() directly instead of through a helper.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
