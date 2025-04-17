Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28C19DF60
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856604; cv=fail; b=mWG3EtW1nqlYT8ct+KXFrnl0vpq79ZrHUCab95kwRDd4IZpQeYTDG/Utg1Iq4ZhqGmcyCHTj2KXRirSeb51dyo6FiF1QEwOU7uoGu6Yk2Svhk7WkjSp9i/T46ewD6+7VgdccS7Z9cyoKwVQU0ekbLsJBGGpUInMpUpE7+TZHwu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856604; c=relaxed/simple;
	bh=lN1ggT3f/d8BEPAnC9cwISU3cjhxaWfBbc0mxygqcYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJQpryaBrrW3sNG5vedBfxwQYSyW8qf5QmfoKYhJXtgyZfIUXhmRgAlF/ho7e/g3d9EBLE7eKYXWyEVEkJR+XnflEX7L0ElZdXKS8H9kIZIZv7JdhZ2eYOmho7uNZ1OAoYs2/fOmTtHgM4FbahrzrJY5M+fEX9l/kZ0hmvcOlFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWikeDPG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWikeDPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744856603; x=1776392603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lN1ggT3f/d8BEPAnC9cwISU3cjhxaWfBbc0mxygqcYk=;
  b=aWikeDPGKVcere2D2AB7HvAwFRJWTsradc6MJ4CMxnzPP4qegJgREGzr
   PJ8gvTWL9OC5v8spZ52qNkEwHtiz8Bifx26L6yA9MYL99Zw44+qfYwY/A
   qzssP4k3M6DrhYBPVQAxlywsEqksSHKu6NzGws43mo88eB5DRJ/6WtQe4
   boFBbPxrC6iZMd/2UFpTzorkgs3KtCrLJzzoSvK1BJUW+S/nWmlR/1dtg
   ksDxOSjFS2VHJFD09MzJ7jBaysaX0iU/bb8C1yXjHiiKY5LpRIQc7R/Go
   v1FuneKsMJ5ZCq+rvQzujW1FOvd2Uoe6VncIqRGsd+rh7LcSDRLVuf5ob
   g==;
X-CSE-ConnectionGUID: 8AzR3olDSGyMWLu3z2kaBw==
X-CSE-MsgGUID: Gqh2H+z4RN2asgVpO7CJGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="56609913"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="56609913"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:23:23 -0700
X-CSE-ConnectionGUID: t96d0scHTy29BydKLJDwgw==
X-CSE-MsgGUID: hW/Z8R1HSLSDnQmCKliH6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="134756649"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:23:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 19:23:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 19:23:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 19:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds5CTMUW57f+HmkknqLn302Ky52omURzKSL8yQrdC2c9qW2mHKrMN+WtDKWS+/yTAjFd/8CGVRed4Cp6lXW1RX42LoUotWzTTy8xTwLq3WGv4KNNXR2jgxKQucJHRwH6fubggmN9zk92nr6u8WtIYp7W7RuA0M29u/bNGkLJgzOBomMuTpmQ48OkWxHGP9WUIEffluy0b1pq+M5so0Iyq1HRvjdhphsjLZfeGEawXL6pClBSBWCQ/DZJ7BxkRqgluV02MqaOjRSIlDqMoTY1+1N58/HXVobdd5aMftuKEuLlFU+LCLzmh30bxPbs51jd0sCYHvHCSKl1Zw/M3pd38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pU3VgdRckoU47P3GYlwhO2cSkl6M9A/ewimK3t5Aqw=;
 b=RwZeCzrTgcDwrc36dKNMGXNbH7UNG9WSym5S/Llf6Mp57EXNY/iQ6zlcLkRqXPmSqS8t1RU2cyenb4aHrwkichIQmo9hzgRt/Zy0UlLVVicoMKiQGYUhI16GYWdqccnzD9xXc557nRoF+hRcUlQcSv3a7nZNdcc4plyNWp8Kp8XjVURWAiNLpn7JnUDVXEQosDT2Wo9wCNkhXm8dDsWCXckN+2pPTQrKchfWSIpADB7B/8/p+56/zt9BeNyMHPZb6+cmmwW4P6gZzoXelg6cQZmwt+dUYpmkCeqQNaHd2/vy42+wv52DL+nlSKpgw6GtyjnB57zLMAlALIpY5L8dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 02:23:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 02:23:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
Thread-Topic: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
Thread-Index: AQHbrqIqNscoM1vBpEO04jBH0/T8ZLOnIV8w
Date: Thu, 17 Apr 2025 02:23:00 +0000
Message-ID: <BN9PR11MB5276F6889D36DD7238E3BBB28CBC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6559:EE_
x-ms-office365-filtering-correlation-id: 4c2ea915-6cd3-47e4-2c4d-08dd7d56c631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1dEDdAQpkxi2031+d9M3z8sg/NSQXq1aQ/vDOyvcEk00+Q4ge53HMMrCSc2j?=
 =?us-ascii?Q?3zbjnViwaV2Bo7iW+EnswGvl19AmRVaQk6BFhW4L148MxVRCf+EWr3LX2fM6?=
 =?us-ascii?Q?uDIKTSKtX+GUcxPP9Aue2BVLydrUCDCcYOcmrtmdGHQyTvHIcVWAxyJW7K3e?=
 =?us-ascii?Q?Xo5T9o4OAW+IKm3jPcJ7W//qDn439yXtevWbtR0J0LOPPTKTmp+jYEf6vsd8?=
 =?us-ascii?Q?TaFyPVsY2uxay6V2lCBHsUx2SBCInrntrQN5uHs+7TAb9+94/lNIksF91kY/?=
 =?us-ascii?Q?oNSj+Bjt6upRdyiMqb2jrHt7IB5sw3x79eVdXY6Fdgoe4lwRTrJ6uUSYOSP1?=
 =?us-ascii?Q?53WutFLv4drucAh+HkzSTlPAR+5o987mFQCBcOe5hrMNx+DKu6sJyujEvEtp?=
 =?us-ascii?Q?4SmmOx19ttqaOoNkCyqDaJ9+zWp2yAPdWyJCi1F2gnUNb3aMUSAumqnR80KO?=
 =?us-ascii?Q?Liymp3T7idwyStOFVd34fSEwbvTfcnNvMq3YyIOUB7PjRaWv9Ed+92SWL91O?=
 =?us-ascii?Q?jzxE1BzRUZ/7i8SHGV9Vdid2uoNpvMvccjH264Pw5ExINAXempyheRLiGG8G?=
 =?us-ascii?Q?teuiAl5JDGmotQaCFKnu4+KT1oqMBPS1E/YGG3cLb+xP9B5Zoh8JjUuw+PDp?=
 =?us-ascii?Q?jpSYuoXZCA9LS141TkzFqzn1j0S6LrneVYXWf7v3iybuvwjyLLMTwJ57Z/tD?=
 =?us-ascii?Q?iS/Ial/prD1jYOzofLHSnspx4O/wO4dG3H98KosiqrNt76XqaVzirVRTCg8x?=
 =?us-ascii?Q?u/Da1bU7nLLtlLZqDbqbWt91VRgN3+8Vak4bL2esy+gsujA8vFe3DBzgOTte?=
 =?us-ascii?Q?gJChm6rMb2QAGFS93FacVAov1ZbUuRZjJcBSviY41b7roRfPifGuVtYrpEDD?=
 =?us-ascii?Q?oaLYJ3j3GCxVCoAPFGj0aciGgu9I8QbLtwb3w/59ssZuhHH5iytm4E5iBhqG?=
 =?us-ascii?Q?PnUaXjgY10HL/85KYjweV4/m81JxnPE8X3/RJMNi8/n8EyXnoewdJUK+LUCE?=
 =?us-ascii?Q?1+VpG0ScyBC1pktKfMNdXmO9I2Fz/MDDNfbjbqmC2gngYhRN3H0G3YB/Kxw/?=
 =?us-ascii?Q?0/4/Gj8xnqOYGlcDmklhp7+iaYlXzH5uGGk+gI8eCPYd81lt4tARAocaEeJz?=
 =?us-ascii?Q?Q0rN2teXyvLIJC2ZFN8zTemfI7c7Kea36/9ZtAfZVjydZsUDF2gyjCDffffT?=
 =?us-ascii?Q?TTrjx0GTDqJYv3kf1sw7s+mE5DbHk++VCGxb8PbQthYI8JlwbqF5QjrCsecT?=
 =?us-ascii?Q?FYA9+SB9a8+grLZz7V5/QbLVvbgLue5RLeGK0rxHQQVXmPgcSdCvrxjc+RDu?=
 =?us-ascii?Q?UTmF+E/9dW/R7HG9Q+pEUIOmRpmfUvAiLYesy4MSQyM+zfas6uelIOokqgFu?=
 =?us-ascii?Q?UuULvDssJ7gdPNhjvJ6UY3Xrf1vEr3p/gQKcuOb3ouCiuzUepOWRJ7DeE1wN?=
 =?us-ascii?Q?siIG2ys8AlJKi1XMmFdcYp2WzOn6rXANjcMVDPnhjoavmQ4cr3AjBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eDTaBr7jfoNmCnakDqcqsNsfAc6FJcm9fiGIWTzfF2Ph6cQ2FWJFLcX1bLrP?=
 =?us-ascii?Q?VJ8TVt04Mc0ce1xlS0+l2VnkmXXVvQyEaJUa0rLyWzQSsnQH/t5f+YnV6cGo?=
 =?us-ascii?Q?gddhKRK8oaNhUEdBMiO6icw+W1LOIgE4tp4w/wbdp28Bg66IIFO9NZQOPog/?=
 =?us-ascii?Q?KHWzhVkRtlO/eMo56hk6hj4gjDRhY/NLvfieOEf8OK6hQTEmDBHoZqTo4L8q?=
 =?us-ascii?Q?RBjw7wpClBaK+p+IZzFVgIyF356VqO88ovqtjTeQHLyuZEZAqe+VjUACo1C/?=
 =?us-ascii?Q?zq/u0ZXEJmuBcrAUzwNcSpyc9z+qjnPIqXs14QRGzaZQ5JDvKe44iD9a/6XX?=
 =?us-ascii?Q?RU/ZSAxlmaWOsKY2D4jsHYKDFkTolmtpXZccV13D1bJ0gTDVigNAa7W4wOco?=
 =?us-ascii?Q?FVhCZhQYDtfVYjKHhPTwaXuNBCvgdO19KdLJce2Ic8fh2WvMSc5ehQgrhwJX?=
 =?us-ascii?Q?QU70U8c6te3TR8+NemII4PieVAQsfNxs1EK6izpfmpcZVPCZoQxY3GxXEY3V?=
 =?us-ascii?Q?p0JcCnExk1ZMKw9poHhXO5wMFJej7GAdD0quzatv15x/0dYHUo+T2rD2UQQA?=
 =?us-ascii?Q?SeXh6t0Z5P3Lih2ihTtwqM4gwJfPQjoiIs+JiqGgwuE5ZEcnKIOUJnPsIbH7?=
 =?us-ascii?Q?PoRaGulZgD0HCUJHwrdybbkxdSBY0u1+O1UxBEFiFgc39rRQ+8hWkspi36xt?=
 =?us-ascii?Q?ERvDURqGSKNQadaAWw9HDY7ROCakSn+MzRe6YTGszxYOJBYsFKhcCk5DacMn?=
 =?us-ascii?Q?0HqgspsRQvYM4OAdYxM96BGskUSSEllZCWAfvbKv+VFaJZVZS6WvleB4maiR?=
 =?us-ascii?Q?EdQHL23dtPLPo8LohWEIxHdizsRJiYSkNH5CkyapsLRSGsGB3Cmn6A08uDhE?=
 =?us-ascii?Q?BHxNq91SCCjWnLQ7GEe6O3H/C2yu3nhVLIzgYhUWICJYXdWyb13ErbjwfLx4?=
 =?us-ascii?Q?IuOQoMc3LbS/qQlTZKEM4JSKex0q+1bVuXA9IMySVRnQHHM0EJ1f1XAakX8d?=
 =?us-ascii?Q?2vrf27/xReL4uC1W0+evWu0Yko4ujuo0n9Z8d0kkamcpLZjycmYXf7Wfbu2N?=
 =?us-ascii?Q?1KusWkJWkG2lWXxWsh5mDXQwoF3rwlnhsEm/+JFiIKyp6F1Vo54QS/Yrq7EB?=
 =?us-ascii?Q?Tovp3/Ztt9CH+wwLeJvwH/C4o7BUUU/jgPpHkrmKAlIuHKMxTUzsniLMcyAh?=
 =?us-ascii?Q?TKcnH8TU/BYJD3J82DuyTkxalo2xE2joW9Kv6jlVqrhUQt0MG30B6PdYT7zq?=
 =?us-ascii?Q?E02ZmOZ2y+zRmOwyVOp9Ib3+roi5br8hmFmHeCBFYTldhidRiLjAJbWz+KUg?=
 =?us-ascii?Q?jQ53flhZoiLmoZpHbeaxuvBQwiI6WWF6IUjuwaG8OoURMC7A/wY4g8eGXj/M?=
 =?us-ascii?Q?wG8xo7man1GveGSDaEWQ+9NhDn3WS3yAtMIgXZK/Udy07babQ623U1Gk+KE1?=
 =?us-ascii?Q?VENn5DZh9RPY0oT1XM3lcsJeFgEGDPAu7CjckzKW7iX5NMuchkA4ehPBUIEX?=
 =?us-ascii?Q?IVXEau68Z3FbhnZeWwx+x7uKbCyZDk6jsiHLGLjiJW7ZCt78vN5ryjAqKAaE?=
 =?us-ascii?Q?GkuCbe3zUdn3FGfJDEFyXC9c4j81JrvVZl7gibDD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2ea915-6cd3-47e4-2c4d-08dd7d56c631
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 02:23:00.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7raoOBitdSebQkJwpQeLwdRWyoP8akdxawVNHTlZGayYwarVCMEih80x2am/KyaaYcjJSsn7kHQvVUiCvbIREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 16, 2025 3:36 PM
>=20
> Commit <5518f239aff1> ("iommu/vt-d: Move scalable mode ATS enablement
> to
> probe path") changed the PCI ATS enablement logic to run earlier,
> specifically before the default domain attachment.
>=20
> On some client platforms, this change resulted in boot failures, causing
> the kernel to panic with the following message and call trace:
>=20
>  Kernel panic - not syncing: DMAR hardware is malfunctioning
>  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #175
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6f/0xb0
>   dump_stack+0x10/0x16
>   panic+0x10a/0x2b7
>   iommu_enable_translation.cold+0xc/0xc
>   intel_iommu_init+0xe39/0xec0
>   ? trace_hardirqs_on+0x1e/0xd0
>   ? __pfx_pci_iommu_init+0x10/0x10
>   pci_iommu_init+0xd/0x40
>   do_one_initcall+0x5b/0x390
>   kernel_init_freeable+0x26d/0x2b0
>   ? __pfx_kernel_init+0x10/0x10
>   kernel_init+0x15/0x120
>   ret_from_fork+0x35/0x60
>   ? __pfx_kernel_init+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>  RIP: 1f0f:0x0
>  Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>  RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX:
>       1f0f2e6600000000
>  RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX:
>       2e66000000000084
>  RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI:
>       00841f0f2e660000
>  RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09:
>       000000841f0f2e66
>  R10: 0000000000841f0f R11: 2e66000000000084 R12:
>       000000841f0f2e66
>  R13: 0000000000841f0f R14: 2e66000000000084 R15:
>       1f0f2e6600000000
>   </TASK>
>  ---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]--=
-
>=20
> Fix this by reverting the timing change for ATS enablement introduced by
> the offending commit and restoring the previous behavior.
>=20

it's unclear how this timing is related to the dumped stack. Is there
more detail how they are related?
