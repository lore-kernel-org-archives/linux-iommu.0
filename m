Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B443CCFA5
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421054; cv=fail; b=qzPLrPGyqaovFRVYwWmSnIOmV8sWEwSfX+4f+xhAXuieNtmqeAJMYLJOvuAU0qpPac6Ug+gpyvplpc2xI/QqYivSEwMO1FQlt/OtgT1SfcCgYjvdSQWrrUkDfNSoRs2txnzFesXK2UdFSApCwteW8+NxoOmrjlnPWq8jU31jglA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421054; c=relaxed/simple;
	bh=wrI9F61xsH9sFDO4K9S+pl84QjDom0i/xIUArvvrlxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpYzVZwQLUsny3REi7jmV0S0mEo8I/uyC1k3sRMptW4KOGSLt7Jhd/Bz0KWhM3I8lBcoy90WvpZdfIn8DxE9yrRBjOvAaUztpa8ae3iiRB3gU9W4nBP7UcWNstpg0X/GB9bMW5kvI/lajGp6e454ripdxoF4jSGMki1fW6gGmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmjPzM+r; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmjPzM+r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re47kpIortokscXRYSpMKN6Vk7A3mRVVZVTmIXKlJYW/AwpqulY7WwKh+aaE/2EXUUEuI93HlcZ9fUnYvcGOe5FihmZttAz+mBpWiUcy8y/kvhVKokNLTNPC6hJwyOgcHX64gCnIK9uhktnqLhfuS3FzQIgmFlrkhZEjfoXWd1Ur0ZnYuPp8G6O+EKJP3oY1bVegzb+FNk4ITkyj0mwODqKtu7y4EWGJVOY+g3wzoAaQ/IESZuhhQzNUfsUWF09c7HEbWQhssIuF+Zoforu2jGUKtTrBFudPy2U1C+ZF2PNqsglgkplqI+W7dee8SbO2vyBBoOr3xd9pJVHu/35Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hkuvx2qdHG+tY6MK+r2/8urvSXH/e+NQ+S3C+G9eFQ=;
 b=Dapnfp9J3c09wZPp0Joa5sPd5pn9JMDoXYzqzjL9htNvi6kSVHE0g4Y0NgESwIXaAY1q9YNr+cUr7k2CHRDBlCZNe1jBOiF7+9OoJqXetMzGxgoR9LQnkPE14AyqJ+nEkyT0bsfDJQNAZJ1B4sAjRKeRbzynz2HdS2DmKsK9tSUFaCHzNT6w3/IjPNqaDrCVWHDdYINZxEtHOjYVxqMRfj+aJeDccnVvvCcCgW73mqyLRWJCdqDBg/fdadvccc5OLC7pHPKkDVbL0xxAyZ7FWT32HDQl7Jkm8tN8hKTxwO9qJXJbyHBKwsMeOjusYeMhd4e3FebBxNgrSP7S0GttZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hkuvx2qdHG+tY6MK+r2/8urvSXH/e+NQ+S3C+G9eFQ=;
 b=JmjPzM+rItCdH+/sSuXXJqeD48TIIi28Tff0k0aq6ujVOcXar37VHzVQmJPvJ4rW9s8bUPg7RT6T2js2Xkkl3GwqrEHRKDgCc1GXfga/bLqKX4UDNiPDrOezfXDZnHtbrCA4otVW9v57fcW3tkBxwUnjUvaE1nqXYYnAV2p+cNuQl+6aTeXG9mHt1LuyKzRb3yDsY9EZ3u947PsPsuBQ48pO0v4Dq6ay5p0q9zsfkAK03X5oObQhV+UeQIfmHWFItSd483+Em9vKOCH8q/2L2WC8ejQmDuwblldpYLhyWXqlDboUbDuFNRPl8XVV8zQwsnDSGWZJe5aLF7JU0z/Raw==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 16:57:26 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:57:26 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Thread-Topic: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Thread-Index: AQHcqx9be6WJSAc58UaxQUHIsNyNOLWsvNqAgAABWuA=
Date: Fri, 13 Mar 2026 16:57:26 +0000
Message-ID:
 <IA0PR12MB7555081D57CC9A7663191142AB45A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-3-skolothumtho@nvidia.com>
 <20260313165051.GG1704121@ziepe.ca>
In-Reply-To: <20260313165051.GG1704121@ziepe.ca>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SN7PR12MB6864:EE_
x-ms-office365-filtering-correlation-id: 88c9ea38-aee6-4e80-7086-08de81219a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 2OYa3xeY0qwTP7u/6v62D2tEsYhmdQxm/0N07jrRoFnvYxHKr0wRJNHXqd9e+B0WahVJObrd0c+RiTgyzIPC35EoTnvCkEHKsX6pmwCiD3jxmcZWG16gBfELFCeSv8ljqBN4I7NwisIdg1LzOU8udBSPLFaY5u7WVWBgLAl/0h/ipdn1eLxGzMT9VopMrWuHl+eRn6KQ3qn43culWPxZq8TkIircQB680H8SqzsltYTNGpQJYe+1Y7opZ7pajNRBb90Dlx1y7jsqGDCYQrTk6bufsPo4xS6ll6Pue5pKmZSDboRd+fNoICwskeASz1JQcfGUgDULLTKegwQF0QZPVbMkwjo9tZ1rXeTqk2o1oRz6W7hHsrng23Mne6niFwi/E+WwQuwios0pmlTudzQ+daG8IlSzMwMCI5yYpYwVgevWzoJRzAXCs8CO29j9YXoGkpgGkFg0eNwdpnWVfgsMMlrVcim3hM+SphVTkSP80yoB1Ub+tu1DyTMM9r5NqCazYsxVxIydT+ZbjNfvw2AEHmVMDnIJx3UMiajVlbhDaNkc3kpPPK6u4JU+gdIwH1/xgsbRWOAcHoqLOmPT5xIuF3uZaySrb7ZTR4ThqFgBEVk3nKQHXPDFgp3qZ9Sac7NhxjgoKuvd3ClihnUzB5DQi42nFtBlyQeM9c4y0/diru9VLrgb8uWaW5H/I3jinAD8zPuQAiylIxn40ROa2SKET3CiNZ8BoFJqck6/mNE9Lwy+i3M4IYuyE2HtI4Dm03zhRkN0aXjuepTy9gxym2KsZNC/I0kKJGs3WTvye2CKFgs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VuKKHOaWP9iDFxst7Cy/nGzUQQPvZW6pJXmc57GP/4Bi/NAPCs0gBUFRhYrY?=
 =?us-ascii?Q?IXvoDeELdLJa2ZOVL17oUEgJHtMVR7aeGOeFVjPyBKt53iB7uoCr7IfCdHZc?=
 =?us-ascii?Q?cHl9yXQM4hW/tT8Puw8YIZ/9FjtZ8fSmiaWa7Zon2Y4zMDAp+TkawI6EOqJc?=
 =?us-ascii?Q?N9NIn51ssHoMzIBxT3BRNIB52iGVOfyAgSfKkQLrhCyK7a6RqXeJYPImd11R?=
 =?us-ascii?Q?jPNEZ3aVkIlPgsm3N1u/WpP1mvYjSv9UmiGRbjKCRLHhQLUgIwggqB4tPqeC?=
 =?us-ascii?Q?yq147FkcFtv+H3KNHW9C5bsc+stZkqlE+7hYQDVz4nSFnkJq7W5H2OsgJ+7W?=
 =?us-ascii?Q?9pQzVppuubgn0/CF8wpWKGwUUPs+he6RnqEqisaoHU0gmViXF3sEXbqhHfAw?=
 =?us-ascii?Q?gx2qIJGclodRgnsiwatHkSsDPgMY+Ese45efBnvC+AWerevXqQ9bdRpvl+YG?=
 =?us-ascii?Q?wOCGWqhfr9V1yl6QtSo5AsbqjpCClLp3TsKAhPcmEWuweBSN3ZNGRkMcmgYf?=
 =?us-ascii?Q?pwsO7zb5H5wnW8U/PTg4604QVNfxy6m3lCv2v+t8FEEvrGlEHQu3y+XY0/cM?=
 =?us-ascii?Q?Zier2Y9kdQhAm/jjkd2XIooL1SzfK+PVQhHC0nT6WE64nKmbmu+adp0kj2My?=
 =?us-ascii?Q?75TK1W2zm71LfJGrFEgt4ZfGN+mdASKSgXQQRzYqhp/8ZYxIfG+Q2OfCziuS?=
 =?us-ascii?Q?vmK9Tq7Ahsdae8friCYNPWIEqD+9aqj6zuPzUsyjZ8szPAPTf/1k5p9eJe5Q?=
 =?us-ascii?Q?3m3Kmd+Vab5qsMUwFeRsh0oqMdGfET9Dir1vcfN1OKq5DI7F5wwtuZdRsULt?=
 =?us-ascii?Q?tHS8CdySZL1MJkxncVipU6bLvK5mdYL6GQORls+xFRdJNe3cmf/qzHj3z8+n?=
 =?us-ascii?Q?e5Qz9QAtC10U0hNfwl676Depb893qYxV2p0sT7bYvV8idCH3lh2TN/uCmOAe?=
 =?us-ascii?Q?Vq6aJ67D2EOpmvFrA4HyfXDb4ruu9nln/r2AcBKWe8RMtrec4y43zg4E9mA6?=
 =?us-ascii?Q?YVoamuzdyTE14znxlZm8dpz7yl79PrWME0sX1Ho6adtCVmrTrpn91U5vzwoN?=
 =?us-ascii?Q?nHEjsAGT/ZOCLCJORk1TEP4tB3lTlJyZSqLUWDsvkVEOGP611MgvD7INGkiQ?=
 =?us-ascii?Q?No5AKpVivWBdujgemFqxvGiDeoIQbu8zBFOm97qfsIpWaQmlNiIeRsOoI0pJ?=
 =?us-ascii?Q?m9O/adUzpOGdOA2+T/iVCoBLFfKq+cLlspSHG4T1+YDUWVJto++LL6K8myhI?=
 =?us-ascii?Q?mxFnqsyjDt+Dgll7CxgfSxCMGc6iGzm3s2ld/gtgAMilNcmDl4ueJv8gBNF0?=
 =?us-ascii?Q?BHAxXl7s+5JfEyiJH+P9WJY4dU/fF11idmpFA1VjWFj8TTKkDpOzVJlt+REY?=
 =?us-ascii?Q?G7SLMWFQ3fr7sLeTJBD/xjpJXYX3p/3UOO1PqYTXsYbbcN4UUk2NBV92QrD0?=
 =?us-ascii?Q?sj2X+IM2r79HnvmhSqRashepNedoBTIjf6sVOnGMYHcNEl3Ljv0fMrluzqe7?=
 =?us-ascii?Q?6qM67j+Tl5gph/bdwCpdiJjJHJ3TMBCk0DZBk7PvC3/6oo02CDkKex+NHX35?=
 =?us-ascii?Q?X/AZMDpgrOI6y1P6ri6gQBVWoddhRJkALNnonYsfiqHovYTGlFvpar5Oo8rL?=
 =?us-ascii?Q?rIHKeZUpozZnjpyocdrAkh1QUvcFI5djiR9oBL6hMR2fNy+zj7e/r01tEa2+?=
 =?us-ascii?Q?hJiysZnvx02RLCVEpgY7DR8E//sw1O2KSyiQpyrXiCAEHRZhOBtueTxU8uEn?=
 =?us-ascii?Q?h1pu0JNJkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c9ea38-aee6-4e80-7086-08de81219a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 16:57:26.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ8lfv32hS3YZ00NoH/ttso5fferr83PCus9bnadvAoDfdyFmx5OezriWO14Pnpqz+sbS9pVYyK+9wZsJCie6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: 13 March 2026 16:51
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; joro@8bytes.org;
> will@kernel.org; robin.murphy@arm.com; baolu.lu@linux.intel.com;
> kevin.tian@intel.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH 2/2] iommufd: Report ATS not supported status via
> IOMMU_GET_HW_INFO
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Mar 03, 2026 at 03:03:48PM +0000, Shameer Kolothum wrote:
> > If the IOMMU driver reports that ATS is not supported for a device, set
> > the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned
> hardware
> > capabilities.
> >
> > When this flag is set, ATS is not supported and not used for the device=
.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  include/uapi/linux/iommufd.h   | 3 +++
> >  drivers/iommu/iommufd/device.c | 3 +++
> >  2 files changed, 6 insertions(+)
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>=20
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.=
h
> > index 1dafbc552d37..d85a2d3e1b40 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -695,11 +695,14 @@ enum iommu_hw_info_type {
> >   * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user
> ignores it
> >   *                               when the struct
> >   *                               iommu_hw_info::out_max_pasid_log2 is =
zero.
> > + * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported
> and not used on
> > + *                                      this device.
>=20
> Same comment to clarify what this means. Does it mean ATS can be
> turned on if the right HWPT is attached, or does it mean ATS is on
> right now.

Since this one is negative : ATS is not supported and cannot be used.

Thanks,
Shameer
