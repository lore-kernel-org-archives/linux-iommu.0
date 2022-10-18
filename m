Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB141857
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 03:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666063636; x=1697599636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h7GhSXV6kqAzvI6q8GwmgDDB9mygg8663ZtUi2VyVfw=;
  b=bmcSXi7Ksdmyly40TjP9cgrhr4Gdtv3mGcqi+6hrP6nAByXM0xp5/PGg
   gTrb89xMlPVMig1t/uixLR0gdazz4YRkqh/63F3NgiFqRu92aD0x6MBBQ
   DzQg1I9bHCIT5DOy9IYORCuPLj4kyTX054n3KUMkTKfh3+o3NE7hk4Oty
   00EskjFW/KAzhNxH+wYyjNiIiA2DqPNmfpV9Xqb0Hn6kCe91S9jxe7RPC
   1SO8wM6rgxG06/8I/0VwiLqF4AnlwT3S2jWzorR64D49YdoJVCRrsZYaJ
   2mkIV04+eU0pE5+MBfNooAkdUG9RTcu7DgbyB4gsphC7bTJdHmgCtId6e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303599022"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="303599022"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 20:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="873717530"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="873717530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2022 20:26:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 20:26:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 20:26:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 20:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GknQ0jKlRNkCr0Gp9LKb3gD+VlzS6hvBpQbHcMu4vQpYh9TnpyNma46c7dcMrGq3ly7V+v4nzTy2rDzjIPye+XKgxiLuVfLfShijCMqYmkJ+5cQ4OCr3D833VSy1+nXKuh96Mr2/bM824aJ3Ef+ZL7Ph8MR8epFsSFWCeHSRjCaRrsGBVvVJKzzEc3epHblrICRzkbYXU0ulaR53cucf+uG1nSdCSM5svVsycodjvmB04Ei0diS7Xa5CQLhXm1SlfiZ5loTv0Psqe8/K7Px28Q0s6Z3XjWQSU8LmzQjb7mocthmg8h8IwE2fTTpo6NbxLm4BjNNgOxAW8nMu0g4oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpdQMsvRtDTRzLVxPqawgtOfnirDVBBxKjRhHbkCZ4E=;
 b=OrLBrzFnDPUsY1Lk3FZg0hF+mXnhXJvNzW+ASfLd9yNnDkoVJS7cxTU69QAPU+3tyOiaRFpY7z3/ZfRk26eIWAMbEdilLqJkRUM7E1LIqJZeX6p8g2k5Gel8C9NVwwESpNZKkC/n6vwsp9q8v8Ym45kaFBommEImr3TXVAHUQMBuZxglRDleFi7xZ1xazii7nky3LoaPiao4fPTaXq6LOwJWAj0TIkacsgLzGTdeSuSUOiOwUIzf89IyVwI7wkV+zXyM2FCquOE5yrIhs196H1m5yZxz8spnOyeTJ4fRs7CW/IQrOqo97YWdCh7dyt/o/tlbQn2k//+3YpYBrYyr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) by
 LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 03:26:50 +0000
Received: from DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::ba8d:4b24:3a8e:e5b7]) by DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::ba8d:4b24:3a8e:e5b7%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 03:26:50 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>
CC: "Coelho, Luciano" <luciano.coelho@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "Mistat, Tomasz" <tomasz.mistat@intel.com>,
	"Furquim, Ulisses" <ulisses.furquim@intel.com>, "Dutt, Sudeep"
	<sudeep.dutt@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Regression with 6.1-rc1
Thread-Topic: Regression with 6.1-rc1
Thread-Index: AdjiMGm81GznUod2TQ651cjO9ms2zgACIDOgABoBaQA=
Date: Tue, 18 Oct 2022 03:26:50 +0000
Message-ID: <DM4PR11MB614148B80837830E33CD9F4FB9289@DM4PR11MB6141.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129788F0FE9CF4BD02E3A1DB9299@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <DM5PR11MB1627D4E151F38CEC4496B6F7CD299@DM5PR11MB1627.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB1627D4E151F38CEC4496B6F7CD299@DM5PR11MB1627.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6141:EE_|LV2PR11MB6022:EE_
x-ms-office365-filtering-correlation-id: b3c29da7-35ac-4871-a000-08dab0b89878
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSZCJksWqCccQANGQgSrB46ubo2XeYAZCAiVkeam/lz1T2gKtvRHd+XZ3Mz6VwAHITPgxW7POzeOF1MFEVkz+VtZXJxhgCJpdjNgJOEZqeqN15SxSXxnMX0DY6gi2ELM/FSENkt1hfj2WtkuJsFAP+cDA4lCvuek/F1Fg5nCFy+OLUOkqnwXx44uMLDttafq/PpLBgjyxv/3l8yHgcoQt9rDAdFiQ0Q+KfLSkzegaIXLvMDLjgYA0A/PraJHLoli8j9aDJwUxPM0+JcYdlFIZ2ogGWc8v1/0H/XByW94rZViDf4v3R+dWPUa7St+DJHLbPmuu5ApmYTBGSEqW6z/yLv6h4/WuPv/+Y9HpUvyBqyDNuL+/A8nnKiRABeyB7QlewHlgGbISD3wAQVaIuCehJu4al68zyITCq2gHrzPVS2ukTX/KrY16wEds1+Zu0gOoACl2yKzWxhT7YcxEg62epYEelozGCcUFmyXISpuEG7Pd7t71CZ6yfu86EyUip8muglgi4G073Tw8Uh58WoUq6tBxvXk4arctnSksrn7Zn4viwm86ykn0u6HVKUh7AECB5Fv98eNyCWrheeKLVlnlsLa1q755G7lpMnFuxxIMUCTT9hWRmdnvJ1J8IQNxIGw5f/tuNyirqbBQAghHyfLgjWNBVLNOlDWmBsrZ2BYTYSjjCsw53v9ZJKOICG+Jpubmo8AgMm9b1DK5PVbz5MsG0p0aSO8UBfPWIDWhl6WVbKwc7oP0wKw4bHrDVqp+R1VoNq0+FV5oq1qF49fehqdTOWJf621VTL7QlqCUz7n0U7S3g38e3K9aoZtPggiXglt2qeE3XAjxehUMi9eenRhuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(41300700001)(54906003)(110136005)(316002)(8936002)(5660300002)(55016003)(64756008)(83380400001)(52536014)(186003)(9686003)(26005)(33656002)(86362001)(66556008)(7696005)(8676002)(66946007)(2906002)(76116006)(4326008)(55236004)(53546011)(66446008)(66476007)(6506007)(122000001)(82960400001)(38100700002)(478600001)(966005)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AhsZvNUdkVTKrTJi49nkqBFhiXG6oYmcqh7Q3ouxAg0sV3XT8YaBi5lZ1wIg?=
 =?us-ascii?Q?l6Cebu/s2Axkwptsrdpb2ty2nlBRiX0nl7ImmggIJxJcz46XUc7tCpuo97Yj?=
 =?us-ascii?Q?Rw7H29thaAgqjYU3fLTVhefhu+OE+xRcLcn6lydNG8hYBEzfc1vH6piZ2g0A?=
 =?us-ascii?Q?kjGLPPCbiDXz509tlZ1mahKMRiDIIgDfHX39uZuK0/ioMvXwWMFv/u8L0uFi?=
 =?us-ascii?Q?hgo+w9+Gsa3b6V+gKripHpAzeURYFllTaBlKy10iBBzuVy2IABAJc5UONUAm?=
 =?us-ascii?Q?weIVNGEjGMxb3gnhl0tTd2lKePPSmqAbajuKLNWrw2updGIIP4BROJyni8pe?=
 =?us-ascii?Q?11cwiU82U5U9ItB3upWHHLnAUwduZmBHHynzjUMtDHI/q8GUfnMxSky6/hcz?=
 =?us-ascii?Q?XXS0I/t7wAvvwfPXCCRqaLhUXI8Z853UVKdPlrrpsTgRcnyl7/kcNrAcrXen?=
 =?us-ascii?Q?kzNN+Rpwfqi0IBLjr55PYiaAN3NA+uNVzfasQd0thAUAOarUqx1s+7DGG+Kv?=
 =?us-ascii?Q?9O8QdbMiVDlR/IPg98ujkPYWAqp/Pmzleqk3Sp2aPoE8vqnwszaGbSII05AF?=
 =?us-ascii?Q?OmPp5scbhTYol2iTNncyNtlDe7VQ2jLHXa/lhF0++uW8REwvzU6wBshuN0MI?=
 =?us-ascii?Q?+x4QDdohp1DsrhziC3lzzjYDh4ZL5bRoKxdZYC1GEbVzGrcoGPBDYb0kQy6w?=
 =?us-ascii?Q?UOzYpA8f+mbhOVoH7j1eKMuQK+RCn2VUHthT07jPOeHuF2dfVMvvvcKp4EJl?=
 =?us-ascii?Q?JQ2dssBWaey5tVTsgO0glF8QAn4TIzh3VhAA0ni6tKaV+06SLrzX6SK39DGO?=
 =?us-ascii?Q?Ip/KMIKdFvgdWKnN/25py2dBc06q9+XSrzJDgD3M8OJhB/R9PkTnfd97TEOo?=
 =?us-ascii?Q?HbknvaBlVMkwIKSvwI10IiBihZFMuuvtHBnOjzjg/tQ9Jt/iRZM1TvzMeXu4?=
 =?us-ascii?Q?fpii70uvoD91f0839g5GtMGD73wxcOKYdMIDk6zdKLnG6JTyQQ1KBWvXCqNE?=
 =?us-ascii?Q?5qqCTuu3zlhokJwTZkXgpNOpq6D4T7IN5+foXpgNBi/DMX+Nv9Pp4PdoXwxZ?=
 =?us-ascii?Q?cibwqSIupxx29/bpUmduN1oTH5zZh3ofJ7hmjIUPVypw4VFzENT5r0t56w1n?=
 =?us-ascii?Q?C++pa6qaHAnH+Yzw7hdpV3rgjzvvsQpfjf5yjp3VcXQuzMauCNlStwtm43ZI?=
 =?us-ascii?Q?G//4/96yUg8Nb1nhco+4eZYcV+LJTU0uM1AkxzJCtk+2FP6vZQt+UwdUhnEK?=
 =?us-ascii?Q?bfbHzsAvwrivLRJq3PKI0L6tarv3GvB7mUxQ76LvVUEN0fvaMaie6YK6nAbY?=
 =?us-ascii?Q?8+eUZjG4HSnWf3JnUV4Nrk8M1oLzTUXtzq7xb9wB6ZS1VKas7gL4htXy6ojA?=
 =?us-ascii?Q?4uhw6uuSDzOv02vm68yVebCDi6qnIo93DhsVicAeG3ekXhiXpi37EL8McJmn?=
 =?us-ascii?Q?mQgvNAe7+p1YElJ30tHHK5kSPPDG5ktym2Upy3yx2Xa5/Srb1axu/8m7Feef?=
 =?us-ascii?Q?mnFmWwVDmbis9SBcb+ekjzVTU7qzp0JijFEbF9wltLkmSZmg152ZoYbr/dxO?=
 =?us-ascii?Q?GH89waVRNvVgm7POrcWjuQ4uwC69B4/AuA7crBKnBXeujb491V/62Dv/dtwF?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c29da7-35ac-4871-a000-08dab0b89878
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:26:50.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZkJPh7FKp5Y+qRBINs318Sf/9PR7gwoNR57mjWZnTKneOuvV1924daLCNvzhlXRdMMNR+WiW8c/4WPHDYu5ygNNzMF2njfmC4g4JvwMPpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com

++ML

 -----Original Message-----
 From: Kurmi, Suresh Kumar <suresh.kumar.kurmi@intel.com>
 Sent: Monday, October 17, 2022 8:30 PM
 To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>;
 joro@8bytes.org
 Cc: Coelho, Luciano <luciano.coelho@intel.com>; Saarinen, Jani
<jani.saarinen@intel.com>; Mistat, Tomasz <tomasz.mistat@intel.com>;
 Furquim, Ulisses <ulisses.furquim@intel.com>; Dutt, Sudeep
 <sudeep.dutt@intel.com>; Nikula, Jani <jani.nikula@intel.com>
 Subject: RE: Regression with 6.1-rc1
=20
 ++
=20
 -Suresh
=20
 -----Original Message-----
 From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
 Sent: Monday, October 17, 2022 8:28 PM
 To: joro@8bytes.org
 Cc: Coelho, Luciano <luciano.coelho@intel.com>; Kurmi, Suresh Kumar
 <suresh.kumar.kurmi@intel.com>; Saarinen, Jani <jani.saarinen@intel.com>
 Subject: Regression with 6.1-rc1
=20
 Hello Joerg,
=20
 Hope you are doing well. I am Chaitanya from the linux graphics team in
 Intel.
=20
 This mail is regarding a regression we are seeing with mainline 6.1.0-rc1 =
in
 our intel platforms.
=20
 [   12.435594] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [   12.435596] WARNING: possible recursive locking detected
 [   12.435598] 6.1.0-rc1 #1 Not tainted
 [   12.435600] --------------------------------------------
 [   12.435601] swapper/0/1 is trying to acquire lock:
 [   12.435603] ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_get_resv_regions+0x1c/0x260
 [   12.435612]
                but task is already holding lock:
 [   12.435614] ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_init+0xd98/0x1039
 [   12.435620]
                other info that might help us debug this:
 [   12.435622]  Possible unsafe locking scenario:
 [   12.435624]        CPU0
 [   12.435625]        ----
 [   12.435626]   lock(dmar_global_lock);
 [   12.435628]   lock(dmar_global_lock);
 [   12.435630]
                 *** DEADLOCK ***
 [   12.435632]  May be due to missing lock nesting notation
 [   12.435638] 2 locks held by swapper/0/1:
 [   12.435641]  #0: ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_init+0xd98/0x1039
 [   12.435646]  #1: ffff888102b7a6c0 (&group->mutex){+.+.}-{3:3}, at:
 bus_iommu_probe+0xb5/0x2c0
 [   12.435651]
                stack backtrace:
 [   12.435659] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1 #1
=20
=20
 The issue is seen across multiple intel platforms in our CI runs as well a=
fter
 6.1.0-rc1 was integrated into drm-tip
=20
 Details logs can be found here: https://intel-gfx-ci.01.org/tree/drm-tip/C=
I_DRM_12251/bat-dg2-11/boot0.txt
=20
 We can also see the issue in linux-next. (https://intel-gfx-ci.01.org/tree=
/linux-next/next-20221017/fi-adl-ddr5/boot0.txt)

Are you already aware of this issue? Any idea or hint on this?
=20
Regards
=20
Chaitanya
