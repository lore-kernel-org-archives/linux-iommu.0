Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792642057;
	b=OppSyR9BhHZ1kpUGj2/sZmCuIUSNRCg/STuw5KHKhk5QIUnARZcTHy1IND18nmeOGQWw
	 NcrMnWjLNSRh0Xo3uPCS9hTwkwpK9RybaC2BuvGo3rf6LgcJGn0miQykb+iWiZDhUbvKg
	 03jJmqQaVLbW83/bbqIuZfzkLmV83kZ8Ne86EoETmYWIxcDifzeyI5rtWrRJ6YAZNH/e8
	 vgA0nUG+8hxW/Xj4hsnyD58O49DnfkDn9w+jgAFRvXKAcqolldBHUzVlC2EwFSidzTXCV
	 9zM7GSBd62pJL6vfjrwfsD5fVdXrYWFpDgB4NGMcpPBHPEHXIZ+PwJWx0xN0spx2xDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642057;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=VIg225yuMnEQnOR5o9K45UHm85gq6uIPY8vOrDxnCeo=;
	b=gKIpWCajtWSBHsaRX5Mp2hzrcvDJyCZzrnmNDFRgFhYa0VHf6hUycDXOGdVMEQLNSkOz
	 UxhRyK5wNXNEQpoyCdU+14ydJYZEdFrYj6JPf9eqEieg0LeUxdvyn1Qt2tgejmBgEpq0P
	 cTnYVik2KlPR4bF6pNbNuVMVbnNB94EEk2qpM5oi+n8XEPrWM+1Ui7ghJGy0ZC239jfCh
	 hzj1PmXvkUTZhiYrZaGvavYVNjigoKClfhr7rBEDjlEYJOxF5qGpjIJ4596AKdoqHtI3T
	 jPSQnGdMH0dhW2A7PWMuIl7dxlHvYbZsdjQuyfOWcQIiiFI40Y3LbRoxd5NLix4/D/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZbSu21b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43048606A319;
	Thu, 22 Oct 2026 04:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43048606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZbSu21b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792642057; x=1824178057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VIg225yuMnEQnOR5o9K45UHm85gq6uIPY8vOrDxnCeo=;
  b=SZbSu21bZc7e8Ku5+Eky1d/u8XLTvPpxQwZSri4SXprLhZln1/OiSSmq
   sT8ZibqXISNLKk4x4xwJDnxELQ7+eGQW0NryF8L44w4ualswspTRRRGB7
   LtH82ZtVeXnqJ3Sj8/ds/fsOeKYW9yg5M2EGJChS/KXUFNrK3+Jqbo8qU
   vJf/89QCSGNEk8Q4tm0M52lDTDETot0bVIrc07jU1FEdjiwG0t1kkcZ/i
   xZZdm9h6DORbhgwqt2NsOBNPvVeAjwbpbFq/1NH7VIc5hgj3GVF3abcUi
   eZg84EO8rea36dWfeewkIQQXY/DChHiMEzRVlVQCJiXI8Ig3fNc4nnEKh
   g==;
X-CSE-ConnectionGUID: SWUSEZftQiizIUi7+BRGcA==
X-CSE-MsgGUID: kQo75gaeTrigPqWOkn532Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1277779"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1277779"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:07:36 -0700
X-CSE-ConnectionGUID: vW23KGSBS7uxxLkfeyKfiQ==
X-CSE-MsgGUID: 4CDglO0PTeiMryGdkZOicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="5069906"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:07:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:07:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 21:07:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSapQGryrkweZEMXQew1huasAEoUUhAkYWlrN2cSKjJopGca+0UcRz2vZo4fTG5a9W5xPoBv9w2Sdb0dqh5B4OwuMT+tBYClKZxREDEyg4GVJBURzKaWD/TLYmj8XJj5kYVmdnFcLM/1U+gxAQBCFOEa9o0z0UjKi66WhqRTlaS2XwlozJuYyIH/O1AIeGN7GVxeqNwxrB+1aajs5CkCWmxSi5vwEMKt7MBJjoJmMHZHO29lKGga4stGd8KjERcOH9I//1NSJ2hepLNv5AxLCLIyQ5Jh92jgp0yW+iiHsfnopuQU8mDX0qHdox/JtNjvzT3bJwwxlaXuRBSG5EaCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIg225yuMnEQnOR5o9K45UHm85gq6uIPY8vOrDxnCeo=;
 b=TRJDzDgKhK93lqkhUJ3MEXX+kGkpPVWhs3npCvvDrkOGeszyXTcNcBEsoeq6OQuze/xP87I51sBYRpPj/HwTyjrzAL669S5jrPcLnnRWcsT5hIn+Lze4RUcjr3Ij7HQhEc52+k9xCCSFSk+3w0G8WZfOZlXPObRu3XZkE2TJbSlzGASCLA7uSm03Cjrm063D+fD3Sj6fjNJk8sv2Lcm9z8z6auVbScuvS2iehuImqVrlnzcUEuzo6AzjODoa0tGKEAdczg9eW+xpHI3weiJVQTxKRYpvwwvnCbamxFDt0dG15irMyP0Ov8vHYp1xt6Aale64qIcitHc7OWiQ4vtotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DS4PR11MB263615.namprd11.prod.outlook.com (2603:10b6:8:509::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:07:31 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:07:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Topic: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Index: AQHdXENN2nUblT22Z0KkGwSJ4t8pVbb+RqKAgACYcICAAOFFgIAAASOggATJHACABHHy0A==
Date: Thu, 22 Oct 2026 04:07:31 +0000
Message-ID: <CO1PR11MB48354B1C84A6BD16CA2FFCA88C652@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
 <23a3c630-a3ad-4874-b13c-b8795cd194a6@linux.intel.com>
In-Reply-To: <23a3c630-a3ad-4874-b13c-b8795cd194a6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DS4PR11MB263615:EE_
x-ms-office365-filtering-correlation-id: 5a3b98e7-6d19-4559-79c4-08df2ff1fe9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261021121427099003|4143699003|11063799006|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 07ck9twwYE9xweDJ/FSaOjmlsxZOJQKY4uBczQEevMyh66AoF6iGwSdnknaPcUyMfhbfZDV+IxcRJWCxJGORhxkRLPMdfceWcGGxBiDr/HsXNVGy8qhAS1lFU3x1KjsItgZ2Yks6at/1TIFrHcDH2vpgI8sDht4tgNur2cjiPV082LOLLPMFp1VZfsx2K2/pTJEdm1yz+CxSu6qi0z+zuMPL/u+LTsEtGtsa/Ip1ZMBU8ZJBtH253jWW4agtaEoo9rMERy4aOKij4doezcw0tdrxYNsgJG/tg6gdYOABRr8ffTvXwcx9Pp6Frg3ATP1QxpX3L6DI/rSX6zrmYMXQg++EyuPAnQL5oXiS1xnIEimk1FVzRDpPLV40BWtKagfucMxQpxP6YlL3SRlg6HiggmnSlDYVMcMB2AqIxaTXYmpIJBUdwkceLbp3iifu07iQf4H8jaVlHfuUeUA53cjizFWNa+ZC5JXvhoVidQZZ6SBg8cEQTfgqwUhBtuVawIErQW81sGEeTTZ6wEmYLS0EO3t1GZI3Y67pb/Hz+ICCHBJnu7wG9AUlq8lcG3LihAgpPm0qFc+WcP739usQrAqUZ66v3fmCWFW65g8n4Wi9npuFaDOhmL9KN5/GgvOUCxJpx6yJ++Er0T+IVG4C9xW1EAcvelqV7XdVqXxxdiV9cKDCNE49QoiMH8dGIW7outN8SdmHD9uxj8CnAbIkB1TZ+3OwNqCzNJQTuvXH6HwxPTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(4143699003)(11063799006)(10067099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3BYK3F0akxoQzZRSU9TUDU2bU1WSXFiYkZWQW1qYmQxVTUzY2RRQmlqdEdP?=
 =?utf-8?B?cGt1V2cwVm1zempRM2JDTXFlM1FiSXJFRVFYYzh6TGVCQ0crYlkxLzJnUmdu?=
 =?utf-8?B?emJXTlJhV1pvaGtqYzFzUGtyUUhrWFB5dXlGVWZnRllWQTZqU2c3TDRDRUMr?=
 =?utf-8?B?ZDg4R0ltRm5ZVFUvT1NFelVYUUlTQjhPVVdVbHd0NDB3TUppZ2cxWFg5MWsw?=
 =?utf-8?B?ditldEg3cDJIOXZMcEZGb2tOenRMZ1lmbU94R0dodWh5akRtaGkvbXZkbnd3?=
 =?utf-8?B?VjFRTHFzenpDUWxjNnJET0JMSlRLOG5lNHcrNnVkSVMxTGt5aWNFQ3gwNG9y?=
 =?utf-8?B?a2NCQWhFVnJPS2g2TXNTT0hyWFBEYVQ0REpLUVNtS3F0Zkp1YitwVzFVVmFC?=
 =?utf-8?B?ckMxOWpFTm4rbDNrbzUrZ21JTUwvdENjL010UHRiR0RIUDdzMmpFNUUxTWV2?=
 =?utf-8?B?M2FENUxnVUxyelpBM0g5RHd6aFVuU0NNN3dIV1R0T0owTm5EZTluN3NheUht?=
 =?utf-8?B?Tyt4czlBK2x6NDRWcUtzTU1Rcm1FekFXVVN1MUVZbDJhNmhFbmpob296aENO?=
 =?utf-8?B?YjJBNzhGSFJIVkxaQUVjRWxKM1BIVjk0SzJuNmFRTFJON1hmck9ZaE5keWY4?=
 =?utf-8?B?L0kzb29PMzZiRkJaenJXbVhyY1YyOGhGc1lZdWlpMHNNbnJ1b24wRGtJZmVu?=
 =?utf-8?B?TFpDRFpGRnZ0YXBFMFZua2dwNDFPbnByVHpGazdGMXB0VGpmZUdkRUdtOXpy?=
 =?utf-8?B?SjREcmloN0JVcEdhUDVSVVJhU0wvbnN4aHBxQTg2Y2NVV0dkekptN2ZwNGtn?=
 =?utf-8?B?N25GZkpoUGhzQTV4dzhFYWxIL2hoU2MrY0dpaUwvVTNYTkVieVIzbUY1WXRF?=
 =?utf-8?B?RnFnT1N2VDFVQVFuT2xPS3NQWUdDb0pocVVqY1lTNVRJa0EyamZRN25FTHZK?=
 =?utf-8?B?THkzLzFiZFFMS2pyUDErWFpJWlJxK1FZZzBadklnRXpEZTRHbFJVVEVDWmpZ?=
 =?utf-8?B?S296bDBnS3R1Yk8zR0dhaG5oWm5oWUxwQ3l1TGFPRDJDRWgwcEFTd1dLZDV6?=
 =?utf-8?B?VFF6ZW8rTktQU2U4OE5sb2FMcVloOHZUWU9BbUFRU3lxc2NmNVUzQVdoVUpB?=
 =?utf-8?B?MG12UXN3TTRxRjRlRDdvMmxPTFUxZUNqbG90NEpLVTlJZmNVWVgrTHhSTVdS?=
 =?utf-8?B?SXBac1NFK2JwMjlGUzFveGtxZnlwK2F5MXluQ2I1L2cvTmhOcTlZZER2NVJK?=
 =?utf-8?B?ZGI3ekl1eEgwNEJ2ek1KT1lWdE56c3NoVHdqekRyTG5TU01rM3l4WU9ETDN3?=
 =?utf-8?B?a212Mm1aNjFzSzhyWS93UFpPdUFQVGtaUHZza2gyNlVpaVgyMHRhanpKR2pF?=
 =?utf-8?B?bTN3aERWckN3dTB5djBSUUI0VllwQkZ6bTlQVVVCTWk3QkpxTEMxa3I0aGFs?=
 =?utf-8?B?WmJNTFczL1hOWDdtNWU3TENLT3pHYkt6WjJwQWRoVG41MXNWVnZTQlhSOWNO?=
 =?utf-8?B?NWo2NlU0RThweHY1VmErbkZHeE9Uc3prM1RrclI2VThlNU9IQVRBSUIrUXBR?=
 =?utf-8?B?OEhtNEY5elNLbU9xN3NHUUs1dGpEK0lrT0o3NjNXY3pOVkRzRElKVkovZzY3?=
 =?utf-8?B?Q0VmbEhUcitNeFRVVmdHYWxXTWZzTzBzaFgwYUhUQ3E1WHNQNkFrVTFiUm5z?=
 =?utf-8?B?QzFFcktYMmJjY01rUTdHUlpWZ0tSS3poajRuWFJiamc5bzlNZGhLVUNkVGFv?=
 =?utf-8?B?S3JJOFM2Y3pYc0tpbXB0aE1DdWV4SkpodWNPTU9tZWdpNndyU1FURUFXTXVk?=
 =?utf-8?B?MnNjSm5EY0Jtc2huZEx1a3luTjRCR2ZmSWQzOUMvb1o4RG9Hc3A2UVZVc1dO?=
 =?utf-8?B?UVorM2tndHVZYWJFbFY3c2FhZ2F2ekVxSkJzUnRYaGNCTlM1U1RHZmkzQURw?=
 =?utf-8?B?UGpOdHFIVkdVN3dlSlBtRmdUdDVJRDVYQlgyVVBQWXZwbmMyQTFxeTdkd25G?=
 =?utf-8?B?c28zeTBJeWVnTHdVdWVZemlZeC9EKzNja0EwclAyais3dGxzOUFIb0R2YUxW?=
 =?utf-8?B?a2IybXRLZzZpME5Od2VZUmdnQ1RuRVdMby9odE1IRVhRak50U09LVVVkYVRa?=
 =?utf-8?B?MXI4L0tkcU40MUpGRnpoUkwvN0NLcXdVUDIyOVdFT2g2T0FaT0lrNGRXWUgx?=
 =?utf-8?B?VXBMZkM3RlN1MVF2Z2ZwTlVkYmZuamZSdFlFcnlxSVhiRjR3N21CUHU2WWlv?=
 =?utf-8?B?Ry9IVUowc3lITzNjS3JqU1d0Q2NpaGFSVHpsLzVoWlI0b2JyeHhwbUFFc1Rq?=
 =?utf-8?B?OWFtbkJwNEwya1E1VzByTHhHNlFjdmljUlBhNjdxZytxWjlwTVhIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rh4sFoGGxfVBkav96IdZNnccMsouhjmM1u8iToqdha4C5vYkBq5UCW0o1kai93pCQF5E/L+WMyhcq1GbZJXIVcLjnR8sGjbHZx+oIcK9Uc3LuRUJN31Yz7/rgIH9EFt4RRfsQqGYMw8omoblcD7Cd3fal6uVOsi6gE9Hm8UmnF0sesKLaRiV9sBJC3XWfp5ZKRtF+XE4wMYthjWFvXJxaGPvHnt5EZO3ZuuBF1v0yWS7v0Mvs8p1vr/EqSRh+7Z3PaDt+FNkQZ1jtGCGNiHQ2j3IvTU4RyYki1Ru/0rrXRIYSasv8kbDDXs5ZEBqDm9T1PCho3JaShK9a2PEMtF9ZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3b98e7-6d19-4559-79c4-08df2ff1fe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:07:31.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcbixHsICxCAXDpt+AuFG+sL8+66GUEykIVYbH/fol9eEIWjtrN+58i0rm39QM1TEokgaYY8S0VYAutNOR+l0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB263615
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMTksIDIwMjYgNDoxMiBQTQ0KPiANCj4gT24gMTAvMTYvMjAyNiAzOjE3IFBN
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gICAgLSBUaGUgVERYIENvbm5lY3QgYXJjaGl0ZWN0
dXJlIHBsYWNlcyByZXF1aXJlbWVudHMgb24gdGhlIGhvc3QNCj4gPj4gICAgICBpb21tdSBkcml2
ZXIgd2hpbGUgdGhlIHNlY3VyZSBJT01NVSBpcyBiZWluZyBzZXQgdXAuIEZvciBleGFtcGxlLA0K
PiA+PiAgICAgIHRoZSBob3N0IGlvbW11IGRyaXZlciBtdXN0IGJsb2NrIHRoZSBlbmhhbmNlZCBj
b21tYW5kIChFQ01EKQ0KPiA+PiAgICAgIGludGVyZmFjZSB3aGlsZSB0aGUgVERILklPTU1VLlNF
VFVQIFNFQU1DQUxMIHJ1bnMsIGFuZCBpdCBtdXN0DQo+ID4+ICAgICAgcmVzZXJ2ZSB0aGUgdXBw
ZXIgaGFsZiBvZiB0aGUgZG9tYWluIElEIHNwYWNlLiBUaGVzZSBzdGVwcyBoYXZlDQo+ID4+ICAg
ICAgdG8gaGFwcGVuIGF0b21pY2FsbHkgdW5kZXIgdGhlIGlvbW11IGRyaXZlcidzIG93biBsb2Nr
cy4gQXMgYQ0KPiA+PiAgICAgIHJlc3VsdCwgdGhlIEludGVsIGlvbW11IGRyaXZlciBuZWVkcyB0
byBtZXJnZSB0aGUgdHdvIHN0ZXBzIGFib3ZlDQo+ID4+ICAgICAgaW50byBvbmUuDQo+ID4gRGlk
bid0IGdldCB0aGlzLiBCb3RoIEVDTUQgYW5kIERJRCByZXNlcnZhdGlvbiBhcmUgVERYIHNwZWNp
ZmljIHRoaW5ncy4NCj4gPiBIb3cgYXJlIHRoZXkgcmVsYXRlZCB0byB0aGUgdHdvIHN0ZXBzIGlu
IHRoZSBBUk0gc2lkZXMgYW5kIHdoeSBjYWxscw0KPiA+IGZvciBtZXJnaW5nPw0KPiA+DQo+ID4g
YW5kIHdoeSBhcmUgdGhleSBtdXN0IGJlIGRvbmUgYXRvbWljYWxseT8gdGhleSBhcmUgY29uZGl0
aW9ucyB0bw0KPiA+IGV4ZWN1dGUgVERILklPTU1VLlNFVFVQLCBidXQgaXQgaXMgcGVyZmVjdGx5
IGZpbmUgdG8gcmVzZXJ2ZSBESUQNCj4gPiBhdCBhbiBlYXJseSBwb2ludCB0aGVuIGJsb2NrIEVD
TUQgbGF0ZXIuLi4NCj4gDQo+IFlvdSBhcmUgcmlnaHQsICJhdG9taWNhbGx5IiB3YXMgdG9vIHN0
cm9uZy4gT25seSB0aGUgRUNNRCBibG9jayBoYXMgdG8NCj4gYnJhY2tldCBUREguSU9NTVUuU0VU
VVAuIFNvIEkgcGxhbiB0byByZXN0cnVjdHVyZSBpdCBhcyBmb2xsb3dzOg0KPiANCj4gLSBkbWFy
X3RkeGNzX2luaXRfcHJlcGFyZShkZXYsICZwYXJhbXMpOiByZXNvbHZlIHRoZSBkZXZpY2UncyBE
UkhEIGFuZA0KPiAgICB0YWtlIGEgcmVmZXJlbmNlIG9uIGl0cyBzZWN1cmUtbW9kZSBzdGF0ZS4g
Rm9yIHRoZSBmaXJzdCB1c2VyLA0KPiAgICB2YWxpZGF0ZSB0aGUgcHJlY29uZGl0aW9ucyAoVEUv
UUkvU00gZW5hYmxlZCksIHJlc2VydmUgdGhlIHVwcGVyIGhhbGYNCj4gICAgb2YgdGhlIERJRCBz
cGFjZSAoZmFpbGluZyB3aXRoIC1FQlVTWSBpZiBhbnkgb2YgaXQgaXMgaW4gdXNlKSwgYmxvY2sN
Cj4gICAgRUNNRCBhbmQgcmV0dXJuIHdoYXQgdGR4LWhvc3QgbmVlZHMgKHJlZ2lzdGVyIGJhc2Us
IE5VTUEgbm9kZSwgZXRjKS4NCj4gICAgSWYgdGhlIHVuaXQgaXMgYWxyZWFkeSBpbiBTZWN1cmUg
VERYIG1vZGUsIGp1c3QgcmVwb3J0IHRoYXQgc28NCj4gICAgdGR4LWhvc3Qgc2tpcHMgVERILklP
TU1VLlNFVFVQLg0KPiANCj4gLSBkbWFyX3RkeGNzX2luaXRfZG9uZShkZXYsIHJlc3VsdCk6IHVu
YmxvY2sgRUNNRCwgdGhlbiBlaXRoZXIgbWFyayB0aGUNCj4gICAgdW5pdCBhcyBiZWluZyBpbiBT
ZWN1cmUgVERYIG1vZGUgb3Igcm9sbCBiYWNrIChpbmNsdWRpbmcgdGhlIERJRA0KPiAgICByZXNl
cnZhdGlvbiksIGJhc2VkIG9uIHRoZSBTRUFNQ0FMTCByZXN1bHQuIEl0IG11c3QgYmUgY2FsbGVk
DQo+ICAgIHdoZW5ldmVyIGluaXRfcHJlcGFyZSgpIHJldHVybnMgc3VjY2Vzcy4NCg0KV2Ugc2hv
dWxkIGNvbnRpbnVlIGJsb2NraW5nIEVDTUQgYWZ0ZXIgdGhlIElPTU1VIHN1Y2Nlc3NmdWxseQ0K
ZW50ZXJzIHRoZSBURFggbW9kZS4NCg0KPiANCj4gLSBkbWFyX3RkeGNzX3JlbGVhc2UoZGV2KTog
ZHJvcCB0aGUgcmVmZXJlbmNlOyB0aGUgbGFzdCB1c2VyIHJlbGVhc2VzDQo+ICAgIHRoZSBESUQg
cmVzZXJ2YXRpb24gYW5kIGNsZWFycyB0aGUgU2VjdXJlIFREWCBtb2RlIHN0YXRlIGFmdGVyDQo+
ICAgIHRkeC1ob3N0IGlzc3VlcyBUREguSU9NTVUuQ0xFQVIuDQo+IA0KPiBUaGVzZSBhcmUgY2Fs
bGVkIGZyb20gdGR4X3RzbV9saW5rX2Nvbm5lY3QoKS9kaXNjb25uZWN0KCkuIEFueSBmYWlsdXJl
LA0KPiB3aGV0aGVyIGEgcHJlY29uZGl0aW9uLCBESUQgcmVzZXJ2YXRpb24gb3IgdGhlIFNFQU1D
QUxMIGl0c2VsZiwgYWJvcnRzDQo+IGNvbm5lY3Qgd2l0aCB0aGUgY29ycmVzcG9uZGluZyBlcnJv
ci4NCj4gDQo+IFRoYW5rcywNCj4gYmFvbHUNCg==
