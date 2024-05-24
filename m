Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802D1E884
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716518225; cv=fail; b=Z0/es8ZK66QGNj5C+yHWUCMp7QkswSJqBPVKGlC/VcfBUoRwlplbJ+vm0rXLWzxkpvuNwM8mrTap0gAJQBE9HV5VbPy8ZTMIg2Wa9NwiRaUviNwgwHONP4jKErYGlEeyygyM0v4KAfYcpqtzlI7t7huX1wSkiKogiBYbuJoguZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716518225; c=relaxed/simple;
	bh=JcIDEDfcjtx0AqE8KHJrCCAU+PkT/EjRiuojh/xXBKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ntQy0Y7aoXDx7iSprPlWXgqPvgmm/MNkm/TcOLdQAAF4NpwuER+JZkNWGIdXupeawFWMgldK9GLz6XzG2F2+9hEdulrvYcTc8gN4it7jKh6jhLdanhO8D6hHsPqDdVALOmcXe9Nj+jm0O++4gGzrZiHtZ2ArJUnnz1ZTBrtU+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGBN/6/5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGBN/6/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716518223; x=1748054223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JcIDEDfcjtx0AqE8KHJrCCAU+PkT/EjRiuojh/xXBKo=;
  b=fGBN/6/5c4kgPNtIY4/H6WrbzdbxPiqO2DUV4rwzlo0kfS4g+Ffzc+3W
   FpOO5agZ4AmBAMbVmIx48XVKqB2Mt5a2TexYhZgql1K6WSc/HboaJ1cxa
   O3Fv/WACSonh378H9C7SSY/SHYNpcKHAJtacfVAZqOWJNrW+0JtBbt8ai
   ZM2z82ANAmLnIHuaFoOsFyq1SozfaoNv7t3DXgPj/14SvhW133/tBipRE
   7+/mHfedZ/QqUBXWyphyfCPXPIOBncN6u4JNgGOUN2F+qa7CaHYtFmpfm
   EzpGIHBHWt6V6AeQfyTxwXqeAEhaweJwqIj5QVtIBxLadgsfvTo7JTFFg
   w==;
X-CSE-ConnectionGUID: jYxY5MFRT/6n4K3Y7H/SUQ==
X-CSE-MsgGUID: U0VoDlbERfuN4ZFy+8LS5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35394077"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="35394077"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 19:37:03 -0700
X-CSE-ConnectionGUID: 1ni/YHBpR+CWy/kZeqXIhg==
X-CSE-MsgGUID: bVKXQKUVTiy6IEDfE4k9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38284410"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 19:37:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:36:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:36:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 19:36:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 19:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH/if0PMKjMMDlLXYCkXUHmb1d0iY4bcbaMlN/vB9MW9S0cByIO63ZIuz476uWy0U4VwriMLSR+1CE0fH1+KCuVYhlWeR2S81iviTh9QOU6B0q2523M7rfrVJAfWXvyfx+N3+UBOKf0FG/YDcXlJ2AxEsyA7g51Yxi18sMNkXtXZLET3vQK+uJQhMv2UZ28e0fDGIV1W7II+nTc5WScIA5QRNlV84vT29ekWguYlTPfeY6wzRDzzVgJ490EqzB/XfmKeXvxyUatE8iAolT/U0bJ3z5gU+3ZzcVNcpnkaIjdyWkKKg2aez6+/8TTsXfdTHA9qmrX0o8knfC7zDpu2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcIDEDfcjtx0AqE8KHJrCCAU+PkT/EjRiuojh/xXBKo=;
 b=XrcdXmggx5isISfGH8gS3QTM1Vl7FaHXxotPP53+x2RgqPjyQQ39JColag4yJbRE1JViD0CRirSNDcViv0ji0guM7UE6iPEZd74SpZ9cLDBGxmJPDVBVRUnyrnd1SuSVTgtZV4203GBXnmEbMvjy9g+cL4Py3cfus4wOChfPwunMD65O1aCeizeTekUWk4Ze3zi6v/wAzSviR8+JQGQzAh0Zkahf8H8LhBYs+bvuhb0m70vUWI9X5spqycJmn+wOyiHXT3HD+v1U6EfbP1G6mM0UgvzV/C0J9XI/hD2Dp2IPjHO8L7Vqsz1VDg5NdDrDNkROBw1bv6kpOSfB1+5vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 02:36:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:36:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Topic: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Index: AQHajVVjs28Dvjq/i0qw8WNB6ldTtbGTz8aAgADiWwCAAmGRAIAMGHoggABT/YCAAMKCIIAAxJsAgADjaFA=
Date: Fri, 24 May 2024 02:36:29 +0000
Message-ID: <BN9PR11MB527638ED8057DB67C0A0F0BD8CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523125856.GL20229@nvidia.com>
In-Reply-To: <20240523125856.GL20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5204:EE_
x-ms-office365-filtering-correlation-id: 3760db18-92a3-4bc9-95e6-08dc7b9a5139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TjJvN0lGYnM0ZzNmZHA4Vy9JL3g2WGwxM3JYOWpqMTNHc0F4b054TTFrY1Uy?=
 =?utf-8?B?VjZFQlZjY1BvdUVTNXdSVWxRYkM0MWVXKytIOFEwTHlCVFZUZnZOUVBzMGZN?=
 =?utf-8?B?d21GdzFWSDJLdnB2QzJwUk1udlg3RGxvMHo2VU1MVElENG95M05ZZnN6cWtL?=
 =?utf-8?B?elptVU9VNk9BWDdwRnlPOWQwTzZ6VERlQ0cydFdKRWF1d2hmeVNIRjFETzJo?=
 =?utf-8?B?eHpncFpuU2ZxeTBrYkVEMW1wa3lOQTFYVzdqb3A2ZHQvM3ZZQTVua2VRdkhq?=
 =?utf-8?B?T2UyL01lZTRzbW0yenNTSnVla2ZrNmV3elYvSE5XSFEvSDYwV3liV2tCdmdD?=
 =?utf-8?B?MWROTWRJSHMyS0xJcmlTNlFRbk4wUjhFbzVWUFgvVDF1Nk82VE5JUitJRlhC?=
 =?utf-8?B?SXFxNUhLY2lmdVJBd2pOZVJ4VVR3cno2QUdpQjdBS1lCNzBxZ253RjJxdlor?=
 =?utf-8?B?cS9jVytVcXVwZVFmZE9YTFlPUUk3N2czR0kzREVrVWh2V2hGT2JkZ2RWcXJq?=
 =?utf-8?B?Y0RkYXlyRGEySXZQRkE0THNQclFyQlFBUzVtcDNZTmxsbURFV0dsNVpPWVNN?=
 =?utf-8?B?RldPeU82MWZPQ08rVmtXM2VJTURoM0RERUMvUzE5bTJ1YTBBaWlGMTdBVWlI?=
 =?utf-8?B?K0czakRKMlZ1TkxxL3RJaGhlc29Td1dFSzJ0bmRBemJkeUVCMmhSZ2V3MTVl?=
 =?utf-8?B?a29Wc21pclRqNENkT0hOU2VXZkZhWEtaVDIxY2pwdXp4dFpBSnI1MHY4ZmZl?=
 =?utf-8?B?TXRtN0JSbEloMmhKZ0lxNFVFcTRDNVJDLytkYWk1bGlNdFVzM1BiM25ReVJU?=
 =?utf-8?B?S001YUt6YlpseWhCM1dCcm9GOGhhTERqNDdHdFQ4amFVUTE3NS9NdEFNZkNH?=
 =?utf-8?B?elppMWEwRWQ1NUJ6SGFLWXYzcnM1dnJtczJrdEs3T051K2Y1L3pRbk9TVXZ4?=
 =?utf-8?B?WUlzaTVGQWpmT0FRb2xqZEp4ckQ0NzdQSEk0TmZ6dTYrNUtVYW52VFEzaUEy?=
 =?utf-8?B?eGtBUkRzSGdBWG90bFNlRHE4b2w1Vm1VZEFQSUJZVS83WnJOM1JSbVd6dysx?=
 =?utf-8?B?WW9YV3BYUklXdTNITHhZVTB0M3Mvc1BzWDRYcDdKT2lORHFrNCt3eEtIcjln?=
 =?utf-8?B?UVg0dFN2MEx6aG9jQVpsUWhuNXZUemlBNG5ILzlOUHlsVUJDeGtuWlZpeHhi?=
 =?utf-8?B?VThlbU9rWkhlSHVpNmF6cloycjNtbXIwdUEyWW5EWlhsMmZlS2lMbWV3dll3?=
 =?utf-8?B?NzhDT0FUQnBKZ1QwK0JRZnlCTDRXSVBMbU91alZlUVJjZXJIMFdySDdFT0lZ?=
 =?utf-8?B?QjBLWU43TXczNjdyOWhDYlRRL0FveUFML3FxaE1peFJGS1pBNDA4UUx3d01s?=
 =?utf-8?B?ci9lYXdSVUN6MWhKQjNXM0NtSG9nKytkaFlxeGh5eHBTZTZhSCtlTlpSZmVs?=
 =?utf-8?B?QWJ4djQwYUdPRm56N3NlQUFPN1NuK0drOVd2di9TYlpyd1RqeisxMWVDKzRo?=
 =?utf-8?B?eHRPVE9VWFdlK2c5RU92YnV5dGN3aEhsMmNHaHBGS1JzQkJUMXBYVy8vSSts?=
 =?utf-8?B?UldoeVE3TDZiL01KZ1UyMEpjOWxDVXV6K0U5SGV2bTk5dWRoOTdSSHkwVDNn?=
 =?utf-8?B?MTdZd0IvdWpJcWVFNEtXc1hoekZOQk1lbVRrUHhDTWwzUTUvVHpLN1JnNlM0?=
 =?utf-8?B?MlNkSDBQMjBPWWR5b1kyYitUdkZpZGlDQVlkRzJpUU1jWk1USkV0eUo4cGNz?=
 =?utf-8?B?SWpIR3VyOEp0LzBheWdHQ1NkNTkwcXV5Q1ZEd2RCUTNmQnB2RlA0dmJUanBz?=
 =?utf-8?B?WGk4MzJPQ0hzZytzSHhadz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ylg3aXEvQ3UwSVZ6WnFJL2JJbWxKUTk5K1NlbUVlck5yUW11aDI2TzJWRGdI?=
 =?utf-8?B?Y1dEcmpJV2pxS3Z0Q1FlSGp5TkExcktGcCt0TWhjU3VLbGhQcnZkM041Y3ZD?=
 =?utf-8?B?VW04N0FCaXYvc0pkMjNoczhscEp4ZVFJak84RGJaaWhKRW9WdHhFaXNFaHAy?=
 =?utf-8?B?TmdscERyZURQaTdZK1ZwZG1SQWhLdXh1WExaTEsyeUhlaENMRnVpU2dQRTVJ?=
 =?utf-8?B?L3hpYkNlTEE1SlhPYkJ5TlBDRHY5SnJkcmFOemxqR1pCQW9KRzg3dXFxaXI5?=
 =?utf-8?B?eEwvYXN4RTFoVCtna0lVNVErOEU2aGRLbURjNkNvYjhISzkrdzA1aS8vYzJ5?=
 =?utf-8?B?NThPSjQ5d0VXcjUwUDc1RWNDVGhRNmNPcUVrb0NOVUl2UitNc1RvTUhmOG40?=
 =?utf-8?B?UzJzYmtUK2dEVVVweUV6ZVlYVWFZSnF0Sy9DZmI1Y3pmVGxJN1JuY2JsNW1r?=
 =?utf-8?B?ZFdkQWo3d3NwdXlKeDRybE1yNE92dC9nZVJwREFVaDNEckcxbmpqQzIyaTlw?=
 =?utf-8?B?SUhOZnk2VnhaWnc2dXNEWnFhTlZtcGhQalBJR2NidlY3dlgwM1l0VXpYMUY0?=
 =?utf-8?B?MUpOMFErYlVOU3NENm51a0phdmovd3kwaGFQTzVRazlQNVg3bS90V0E3RjdK?=
 =?utf-8?B?a09OSmJHTW1ZRFIrS3JjejdKNTVVcXVYNFkyMDYxVTlsTUNqc3c5TUt1dXZQ?=
 =?utf-8?B?b1l3djJJenp3OWs5aHM0VW9kRUxhai9YQktTeFlnWjA3UjNMSWxJdnFRdkFR?=
 =?utf-8?B?bUE3cE8wVWxTNzA2S1BKVnZoSUxTcHZ0dmlFT0pCKzUxcFZNNWxPV09oNkZj?=
 =?utf-8?B?dUR6YnZYbElHVHF3QldnK1FHWFV5U1RzazhxdENJTnhVTTVUQXZDMS9ZNWNZ?=
 =?utf-8?B?a3E1cWhWL3MzcVI5a1diMlI2OHJXYis0Z0xlb3hlMWpCTWxpazdUZ01VLzND?=
 =?utf-8?B?OUxVeFdicDZsMlREallXOHNhWG85cEJ3NjNFc1g1blA4bnIvblhRWWFKdjRH?=
 =?utf-8?B?L2czaXBtRGxCczhicjFzQ2ZIVTNxdXFrTEtZSFdMUDJBUG8wRUhZcTlYY1lG?=
 =?utf-8?B?V1pQWjFFQ2xyK2VsSkM4SkpFWWZzaFkyN0FVZzFLYXRHN3Q1NDNoQ05lM01C?=
 =?utf-8?B?NFQwK1JjWHM4RC94TEpGOXV0STRUOVdnUFZrUHE4VDNYWjRnNm9McjJCQW56?=
 =?utf-8?B?QTlQcnloWm4zUTRXWFd3TmRJWWx4UlREQkxBY0swYTMxMEJvem5jNWVxSDhn?=
 =?utf-8?B?L3ltc2QwVkJid2VDN1Q2aDN0UGZyMThSQmtMVDVYRUw2VVZwdVVwcFY0YU4w?=
 =?utf-8?B?UGN2OGQ1RTdNU3N6eFcwREpSb2VBVWRYUE9reURRWU5na2hsd2dpZnAzdGRz?=
 =?utf-8?B?QllGaXhKUFFLaGlTTGdOVTdMaG1ETG9pYnpvQVlZUVBXVUtUbkY4M1d1Y2hC?=
 =?utf-8?B?YlI3SGljSUo0UVpWRFNMaWdybHVFQko5M3J0ZXRjNm8wT3pYZHNGM1JqTUE2?=
 =?utf-8?B?Q3ZQdHNZY0lqUkpJaFRSL0ppcThYdHFpaVNNSFJDK21VTGJPY2xkK1lVd0Er?=
 =?utf-8?B?TEFGb2h1Wjl1SGc3RVI5SHNmTnVoRG9JNm5xUUNEQld5eC9zOEdIeEYrV3pP?=
 =?utf-8?B?WWdjSW9rSDFhdUx3M3F5eW95SCsxZzFSQXRQMEtReXJBTnlsTWFaVVVJTGVy?=
 =?utf-8?B?KzBZcGU3ZytuOUx3RjFYQ2pnN0w4S1lwdzFtNjY2OEZrU0pHOFM0QmwrSEtG?=
 =?utf-8?B?TDhTYlFvR01WVlllUTBDZ2lmN005NVhaYXZ1OXBxeUM4TjRQNkhIYU1wcHFr?=
 =?utf-8?B?WDIzS3lFMmZvRGs1SlpUMjRvbXdOWm9KcmpGMmY2ZGRralNDdVdRZGU1eENU?=
 =?utf-8?B?SDZ6OU1ua0RxVjM0SnNUMVZRbW5zMVE1OHNlSVM3eWhuNll2ZHV3UWp4a05P?=
 =?utf-8?B?bGwybXFpamdKNUh0S3FPajF2a3EvWVR3OWZiemNYWlUvWVVmQXpjbzY5WXFn?=
 =?utf-8?B?YjluRjI0RDZIekNGMFlTekFkSTQxSjVaa25LZEdQcmU0YmxSOWI2Y2lYelEz?=
 =?utf-8?B?c2x0dGxyVWlVZUxyUHQ5VjlKLzlSYnJQNXEwUDdiV1JlQllDQ3BNWjhMTEpB?=
 =?utf-8?Q?6odPRMZ24lDfNKjOCsGJ5edA4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3760db18-92a3-4bc9-95e6-08dc7b9a5139
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:36:29.7065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gA7fDsYngLkGGPbtDtCds/MwlwhjGhUfiKbkkXd4BVUvHLSNiq2SDHBvNxitvoBZwMtXu/tzxq+KOm1irgPLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWF5IDIzLCAyMDI0IDg6NTkgUE0NCj4gDQo+ID4gPiBub3cuIElmIHNvbWVvbmUgbmVlZHMg
dGhlbSBsaW5rZWQgc29tZWRheSB3ZSBjYW4gYWRkIGEgdmlvbW11X2lkIHRvDQo+ID4gPiB0aGUg
Y3JlYXRlIHByaSBxdWV1ZSBjb21tYW5kLg0KPiA+DQo+ID4gSSdtIG1vcmUgd29ycmllZCBhYm91
dCB0aGUgcG90ZW50aWFsIGNvbmZsaWN0IGJldHdlZW4gdGhlIHZxdWV1ZQ0KPiA+IG9iamVjdCBo
ZXJlIGFuZCB0aGUgZmF1bHQgcXVldWUgb2JqZWN0IGluIEJhb2x1J3Mgc2VyaWVzLCBpZiB3ZSB3
YW50DQo+ID4gdG8gaW50cm9kdWNlIHZJT01NVSBjb25jZXB0IHRvIHBsYXRmb3JtcyB3aGljaCBs
YWNrIG9mIHRoZSBodw0KPiA+IHN1cHBvcnQuDQo+IA0KPiBJIGFzc3VtZSB0aGUgdlBQUkxvZyB3
aWxsIHN0ZWFsIGFsbCB0aGUgUFJJIGJlZm9yZSBpdCByZWFjaGVzIHRoZQ0KPiBrZXJuZWwsIHNv
IG9uY2UgdGhpcyBpcyB0dXJuZWQgb24gTHUncyBwYXRoIHdvbid0IHNlZSBhbnl0aGluZy4NCj4g
DQo+IEkgZG9uJ3Qga25vdyBpZiBBTUQgY2FuIHR1cm4gdlBQUkxvZyBvbiBpbmRpdmlkdWFsbHkg
b3IgaWYgaXQgaXMgYQ0KPiB3aG9sZSBwYWNrYWdlIG9uY2UgdGhleSBzd2l0Y2ggb24gVklPTU1V
Li4NCj4gDQoNCnRoZWlyIHNwZWMgc2F5czoNCiINClRoaXMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQg
aWYgTU1JTyBPZmZzZXQgMDAzMGhbdklvbW11U3VwXT0xLiBXaGVuDQplbmFibGVkLCBEVEVbdklt
dUVuXT0xIGluZGljYXRlcyB0aGUgZ3Vlc3Qgb3duaW5nIHRoaXMgZGV2aWNlIGlzIGENCnZJT01N
VSBlbmFibGVkIGd1ZXN0LCBhbmQgSU9NTVUgc2hvdWxkIHdyaXRlIGV2ZW50IGFuZCBwZXJpcGhl
cmFsDQpwYWdlIHJlcXVlc3RzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIGRldmljZSBpbnRvIHRoZSBn
dWVzdCBkYXRhIHN0cnVjdHVyZXMuDQoiDQoNCnNvIGl0J3MgY29uZmlndXJlZCBwZXIgZGV2aWNl
Lg0K
