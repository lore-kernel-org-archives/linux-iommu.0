Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8500EADA
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168817; cv=fail; b=frhh+i7hAyn04bmcOQVAmFe4t8UifPc5Dy8pXlQwWSJUfPHjgQJetLcmG3L8q9VvawW9iU/lHq1f7YAXuRUgtULjweMlmrTcXDQK9FmnoZpHXEkZjVl9DfWB0f+Fy2NQbMS0tzyxZyPmfS+BOD0eDZWR/Hevj40iSvQ6/nr2GJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168817; c=relaxed/simple;
	bh=UrjdycrFNAWtSMCtIuIi6+wzHSGMBLfqJCH3OgO0QaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M09zd5ryyEk6J3fPWTW6dWS6W8SzuIrs5YxuglJZ0fuwKp5ot0/sH1ENPVpooT+XEzFCBIi1zAGombYntf0OLXZstuPK7p3fG8sGP/GU4sshXZQe44Iqw1vhz7UZR8AabJmfzc/GXwv7ySbrHWUnR7FmFVR0xRMKb8AlRhU4kGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWf+prnP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWf+prnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723168814; x=1754704814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UrjdycrFNAWtSMCtIuIi6+wzHSGMBLfqJCH3OgO0QaU=;
  b=hWf+prnPF8h6HYsP/LLNxP9gfzb3YyvAPtCceEhzTb9KuGFLwAESyuwT
   sej/LyHxaTQg5dQP5G55OcIafEgFbfb9EuEEbP86zA/ewdTbW7NMpeGA5
   bgNmc9TrLY1GpVVfRLTY83tUKfbfEBomqaVqUku8d/LrC2gvQcNbHvxAT
   cz9EytUsEzcMZf/rdIuoAcx/mlnvKJdBtXJOtmXsFBQ/vhQCvcvTr43qk
   W/2tO+iVFCHGxXQcNRfB2rAo3puHTPXMeDS6Lxd3gN9oZeMKMLWPFV/40
   MytBP7LK5pa7mNQZrmbrDNQ5npTrUKlVmjrOb5iXdIj0fjUdKMGRiy7Xa
   w==;
X-CSE-ConnectionGUID: bzJJQhrYTP+0R76nPaqoUw==
X-CSE-MsgGUID: To5KGw4XSHa7WUjf7j9uJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25198696"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25198696"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:00:14 -0700
X-CSE-ConnectionGUID: aNa+xPTXT9iBQbTRY8+PaQ==
X-CSE-MsgGUID: jhJ3HfzuQsWl0LlTRLfBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="58127881"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 19:00:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:00:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:00:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 19:00:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 19:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCLjoxZEQ3DHCZsSrPx12/6LzcRArpjDEupixFdrpdyB4rQgfsm/rpYMFEuvAKQ9MfgxepGhf7GI7x1EcupP8oZJhmxNbjCpQJwlY7Cv05TpJ6Jm3BRHu2ds3Ny9z+1DjEHcShAF7y7JoUKI/AUofhwFcIeJamUsBO4BROXiEoy2oUxndx+dFKBOysDsy6iHFtpKH+OseQrp02AOHVQSbJMJe3eXc6bO5+wdPr8D9szHbWJKzoW/vt5+9tUwYpQKPk7+xO9AQ/wUj8E/CDP1tlQXpRWhOGalupZwe1zzFrhjlvNIFupu+tELJf3FOlVbdC0UIVooWJfcOEq7L1Yasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEH0VYuH45gWZkvu4xmZmWX+0gTAHzpNEzuLxfMPtZo=;
 b=BBvk08fdg4gSMhTT4nhk5cUy0g2+lrPYDIzRcvr4kyCTfF515txaHb+r5S560aA1suNNtVF6Vj/1HrLT6t4jeweoQBDhRGu7HZKpbfPwUqhZ/N9sghJ0S5eLePw/+ONkfeovcX8nNKJHZUus6QPiEX/jXFyl3pNBXj3rDE+NhM5K/HM4R5ucQzuOHlMnYBsx2EgC1rPPHs2ed5Qtv/6C+hz1L2vRl9sq0IlqjaVaPKVYJdrn0TYG+kRwaTd8S59S/2L02NWMlOTDptE2uR/vN8XKRu9IKvG/UEaannVQtuWd1x423mX6tG1UEltMwS/SlgOlWE/86DPmSR1EU600vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 02:00:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 02:00:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Thread-Topic: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Thread-Index: AQHa6GG5hyMcek1G+0GMs4Xta49467IeLpIg
Date: Fri, 9 Aug 2024 02:00:10 +0000
Message-ID: <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
In-Reply-To: <20240807003446.3740368-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8422:EE_
x-ms-office365-filtering-correlation-id: 7282a697-5c0d-4139-383e-08dcb816fffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?njfyHdkqcM83HRUqIH7fxCtYVZlLE++24B/8PMs1mYWfXf07giop3zx7ZbCY?=
 =?us-ascii?Q?nHzSd5BH1hy8zdqfgiFYTZxo7VnyrSXpVk/Yp3FHgeuEugS9fH2gijmKOY8x?=
 =?us-ascii?Q?5JLm4aKgU2cPcBDjIigP8FILyAUp67/5txBHQ7QnDTX1WaYIPb8TlL4gUuMz?=
 =?us-ascii?Q?FvFEjJcTPWX+FOzjZZ1Gsi458wMohl0FG4FCQomSjfFBeCYtRp4+xx8mdVwE?=
 =?us-ascii?Q?1vpPPcKqwbq1apR5JP+RK770ALe3IKzFSjflI4XUxe3b8iEF6ELRsW5tCMIH?=
 =?us-ascii?Q?0jMDtjYVfIpxxB94vABtv8xLWzKPyYSqvq8jK0YXEvqzFFEk+JdhYA+mnt9s?=
 =?us-ascii?Q?OxLAbmi6Htx/OqxG0UI7RxRNK7cHhGS9z/yCUi1hwBwTyOYHlmZvRZFylJLA?=
 =?us-ascii?Q?1/I+Gg1CzH33qxMDs3TSEYhnOUkwm6GGaTCwWrm+FHkqaIXV+mKL71hpD6/z?=
 =?us-ascii?Q?cabf1YDWFH9bViW/ZTbOdtlt+siqddJ+6hXn3irhpnQs2FBTgeYpBmCoGjEH?=
 =?us-ascii?Q?Zt3qlJespyhnL/hTDfMZnoaH/7dRSSgxF5k8EEVGePeICTpKFVtCFg3u1mW0?=
 =?us-ascii?Q?U8bfRsvSz0si4XINQk4tzu5t2vq8dv4XTHfSnzuxBYvLlWPfpTcD7kVYSXK/?=
 =?us-ascii?Q?GflQlEPAd2IF+bW/Tp+4mNorOYLdkp8l2YZwJwMkn+rdBzjPTKiM2svInWeP?=
 =?us-ascii?Q?xp47YMULeDFxmMLMRueDspcDMo1aQc+6uHmqCcnb4KCu/9HssXw7vtbLgUS5?=
 =?us-ascii?Q?Rw7T15y2pINbtm8WmDWKnJ8MrMffDPlaGM8VBUonoIQOzb8okCrwGgvMpFG3?=
 =?us-ascii?Q?40Fo/SFoM72p9T/nB7nSBNBCoWJ2s2bQbai+qo10eEPiPsOOGxNNGovJTTfO?=
 =?us-ascii?Q?mUu6RfVAUPhrCoWApFRIXJ9I+NnzUALU9qKkXfCajq9Eztfa262+sPUrqImm?=
 =?us-ascii?Q?hVSTFwWeGFb0HKKa8flOINqUEMtKkJefj/tW4XB7kJuobmx7HdpH3VWmGmzp?=
 =?us-ascii?Q?5DSIxUdybQcGuaxuqmLt5mabfSAD6gC1Y4D8GHnVLP0KKvLAJiGgJYhlwMaD?=
 =?us-ascii?Q?Dot4lDo2eTkt7JLYUymWj5SOkQ4xfeCsGf8Kn9FyHAlabSNEpGmfUBtxbq6V?=
 =?us-ascii?Q?RCzydub+snZRpas9gWeUAypDPj/p/BpDgoGmmoe9afPDUDzwh3MlbUVH/NFa?=
 =?us-ascii?Q?+R84XiUNhq2bTe3ra3Ylj7Eje6v9RXMDlLkYv73DnKVIXeWjrxCYLknclYZS?=
 =?us-ascii?Q?1ruWQOe5ns/ZVA+wTa40I2rhecVDxUW3rveIf8KHq0/7Y1SqU/8fIMcAWUIx?=
 =?us-ascii?Q?eoUTemnR+KWxh9wng4T6vOlrCOcOD8lCSISIp60nCh7yR2OUHZWtn3THoSK+?=
 =?us-ascii?Q?/WsMXB8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EQdlTj4hLG9Eqk0Ig11jfH7oCobWogJfvj024WwEg2EnYTEj+k8lz9vOASQs?=
 =?us-ascii?Q?im0suXayfcJo7QofpruJEq++FxP+OUmOZG6gCfG/ICviqHjtW1+GPv77JqcK?=
 =?us-ascii?Q?CwVEegMfFjuw0CNB5K2sdjxm8hV8iPOc9/UHRC5CRvQdLAxvt3RSrjJk5mUg?=
 =?us-ascii?Q?ylmcEhOP4B0t9dDtZiQ1ms2OPRO1gqTG1Ncjv7Kppjx+Yb4tPmL2Hnl6LVCB?=
 =?us-ascii?Q?Y5P9jH29rm9wuoyYJnZTMXaAYRhixAw6Ve6Sha8EwZbrkCEXefrDjCS9S9m1?=
 =?us-ascii?Q?V55ecgNEdOr/biyG0TMtROgCnimhWR6MOksLfZyyKt7h3SemB6XDgeMDgeSv?=
 =?us-ascii?Q?hm1iO1T5FU3YBFnPOkYwUmocrec6534wWzJOUAVdKL6LnBadV5pc+2hwnqMJ?=
 =?us-ascii?Q?4i3gtX0O/nkTO+Ado6vXbwNn5OH+YAnT6/tkKVHcbdrqEEvfU/AQOyMlBK6M?=
 =?us-ascii?Q?5GGwVHOgzsXXpfdos5e0rJRMRoQFtdNrmjsSrXPBiLbH+viWhQ0Abti/T0WZ?=
 =?us-ascii?Q?fh1cOWzO2NMD3vYxhDvrwqLUPXMn5KMxZ5fZgR3kwMIknwR0aac9Z0vMFaMf?=
 =?us-ascii?Q?eYdaCfvcLJfg/OR38EJ3t7jxiqiFAouMZexLBR8jI6dM/X+ywSMIG61hEV7s?=
 =?us-ascii?Q?WBw97+O7qmEKmbTBZvfWKtNHxPHIeTceX882gNDifCmahBIeyF3PdT2exSTU?=
 =?us-ascii?Q?EKJUNrlb3/JbK2YPYCfz8ArUqvbjA6vdV3ZUHzE0NSsACOmZm5cZeSBZg+MQ?=
 =?us-ascii?Q?afjeHqG+rKqKng008SktOPuJ+JakORFjMZOnneUVXjV+6HEhrC8qFoSOHlaC?=
 =?us-ascii?Q?4fj4CC9nuxGO1HE++EjqrVo0NOburOQR9bG7l8NtG34oHMtFtis1BqCNavMK?=
 =?us-ascii?Q?/tlETLRudDBm6nLQW1To3JI8IhPtT+YeLYQ5f1mNKL1SyLrJc/1TY+jW7HUU?=
 =?us-ascii?Q?RVybenuWYVCEVJg3U0falukxq5XmK/SOuToWj7+Ifx2/mZPqBComTZPOaG7d?=
 =?us-ascii?Q?WpWEY2MQJ+AYBIAYUvl83OHWqh+T8PHKwbvumStc48ENvYlYu+F9SVG3aGig?=
 =?us-ascii?Q?dZof+OHe6Ij0jnRwEEIKf80OiPhfGw2ryif/WxjlfX4QE2yFA1+RVKwPs/Vv?=
 =?us-ascii?Q?mmIR5aO/fpgYPpGLG8uCpHEq0wMnVRIr607y1BAOq7OnCzJ5MIn2Rx9rR2eg?=
 =?us-ascii?Q?17PIvk0ggL8B/5lWWIyX1NxyO5Ezq8JKNwrR8P9f9RJ0YUPENKAlzN5yYQ1U?=
 =?us-ascii?Q?Jb8QlMudvVv2oVpLh7+WLZRRNPiUEOgg8FvdtKpRVkG/r3QwYQDl7KefpWh6?=
 =?us-ascii?Q?jAuHX45SzISAjGSIK8nosqJVDxhIe5jqMWOEjdJlOoaTzuuwTApQ6mmxlLV0?=
 =?us-ascii?Q?htzXktQKHSsINvrpxFkqlGjWSnh17cKlpt4HtLCCZc1jDqQN3nM/X+WuobTC?=
 =?us-ascii?Q?a4Ft0DDDtSUN6bTROw7je3j8htrfp0PzWW9gaE6EnrqkHWJGsAu4GPtH55gp?=
 =?us-ascii?Q?HVcVvrtOx6v4Pjou1hMDnQox6WGJEEyYFpaFw3HoyS4Op7b7tYp2guCU3znC?=
 =?us-ascii?Q?LK2dRXwxuHqMe35SZTcV4Kf+mrq3Re/TkQj6k8zh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7282a697-5c0d-4139-383e-08dcb816fffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 02:00:10.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1a/t9QMAfbSsvY/k9LkEXWkCYatZmgTUY1oOtYAqmUsU7fCQSdfROFjxP2bkSSQbsJ3a6P4fZZco/AMEKmk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, August 7, 2024 8:35 AM
>=20
> Currently, device reserved regions are only enforced when the device is
> attached to an hwpt_paging. In other words, if the device gets attached
> to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> would not enforce those reserved IOVAs. This works for most of reserved
> region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> defined window, required by a nesting case too to setup an MSI doorbell
> on the parent stage-2 hwpt/domain.
>=20
> Kevin pointed out that:
> 1) there is no usage using up closely the entire IOVA space yet,
> 2) guest may change the viommu mode to switch between nested
>    and paging then VMM has to take all devices' reserved regions
>    into consideration anyway, when composing the GPA space.
> Link:
> https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@
> BN9PR11MB5276.namprd11.prod.outlook.com/
>=20
> So it would be actually convenient for us to also enforce reserved IOVA
> onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
>=20
> Repurpose the existing attach/replace_paging helpers to attach device's
> reserved IOVAs exclusively.
>=20
> Add a new find_hwpt_paging helper, which is only used by these reserved
> IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect
> to
> its parent hwpt_paging. Return a NULL in these two helpers for any new
> HWPT type in the future.
>=20
> Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

I'm not sure the name find_hwpt_paging() is good enough but can't
find a better alternative. So,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
