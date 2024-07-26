Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1B79FD
	for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953099; cv=fail; b=T1ckYmV90GfFBApLVEgYU/GKZkMWDo849+jaIYK3BRF68NKcSfWVWOxp8Qwks7L9RCbRzFfQKKNl14d7mj3xdVYsi1VDGRCMIIohc+dwzqQfUON83kl69w2n6UH+x5O5fY9tsLxYePzeZdIAn+PsjVcwCqE88cqNA7S/EsDzlEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953099; c=relaxed/simple;
	bh=U3ya0j2IEx1L+fexeQcgj9kNFEngc6sU/DfbiVy7vFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgQUPu5uDCAmxxLdGZH9SaDRFvndqSgVg5fH8hq/afFqWAvFSBEOKfMv1sqmheQczIPx5czTSDua56z22M2sv1gpggVYvPi1Ji4Sb2Yq+3tqAxAQWd1a3uaBYpB/jIjI2Lz1V3IRGiaQOtGwKg8v2lAYYE9WAd4HrYs5tPkBp9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GV+VrmFB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV+VrmFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721953098; x=1753489098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3ya0j2IEx1L+fexeQcgj9kNFEngc6sU/DfbiVy7vFc=;
  b=GV+VrmFBzgLse6qg4uHGQPqUld1dzamEvcpgrdfkvypcNQirV+j9IcmF
   S3+/0epNTinBQVoJUHSScuypmMnDXTcXW55GMby45zHPrr5CF4GpNZXia
   FVZkcjR5hDFkYLtJTX0jbpulQLowkLSc9I+0GcIPigx9yBZt2Ririqs6y
   F34U3AVNpbYpyECyC0wTv4my1vldTIozdMirXs+AAo4ZqoHXFg8ELk0UN
   +BnpNxEfQSHm19TmQnC6EuMJuYV7GEbf8GE7XbxJtP56gcwCDldgKYtMK
   XEpmez3h74OhxIDnb5N/maQDcy7NNCngSB+l3uMSqbkgkkVeBGVW8r5E6
   A==;
X-CSE-ConnectionGUID: MK56dFRoT6uyYIQjJbJKJg==
X-CSE-MsgGUID: CYCM8MQxTIeWgxWw2CSlUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19851255"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19851255"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 17:18:18 -0700
X-CSE-ConnectionGUID: dy4Vyv7mTKClCgCVk7w4qA==
X-CSE-MsgGUID: gi15EuLgTb6NIwFua9DlWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="53018687"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 17:18:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 17:18:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 17:18:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 17:18:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 17:18:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRiudUV/9arD+cDUp/UfvMShRcjrsi2msczdyoluGSNOZgHQZeVjZRrZcnn/+1gDeSOaI0ZenCNPVwjy4PNGt8Svzj26u7Sl7fTnz0f/az2AIAuZpjTvhtqg+Oep7g5RAYKBs/1R6Lep9/JFAXXuSIw3NgC07kvngKSpVZlwjjPYpM7ARhxVqPvxvNdpKvAZ7/DiUyLOObfT8GgU6sNPac7RdkTPCdg70BL7zPz5zSY76jPA51p4Ngvd9wEFsAYHHt6kxIRf68sq2OI0koJeD0K6HigUp7YeLEgVclnsk1sk5Q8DZ+2A8UktmHCA8YTsniZsRaAX2oFrkyaq8fLhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqajUnc56X0YPoHkrsJmP+Ym1aS/6iLOO94l5NG8Buw=;
 b=pCevp4YJXnR9N68qcOLHCB82I2sagL3Tq698il5R9TCYnkeczH6mk2tUfwxpoR9/LaSOggoFk4kuWMRoZuQm3y+vfiw7ddo2J74HMPUHSiESlpmudRuoU5eMtF4a/J/HY6MzxOmdIgvQOPOcvHUi2zMaqTeooNc+WDu64bTIDHYVHZRckfnrh9ql8E6iW0GQOyjUS+5/eRUFxQIj0kcIDpF5xIsnlp/aL6ZMSk9YMhTdPnnJkJpnfERM8hAbmSHkwDdibcMHbQMRMWvkGwbglO4hv4Lq8B7CoH04ETjAP+KNjP2KBaaol1kx0oAJMpTOPoRwKwRGMGi8QWF+5h42jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 00:18:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 00:18:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
	<linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Topic: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Index: AQHa2gc1KcNzc28ILkuz4h1++7d/drIFgnoQgACVtgCAAIi28IABWWSAgAAwo2A=
Date: Fri, 26 Jul 2024 00:18:13 +0000
Message-ID: <BN9PR11MB52766AC7AEFA103E5B1D067B8CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240724092540.6ef4d28a@jacob-builder>
	<BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240725141111.6889dd62@jacob-builder>
In-Reply-To: <20240725141111.6889dd62@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7775:EE_
x-ms-office365-filtering-correlation-id: 38602337-d17c-4648-8e14-08dcad08709b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HV8ub5RdY+MMaMIBFi/4TkGYn1JlKV7EgROrpxsg95EWn6mwHtRTwqa8taiZ?=
 =?us-ascii?Q?jfPbwNqQV137Ob0nMuikP7RXB4niAgembXvJkEOUpv4TBO62IGPFAIVPT8ai?=
 =?us-ascii?Q?xQQh6qK/9XwD8TXZeAnvZDjKoviBuYl8KCVh9LKKBOO7SBVAKIvYUz8OVRJg?=
 =?us-ascii?Q?Lqh9fMtO06sowwJbaOM/BkDG05YIorpcwANQXh6eWPpZv1+Y2zokv9mwIjyM?=
 =?us-ascii?Q?enwxHJ810IPn4CTGNl53Ad9Q+g3OBG5jg4M2hVGuXb86Lb+C/eWPABt5BL/3?=
 =?us-ascii?Q?e3vtQ0xWg0Z7OhWFL84tY/v/4IZOiRsr4AfJz9TuDD3/mZxq6qHT3Iiq2tQa?=
 =?us-ascii?Q?/hq6nkdT/zvErgGe0H7QADANPIdfrUjMCoc8dhXQCNc5KOxHIFS+a78A+0ls?=
 =?us-ascii?Q?lXK9PyVW/ga40zxfQI3U+TyRa4B7uHsglJJICOmK74j4TmX9tjsU4MT+j/OR?=
 =?us-ascii?Q?y14Cr2MVRQt7uRpHAtGXTLtNhK17PBWomCLVw5uAhWpaOMIbL3W//o+cwaiG?=
 =?us-ascii?Q?zT9AgOI2jN3LvZklUIZShZUH5a8BopfAauQe/Si75nbtQjYRf7t/nCqIWA2l?=
 =?us-ascii?Q?m+iWx1X5tPevljovgPx4zRB6wyLdsGtQ9bVh0g6+LiAVF1iqRPRn6DrGpveO?=
 =?us-ascii?Q?lcCe7Q5bQHVITMMD+1OIpWoTqENF6hKje3YsYvmn9YUe++KYoVMxxzBGVls7?=
 =?us-ascii?Q?5GgVlt1bal2JzjCtmO59zuFdH8dvvr1TXO3CJHt0fZWNJnY1W5wg0uCt669r?=
 =?us-ascii?Q?Uai8sCL3+LjojWQx+Vdoa9LkUoOJVNJ8Ri7nxWsto1lRgT/sCxyNeRR0U5ty?=
 =?us-ascii?Q?bMS3d1jP+PVVANRghJLYi2oYKAcoJ6ngDO/XDY0S5BzHtlwPBQXMdYDPmlDj?=
 =?us-ascii?Q?+pRg9bGt+zHae2Mz1erxlhEEHSt0eG5rGSms7n4gkQHR+t7MUf+dA3W3kZ7T?=
 =?us-ascii?Q?B3dsZLJTygM3k8XrRMPalBfI0/tPDy+DDpUaOqB/GhuHqril4QbzQ/nCEfGI?=
 =?us-ascii?Q?f6+1qAAZ08n5kcJ+nZH0df1/LqckghqCY5AAXx2A2rUQOnE3921EF9F2nkLh?=
 =?us-ascii?Q?R0mf7xzkWHs8OO4JjWzMY3/8Tj2rX6Gu3+CKW7iRjh7qWbck7fFKbjz8ZGxF?=
 =?us-ascii?Q?DbLtxX1gRr7j6xzJ8I6IJZjWs/dqY4HAR+aztt6d10ppoDHepbVbiiF7Y/wb?=
 =?us-ascii?Q?MasppyGevZz1QuRwA7A2x1yXm01KP60R0qkg2zRQ9au2anXj7wIK5+jbgndj?=
 =?us-ascii?Q?vio9UFNFiyDzl0Dy/J+dcakXZOt6ahA+/fRFypp8FPL4kyOuihvwxzTF7ScP?=
 =?us-ascii?Q?t0kAzBRbcGh3eBos7y/IAdIAY7jeZz5xg9m/CEDjbBjmI2KF7uLStXKBHwsC?=
 =?us-ascii?Q?xh8SL+ZplxS8bOQ+ok34fBzkiw+i8VPDHAG2K7v5h25165ZKBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O4k9g0QTqvEWRpFIWFIDgKLqKMWCt6qoOMS7jOv+Zrc+icDC+M2fLblI5JhE?=
 =?us-ascii?Q?HpyV3DgSh2w2cwQ4PR8nbXpYDGdHqaXF6USy4Jwoc2Q4RrSfqy/0sa/gIAoo?=
 =?us-ascii?Q?K/fum0W12/CxKnRyBxay/tYn/K2xnY/Dc0i2Nu29SC3naFsRVbT4xqr2c+yi?=
 =?us-ascii?Q?Ahib4iy8ict60FJE7YJiLZ9faqHHAijcxGh3mYtLguZncvlx8bTAiKPZF13B?=
 =?us-ascii?Q?EbwC6FhxS1gYY2YOlfkNi2htqjShbnYOfE9Dyc7D5AQZ6eWPCrlum+r6k3B0?=
 =?us-ascii?Q?1bwOYwL5YhG/MAeW+LHEuPEg/1785KlncEIP84leJcCkIMzuWfb9f2z/mR7B?=
 =?us-ascii?Q?YCGRMcsfRCTKCue6RtHyeRBgepeL6GDLzlwtRc9sNKXsSRypdduzWRYephja?=
 =?us-ascii?Q?cUgNwEUR39IS7HfUgoVlx2Na5lk4qLt0ojNFswyheNpwQYkYqXaNuAYPiE6w?=
 =?us-ascii?Q?0aqcbt6jUe+bvSKIj9vcivtpM1DfrA9LPUYJtafjYd2WGeC9RoTmAheYYlfu?=
 =?us-ascii?Q?j4TpXHNS09RhIuMZnppej4k+wes2Ue8J/ZLH2pjmJw6tcgRN0u8XHWaOVWkx?=
 =?us-ascii?Q?jNWJ8MBHAElF1wx/mRwSK9gBdu/iP7M26imYPzEtgUnzLkATFoedC9LWlqPH?=
 =?us-ascii?Q?vIwi/cs3gIeP+enYqvPdTJQBRSjsjMLlY7YPiKo8IKDgs5g/kCh0WWwtaf6C?=
 =?us-ascii?Q?eKUiqE+cFKY7p9SixBg1n6uXqe2aMvqCp833vLAQ6EEzFaShT5uROJlryvhB?=
 =?us-ascii?Q?Cj18hDCOXPavq3i99JgysNIdIw6G+EK4Bm+emWz1MJo+oLv4Ioco9IuOFwpJ?=
 =?us-ascii?Q?ES8eJz8q47obPoJvpLqkSluJrRZO/pIon/9RmBVU0OTCTjHu7C0DwdlaDCdX?=
 =?us-ascii?Q?FxtvL5tI4jVyhdPB1JqMCpgsYvhPA0jDp/Wh/DKYv73KJLUg2IZxF47xE1g7?=
 =?us-ascii?Q?FCjaPyR6GAozuDlbBSxAT5rjcuNe+ierEWBUbuyyPot/P3v8QrPscD5Lc5U+?=
 =?us-ascii?Q?gqvk0n7tZ1vjwGjvJFkMDbezdfdPYNNOqngfhdiEE4Vw5lP3oDPTOsAN92/6?=
 =?us-ascii?Q?AMgxXpAiZnMMs6mMJYQL2Wk9tbIXq4ytZd+DeC9Bd2YgNwf4/t0HUuF9bWw8?=
 =?us-ascii?Q?qE4+0JD4opG0FHPA3E4qcGag3L/0K6J+qmtcBp6wmp8nV/lurtqC9Z53N4NC?=
 =?us-ascii?Q?lUHaHJT4quo1uDZojngjtqZZAX1OtkWlHsdGfsi3vZ8vQ8h7Dpp81MHFlljR?=
 =?us-ascii?Q?dxxH3a0hhumfx935RcLksUkPLLyj4+mS3LZQdYmNO1IcH6NWEyIYJdZiujpt?=
 =?us-ascii?Q?9KYvk24LWru8Xycluy8U/Gbl7jLFPDvB6FMSQ1ehcl3685cBldyRDeG8EtGI?=
 =?us-ascii?Q?/XvTPwmdG35VA1nJq2yqI8YxF6fZXvG+O6vThyDbncLBgDXIcOMRspsdt2XZ?=
 =?us-ascii?Q?ha42Ej2uYmmpLnlB5ckamANu/uf8xPO1+Y1wOAXhHCAeQTBcur/PdpaPBmPj?=
 =?us-ascii?Q?X5cli24DoXnJADcqPm3vobxaCpEPiP4wJSwe4PLU5+LE+Jnmue5GKhOuw2YO?=
 =?us-ascii?Q?M9aPjbuz8WKm3zWq26OWzZUCn8enhuM6or6XRsaT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38602337-d17c-4648-8e14-08dcad08709b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 00:18:13.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXlF0pSvZMiOSlUytJkasv5zyLvqKu/jhNVF35m6fN+FgBYxadXIDQIdNnOeMSjd9XpsTL7SsvLZAT01yxvw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, July 26, 2024 5:11 AM
> > > > > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu
> > > *iommu,
> > > > > struct qi_desc *desc,
> > > > >  		raw_spin_lock(&qi->q_lock);
> > > > >  	}
> > > > >
> > > > > -	for (i =3D 0; i < count; i++)
> > > > > -		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_DONE;
> > > > > +	/*
> > > > > +	 * The reclaim code can free descriptors from multiple
> > > > > submissions
> > > > > +	 * starting from the tail of the queue. When count =3D=3D 0,
> > > > > the
> > > > > +	 * status of the standalone wait descriptor at the tail of
> > > > > the queue
> > > > > +	 * must be set to QI_TO_BE_FREED to allow the reclaim code
> > > > > to proceed.
> > > > > +	 */
> > > > > +	for (i =3D 0; i <=3D count; i++)
> > > > > +		qi->desc_status[(index + i) % QI_LENGTH] =3D
> > > > > QI_TO_BE_FREED;
> > > >
> > > > We don't really need a new flag. Just set them to QI_FREE and then
> > > > reclaim QI_FREE slots until hitting qi->head in reclaim_free_desc()=
.
> > > We do need to have a separate state for descriptors pending to be fre=
ed.
> > > Otherwise, reclaim code will advance pass the intended range.
> > >
> >
> > The commit msg said that QI_DONE is currently used for conflicting
> > purpose.
> >
> > Using QI_FREE keeps it only for signaling that a wait desc is completed=
.
> >
> > The key is that reclaim() should not change a desc's state before it's
> > consumed by the owner. Instead we always let the owner to change the
> > state and reclaim() only does scan and adjust the tracking fields then
> > such race condition disappears.
> >
> > In this example T2's slots are changed to QI_FREE by T2 after it comple=
tes
> > all the checks. Only at this point those slots can be reclaimed.
>=20
> The problem is that without the TO_BE_FREED state, the reclaim code would
> have no way of knowing which ones are to be reclaimed and which ones are
> currently free. Therefore, it cannot track free_cnt.
>=20
> The current reclaim code is not aware of owners nor how many to reclaim.
>=20
> If I make the following changes and run, free_cnt will keep going up and
> system cannot boot. Perhaps you meant another way?
>=20
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
> *iommu)
>   */
>  static inline void reclaim_free_desc(struct q_inval *qi)
>  {
> -       while (qi->desc_status[qi->free_tail] =3D=3D QI_TO_BE_FREED) {
> -               qi->desc_status[qi->free_tail] =3D QI_FREE;
> +       while (qi->desc_status[qi->free_tail] =3D=3D QI_FREE) {
>                 qi->free_tail =3D (qi->free_tail + 1) % QI_LENGTH;
>                 qi->free_cnt++;

Here miss a check to prevent reclaiming unused slots:

		if (qi->free_tail =3D=3D qi->free_head)
			break;

In the example flow reclaim_free_desc() in T1 will only reclaim slots
used by T1 as slots of T2 are either QI_IN_USE or QI_DONE. T2 slots
will be reclaimed when T2 calls reclaim_free_desc() after setting them
to QI_FREE, and reclaim will stop at qi->free_head.

If for some reason T2 completes earlier than T1. reclaim_free_desc()
in T2 does nothing as the first slot qi->free_tail belongs to T1 still
IN_USE. T2's slots will then wait until reclaim is triggered by T1 later.

>         }
> @@ -1466,10 +1465,10 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>          * The reclaim code can free descriptors from multiple submission=
s
>          * starting from the tail of the queue. When count =3D=3D 0, the
>          * status of the standalone wait descriptor at the tail of the qu=
eue
> -        * must be set to QI_TO_BE_FREED to allow the reclaim code to pro=
ceed.
> +        * must be set to QI_FREE to allow the reclaim code to proceed.
>          */
>         for (i =3D 0; i <=3D count; i++)
> -               qi->desc_status[(index + i) % QI_LENGTH] =3D QI_TO_BE_FRE=
ED;
> +               qi->desc_status[(index + i) % QI_LENGTH] =3D QI_FREE;
>=20
>         reclaim_free_desc(qi);
>         raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1ab39f9145f2..eaf015b4353b 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -382,8 +382,7 @@ enum {
>         QI_FREE,
>         QI_IN_USE,
>         QI_DONE,
> -       QI_ABORT,
> -       QI_TO_BE_FREED
> +       QI_ABORT
>  };
>=20
> Thanks,
>=20
> Jacob

