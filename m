Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DD4F5FD
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913305; cv=fail; b=U3mYtqcTAD2yI613xwCzcxiTHW9dQsF9ERSjTbY+n2tLZecT+qOxg+D/UJa2EFfqWJ2sTtJQ8oSscb9rJ8r62UgP5eqCuK34rKP3GBu2e00K3MJRmcrDhH7SiE1JQHEQ/jXOG+IUC7wmtwzh8h9n5Cc38lkhv92m+ldu4i3Bw7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913305; c=relaxed/simple;
	bh=KFekTSSj18og+v6Jsn1LgDb9P8T7qFZ7AyuVbXoH31k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1abWzp7YfXboS7xsJgEKWdOHw9kkP+znzpACX7y6VlYiYV2LRsBJVoCDmkNevsXlgo/biboDQyUgMyrK4BRWodcWPxw153x7aQWaF2ccDKNQq4LQj+hEUeIxKbOk6j61Iv55kYqP6hcQ4mgYaPY/BmsA6M+s3HG9FXt6Mdk3Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFbaGa7V; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFbaGa7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712913303; x=1744449303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KFekTSSj18og+v6Jsn1LgDb9P8T7qFZ7AyuVbXoH31k=;
  b=gFbaGa7VusFNt39ddlbBCJfY4Srj6enBJt+9ZO72bAtI4kh8YeDUZnIl
   oPVM4pA88ZQtOwE01siHQmmzI2x9C9cjpbfdX368FIjS9aTAEypzNrRwh
   8jvHSQn04WvsWypaKfu/itafwGqe8aRuAsE8zaRRe5+kRepxojOfpnmFP
   PYyLh7BDryBe5hqa7xPIjXF9ddp88moMcU7raQ10werMJOD9jZScKI9MQ
   tESWGlyrPq7lhrVr/8aqajmlS07SeWymGD5in24D/j629OBUSrufgERvT
   qK8kf8i4mkFLIE9tMM5nmLFz7frfb/oVpg+fuiwd8Iw1qO1jQpgJI+wpw
   Q==;
X-CSE-ConnectionGUID: QHjJT0X5T2eI+KA7Ff8qOQ==
X-CSE-MsgGUID: iSKL4jkwQUmMkeDC4IVsoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12146360"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="12146360"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:15:03 -0700
X-CSE-ConnectionGUID: SW8mpZyQTiWETnu90k2zWw==
X-CSE-MsgGUID: lIII07ojQdSS4+l1BXuF9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21164992"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 02:14:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:14:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 02:14:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 02:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je0ACLntbfyhDtI6+0RydkAfACLxpVyT/WZaoOaGAuYzWHiZUzihdsK2t364uTLWZvyiZ4oeobUg2QpRI7aywl9sgm1bz/M6oyVRpG9DIFR9Hdh6Utj+idukIgC5N2w7Tlg0T6IeTUKwDS45Fzy3S5eC0BoalRJzC1Hgwm9n+8sJBrmTx1bYfRpIGQKQff+QqvG6Kbly7ljNw0bEIyT8Fg1p8gLKkUAy498RpujrZ4ULhe0wcfk3b1jKcM6RAA8VqPxb2GYrD1Voy5Sq4Gu84PN6SPFJasKuEnn/ImU+BLcOKhjiInV+J0AemwJolD+SAnuXeOyVLya3sW9NpiGA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNLZlMU0wZXgVMKlEPhX1hqltEYlgX4eHwPgFN0NMzk=;
 b=jXmlQovJRndCv33P5nVpz9TXQl9YuLWuB5dJ1xSdoWagd6XT3B8Mga3cER5oCZxMyTOuOqPLzpWOPXzH15AmeX1ovsDnfDgHPhlcbmto5vOE/lel9TnB2GBDllc7C9tBAM88YnB3EuxntZgkctf/nBDYTvLQD4n1gYX56yt+WCwcnAu+19R7X6VEgx3uXyqAyhqHEm38bWvAq93GkzYbLkC43+d6e9Uq1vP6K4y2GHcm8Ww5sda8hjCku4c4Wda2lIcwY5k/gL5d9/xLnnPB83j/mbjdO0ZYFDNQaIh1oibIy3oXPMZzynquYEPAqDdTtKPxStskqugCMlOmXZRNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 09:14:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 09:14:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
	<linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
	<mingo@redhat.com>
CC: "Luse, Paul E" <paul.e.luse@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, "Raj, Ashok"
	<ashok.raj@intel.com>, "maz@kernel.org" <maz@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, Robin Murphy <robin.murphy@arm.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, Bjorn Helgaas <helgaas@kernel.org>, "Zeng, Guang"
	<guang.zeng@intel.com>, "robert.hoo.linux@gmail.com"
	<robert.hoo.linux@gmail.com>
Subject: RE: [PATCH v2 05/13] x86/irq: Reserve a per CPU IDT vector for posted
 MSIs
Thread-Topic: [PATCH v2 05/13] x86/irq: Reserve a per CPU IDT vector for
 posted MSIs
Thread-Index: AQHah6hds9I+TESl7kiFR5xiGDPLp7FkZAcA
Date: Fri, 12 Apr 2024 09:14:53 +0000
Message-ID: <BN9PR11MB527609928EA2290709CDB3E78C042@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
 <20240405223110.1609888-6-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240405223110.1609888-6-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7831:EE_
x-ms-office365-filtering-correlation-id: 7d60a2f5-d7fc-48ed-026f-08dc5ad1038c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlutyGQN4rChAnL7kO1Dr425voT18eTOmesUY3NosI8m14zZOK4GbQc9dY/mjvJo/5/BcJlX8M8qlr6zmG1KRTLGAXVqDViixHccfXAwXNXosqei/vROnU5ebG7edqNVtwe/ENrzrL2yAoCL8uUKuJicsPnxXIt7E+qLq7w4OoKRxTB83FtPcCPHJZUI76S2dKMwlah0ORDVJEvwdTYI0Q9ON7u46qMc/v606qypqnkXIdgd88c/QtQrFl2yUhgs87cSBI1CKY/NoDDMak2woPiBhdVDWOzI6TCTgVDvHZMkCnge3BIlAkOlqU/Yq+y7oxJkm3d9qxCWWZCaJDGgLK/Rvj1lS5BIERM4V10c66yup0pESWmWVsgotDh01FSeNpbMGMGEnk/3EruhYIfhWN7deau+myprlWD3vEAWrF21ldflIMS92KAKhHrta3m/66m/BY6k/74RwKbNwVxMrVskjQse7hr1747+0FGcR/HFIrVO2eQxRiiI0WmzfVtzNv451rRcfXOwK1CLeUc72VjWNAMnoi8Gh/nP3YDMmTgBfFyNCq4uI5xVtEAkAe2nQ90dwnBOfvUh4e3aTim3d4GvUlyKBJapDbCIipInRXjFt24A9wYE7CHohg6bw/cJ7JjxNRCdZSsGA2h5ltaavtGh1bthVMELjXwoQvPZr+IZzqTWjAC4mJhFf2yWt1cAMkJ+Je5zM6gz4qsO9iEh3gfvId8sMbQYOUKbExiOcNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dFilLhE74sU/8/fvxoccuWYBFx4mYBAbEI+BloWC/vsHbr7YxQ5KXzenZ3FO?=
 =?us-ascii?Q?5OUbyQhXlXcnKeWcgvs+i2DE6MFRgr6kSgK0dyK7Np4udsUIL9feN07WI2Di?=
 =?us-ascii?Q?kwHn4Ae5qNnq79blrvrKk8yR/3qIzO9F2ZRmRg09lIUEm2mLAaFcoOVK9N7i?=
 =?us-ascii?Q?L5K8vx559hgTfhKpL8PUrxU3Yyg1ww6kT/VlkYpMmiH0D5m5sykARnrYorH5?=
 =?us-ascii?Q?wDV5YGMgp/jhXxljNc/IE+6lEqC1NJtkaYVwRPGi1tIMiSm964UiVqQE8+mH?=
 =?us-ascii?Q?v2HsEiJGJPTGDbhp/b0Q4h8PtEWBQq4pyAS4y22iYtRrSBNb0QVo2WvLAHHd?=
 =?us-ascii?Q?OzT/6io16VH4z+Q6e/rJps4QIMgVlwriTMfH1B01Zb9n2ujpximP8MK1v5nn?=
 =?us-ascii?Q?4cyyGnUGkFiaLz8CDWVaoqjCLd0JZlUYfQtiozuvAcc3ZoHaxZXiDqtQbkFW?=
 =?us-ascii?Q?CJ8RaY3LebEwQ/dFePEB6s2E5Ke/zqXGUE19Oofb7H3Hhqo5zfCHAJW5Zj+k?=
 =?us-ascii?Q?2Iq0uE4VCfi4fqxMiHL4AzhiKLw4HQcdGLeobu1F6L1HqTKfx+N/Vv7yg58W?=
 =?us-ascii?Q?SsJxcxKb42e73JT3b62tes1KblzUG1zJbUDkcyyJejrsTQ+suwckhsiJDw8w?=
 =?us-ascii?Q?ELZp0w4ulnRd0OeE3plFZE8HbtD066XZDChod6liosybhGeFd2mZfOZHpJds?=
 =?us-ascii?Q?NvbQ8mx3knRpfRHcB+Fk7YVuoRpOow6icNuviONMUrPMFk3PydiWDzxeAQzA?=
 =?us-ascii?Q?sFehrGvtI4u8H5c9UTUymn8w2zSt0sVszysi3cmHNLhmBpuHvCkkqSzE7m+t?=
 =?us-ascii?Q?SpLLEH0rOrqx8wAQortUAkUs2s2SE3ieE4k9Aq77+OJIUxOlV8yOLOpevn6N?=
 =?us-ascii?Q?ncdfLgEjuQNLJZlqPLyhWWsKOIsOhC9jLh+/JxYokreGrgsJlJOjO2PibBon?=
 =?us-ascii?Q?073VTN8mMWezbSLT+Sg0yYDxM0fxBSBnxhBqLm2xG3+dLjyVV9GHH0uEKHFf?=
 =?us-ascii?Q?N+MxvVNb8jYydYuvnOs4Q1TGIyt1GpS6wpRqkO+UzYBawtgAiwiI7BK8MhwR?=
 =?us-ascii?Q?rkDvzyQbn7a5gD1V6iX3O9HgrbrLd5xXPWER6ZSp18pJtLDUSVrbMH3+GUXC?=
 =?us-ascii?Q?OiU9PSscAtRuOTQy2GzETt0HagGVebm6QNEv0TSy5UmY49rXrzB2/5uiUp2a?=
 =?us-ascii?Q?Q0I6/+twGGGlUBqJSDeHSeZK3TO1uq/d7674kJs3YOyu7LfUURYagRHsGuMz?=
 =?us-ascii?Q?SFIwS6O9TFagma7azwxZq23a+X7jTNtphVnb7MizKpHfmlwmTfbtjtZ8YXVF?=
 =?us-ascii?Q?A+lJ7c51KIHfPfm4NkNNcbQZHMk8MXjN8+uOwI5RlGuPVTzI8ywuYZH8+53L?=
 =?us-ascii?Q?WOSc85zqqAQlLhQJhKcH10QD6bpJNN9KjrBlntiktxVaDY1EB9vvGNK/trgK?=
 =?us-ascii?Q?NjwpVoxx47iTNfXJqX+m882NvaC5VNGeRVmshBwpNRqsQQBvlDhFJoOESp1C?=
 =?us-ascii?Q?3K8XBW5yMfWxXs97iUUA3s2KgWi6a6Vq7OEedxjuy10qAo9fv4S92OZdDPaj?=
 =?us-ascii?Q?ch7MosGG0uuO2ArID8m/iC6QZ53xMO/6ZlsGObly?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d60a2f5-d7fc-48ed-026f-08dc5ad1038c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:14:53.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9fpayx1hYr+3FsqwkPmhGjP/4i1c7q3S6/pzfFoWma22AastmvsFKwiIkADbjuLNA91deRUqvEZ1mxg0AXZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, April 6, 2024 6:31 AM
>=20
> +/*
> + * Posted interrupt notification vector for all device MSIs delivered to
> + * the host kernel.
> + */
> +#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
>  #define NR_VECTORS			 256
>=20

Every interrupt is kind of a notification.

Just call it POSTED_MSI_VECTOR
