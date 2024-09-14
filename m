Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCD4400
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726275152; cv=fail; b=t4/h+stCy113sEJuMSeoWQfnO9ri1w8ngUE3IE1b9cx9awlabtkZwmaSCbC0hTtuZCM6HDtQqsD4zZcDoWxskGOM2VGuA4AvTG4GQobu+LawuFL9j0rJc+U0XY/dhKepctlJXDWkgCB6yU3u57Icsf6Ym5a65nNw6qFLpqSnboM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726275152; c=relaxed/simple;
	bh=oeG2TXunXxldRfUdW+gl3R1g+qkUYgQPLbC89y8iDpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Io9yBb0pys5zhdI8sjev4uJEB8ss1OFyU9wOP7ecWMMlI9ykGkmp+PKKgqYT8I+mk+bPB9PebJUvFiG4OQWgpmB5zvPGaI/GDgbPR53Tw99aHqrr5jzTgxRy6q9UmXcTTH33wa1bcRcC3rpGvOn/qANVjlIu/5z8j2O824hufRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnbk2zuY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnbk2zuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726275151; x=1757811151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oeG2TXunXxldRfUdW+gl3R1g+qkUYgQPLbC89y8iDpk=;
  b=cnbk2zuYMSol8PU14xdb9clA8t3+wvKRrMBsUF1/9rC1rl3nHRNBveGc
   bqAhlmmpjikaiUF19DCby4Olo7JkJ6jlfOzQANdeiJkn/AptVSYUIq2qx
   koGN2c+7EBb6Ggzk/UZ0yQpBuoXlqLicnTbCRaRtdnS0icUnrkYEMrbrK
   Py/syAvrVaN6N6OcQ3eMd/RObFDX1g3JL/3SozUNmJ2RF6kMowLFTWP3L
   Jd1C5VF4EBXCh0LQlcOFcKbdRESQZxxxCOu0rHnGEG8BKv0b30GXYPNr7
   O7pdriAJ0VcSoKje45HVqbnq4gYkKXnfUvSRn0LmVEgoB/LBOzWWOD8xy
   w==;
X-CSE-ConnectionGUID: /ffUKZjyS1adFV0pZBHAMg==
X-CSE-MsgGUID: MB345RLKS1GHzmr8I4X/Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="13521611"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="13521611"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:52:30 -0700
X-CSE-ConnectionGUID: kLGNuagRRHaOL77smE4oUw==
X-CSE-MsgGUID: qxcM/Zv4R9+U0rhshp067w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="73278543"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:52:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:52:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:52:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd+XS3+J5Z5GVpJZxfA5qBm8/+0FiClUCAcRpKvZG/CIHRIlSqKengPtI9SldkDWuxBk+rfEXBWw/X90ZebkSaaCO0hFAT1MZwtuIyeaJwHHmEawpujq9NAXTMjzQndrb4vmV1JF666eLR953QIQ9YZ8GWcEyegmbsBABnH+SQ1AoXgGZj+YaRd6Fk7uLgkKUHqS04i8tv29dOrgDZrpAUqrs5Llk6V0xdP4cGLegSlbcamRyEIroe1GQzqRYJSc+Tsjg0c5YY8Xt4YbehTNmYv2pkrPLQpnYzHv3MPk2JgdFF1OiFv96P5QwUd69xm7yFJMv2gn8Y2xHCku5/QpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeG2TXunXxldRfUdW+gl3R1g+qkUYgQPLbC89y8iDpk=;
 b=kDp8VJlYvMiKIsBCIaYHB5IrZ7ZF1StZIXY57WY9MpooaphyzfXagcNdRLCyF68r/yp15qPnBjeLb51wX34gEAAN9K+AwEUqo7WGAr8gyEHLQXzU57LY7+mxMtQBUu2FHpfIlS/a67O93G2BXF0w86WYT7fJlSg/ryUURGZwrIxaIN1ocXGVU3Kke7NYlSVCoG6lDgeXxUmc0DvVApFm/M/Fn7vSOCT0ZSEtmTaUkcifEZTqkB9TzqAke8zcWsnIStWCo6rgPiY3oNvf4HsU7+toUj2LqeV3Ifc2ZMXRyDJR0INNkbp9JcLCdajl4QQQ91No4b4H2DkKKarnbKrbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 00:52:22 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 00:52:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "j.granados@samsung.com" <j.granados@samsung.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Topic: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Index: AQHbBdJ7/7CTtQp+20SlGBvfhvfxtbJWdAEQ
Date: Sat, 14 Sep 2024 00:52:22 +0000
Message-ID: <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM3PR11MB8683:EE_
x-ms-office365-filtering-correlation-id: 0d5635d8-1cce-4b97-01e5-08dcd4577e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVFJYzBpaFc0T2xnU0NzbndMd0UzYS9LOC9MdkFyelZJaUJpdndhS2dXNk5N?=
 =?utf-8?B?RFFQTG5rMFJnMGVZNUI5SkxDeEJ0bzg1NkpzSWlQb01VdmlONjZvU0lHZ1BG?=
 =?utf-8?B?SzlpWlIyZ2MyWUlpVVpFdUNwbCtlOGFVVlBqODRlK29TTWNvZFNXNXlzaURs?=
 =?utf-8?B?VUpwWGdMUDByeUhUdmpYVUVjbUVZcnJGUTZBQ1Z6dHU2YlhOdTBYQ2xMZ1ht?=
 =?utf-8?B?NGlINTM3d2EvdHZEaXJkRWxXSWdROVEwNiswVEJzK0FENVg1NURxNnoycDdq?=
 =?utf-8?B?SUVZMTVKZW8zdTJEZzdGNTI4ZGIvdUFqZmU1MHc2UCt5M0NZTTgzSXdDNWF1?=
 =?utf-8?B?aWwvRE5WZzdHSWgwVWl1R1U0QVJVVU1JdTFackZzeEZzVDNFSWRyRStjUFlW?=
 =?utf-8?B?TlpnejZwd3JqNVVLVXFNbUlNVVErK0FjOVFXT281TVZUZzVsTi85K1h3RnpU?=
 =?utf-8?B?d1l1R2tZZmZQUGNPeVFoQW9VNW1xWmp3ck41Rm5jeE04R1Q3aEp2TVpYUk1C?=
 =?utf-8?B?M0x1OG4rTVlGbldmSnpwQ2RXSFVMbmt5WXhaenRUZnlBYjVYamNYdEhEQ0Qv?=
 =?utf-8?B?dVJ5aDd3V2hCcEVoM3UydTkwTTJMdG9PVSt3SmFBaGR5Rm0rRStodHFqSXpJ?=
 =?utf-8?B?MTVvRU1ROVh2bHdFTkowVHRBQ1JqTi82NjNuQUNEd2Z6WUZTTmN0N0tHSnhu?=
 =?utf-8?B?dStBdy9QTUFacE82VXE0ZUdMREN4UEJWTmdSdjY3VncwMk51UFRVOHVNUFdW?=
 =?utf-8?B?QldKRDF3WmI2Zm9KaGM2OHVZaUN1bmhJT0tlRkRuZXVGOGRQaVdiU292bGZv?=
 =?utf-8?B?aUxjeDRxdEI1OFFXR0pvVmhzcXVBbk9KcDVPYkkvdzM1RGlYVS9OMlJVaTEv?=
 =?utf-8?B?TkdpaENJMXBPZ1d0STVpM2hZc09Uc05OV1h6OWUyM2hLblV1TFBwNHVQQkVi?=
 =?utf-8?B?S2FOWjVlSnRiUmoyYkNCQTNrZmJCMjFuRnJUNmxzU3o5c3ZLRzNSUjE5cVpF?=
 =?utf-8?B?SnFlbm9CcTZnZG1CaW5JSFpWcVpTY1lZdDFhNmVsa0gzWlRjbjRyUGExZlo5?=
 =?utf-8?B?ZVBsQTJIODl3Z05jU1FXVndjU0FWNmpBRlJ1Z2JaczZkY1BNUy9JNmp6T3FE?=
 =?utf-8?B?VlFJcGw4UnM1NkJlc2NESE5OczJVNUFEQkZqNFpLRTdvYmlZTURuTmR1bEta?=
 =?utf-8?B?OUd6eFVmNFZLbTYyOUducDVmbWNtY0plWTYrWjFrSHN2L3VwSGlmdnpLVXps?=
 =?utf-8?B?TWZwN3loM0lZcTlWSjlvOHNHdmo0LzZLeGRxbldUejZiYldDR3NQUTUwRmdC?=
 =?utf-8?B?aUQzeHhoT3E0WGFITkVYTHd1K08vVjZEQmErUWNOYjlkamtlWittRmREQk55?=
 =?utf-8?B?Vmk0Y3JkcDBPK3BxanFNT0FPNThOS0hOQjVabnR6dUplcGpiR0RyY3ZkQUx4?=
 =?utf-8?B?L05tek5XSXJkbmF2UmFYcUNNdHdiaU1YaUZ5Z0JhOEpjNURMaURUaDNKV1VX?=
 =?utf-8?B?b0pSNFFvM0ZmN1llMkoyZ2w4L3Y3Smw2SjFzQWJJNHpJZjFEeE0zSzNEenN5?=
 =?utf-8?B?d01qQzNvekpUQkNDNUdjdlB0NVhiWWd4YmV5TTVpUTQ2TjFMWVdIcThXd3py?=
 =?utf-8?B?Y3BrK1orczc1NXBrVld4Y2FheWVrRVgyZ1lMOXo5T29jRVdIUDhUa0RHU3J6?=
 =?utf-8?B?Tm9tTXZ4MnN3enhYU013MTRXcG1SRTZXM1B6YXdpZGUydE9Fb1g0L0x0Smts?=
 =?utf-8?B?emtWMmdIdGhGbytFQ2tza1J1VU83VFJyb09aSUlDa29SNFJQMEFDeXprelVS?=
 =?utf-8?B?Q3VNM25WLzRGREdCVGNqR01FR2dSOXg2cW0xODdYa2pGamIvZFBET002eW83?=
 =?utf-8?B?R1NhV2lIc0JUWTIwQ2NyZUVvcnVYaEpYYktkV0dEeXR3Znc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVBCaXZUOGZhUFhCdEFYeFR1V0F0Znh5eE9rKzRBVWoySFk3Y05SMHFCWWNa?=
 =?utf-8?B?bUxETC92ak9yU2pYYm5seVoxQTFoS1hURHczZ09mSGNySDdQVXh0ZVlycmoy?=
 =?utf-8?B?QlYzWitUb0YxVXhVUU8zZUlZT1J5cHlOM09SQVFNUmZjbFlPVW1qR014TEFU?=
 =?utf-8?B?cUt6TmIyck1nWnB1QzRPeWRGVG9jOFROS0RFT0FXRDVzVHUwaFVteFFubWNC?=
 =?utf-8?B?MXZzQmhiY2VsTDg1RndHbTk1SFphQnNQNnZVVXhJamRmZVhHcVJQOWhhY05K?=
 =?utf-8?B?bjVaR1FLSnhkTnVHdkpTa2I4aHZud01FbHpMeGJHWHkxZjlHMzFrZkw0WDFB?=
 =?utf-8?B?WGMvRDEwN1greW85ZTBxNlQ1SDVLRW44ZCtnTHBTalMrdG9VczNkWkFNZkpG?=
 =?utf-8?B?b2pLOTBGVXArbENSTGIxQlFtdHJrSEJ2dEFRU2NLZkRLVnlxcmVqZEp6TGho?=
 =?utf-8?B?QW1UQ3plM0FUMHFWeUZGWXhSQUhIdVFmNEN6a2FVbXBaemgxanliVkFXNnAv?=
 =?utf-8?B?Z0IzYVdDc05NdVhtWDVZZHRvRklZWDRSRTZ3bE1YS294QkVhUEVhSGlUTENW?=
 =?utf-8?B?QUFtUXhBbUV5VmpLbzlZVnYwcUQxQjZnL29MZmhwT1lIU05XdmRNcU44SGJm?=
 =?utf-8?B?alZuREVwTklTaEhTOFJ5VGY4Q1luVGJSQldpc3Z3eFozdnFjUHNnVW0zUVgw?=
 =?utf-8?B?S041bW5vcTdKNmtOOVZnUk1pYWxqbGZ2eTZYbFhlNEZnYXFwemNiN1ZMTnBh?=
 =?utf-8?B?d1FWajBMcmlOaE5uZ0pUTEJVSXlWd3o0bEkvWVg0NHh4NEdlbVJEQnEyQnNY?=
 =?utf-8?B?Qk50TEZVSXluVGJuaGh6WGNDYkhZam1hZDhjVysxMEYveVZaOFIvZTVBd2Ja?=
 =?utf-8?B?bSsza0F6NUdWaDFrVU5pd3JhTnQvVDdZdWpheEJXSlJGcWoxek5PdUkrN1U0?=
 =?utf-8?B?cVFoU0ZnbnFuNWRjUVRnUHRiQjc0eWNHYmtSZ0tCZm9vVER0VWVJN3pjcysx?=
 =?utf-8?B?NDdVT0pQaFlIYnhvcU9mdDh4MGFWS0NKaHBsdy92OWswUzg2VlBBYy9ERk1y?=
 =?utf-8?B?UXlrMEVWMDRDKzA1SEk4U0szVFJpaGxSSTJtQ3AwQjFvTnhhMEhFbjJDaTBB?=
 =?utf-8?B?LzM2NEFiM2l2ZGF2RTI5MHBvYTVWcUVEZ3ZMZys0K2JQNnVSQmcvN3NxNjN0?=
 =?utf-8?B?WlFmZzNLQm5sOWdPRmo2cDAvT21HaU9pTVYvVGRSanBmOXdqTU1FR2FsNm5Z?=
 =?utf-8?B?VklvZnd0Y2U1b1ZlYzIvYjBnUEhVZ0pYZDRaa24ydUtsZUVVS3dMT0wxTXhT?=
 =?utf-8?B?RDVOYy9ia0RTZFNlYXFBMkZHb2R0S0RFRDA5eEhJNU1nY1ltc0ZUcTkwYVpp?=
 =?utf-8?B?Sm9xSkw3U0xLTDAvUFFUc0dTMmMxZ0FZYWFwU3RFUHFZYTZ0bkc5MndIc3B5?=
 =?utf-8?B?Y0lqTTlzSXpQMWIyeTdhZGZQRkZocDM0clhJd2JiZFVhc2dSM05pcXpXbkVa?=
 =?utf-8?B?R0E2SUdCK1kzMjhDSVdzRVpFS1NyTEY2eTErb0VKRnZSS0xUbURLNGRQKzZw?=
 =?utf-8?B?MW1qTFBSU0NNSGMvdTB0UENlN3M0N0Rtd2VxeVh1WEloVVliSUYwa3VKWjY0?=
 =?utf-8?B?WXpuVmVmOUU4UklPRWIzMHNyS3RWak1WbGdnamFFWFFhR0FrekJhNElwVjZ6?=
 =?utf-8?B?KzE0OFA0MVNmNlRGNFdoQlp4R1lISDVuVUpxaDdJS28yV2Z2S2tuem02ZmJm?=
 =?utf-8?B?U3NJWk1KNVp1RGpNd2hpbGZKT0Zia1F1QTlLVkg4bG95K2VhVEh4cjZMOWlK?=
 =?utf-8?B?Zm44RGtZY2xsZHZ3T2FzM3BYbHh5enJUcTFwZzAra2U5dm1hMnJ5L05vb0Js?=
 =?utf-8?B?cVNRQjdHS01kdGFPL2IzcXowYTZiWWlaSTlTcThKaktMbEorRXpHMWpTTTI2?=
 =?utf-8?B?UlJDcExOTUR1amNYZWJxRnBpK3lBSkZZdWhYd0d1Q21LL1NBTlhlcmdkRThu?=
 =?utf-8?B?TkphUDFYYVBvSERNNG1wRzFYdU1iL2lVTTZkS2lCUHo1dUFQMEZsSm1SOCsx?=
 =?utf-8?B?S1BsYWNaM2MxL1NVVDUwS3BLcXU1QkpBNFZjMnZ6QWpROW1oY0JqUmdoeFpH?=
 =?utf-8?Q?8jSSciJCKwY57rxZfQS3ydTtr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5635d8-1cce-4b97-01e5-08dcd4577e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 00:52:22.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMk+9zwp5WAgo1Ri63GRTlv0eH8I1sNiFU0ah5gPYnBCToXJ7nFDSUpiptwRHyYFoOLpLqe5XFo7CWtG1Wc2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2VsIEdyYW5hZG9zIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqLmdyYW5hZG9z
LnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+IA0KPiBGcm9tOiBKb2VsIEdyYW5hZG9zIDxqLmdy
YW5hZG9zQHNhbXN1bmcuY29tPg0KPiANCj4gSU8gcGFnZSBmYXVsdHMgYXJlIG5vIGxvbmdlciBk
ZXBlbmRlbnQgb24gQ09ORklHX0lOVEVMX0lPTU1VX1NWTS4NCj4gTW92ZQ0KPiBhbGwgUGFnZSBS
ZXF1ZXN0IFF1ZXVlIChQUlEpIGZ1bmN0aW9ucyB0aGF0IGhhbmRsZSBwcnEgZXZlbnRzIHRvIGEg
bmV3DQo+IGZpbGUgaW4gZHJpdmVycy9pb21tdS9pbnRlbC9wcnEuYy4gVGhlIHBhZ2VfcmVxX2Rl
cyBzdHJ1Y3QgaXMgbm93DQo+IGRlY2xhcmVkIGluIGRyaXZlcnMvaW9tbXUvaW50ZWwvcHJxLmMu
DQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMgYXJlIGludGVuZGVkLiBUaGlzIGlzIGEgcHJl
cGFyYXRpb24gcGF0Y2ggdG8NCj4gZW5hYmxlIHRoZSB1c2Ugb2YgSU8gcGFnZSBmYXVsdHMgb3V0
c2lkZSB0aGUgU1ZNL1BBU0lEIHVzZSBjYXNlcy4NCg0KRG8gd2Ugd2FudCB0byBndWFyZCBpdCB1
bmRlciBhIG5ldyBjb25maWcgb3B0aW9uIGUuZy4NCkNPTkZJR19JTlRFTF9JT01NVV9JT1BGPyBp
dCdzIHVubmVjZXNzYXJ5IHRvIGFsbG9jYXRlIHJlc291cmNlcw0KZm9yIHRoZSBtYWpvcml0eSB1
c2FnZXMgd2hpY2ggZG9uJ3QgcmVxdWlyZSBJT1BGLg0KDQpCYW9sdT8NCg0KPiAtI2lmZGVmIENP
TkZJR19JTlRFTF9JT01NVV9TVk0NCj4gIAlpZiAocGFzaWRfc3VwcG9ydGVkKGlvbW11KSkgew0K
PiAgCQlpZiAoZWNhcF9wcnMoaW9tbXUtPmVjYXApKQ0KPiAtCQkJaW50ZWxfc3ZtX2ZpbmlzaF9w
cnEoaW9tbXUpOw0KPiArCQkJaW50ZWxfZmluaXNoX3BycShpb21tdSk7DQo+ICAJfQ0KPiAtI2Vu
ZGlmDQoNCmVpdGhlciBpbnRlbF9pb21tdV9maW5pc2hfcHJxKCkgb3IgaW50ZWxfcHJxX2Zpbmlz
aCgpLg0KDQpzYW1lIGZvciBvdGhlciBoZWxwZXJzLg0K
