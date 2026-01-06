Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71431AAA3
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685919; cv=fail; b=VtWd0kT8LDUj0COzQOz+a0X+soEhvM2Apr1QAgofQ6c1WobLLz00kLVVLPA4glxo/vo/LqaVQCn6NRcQuzuOhJaybFr3EK3zliEu9cZvydFgSnDO/bQhNiYz8eSEofpkfWySluqgAOU8VVUkdETFkl01lYff2SoFH/lJzyALYws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685919; c=relaxed/simple;
	bh=2nWZ0Y5e4v57sh5rCVAGpV9VdpCoh90FOCp7mlDb8fI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=amks9uLZ3sXtHdNCTKcLLl4fBsicRJJvlvlZczTAGUr4otlP1LDyWMTWqxHDawbfclYl+U34kMmRoe9FmOj843sqqybFhr0DHquyExopZ2BzC1bKqcI/hAOAuq7dmkP38wTkbg7QXiZw4sssl4r/8aOBXZ6ZLRBRw3rGTYjZS5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuhEKcOL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuhEKcOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767685918; x=1799221918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2nWZ0Y5e4v57sh5rCVAGpV9VdpCoh90FOCp7mlDb8fI=;
  b=TuhEKcOLfPRgp6DeqHK/zBinaq4pUiYI6EAxNt8MTCx6LkfwdL2ZDDBn
   nGdQRTQxqgwie9RKRz+NyLnE04lShjiJrhpclxzD1DRSUhnVnrDlwuabP
   vUD0SH4QTKlCvLBqXigBhSHh5x/fsk6XOeUUHDywXV5wfrYDLogwCVvwA
   kba+RmC/4BH428+KGug6tsKAO+2ukcXgWz5qf/Tfo1PWNndb6o/AsLlFM
   XUkR3yroymHkIzXtbJLLoVOnpuWY3isOeuwG5Y65f7zt6HPufa2RLBwGB
   AhVkwMuWMnUE/2NPlbaUfqtsC/d+BJUdnCMrltiCEgFHjkzj6eAto/8Fb
   g==;
X-CSE-ConnectionGUID: Ts73dnjmTjWr+PG7O8dWUQ==
X-CSE-MsgGUID: 5Xyj4kgpQn2K9pXpXMi5qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69210600"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69210600"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:51:58 -0800
X-CSE-ConnectionGUID: 9PgdkTfiTam1kOYX7bb0zg==
X-CSE-MsgGUID: PzoF5ixiTYq7o/Pq68QHqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207150276"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:51:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:51:57 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 23:51:57 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocxiro2hrUuuJrWZAMrSwxqJaQVR1G/MaPFN+RMQzRGIHN0SvqSTtlxWokEsLbOT8kFMXrMTDkh+Fa/9wpJwfFuPVxZXDRha0RoyWZfFlYSHgaKWeTYMC7dd4JDDJK/T5z3H3u1qNpHzOHRW7K3UmQ1mfs4TzwQGiqwN6dpari1s/IajJ9I7/r1OPWrAtjR8QSdDzCi2sAcmw6vIKJZp5OEenItFfO8OPo2YeI7b8ZrM3V7G51cw7lhvBXopmZzSuGnL0DDTF98fnur0c83qgOuUyYJ8ooLuKFBSOUY7itswhhcTt4+XJ/AArzny1EGl8APwzXqAT08LGzVCM6ulwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nWZ0Y5e4v57sh5rCVAGpV9VdpCoh90FOCp7mlDb8fI=;
 b=VLXS97EX4nQVIul3KR9abI7a/hUrpTOY0TR4QBBUfyxOFfqFY721lSR2TbiMqp7e0fDnyvAPrHPPNJ+/nK/QqSwnjoLrj+3xkuFLm5KtQAP43137nOVkHpyurfVNrcBFcLbC2m7k5vhJghhOPK5wddMmpONq+UgRlNixIPhW/iSuJfXsCAbzoWfuIvX5YPbxc5z5FVzYo3fGWb9uPqTGoCiXVPrULajsylQk069cobdFPvFcdGfP7SA2QIMprjxYdcLWAeBaUCL/QjsQE+SbTJcpmr+O1e/bQCYonlRh+gbt5xxLf9ysst2tbrN2yXjcNcB4w8wRzl7CPQY7/l40Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:51:55 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 07:51:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Dmytro Maluka <dmaluka@chromium.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>, "Dong, Chuanxiao"
	<chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: Flush cache for PASID table before using
 it
Thread-Topic: [PATCH v2] iommu/vt-d: Flush cache for PASID table before using
 it
Thread-Index: AQHccnZNdGyYjcKnjEm2cpA3s2nFyrVE3Vdg
Date: Tue, 6 Jan 2026 07:51:54 +0000
Message-ID: <BL1PR11MB52717592825AF5F237B71C9B8C87A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20251221123508.37495-1-dmaluka@chromium.org>
In-Reply-To: <20251221123508.37495-1-dmaluka@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH0PR11MB5832:EE_
x-ms-office365-filtering-correlation-id: 1de790b8-8459-476f-b8bc-08de4cf87621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vWkaV+rK3mTFNEPGc9L2kRD2mmNouufHCAHFoQRPqUPDxtwT9zEL0ks2qLr6?=
 =?us-ascii?Q?YWEoUftuM2EzDEvLg3n1Vetmgj1zdvIXwEH4ImfEo1XMcA71PBq7fO2+qVsD?=
 =?us-ascii?Q?FKVD1RZ25/UrPy+V3RxIKi9dsD75swt4frqSMnrz+JDyPupNyIjr/ZSwAQrO?=
 =?us-ascii?Q?vnIpOJbmMYJw38lGwbbaF7VXHN7TqjwPrhLsXAZL7Hx4IZnLHPr0TfPv5B9+?=
 =?us-ascii?Q?krSKIaV+4TxTERSINywEgX/jReopWrkx8ERe/ujIIYzJ2f2T41q7MC648pYF?=
 =?us-ascii?Q?2OaPZG4EHeF/61MD+VFwNNc2BS2QJDktxWrNmQXgnk6CA5aWeN2ClujhqVmP?=
 =?us-ascii?Q?GM//7UqcvHNBeQ/U1k2KiplpTXg7L8p5IkKrJpaEgbCJ/gRoKas+Z3Cj5zxd?=
 =?us-ascii?Q?MKlXnntU0cEXPvDGTSSlEtJtGIVC6pwwXBGMDQz/SdfXXBz9Oh31+ipPyhtv?=
 =?us-ascii?Q?YJAEJomNgKsR4sCYrirdWWWgfu1CQWYVnxJDh8D8nlMAkCKOJkpPJTmwEgLj?=
 =?us-ascii?Q?5XJrwlIUEbfYe/qPq2hPhMFNmK6BQi8PZz90JuIgWtYKNfKjf7t++o7blH3q?=
 =?us-ascii?Q?O3pqI/iVuOP6RHy0u4NThMXKuiIOGxRCIJB+HJ5JnP19UF4m5aovc+Li3IKF?=
 =?us-ascii?Q?qw98tru6L4EDKprb3Fpi2SpY3h2DvJtaBrCy31+I2Jimx9EhCF/ejsKB0PnS?=
 =?us-ascii?Q?lCGVz5V32gAkCtw+kln4SMc86+ZILJkwQU4Y1AWu/gbcQo6Dky0Lr5GESEb5?=
 =?us-ascii?Q?1/owAK0mW2W0b4CilgxaYAR+MuNhRL5N3zuFe6mRKB0v/Jdw7gmC0vTqmwXS?=
 =?us-ascii?Q?8kafej4QRq0RLDTBrQ1MwXqA0F4mPYf8LHgE4CgqWBa1jcJD8GjJDL1C34az?=
 =?us-ascii?Q?vhWXgLWDhVHnH9IRyKA8w1H7VsQYs5J4tN4aNRmjTRy8sTX0IH6p8+Uug7Nr?=
 =?us-ascii?Q?YAMSd/1jeNYjJZbvhSEHKl295kcIIJ3IdplW1N7hQb3eSslf2rWZCoReI0sn?=
 =?us-ascii?Q?PLp5SoVDhBEMICcpdrXLHJYnkmGomPr8J27rMlg244n1OO8B64+yq4/2vnPY?=
 =?us-ascii?Q?rWVVkDNeZbqPw9QBi+1UOx1xz2ZRMgRVp0293eS2qUzO/8W/Es+jxOmAxygL?=
 =?us-ascii?Q?y1dSq12x3Y8Pg1lkIljMLGr9DlpeBEzhJkjT/J2CESi3g4u/jBSezee+Wu7J?=
 =?us-ascii?Q?OY8FPHUV4cHqBKhYn3mG1iQZYV+HXEb9fOsEwPnCOi2MxsHpYGhLQnJ0JgrT?=
 =?us-ascii?Q?ZJ40leRdVWvrv8ucLUxQxGVdo75x7+7nsB3gbVmkqccoEZfb5gGEE3tXewcZ?=
 =?us-ascii?Q?hDMIgqfBsz5p646mMuFYeR0kkNtaA29QE+yoUWx0YUVnTEDK44ls5Jjc+UB/?=
 =?us-ascii?Q?58uiZ7/4AOAbDqROWmuVc8yUZexrSS7qI+tZjAVM7i2+CtCj2u92ACsXExxK?=
 =?us-ascii?Q?Rg6/4tYxEZgg1qEyGe6o3hMx/3hPKyIdt8ORcpksmuS6oVBY0gH/wHVauI9H?=
 =?us-ascii?Q?Fg8AFzx/hu3+yBk6ebm+XmZNkhsVaU1TG+Nc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GFYivd1CoZOwImN3P/tIbxYoq44uA1/E7GWSTq4B3G7cZ/C6xjTH17QZNHSG?=
 =?us-ascii?Q?npGKd1cxzU+0DCwwlutRLh6w1CrThxZXsdwWoarCtLM8zgZPIoA+rmLCaBK7?=
 =?us-ascii?Q?YvXsEdYyMDjBWYueNfZqc8zB+JELMQls8x6LtpvyQwa1I3RMAO+wa0oO+Ngg?=
 =?us-ascii?Q?GjmKAQFZCd737ET+FQi5+LtPxmMJBQD8vPdnotqyEJ/n9/w53Nd7bymeQMrP?=
 =?us-ascii?Q?m6dNHq4nNiLUaL2jglvCIqIazpE8MAQZXzP4DbJuDM8nV4IXLMP/o9K5Z9XN?=
 =?us-ascii?Q?TNdmZrz5vOcD6d8yFJNotAG5Sn302exd5erwA1BR6OXU0NTDceDQET4nRWEg?=
 =?us-ascii?Q?Cnw2DXUdAWhYL6WMFJb84x8mTNjQaKjqi/50EWTeBUZvJKFgZEGzumkZiy3s?=
 =?us-ascii?Q?tE1cBgnu8c+KD7fiX/5a1WwHf92ksYdDWx6L7NQZdCd4fJwxDssrQCV/QPmm?=
 =?us-ascii?Q?HNFKE+UVDTFJZ8v5AvSBJM5tDfsfOg+o7wSU9o812Qb2/AKfU5/Mvg5TBPNu?=
 =?us-ascii?Q?+LdxYfAPVEPjOc0V4Gu9WUEShNlEuDykHHnoibwLeiBS4nVwTIdNZSF5pV2o?=
 =?us-ascii?Q?zyaVLRn/BPZsJ+8v8BRcjlYPx1GqAzOGLUcOZDc6Tn/j3mmUn3YizhfLo2Va?=
 =?us-ascii?Q?ovNqhbDorH/z5u09c8MEYFBvUvArh5rqO/8cv4i+5wnmZ5ZJc2UJ7j01XW+s?=
 =?us-ascii?Q?hSZg6jhqL+UNueyVTfJALBrVf9WAFCeixh0gMxCB3Ukr04jq0gFHol+InFH0?=
 =?us-ascii?Q?/skfQ+r2pHVe6KkcuxNz87ENk3VxNDPldXybgbBbRYfdbcTKKmRi2Uimo04x?=
 =?us-ascii?Q?05ISVTA9tBT03o9UEfyahPrmWdZH1V2zbiFpGUTdq+/FkzgjAcxhFyLnFujH?=
 =?us-ascii?Q?Ek/JfsFLVHZtBbG6hR8CRcXHerOaC5JrbeMalSipSTNlm6CO0rxVdDniY/+X?=
 =?us-ascii?Q?Vep/X8mD73uuZYW1FS53vcyJLh3WpYjqKiNJA5iYxOcCHn56fXmQgvIn+vXF?=
 =?us-ascii?Q?JkE8vYrbxtMDFr/6hkK+whf7qKSaGpWr27kiAWRaTwP/JCV1mg3QJMsrRJmv?=
 =?us-ascii?Q?BvkFwA9bFPpcIzW6fL/p8N89mouxHIAA3bamoyqS55J/jwdsZEnTotBg1Tak?=
 =?us-ascii?Q?nUrAiED3+AKIwYpbCEIx9qs8BHPUYL9kdoDmVOZD+tvO7kQUvSuR03kOXkrq?=
 =?us-ascii?Q?UWHF8y7I0pC5eRzOLmGzET4/YujKKAmTXHEFluFeZXtaQtfRD6wzfZLUbBbS?=
 =?us-ascii?Q?ZVao+BKhaWxCwayzlqy/ExV7hJZ3Ider+FdklUvv/I2ylNdxjc7deT/pIzIw?=
 =?us-ascii?Q?P5PIyanH31eC8ZhYouw2SZlHFJFKAtNaIHsdGXX9nUy0qbf2hnlm8qh+U0Hl?=
 =?us-ascii?Q?O8VbUbr/gxXyfQ6lR9sPdP/xtRMWtpFc942+6kQpNrG4IMkszsbN8dky+cjN?=
 =?us-ascii?Q?Wne81SfEWPtv1opzcJbvR8w2GFqh9pbTPIzXnWF49iC3QTp5dbVUkLEd9BXJ?=
 =?us-ascii?Q?3l4ynow7CWShHQQiCult7Z4HlkxNJgt5QHL2xuhCqZQiHRUo2NAoPjRtrbER?=
 =?us-ascii?Q?xKOaa4CZFH482YqcossyY4MwkBVmDDqGj4BNKjvwnxhUJN3Qs6vlym4tLIs9?=
 =?us-ascii?Q?o7fvsOTezfMyrysFwhj30dndErvAunL+I6kIzg3KxmcJUIhM/fJDEUzNooNR?=
 =?us-ascii?Q?NROql7fnutVUUuOCpQCu29To2dHmjdV3zeKEb8r77NUCyXUeXSgZ3BBPIZ8U?=
 =?us-ascii?Q?ata/EbYyIA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de790b8-8459-476f-b8bc-08de4cf87621
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:51:54.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr5PpR86KbSE0RqMsNvIaFfWpEqe9xMfApH0YUIc/DlkRozGDH8G/WEi0SC1m/17fJbudH8NvRpw4hCh8LakxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

> From: Dmytro Maluka <dmaluka@chromium.org>
> Sent: Sunday, December 21, 2025 8:35 PM
>=20
> When writing the address of a freshly allocated zero-initialized PASID
> table to a PASID directory entry, do that after the CPU cache flush for
> this PASID table, not before it, to avoid the time window when this
> PASID table may be already used by non-coherent IOMMU hardware while
> its contents in RAM is still some random old data, not zero-initialized.
>=20
> v1 -> v2:
> Add Fixes: tag.
>=20
> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
> Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
