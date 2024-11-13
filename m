Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064729CE6
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506901; cv=fail; b=qcR8pohOfdeB7u3OIa1fTqr8EwmQ5QK+jkwME+sUdSSGCZcSQmThYxjuBT89iJZny8NWKXxs04GZNJpQ/Y/EGrhZkMIp5DNYVxxN/9puYfz3hpfuzAC5BHnkH9J0yfTKtYzOeqSxI4Dsmkham0otkguIkZmYP0/XQ5pqyvJduHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506901; c=relaxed/simple;
	bh=fxF9LNsU/XiCY+WY+jWsXqR6+ygNr0tYpoKEcIRAFks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZh8t/JKUrFN0TszzsS2SEz+OeyxZHXVX174reILrPXSUTZjoaTy5+UOQ/1HX+B9oJkJmxFkhzjoTZXbPbbjMU/SqEPsUEujSQ8Pp5XVsMOyhgvcdnUE6bEIcnqNFYPK/cP+yo0scpZFQ5TAN0oAUW6o7qx8p90YQM1hkTXoVYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lcfSNrLd; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lcfSNrLd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq2W6Jz44CnLmqsfgq4choAuBkjFHXalHJ95Sve7l2OPO/Y8juxcaEBLGDsWgm+FuQKjv+FDmHa1nRc9Cp01I3a+nDlLKPMAWK6OzlgejUPInSkzuyaZ+Dq1iAUzQPcvTJyy5Ip0fkwnQdv9Uh9t2LeZcXedUSHtTAS0fvwlDJZ7DoQ0l4ma7ATG/iwd5Hlc2mG4wnfyJsccr1mXxx4MFfAtRIYZwi0mIxfBD/FjH2jipKsH7YXdtUCskU84AJVEOuNhBoh5feobDUeB0MvksUYBT9GToNOht+tNL9mNJXWiVi3lYn/DMAYvZ0tq1iLAoSal1QD/cJVs3gy+DuLpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlrzx0HBu1Do7oImCX9gSja7MbftL2wuodc+t9DTa8k=;
 b=Vl8+pWEwpGudMDnmH4f2Cr5Sgp5EfQsBYtocgfF/9eoDCpZBJCRt0CbE8PggAS2EZT+K5kigmDaiyiYVUWWKVBjh5p862s4ParRrS+irrvgx6MsBDaSxRF2BWOm/BUHCZxdrJY4+D1NhQjumgP5U84K9cU6pkkP/XuJfstL7p1OIWLcUI8b/8zkI5oNsOa64VwmRpRxbyFG/WOzJMcat2uPS9/g2eSDUM+bn0HEx2GT9NXYf82U4RRUmOcdXrnMcAVVnpqwj9PB/tvVZ7+slA3EVFP9WZJ+lTa+3h9VnQpv7Kh7tYyx0mVzdpqF5WBSvRqL1zlLJgQkEpvhnYyKITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rlrzx0HBu1Do7oImCX9gSja7MbftL2wuodc+t9DTa8k=;
 b=lcfSNrLdW4zObKkZDs4oIA2nd03DG1lZTwp0xdV4SvBTPIqqTEQTM7Hhvfg6k0kRt0jQhYi7cx3jnsmCpkYfB+FLz6/Kq1NeYz2aC23qH/6ZV/UYXWJcYAhdF+AWL0kalOFkPlIxq2p6Hhku648ip+tq31C7qaHUCzl3TEpj6W2PUnLaPdCrUHD63SPXjflhWDndx452rPN5M7aa43fFJkskG42wSJNBihlQLQ2IvDsp1V/2khAEepx6g8tNtMEFcNjuLdEzsDasjGB/JtBzgz5A2fHztA/YjZ3CMcau6dMp9FEi6mq+9LLvhya/MIjVjFObXijau+VuVgY5yx8h6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:08:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:08:13 +0000
Date: Wed, 13 Nov 2024 10:08:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V4 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Message-ID: <20241113140812.GH35230@nvidia.com>
References: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
 <1731016017-430373-4-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB52762A7D90A52DB3FB434F008C5A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762A7D90A52DB3FB434F008C5A2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f92158b-a5fe-4846-b6e4-08dd03ec9c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xe9kPKarjPmbeYgiuQYTooQtXUlEQIu+ldmcCIyEJxTQ3xKnJL5Mf5h7wsCx?=
 =?us-ascii?Q?SoQWuJU7q6MtMQjRC9Hd88mrpYywkgd4dvphar/Z0xA2Ad3wJ9yo5Lf8SkKl?=
 =?us-ascii?Q?X/jzQeI3Kr9WMDODBoa0hy/nYrkHcw55/Dya6exJllEhmWIRTyhobB9CwvoE?=
 =?us-ascii?Q?z1quDbkbb26AUSBeTn6ovCAD9oiZZzqeYjtVR4fAs5T7lLWZCJxfag/GuM7k?=
 =?us-ascii?Q?2fUYuUfi8Ifaayw5o8lQd+LPDtccvN3nBnESSQ+S83sBB+WaBIuQsgkkhIjT?=
 =?us-ascii?Q?O3B3NG3tJZzS5lbih0fc8kka8o57u8MzYCsxfmKNjZjgIxJeJVQYxD6hu0rd?=
 =?us-ascii?Q?rmqfXov/0KJG8yDAFRFmR7b1T9uC0wXcw/nCFBC/Q658viB0WqUKfE+zmmIw?=
 =?us-ascii?Q?RTUSBPRJvgqjIkD4yFT8IdsPz4n1LZes2m/QbncDfXYLVj6XhE/w+5K3zwco?=
 =?us-ascii?Q?GVnib5ffBRltFCFAdcBL0LIYwiVNf2fYBSFmdsHP5+wmh7uJOC4E0WhimKkW?=
 =?us-ascii?Q?bT4W4gsQRQj90WEP5cUKndc9edcucv82qQYFtCpDjqB6LIKQZARLYtrV0l8d?=
 =?us-ascii?Q?Hm6m3li0+R+uxtSiLsOkdNPz2HCmYGe4y65Ujo2GWaw+A3nYqUbqmhtt/zt+?=
 =?us-ascii?Q?Bj4BnWXNXiGFjdIE57dc0sYKBhX2KtrdXGkkLyEog8tu6qCKuhu90QKMYLWH?=
 =?us-ascii?Q?BKa2lBjKfub8hGlMAdO8y+DV6GfnYAxqXSN5s6QRKbRGHWMwtiXDAJtqlrgB?=
 =?us-ascii?Q?MlpYkBQQvL7gGY6YrxY6xpxfb0gPtQuksS0eoDWDLnsB8IjKQRtEGykR6ARh?=
 =?us-ascii?Q?ngcn6FO3k2tbVN4cXW28AYspvcrXEUozQFDyaprLQjVUvYOJWyMabLQ67BkC?=
 =?us-ascii?Q?K4rjQZfTRtTjiYd9eVCWAE4UtfjNmoCstmjmI+m3X1lF3/xj/SeP8S8k9nZl?=
 =?us-ascii?Q?MatECH0gJb+MeXuUy5ko4hByyQmyhfJCYWotgyiCORme7t57/eQEWuFQgyVp?=
 =?us-ascii?Q?SUDRZfHOnD1yL1dyrMq/NpMyXpeyXW8CJHTZud5F/dKnfeWgCkkL8N0rWgtM?=
 =?us-ascii?Q?woeKsdJkkDT2C8jFtJv/jMUVd1ncTWJR356AbJnKXZUSTdP5LU+yenhUsPDU?=
 =?us-ascii?Q?aUQccR6y8pDWj5D0IC8gM+XYz6cWIhCeIyy6uKyGmMQHWB7/EiGmnfVdqk6h?=
 =?us-ascii?Q?Jvzl6AnVjSNQxHoabgYKmm0+t6QtKksVbwtDi79RTQ95jEYdG7CJlqnnMElv?=
 =?us-ascii?Q?31j+1L+QEZ+oKaySN8yTSqqSPtH0yxXmVgNiEDLvAxVGteppokYZM9a7VMHx?=
 =?us-ascii?Q?GlDRoRN6ZlEj2qX71hcnzJj0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzQ2woqbjjNQAUpAJTaxMl8SrLSUb2+NH5SjhlHpaWFsRrhRPoLq5SxYZHOt?=
 =?us-ascii?Q?pSSSfWLR6C1uphhcjAJuxYSp+V+RBNj8WD1xKPD57i/SbptuVfwxxKiz2XDZ?=
 =?us-ascii?Q?w27aY2E4NklkxQlAPis2hTI6z2+OyMdUZtxE0arN0HgyZccQPDU2SNbW/rk/?=
 =?us-ascii?Q?th2+JnZXFTxuYvPctIi9ztWWj6ZlyNv+shREbbsVAgiwSst817bCdkEuXsNe?=
 =?us-ascii?Q?/xI6sLDE17cg4o4Sn4bn5AxcZOvtbvXGDbAe0I6du54nxBgWG/txsu5x/rLD?=
 =?us-ascii?Q?0RmIj9I4e2BnZcQcGob95gOFoD5ZdR94QzriWQtkuyLLP74YJ4DnGQhfLEom?=
 =?us-ascii?Q?bLEqLGqsM2SduGXW/bOd/J5pyy3wY5KVCQWh4LhZ6+IskAGlLRLlZfJBE5JU?=
 =?us-ascii?Q?sABLdXYjxyCqUAMrGwGsSVw12E0zuG/ImGzJxRrb/NiUht0b8AmSAuhYpx/j?=
 =?us-ascii?Q?sOlELgFfS4Z7GKnXu2ADi2lvktnElcUQWOh2xX1APkXunsQfjeTbqcK7Cvi2?=
 =?us-ascii?Q?urzR37sNVvBphwAGExG2J9UAzwPOR5kVmhmKGNgLHb6LWyyYnTh8TQqbeiRs?=
 =?us-ascii?Q?QRhThg1CBFnUhJ/c96uCCwzKJjcmZrIDW6+4ukyi7ydLxeP1K3djPbZ2aH1q?=
 =?us-ascii?Q?d2fwhN4bN4I79FqGAwr06KQTumkHls0I1ty7yQA6ej/itHeDIasOdKB22ug8?=
 =?us-ascii?Q?7o7sqQW9BMdHOHvojT3kcQfiv/pGIOGoMeWcILDTBus6vo6LSF7C02XSG3bz?=
 =?us-ascii?Q?JkZ+M/Ycv4wEiCbDhxeJUpm7ZHQuPLRSd/ie3Zp/CASSonHCHnx+/tTo7S4O?=
 =?us-ascii?Q?ZYU5BeX/74em1VKjAdA0fjtjBpI1IiHJQgJ8tqf52L+Pavw/UdzBq0K0D9Wh?=
 =?us-ascii?Q?PaJcMBByjGON8LDSbB4j63IM7MEI1cTQfApS2g01Mn/Ggnn9fGSqkouElIXV?=
 =?us-ascii?Q?fZ7i6byS45VgW8ReLsCRm1BasuVy/TlssBtn+28RiR3q7J7mYjaMVV4vae4N?=
 =?us-ascii?Q?mT3xBg532JdJUrxnTZk9xXICmQtPgR7JIRT528dmN699Pz6QRCZ0iu9b1R49?=
 =?us-ascii?Q?Mzbw8jqpDNnQCYeA7jgB1xW2B63MIqtsabwVi57kgHArbCXPMmIHUnT08mBd?=
 =?us-ascii?Q?MZDvjrkdQCXisnu048wYjdSO6NaLEYsYx7VQHttLCFcYQ3Fv0G8QSqCDJQSN?=
 =?us-ascii?Q?JsmAhQBxeLjk4x+Z58EUMjos29Jc/Kfmd8FAF2IXgrxXAEHfN99rdXvyWkCm?=
 =?us-ascii?Q?8rmc6irRahUTU/fhm/ERasL/wnRaKjb6zy0uco4dxEqXCT1AKmcrX2NqoCpc?=
 =?us-ascii?Q?jV89u1L2wJrYCqSX5gIitFqa43QXijsvmFdE8KD5Psy+ygTgJYkoiSHmDPUM?=
 =?us-ascii?Q?R0QLvFrCmv5LkrIliTzuUApQhfGcdYRGeVhD0JomuO3cBBO04lKCk+rv3yb2?=
 =?us-ascii?Q?1n8foH+dzmHC3rg8MwO2f6LHqQwSpRNJBVXrRYo/9GVWOSU8QwYb9o5ymNKz?=
 =?us-ascii?Q?Z6zL4krAUNf3yJd2cSNUS+cIT0rvdijWz0vgwr9gES4Sug3LHg27KowkYidO?=
 =?us-ascii?Q?5zdQ0zkJYv0Oawk93/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f92158b-a5fe-4846-b6e4-08dd03ec9c72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:08:13.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvPf1lhHUzYwGWTDAoyqE7y9uoCvtZFqJfgPnh6HfDBmPwKsdErU8ASxZZi8n5ov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

On Wed, Nov 13, 2024 at 08:25:45AM +0000, Tian, Kevin wrote:
> > From: Steve Sistare <steven.sistare@oracle.com>
> > Sent: Friday, November 8, 2024 5:47 AM
> > 
> > +int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_change_process *cmd = ucmd->cmd;
> > +	struct iommufd_ctx *ictx = ucmd->ictx;
> > +	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {};
> > +	struct iommufd_ioas *ioas;
> > +	struct iopt_area *area;
> > +	struct iopt_pages *pages;
> > +	struct xarray ioas_list;
> > +	unsigned long index;
> > +	int rc;
> > +
> > +	if (cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +
> > +	xa_init(&ioas_list);
> > +	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
> > +	if (rc)
> > +		return rc;
> > +
> > +	for_each_ioas_area(&ioas_list, index, ioas, area)  {
> > +		if (area->pages->type != IOPT_ADDRESS_FILE) {
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> 
> this and next loop could be merged into one. It's not a bad idea
> to add cost to a wrong operation while making it slightly more
> efficient in a normal path.

The next loop messes up pages->last_npinned, so if you merge them then
you also have to do a partial restoration of last_npinned and when I
wrote this I thought that restoration was complex enough to be not
worth the optimization..

Jason
