Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69746F4A6
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592325; cv=fail; b=cXui+0IB01xTIhWOSaM+Rxcxfs8vACQMTjTTE+APVg+hAXWzrmWdXuvzP8x6+pqbZ5Q10HYpcZ2BI4qy+MKNYEn0tWL6PTKStE4Q0pgf+HRCuyqiff8vhC35Y2KoOriPHH46OR+MJNmmHVImNO2J7h3Uolk1crGhAkwKr3D8y4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592325; c=relaxed/simple;
	bh=QxWdUmfvQTFc9rfMdiq9ISYUEWuXdtv/ogAhvlj9lhE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=pu9BK3FK58bLMEBDn7l/vED/WoCIuaGUloBcf1J7XArUe4kSFmOAplgWIRG8IykANdAsa/cEWbWAj3onbx6A+czfI7a7kCq1vpfwZdXhjWNkwNkAhmkX6l7HYz0UNrmtFMsyumVj9YVAaGHuonkZgO9AYP7VsG8DIIBjkBBXfSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D07itNRL; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D07itNRL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IER1FR/aRF5Zr8BqAKsJ4Jf7yM3LXUr3w+24WJqjcbknuvf4kIzQsHMYb7NE7W3qSjluPwMUK+5JhhJH/trO50hUacMeCmkK+lr4jqqWGtwfXvaOcvI3TWX7nMtUqga/F+gEyrNRdrVL5/9l11NAJfjqHyLvlSgMyVRHU3PHzsqoNJThz/MXS3tcuvKymPF++fWQ/2r69+53jrIrfGoWAa6gB7xTH9fU75pOKbVgeeEkUQ3pAtrwJapOKYNfnppZLikR/VY4ichANZaSArAECi7C+lG1OR2xsycuaZxsUvSvfWXs8q/4RVhaEpqTfi5it5IYDCO/Hggdl3SsvfEC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqazsGLDbqNJINOTDMTtxIG9uRpCw23QmK3UYX8InDw=;
 b=vW7h2PkQTI1i8cOMbfjwpAOG4Rasof995SI7v18N7WcUje2DfJX21VSouB/E6PwEbxrthPnEMlx5Y11DFiUoqwxA7KI4QSuGU5O+4XJvXGjz8v8k7+TsoxjYV67kk61TDpjVus9+5dFlGFSbXfl5mafsgGyG/RS125YhRcRiXqFgtj8JAK82LCBuxNbxHLqR/Xx3nhieDvO+u84u+uPwl3vIIcwfLdZxfePjcD9RJ9bcWyU5aQmRiP4wUQVwHWGXfX8GlhcxKeGPdl8hcUcMXnieCl/3uyvFOwQjEq8XUpmdcciNRVCQRIor3J1JUa+4Q2602nWDOSNeqAIOoiqc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqazsGLDbqNJINOTDMTtxIG9uRpCw23QmK3UYX8InDw=;
 b=D07itNRLXZvZ2MnXZNUeDBubTXMTjMMK6gjpHFrxqarfhbtunPecpdXxKeL5at4sbs4PIX1N6EtMyFjGoXn5XjT0tYUObDxTHPBfhaB2QMafgeMI1h4mSY2r27WVZh/Ej/6/Ucz8zLu8QqIJN2updayZlA3jP3j7oiaNl7cw3PzkK7DsyojpwYUAEKo34kmlTe2y3O9YzvokOvaifSjUceyykDXuNeI1evBJgB/7UDNkzjv2F/YznhW1y7yBtkglYlzyJ2SpdNWx3hJDsgX1WKgwfX74WtWInJGsMwwX2Dw8pIxGif5OEuFT0ezcW5LCzLl4UtwcqKnIiUWbl1V6kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-8-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-8-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229632.3131778.14367426076892981788.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN1PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:408:e0::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: f98b31fe-5bab-4c74-31ae-08df0204a448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jU1Dojw0q1HmlGhqE+N/1PG1DHIXD6WkZqICxD1IgA/IhVd4LQ/CWEDz9j7Hz4S9jR3O+934CKn7Gl8KoFFE2y/0OUzq4fnnJaTI9H+xzMGWOos2N2BYLq6dXmIa5L5avz52P3Puwxw7VCjl5O0LvkerqcirgC6+SszTB+LIkY64kxgx3ae5GfsSe+pYTDfw70yzcQwWndxsV7bXkk02hi6TJlQp7gIT6jRd100BGXTOFf2lf/bWlP+tbLTdr+wcvEApC97U1rGu3GTj3jHru9SlI5cfveQu+1HIizm5HYkexUcmf9O1uU+Lnsw/qa/HZ/uMxn+hzYuiTwTRaxS56inH1wDO0gGhUVnvB49quy9Kdx0VACzHvRl1IhbBcQHAGwCFC/+RRXQLXavEIDvR6rWK2/sdX7Yh/eSJnTHbMKk/jZx0yLYEVZ9iWrBZCzovXeu3d7aVYXmKxm7tIzwmVugq6887m9iVH5RepMXjjyxbHcoTc80C53Ga9bv0T9EoostEjeMvxwG3lonB4ol0XXIVWEIrTO+jwt2zK0WDbGe79JENsUnlLmAiKMKtODKlTwfLutM+ro8XGvwpkkOnpoZIXhwnhlLJOiOzlKyTTB7sCONM8nrOOjS7UiBmA804PAYInYJMPyg+TnyxAL7prI+XuPcHyyJhrQZEAANh3Rg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkhnRWlvK29aYTJ3dlYzSzBWMEtjUk90YTRIdm9EdXBmS2hieFc0ZWl5Qm5t?=
 =?utf-8?B?Wko0SWFtV0RTa203eTZra04rZ2gzaHBQZUJQVGdtcjN0WnJHaVZnTVN0Vlpr?=
 =?utf-8?B?S05QYnBIREUramxIYVB0b29FS1dWOW5KSlN4T2VFcTltOE5iQ09xT1dBWDFw?=
 =?utf-8?B?SElFbUF4QjJUT2s0c1NObGNpUHhmMVE3UGNmcDF4d0FVa0hsb2VYaU1BR1VZ?=
 =?utf-8?B?LytPUFFMdXNWNGdEV3lJamY5N3E0UVg4d2trNGpsVlRZU1gzbG9YUTV4TUtI?=
 =?utf-8?B?VzVVVHRySGdzTmdkVUc0TVFpNlZHblJ3UEJJYmZQLy9YNDNobWFpdFR6dk1u?=
 =?utf-8?B?WFRuR1M4NzBpV3QzZDZrdXU1eGl5Tkp2NktMQ2hJeXhjbURBbHJmUWFua1p2?=
 =?utf-8?B?ZkJlM3NldHZYbVRiVjlpNVgyZGM1WmpQcjN6Sm4waUFSOWloRTExYUNlK1NV?=
 =?utf-8?B?L1RJK091Sk83TXhxVHpGTDFqV3RxNVV6dFExdDBsVWxHVGlxNzk1OHovTjJF?=
 =?utf-8?B?R0wweG1MVkt4ankzb2hieE9GMFVnUVYrWjNIRjMyM21Oa2FoUE5YN3BucWc5?=
 =?utf-8?B?VUJYcDFRZVV0TmF1cmRmeHhMRStyYzN6MWdMZUVOOStoRWk1Y3BuZkJ5dnNU?=
 =?utf-8?B?SzRoWjlHT3hjOVU2THpXSk9jeUpsd20rNDBUcUxSR0xVcWprM053bnd2VjRt?=
 =?utf-8?B?NWwwK2JnbG9tR05PS1ZteVR3bGROY2tTdWo3OFFDUXNzVkxsMVV5c01VUVY1?=
 =?utf-8?B?dXYwZ3VOWFhqKzlkOWhZTTJBZnNLT0htTU1GTzU2cG9XSjM4WURRWnB0Wi9P?=
 =?utf-8?B?K2kzdWlFaDhLdVJudGxiditZMlZBUTJVMXE0dFJlczRJS2VML05qNGx5S3Fk?=
 =?utf-8?B?MkV2am02YXdKbnh2U25IZ0ZYNklRTGY2RzNXeTVkQ0JrNzdNSURwNytKR1NX?=
 =?utf-8?B?OU9ta0RmZjBUanRKbllGcjdrYXFkSU14YzJNcVRwa3ZQcUVaa0lSUkZ2RjFk?=
 =?utf-8?B?bnkrYklpVnF1bzdwK0xwanUvQlVTN2VWdVpmNUREdlYyZjdvenJqZm9Dd0l3?=
 =?utf-8?B?T0llVDIrK3RZTVVjcjhucG9ZRitHbHlycWw4T2xsYjVXQno1VWw5bXZwRkM3?=
 =?utf-8?B?OXNkYTBocTZkTnZhQUphZFNjWWQvRzFkcnVxc1NRQkVucDVnSHFvSWtTNXR3?=
 =?utf-8?B?UXVhQUlVSDd1QjkzamUvQmlOSW9GYWFLTjlZTUR3eDMxTkVKVVhpdVVEakRY?=
 =?utf-8?B?U1plR2RJcXk3eWVZRzJqMlhxdmpmUjdSYjZvTzc5ZkJkWFIzVTNGU1FXRTdL?=
 =?utf-8?B?Q29GQWZOU0g2SFZtOFJHbVVDWWpMUWJQaUVHWUJXMnYwbnF1ODlXOHd6eFk3?=
 =?utf-8?B?NmhKTnBWSjFIdFFRNHhtbVRyeHl4TUswSzNZY0dFaklSRzNVQVNCbUsrTlR0?=
 =?utf-8?B?d3BkZlZ4K3FMV0ZMNlprMUtNUm96dUVwaURvSUt5UGVKblZldFcwRGNoRVlF?=
 =?utf-8?B?U2VERnJjVFJXNitIQ28zKzdPU3Via0VnWlZscTVvakprRjRiM2pRWTd3NzEy?=
 =?utf-8?B?OEZ0Umo5R1hod3dlb0s3Qk5KMnFXSHJ3ZWNhd1RZUHRycWZoK0dVOU50ZzFY?=
 =?utf-8?B?ajV4QXU4Z0dtUjVtOE5lTWhOcHRPYzBOVVhTd3RBL0pCTlVmSVF5bWFQNTQz?=
 =?utf-8?B?Wk40N29VQWUwNHJSbDlUbS94MUdMSUM0OE8xSFB0U001MktkTUs1UkdnQ2tQ?=
 =?utf-8?B?ZndvUlV3cXlFdGZhVkhVcWh3eHJxcjJuejBaSE9FVktobFVNSjRvalFHcUYz?=
 =?utf-8?B?YTZ4K3ozYjVlSzVNM1Nrbm1OTUlDM1lWYTlBVzRMVUp4NXdDcy9YL3JVd2tR?=
 =?utf-8?B?cFUzYkZFUTZlUWx4V242dWVRc0VleW9TOEhDZ2NJa0NWbmNNd3JVS0pwcHJU?=
 =?utf-8?B?cTJvakp0d3MyWUhKMkZqUzdPRmN2dGUxdVBCRXQzODZUSkM3VzZnUzdFUmpN?=
 =?utf-8?B?NWV1RnBEVEhqeG5XSFYvVVRoSDcvYjdURmhnaHNSTExzWlBjN0JwV05yWXFs?=
 =?utf-8?B?aExabmN6Unp4R25zUHRhMkgvamVHOVQvemxZenpoVXBWM0NpazlQSGRXVUhO?=
 =?utf-8?B?c1p6bWpsa2dlWVVSTHE0dmNhZksrTEthNWYxMUNkMXdXaFdTYmpNZVA2aW1t?=
 =?utf-8?B?ZytUMmZIb2p5ZkNkWTJOS3VNVmNZRXArVGhVd3pmZ01LSzFvUXBOaTJxeXBL?=
 =?utf-8?B?T1Q3SVFwMDcyRGtKenpjSXBqTHBxNnZBNW1GRnJZMkxybUJyb05NbXZraXQz?=
 =?utf-8?Q?Q3RON2aMkl0CaiKDoQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98b31fe-5bab-4c74-31ae-08df0204a448
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:07.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPWSmH+gS46rUjADrb2O62WSijJQcqYWLcRTpugfA0BPAGffuhkD2MgIiTYpBtti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:28:56 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
> This is achieved using the iommufd_viommu_alloc_mmap().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
