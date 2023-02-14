Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1B256A
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 05:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676353940; x=1707889940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qud8Da34lb48X1m5FDtYYJK0LMNwy2DMpr7wZ1yeuDI=;
  b=FCV61JFnzh6BRa6LHDktxLH6dLcbvCsduqFjLaw6iiglU8aoQspX+U/q
   pZbxf2myQDX0SOZQFR9PXcdolRdEXxnTODSdRXCBuV6/13nhsO3jGVucx
   4AETkzVIW6dxLZPVq8RtChcqGC4l0v9Ze44KVAcpc0PwvVmTjNPEMCWXq
   /PBT/2AtPgKgZx7tdTKA9ZjQxYo+SneVbulDyxZJTEnhkioDQXPkyBbn6
   /HO9XJnhURZ83bs8IHgzxfSMTq//IpZu6awTfpbpCeLXlfWc+Upv38bTH
   B6lLZBNpYVKECPE/Mx3nH33ls/vejc1e09mHgM2v82Yhlyd9wpctFf6Ex
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328790972"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328790972"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 21:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914616120"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914616120"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 21:51:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 21:51:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 21:51:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 21:51:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAsL2AvM20xnOOPTb6Jkr2U+MCA69Kg93X56+0+n+yet+5oO0MgVNihiaHmwMOfiiyLW5b/puxjOvUaX2n6D4c3rM2gJPFsoCl/OVPlYbiGfCPADBzn03SxpwdMcvyForBZg0we3kEFLKQXLT/kt69QTy8O5zIVJUgVIws532oHlejkxq6HQS+vknv79UDyRcDYwlDWXBwTkbF5NtBG+HkC37FOEjPeHh1XyIQCz7n6frWpFo8Tf107LclJ93kaPlotB0FdrV/cdls1k9hKh7OjFdX6TomUVRVucdoavV0173vcc+Nwc2gxAuB2hMMC+S+bdo12tyErLgGqJyNghWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzSl7pbEsWZn/pe7OsQ9AgLE3q6bVoJTSG6vjHaf0oc=;
 b=DGEb7Y9woxnlTAy9V8SaLudwZATHJ0Oq6q4p+PjSIcTyhGs6PISGYmeq/sK2C6GE9XZqAnkdr8zclpvsh2rtbBPMUz0rQDlaVLgoQqcKXvDvBCHHymP8fgVtKz7viT0kSlBd3xTFMFTOnwnzxVFaNKihUkUYKVT2ENwbjEoeCobT8UDvFzg1dIcszs2bNZ19340mauPsIJ4ihCRod80CFytIL3dMJCpS1R76RO9aDNq3uq8hd60+iy200jS89Kex7t6qzXqArXtEiIrDehVfQ7G67DXsVua1fnBF53TVIbosVAkf1MzzCsNE2j/BGSRy8DqEc3XyfdeSMYLJk23j2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:51:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:51:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 1/4] iommufd: Do not add the same hwpt to the
 ioas->hwpt_list twice
Thread-Topic: [PATCH 1/4] iommufd: Do not add the same hwpt to the
 ioas->hwpt_list twice
Thread-Index: AQHZP9Vw1cvK73P82kuHZI3iF7tx767N7kHA
Date: Tue, 14 Feb 2023 05:51:13 +0000
Message-ID: <BN9PR11MB527654AA7B3BE05FCD7A12108CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <1-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <1-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: 9bec8bef-8d75-4db2-8dbc-08db0e4f7b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzrsWYCrGgzcdeOfZUhGuGflj08imI9ceTlfDG2gEqWkggz4zLZXcj35QmMU8gjxfv3/tAVfwhyXYnKxGl9CdyJqz9b+JdxTwvZFaaX1D1T/4gBF90s+XxNn45Pl79OkjdcyVAQqu05MCVA8ZmwzlgGwNx5Z0H+LoXQ5/mKGSjf2rP7o9MduPKKWmJjkExKgIysZGuTZh3wrhJJeqhKvVoBKsFewb2JDdN6CYgZnvNEx/gJxTAb/j2P+xb5SObQGbGbfJyY80KjX97SZy/AOl5PJ+728LoaWHLeOZR1CgV8Lg9Nh17CcwbP4901ftlWJ4k/NtleewzYz0yYvn0p/XDCKTEhOf2Ls6b0KKQQFCSoKRpQTEBm/7sYwuGosyGWNLgDKaMQq8Tpkb0nuTzj9Y0hfhlSHm4qS8Tf4fFRfEPsMMSxJeWUMZvxux+tqSmnMlg/UjucpB9bHVr778ynHIvPlTMYH3T8KCqlAQN2pVIgm2EDjt1YPTypi/ca7EP35BcU/wL7KTPL1xiRRWjihintDyVqA3ph4YSgrgKm1bfpMmKggNPvlrq5bXPGLcKPuRG6mwb5+B0Vz9uE7HVLGECDC9CrKsmfEeHndM9XY/xJFcF0nG7pClb1Rxarl0rey+akzZdzQ9kPgl8QH2V6Rje9QO5D/s4rxLAn+/1iftJ4mVFoarQLO9KG5XtrcpcGwGEEWuSuvMJtoaTvhRap61w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(38070700005)(66446008)(41300700001)(316002)(54906003)(83380400001)(66946007)(64756008)(66476007)(52536014)(8936002)(5660300002)(66556008)(8676002)(478600001)(4326008)(110136005)(107886003)(76116006)(6506007)(186003)(26005)(7696005)(9686003)(33656002)(55016003)(86362001)(2906002)(82960400001)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zzBe3CarTthMzdH04lpFuOYCGxp6KJyoPzUSFNMJCeN2e0ybEUwbGTw5VvQh?=
 =?us-ascii?Q?n1y/PcHcRh4sPmErfToneL152Q5aHsvdjb/pWbkkw5EAiDfmrjiiTq8uNcOA?=
 =?us-ascii?Q?H/rAevr2cFD4uLLvCmczwZvqSxaijlGXBBi7d4i7Lh+xlAjB4rs4IbBwOi8i?=
 =?us-ascii?Q?hcHlCl8+4FnvwZ1LlU67OebWO9pLiyyUuKk2rwwzYas9nYi664UBnhNilx+s?=
 =?us-ascii?Q?3xqlCVLZpkaT25o9F47k4hs5z3F05eegk4w+NWLufhndM78K2A7+RUf4jU6S?=
 =?us-ascii?Q?iEwUJD6hxi5w+KfPLcFbvwvp2hGBgEDJodylUVTigGp86sSzhIWOTcbUjdSL?=
 =?us-ascii?Q?GYAYkgY+NRaKtLDCrMUynBEqtqxEiUcnfGvSKuWJxxT5KfTv+l6QKfjNIJNG?=
 =?us-ascii?Q?Iuh/q0tkZbxsaF3MWot4AsamdmoA7qGfX5Ys8hNI+SqO0pYrvETVllgxl0ON?=
 =?us-ascii?Q?xNH4dUoWDWCIFjpx8MglnirqZXY2cJ4w3UeqyJiDC7BmoD26orlJ+q2LJO/b?=
 =?us-ascii?Q?P/g8h1YjK/luL6jQMIb5Viy80qpYsP4124M6OxZKUUA0cU1xJru8kDqg3bnR?=
 =?us-ascii?Q?AjkmvaqtxMVzEs8DwwsViUzJyHiyCopT3MHC3v9GTuAHmQQ6Vhm8hOFVqkiR?=
 =?us-ascii?Q?Ix0OgDC0LLBMB12TbLaadWiDN8NeFLqEOoUA88Gd3r+1bwq9uv31tH9i9Ajx?=
 =?us-ascii?Q?jK7c+4cqjogH8tKI4aAG6eF9bVeqfQOGPctUYzw3rOVTyox0zvKIgVp7xsY7?=
 =?us-ascii?Q?XmbGroTvNiUuuDwYarwAa/DtaduyKckRY+Pls6NO4x8XOrlpnaDBR2rSwRte?=
 =?us-ascii?Q?bDrOGxY1VQ6CUoYfFUmPKjf8hZbDcYuWXUXutuoAI8RGiUR5ES25ODg2D/Ko?=
 =?us-ascii?Q?JqBUIC612nq9wlR1URY/Wdfd3ohNl1++nUnSvXJJBhXg18P9a0J+TlGm+cgY?=
 =?us-ascii?Q?cBnefOW+8k+v5W3k7EGFahCrXawHLh4yOQfoYWAVflH93YgQfYhCXfU5aoZr?=
 =?us-ascii?Q?P/fz3gvqSn2tvq0UgZ97s54czHue9MS2zxc6MxZiXGhWsedjuoAZGVflXwtZ?=
 =?us-ascii?Q?Dw/Bh9bVRYjgaReUxdiNp+0v0pjAjJuKNpp2moPiwhy3PcOAvuvezbiE+ear?=
 =?us-ascii?Q?1AXoDSGolEUC2c2Pn/aduuaB9dxJGq7sfYoi3tG1IjBB8eF6EGkp41lsfz31?=
 =?us-ascii?Q?sprNFnwbwRwD5WcvkWi/IQdsPHl/B+rs2YBn0l9D1BiMWZsJ4rqE8g9HMbl1?=
 =?us-ascii?Q?aEH3CzyxKliSXcsAf44qhhOQ43YJCBZc8iCCtWIWEk+tlUNsRiw1xFX0Kg4f?=
 =?us-ascii?Q?2cuRjkKccwAN7tqrQVA1Q7btUP6Cts+sv3FMDQgpiPOMAMjEEKKxAvy27d7w?=
 =?us-ascii?Q?EtsDEgqPOyEpumM32ZZB4Wz0f32k51oJIKyfk2eEKhxflAJuG57eK5I/eHRc?=
 =?us-ascii?Q?C6utZ2acOENHZDJHWzyEgp840HUrrdPQBNPNewZCTks2lFRgPuYozsM0Il51?=
 =?us-ascii?Q?Twf2uJbV6EplAw4gBWAvSrxyjB+rNx7YesDL7I+1ZsVviW/7zJKJKT0nJE7O?=
 =?us-ascii?Q?8tHr0mFJ+TdyynYz7rsAotWw9FIRWTUXmlcDpZer?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec8bef-8d75-4db2-8dbc-08db0e4f7b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 05:51:13.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uz5YTNyRKRMhfrsGpdgA/DyzuOyIPQ4BICQD+ebLACnjKr2fWW9dSWvU3mMURlMi6rk30lJ3nYUCkWKur8tNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 2:03 AM
>=20
> The hwpt is added to the hwpt_list only during its creation, it is never
> added again. This hunk is some missed leftover from rework. Adding it
> twice will corrupt the linked list in some cases.
>=20
> It effects HWPT specific attachment, which is something the test suite
> cannot cover until we can create a legitimate struct device with a
> non-system iommu "driver" (ie we need the bus removed from the iommu
> code)
>=20
> Cc: stable@vger.kernel.org
> Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> physical devices")
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

for stable kernels this kind of fixes an issue in a dead code path
where no uAPI for user to manually create hwpt or return the
hwpt id of auto domain to userspace.

from that angle do we still want a fix tag?

> ---
>  drivers/iommu/iommufd/device.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index 9f3b9674d72e81..a0c66f47a65ada 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -344,10 +344,6 @@ int iommufd_device_attach(struct iommufd_device
> *idev, u32 *pt_id)
>  		rc =3D iommufd_device_do_attach(idev, hwpt);
>  		if (rc)
>  			goto out_put_pt_obj;
> -
> -		mutex_lock(&hwpt->ioas->mutex);
> -		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> -		mutex_unlock(&hwpt->ioas->mutex);
>  		break;
>  	}
