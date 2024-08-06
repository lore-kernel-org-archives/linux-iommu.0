Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778063CB
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913202; cv=fail; b=k/Ufly6yfm4ygCmXycoNNBzmyJZxDxj5kTIkWGs13yXHPgLCCkr48yBi40uh6fFBDnIs17tTAMBoOMC+nWu1P0IUC09Lbgi5+fIVM3h/2LOha17FJPJiRsNQhpFNiN3P9CkNKhUyt8MUJvAiwIp0NK8JIVw6yhA2sJhT9+4zhDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913202; c=relaxed/simple;
	bh=LSsi3YhpgeAdTHm/mrAaJJpe5rNC23PwpTpcshASAaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KfCvFEgQKbORnRk1qNM9hPaurc/IDKjwhBbyO+ksS3+Ap5GVQanFzomHJ4rJX0SU5MRIsQ40J8ughhsVs/c8ufCDM5CdWTL2VAqW6zc6Irs+rUgZsnSc6QsmXStGg9mUumIUsu5Ou9dQ9WRmbbNrXdKv9Got5+5Y6gfqWa6N81Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwEp1CJz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwEp1CJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722913201; x=1754449201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSsi3YhpgeAdTHm/mrAaJJpe5rNC23PwpTpcshASAaU=;
  b=BwEp1CJz54nXhbbtmUI6azR/OwV6gFTz569H5LE3mE1zaIR8CATdsxh/
   aWXOMq8xAwYfnWKveL9jxnn1drObkZTFEPJEz1Fi89eeYVi9rctMphO/T
   UQKQt3o9yKzAnOjWQnD4WrTdn6cbeTYa/B406DGdY2jhDUmPT1dCxv3GO
   dwo8td4d62DmMuyBehbqWKHdxZRPS3U9dwh5zrYdsxsY1LhZvJh6MzOJh
   4u16e7hZCmq2vx/eKZtUp6CyRXF6DCC76xIsM52fj2YkBdSryEZXewczh
   iZ4nwdGlylAFdqM+OkRmYLJaOEf77ibgN4mHQq3clY6snj4OY5L9eFRdF
   A==;
X-CSE-ConnectionGUID: cJWtlFjwRB23cJnz2nK0/g==
X-CSE-MsgGUID: gVzmtex9RZOvuHg8iDj7Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20782681"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20782681"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 20:00:00 -0700
X-CSE-ConnectionGUID: VavPzobaTnW4rYrnrZHa4w==
X-CSE-MsgGUID: f2p2t1Q0RS2fIr0o21yqOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="61181305"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 20:00:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 19:59:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 19:59:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 19:59:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 19:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKAmyCBGVwV5adIEHhMcyQcRz3PEGIVzB5Me7/XXHwwxOVZRKfxtimXGe4Iz6yQKoh/883lAJVm8VNSFfDBJ14/9QzfCk5oQP8qzlflB/uEuKvcRgsamHPK+p/fHB2ufy4PYVrJu9RR771oVi4CnULzWxEaFeDQtJ7J4NT0gqv2DB+V5xZxPEtgYqCvAIm9x3c2q/oKWPbUXO7XpawJWvyI2f4y70A0fytG9fd0/Hw1cdqR/qsXhIGkwayE9CBOe7XyRRLpEaKv3oVLGP6el7vRsipCR5Ch9YEnl1NFO9VI7cEb+5efs6nLdPDBPvZKqg6cUH3WapzAifClvvtvvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSsi3YhpgeAdTHm/mrAaJJpe5rNC23PwpTpcshASAaU=;
 b=iuVRdPuZ4qOjmeRMCieaXhckDsjX932yB+PsnEDbGgpBtOJ+XlYGwfd1niUTltpKmiygJ0H8dI+qs2668rftXBRZw0ImOpImeDIh1r69kJxyw2W3oEQ55uUv+O4wewfBi9LWQWVXe/Q4zxgIOkz83rap55gnm2LJjSC25fRhsQYtGWUzdu89Ai7DUeEkp5mSDGj5jeWE3Aw3ZsZFe6fJycLuOg4Z/VfNEKW26aPCchBdqFGHzeTZMCJOzUwb9r+U8W1f+oT6iQxwI2pvBPWXXAIYMvnwHi5dpSC+HglA7+vi5k+CSzhm7Mtwvy1f9CRAfiiLvDxT6qykCJt+NuFDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 02:59:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 02:59:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Thread-Topic: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Thread-Index: AQHa5J3TlyHszQz2P0CCi2K4J6viy7IYRw6AgACzUYCAAI8sgA==
Date: Tue, 6 Aug 2024 02:59:53 +0000
Message-ID: <BN9PR11MB527682A9FBDDE82439A3F7E28CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240802053458.2754673-1-nicolinc@nvidia.com>
 <BN9PR11MB5276B6D6A75FFDF7DB14CAC18CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZrEQt5r978B+Pgex@Asurada-Nvidia>
In-Reply-To: <ZrEQt5r978B+Pgex@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5090:EE_
x-ms-office365-filtering-correlation-id: 0eda940a-4d42-49cc-8c2d-08dcb5c3d86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SVYyTXZRazl2bmtZTThDUE1JNW5KU3hkdWUyY2NxeDdwTU5YODI2Tm5FQXVQ?=
 =?utf-8?B?amlUY1BZZ2hsK1FDbGErSHRrZEhOd0VhTGVrekltL2wrWGd0WnZ0Y3pqNVRN?=
 =?utf-8?B?bFEwblI2d28vS3lsQ3ZsMllKdkJjYSt0cXZMbEMvMmliUWw5WnJteXFqeXph?=
 =?utf-8?B?Q3VnZ1lUeTF2ZEE0aGllT2EyTktBMmdET1FFaUxIMWw1NWRvbkFuT2c5L1FE?=
 =?utf-8?B?UWRHVE9XY3c4QUlqb2hweUR5a1pITFkrc3dXS1Z3eUJKR1FlYi9GSUJGNTB0?=
 =?utf-8?B?cXBBTDdGNVAybXhJZzRMWEw4R0VubDlrTWJMVlVRODFHY1dmM1Q0cWcwQ1V6?=
 =?utf-8?B?dWYvWW9BbWNjbUNheWJlMlZIdmp4blo3dUZkTkkzNFJNa1JUb0RkcFQzV3NB?=
 =?utf-8?B?UHM5SXFUZ3ZQTW1IR0FZbS9zTktoTjhKaUVFWVcrejdRczRTOTl0YXY2a3J0?=
 =?utf-8?B?VzMrQjVUVEVmTVhhanFEajVjdVlKaDFGdUdzUWMvcStxUG5PSk9WQkZvWWRh?=
 =?utf-8?B?c1NIM1NvK1BCc21VWUZ3Zm1YU0R3RzR6UGJidDVrdE5YNk1RVGVnbFdjd2w4?=
 =?utf-8?B?azlZZjRCYVRCUFVUZ0FKbzRKOEU3MkE3SXoycUo2Vm1RQ3lYa0g0YmhJNzZq?=
 =?utf-8?B?eHc0VlZvejBmMkZwdHZGcFhDbU1PblkzT1J5SUpRSnAzSnBzWUoyeitWMEVq?=
 =?utf-8?B?R0k2Ky9DMVRDNDNnaXNWWnVKdnBYVnJ5YS9obXdKK0NNbDVCUEF1c2tqV29U?=
 =?utf-8?B?aFlZR0FtbUZQWEgyRVhiamlYcVdSbDRtZ3BwVUNUbVlyMzdOcG9XVU5yYXpZ?=
 =?utf-8?B?OHh4RVk0ZmdVejVEeGtydkZVSDY0NXFkNTVFNlVaa2RPc0FneGxJQUkzNG90?=
 =?utf-8?B?aGR6SEIyMXJYeGtKQkJCZzQ0d3V0ZTFMMU5SWFpOTjI3VkY1UWsvcXdaWmhE?=
 =?utf-8?B?Z1QxUXBKcXIxNkJYN3pac1RjSFprYS8wWm93Q2xoWENpd1ZGV2lyWVpJOWJk?=
 =?utf-8?B?dHAvMWNPbThoVjFhSVdPdUt6dzNCTXY2VkZORkM0SDVsNE96NXE2VnhWSXZL?=
 =?utf-8?B?TkFCL1dCZmM1V1ZYVEpYS0dRNW85aFh1OG1NTlNSVTJNVVJ2eXpoS285T1hN?=
 =?utf-8?B?S1FQNXZKL2xkVjR2aHVqYXIwKzlpVkZpaGd1NXVHcWxubTk3ZUx1T2wyMzUz?=
 =?utf-8?B?Wi82a0ppVUFYNmpIMFgzMnhqRUQvdkdPL1RzeFdMQzd0MFV6cmRiK1VRblBF?=
 =?utf-8?B?L3VVU084ajBjbCtMVFdnNVgwMERJaWQzd0twbUt4dnAwc2ZyaXpnT3BxRjNG?=
 =?utf-8?B?d0JNZlVVbE5SWkRmd0E2ekxSQzdTbDI0NW84MDJTUnRlMVJsYkhka3hCREsz?=
 =?utf-8?B?VGZDUmIxTjJ3Q0M3WFcrRTUxSUx4dTVCRVN2cGs0d2UvTUIvaTlWUzgwM01M?=
 =?utf-8?B?QUV1emZFSTVJV0dvVWY0MEhGSDVrUDZQZ25mNFcyNTd6WE41b1JMRmtSZU1o?=
 =?utf-8?B?d0JCSXloSFppMEVJOENBM2ZQZ2tPTVBLSjI4U25oSXdHTkwvTHZrK0VlTDlL?=
 =?utf-8?B?S1R4b1p2N3RqOUFIZnBDSmMvcndwSTNSNC95Y0t4TEo1d3pLTjZ3SExxYjA0?=
 =?utf-8?B?dExJclJ1YURqYVEweVdZU2o5aE1zb0hFa0JyalFLTXIzN1VURW1kNWovWHAz?=
 =?utf-8?B?OFFIbnhNUUlJUnRGQ1NsbXJCa0ZidzdweGVUMHRna21rNWZBVVRnVVI4dWtw?=
 =?utf-8?B?QnRFTXFVRGl2ZTlmMkZvdmtrN3FNQloxSm0wVmJhTkJxdSt2ZUpMZmVYNXgr?=
 =?utf-8?B?UXNxemx1d3Z3Yk4wbHdFY0hGYnFJQ2lZUnBXaWE4VmtkTU5OMDRRaHU0UG5y?=
 =?utf-8?B?YlQwMjJoUytERXppQ0o2b084K3U5RHB4Y05VMDliTkt3a1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHV2a09nVElBU2xZeWpVNW1TcU43YXZ4cUVQaFlmRjNGMm9RcWpqeXlWSDRN?=
 =?utf-8?B?R0tHUFh2L1Y0ZzZaVVdoNzBCSm5QNXhZRFh0c3hxL1gybTliemo4L0tDSGw4?=
 =?utf-8?B?NUpTQi8vd2ZVa2d5c1dmaDlIRTJNTEoxSGFOQUlKalp5RHE2VDZsWEdGdC9M?=
 =?utf-8?B?U2ZGdlNuQVpLVGZTem5jcXM2QkRNbStaOXIwcW16YWdLQmF5bWk1bmhqVFow?=
 =?utf-8?B?d0dSWk05ajdGbExJcVdpeE5LdXhpeU1mVW10Q2F1VnZubGVvTXVudlJOazkw?=
 =?utf-8?B?K2ZGVU5RTGlXWS9mN3FWQWhNbTN2N3FnY0xOeDExQVVBdU82VHBoVVI5d2ZI?=
 =?utf-8?B?NWczbUdvaDByemFlaUdrcUxJSXRWSEVZeDZjT2NVaUdQb2lFUEtvbzF6L21E?=
 =?utf-8?B?aG9zMEdZbEpKSUFIRisxUy9tWkVrL3VSamZSak1zdHByb2JicGJUUkZObWxZ?=
 =?utf-8?B?WEZZZ0tteWFTKzdzdUdqQjYydlpWL1VONGFyQ2pPNWhidGtzTzFBdGN5Wlps?=
 =?utf-8?B?K3cyeGZrZ3BJanZ1a3hDYXNDRkZrcngxSzBiR1VENDlZaTB0ejRWNXlXbEUy?=
 =?utf-8?B?ZzVyQ1ZoUytPNlZlMGdpbk9SMy9FbXROSi9HRmNSM0JLSE1UdFlBMmpsVDB1?=
 =?utf-8?B?MTBGOXNHVEFHejBNV1V3UUtQaUcwZ0NER1VEck5jSjlUVWM3bnk0WEJWdTlN?=
 =?utf-8?B?NnZBV0sxTDk2d1FlbXEzeVZUTmwyeHdBT2VlM2dicldmeXJTRUVLbnJVUVhq?=
 =?utf-8?B?d21wMHV2UWV5SUU1MFNjRzBjZFhIeGZUa3NPb00vT1FsRnVoL1pYN0k3dFgz?=
 =?utf-8?B?SzFzamNIZGZTckJzNk8yZjJ4ejY4clVJcTBSUlpXMUhydk5FRUM2bkNiT0Ns?=
 =?utf-8?B?Ylp6VW9jeWJrOVNjMWV5T0JyNmtiRUtFZTh3RzE4Kzdmc2dCRXA5VlA3aTQ3?=
 =?utf-8?B?Q2N5eS9QWmZIUTNJcHEveHlNZlU2SjN4eE9DdjdrYk1PYW54VzNJbGZ0bmF4?=
 =?utf-8?B?VXIrZ2hYVmp5RXNONzRlZWFYdWFhbHY1dTY3WnZNbFVoN1M3UHNHWWVpZWxZ?=
 =?utf-8?B?MnZSeGE1RHVQdG5VelNoRThEK0hkS25XTzJWQmdENFgvd0haM2d6c3JONkhC?=
 =?utf-8?B?Yk5zOXV4M0plQ0gwRG1hcDVYZlJIeE1WTXA4d3E2OGZhWGxMTU01VEFBWmNq?=
 =?utf-8?B?SDVMc1VjTUE0dWVJOGtjbU9NNkpaLzdEMWNVbVlGdUhPakpaYWVJK1J5dlNZ?=
 =?utf-8?B?VXZsc2RyQ0laZmFjRHdvRkpVSG1CVGpiM3VqSGNuRC9RUkV4YTF3c3orOVJk?=
 =?utf-8?B?dnFQcEUxVnJMUE92UENtN0lvbTVQV2t1b25McEczL1FIWE9hMC92WiswcXla?=
 =?utf-8?B?Y2M1OS9meVRuVTY0ZUhQRk1hQ1lnWHdYSld2bTFSMVJ1SkhseTNJeDU5cHB6?=
 =?utf-8?B?NVFBdkVuczlSY1dzVHI0Z3pTeU5FNGhwWTRYN29iZUhvbHo0dXh3aUh5aTIr?=
 =?utf-8?B?ZmhzNmI1am8xNlZYMW5uc0NFcTcyY3RXRk1TYlN1R0VCem9rNmdQSVpJcG1N?=
 =?utf-8?B?US9id1JPRklRcjQwckhZY3dvNFkwYTZtMDVoeTlmcUN4Rm8xcGpXcFJ1RTJt?=
 =?utf-8?B?N2pKL2hBRXFIWnlnOXl2QkNVNzUvaHVVb0FOQis3dkpLUGRTMEpVRWRHVzJJ?=
 =?utf-8?B?SmRDKzN6N1E3TTlkNWhtRzJJWlhKczkwZkJmaHVpUWpNUUFjWm5rQ3NyZ3N3?=
 =?utf-8?B?dTc5R1FmNzZzaDUzQkRMZFRPSlhsRGg2Mm5jV1Q1K0RIQ0tTN3M5cjJpbEQ3?=
 =?utf-8?B?ekhxZ2hmUDdFczlNRmE0blQ1N3kvR3JIUHovR0x1UU1GS0pWZTk1OE1yMy9N?=
 =?utf-8?B?WFkrTXoyZHpUU1BCZEJSZDhtRmc1VlFBR2ZEWE5mejAvQjV3dEwzUlhTZVNj?=
 =?utf-8?B?U2lsRDVSRmdPVjkvSUxTRmdQUGFjK3I0VHVKU1M2dE5pMGNtcUVxMndKSzBF?=
 =?utf-8?B?NnRKZVRibDVUdTVGRmpUalp3MzNjOTVHQ2h4eEE5MVdKU2N2ZThXTHBPRDRq?=
 =?utf-8?B?WGMwUFNpSmpyZ0UySzdTS3k5TE5Hb1k2Z1VBMHk1RkN6TGxuSUVJT21lak8v?=
 =?utf-8?Q?LGfIUOky299xQ3dgd/IppTF9u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda940a-4d42-49cc-8c2d-08dcb5c3d86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 02:59:53.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwKUl/A85du4b33aPdbLIGr2HLLCcsOp6GWNl9f246ryt0oadYP8i/uF78z5L1uyuw26PaoIP0U7ky+1tSVf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA2LCAyMDI0IDI6MDQgQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDA1LCAyMDI0IGF0
IDA3OjQwOjQ1QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MiwgMjAyNCAxOjM1IFBNDQo+ID4gPg0KPiA+ID4gIHN0YXRpYyBpbnQNCj4gPiA+IC1pb21tdWZk
X2dyb3VwX2RvX3JlcGxhY2VfcGFnaW5nKHN0cnVjdCBpb21tdWZkX2dyb3VwICppZ3JvdXAsDQo+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9od3B0X3Bh
Z2luZyAqaHdwdF9wYWdpbmcpDQo+ID4gPiAraW9tbXVmZF9ncm91cF9kb19yZXBsYWNlX3Jlc2Vy
dmVkX2lvdmEoc3RydWN0IGlvbW11ZmRfZ3JvdXANCj4gKmlncm91cCwNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9od19wYWdldGFibGUg
Kmh3cHQpDQo+ID4gPiAgew0KPiA+ID4gKyAgICAgc3RydWN0IGlvbW11ZmRfaHdwdF9wYWdpbmcg
Kmh3cHRfcGFnaW5nID0NCj4gPiA+IHRvX2h3cHRfcGFnaW5nKGh3cHQpOw0KPiA+ID4gICAgICAg
c3RydWN0IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpvbGRfaHdwdCA9IGlncm91cC0+aHdwdDsNCj4g
PiA+ICAgICAgIHN0cnVjdCBpb21tdWZkX2RldmljZSAqY3VyOw0KPiA+ID4gICAgICAgaW50IHJj
Ow0KPiA+ID4NCj4gPiA+ICAgICAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmlncm91cC0+bG9jayk7
DQo+ID4gPg0KPiA+ID4gLSAgICAgaWYgKCFod3B0X2lzX3BhZ2luZyhvbGRfaHdwdCkgfHwNCj4g
PiA+IC0gICAgICAgICBod3B0X3BhZ2luZy0+aW9hcyAhPSB0b19od3B0X3BhZ2luZyhvbGRfaHdw
dCktPmlvYXMpIHsNCj4gPiA+ICsgICAgIGlmICghaHdwdF9wYWdpbmcpDQo+ID4gPiArICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgaWYgKGlvbW11ZmRfaHdfcGFn
ZXRhYmxlX2NvbXBhcmVfaW9hcyhvbGRfaHdwdCwgaHdwdCkpIHsNCj4gPg0KPiA+IGhtbSB0aGlz
IGNoYW5nZSBpcyBicm9rZW4uIEluIHRoaXMgaGVscGVyOg0KPiA+DQo+ID4gICAgICAgICBpZiAo
IW9sZF9od3B0X3BhZ2luZyB8fCAhbmV3X2h3cHRfcGFnaW5nKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICByZXR1cm4gb2xkX2h3cHRfcGFnaW5nLT5pb2Fz
ICE9IG5ld19od3B0X3BhZ2luZy0+aW9hczsNCj4gPg0KPiA+IE9idmlvdXNseSB0aGUgb3JpZ2lu
YWwgY29kZSB3YW50cyB0byBlbmZvcmNlIHJlc2VydmVkIHJlZ2lvbnMgaWYNCj4gPiBuZXdfaHdw
dCBpcyBwYWdpbmcgJiYgb2xkX2h3cHQgaXMgbm90IHBhZ2luZywgYnV0IHRoaXMgY2hhbmdlDQo+
ID4gc2tpcHMgdGhpcyBzY2VuYXJpby4NCj4gDQo+IEhtbS4uSSB0aGluayB0aGF0IGlzIHRoZSBp
bnRlbnRpb24gb2YgdGhpcyBwYXRjaD8NCj4gDQo+IFRoZSBvcmlnaW5hbCBjb2RlIGRvZXMgdGhh
dCBiZWNhdXNlIGl0IGRpZG4ndCBlbmZvcmNlIHJlc2VydmVkDQo+IHJlZ2lvbiAodG8gdGhlIHBh
cmVudCBwYWdpbmcgaHdwdCkgd2hlbiBhdHRhY2hpbmcgdGhlIGdyb3VwIHRvDQo+IGEgbmVzdGVk
IG9uZS4gTm93LCBpdCBkb2VzLiBTbywgd2UgYmFzaWNhbGx5IGNoZWNrIHdoZXRoZXIgdGhlDQo+
IGFzc29jaWF0ZWQgaW9hcyBoYXMgY2hhbmdlZCBvciBub3QuIFJpZ2h0Pw0KPiANCg0KdGhhdCBp
cyB0b28gbXVjaCB0aWVkIHRvIG5lc3RlZCB2cy4gcGFnaW5nIHR5cGUuIEluIGNhc2UgYSBuZXcN
CnR5cGUgY29tZXMgdy9vIHBhcmVudC9pb2FzIGluIHRoZSBmdXR1cmUsIGFib3ZlIHdpbGwgYmUg
YnJva2VuLg0KDQpJTUhPIHRvX2h3cHRfcGFnaW5nKCkgYWxyZWFkeSByZXNvbHZlcyB0aGUgcHJv
YmxlbSBhYm91dA0KbmVzdGVkIHBhcmVudCB3aGlsZSB0aGUgb3JpZ2luYWwgY29kZSBhYm92ZSBh
cHBlYXJzIHRvIGJlDQptb3JlIGZ1dHVyZSBwcm9vZiAody8gdGhlIGVuaGFuY2VkIHRvX2h3cHRf
cGFnaW5nKCkpLCBpLmUuIA0KYWRkaW5nIHJlc2VydmVkIHJlZ2lvbiB0byB0aGUgbmV3IGh3cHQg
dy8gaW9hcyBhcyBsb25nIGFzDQpvbGQvbmV3IGh3cHRzIGRvbid0IGJlbG9uZyB0byBhIHNhbWUg
aW9hcyAoaW5jbHVkaW5nIHRoZSBjYXNlDQp3aGVyZSBvbGQgaGFzIG5vIGlvYXMpLCBpbnN0ZWFk
IG9mIGFkZGluZyByZXNlcnZlZCByZWdpb24gDQpvbmx5IHdoZW4gYm90aCBvbGQvbmV3IGhhdmUg
YW4gaW9hcyBidXQgZGlmZmVyZW50LiDwn5iKDQoNCg==
