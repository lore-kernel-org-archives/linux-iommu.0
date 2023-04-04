Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102807E;
	Tue,  4 Apr 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680599766; x=1712135766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Y57o25sm20gLcCov6Xp3SlcUL0kSqkU5MEJyNF0MT4=;
  b=AmpJJiuhbNpSuvALzWLWQY/Z/2pO3HBTQrvntED0Hjt06L+u96doaUCE
   RjQ9disrwrh4F0BDGOwdTC4K7Trdf16eLxBefhV9+RmXNaQDKoaXdNhx+
   PL/J+3IhFeLh9DddpVfMgmV6xYgIs6iOOCEfCdoFKPemjTH61pvH34qnl
   Bsji9SRhvUG1ZpSFR9CX/wLaW6GBysrdQOEtOtX9F0uiJgITAufr1Yol2
   DTKmctcNxWJa+m9k+0ZsSaLrh7Ubw71kBXg1p1mbmYP/8okEW/z4fYtYo
   bld97CDl+xhTgq+f5ZEvOHMmziPSt2GXfbCuUfNX8XJNpCoi/sfWk80OW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404893406"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="404893406"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663513806"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="663513806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2023 02:16:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:16:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:16:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:16:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M63FOulWHDm3RTEZzRg9TdnqeNnR+ElOAHZoI5/VAlEcL+r+mjctI9I3uu43uBFn7Dp5TOmP7OPaDPZCfxt63sA6TmxxXvw4ajYYXbnPzn5yWNBhgWsZ1YXe8BqtGPAcCUyhcHxv3Ha5vm8NOPDpanMPgi1kWL4fMRkbva708gQx+lpQaODxUNepegaT2ByEbFZFxIK/l5Q8jGEU/0EXUkqE4Iez2abn+/oJIl7YrVbroh9+zWXSIe4XecslJIzv9vQb9+pg6lIJyhQVpLMiVwDqjrHNruEYr8ynEGTAEMZ1XKpeWoYZvegIA10ucyB73xIVvrD1JTGwvKANxpWvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y57o25sm20gLcCov6Xp3SlcUL0kSqkU5MEJyNF0MT4=;
 b=Ae5YnSqHIE93VIzHwTJ7zFv2TSkIoIxpi8HHOiBVtmHJpZI9QYB2pKI8qvHp+3iOfIYiOpb9KKaOa3YNs2ghuY35p/Jg6OyCBmZkuHAugJ8Fx6kXfQcMAa+gjaSzuW2BcCJXYi+91nd8dw0oqd/zU9HAHVJzlvUdGGYx1UAenZw+rJSVlf5BIVIWx1cqoA1pavhZ1FoncYzpwnoIj11Mn6rh5uv8/qASFi5ggPCZLUG6rf9zvR0s1V0HQCUa2+oc2r6QlNUQ0DcjlLIIzvoyvPnNrJbZWnYjiktCVqE7dXgjJUaVqzCzogIzJhaGTkOrGyNvSDlbnQJeupAIa1lsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:16:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:16:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 02/14] iommu: Add for_each_group_device()
Thread-Topic: [PATCH v2 02/14] iommu: Add for_each_group_device()
Thread-Index: AQHZYpft4dkDYfa9xE6N2sCp0jy7iK8a5tHw
Date: Tue, 4 Apr 2023 09:16:01 +0000
Message-ID: <BN9PR11MB52767F992D799C38FE604FF38C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: 6fa99e75-50ef-49c9-1081-08db34ed35e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEdK7bZgjex6o4JvkaBQrEgTbtYwRGgzlgT3h/7qXLUjXVpFQmm4X5N/xO8knieOt8HqWbsYlki0gSGi/YKLUgjcCfg8uwhTMZTfWBzCHeNWmWSJXMjBkkH0DWj3hV0hdYrjuzKa6Nn2pmSwq4oXWdMfYjWpDfdRPvrpnU8kjYHYLmYNjxPP7xCiZeFxq88JHzPYimduAaAys6fhEHUgzoWuWNB5CCp+r8ExGaE9I3/gnMFKBgRF7WOC71/BFKeO7eJ1qqPGGOk2umUNcQaauZB9UUu/Q0mmM39mzrpn+SRkJ5DjU1x6OEWAbv4fLfk4Z+N0A1b8S05FBFg0KFlyqcxsISPjsStaGCeWetch+S2rDTr/4yjjoaZLtifegUfg34PLYWl0ZxZGq9ctiBkvNwZvggWXGcpsIxWwubflpcQtDB7ububkCsDB5bieJ9oGV3unKX7D7rlthkMM3LN/H617RwJmb/0xU3LlrxFMEE7o+N8zvtyvUqcjwCixlOw4YHG6HXaBHKboCaglPa3YmjBcOJq8Dj0bIsYXjxA7I5R8BWXFAP6utAdgx3Mw5mAOOHTpREJUwgGTw/OeH3eGjwfl08Ve+78H0CG00ky0k8qQjPCNJQw7J/qd5mCsfesUHqex9STc+wxjq7//iPUq/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(921005)(33656002)(122000001)(38100700002)(5660300002)(7416002)(76116006)(55016003)(38070700005)(66556008)(82960400001)(66946007)(52536014)(8936002)(41300700001)(66476007)(4326008)(86362001)(8676002)(64756008)(66446008)(110136005)(6506007)(26005)(558084003)(2906002)(54906003)(9686003)(478600001)(71200400001)(186003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J7wG9GsKaIR3ngzudbnq31DWFM27EIhU62DYRo3FNr/eyYetGQypLAUiCm4O?=
 =?us-ascii?Q?SS+OhsbgmoT8sySs1VOwMdpN26aPFLrklmOurUKdYhCDs6+wrnH8VTke4Mb7?=
 =?us-ascii?Q?7XKkfZjSzNDkIPPWGOzoQ5Z8Fx6/s5dfAt8u1HCQwgUbGQSLhtquqzLHhsxH?=
 =?us-ascii?Q?GJ/+6pdmGEQgNozCpPpo373jlpoi6jRlQ5f3dcw09GWI2AdLI+QHM0/cbDM3?=
 =?us-ascii?Q?bya4uxyFrHkGS6tNj5iiOUw4xfiomNmjF3ZGSertNdopBctvWf2ts5ROcyDO?=
 =?us-ascii?Q?qT8uMjKwiFPe/513beq5kyu+KSSczYsmMxAeTQkK/egBN10393F34QY9rqA/?=
 =?us-ascii?Q?UymTyfe3Sw+RUJLimFKHhfjDHLIViBgfsgftpdSXc2ij99cmxR1W7CsVsj97?=
 =?us-ascii?Q?3l3Y2RoUU3EtwUa0p+/gz6qoP2OzguS7mL/41xWEv+KV5Au68I1Qr44Onn/i?=
 =?us-ascii?Q?tcV2vFRY+sRfW2+vQoUzuWTSv3Tmwl0rGjCcWKXz8j1JpTzfb01cQCznpwiH?=
 =?us-ascii?Q?fEnhK3gGUMt4ZtZ+ooLd/31vKYSRDXkHNwENU2iSw6+9qJYvtPLyCIjI8fJV?=
 =?us-ascii?Q?F6rbm+Y3276rYrUoCTTHe3ZUEqKbwEgnIFByGpon3SZdo1aKHbavmikQwT+5?=
 =?us-ascii?Q?83rOzQ3OvbPFHergiMK70WkUk/RkyqKZOqQKymjmOeeBW0pgB0tmbaGYbPXq?=
 =?us-ascii?Q?12KSh30MvJnOYbasQNFoZmKqYix7jf8svuk04xKX5cfI26drj+/ee6uwVTXe?=
 =?us-ascii?Q?1rdo5rXyRMojPKIS8zgSN4QFLAPNscVBsvjPgnRzdsg9Bk3ssbnZ6DfkPl0k?=
 =?us-ascii?Q?rrqDQOrV+1baO0jH3m6YjJMozTT0fABDGHy2jYfPl0o0UIoc3p0A/XTCDUVt?=
 =?us-ascii?Q?BKtWXViygtv+nr+23VsD35qevmRcy/YtWEpKW5byrAo4JM94YhcFJr+PEh/0?=
 =?us-ascii?Q?eD07Gdq0GDQP9SeaCNvb0c7E0mS1gfHgobrARsh4T3WYalThYYnssLt9KfeV?=
 =?us-ascii?Q?iAoa1Kh8SLnvEWCirhOhRjTEHA2Bu0OeS32xkeughDEM4RaSr0UFeSNHs4N8?=
 =?us-ascii?Q?PlH5xZ/8qaOxGlWy0IWnZ3QgFlGSswlyylbZCJAyTWvgKvCJ3cTE3RDZUyDh?=
 =?us-ascii?Q?k3biM2oi2Eh9vigXVvclictL3eJm4S7gcFYZ6qSDsL+/igGJnDaRTfzHvoGx?=
 =?us-ascii?Q?zsk1YDRWZt/Y1S/oTZRuh6lAHymSHkgOqwkRqCik4xgb1JtkjdOne50Gw6DY?=
 =?us-ascii?Q?e6W/M/iPM0RjuDyP+62dCQfFICUQ9SNa3+PT0YE8DslBPaxBqL0Oca78STJm?=
 =?us-ascii?Q?oNJGdifDW23xQGxOVaBYQ+IEJsyWfYCTzCw4lY9vrxDx/z9klv5LSn9uEDiI?=
 =?us-ascii?Q?6apNfZDfoFuGu5K8x4R4eu/bhqh16OMKpdH5pD5SvLZEtrdAYzCOPr//MrQR?=
 =?us-ascii?Q?aRbd/h8P2SGzrKfqhdAYj37vkEMYyedx+OUkcqE8yiV9qQUVUa7QPYN7oiBl?=
 =?us-ascii?Q?btmlilHd0W5hLFI2MwQ5DJc9vbB0Xis/dpAseibfLNmU8H7jla+Y+8c1X86I?=
 =?us-ascii?Q?x0RqmBF5f5eRIHRdvr7l9kALrPkF9jwdDWdWrwW9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa99e75-50ef-49c9-1081-08db34ed35e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:16:01.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzEd0kiix4JqSgHWYNhhCNjips7Z1fd1HezwcAssIKfFUfhMw1mlWeRfRJMPOOYCDZUryweahW6GM4fUxMGHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:40 AM
>=20
> Convenience macro to iterate over every struct group_device in the group.
>=20
> Replace all open coded list_for_each_entry's with this macro.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
