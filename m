Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAD37C105
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325716; cv=fail; b=RcJOpfNpVIaR/VH+G2f3O+zzyRe8grSm7cAsjsyzjGwUSR7qHSsIp383f6bYMuzJUSJLSlZ9+62SdjJPKkuVjtdNoQq54gKafBvoJNIi+eirhhf19ndV28vlHJ9c2Rz3xbdvhpK4P9ji8KQt3ZuuneTHBHZ5Y8N5QIfeqFQqgn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325716; c=relaxed/simple;
	bh=j5leLRlcM633jqzSMrT6QXODKAtUT0wFvCBnwgzd94Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PteN0QjJZooZBuWseqKgx1KswGhJR4yK1Ux5T+1kyhwfjxo1gmyZZpYzTnmOMGkvzOndvFCpdvd9KKgwrcmj6JA7ZRi+F1GUTJAzjNYRLm7+3kjIdUFxZ9T6lQ4n8RQcFCzaLAA0FIB6OurPRSRJ60OHdC3qWhI8c/+3XdVFLYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byTClXvU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byTClXvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776325714; x=1807861714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5leLRlcM633jqzSMrT6QXODKAtUT0wFvCBnwgzd94Q=;
  b=byTClXvUgNFOY4BolON+yPbuYU/J2f+eMvrPxbZW0E4VaqxReuzMrUoF
   RKHTENsVBrXVf88TX4jQmu4tHEbI0YAdqK6emeBSFaTMTopuiIfArT82r
   ux0VqkA6LGLwEYKjynHfws2Olmm7/6If1oHFu+tA/9Y63qKh8lae4Ymps
   AXY3xXhXUI94yx/+rp5Uk3255jdySUsslFF1bGcCP2QxWIxsOR9+H9v2K
   fsy4tIXmJzFWUQDnigpZzVadujIzZE04b44Vy9U9Q9hun1h2SurWJ6r5n
   ONoc4AUz63etg3bYt6hXdkRarNd3DQa1hjwM3ucVQ3vOo2ul0lGB14MqG
   A==;
X-CSE-ConnectionGUID: XvpQ8bSySR2cW1LIlMQ8bA==
X-CSE-MsgGUID: X64ePS6JQkSKj2Att7m50g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88767656"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88767656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:48:33 -0700
X-CSE-ConnectionGUID: 95Tehm6XScCnsz0xJA0X6g==
X-CSE-MsgGUID: IhRgZpCHT6agfRD+9Zgicg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227999668"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:48:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:48:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 00:48:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCz1MPlZR4aK/zbqqx06LwJLsOTs1q8eWGNcZ8XDgVGUIzAgN7B97M/QxFYipVW3zw7sKBTcAcybUW0D61sKLXO/+ZIJj/qZoi9HNCSTDRaoKaV1ex3GEpFp8OoOHIszGNfzwB3vquobdmgDJ7909Wm8MXk/NVXKgsdLwaRSfO55KGWLEMInfCJNl8ztXv8jVv6XrL275JP6unuod/aSpSWf8TSnGxHzh0mDZ//NpVxzTl5ZzL1teE8ApIfNNlE6LnEfOy+s+qCBTm6oirVH2vZuuYLh1UiC+kkxxL5CZE/vEEF6K65u7zuo41kV/EbmPyhzLZ5Ka6BarorMGWHUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7preG1B4dzwz3tCGA6nL/Xs75955vwSWkKJ5Alij5w=;
 b=gXx6nM0XtZksXlQmNT2lJz7WELIxiqQhp2G4+Yl/NpG+tz2hFSVhyWzvOhLc040QaRpENp0u+Yi508AelPCBnKAZHguh6XN6g6NccCkDsslhEM7g/YxbnoJQS52jyWAA/ZxkPvhS1z53plL59csirMEKsC/Tx0KVZXMCI0RWouCLHpvj5pwmKBtyuerNCco1swgdRCRmGwSG1TlAjujKVRwl5IE8Zc4LtWebpGBClbmilAqxAlz84e5ICtdMCcisWZBiFm3YL2QoUsckUy7BKy3vsrmzUKlxYegKoT8ZCQ2M9A9dcPL92nFor1eNGtSSnAsjnZPmCgeL+lKTpnjoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ5PPF66B2E927F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::830) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:48:28 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:48:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 02/10] iommufd: Move igroup allocation to a function
Thread-Topic: [PATCH V4 02/10] iommufd: Move igroup allocation to a function
Thread-Index: AQHczFOvIvHbSiDhVUGvMOAWF33aArXhUeLg
Date: Thu, 16 Apr 2026 07:48:27 +0000
Message-ID: <BL1PR11MB527178A84DEE234931CF6B268C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-3-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260414211412.2729-3-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ5PPF66B2E927F:EE_
x-ms-office365-filtering-correlation-id: e49fd3d3-90b7-4cbb-3dfe-08de9b8c8bcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: CZkl/NrIGpvgSM8ldLTEQZorX6et8hiaJpLsCW47BEtH/ybtGYMyVgRCL1T9NGkGfcdltNIEFLc/SlRRDA9vJ13m8XihYPOuhKDRgmRX95NParyV+URI3dfHFoOBNZ1lEhL1xgHC/ejo1FJBZs4QMGFqnrZ+x9cDtBgWpyGObt4Uk1xO5IP1i2hEEm8OsR00sb0n2LBPNPH+hvpF6XMCG2No3D01AVWKtY9UWPUoHgNPYLjm/lPPaYZQ2BwE6M0pGANJuCpNlI7TS6x2484WnOIT4B2kB+j7S/alOR26ExKWthR0cTP4VdveaJyylV9VvxQYvlTlWX/cq0dE21C4LOXzLsV3PRkPbtF8vE8pRd4z+Z2wAufoQFAqwQp/c29z+dvky+A/gNMssuEoXISkyuMMDWvoP0792XZPpkHUMJopzSxJk/AOGfyqBsRpPkYwi28cdOnXfIlIRKrcFgWUOekdPzLm2MPLbCjaFKBLktfMIkuljkNnsou9yC6IsoJUfNs5OvqSUNCzFGJw6CqY7ApipA7J74StpcE51oCJJc4TlgxIG2sShEYgrUVZ76bo9RbEHXyCi+F06B3C7Vff42qUbIoUAw6kQjitmwQD2tdbUiBCb+QGJeiSWNDaGwFzo+qEq6j1I3OEbbUlRb5u018Zipy9LtztE5H0MNlBR4QrVv5XiPhmx1LXZ+1iPgMARnQaxEJ4NFT+k+I0GS4dH2uHH96yTb3y48MvxMGd4cmKzkL/sK0zY3xCebtLzEoJj1YhTntFksAY9l1pgb+v6iEQTMDgmb9hmwtTiBiWeFbjqPtxcyeFR+t9m/HdtIg5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LeWu+RxYPbmQQH7u8Pj/nKVma9xTlkjiLCBjiFPnQOR7kBtDzgxu2s1hn6Bj?=
 =?us-ascii?Q?Sp6a3I32lR8oXI5gWBmNJim0fG/9zBiWGNKFGH6RtfzpXrFHQGSAGqW1E86o?=
 =?us-ascii?Q?NYPmcij4qiaY2mj6/zGR3NbNcxD88SsXbY1Su/f6SH8+mmCuLAJ2mljF2ON/?=
 =?us-ascii?Q?umLGTV6iJQsVGtUVGiNxUY0mQLe44K2qbOesub9m888pH2fjEeWR1ZFC7POC?=
 =?us-ascii?Q?H/2kbJKPXBtUtWHbgY3eqEGWr991qsdFT/UHvrA9eLGuWsOcQ29X52Qo9h84?=
 =?us-ascii?Q?L17ngv/VRLcO23vq0q3citqAScxPZCiHFGH/yIMyMRIWKaVKF7865NCEHCei?=
 =?us-ascii?Q?Q8hzoc3mbudIykzzZ6gHC0WpHs6WwYa4JgNgeW/uC/3G/EUDrM2SoROufZzS?=
 =?us-ascii?Q?HrxEMwr/spX2XsJHES8loj99n9i/EhJ8pb/i0Y6Fqyc3fgmuy153CUDESmce?=
 =?us-ascii?Q?cngcyFTjaZzeDIoIsv14WHoJJHk3qs2BgGnx0bTTaJSvDONunwZXH3q/XkCj?=
 =?us-ascii?Q?hI/WFWoujwoXknntmlezKqdo33x6kbKat3PkWYhxMrIGV/lHK+O3sxBj64z3?=
 =?us-ascii?Q?ax4QtRW4VTJFFXMRWGRtW8WW0jooKW7q7JXxL/fkP1z0RTcX+eMSeOPTSFRN?=
 =?us-ascii?Q?vQqAEeWcXt1UWRsQ8KavotMMSJwa0ebvvyYa+U37/dPCnhQpkkq0SOeIJhbY?=
 =?us-ascii?Q?H20tvQvmeyH/oL9UZuV1oikDr55rzh/9uZd8ET86ke4M2YKE6v+S1w2xL2J+?=
 =?us-ascii?Q?2K8TARB4e6zdaVcnP9ObxCTufFIu0V7MOljR6kC/06MFoNDtzi0VsMDH+SCr?=
 =?us-ascii?Q?mi8tEUlRFvEF/Qe+u5NoA0G3KTfx9ve3e48pwyde5bOuk44jtXr7lgpMqsfB?=
 =?us-ascii?Q?i/jd3gHdaYINpERyxk+nryOL/YyaLA3gCbz0D5uBdGkbvZkg4sPU8MtiH6Db?=
 =?us-ascii?Q?z6NOdRMc1uT1TO86+pXsBHBj35kQK/RfodHIuV+WWMV+kDBJ8MCAJLVu6J0R?=
 =?us-ascii?Q?hk4H1nURj6x+/nnnh3j6rjsWPfgyjIq8APvRAGedgmBfcAh7nzxTIsiFSCKI?=
 =?us-ascii?Q?Q7kBNGGfGQqfPI/pyc82M2hx7wYqe2Z22/tndY8nnn2EUSKTeibZ57didz+U?=
 =?us-ascii?Q?z/dpmnB43bEeEufyLIf7/ZK+9btkhjxJLwQofJA5ZNqD1QhRRq646qoPKvw0?=
 =?us-ascii?Q?6Gz86yQsw0b7EVDY0YCcx3VI7Ju+0IlRHc1lZwivr/IMl2KrTk1d2/yDBZH5?=
 =?us-ascii?Q?b1gDr4D4dt9lPDNWQK/hVpHUzlCYFlfCV0R3khJ9PkeHg+m0QmMcRyrLGCjp?=
 =?us-ascii?Q?+RsiN21QOeOYaholYhPtvCF8sTTWFygK9OMRwdFsV7j1xeUXBxTNOhXZVsiZ?=
 =?us-ascii?Q?QmC9YHrBLJM3nIf0Bu/+1G52t6O2W13tnNsT8NzsvdmHBkC4of0W8YzkvjF2?=
 =?us-ascii?Q?1YfgwnUDsb4xIRpFd+Gehl4fW4Xd/s7m4mdm3Z/x/PbGMtNEOpY0jONIJHuF?=
 =?us-ascii?Q?DjV2b3PtAnE+0YGLQYPEQlFiJe3GGb95ycZaNHH3Q7tkNOO/vZf8OgiQcZsl?=
 =?us-ascii?Q?8fomMra+jMjxjs+Sd3cTC5EOKPCOrYyECGWeE/1606mIfgfXHeP7ct2ESo7i?=
 =?us-ascii?Q?Wpq5eO+cFGZ9M5EEILHof4FLq2nWNp+j1+bUECieO6MzuAsAk0jLNfrh5NQs?=
 =?us-ascii?Q?2uSU/F44CWcwTmuyoS354niCSTiTxLD2AQyp9KTmSPn6fU2t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fcm4Rsr+vwqjpWtumnsh+yN8pr/CUzTT5hkQ1wcfVHjHPDsR7C1RJOvlzpbIbzjU/gM3HwvSY27mq3xj0VyPL0TdLwBxNn8yWlJkSrIIGKC4zstMOVxSZ4BrAGsOEj9AJicw/AwdiFhwcBdCK+LM6bfS1V1li61Eh7EtXTYHEZEgVkyis8AlCEx6kn7WNoB/DnfoE4F4ubmq3i9pIjZPbFirIPVL3jCDls/oBBepg3zw3ayn+3tJ24KbZiwUxnhDMeJ9tC/smPFMHjiHIeFmolaE5641gIp584UkAiT7u1tuumNl7QSHXNFMU5uYZ9a1p8KlW9m9IO2BFOU9STpzRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49fd3d3-90b7-4cbb-3dfe-08de9b8c8bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:48:27.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIWP0QpmrH0OsI2VG0swqVZF+5SS3RDc0uvCGOPLNcKpFvVLW5XUHOFH7lopqxZ2ucn57iJcMpLSeRtLea90eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF66B2E927F
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, April 15, 2026 5:14 AM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> So it can be reused in the next patch which allows binding to noiommu
> device.
>=20
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with a nit:

> +
> +	/*
> +	 * The ictx is not additionally refcounted here becase all objects usin=
g
> +	 * an igroup must put it before their destroy completes.
> +	 */

s/becase/because/, though it's not added by this patch
