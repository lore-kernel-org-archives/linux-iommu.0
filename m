Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372318733F
	for <iommu@lists.linux.dev>; Mon, 15 Jul 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039989; cv=fail; b=FTFtU+oe7AB0U43qS+3ySkatJ/f1BZeS9Y8lwBN3NBZPx19UL6WO/Hi1Vid1KJPi8Eu6Yw/FVUiLroKsch4DgU9EX+zYGntVtBCcz0orVY3BYLAJ341lDy3nrfjNjY6PAXyoFG9PI7XH14rRs1OdB/tZ5DapmuXjTQS2JZyEjwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039989; c=relaxed/simple;
	bh=hpuggPjKV+0jamRdJZHWg4gWMExMbzEE9TNFpaNaJJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAdedHCiazAvthDzEeZse1DVgeYZ/gvaPaiw9W92LEui/NsrDa2dcZ5Gy7A5wjgW7RTGCoPcbavXkcr23C3ExeCD2v0C94mJgK7zgN7q8uJ4iWr+IRp5o+I/WD+j3PvyrpKqtBWiTf9UWFm4QGVziRHcSIbAJogs7HwnrZt4OKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pexZY1dj; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pexZY1dj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOX7bImfbmFITUbEKjJUuM5a5mJ8cF+eHffKA9A6BJYx8Rkg08PjSxVOw6Bu3UGwbAjMJtlBmBKIrU2fEXaO29pFVbR4M0DUDsDsLlpy4Tvu49PgS7Xijdpn+s8H4GIJ21LUz0cldzqYJWsAxW8i8IM+7P6DvG7C+B0rKq2b00WO+LhuDmfg0Ap7DSVfQvYyh3cWlk4rxHs1VrffHae59LbCBTEXCxo6HpWU7bQ0DGfsCf8aySBPounsfVYy/eiUL8jcbRy3YDOcFfipp908udVDSfxO2wDrQe4QDOK0YcPDDDumJfMcngv/IbsassN62ojXrgiuqyDT6IO0W0nf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85L34hqAe+7QWInKStD9hCS5duY11tgO8KjWyIBehPQ=;
 b=VmQN2B1BeN9p2FG+XgGWObrmyLd7G+FjSQsM1O5D+uZf+QPqSc9HlCZPWVn9f57chXp/DDupqKSBhQX5qLlEJ0sYny/q3pe38QBm/AQDvtkTU6bym70rPDhg7KAj9SxLvka05kJ9n5efphyuN3PpwJe+/e9AbibGRQbnkjXhYEXtHvcyP3fCiN/Hx1CHYAyuKO3Vq7SlewmSG9xYaLkNwTmGXyT95sOizBBU3IN5Dv1PzdZNuzi1AqwN01KNF1Aq8NHWX6JXQ6j0h3+sXgRzj958RlBuiTiFXCEulLCurO52RBfHrUncKajmc/8xlytXYkm9olKXgjdeU6f63WH30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85L34hqAe+7QWInKStD9hCS5duY11tgO8KjWyIBehPQ=;
 b=pexZY1djwj+cdBB3fI5aftoJBJrqEg5O5U51oS/2wWm4397XZtvTxPcLeQUL8/IXVhj98Jasx1YIpD/8aRmYLxKwjbhkQ+3GuX/HCNRBcZ8KDxtobCwz6q3FxlDsDRcOsBjhNaRuwxhsc/DZHWB8fz9RtO7/5IpLtpjPbtgM/cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 15 Jul
 2024 10:39:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 10:39:42 +0000
Message-ID: <97538ddf-57e4-481c-9429-ab5a4b88710d@amd.com>
Date: Mon, 15 Jul 2024 16:09:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
 <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f04df3a-28c8-442b-e721-08dca4ba6f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3lUdVU0SGVxL1lSVGJkYjV4Y3ErcEZYOUQ5RVloSVVWYUsvZXRFOU1nUlhL?=
 =?utf-8?B?bG15RVFxMlRBaWtxYjNOMTFiVS8rMHBRRlVHMmFWN1BwVUJnSXVWUkJKTmhX?=
 =?utf-8?B?YVFWSU5lbGJCNUtOODRiUW1rMzJ4UmU5VlVsTmRBSGVWTlVBcU1aMXFNT2JZ?=
 =?utf-8?B?dXJnSU5KKzUyMXplMVBNVEFLNHNaek45MDBRWSs4bTJZaUJEYTdGbTAzTm8v?=
 =?utf-8?B?OHRIaXVRVC85Uk1GcTdrd2Z0ZHJybVZvY2pNM2VYRnJFbkw4bnNteUNrZzAy?=
 =?utf-8?B?NjNaV2tFZGFhM2crVzg0NmZkYW1NUFlRNW82RG5VSGVhc2pMOFJGMzZMSWJG?=
 =?utf-8?B?bDF3ZDQrU1FwYlUzUGtYT1VXaERkckpVeEo2QnZ5SDFzdVhOeXZzSDAybWxD?=
 =?utf-8?B?UWh5aGxTeG5GU1NFdUt6MFpwdzdSNXR1L3dGSlhIQ1laUURhYVhnY1J6T2pO?=
 =?utf-8?B?cG4rZDBIYVpZaVZNc3NWRHIyMUFVMk5RQzVOQ2k5bWtFQlYvT2RvenpHTDR6?=
 =?utf-8?B?TWZIQWpUb21ZNXk4QzArazNJMXprVURNTUhWNjhpbm0xdHVGWlB5OGlPU1ZC?=
 =?utf-8?B?cUdsdVJtNTJEa1FMcHhvS0lsTW5sUldCWDJobjRIQUUyaWZwVGdNaDFaNHI3?=
 =?utf-8?B?K3BodVpNNmN0ZXJTRVMwQ2ZXengyTWxrdXE2NkpRVGltaFlaRkpQUmhUSDNq?=
 =?utf-8?B?VjlFUzY4L1NZckhCL3M4N2Y3RFJYcnFRSmw0TXA3M3BZRFg5ZWZSVHJIcFgr?=
 =?utf-8?B?bUNNalo3VEozZ2pFNXJueS90UklaZEV6blN6YjErK1F6Mk5UaW9QckV1UEtz?=
 =?utf-8?B?dzY3alZZR25aU3N2L2xtL2FRNmJIK0tMSGNzR2wzMEt0RVkvaEhNcEJETU14?=
 =?utf-8?B?bjMya1VjYUxZQVgyV1BnVXNIbXFyUHRFajNTMVJjemRTZVZ6SHhlQk5uNHV3?=
 =?utf-8?B?ai94UXlqc0JCNHBpdDFXbVI5anVQWFc1TEhJV3NscFUrODdXYVJPNUpZVWpx?=
 =?utf-8?B?K1lNVHZPNnU4UkcvWjcvbFJXUEs3cTFQZTV0YmhHbm5xcCtSZWRlVnIxemR4?=
 =?utf-8?B?STNpai9ORjFPRFJRbFhiaXAyZVJVN3ZodzFqNzNHc2M0UTVUOFZ3YVhleFBS?=
 =?utf-8?B?RUZ1T2toSnVUZUtITjdlK2RsblIwb01NVnZYcmlXNDlIczlsSU9lcVNSZVZZ?=
 =?utf-8?B?d3hkNUtJZnQ5bnJySUh1OTV0dTBzaHp3cG5GbE9yakV1MHVZRE1BUjlNREZV?=
 =?utf-8?B?TTc5NFRUM3kyMjZtUk9iRkxzMytVdWgxdmRtYUtlUUpEeGUwb2V0LzNpQWZZ?=
 =?utf-8?B?WlBOMlZGVVQ3Y2hqa1BZMmFaWHN5NHU5OW9vdXZDTXZ4Q3MrSDcyUWJIVXFV?=
 =?utf-8?B?dEwwZDV4cnlxeFFFSkI0aHQwRm9sM2U4TjBkci9wVXNRaUpoUXF3bGEvdGls?=
 =?utf-8?B?UUhDekNTYWhiN0pDR1pRV0ErT1BsbVcycVl1czlSRUlkZkY0ZTFOMHBoZ2NO?=
 =?utf-8?B?U1p3QVEyWXE0Um1zTGM2bHUxbDBNYURCTjI1WXhvZjlYQjNmMzE2dnE1U1gx?=
 =?utf-8?B?TzFtcWlOZmo5Q0dBQzhxTVdTQkNzdEpXVWJsTjBsSlhJNUFvUUtxcUtlaWk2?=
 =?utf-8?B?Z2tyWEpTcEllYVErMGdBdEU0NFg2bWU1bU9ReUtOREZZRzcvc1NNMml0WFph?=
 =?utf-8?B?U2RKUWNoaVBSN1BOQmZNaENvaXpnYWpOam5UTFR5Zi82cWxSQVRJWmNKTWNJ?=
 =?utf-8?Q?aut38FKN5+wQjc4jgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZpdFhYcGZJU0Q0QmxXWlFpTFJXLzQ0RzgyY1pFaHdZcUNVYlJ3bGZYeFhM?=
 =?utf-8?B?QlBSTkJlU0pjVHU3cmxnRkhKR29OTGp4ak1uSm1ERTVKSUxmOU8rWEd1OVps?=
 =?utf-8?B?dnVsM0QwNmtJT1RWTzdlOXZ5aWV5YTlrck5hc3pVNTRqMmZEKzRxd0NNMis1?=
 =?utf-8?B?ejhGZXBDdGZCRnpoR1JwTWdQQjRlSmlEZktRVjgxa0hKZEk4VkJJOWlOdDFU?=
 =?utf-8?B?RFFMMGtUZWFJZGNGb1BHUkZqVWdvQlR6QVpZVXlZMDlManlqY0Q3RGUxUklZ?=
 =?utf-8?B?MXJtVlZveHJkUEIvemJaWTJSOVVxL2pkY0hXUURMYk83NEEvaHUzWWREaTdK?=
 =?utf-8?B?cC9xY1ozb0cxbTh5WU1oTnVuN1dVN3FKQVFoOUN1R3YwRGVrTmw2RHRZSmxI?=
 =?utf-8?B?b0FObFl1YldaUWgxREkrSWM0Qk9pN0l1K1dPbkdYUmFWT3YzT21rT0ZDYm9q?=
 =?utf-8?B?enpSUjVCMWpXSVd4STFXdmxFYXFZQnpxaWZCczllVjNBUWJYeTg2MTM0R3pM?=
 =?utf-8?B?NDBjUndhMDdicFNxOHd6T0lwcDlVTzZvbldSSW1XZHVKbExseWkwRzk4REI5?=
 =?utf-8?B?eVNSTlAxdUg0Ulczc3NQVjhTV1ZuY3VZTDh3NkRmQTVmMnRidC9HQ3FqcWNF?=
 =?utf-8?B?M2NjUjBVVVhqRmIwRmZLRVVkTVdDYUpHYVBOU2dOUkxrOW95eGF0aVJaK2Rm?=
 =?utf-8?B?bG1TVWRPQTU1TW5KWTMrNFFPNGVFYll1NXFLYytKdjBYdnFsRHJ4cTA2RjZr?=
 =?utf-8?B?d2xhalVIZC9ieVNHY0FOZ1J6V2hWdGRCLzZFTFNLa2J2enRqNEVqc2xkdnNo?=
 =?utf-8?B?ekZLejNnWjl1RG5ZM20ycmhtcVQ5YzZVdU93dGFEYjNQSFVURFBZSDdPaE9m?=
 =?utf-8?B?alN6WjZyUFZrRVVOWlFuNElvS2k1dFFHeVh3ZlYwRFhmT3RBM1JlNmpYL0dl?=
 =?utf-8?B?bFJrc2lqdHZsKysyK0RLbDdBWVN3d1VyMGYrQjVDWTh0cFVVcGZrMnF0NW56?=
 =?utf-8?B?d1hzRnljSmVnYTI2MVNHV2VWclNVdU13cS80VG13anUxMHlqdHZkdXgwRk5S?=
 =?utf-8?B?NE5nWjNUcXdMUk52a1MrcTBzSUlxRHBCYzVwYjc2OWMvTHBTWStOTHp4VmlH?=
 =?utf-8?B?RzcwNUhvZ2VNTS9NNkU2QXBMMWEwTWZjUHBBeHJscnN3OXJNdHRlWnpzYnFz?=
 =?utf-8?B?NU5TejQ5WCt6TkZrYllHczN4OFk2K1AxeFh1N1JXbUQ2QjNpdmVJcklGaTJ3?=
 =?utf-8?B?aDdtbGEvbncxMGx3dmJXREthT0s1RmViR0YzVktLazZwTisyazlCaDJMekJ1?=
 =?utf-8?B?Q2U1ZzE4ZW1NQVppeHBEckpVZ1JTcHRrK080NDZpTGR2aDdoWHA5ZVZxZmxF?=
 =?utf-8?B?ZTVhKzVZR2ptUUxtN1Y4aVFBejdVd0dZQVZPcGZrUkJVcEFjai91d1pnMGJY?=
 =?utf-8?B?WG1WZ3pmMGVaNmNKeGRJVVFRNW8xa2hvckx6TjdCVlV4c281SXJmeGZlZllU?=
 =?utf-8?B?WmE3N0hSclBqUm9NRnR1eU9tNnB0MDAwTFR3TWUxNGtrRkhVMEcxd2tYT0xs?=
 =?utf-8?B?NzF1eXhtalpTYkEzaDZza0lhK0VtUE1uSUZKekl1TjNrVTRPNDZ5Y3kwUDBZ?=
 =?utf-8?B?R2xKLzRVSEFYNzFEQ0JUMUYzd3R5T2xaWjdoQWdkbEE4TnM3YWI2a2c2c0Uz?=
 =?utf-8?B?UkRFZ1V3NEFuMTRRYTFoNnFtZEg1MmVNaGZFallqQ0NmSmFteE5qUVNPYlV2?=
 =?utf-8?B?ODYrak9RZUhvUnhzRGgrUXc3MkNNTWk4bksyUXNXZEdwZXFIZllCYTYzcWZT?=
 =?utf-8?B?L1FmOFNXcWRteTNLdmVuTGJRaUlFekVqMk1VY2l3MkdWVld0b25uZCtURFFr?=
 =?utf-8?B?WE1yclUxTVhGV0k4dTFnWUd1WHMvMjM2TEFiUDF3bFJLNEx1dHh6cTZwQVBy?=
 =?utf-8?B?S09odERMc0pwYUFDaUJXTHYrVUxvQ2pQVXNUZkdWeGw1QnRxWWQyQmNuUFd4?=
 =?utf-8?B?aUNVN3VuNE4rYStWNFFCb3VWZlJocXVybjVoVEFvOFBiNG5kRHNYKzZCYlEx?=
 =?utf-8?B?Wm1uSkRkN3pJMmZETkR0VFI4cFNYZTczWjMxak9CdUNYTWVmdnIyWmRTWDFY?=
 =?utf-8?Q?fmBITp1QKnHFWkuzwZImy/2VF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f04df3a-28c8-442b-e721-08dca4ba6f33
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 10:39:42.0349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXHnjD8Np27KndrExskZSl4XyW03czK7ZrXDCckxBxbhR2jdxpgUg6g0tiHWFvPdBe7kNFW5Z1tcy/rNk14EZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

Hi,


On 7/11/2024 7:26 PM, Yi Liu wrote:
> On 2024/7/11 18:15, Vasant Hegde wrote:
>> Hi Yi,
>>
>>
>> On 7/3/2024 12:27 PM, Yi Liu wrote:
>>> On 2024/7/3 13:42, Vasant Hegde wrote:
>>>> Jason,
>>>>
>>>>
>>>> On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:


.../...

>>>
>>> https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/
>>>
>>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
>>> is a PASID table which has multiple cr3 page table pointers.
>>
>> Jason covered this part in his response. Basically AMD has two page table :
>>    V1 which doesn't support PASID.
>>    V2 which support PASID
>>
>> By default when host is booted it will be in V1 page table. What we are planning
>> is we will implement domain_alloc_paging() interface in AMD driver. As part of
>> that:
>>    - PASID capable device will be placed in V2 page table, rest will be in V1
>> page table
> 
> looks like the format of V1 and V2 page tables are different. Can the V2
> page table be attached to a device (RID) and used to do address translation
> for the DMAs w/o PASID? I have an impression that a RID can only use V1
> page table. I may be wrong here. :)

We can attach V2 page table to a device. DMAs without PASID will use GCR3[0]
(PASID zero).

V1 is AMD IOMMU specific, V2 is compatible with CPU page table hence it can
support PASID.



> 
>> For UNMANAGED domain (like vfio-pci), we would need a indication from core layer
>> saying whether we want to allocate PASID capable domain or not. So that
>> internally we can allocate appropriate page table type.
>>
>> That means from VFIO layer we need to pass this detail to IOMMU layer.
>> For this part, I will start watching your patch. May be we can start discussion
>> in that thread itself.
>>
> 
> yeah. Looks like you need to pass a hint to iommu driver for domain
> allocation. For the usage vfio+iommufd, it is fine as the domain_alloc_user
> accepts a flag. For legacy vfio (using vfio iommu type1) usage, it's a bit
> tough as the domain allocation is within kernel, userspace does not have
> any input on it so far. And vfio type1 does not expose the domain concept
> to userspace, it only exposes container which is kind of an address space
> object. This means no good way for userspace to control the domain
> allocation.
> 
> If it's only a matter when PASID is enabled, perhaps we can skip vfio iommu
> type1 as it is not supposed to support PASID.

Right. My understanding is with vfio IOMMU we will not support PASID. SO it
should be fine.


-Vasant
