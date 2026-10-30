Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347426;
	b=zM0uOB5LSv/bTrLLgZ3TTF1ToqueWaE9BlEJUfk/dVi/AK7BCEBz5hJjjgAMP9OXMsl+
	 JfcqKRTsd7ykBGxk07sCY2jiuhCmjNnA89+20oVKfpgOweXo9dgBv3jV7cQ5tvqdlZfgE
	 FXQFsSEUgwdcF0bekTgAjQ6flNhAFsyZek8FCttmN1suT9M724Su7drcWL+AvStLsDOH2
	 84+ha9jE4hnEhoFRYvsSE1pXhXRx2UdlpMlks+75b6dZ1yUpKWcVQr9/GEvdQkoHRwc5T
	 5h6ZvOgTv5GhLJIAL1AXyj1AMCyhAbrQrVTiSex4Bf6y7M6s1OlqT+knA89GZ1PO0Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=VIGA5ijd+kGRMUFTvXURItI/HOyLDUH7HcwBkep0b7U=;
	b=W2QIOXsTwANNGSsuszSGq3cmNEJ1sFC9aVVqLjoVLgQ2oPK8tDROH59ZsnN4o8owb66d
	 0OkO6JNTCbIXFX1fsoRPeQSePdW06gFylzZDVCsMdWlFegpxbYbTDLZ+gi9lp4WGYpblR
	 ZrjUW9RJyFFY+YHsEd8HNGZFFe1hKamu1J81S0dv6fu3C6c49WOlVj1J1T1pCquxvZEXl
	 N/nC+EPYx9emLnXI+NDAfZGfvnGo4uc/m9Lf8A/2KRv/B7top4x6qi5aoHvKKBGdRb2db
	 h4ZcPswnusehuGZ7XqwSzIZv1Ty9k90H7Nm0/s/u6N2xhlTfFVOs6hAqf6TD5l23DJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cCTQWRNW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5798606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5798606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cCTQWRNW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793347425; x=1824883425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6TphMmJMyg8kdVepI1kcFq7Ta7sg8JCTUWaNbjJs3I=;
  b=cCTQWRNWLO3cc/8NT14cmw0Ed+riYxyIexiTGXne+EDKLxhT7RQYP5sT
   hqMNGE29jcwi8oKCZy4FBl7L0nZ3mz5prQcrwKKSsRknKPbDyLLuUPJYA
   mGspiiAceGA6jb0C/HhWS46nXk7qhh4ybocKS5CCqvE28EpX9Er68HFns
   xplhw+i5iD8b1YohUoNtiIWR9eiOJlMb2ndGbxUFLZp6egD1AAis38QfI
   76kRKM/ZaghuO2ReF+7cYZxC7hFLH4+kPstkAYk6sVijfi/0zfLEP1Ugo
   3gxgRqqsXa2eHoLIG2T/v9bv0sjRMNQR4tuD61UdvefcS2xZFNLCo0t0m
   g==;
X-CSE-ConnectionGUID: I8MvbviVQle0XvfFlDuL3Q==
X-CSE-MsgGUID: q/sMVSrkRzOzX1NhptfnbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1997523"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1997523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:03:42 -0700
X-CSE-ConnectionGUID: lCe6gu9ZRq+/6tNWTO35lQ==
X-CSE-MsgGUID: pl9KzyKvQFG3XArdwg09Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5743570"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:03:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:03:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 01:03:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pobc9xDR+uFV+BcAsT1bsA53eORCGpP9MgNnWpdofDKktF2gSBe/Hy3loj8zH6yYTvnIo+HwDG5QZUOALvb6wHNoR3Y8iWyZdVdTwqgyqXU/NWTGNmoiFzoE0LapN2DdhVCJK8dZ+ejTw6RaN+yJxbocrdueuKAUbPTCzR5GTpQZkzuVNnSNCpO5bdnqqLBi4BTLl46GCrNn0HQdbu5IBlPCFOW6AjCtMNiHHreCYz2xcdZQ6u+SEkVIsOZe2VyY0r628ScDuTBJlAT+wyms6nSC+zTG6KY4JBSAMiCa9bFLcjb43vFlXp6kg6wR0IpMOhL363WNUfz5XRWTDiNgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIGA5ijd+kGRMUFTvXURItI/HOyLDUH7HcwBkep0b7U=;
 b=dhKPaDLpHY8I6RAxKDp4UJrXqSVVEtRXXR6olUC8NQ60URDQXDFygpM2TYWWqoj3cEWzT59gEYJW12tPuU0D4IoIAVBD1tlEmpWa4UR6MYHAcvp1+foBUKbDpTgpkUcbJUy8GZj1ipBuzSoa/IjuYLjk9c4bXkD2tWO6Upkjw6E38e00aioZwFwLfXi0BtLhEmy2VlblQIH4OikAG0Jnak8hKIE4iYi7yEa+3L4giOZQO9Gv19OtyNWg5StJjvgE5P7+I2uI7OzK5QddzoSkjCDlo4MFpV5aGedIWUuvu3jPv+qBNiCSfzlU17vJ6XYcYMw/WGctrp2gpCgJS5gNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DSVPR11MB505860.namprd11.prod.outlook.com (2603:10b6:8:3e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:03:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 08:03:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Thread-Topic: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Thread-Index: AQHdUFzfUPpa8Rov+UOYSfzTDqgP8bcUSuRQgAA9wACAAIIKAIAA3kOg
Date: Fri, 30 Oct 2026 08:03:37 +0000
Message-ID: <CO1PR11MB4835BC9658F73705121173838C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
 <20261029184544.GF3734323@nvidia.com>
In-Reply-To: <20261029184544.GF3734323@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DSVPR11MB505860:EE_
x-ms-office365-filtering-correlation-id: ba2e6e01-5b54-4236-848f-08df365c4d8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261022075727099003|261021135927099003|261022105027099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Xm1aIqbLpmBJMON2zfDYsAryFJYP1G2WtpH26SfmFl6IOqISiMD2vFhMFJv+hgz5Foq6jjjZHxTfMrMJRtHP6wbwWgyXBkLxFY73nnXAnwCAlVtBgl2xSgHUPj2sWGDae5H9Egy0SDDL7MGoSjExNdEJGkdhxzLhQUceVl94/uu1m7o1X7H6KHy6z3fK3mCEeYFMYmLPkXLkAuZXOqFGAWsKrHtYk+9C2cmA2q0TzlgykmyHq6jOp1tzTCE7ujHMPg9GJ0E0QgVVMItgpJL9QeBsuKUk2cx7sP3zlf66Pm6FuJYd+OfqAS3o+sfIgoQcjY8+wkJMImzUfszsrU5BX51AAErkVvUgm/0GXtaHDAfx/+VCKXD55bd0JWwYRqnFdB6ujc2Usk6Oy5X0xautc/gl00mgmzayIsVJ8+ObXgCCYwHnVXWeoRvHiz5tF+wyH/brTDJWdaXvR3fafunWLpwCkvVQ3nA0msM1t5cB4VNuLxUP8vEsjHdv/yHalf0h45CJpP9HjQxbzOJPwKnlZEr4Dr7/+oLmH6czoONQDPlGn/DqXSxYC0KYbJzfkk/hr0uSiuzfRryhZipn1J+JrsDGLYY2rBd/M53xD1uWQOQf36mT9QsENHfqnmdlTLlDlUMMoJgP/TLDJjZ12nLbozWXTYXzyLcw1MDWMga9AjuB3U6fv3c6+s3U/bav+qIT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021135927099003)(261022105027099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mSnG/3xm2LvX7LtwNAPIB6o7wy6UpSWDpTzlKZa2UvlArgQ5b08we3pW9ILi?=
 =?us-ascii?Q?VNbvkaIAM4dPn351OGRbQDeHIJ+NaRJE4YBLB7QLp6zrMUSam4Mt1uwLL43K?=
 =?us-ascii?Q?wAIfabC4VNNjCmziIAnbIXtW53nzpoSptbRnO3s7+gQUdg+mkzPElXFGEysA?=
 =?us-ascii?Q?lvuzlDamavMOnVnhD/HhLoD83KlSBl1NK1hKrLRZgMG4WYsQzlEfJBSwkzDx?=
 =?us-ascii?Q?P4rl4TLK+pyFwS1t0uAvd53AhpJSuQCBWjwqoFUe/g8lZG3mZqOs0fO1BRIG?=
 =?us-ascii?Q?eDnUtdKHIwyu1Vgs80plyh1t+5XMPuJK+NhP8CZVnP4G/+LWFY1I2Z2Xybhd?=
 =?us-ascii?Q?uw2e5na73axEDKNNHc6WYkN1KHdqHNDw+5oBuquFGem/WQNU0Cbx7CB/GkOo?=
 =?us-ascii?Q?Tw8oV0EEc6hJx1zM68cZQ+S2H+dGjchznFFinQ96hi/fej2kGDd5jTyXdwFH?=
 =?us-ascii?Q?JHSW4Q1mCRRLhIII5Htzdp40/OUtbyAiubj3jRr0jPnXS+0kkg0HUn3cMs+V?=
 =?us-ascii?Q?CJtdhVT7RA5mwLpFAF811lbk78qaIhgOu6twt3d9pLY9VawSvMquPW0KWlQi?=
 =?us-ascii?Q?lnyDiLNM2lgXivVAEoPSp/xBK2otameQnWdBn4EP/ysOl9N76TY6RMm2UHdn?=
 =?us-ascii?Q?NU9uPZoYpggWDE3PNUKzQwcrrBsAWDlU5S+uzTG373sxFkn70XHwD3qc9Zu6?=
 =?us-ascii?Q?K05sbOiE3xtBHyOSRWB1LeSbch+qMoRRXO+iqS0VGls+oLRrsgeBlRFror97?=
 =?us-ascii?Q?vRvxKFPgg+o+p5FOqRYjAqy1OPMP28xb+nVDO+NjrzlCr6fCfrbZkeJz7cLn?=
 =?us-ascii?Q?+mu0QAyAQcdmMlfQsiiDOfXdu6PpDSjFJ2ETdItr6H+oOEZYkOnq3GZWbC4S?=
 =?us-ascii?Q?5EDenkqdkHs016MgKajHHcg5/Dqpbk9z8AM6RdJXCpghYaqrPcEm4KpQtclQ?=
 =?us-ascii?Q?dV27S329dDkRKVPhQMHrHvea2IEtDt8TsZYnsT7vMP6FWLvwvWdnkakmeDCr?=
 =?us-ascii?Q?kQti8yvpqCsi9J4dRgDGTx8z3URsB1W8qEpVPhHsin4SiKzxQ2Hc1+5yev/R?=
 =?us-ascii?Q?sWqBSJwn0XddevgDZFDTzbmXZ7k0sSwVC1z6hzYz11E4Q/CSubCQcoY6ptc3?=
 =?us-ascii?Q?JMppoxyuFgf0Qf6X/J5AWQsfYitia2vhssZkMqiAQZmSDP4gOVfWibqXuwsY?=
 =?us-ascii?Q?KM9c5mCfvXB3zBsy8CRIy1+qSU5WynFkoo6PBXEeWRJub/uj7Pa1FjPPp5jq?=
 =?us-ascii?Q?YvL8vAyQh/C/eJYXdw/kwZZWqdHJPHN1bJnioQHsURE7UJHA8THYFWPMufEi?=
 =?us-ascii?Q?sb5PMYK+CwxxDS51R/8FmdYdTtA9KYfm0SiHQHgUCegWkBLyMieVGFSqnAp5?=
 =?us-ascii?Q?+bcBx7srzQQ2AxeQ2QyMHlXiczq8L1pg01uAF9W90FzMz9AQ+l1LV+dU2GB9?=
 =?us-ascii?Q?cuOZDEMjlbhreegEB+kGNKNZjCeBMaAXLRZBXfos/1nxF09K5qNa5RwepbbD?=
 =?us-ascii?Q?+TUkJ5mzPjJJNyMEKeFsDCAtjJAClxP2d2V+6+Q4TXhAl4/nH52Dk41yBXS4?=
 =?us-ascii?Q?DLQBAYuNyTS1zM37bvl6geWx9Zi3S85pS5gyoarnq0+JY7/CPcksXOc9k9cP?=
 =?us-ascii?Q?8Twb7vz5GqOgNCpWr0FveKciLhpCUnyLFW+weixtHzEI+/YvdC5CO6xmEOty?=
 =?us-ascii?Q?uhLxzV3PdNnaslcqKaeIizPKuHxgbvGXTOlyEhEwA9J2k9jG?=
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
X-Exchange-RoutingPolicyChecked: JENeMvwXQP2oC5EdWr1ZPwAH5s6XdBFLfHycSACw/lUTK0GL53CMZmEyyajjWZOJxn2B6v+1h/wUq5bzcVWR/StdugZsuvOxUkwezf96HTUooZWFCOqfj29pHShdeh7XcXTWodmfijcsGUSc7aqF/uzuNBljNe5//6B93NToHoDf1tcGXQHr0AHVlhvCDkaXpGBC5Avi7wS/7EaMbn0JukmuwqyiAUxzYbUiMvS9Fv3UZJ/M8irQgN0seLH9dZ2SDbmnTt91GCIxxZaH+BR/oN8xTOb6AJ9QBBwgRIuIdJf9oQD/7oDQ5VUCdCYhgv2JCxyZIH0a1BF9X5fF1jivIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2e6e01-5b54-4236-848f-08df365c4d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 08:03:37.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcUY3E1+7j3g782HGM2m+jjWr8bhiTaLmVCsyxge0nPCwJ6nvHz9fTgsicY5CqUfmK8ONb+PslRH3aDq9zG+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB505860
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 30, 2026 2:46 AM
>=20
> On Thu, Oct 29, 2026 at 07:00:18PM +0800, Yi Liu wrote:
> > On 10/29/26 15:25, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, September 30, 2026 5:52 AM
> > > >
> > > > iommu_replace_group_handle() looks like it hides the detaching hand=
le
> ahead
> > > > of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(=
), which
> > > > stores only when the current entry matches @old=3DNULL. For a repla=
ce,
> there
> > > > must be an entry sitting there by definition (i.e. @old cannot be N=
ULL), so
> > > > the compare fails, XA_ZERO_ENTRY is never written, and the call dec=
ays
> into
> > > > a plain read.
> > > >
> > > > Therefore, the old handle stays published during
> > > > __iommu_group_set_domain()
> > > > and only gets replaced after the call. This creates a window, durin=
g which
> > > > an asynchronous fault path might hit UAF:
> > > >
> > > >    core, holding group->mutex          fault path, no group->mutex
> > > >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >    xa_reserve()                    ,-- old handle stays published
> > > >      no-op, the slot is occupied   |
> > > >    __iommu_group_set_domain()      |
> > > >      driver attach/detach ops      |
> > > >          iopf_queue_flush_dev()    |
> > > >                                    |   iommu_attach_handle_get()
> > > >                                    |     reads old_handle
> > > >    xa_store(new entry)             `-- window closes
> > > >    mutex_unlock()
> > > >    kfree(old_handle)  [caller]
> > > >                                    UAF: old_handle->domain->iopf_ha=
ndler()
> > > >
> > > > Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish
> the old
> > > > handle.
> > > >
> > > > Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
> > > > support")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: LLM
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > >
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > >
> > > btw I just realized that neither old code nor this fix can actually s=
upport
> > > replacement with lossless fault handling, but I don't recall whether =
it
> > > was the original goal (then destroyed by a following change) or inten=
ded
> > > to be a future enhancement...
> >
> > There was a related discussion[1]. With this patch, a page request in
> > the replace window gets IOMMU_PAGE_RESP_INVALID instead of being
> > serviced - spec only says re-issuing the same PRG won't succeed unless
> > the mapping changes, it doesn't forbid retry. So I think this is just a
> > more conservative instance of the failure case Jason already called OK
> > in [1], not a new hazard.
> >
> > [1]
> > https://lore.kernel.org/linux-
> iommu/20241105151042.GC458827@nvidia.com/
>=20
> I called using either the old or new translation OK, using neither
> seems suboptimal. So returning IOMMU_PAGE_RESP_INVALID doesn't sound
> ideal..
>=20

This probably need a RCU so the old domain can continue to be
referenced by in-fly faults in that window...
