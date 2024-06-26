Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B71CFBD
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367705; cv=fail; b=MSfWZuNZaz/7QO2HWbnDUcyjfZ1suTdouiSn807ubUYKvDFiQI91XwHN75bzzXxB/ZjLjOJzEsNkNrOFXnZBuhbcY0Vyadr4QbDXGUNTFhJUQW1C9FWI3bm4yFpW0G8s/72E/Ue0PCSWYQBwRfHq9zw9ANDoHAaBS1APUKyfgZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367705; c=relaxed/simple;
	bh=Ak9s/37R7JuI/8NFyyfdgWv8Dp0Vq6gvHPHoD3VrHWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9hEORl9gXbmetmCzC9Fc6jZ6P/TUflo7gzOGNjKxqQjypQy1e8uyqMHPq722AhQ3MIEI2K+Bpbhr/nZcMfpbIF3zwm+CTIaRYgStUsBAj81VT9Lxr6KqL92i6Kl7YKyzfj8BDm7BNykv01KyrME/fQoo+l7Sku1Yg19hEN8iVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGt6Zu94; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGt6Zu94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719367703; x=1750903703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ak9s/37R7JuI/8NFyyfdgWv8Dp0Vq6gvHPHoD3VrHWA=;
  b=eGt6Zu94wngzaUT5VaQnyhXBHUD8oUW/5+MZQDlegTgPhw7bSSkgOG8A
   6lc0tRMaBlF8EExwj9LkOuPQllXfogH3wQHCjFjHpmZFkOhxK59AVY6+K
   0QCmmump9K+WqQbZ8XttIwG/W8zfJk3AqE+fUojmnlbGLx+CvqEvDq0I3
   B4DG9J1fLLRldhnhVWdGGV2R78hn8RV/Oh0VQDBfna79mPTOHSuWXm7UJ
   z8SVrBncLtSK+e8ehkUogmW9lHz500pdOIaIlbtDIxTb+dNp2s2AYelgP
   rSYt5HNcpH6Px3XDihetBh9Svw4X+voyBZGYnkwjjb8hWLWnbvo4L54DO
   A==;
X-CSE-ConnectionGUID: hmDnu0uQTqazO6D4Qva9Yg==
X-CSE-MsgGUID: 4L3s7xHNRxaKSMspJkQ5MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27560165"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27560165"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:08:22 -0700
X-CSE-ConnectionGUID: 5RJUX1/aS2uw3SMUlVlWuQ==
X-CSE-MsgGUID: HlJJPsjMSZGITc33Yk0VOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="67056849"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:08:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:08:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:08:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC5ZrzUEKQPeXA1sHozLcgjIMC+U2G1SNgKPDaMdAvvw0aGKthDmkBx1oWXCJloVvdYjcsvIhvrwsUXosdLC3jV6okjuCxaT0LQQTxv2XjroISYI/XcAbaCCt3HMlO+pI30aBbNIEz5RufbtJ30BGGdZTFkOayQ/Kbe39der9/caHVM+88BHfKFaxfewaVcBa4aNKrG9EV+qrKh9jNbdCTkdf7IRnLOXu3P0rROxcEQttQaWgyHD8oLtwgB2djjbzEl4QtiRSfZKz+HzMGPbylpNY3Cu2Xbqd4xPx8roW2v0BV48Rt3nHo5KdQTWRpkSugdlWxt9rzWm/+hPo8bAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xoOwwzhfA13ZdPIbHfuKO8sl8ai2UFIaJCt7QwdZHg=;
 b=LCHMx/qzADuj9ZrkCjRs3o5Wf2oZmzVGSwd8e4OpZ9Q+9bExTurnJ07X81Ms82siJ0T5/cBOknWudfgjDsnQlNdF0aI1awnfM46FmCc21gwP+Iryu1x1OF1MBaHpb22t7h0DsfNAjgYciBxcoQ/VaORyeimajF0uG7aaLeSKrCwQ7y/dA5KuWN6wveY9S1wER7qEzl0hyMvT7XJER6q1rHPnlNcQa0Af0mJL/Nh8kiBcZJbDk5cMQ/jQEG9UDqDWfIKTMNp+HH7uyfKl+WLL1C1GU5cesgTt08GgjeuGwpal5iwDDtEDxjf2nUZ/0f3tIc5b/owZ76qLqN0yNmrWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 02:08:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:08:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: RE: [PATCH 1/1] iommu/vt-d: Downgrade warning for pre-enabled IR
Thread-Topic: [PATCH 1/1] iommu/vt-d: Downgrade warning for pre-enabled IR
Thread-Index: AQHaxroE0xH9EIoGqk2Nu/Wnli7Y2bHZTdnQ
Date: Wed, 26 Jun 2024 02:08:16 +0000
Message-ID: <BN9PR11MB52768E133AF3BED360B823338CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240625043912.258036-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240625043912.258036-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: 43f45f1d-3223-411b-223e-08dc9584d7e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|376012|1800799022|366014|38070700016;
x-microsoft-antispam-message-info: =?us-ascii?Q?iGsvVnIQVWwevCrgBxGWiRy7FpkbsJwkH81nxHzuw3KqcmCjP/1inspaGSzs?=
 =?us-ascii?Q?estVLAzpn56lmBpkdJP4W4YkVlciKxGmj176y9D32AOjerEGf1pejicNDDsg?=
 =?us-ascii?Q?h/S8my6RgODY7R6i+Wa03qmOwvMPV/C1+tUPJOK6zwE5W290wsXNdrCZHCav?=
 =?us-ascii?Q?ntrCspy8CPuKQrbu13ivkzmkTuL080z7UizScV7d8MyN3KTrQrUSPYnNkk3g?=
 =?us-ascii?Q?RaOv52TS3dPPBroTrMAVY816KYcjUGbomkb3GvP5LhV89WyK2PuznjTRSy9/?=
 =?us-ascii?Q?50PMAVTqSvHDj3ApuYNI9tJNDXV5GPLr1tI8gQnON+gKbePMkIcusQVzzrkY?=
 =?us-ascii?Q?iKX8kgeGjHiF+wKnD3MHXo2T8RkfYelOvpahP6cJNT93h5hsidU7l6J9yESk?=
 =?us-ascii?Q?FOHK5GH984ZhFFR9vfF9kWcPTtd4+2hM9vAPfuueeuyw+cggQV6DwzZFAzto?=
 =?us-ascii?Q?I72ZJIafygvaTHWKKXuqEumq28qYUQZ2bDNvUHDa2cFd0PBBdVuZ5EkZiKe7?=
 =?us-ascii?Q?oi84X4GRg7GP6huR39guZD9roC8tNz9iewN4Asa4qTCFog4px0ZR0MB7Dx9t?=
 =?us-ascii?Q?HLrsSlWxykiOHBc3fd+Ocj89ZiI+JjZ5EKP/e+r+7pZ34UNMaE5n2rIZyfzj?=
 =?us-ascii?Q?8q2bKifpfW4JEZLV7t87beRNnuMdEOEeasun02+3YIxZaD38JYet31qyBVNY?=
 =?us-ascii?Q?PDEijhB5EVo8y3DylpEiJ+uM6De2RqH3ORR8+nTfd0iicwto8MzhySrwE53W?=
 =?us-ascii?Q?RmQjZJEkQDSls4wFZzlNKxyBFV7kueNZoHtRYGFlmuGEGFpWXZpiiu6SChOa?=
 =?us-ascii?Q?R06T9dVrz4CMsHm2x5PKM3WxHjSPsZOg0LNqTrDk5c7MwbOviCjhc7nK5ABg?=
 =?us-ascii?Q?7t+/kwjW9DfVZe8NIyspQ5EonKNcWtaoDKHFT70LVB0HMj2z+NnK3pONYYIX?=
 =?us-ascii?Q?r10m5ciiCP/MOM/SG6vxy/ZDKjlNepcPV0/dFZ0jFIhu8boxghEakyTkF12f?=
 =?us-ascii?Q?lE3iWmFL55xGTYwQkmmzWDUtpKoZMdD1npWHC111nLo4wM4Ev1Nf0hyRe/LK?=
 =?us-ascii?Q?lXG20Il6LQPp0Kthp7rv6Qp23rPcKXs4ZseWCJqRT58JFo+ESqkj6mMQpuS7?=
 =?us-ascii?Q?r+9wzGdERFLEuTxY6oW7IDmPhYTgaa2foE6vKXJD3zb4HLselkuc59sRBA+a?=
 =?us-ascii?Q?Uk6iscwLP+4GQGUJfl5VHqPsGkBt2vQpS8qOe8ImyGRkm3IgWLhOYOn9Lvtm?=
 =?us-ascii?Q?Bp7gHaXsmB71D2CZvLatxI2b2R63Je67rtdsQ+UnTD5CJXCQ1VXs5WkoGGc2?=
 =?us-ascii?Q?M+lVqMfo0eIIHxHYHsvzxOlO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MZsik8s99AFJmNmK/V2EQPRy8A6kNpIiTcMc6zei8nNZUBcA5BrP0YRUE7Bx?=
 =?us-ascii?Q?EzOGwlLx7ITAF+u30Yn0pzpkwhmLN58pEApurT0l6Hm22+DLxPMqJyq1GuQL?=
 =?us-ascii?Q?4mCk7zkr/nr+kxO854fIOxUCfmFfZIK+pdZYHPhFQmncOplIrA+ux1umOPH2?=
 =?us-ascii?Q?CvHZfP35EXmzU6EezHPyBBnlJ/+rrK5lxtZQOuBPDMDJXnYn0qDkAwJbmD/U?=
 =?us-ascii?Q?Njmv/DOBKuxjimfbAzq6fF4gZsRMZ2GvhWNKgOoAiEehLQCRMqm/9NENWJVO?=
 =?us-ascii?Q?jfUUYQj+vR680HgxTV0fbib9qo0zs6y4r3nHZemNsX+AmdmxpZiAYIuI2W+V?=
 =?us-ascii?Q?Jjv64Y1tPQYOmbMlihPZy9dIfCNj7rLIT11iVgSnM+jgStCghzcMmXaJGqQb?=
 =?us-ascii?Q?Ac2hq1rXrD70KjDbqpq7c6GEYKivXKFBIGcT39gWDIlmusfaS0DgCLJ4kcSK?=
 =?us-ascii?Q?e4F841o/IkX+jgKKTGLYD+KoutZtv7KAIemNtz3sRogsF/RY6LxEWEnx3aC0?=
 =?us-ascii?Q?iiBJLsMNQkbdOVVWHPke6zru8Yu3ecG28VQGBM13xb7DOxtsoHg2/Paxs/qL?=
 =?us-ascii?Q?dugNKEogSsqTE1pxFtvVSqsqwchcba2A66nx1piVujYf2lCdXfMWNFQEd8mu?=
 =?us-ascii?Q?3uQFy9LzsXvGBtOdrwaucNWKQYjutHwberxpXYReEFufxexmqgmxjlWZqYN5?=
 =?us-ascii?Q?J26iRN4fgO/w3GX7AvQsLi8W9m9q1nWLnnr1f0zz14I1nyT905+HDdxITaUF?=
 =?us-ascii?Q?0Di8IQUwyadklIiI4bftAWmNVP96905M6Bgm/ijHD6oDRyH1tdGjsJwbeDWZ?=
 =?us-ascii?Q?q0i9EBkIbLZ3Opx93b12yUPpYg+fxaVr5gHXGig/jJtUfqOEW+/PKNynloT4?=
 =?us-ascii?Q?+6+AuuFT7QNpMc7kmsI5M94Q+0B2WHei+ST324dVLlfRbqnCoSm70PJYqI00?=
 =?us-ascii?Q?OIjtI82OecaVKNm0kB0hw1pvEIaMQhwAdyUMhMI0/uNnSAzcCUMA9prGJEFA?=
 =?us-ascii?Q?ylqwXO4Bhscwhdo/rhiWOzsLGD+PvfY1FAkvoYlSrvPNDn2SY0UDzJBin+vf?=
 =?us-ascii?Q?Uo/iHnD+24NpFWk4vAD6ww2UCckQfHnppOZl3u0p9Uceuej3Rw99ynLDKR4U?=
 =?us-ascii?Q?dBtERORkhIxQGwjThhCSqrMoD4tJBLL1+NxDrnu9dJghzhQKwtQWenoHm+3I?=
 =?us-ascii?Q?1A+wC08B8YgDtJgJMTMbrkzm6+lfaYRRDZY6zyFGgIoy9RB0mmZUh+ZtjaE+?=
 =?us-ascii?Q?5Q32Lh7Rl7kjwD/Z8rqmuH0xY9HYqm4tFf9vk4fXZFO753H7j0oAqGbmNep1?=
 =?us-ascii?Q?clHjWMvh3qoSpeNoqzpQjwxYVbkUzdh4l/x1fu1gKOc5UoVBW7RX1CFCAeC3?=
 =?us-ascii?Q?e75bxHoyAR7sW5+f9+XzGEpG9IP6L25j2uVoiiuQ50V5o3UU7IyeUO4bHFnA?=
 =?us-ascii?Q?yt+96KwZzbwb901VqWsceKuWJk+R0rTu/M6Ctgextw4mxwu7w+42KO572IAD?=
 =?us-ascii?Q?z2+TZhX6WGByLMoLVHMlN6HAcZSj5ieA6dB9uK544lzFUO7xSLakUmFQUQY3?=
 =?us-ascii?Q?nIq/tdWBK3pSYu5U8ud+ZLj5La4iForpznpjWRhO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f45f1d-3223-411b-223e-08dc9584d7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 02:08:16.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/5jKPUOKDhqn2r5btjxMBum0cx0K2gB14Owsbf5iqq+2dqG6mOH299eRyWZGUwuxoVKNKmrh70+ySr2NrbMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 25, 2024 12:39 PM
>=20
> Emitting a warning is overkill in intel_setup_irq_remapping() since the
> interrupt remapping is pre-enabled. For example, there's no guarantee
> that kexec will explicitly disable interrupt remapping before booting a
> new kernel. As a result, users are seeing warning messages like below
> when they kexec boot a kernel, though there is nothing wrong:
>=20
>  DMAR-IR: IRQ remapping was enabled on dmar18 but we are not in kdump
> mode
>  DMAR-IR: IRQ remapping was enabled on dmar17 but we are not in kdump
> mode
>  DMAR-IR: IRQ remapping was enabled on dmar16 but we are not in kdump
> mode
>  ... ...
>=20
> Downgrade the severity of this message to avoid user confusion.
>=20
> CC: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/linux-iommu/5517f76a-94ad-452c-bae6-
> 34ecc0ec4831@molgen.mpg.de/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
