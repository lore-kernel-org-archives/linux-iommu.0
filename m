Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24F2233A
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362349; cv=fail; b=WO0pNHR3/1GGS3sGp444pFpZZKFKNJJz9mu5KyHztllc0OzVnmcF0Ipfee05Jo7H8FjCZDUy3hygUQIA46UwJGaXdcsQ5ryzcQ3VuYvzipwpdq5XpF/6WrNsMhXNSLVpT3Qheo2w73toB8nLi1adMGB9TJ8bD2v6RrywXB644M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362349; c=relaxed/simple;
	bh=lT6AP0oL/THmUif2hC18unPgPbbq0KlNFZTeCO2rfpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVhuZU9+qRYxTJ23WDyShIGnAB/PGqhxc5h6+QTxQfQy/UY+xMQgn3uZ5PDUdyQX13t2kRX3rk1CYHgRoifzIZ+iTxg0/GyfOJ+qwwrwss1v6C3jifZQA8rt/vNHZ8vXbXBaVTX8yWrmcf3AT50mJnZjzCx8TTzVR2WZKoW2nu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhcfC6kv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhcfC6kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716362348; x=1747898348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lT6AP0oL/THmUif2hC18unPgPbbq0KlNFZTeCO2rfpo=;
  b=RhcfC6kvgXcfwvDtRSXWvfNHI8YVeT9N5wBkbD+IR3Edlo8gglvDfkbZ
   mVNmm9VGK2aE9kv4kAvTyqGWt/w+3ujrJQzXreMnX+ViDEM5Qr0NJxOjg
   v6GW78mmobX+WNv800t2c6xIvFo8+YTeyb5ztGB6MEyVu736wmeVNZdM4
   ke2o7Cy4E9cHStFdQ0n4E3loUS6JkTa7HVIkxuiehZeI+2RHX/rY2vc1i
   FmOGpoZjNzk1T+zWTLl1hhM3Gw5B/rQ2yDefECTaDQjpPItmsHLfDGCyX
   Ej6p6wVkRlc6P+h7uLt+Z4/b8yRDy0cFWnyopjDHud10Ya3+8gAqkwLjD
   Q==;
X-CSE-ConnectionGUID: enGL+ZclSgCpeKgkYszFxw==
X-CSE-MsgGUID: j9VASEGMSxufpAykXy91Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12466586"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12466586"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:19:07 -0700
X-CSE-ConnectionGUID: xOF590P2RpKM8iEyoRx2CA==
X-CSE-MsgGUID: JMBSEpDKRCGG41JHHyumLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37777054"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 00:19:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:19:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 00:19:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 00:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU3hiSFcPW7fgiWZ5pPke8I5jXLC0gtDAlMCN4ZT5E49tD3MSJ775eYL8P2r0BW+BcgLEZ9kQG3rrW+qNe1vJj2Tt+FjPVTHSU8JLnjospvqwCvqQDq+roZXhBPdrtPjzpjTa/je1EZPMiob08wX/pPaGml93oQieMFjgagTwyVGqb9yGNNJLC64T9G6iGhR5W0fYzfn4OaRBCJ8VZPw0/grcdMOPwjfwYsYSgvugGy4RmokNXXf3CkRErDEarP/cwqqpJo71doAwNKJtIhio2ctf13EZLgkoWvdVoRPLB1tQ6iCn+fohw85y/qklWKdZDV1Y9afLm0cQadK7Nq5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0EsCmaGPvHzkkPRQ+8++kbhBKH3W/egbP0Q0Wcx/9Q=;
 b=dTnFd6DlWq06ES3Jzb5YJB/D9l6k7uvWWz5sS4kTLSmdMcr1pmO8da+cIRv7E/n0Dr5yno2jj65pJm6cmenpimhkGy6zMZjD316xPl4mJ6FPhUdav55gj6ryqimPse3IHZ5ykB/C0DCnzShechR6D3wS7Khzath10N36hfenKM/hjCydczdzASeRy1N/c46ecYpAr9od+6KDM3CpcY4GKHk43GomgqW8f0UroFjMLONE9NtDavaAgG57dmn+D9/ch3p0OCL/A51eOkctwY8275gPw0qSBHWhlqkMoe8ifwcq3i4JbOqt11XDL2QptV06tx+P+5Qm/PGsGU4wOGhlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 07:19:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:19:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "jiangkunkun@huawei.com"
	<jiangkunkun@huawei.com>, "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Topic: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Index: AQHamwTKQCCGF9LrS0KLHSsE2DcDKbGTlDyAgA9mKFA=
Date: Wed, 22 May 2024 07:19:05 +0000
Message-ID: <BN9PR11MB52764A677C40BE74610444D38CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
 <ZkCxTWbkK0Domuwr@nvidia.com>
In-Reply-To: <ZkCxTWbkK0Domuwr@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: e749d799-10ba-47dd-b161-08dc7a2f76ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?JCJk5AJne/Ecjl6rTGGRdnmUJKkHEofWFcwPI97AXcfMnYKoG3p1w3nrRth1?=
 =?us-ascii?Q?/RjW3pI5IezHS/E6pD5gd7KEkJmcpDON5mGf0E/rLY9nOzpkQulLujEVzSXM?=
 =?us-ascii?Q?DnYDo2G5i+c67SVKDZV7SMxxTmhtqHhOlamTCNQ+yIAVeLfmZ+Yht0Lj6uD5?=
 =?us-ascii?Q?0Ho8/7JWhUVhatVk1fRAfnvWX078wy/STEl8tboh9e2TQ2+aaY2FOhbehxkp?=
 =?us-ascii?Q?HYotlr9GDY7TRPXHA03d1TZVlINEKnJV7CZEpBDs+qY+MEAJ+OrGtv4FMcH8?=
 =?us-ascii?Q?CQfzRUGscaiVGEEwxNZjyVKo+5IFw5MIZNgP8exHyprKBH24OyJSOMPQx/lR?=
 =?us-ascii?Q?lT3NEhl1IcfhKmCN2qonFlE5Ozm3+pqJdfCa//IM9Cp3GT8rgxEnrPAXx3aj?=
 =?us-ascii?Q?0/d6oJibIS5dt5gW53/OiqA7U/cdxPxIILI/DcDgiTr2Xe3Hk33EI9ElriRm?=
 =?us-ascii?Q?BghuUSbG513UxZpUnJMGcLySbYK1Z2Oh4sP2itM2XvEjQe2HzTIpLKKfao0Q?=
 =?us-ascii?Q?Tbw0e6MinJiGE66uPcOb6wt3SWAcUiQ9XDxgCMJrmrC+3FSQ/l5hJ35SEk+o?=
 =?us-ascii?Q?VE+V9LDTzT5GUz3tyJtPqYBHPKXz0cBEiHmRv9WMr9Tyj7lfHDfEeY4867bB?=
 =?us-ascii?Q?Dbi3BBCNmgC1Hx/tB2sTjT/zc6Ad9ilxO8t1jghAoNPJxvw/5JGTcgrM0nfE?=
 =?us-ascii?Q?ocbvW6IF/I8Bm55TkusgnHsJzgWjJN3s8LGSuDP5SvwAxgeyMBcrAA3KvLHU?=
 =?us-ascii?Q?m+ueLzljdfswQFdftl6TxTh8t1AhULYKmIBrswa/e+wLzgHD5BCjpS8Ehhsr?=
 =?us-ascii?Q?FZ3FtyDfjgCKcHFbqQ3jv6G5L71Qvzx8sEXaoJ+aSFzNGWCnwtNsPDIl8qu3?=
 =?us-ascii?Q?wTdUg600WPbtQlVAj99NdcihuOVA525+W50GqlnUslsQ88WwvoJyo08OU/oY?=
 =?us-ascii?Q?b1r9UnnP/3jfQkxjRBBEW2KFuitN6Zn8zdkAoqi2oBjryOPnLqenjw/qLecx?=
 =?us-ascii?Q?UrnG7o5CGS1ampRjcYWYCt+xDQ68MfWR+wJFQZPEJWUfltuj/Z7fwv+FvXP1?=
 =?us-ascii?Q?oYl9/fXbwTWO1kc+gmUQgq2NA+Sc073gnUqv8CB00A8b/f4QMWlV0TH70Zl9?=
 =?us-ascii?Q?cnuLFokXl1wz0O6zeycYqAlrONBx3Ol0AYbjVOt50MjOHdGVY1bktqYBeu2A?=
 =?us-ascii?Q?9MQje/tkByJVzJ94VhZOLH5XtJptTx8AItS0b0qZm7QtyHzMp4J3qeZkR7zz?=
 =?us-ascii?Q?BaNG6Uarsxs9YTb7jvKSQCRbAz0OaMxwQwVNjMI9vuW0fdefx4l8+s+08Sam?=
 =?us-ascii?Q?TFnAA1lsMa7R/xvLhGLcxbRws7v+u6cmDalSkx+sxI+MMw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgmjcoHDgFFBv7dg/hi94DOZseJRMkW2GE3IyzSBWNLMbA4K/QnB9EjDI0IN?=
 =?us-ascii?Q?bXxaOkUQSCPWt2ma0FLnWWrBpTAhjjNzkAjmL7Qhibp0WFCncN/caxOEwrtc?=
 =?us-ascii?Q?rayB6yqA17D3QC4uV6eZYwPqpIMVSfelfOQElK0LXcQ8owsRsrc0a7P28BEj?=
 =?us-ascii?Q?Pb8XZDVTcd6wa1D3oppT5XJlRhfIuZkEgYgVehsoucS6fKeinAhDWW86KE5j?=
 =?us-ascii?Q?m3cCIjiQBExYTPPd4sX3WS2amTGJ0EJgbwaZUK+ph+apHMVKos11oW9MKvTv?=
 =?us-ascii?Q?z6hOkHGl7cUhrU62hXUAulnIE3tIM5jM5aVRStEmoNmKe5Z8lxrlQFeLvPj3?=
 =?us-ascii?Q?Se4H+DSp1H7yMUo4I9WbIwoPLgcX10k8WFHdAFd08UptEIAoR2O/1Sc4aJ1L?=
 =?us-ascii?Q?1Vny7dK9VkMpMBdEOiH6ETFdWPpka+Jc4WpYo0xMKRJuJoqdGtd8Zprns2LS?=
 =?us-ascii?Q?OdudtcbUttEtF2+RKSW+7jrzgHjdih//40wtqYirazx1OPwb5aa5HsT9Htk/?=
 =?us-ascii?Q?duRGkjMb1Jm40KODhayTa0yfXcPe0Paf/rcnrjlOv6Q1rYRztzvKNi+YeH2F?=
 =?us-ascii?Q?jMuQQNYJJhO7oK5jVphzk8oKLeNmJU4APDnvon5M+7e/2KXO++ZoEjqQM+NB?=
 =?us-ascii?Q?fW9248j8M/nl/zoDqznEeawxZ5Y82kwg25Kztpyi7zucIOOojkEipcZg9Dxe?=
 =?us-ascii?Q?P6BQcJZvVX8ewSftxWA/sh960QPULsB0BIM5kMNgmdd+3ixj+08fddKkGPK8?=
 =?us-ascii?Q?/9Mmc8aKLZjAVi/U/l8JS3nOuunrfwrmpXOlmpQ/8NQ1YaQBB0F0LGnL2rPW?=
 =?us-ascii?Q?NH9QrGRyCW3DAu9bFW/3OIcNHZ4+lbFl+3XtmmQtf9LLAl/GX6MPOzGlt/L8?=
 =?us-ascii?Q?FVGX9XFscKjt3TzQP4uFU5H4tLxDVcHfwK8GmPz8MC+jaMFdL1VzlxrRhgFW?=
 =?us-ascii?Q?niw3ffS9Fx/a2quH4YV1BJI5hosPIsI/bWWAsXtwFzLqHwkxY6xq/EWso8hw?=
 =?us-ascii?Q?ROuU41vTjJPZvGt517KQVJYW9hcBXiW0N+HtndPR/MQ4Nr4ken8y5EucarlY?=
 =?us-ascii?Q?YH7dTfNcbztrpm+BhVEMJRldKpiNR6toGiV23L8b6o85+kEObqKYh1V4oY2n?=
 =?us-ascii?Q?qb2P3Ev4BebChpgRetucQj3NhgeR2MNhyH5mxLfFyVTZSkKq4iERlWUKOexa?=
 =?us-ascii?Q?bEDM661sP97kGF7DT9RHJfTWs+ztRWhmNUV8rF4BDCIdOWhw4fVPm1asbfng?=
 =?us-ascii?Q?Dp33cRa8FBJeZPX07FeSBXDN+XEOe6ghcdxIoiAzaZ093cBRHQlcvzkDxYff?=
 =?us-ascii?Q?1KYCGhAmFg0+6Q5HRu+7ZYF53tFYb1vz7nPVblvql1Lh0E++WOkXlgUI/sVo?=
 =?us-ascii?Q?bWcD9BbvYcnZoVI2SLm6AkLthy5da4BGT7sOuSlvqdMHI+1GN8+RuW3nGjjG?=
 =?us-ascii?Q?y/i7p3nH+0F2Z4btyMkBygR/OU5WuBHfNFq/F5xgblzSUJZt7amMdJStoHPS?=
 =?us-ascii?Q?Av07JtpJaowW+Fol5jnhJkdUV9paKhUxPAMiEf6VNnzXO3IVFrjV9hgNmEwO?=
 =?us-ascii?Q?c4vEH4r3zwwQOEeXPLl/9miD0vy0RBbhgHI3TTBd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e749d799-10ba-47dd-b161-08dc7a2f76ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:19:05.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+KjXfpOeysxooBDLRaAH3r3Qx4DcjfgcrYcxrru2SuJbxUtEoRMAjPC68lDs1MdGg1tkeFOR7s4A6ilqsPdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Sunday, May 12, 2024 8:09 PM
>=20
> On Tue, Apr 30, 2024 at 02:43:08PM +0100, Shameer Kolothum wrote:
>=20
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-
> arm.c
> > index da6cc52859ba..20ac0e833c7b 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -433,6 +433,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data,
> >  		pte =3D ARM_LPAE_PTE_nG;
> >  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> >  			pte |=3D ARM_LPAE_PTE_AP_RDONLY;
> > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> > +			pte |=3D ARM_LPAE_PTE_AP_WRITABLE_CLEAN;
>=20
> This seems a bit suboptimal, it means the HTTU will be generating
> dirty's before the tracking is turned on. As I understand it if the
> SMMU wants to write a dirty bit it has to do an atomic RMW to memory,
> so this would be a drag on baseline performance?
>=20
> Should this start out as dirty and let the enable flow clean it to
> turn it on?
>=20

this appears to be good for other vendors too?
