Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A613E275B
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247452; cv=fail; b=rX1eZ6QAVlRerLoyNKqGmyOY26+RS97paZjU65+qHoIIpdbzmIY5WbvLJfKAuzBK43aFCmerBzGl/8EkjhqJj7VF1MNoDWMdm6u1cjh/gavzRApHtA9aiZmHIXI7bIGf7Mk9lCiDwZGBXklrBI9xSum3JrnheNQpDwScoOsKU+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247452; c=relaxed/simple;
	bh=q+sZVh6RW/YU93NVW9TuHGcrU22FqdLVuTX1Yj8kOik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pW8XBt7DE4IQdFntLnWeKr6C4LdymrHNlOVX1zJOIQmmvrQKBbOOhNuTjKORTtzv0XICSKPmOKW2/2hTlbJQltRiIQuHWmSSrXah5dj1z6AaNBI4ZoAwNiSuL7bSTV2FUgCBtwHOE4PUvEpfUyGPND8F7gHeXJ19etJN/IaSSwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drAYICyu; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drAYICyu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfnSAakqIgEhFlesOkvoZYbJUOXQYlRBDNotw6T0AVoQdEamJ/QKBXTNvEjRxH+w3KldGwVRBnrPz/R5G/0Oke98kXi2bNCHUVBfRCfls6E9r4iIv3BsjtQv9LSlZMO0lAkxsfl85R074xfEze2iyhRDPSCT3zk8mqJEuBqQ6+UBxOvpkF140Yufcx2jESFPv9KoGh8LlehtSbfwoHywZvyvWfxzmra0OO1r0l1Rge/M/9buCys3J45XWyNDz7z6jtSEzU+TWB6wrwtp4RCy3lOhwkMX8sV2bxxdmdqqRXxGNZFdG5Cog+P7rLFJJy+RNjUUAOPT0JY/4AbNxMSYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwnrUvnhMP/eVT6Bpc7cjSf+r3N4/wYh8rDki+9P15c=;
 b=RRh30o0q/XzSInmCy5fO081Nj0CU6AdBPl3+/VQrLzK9XjDvaEUUUKHqMEuGtgounXmIcl3dasbdqp8wsJ1iOvb2wkm09Qepy0wB88YfAb4zGSha7JyiXJKSKZSynQyNsBx38Ai7YWaWShaBhUJfnpirKl2GHjRevqWp6Ndzrcz9yUCizNnMue78wX2bdJncA3FEQlpK0wTYHsCWSe5CvUgf8iyjHKzw0sXV69fE+5UUlefjpU6vkdkP62zSr0SVK5g6J6N/BXD8AgTUzzc9fsI/iVTs960P5EGEuVgJprpzx0ddi+KFZ+1hWFzSUeK1xqot+isIxZCO5ZX+/WCWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwnrUvnhMP/eVT6Bpc7cjSf+r3N4/wYh8rDki+9P15c=;
 b=drAYICyuSV7QWFwhCajRwVWOlgDaCrulBSIaEo+isn8ASrUA3+fXrFpey00qvSriQ1ppz9IzFCW1uYlzugk43e/1zVTwGf2AxWCOYiD/O6UknhofMJuDtzwjfmSaM4RKw8LFmGm3W18R9zNbDW6mRx9i9AQIzJG0Ztejuy45iGLbS8WpatB8C1uPebwDbqVOu7TIFk7mjBAm1Wya33n1iyHKqrLl+Qasx8sKXWrrKeiupgLFIxxHfAIpN5jUmZ4RoTXDzOu7mt0FASz24fe5qK5STAx0bTpmcur+gbKUx4QDwowIMoWJKckR7JWJig++6st/cdmiLC572/8q8uyTwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 16:44:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 16:44:04 +0000
Date: Wed, 11 Mar 2026 13:44:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from
 PT_FORCE_ENABLED_FEATURES
Message-ID: <20260311164403.GC1448102@nvidia.com>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
 <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a85278-81df-48ba-ac8a-08de7f8d67b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mJDORBNV2AYyJfKALto82/mHpYl7QEZOTuVwTSzZWkOMup3MHzasqieuu/88x9owrG05iBJarRgfC9ihvPPnmB0KO8hpOlSFXYsvFI0k/sLc+6pawSDApxDXEdHKm5OnpYTOmVIUpkg+tbhmULvfHqE2zJAzoKm93BIc3Caru7H5lqtJYd7IrxLselQhPAlyy9/0b17BrrHOK0aEZmllTBuiXVQ/KwZIuyVgg0Op95bsPeGqc4YK65ai2eNTCYlNB4le9yYLbFgLiIx2N/FIOYOnCsNexmnQ6IbZLgAb7mvQOg8J/ZbA6jbnCWp/KsOllIU+yzfyYq1vcuGxtn+r5Wm167MRDWfLLFwTfpiTdKWMw7MsxUaCzwKmBMvKM8r8GsxzVuWl0LGkN/XRGN6E3S4HLpO2HxlVYaX0rPduDyqn5HF0wvsg62oeVjUE6BiIns6okBS1QDo5W7+2CoFC6YrZDM5iKDiBH4BRaV485JEr0DFiWSl+cRuKAHwJfx12nHA94zIcXDeyCMUg7p5ynntLVqQVbB6LjhDyqy2wTJjey2qbypABAL3FchloxwEmB6WpduX2stqgPj+KtTNml+Que9Zgpxv1wNghQ++of6PG5s/N9dCpXR/NOadiXDbeB+dco64POMFChR1+dJL7SC9PsTTwJOnJ2n9LHwMidksthfvQxLWMz/5OGXGcD3J6gX7svn2PHr8iLYeU9GLG6sRL9TLhdZwAji8FNgV49gU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5hzHF9dDSPo1l+Fa8TAcO6sEuKSJI6KL50S7SCGkkHlKIt2PXq+h/uR6op0?=
 =?us-ascii?Q?iCRj1D6+U32uCFbuPuTCnwhwW0Ozzfzfu1sxloVqe1MnwCffiqRnjTd8a6c6?=
 =?us-ascii?Q?B23mQZE1+XC82py51kfGp+Pm2RhDEaHjfglLVJwcjEFqwUxmsWH2AmFXO32O?=
 =?us-ascii?Q?zDxcPGtk9lMRk8kRN2HaqXV3CTXWH0PFGGJ9DRmhaj+b/XbpWhTp8bC84rpk?=
 =?us-ascii?Q?jHDqJ6a5SC/picekYV8mVVsuurPTGZkaz+lsYu4Txto4QPlavCHyzlO3hrgG?=
 =?us-ascii?Q?+EaMa9CBnODRA7GWZOey14vvvDgIA9sjhzAslci/m4SYZdqy2ydaZonCCWIE?=
 =?us-ascii?Q?RK9AOHkcUsnATCUFtgNMdOv6EVWRG5FH6q6lETOT0CSzva2PJpZ01w7sNicS?=
 =?us-ascii?Q?IY5wVPKBeKlSs0gMxqi0kp3+UwsJcqVMFnpNUM9c2FEqk8dcXLFRMvUu1qLm?=
 =?us-ascii?Q?eoAc6cNkm1SnnKvplKHSDpeXfwU3cHbz8LGoKefi8U0X0aoJmsa2FOEcNz5p?=
 =?us-ascii?Q?IjTMY29J+/XGtz1TayPHnIiJBs2Zofnp0b6S5EftI9fkuBJQy0fnmtINSu3e?=
 =?us-ascii?Q?27mH4QarRoqRZ/roTAbgQYRBWG5fdfuNjQEvDcRQ213dlFJHbWxB9ptL+wdc?=
 =?us-ascii?Q?UpVpSxDxxXGZsvkupNzaaWC+l9Nn0Rrw+8UuCSqP5hVmcxf+od2L+gbyuSYd?=
 =?us-ascii?Q?PCX/yVAWKPLWVLDknEBTqR62m3T4xEUyGRVtN5Uk2VvadMero7y0iVS7wPCP?=
 =?us-ascii?Q?Z1kjJOkYzXMGr9SlYf4C8W0RddOxeqTXgvo6nbzqta9vZam2syYNov9/njxz?=
 =?us-ascii?Q?pwcOvgHs4UvOsLC0pyzb5wq5CgXQ1lI32350vxsriUbJcRyRxOZ2/JPyc3DH?=
 =?us-ascii?Q?wbxgs4tST40pg7jEjWLhlQSCEJZBV/cGgHvAlA+8mcl1IQmRuKdRy4xeywzp?=
 =?us-ascii?Q?Iqf0Yc8WH1N8ik7DorzBsthjBTIlGTfL3MekVyhi63RHfKK1tdULc4KGJIwi?=
 =?us-ascii?Q?iJy3UuQWdO9oqviqJiid4f/Dn5g/pEYvBBcR+2s8dKRzawfOmT4WiToK5BX0?=
 =?us-ascii?Q?0S8BJLVOe3qwxwg+BY1z9abUwhWFZ90w8CqjR1OPFuh4JeyJZATHezYCKQhu?=
 =?us-ascii?Q?VxNzMyqHRmMckZNY8oyvPIRULealXaEPhxRWywd+e/Js3gOW+QZL8A1BNy/z?=
 =?us-ascii?Q?XIOJPMopm1QW0WyOoMYycKW65tIPlZ0UxUIIzjhvPAGn9OAMn+Ou0iMUJ7Ef?=
 =?us-ascii?Q?pQ+DeQfMiTlaRT6EK/fGt/OHTzA99D3ZQGGuQC1TejDhLCgeWyjvw0eSCJ7i?=
 =?us-ascii?Q?O+LC3HR1iUJueRGXQm7IWY1dguaKkz2BgsA0b8uCbbXYXOSXKpPddVdLrlve?=
 =?us-ascii?Q?Vn6lx/LZIiVgPpyow/K6h7LhPMK22v8whWuXgo0EGi1eh9x6Ig5E9iUU9gE/?=
 =?us-ascii?Q?yVXj2v2zeC2Pml2fc5WVbNvI+qLmMddTUCl9JabOFiioTLiGbFP9/unLPBj9?=
 =?us-ascii?Q?57stjIXe/2PQlghstuoq+YttS+miQYtFSl+T8s+Sqr+hVz1de6qD9+E2a9Vs?=
 =?us-ascii?Q?gr3lMfomLecn1lsAtiAYA+8kEsHntqvcI1CGROo0kuL9n1hrJTijY5kS5sp/?=
 =?us-ascii?Q?ViwIY2BMRtiMejn3yn6KftOzrPXgXRUXBAgzHvjSRVaycmoD40LvpdDk2Qbn?=
 =?us-ascii?Q?aqNdBIO0bZKZDDFSRIekjNo+tL1yNJYZrRmHnHDXUo+VfvCPQE2ce48F7QPp?=
 =?us-ascii?Q?v7mIIx+UVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a85278-81df-48ba-ac8a-08de7f8d67b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:44:04.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPHfYN+8BS7iqQYfes89SXEOIYeHmP1B2SCLUQkBfw081u95bhMKTUxt75WfEaTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On Wed, Mar 11, 2026 at 09:54:55PM +0530, Vasant Hegde wrote:
> 
> + Jason
> 
> On 3/9/2026 7:35 PM, Ankit Soni wrote:
> > Dynamic top is used to grow the page table levels. However, if the VA
> > size is small and the initial page table level already covers the entire
> > address space, table growth is not required. In that case, the generic
> > page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
> > error -EOPNOTSUPP and leads to domain initialization failure.
> > 
> > Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
> > domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
> > via cfg.common.features, this keeps normal runtime behavior unchanged.
> > 
> 
> Fixes: 879ced2bab1 ("iommupt: Add the AMD IOMMU v1 page table format")

No.. There is no bug here.

I don't really understand why you'd want to do this, the driver still
sets PT_FEAT_DYNAMIC_TOP, so what is the issue?

It shouldn't be removed from PT_FORCE_ENABLED_FEATURES, something else
is wrong.

Jason
