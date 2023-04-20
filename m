Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D728F6;
	Thu, 20 Apr 2023 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681975973; x=1713511973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jAyncxYVFVpbsoEA0J2OK21yN+EwPgcIovSF3A68ROc=;
  b=Va8t3fvUhcqhx0oWUCUN99Cn/guis2KlhryYqRaGDk6q6p96WMd6baXh
   83RasUlPSTJwPjXXKl9b3T7O3j+qbb7M8TPud26+tLNwYywqIqSQ+1W4z
   kno89Nw7SkK1oOXgyKBXbd6pOic2dJZKcwCssS6vulK27J2Xc8rhWIpNe
   3QzsUvxkX5W+Guqc1gKI/eUnwk0kQ1ebK5ndo9HnV8WzDVNDJgwJtEjgC
   DQwlK+g38o03NXi/3Mrmni+PEMqrF7tvwLTxuJuNO0fpqvAxIOXgDuOI4
   HoKfJFZLIjgN1O3I7ZsUOWGlB3FEQxEEX91/hok5yRHZWcLfBD8lFvYyC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431936412"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="431936412"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691799777"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="691799777"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 00:30:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:30:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:30:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j68OuyT2Uq/TLCM3qwT0IEa9sad2372xmHfNIpxOFP+V7i3BMlBU51SO9fjmslfoEQytK2A8+V2XKUM4XTHnMjZ92eJdcRJVUGLNlpE/1oepHiCi/GXgS8b4LN3B8ntziphUEzSXBTcDy9dTTyXjS+c/Fq4fcTdYF8PmwxGA3or1YCXMI4m1FLBLhzUOvvbH0QOvqwT1UButgY8QBbKqnUtEcmLq1tE9HheEpziJPsEOh7KciKekosj6b/hotD8ma8tnqCTWS7DoymQFfV1Q+mC8HdrNTP1Vm6Y48xjzF5pMtG5IW+mr8WeOpUi52eJTmNeyl4GJXyFEZtY029cR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAyncxYVFVpbsoEA0J2OK21yN+EwPgcIovSF3A68ROc=;
 b=e5168WskMBbj66XaAhNm5JP05pJtWOb/vOpwXYAgi6LjQ+Zu0z070vVkTVIHEsN+Ve3o12f9do5vCK9PN19wcHqRBwaukbT19m8qyJzSUfgij9Z8fPOlJ20DYaMF7Mxv50TmO7ZeiELRqzjPAWSPNQvFB6Y0/xTtJki4neea5O2Ta4VbXPVzpLn8i9ddiA97zFuSSq1FGJxfAltzYmmOD1VZ9dbm/kJuuab6n9g+h0GZGgej+ZOfPFZFybSHBajrwy5B+lMSy6XbBHdWz4VzEapio/0fcTrb7t5YGuuhaWvo8R462vyKDAGgmMjAt999vDJF4VMzQseXXmzXpH7zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:30:16 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:30:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 12/17] iommu: Consolidate the code to calculate the
 target default domain type
Thread-Topic: [PATCH v4 12/17] iommu: Consolidate the code to calculate the
 target default domain type
Thread-Index: AQHZbUX2we+6gVM7xkyT5GCsJk1Zlq8z2UGw
Date: Thu, 20 Apr 2023 07:30:16 +0000
Message-ID: <BL1PR11MB527123FC8022F33E725420628C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <12-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <12-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 6c9a7b3b-13a7-48fd-0239-08db4171167d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSxFbp9IPspP9llczU2pIlvNC4wT26Fq3U3MqkyMVHcVxOWGC/qM/kPcKtj1zrsmuZjoRKftfLNxKN5j0ty0sCGG3YY6m0cXPVRzoRoVn1JAv5mCD0tNLRpC7zNnQMR5LgftI0/5Pp1IpEuj01J9tKWOh5ZY46EhUrOc/nSEC/AQp/FqQQijCPXDyez9dGYWvPV6sN0UorN1OwNbnFiyRr0COpCgfayOqAiux5t8KsAyEssxjBFgpAYzMxB5clcjnumGjpLv0AMIj76Y+R6om0ldJyjIcYWyic46kReVX89Hao1nGbEbUCRNefIB1xaCw+hKZbKkfG4/Hrc4HuvFrwKeUtjZeAy6aWlJO7SDD3OO+3nZpjebcWn3S7LK27R4+zRvZK3GCeAZq4RZ8Ym2EC3w3qYUnU1FpTgQXYST7crnXcMpsIvZafiVDhIOHYFl68p/7ljS2tQh8m21oY90cHIhu4L9+VTvpENzZdIeW/G5PaN4mpe3UtxghrOmkYo6F3xRZXjtZ/yPo4pVzRiURrquULLjViO695Kq+QUWnioYAv3jkfEViFsMz3hM2rcWZ1zUgZn4TX37ycnqP6wk7DC9AQX4O8pLAUCc38w2S5AHCCOYgVISejzPIlYDR3nQxX47o2kBXIG6XWu+22fE+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(122000001)(921005)(2906002)(4744005)(82960400001)(38070700005)(33656002)(55016003)(7696005)(478600001)(71200400001)(38100700002)(26005)(6506007)(9686003)(186003)(86362001)(5660300002)(7416002)(41300700001)(316002)(8936002)(8676002)(52536014)(110136005)(54906003)(66946007)(66446008)(66476007)(4326008)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J74KuP1sRfv8F6Tj1cq2cRSKCeUz16XY2gy/AAJddcFNV35ngZySnCGeTDZu?=
 =?us-ascii?Q?zk5eyTZJIrimsKrd3RKD9xyUQldIRk2DxuzWHvMwQE/O85sAwLMNuJf+dLpV?=
 =?us-ascii?Q?yEzIC2KzayqV2zJKtiRulCklhlTgIpyUrs25ZWOkSo01hxNgy7HNTx3RUnul?=
 =?us-ascii?Q?BTYA8d/aD33QdFxorJDvXFvUbBMVa6HkNDfzzUEjWmq+Vk7RKaaP7WFrhXpC?=
 =?us-ascii?Q?+NIbZxq+GpQWqszDKGA9/tr+SvdsNuMXWq4ojAtPrUczt9SlDVNONXhR/jHY?=
 =?us-ascii?Q?fR2FWXkzZNQn1ZRtFkxrIu/gPnTXOfF3gLzZqhhIMFijLvyzp4hrv4GmLxej?=
 =?us-ascii?Q?smUwvoNxY31AgtziyizHjBsDNZ3QRlp9v/4kSFBVExQkxvVXk/FpTrcL1S4/?=
 =?us-ascii?Q?6fuWbuLf9Rkdh70wz/fpORFmQCOUrn5+D+7HBZ43TBHkjbn3fNLoKmBKX/ty?=
 =?us-ascii?Q?yLPliZhSyosXmrErFrltqHKqXcK3WfzshxIxwmE3zkVFeYuqWNIZr+LpWJeJ?=
 =?us-ascii?Q?uk3Buoiq/3Y4n6ELpdw5tDZXg6Lq9ha887wgBeZdZm74PX2cBYnVkAp9h+iB?=
 =?us-ascii?Q?DKKHLnVoL87Go1Huw3lTPEQ01lK0V7alX4QHUS4PXADp/6r80gSuH8Q7QShO?=
 =?us-ascii?Q?XTozYH053bX0UPFSUwHzMXuYZHnKDzbrQyJ6QcmLv6DICt7Krje5RB6pydFb?=
 =?us-ascii?Q?PT3YVtR3sJYDEQ8/1jlY3brrVECJWNtwGJ0LKujRdMnf+TOt9WbL5I0uRuLi?=
 =?us-ascii?Q?1+4elh5pzZBMIkSX6KzfMTwRgtUXZXPZq4m5VdffLFlBbR86ijL1BCk2HK3B?=
 =?us-ascii?Q?JoYtdBOApOYdGrr7NNou/5r5NApDE6rTW2ELMystufEh57hw24BeZ0UraddZ?=
 =?us-ascii?Q?5uMeoQoJjLDnGL6PqFVMJEK7gfOhsd2K6LZ8h7u0mo+xYgZlDOZN7K1gg09f?=
 =?us-ascii?Q?0CszqMZtRFUziOUYoSh8XHAS2v6jS0ionqwZ2+aWPUcUdU0k35DDgCReNrqc?=
 =?us-ascii?Q?XX2hUJObuK1GFjijHyLojMIKNsiIy+pRHBDiHnCmliRdsZAbLwbo8eLhY6dV?=
 =?us-ascii?Q?KHF2UoSVHu9tILExhO9d3L1mmg8DDKepsJ4D4A7PuEvKkeqebD16v2F/Dxre?=
 =?us-ascii?Q?uJ5DF7hzfsJ8FEJiWAuw94o4VakwNwa69c8fSnTvPVtHYm9wsPCA+uEUE3/B?=
 =?us-ascii?Q?JJgcb0dTsYSTGfm/YtjbmZXxM7kdHbw04SCyrKFX0QCf9Nosq0cssAua6V6c?=
 =?us-ascii?Q?gtH/jpEWu7XyKCcA+OIwJj8Q8Py6A910ytdMEmmtj/0x33bhpugBQk7Jmdvv?=
 =?us-ascii?Q?/XNu541OYXJQUaIod7MpqDxh6d4+snmLkWoBQaj76qIWfLXdtq+nG4UAU1Cg?=
 =?us-ascii?Q?RSRB+WeaIVgjjXGBL1Fu/NT1mHfNDv8h7bLCqLCaOZETEEoW5+3O13plsPL2?=
 =?us-ascii?Q?KD2YfB46NfiYtOgbHMg7XqWm0bc/nosqOSR2fF3f1Fn9gHMsME8atwywvlk1?=
 =?us-ascii?Q?EV68Zns+SIo8YwHhUZS36Da5u0EXyX1pZ2ObMJDDo9PJjBYRLHchqfsfgpmj?=
 =?us-ascii?Q?+cydqm7fMJO1j9AYDybzXPvzoDMPCVE8vnlkHefM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9a7b3b-13a7-48fd-0239-08db4171167d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:30:16.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DoaNoTFk0xiLtrWcwfg9ygY96f6PD10vVXZowPU4cAPKB+3HLEbLhzDv4JheEHjMEyv3l+ZFtud5CGMUn3zqpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> Put all the code to calculate the default domain type into one
> function. Make the function able to handle the
> iommu_change_dev_def_domain() by taking in the target domain type and
> erroring out if the target type isn't reachable.
>=20
> This makes it really clear that specifying a 0 type during
> iommu_change_dev_def_domain() will have the same outcome as the
> normal
> probe path.
>=20
> Remove the obfuscating use of __iommu_group_for_each_dev() and related
> struct __group_domain_type.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
