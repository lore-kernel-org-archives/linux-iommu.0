Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794463128;
	b=pnB+dhlERJqmpO/L3a87KoaidBAvJ4I7BPnXcxxC1oo7uk4OdIJ+Vl7ySBwzm6cwOwVj
	 9Y+96PxBhsG9gwtbkTu/XQGwYkmUgG4Ipq3pIkor6zmhpkmVe8iqud5BSbQWVBeV3hZ+r
	 VgNgI6B5b5bjwvG8zOTqkVmODIc2sqTqNy0dRXgcTSiPruhQAOPWSqCPrRrcIpCQlDU79
	 69JNNLZs1/rhucD1suepwUAgfChV3jXQq866TDs59JdQ/GAvFS1F6MBAwvSH2uwRzE1Zj
	 IefU9+x16+CDyk2FT2PrAMx72aOqNbJDhZRIYbFM9d1ug4SewiKat88mj+XVNAmU6/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463128;
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
	bh=P0n4uouMvFcjvCamHKCYaZPrqThOYdU4UJ84IwH3C9c=;
	b=EYALqzyeDELBSPq72d3tIbwDfx0tFwgxW7D44OogwadnYYfHtSXCeqdJLjno/Aa3ZFvE
	 5tjYPvY3Y3qd9M4Cc9D5Deuj5sJhUEa2lAmnN+T1n/Dnx1GpM/XS8CKsWeNfF+IA8McPY
	 CT3o0Ed9v2igo3xxauTOZzEucTOXDFaXo59PlRJCixXUpRO6UGLO9ZlDjAeEqfOHMPM+Q
	 d7/fkf7DgFbUsXtDPKSF2J34cZYH+PU1LDB1/NvL8bMyvYo4QYZvffZjWk28UmqVML+SK
	 6pTNRGTvQmnOpxprMcz0/4LY0nhq6kVJDpupW5rs24BWpf9R4vp3uLZIjI9NlB+iLAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cw+q0eZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197B606A31C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 05:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7197B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cw+q0eZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794463129; x=1825999129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2DI2E1uf/NhnC7bqHk4cK+vBmmmo6zJvj4mKaPTVl08=;
  b=cw+q0eZRVfb5X9SKrvQ93PbObgMV5XXK4Ue36OgHwewqzL7MUKYe434l
   mVI0A9ke0OntYrL/umg4N3T1cdZK5CD+RxU2FPjgOcKMfsOt43fnr+MZT
   DmhUYB1/k9/4aUpIg5tjAwUJ4bvsu3Nqkm3ALdOpxDdmYOUB/VVsb75mp
   98bXqROS+kbzprKGXU5itFgbhbwEr8WWsiX+nOZc+2WNQTGWo/sLcA3Js
   rLT03RRgkUTDR/YWUftnIiIuEVSmZxT8ngB2ZyDnuHufKTgzeKk9xPaWC
   PRo3RCkTymZmvYEscLZOM68tZZpWhiBTwH6uTo4KvAwzTSHyxKSZ1+SIw
   w==;
X-CSE-ConnectionGUID: IaDWgRURSA22HGOGzp35Tg==
X-CSE-MsgGUID: oRidH36zTbaHIDyphc2Kyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3336089"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3336089"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 21:58:48 -0800
X-CSE-ConnectionGUID: GuPbOQC3TmKHu4HmVoQfsw==
X-CSE-MsgGUID: smbOZxUnQFK8+rBJU3Wotg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8737933"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 21:58:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:58:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 21:58:47 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:58:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/j1ormLVguHxsPz3Or/Wrzd4Osnb1Dnk7mHzscBu0JrARz+A3p8IM+VCvq0THeAMxcCuHWlm80KP139ezf6jMA0PVlMvgZlKgRLz1PQtqaOYt0RPZ5+bfOxx3eXMGE/XFosfVZcBzwUErFYHOqeCQ64FGR8PT0DFvyZ9nchYveEX6Ysiu7j3FhbOJKl+GsxGrCItIRZSAxM+M/kOdNeI8mVZzN+jFwZmTMOQYkJ3tLzTnRqCatrG3MKWOXBaXeKVmyO+HODLFoZKIXOLQr1P+XYv1yni5mer6w9h/zlz07ehf/ET4yAZoAz/UlIoi2LkQ7t1AABKhm+Cm7ZFB1jlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0n4uouMvFcjvCamHKCYaZPrqThOYdU4UJ84IwH3C9c=;
 b=ybBaw7C7OA7rMkTYpmU3l9qix3y/JhPMgTJs5wjuulCe2+zWdjgs4qEMyxb4b+S7BciLnMt5FS0YRTXmW31ABCoEdiydQWhFsvWf3lr+2KXcxEmFJamXXoSS4SA6tOIqQo+n7tvSeXbya7OZ54+zkUmM9kVM9dk8EWIkg5R4KRF9jS4wHmS6ryOSEKrG0KyRdi/8bpGX0brqOQDhV4n/7eiS7KXJvoJkle7W3xqhKzlXsPDF2pEztPWEwQmUDSVCpaN8lZ4/R0Is6TfjjlmcJ1x2j1sEKlZ9n8mITRQby+JmacIYbUifbJThKqxYwX4g2qZJ6T2ZByXcSaQjp743PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA1PR11MB9616.namprd11.prod.outlook.com (2603:10b6:806:4c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 05:58:40 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 05:58:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Serialize SVA unbind teardown with
 intel_mm_release()
Thread-Topic: [PATCH 2/2] iommu/vt-d: Serialize SVA unbind teardown with
 intel_mm_release()
Thread-Index: AQHdbBy3v42zwmf6ikmCDVINDY42D7cp/Wyg
Date: Thu, 12 Nov 2026 05:58:40 +0000
Message-ID: <CO1PR11MB4835BF95503C65657F1FB41E8C702@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-3-baolu.lu@linux.intel.com>
In-Reply-To: <20261104051059.1345010-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA1PR11MB9616:EE_
x-ms-office365-filtering-correlation-id: 060b0c65-9678-4d5a-3055-08df40820031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003;
x-microsoft-antispam-message-info: pafo6RFkOB3NrmnXzSVXqFiSHfv3X04vgw7O5T+s4lHiJXnvG4+LPKNk68g4B99z5+tKH1KpFqBRzF76XG4LiJDO0fDO9IKRsnFbyKQbT7RG59NU/qWrI4SorFqchPFWZ4Ha6wSU54NGDVni6dQhRx39jQzxPlU59sjSV/iZha292DaFIbtHrgaMioFvVrvR/9gxdaAGZUMDi7z6wN1sa8jimem4Fdbuc5MEsm+BeW6aKWSjpsTPd9DJti6RjAJBgwtfrDc9fON1jDmWmO2UbRf25/GJQGu+NCGLQjrFXuquE10RnjfMAPYCJ2A1yINXFxA/A5EQ7IxjoHcL68uHBbIwhLfOOuBg2GbQ1vULr168XIH6WaPm4ANnmLRRA8/bwUDt0FPTMIMgZC0Bs8phzDYVf8hbKq0Sarf8t1Uj9PVKV0LkSqkMRbtd/r0737OSCtDVrgUE4x5uFTOZ6VbmKT1TpXjmmfLmsQbMeszp64G1VRY9nPttpSWP4Irw7gcWM0hSLPQe/L+wOu4E96pYvNsBQfTsvndP7keSzIRUh06+hMaEefz6pdEnenACyFf6F+yW56j5pRNhB3d6GJWEHOKldov4Qvgus3JT2f3KiVAvrrpcbBi0dlkdMWQzhL/qo28291oZoD2iM83dPdPfEivKrqN8RzqzfN5Ox6TC+/jqfLKOTPPaqsc+QTtE+4UjJiHd3osk115q6G02xHLwZwGgnjjknl+u1GQlkHyNzlI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hoD8yB4ABVJ4vyj7JTenArEdQxLzwtCfNCsqvH8VOXULVgau96Nk0pgIHiHv?=
 =?us-ascii?Q?C0qEKmLPi6xMuNOrjP5v7jxXVfcw6wUs0lqIk3jTtHXYFs86vtlxlfidFoaP?=
 =?us-ascii?Q?ZGYN80howc02RchdUjxzq2zWd/WsiR0PkZL+YTnduOjk20A72Bi42Y8FG5/Y?=
 =?us-ascii?Q?QZMVdyXFADeoFZJBNKdWQc1x5AAvbiNpFn97hWLcCDInscs+aQZcOjLmVt1P?=
 =?us-ascii?Q?begb5qCRilxUAXWdsBec36fSs4rkB3PiqJJxEhoKErxDaTECP4nvS+9va4pU?=
 =?us-ascii?Q?qU9ImuyDN3IzSpWv8xSToYed/4uF2fi5FDg3Pq3Rf2gA5TyRUvvBiAs8lqjk?=
 =?us-ascii?Q?/cR+mzZJZc+L9+DPZ4CIdB0gYWinXzh1XrF6XTzNbWUlDWvXkk5AHsCd7fLz?=
 =?us-ascii?Q?mkl+odro2/2o/FUyNGNaSeWU1a9gcdFKJICDRe53ccajil6gqMWYBQ9+3cuj?=
 =?us-ascii?Q?5OdC4QH3x1u08T+bsMfZRkkDpxIdlT4aDuJ+sMv7Wv/uTv/E0440Hxw+8oWj?=
 =?us-ascii?Q?vNIvr1Vn30eIdd2Y0avUHrMNEOLFd5BrFsYhFyAz6idqi7i0rS//ZflByeP4?=
 =?us-ascii?Q?vbnnFOfvIFUrbwlio/U5edNqhlmp9geqsbe4oSd7oq3hxNxh0+KdFTeu9BTo?=
 =?us-ascii?Q?M312zJtpbs+JTiImzLxosA1OFolzXlovqe8dyei2I09OXuUxRbYqBPea/MKM?=
 =?us-ascii?Q?NVR3IicWjNVfb+zx+AZ9mVWVpn/rDIUT6WkyXJyKk9zZLKMLLpcScYDOjDMv?=
 =?us-ascii?Q?0FPSPtewMifFoT1OwS8TFFubtWqXhTN+p639IX6REhtMvK18aHS6ms8tKsib?=
 =?us-ascii?Q?YkDfq4O3654Jxhg847zz2wEKBMhl3EtWAXfl0t2Pe3219UZO4IUgSwagEf+z?=
 =?us-ascii?Q?E1yXS57zKFraWGGuSw+DfbqyK4NIJcLNAyG0kssDL04OnQobkYRNj2Exjrc+?=
 =?us-ascii?Q?zUg55SwF0fN7V4DBuTaEvgMDJnMB+Mm2iZle+M6rmmjzUBggP9pQCDdbgoAw?=
 =?us-ascii?Q?1i3ryofG5hNtBtS5zEsQ895OB18scpYV1I+fO61KO3Z09cpwEDhYSzgmAU/7?=
 =?us-ascii?Q?jK3ytPkbRYBC9NwHHmtwbYQfbYCEkaWQAhGQ6bidO+QpGTFIN5VCKlHRtOVw?=
 =?us-ascii?Q?8k4ZasiKbChITpT2UKFKcd2ua1HcCXHqEXC0390u3PmrsdVPaoAydk8ecCB+?=
 =?us-ascii?Q?NzY3wf8kAqE7EyHOTZSYr2snqPrQFNfIviHxQbBDMpZgAnTDroa/yHW3s9n4?=
 =?us-ascii?Q?VNdxvyUH83AfZ9DSkOemdMLcjUKO1Z2fwbkqnUBhbsRdlEnJN+gybELGVpQW?=
 =?us-ascii?Q?pihtHfSiXu8l3P17f6HGt8LaeNglJCzaMlaX+cAwwv9swM1YiPtJaMWXOEWx?=
 =?us-ascii?Q?Jy3qyN2rwxVGro1gnZ3acMEeDenTfqr8CRqv6tAvTpdN7dO7ekAxH7QYbAZB?=
 =?us-ascii?Q?MASJxhhHShIQQ4z+duVi8EWOQfiN9ojMk8+O6+O0otXKPLO3N9DiODjboOHr?=
 =?us-ascii?Q?Urm2hXXJvzWxzclN3ev9DDQMv1y7/N7a6h2wDgYlaQdfwWBIUGwskTiwwoZv?=
 =?us-ascii?Q?1U3V1uAX6Py2lYFOFO4ISE0I9mYP9+UA8EH5wmG1iuib+nBHIJOgmtuCFjMd?=
 =?us-ascii?Q?qOePNAIkzKAvBXtdnLtczjf/OJYg8p7Re0is0XdwQjYo5hV2thgjagNsgEe9?=
 =?us-ascii?Q?bpKjfVITdcqPaKxPbmBNa3hOwg6CIHrf4X4L5hj0KMwRhUuA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qD1B8oHkHHEOj30gNM5CB7rU7CIC21cLpj+57mtwdoHvxwU3kTWMuzMlT9nyQVQFiuV3xRA8nG6pLmYXu9mOvOmnLqmKyB1KLmXGdw1brGb3c4mU8Y78tc/Aowe+kbW3/bJgKM4JMCaDpOEonDfxA2iYpjUUTlVmPkJ57K3/G2pZv/wUDxTjwGComAzv7LToMnl9C9nyPzef9RpIs9Rs/bdlEm+zLGBSsNMnwsNGziQgENK8EvcJC/W5TGuTf43ONqryI3ce9ss2VFxlNE4sjA1rZy1YPOgKzSfwHNuqiRk3KI7SVIRf0DjVkt/jJiVvO1/DDG+jwndxXG0OaxJb6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b0c65-9678-4d5a-3055-08df40820031
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:58:40.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea3WDX+xtcAIUVUPDM9dZ23+HOcuersjnEZF97ilu6meAEt6rCIm6jHxuB0DbzjCogxOzUg1WmXiQWLEYsgsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9616
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, November 4, 2026 1:11 PM
>=20
> intel_mm_release() can run concurrently with an unbind of the same PASID.
> The unbind clears the Present bit, drops iommu->lock and then invalidates
> the PASID cache, IOTLB and device TLB:
>=20
>   iommu_sva_unbind_device()              exit_mmap()
>     blocking_domain_set_dev_pasid()        intel_mm_release()
>       intel_pasid_tear_down_entry()
>         pasid_clear_present()
>         spin_unlock(&iommu->lock)
>                                              intel_pasid_tear_down_entry(=
)
>                                                !present && !FPD -> return
>                                            ... free page tables ...
>         ... invalidate caches ...
>=20
> intel_mm_release() then returns before the invalidations complete, and
> exit_mmap() can free the page tables while the IOMMU and the device still
> hold translations that reference them.
>=20
> intel_mm_release() walks domain->dev_pasids and tears down each entry
> under domain->lock. Do the same in the blocking attach for an SVA domain:
> tear down the entry with fault_ignore under domain->lock, so that either
> intel_mm_release() completes the invalidations first, or it waits for the
> unbind to complete them.
>=20
> Fixes: 4f0bdab175d6 ("iommu/vt-d: Make the blocked domain support PASID")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
