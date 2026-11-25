Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795578587;
	b=jyyzt+PtVZXglrgGuDzY4zbf591SrfE7WAjIysQxKyV5OXSFlaNKFspXC6nDpvo8zNiz
	 FGWjMdqVrt0vT3rQFpEi30ysNfU8lCirb3I3TW30EeWmjb+vVLXNtFw3CJ4quMQF/Gkce
	 04NiuXHckflbGOK+UUr4EIUP09t/sGfR/NhFTo82uaADh7HKfZx59bqhCe684CHCe5F8W
	 YrlgHB9+QVjGyCPrumxZMf32ICpechfcX9RQnbqurZEP9LC5GhMtzRZRU9bk/tmMLxUDb
	 TlsMOSpQCIt+EbPW+aoe5tqHht55OoFUtb+VGap6IND3rrqoRwZurX8kP8AIz1HXccw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578587;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=vlGk9xmRxgJ1kYSZoqdOKrtZBamUlPgCxDlm6fsI4Fo=;
	b=pWYMfJbM4lgLs3MfpuGaJ3U/0kFEv1ThUrICNHNkvZV0njAUQOoelZbAqVq9MBLnOHhk
	 XD0m73eiQvupSk2lDxawrVQc0Z7U/l+75jfsmveZQcr6lqWZwoZync5im4XmO8mpLb03E
	 R2OC9oSgX2Jp4znzk0lIum57mp/P9x+0GN+S+OKEkfCzERk8agzNmwf2Rlbf0m8FWVy6j
	 vNYj/qItWWdkckgAgDzkBE727/aQShPI5hRgUXf+d/5mashB5bvsaZ3rOnP2I8Xylk41N
	 H3uRXWycWplf0iarVJijcRA03fcKMfOLzVZI+Rb+gJyBwrnVGhuJDIahybgg4jWjAww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="WkUKXZE/";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=GU+YdLuz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E4606A321;
	Wed, 25 Nov 2026 03:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9E4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WkUKXZE/;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=GU+YdLuz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795578587; x=1827114587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cfHQwE6SmMbqrmalTpnUdzfPN8dRgxNrLCNS1MYvkg8=;
  b=WkUKXZE/TdpA3cAwRC54aT1vr0BQ2+FPblfeZCQM/mTQiQjb3qPsGQE6
   zv4XHJzrr4q/VaW3AQpNKsgKixQDTAMRyEbdDWaVHCmSlZrVfkDaaBGV0
   qas1iHtZNRcET0UBTLbXFQDqqfwxNB9Z3FflsEhRsvZYfZKBh0FzteDXg
   a1xsVQUJ4VhdhcVv9eQvKrG1s9fSbTZ0JeMQKfhHM9ntvQGEO3mZB4La8
   HhmTtSlXxnesUxvUglSKLcWuSNrHhM4Vk7OhJMdOXIjQceHweZFEFYWX0
   R51o+1hN/fBulBepAJpIyYQD6299NumGceDgZXv3Yd5TAdPYjUWNccpdt
   w==;
X-CSE-ConnectionGUID: OXdNeemJTBmAYM/ukhy8Aw==
X-CSE-MsgGUID: pESHqAu9QdOkXw7RNDtE6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4522546"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4522546"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:49:46 -0800
X-CSE-ConnectionGUID: LOtErMmlSgahTsX3oDTD7w==
X-CSE-MsgGUID: S76u6SUQQJGi6w7ftpgmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12181587"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:49:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:49:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:49:45 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:49:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/0xO8JcQ3ldlOErGg+ImK1Ik11FYyTwkG8NrIFBKvCyi1tQDmMqJDRlgBz/9XVEYAPYQFwvJMZZAlUkfLV7F1JBN9tuXmHqPIJMDKpv0lyar595Bm1zADRcSnphmNkV0m5xabZWzx2AqKhEM8t7hm/7E5CwOoKj7UD62ur5cYG1pxH0ZBDZiAN4SjFlEG5vVpb0ZNZcCfsa7xNcfXH82s2L8AP7u+P4ycdeo//kx6z+F/cU++IBwTpBIkLFNLzDKMAuooJoW9v9etpRgY3MfBfggX3mFWw/P0V0r1JZjkunm11z9ko2tpw8Ds6q0i/1PxNHbHOPBIlXKP26kxn/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlGk9xmRxgJ1kYSZoqdOKrtZBamUlPgCxDlm6fsI4Fo=;
 b=XSU2TmmEdUBxjHdRUBCp+185nSG8TuXOsoBYZrtCSyzFsirX1OD1QqR4PZt6n8FGQfNP6rSM4PeeEtrZU24QgXTJl21hJHx8cHBhKfBEcrhuZHbiDgijSsKkyyI7R5gvyRFrjCZmOH5KbN6EXTOp9OD3RF/4TmAEoE78h3AmOZ5ZFL/0VYroF8bvNiLR4wp3amq9ne8ZhtSE4hgO6PamYjPyWONsyIw/Jv5alfvb8ppCI5l3S7ndkC9aaoiql53hZT4nCZG9jtS0RDhE2MKH7hFa4w0gDFupDbFLo+nJbKNCioTCw4wrxHiuRBJfvVOcaeKKXFYSvDUsBG79d394zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlGk9xmRxgJ1kYSZoqdOKrtZBamUlPgCxDlm6fsI4Fo=;
 b=GU+YdLuzJN9QWX9rVzl8yczLk32dpmjxIg7taJMrUaXN7jmgPozGVac9uvAIHkh1u0kbaTy7piMl/Ainh7jk17afbHxlTVYw1IPT6hD9ZJL6NUhwUwODxMDtLBGLFBz8xjNCFaeGc7cL6/S46rHCSlntvGkAvZLXoqJPFxw0FmA=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA3PR11MB566415.namprd11.prod.outlook.com (2603:10b6:806:589::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 03:49:43 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:49:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/9] iommu/vt-d: Block GCMD and ECMD while acquired by
 the TDX module
Thread-Topic: [PATCH v3 5/9] iommu/vt-d: Block GCMD and ECMD while acquired by
 the TDX module
Thread-Index: AQHdcmB728lL8xYlGkiyC7/RvXQScLc+Nr1w
Date: Wed, 25 Nov 2026 03:49:42 +0000
Message-ID: <CO1PR11MB4835F23CDAD5127487B5978B8C432@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-6-baolu.lu@linux.intel.com>
In-Reply-To: <20261112043054.2664857-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA3PR11MB566415:EE_
x-ms-office365-filtering-correlation-id: 8a9c0d26-c3bc-4889-69e2-08df4aa723b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|261009223027099003|38070700021|10067099003|56012099006|11063799006|4143699003|261022105027099003|5023799004|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261102123227099003|261021121427099003|261021123027099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: CpC+0dblPFlzd59zmpOhezYwa0vG9xdHd2pJd20uYtmjb2c40YaVWeA37KwUabaqVDOyAnSF03GTRPoJsgJCUIrVG3ju9c8g6REU8gy7bilxNdy9UnhbKji3TFM1MfeMoa9adTEYVrHSa2khqbUjEwrpr8YvcsbutOMFhxQi+gXOqhsRY64Jk41zhAbQU1R4h+vXHAOe0EvrhUcRmlAs38K2S4RfaogshLQuc8chvgZJbC6vEEQw7GsM7onC9EAxyCOt7gGpm+857RhBkRu3Hxl9G6lShW9W7Q6B3Q2Ks9xqhZwrE5qHXFTC9/JJj02dNc9EMBmovk9FE0rAMKRuY4tWmJ6iTOea09zrAD1Kx6xubA1Dz252OTOcL7sYLW5icC6W9ll9sXRzi5/WcW0WRBzTLi0bnOxSxNTM0J9SzIjXVjSlemTBcq0sCw72R22e1UWF6d9vo1t4KW994HaOKo1PvbAh8nC6vGalccyV2BVY3MpKDEGpF3GnYziatzQ3blMiDWORhdNLXjOXiMS6c00z2wty02ghsmD6gq0he0yKWIoTkNzqRarOlM9tLm3pgbs7CDXDRtaGBhcq2CHN8lrMtTX6qVYDdkq4ZGnL6Qk5cIRveGJ9JC0Rr/eoc0PPjrRQc9c9ZbCGI97s+7/ef8b7+N5X6UU+cezowCgIhSC/iYldbuwTQxnMVoMvuHF1jeijGr8gOEK9r9YWvla/EaT4ulXE2ACZcmWsuq0S4ik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261009223027099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(5023799004)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Kk7SjsAy9ium3r6nymMrPnJmeFfnHrhr9rX3pS6wuXijlHAvZGflOX2iRUj?=
 =?us-ascii?Q?8yeJYMHmLaH5xf11yhSTOnbOTLOEAutdPA7lC1hb5ogU/DsysSlOPcgHGyMW?=
 =?us-ascii?Q?YpOz4juF4MJ0TdxZVvqyteF6dTZnEba2zjdna9ZNZsOKJ1i7F4r99itGrR6A?=
 =?us-ascii?Q?7oE6Cqts+/QNjnAMU3tglb27etpt3J5RhU0+x0fK85FfL4vbHrfCHVTS0ry/?=
 =?us-ascii?Q?ZostOAx4duSJiNKosNERVSqFlOpOlUr9foMiRqu8lrsHk/fzWCh5M/N/Zq7X?=
 =?us-ascii?Q?Ih/r/71xxFxfqkpoH40/WfO8BFPto+RLjvabqio9Q+sIK5CUUNQ9PX11owok?=
 =?us-ascii?Q?u99NpOx4Idme16Fshl8/agsbhTIHFj2SSxqt1u+lOo99hs4eOVBYUuHgN7uB?=
 =?us-ascii?Q?yV/slc8X1NLc0TxBR5jjt30pBbM+GU2YGHb1NSI5UUhZ76oiHg0I43f80JKZ?=
 =?us-ascii?Q?2hrriZVXAj+85vqMf7hUq4/RPdctkz85iuplxUfi6AWhi762A18+VA+pEZ+F?=
 =?us-ascii?Q?P+chHDD8EEiPCMMWCWJXxpmbozh1pO2KfYnMJXhAKbJiwGTjG1QQyc9qrsmv?=
 =?us-ascii?Q?PEMiqPWB2sUrLcfzmfx6XR7oLkUGuJWJu7PF9KCgJbEjFvaSmtLEmrvcNwPm?=
 =?us-ascii?Q?/HgWeX2aN7fquyQ5SFRKEeiCwiidP/LKGOUAd6vZCGdNYVvTuL4zD77wgVBF?=
 =?us-ascii?Q?9wHB6HYrHYbOa7DU8ZSWQPL3/2MhOibWEnSAVpCAw9eatWFEfpykROpCqX1H?=
 =?us-ascii?Q?3kPFl3Nz4yIU2Z9Ug3aRRlfEn3P0VrJONg0noH5Q6P4IfPQYPz90K0AIMvfO?=
 =?us-ascii?Q?+fjprFfJwhiRBcOIZfUSMZrIxQLxIbtj1nEVRCvxmUbIqdxEYleVmtW2AvIW?=
 =?us-ascii?Q?aXf3spWu4NGHhanqQuofK6DwyuNXO02+sOHwNad6YMcZBRE5RyfWcoH8slix?=
 =?us-ascii?Q?hi7dlWokM+Byi9pU2NGtOEZpW5tEiRqd6lNA8ygzKC9mkkRtSJiNOx1IxFmb?=
 =?us-ascii?Q?u+crzFgI/xyLgXB8JJaOg6dStJk6YDtz27lgdaDDC6Amgnl8/nrPm7Je9BTg?=
 =?us-ascii?Q?NvZpn0PRT/4RZmqb2txTxkddso2s7dfsYVaiiDErLTKG1Y085WwtY4tmjv25?=
 =?us-ascii?Q?HiD4cEwGPM34zLD+RG8nKTMdcbQMADDReI9Z7WYrZ0fnfs2FiaBp2mvrFIwi?=
 =?us-ascii?Q?VMolRagYig/Sv031ceIk5OFEYECnglnXV1Dvmg1reW3O4Es/LoY4UJM/idHn?=
 =?us-ascii?Q?MRyX5CIQbzE64VtgrfOl4MOvsPV69RJ3p3seGVJ7dcFvG3yfa5aRVAtO/ZdH?=
 =?us-ascii?Q?+QY738spDgoOGtulClodbdPa+fDioOCA9+n547qPPHAtXQLb4MbhdV6jF6f+?=
 =?us-ascii?Q?QzDGyt6IcsyGiI7F5V3VXAgRwcrQ2TSiiQ8hvXh0Aoj9NfMNBeP5BV9xmPzl?=
 =?us-ascii?Q?IcEVKRSoV2jm2LVqCoSqdmnq19dIkcBnF5AO2/7JwyfmxUI8TD5zKoqadTDP?=
 =?us-ascii?Q?vYYKgP7L9i9DfLJ1YaiKu9A1Fj7lwZrY76U9bpx3m/5Y9J5OIbR39aQLh1Nk?=
 =?us-ascii?Q?scNIGtgRXQ5ZB+pmuPmZqp0jwgpvLIs3jWoCfkmyS4YYYnsHCEdAHORSjfFX?=
 =?us-ascii?Q?ll5t9uinoWvP55oB0UjyBX7b2fV2SrB3KNF6Eqd059QZnZnh/D9jC+lxUysa?=
 =?us-ascii?Q?wlVjyNjmkfj+c9SrHF8KjW29gePbyKOfudqJ2/5chbuDghEb?=
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
X-Exchange-RoutingPolicyChecked: jZaLBH7KZZKHLPTJQ0b8qu5LbvYT5d2BIY5MAM61Q43lzzqr7w1Aiyz/+r7zWvH+h9ADhJia4oZy1ggUBAb8Pmehq+VjUnI7p+kJ61SWA2C2T6lI3e+nUJCENJu8Pyc9C4i55p5NJWahDXwmrJoVOtYSpCaWX1z1+2xB5Ecl+pBH1H4WrrRGeyvAaI9UVLb/aqxhnkuhK9GD6JZ0ipVM7dOFPCAZ9jJTzCFBja06bkU6J/RXFI7rqCT8f3YU6/ZA8cgdClRiLwXAYfq+LRmAUkqKbqfWLFEaVrsrGkD4YEx129aLjFyrRHoGSC2A04dSbDXYirsk1uerr2rdlHr46g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9c0d26-c3bc-4889-69e2-08df4aa723b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:49:42.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z3UVacUq3lDff8m/Y6/x5KrX4iSqlVdZVIeukpGw8hCzE4tZxOviNLl7g7j/mfTuEVVHB8QxRM/55ApefU2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB566415
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 12, 2026 12:31 PM
>=20
> Once tdx-host acquires an IOMMU for TDH.IOMMU.SETUP, the TDX module
> owns its Secure TDX Mode state. The VT-d driver must not change the
> global state of the IOMMU behind the TDX module's back, nor issue

just part of the global state, right?

> enhanced commands, until the IOMMU is released after TDH.IOMMU.CLEAR.
>=20
> Use the tdxc_acquired flag of struct intel_iommu, which is protected
> by register_lock, to block both. dmar_tdxc_acquire() now fails with

'both' means what?

> -EBUSY if an enhanced command is still in progress when it sets the
> flag. All GCMD writers hold register_lock and wait for completion before
> dropping it, so setting the flag under the same lock guarantees no GCMD
> operation is in flight once acquire() returns. While the flag is set,
> ecmd_submit_sync() fails with -EBUSY rather than waiting, as it may be
> called from atomic context.

this needs a re-write for why GCMD/ECMD are blocked differently.

>=20
> Write buffer flushing is the only GCMD write reachable on the runtime
> map path. Rather than adding a check there, refuse to acquire IOMMUs
> that require it (rwbf_quirk or CAP.RWBF). Move rwbf_quirk and
> rwbf_required() to iommu.h so dmar.c can use them.

good to mention that this quirk is on early old platforms.

>=20
> The remaining GCMD writers (root table, translation enable/disable,
> queued invalidation and interrupt remapping) are only used at init,
> hotplug and suspend/resume. Acquired units are never hot-removed,
> hibernation is unavailable with TDX, and the following patch refuses
> system suspend while an IOMMU is acquired. Guard them with
> WARN_ON_ONCE() ahead of their companion register writes (RTADDR,
> IQT/IQA, IRTA).
>=20
> intel_iommu_shutdown() is the exception. It is only called from
> native_machine_shutdown() via machine_shutdown(). On restart, halt,
> power-off and kexec, syscore_shutdown() runs first and tdx_shutdown()
> issues TDH.SYS.DISABLE, which takes every IOMMU out of Secure TDX Mode.
> The crash kexec path doesn't call it. Clear tdxc_acquired there so
> translation is still turned off.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h         |  8 ++++-
>  drivers/iommu/intel/dmar.c          | 50 ++++++++++++++++++++++++-----
>  drivers/iommu/intel/iommu.c         | 33 +++++++++++++++++--
>  drivers/iommu/intel/irq_remapping.c | 10 ++++++
>  4 files changed, 89 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 18fef91753a0..26135248675d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -690,7 +690,10 @@ struct intel_iommu {
>  	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
>  	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF
> */
>  	raw_spinlock_t	register_lock; /* protect register handling */
> -	/* Acquired for the TDX module. Protected by register_lock. */
> +	/*
> +	 * GCMD and ECMD writes are rejected while the TDX module owns
> this
> +	 * IOMMU. Protected by register_lock.
> +	 */
>  	bool		tdxc_acquired;

No need to update this comment. It's still for acquiring the tdx mode.

explanation of restrictions in the tdx mode belongs to other places.
=20
> -static void dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool
> acquired)
> +static int dmar_tdxc_block_regs(struct intel_iommu *iommu)

You could keep the original name with comment internally to explain
the need of blocking certain registers.

>  {
> -	guard(raw_spinlock_irqsave)(&iommu->register_lock);
> -	iommu->tdxc_acquired =3D acquired;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	if (cap_ecmds(iommu->cap) &&
> +	    (readq(iommu->reg + DMAR_ECRSP_REG) &
> DMA_ECMD_ECRSP_IP))
> +		ret =3D -EBUSY;

here a comment is appreciated, for both why a check on ecmd is required
but not for gcmd.

> @@ -2669,11 +2695,19 @@ int dmar_tdxc_acquire(struct pci_dev *pdev,
>  	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi
> || !sm_supported(iommu))
>  		return -EINVAL;
>=20
> +	/* Write buffer flushing needs GCMD, which is blocked once acquired.
> */
> +	if (rwbf_required(iommu))
> +		return -EOPNOTSUPP;
> +

let's be clear here that WBF is incompatible with tdx mode. It's an old
quirk hence simply rejecting it if required.

> @@ -4336,6 +4353,16 @@ int ecmd_submit_sync(struct intel_iommu
> *iommu, u8 ecmd, u64 oa, u64 ob)
>=20
>  	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>=20
> +	/*
> +	 * The TDX module owns this IOMMU. This may be called from

the TDX module doesn't own the entire IOMMU

> atomic
> +	 * context (e.g. perf pmu::start/stop), so don't sleep; just reject
> +	 * the request.
> +	 */
> +	if (iommu->tdxc_acquired) {
> +		ret =3D -EBUSY;
> +		goto err;
> +	}
> +

iommu_pmu_stop() doesn't check the return value of this. It's a void
function. So returning error here still breaks the perf feature.

we may need a way to disable iommu perf completely in the acquire
function.
