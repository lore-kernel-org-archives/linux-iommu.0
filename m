Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD415B13D
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955358; cv=fail; b=dVcxf4L9I1DAOLfDtM34x6UnF/K5OWC3N/VjFXHXGJtpdBfBTwUHQBkl6J081gsU+3k78P/lV2L77FLhUhf7eKYESyRC+JL0rtkSJJzvnlMGYkJQIBi/nVUNY7pVJAFR5gVCmxpfOtUITDGUHoLLAbCdBTy++RrIbq/xQ/uWkHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955358; c=relaxed/simple;
	bh=Fj5rfM5mqKml5FQa79TSO6LP/WNZxjb3ktP+ezWmyHg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpUzljveLpO7wHW4JpMnuor2i+B25xIildeQJVjpzwt4cQoYh7RA+do+0Pg5vXcAJNbJV3sHNHApX+9YdpeH888sz4xa22WGPynvb+qcQG2Mm5rlHdfLBHcNTCq9IIWrGjqtIzJBrgwsfIumeEMFQNRzmV5gvkvg2u0pxnpDxHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/haz1i5; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/haz1i5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSKr6Q8pp7nQCdy9d2pV43Ww0x13ZmWvGp9zNyJM9d3Vzc1s1fdeuSPnTCGUld9MVHflrTPtd3MplMmuXaRZ0yAve0+jk+1en66QJB2r8JxN29SnAszrx8j/y7J8Pa1gBCk2n9NgYNo38daShrS0tgXHqHdoh3DSvgsq35uiCGBBx+Hb3MmkHcRHT5v/b86HwA2A+kRe5mFoDCa41uniODrU7ftie6Up9ESZ76OyX4PXdC4UdYGMgL5wx8n5wzrvIVrcHeGyW9kuZ9TNdod9/75NTKrE8aLVleIiuvpjrGn8BEym27WjXu54ywynQxyUiVBqXzWTTgmWnrw0HULk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6aFgDwON8ak/Ev2jj+R6AHXL60fOc8Tl7stUhpQLg8=;
 b=UJ5PfvW1xwH7Iy6i7MZU8pWu7k+Ky/aa8ywGpunUZM8yeZOYsWgMLMHWXSkwnwdwvaDPX9XiNrSHkET6YrEs8gNo92BXSLcmdWX/f7HIiYnucNceViMGOtSLqBSPVNdeDZz/7/5oFWiAfE2PBjr7XPtpgChnxhhtshcplPIs5vvnIml+FTln111KSM475Fq3GOtPtEIRPoMRTBXa7I0soqVoJXTcv8Cp3lbZhXoBQue78Q4apkjDxLYGQFKIq9XtpMMKofSJZP1J+o2HRAl8RHRIPTwfk872EXn/H3a+InebkHMXAe0R6KtcqNtG4wz2f68s39HxBLglOrDuUxOYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6aFgDwON8ak/Ev2jj+R6AHXL60fOc8Tl7stUhpQLg8=;
 b=s/haz1i5lLuGVxLYJwuJGxLKeActz/5xqMQaUq0FHnaBmL4SkOjRojHbkzpwiDRWpU0QytjTTV6U8dHPI2e/y0lXDaHT+cg8s4Qu7h39qd7jTfvgV3XzQwVT0yz0RV3anN/OSXVmaVDTByvfqRXAPIN3vNu/lMlEnGMfXKW2FYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Thu, 29 Aug 2024 18:15:52 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7875.018; Thu, 29 Aug 2024
 18:15:52 +0000
Message-ID: <58169757-69f5-45fc-8657-82763c71803b@amd.com>
Date: Fri, 30 Aug 2024 01:15:43 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg
 operation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
 <20240819170939.GI2032816@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240819170939.GI2032816@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edfc4bc-1141-451d-2613-08dcc8569dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVNRG1GMkhOTzVxcVE1Q2UzT1hnK3lHeDkxM2g3WktKQ1Q5V2xuUnFEUU1U?=
 =?utf-8?B?VGNuRG9lZnBUei9JekRJRFZ4S2VZU3E2Rk5GTmZxSVJvWE4wU3gxcDNOcEdR?=
 =?utf-8?B?akYwVEZGdWJRakNMU0c1ZWNLOGExOE1oeWtYZFhmaXpFWDNQTEp5SEVEa0Ji?=
 =?utf-8?B?U0J4NEcrVlZLbUc5aGVxdFVzSFJpMStQY0VFc3FMR2VDZGpqQVdWMFdtQlds?=
 =?utf-8?B?MGg1VDVFd1ZzNGk4TGF6Snc4ekZ2Qy9nbkJqdGNzU0NkVjN0eEF6QVZKbVh5?=
 =?utf-8?B?QmNCOGJBMjZ3aTgzQlQxaUhubTJxRmRoZW9zcUh3Mjh0UVM4cmw3Nzh5MnlS?=
 =?utf-8?B?ZC8yNWYxdm1YVElLa3N1N3p0ZlVYTW9YNVdzdTZFdGJ2K25qTkp2R1EwdGI2?=
 =?utf-8?B?citCaTFJNks2ZVFLanJqOTJVVGNvaEt3RE1ieFdoT0ZveVhNVjBSdTNlcTdP?=
 =?utf-8?B?cXFlYWRvTUVVR3lLdGNuNzBSamtBeUNQemdUSmxyR0dHNklIODRJQlhnbFVE?=
 =?utf-8?B?clc3MEIwdVNiVVZUMlltdzRuNVVhd2gzdEFoNVV4N3I4c1pVckgxYWpQOVRm?=
 =?utf-8?B?b2Y1c2xCOUtoN3d1cEF6MUkxb3hmcFh6WVN2a0dPTWg5RG5PL2diSFovVUFr?=
 =?utf-8?B?RkVoTTlIL2hwMXo4MHBsa2l4U05taVJDV1Y5MEZJSk5QMFZWTTB1SlBMa2Q2?=
 =?utf-8?B?RTM5WHI4SWpSOCtNckpuTVNHejl4YkFwZWhMclV0eUh2RzZFSlo2ZjRLN3FX?=
 =?utf-8?B?L1BLWlFjZjQ3dURRb1hhRWxwQWk5QzNOakpqOVJwNEFoWHd3TXpJRll5L2Ur?=
 =?utf-8?B?clE1dktqaHNFTG9qb2lWelo4SjFlNDRaTFNXaDMvU3lGTldUSkRNN3VPaEdJ?=
 =?utf-8?B?ZVUxWm5FbUk2K1drQkRwM3BEZ0NyMXAzWXc3OUxEcDJYZ2lNN2IyU1NKSG9J?=
 =?utf-8?B?cW5zVDZvaTNvTVdxcThNL0I0ekZLdHJmQVovNWxsUEY4WjkzSmt6b1NKczhC?=
 =?utf-8?B?am9BQ0dKOE1acnRINzV5L2p2Y3ZyalNyaXRQT25XNWFrQ0RyMEpQZlVmNnBs?=
 =?utf-8?B?cFlGQVU1R2k1REhrSXRiYjZVbVl2YkxlY3ljYUpSbGFqQkI1eVRFSzdINFFK?=
 =?utf-8?B?SGZHWWhWWmZtcnVXdGJRQWwrdFBlbVZuWHNVMWVXbEQ1dG5qOXRlUXl6dHZq?=
 =?utf-8?B?MEw1RnRmTzNFYVByaVhuNVpaMHY4dkpWeXZSakVtMThXclN0Szg4WCszRit6?=
 =?utf-8?B?OURqMVBjVjYybkU2anBOME5rZXY4QVpFeFBJdlRWckF3WkllcHN5aDgwNTE0?=
 =?utf-8?B?OWxPWHlTTlJ5YzI4cTIzRFprQ1JldXNvQ0s5WVlkaXJHa0wzNmQybUcwWUlW?=
 =?utf-8?B?UmYzT2pzZjVyZFJiRmpIamdrb0tQa1Vrd1FRSytBbVgyUWFia0M5V3AxRk5z?=
 =?utf-8?B?RU83bUkzTlN2SkhNVlV6Y2o5UDJHQklRZ0xXdjJsbXNLLzJQV0ZQOVJuc1FS?=
 =?utf-8?B?b21kZDUvWWdMcFozbU1YM2k0R2dLMFdtR3FjQTJrUFJrdkhUclJJUm12SG9k?=
 =?utf-8?B?aGcrMXZvVGdvaDFTZjNhRzhBSUVubkQ1bzFQbnZsN0g4d2dGRHNOQ2t5WGc1?=
 =?utf-8?B?dkpZVG8xSVdoRWV5cUM5QjlQRXVuWGd6TDI3WENnN1NFNHN1K09heDZBRngr?=
 =?utf-8?B?cGpqUmVnUk4ydGxja0VlTDZ4Nk5YQWY4Z1I4UUtSMmh2OHl5K01lV0xyQ3BI?=
 =?utf-8?Q?OwWs9PynWXRyFjt7uA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE02eUNzc1VTVElxUUxCUHhjTU5BZEFmWGRWdjIvNGptKzFJQTQySWNINEZI?=
 =?utf-8?B?U0RLTmpOdW9wOEtXRis0V0lSMFI0T1htd0ltU2RZMUpvaUxYUy8ybU1kMm9T?=
 =?utf-8?B?bmlBZWRMSHJvczZDYWYxL1VqMHlVSXdzWENDZzFOZ2NFYW1tcEltWHpyU0xs?=
 =?utf-8?B?M3VHRzNLWnhGUmZ6emxvdU9YdnZRQWVMRzljSXZLVmNKajVNWHNtM3RuejBN?=
 =?utf-8?B?SERPWXpVMzk5UTcxUThjMWZ2S3VCZVJKMTBVNXMyLy9pbVNidDhMR1J3d0Iy?=
 =?utf-8?B?RVFMNmV5RmVuUW9sWm84UXE5WG5ROFZhMEtvcWpJUWwyKzJieFBmblJ6RWp6?=
 =?utf-8?B?UUdRWTNuak51K3RjeGNpUlZhZklKTHhNRHQ4YzhnQVoraEtNYytpYncwWkpQ?=
 =?utf-8?B?M09lS01ra3JEMGFlcDRtcE1LK3lMNFZVcFBxcWJoaE5icFIwMjJYSkRCc3Jw?=
 =?utf-8?B?RUJReWtLRTlTcHRNUm84Ly92RHlOOXN0bkdWcEJuVmlBTll5QWNaL3VWSTFk?=
 =?utf-8?B?cmI1TndYWWxVK053TjlSV1NWS0VTaEIwVTBycDN4eGV3VXhsOWpSR1QyeWNM?=
 =?utf-8?B?ZW9mYzhxZG1xN296WWszN3ZSTmVaQlN5ejVCRzNtaE00L1ZhL1QzeHZPT3l3?=
 =?utf-8?B?TlBEMUJrTzRnR0tHSk1nVjQ4bEhJWWZkdDhMWDJhejQrK21CWkl1eTliRXBB?=
 =?utf-8?B?YmpoL1ZVWU9KOEtjVHJGTWFhWDUveTNtYVdrUUVxQy9HRStjWVNEMHVEL1cx?=
 =?utf-8?B?M05MVTVLMWpaYW8wYlhIUE45aFZyUFNUcTRtZ1g1bktGZFV0NG9EM2RLVmhq?=
 =?utf-8?B?K001Z2paLy84d0NQYklrR1lvMmpneDFEYTExTFViLzQxY0EzeFMzNjhnekxj?=
 =?utf-8?B?WnNWT1E0L1RpOXFteEFXWXVueExJSStCMzRDd3cyNTRWQVRkY1p4L1pWTnBa?=
 =?utf-8?B?ZlhIVDJoUGk1cituYW91blIwWU1uK0xVMmxNb1FBUWJXRVJqNnZVKzFCVmRG?=
 =?utf-8?B?WnhZcnc5dkpUdDZveXMySDBFOWZ3SUI4SkZDU2ZGQWlPelZ6Znc5ZHNzN2NO?=
 =?utf-8?B?TUExTEdxcXROeGw0ZENVMC9pcFg0WWtxQ0NQWGNsbHFnOUlhTXdSOU1VUnNO?=
 =?utf-8?B?QXc1UjRWSUNPV1l4N0ZZVkw3TXo5OW05cmRGd3NEaGI0dm8yTUZ6Zit4cnBT?=
 =?utf-8?B?d0xvZStqRVUreXljTVBJNVRIZlliTURSdFhzNTlQNkpVY1FTQWs4ZS84eStO?=
 =?utf-8?B?TW5FTWlYSGlWQ0x6TDl5eDdHN2ZSNTdMSlV6UzdyUE5TVGNhdXpoRVFpeTBO?=
 =?utf-8?B?WG1wTnRpVUtIVU5EREZ5U2JPbDZNVmRwdEZ0elJqb0FMT0VPUzh4YzYxc3d3?=
 =?utf-8?B?V2ZMTFg3WmpkRHZJdUc0ZTgzU3JRNklJZjdPVjZvMkVtSFBsd3JDQU1BZE9Z?=
 =?utf-8?B?cDJpeFJ5M3VaNytTd0JDb3FUcXZEaUdmMGU0YkN2RFVTM1JFZXpHdGxFVXJU?=
 =?utf-8?B?aGl6clFXWnRTYjBGbDltN1EwcDIyd2puNXIxYURnRUdsT1VkTkprQXVvY2J2?=
 =?utf-8?B?N3lseUJ2RG1SdUNMSVlXQnNpUGVBL3laa1lYV2NuZ2VBaWpBUDNzNG00YlVP?=
 =?utf-8?B?L2c1VSsraHFwd29SRU54V0Y5czQ3T1J0Y0dhcHlqdzV2UG83VEpFWjJraWdy?=
 =?utf-8?B?TjhkNVIyKzdScUVoWVdtN1A5ZktGbnJWZTYvOCtnSmtQVTlCVHBxNmo1bERC?=
 =?utf-8?B?b2lBVy8yR2dPT3NycmNINGlxS3llYTloeVdmSVFwM1FyYnVKMEpvUklLUWZS?=
 =?utf-8?B?MmliVEVXVGxBdWVoWU9UZjBYZTFCd052MTNGQ0wxcG5nY0JwemFyeldDTVhk?=
 =?utf-8?B?dmhGL1NudCtBdkY2S0ZNSERKbVoycGRvaTc5Y3lIeGVHaU9xRXI1UHo0MTha?=
 =?utf-8?B?cDF4SGthVHpXZmVOZXRpMDNWMmhsak1xd1llMTczdU0wYThzM28vbFVEdEN6?=
 =?utf-8?B?Y29iTjJlZm9PeDdQQ2xPVkE5R2I1YVNLeXhmRnRVeHZEdGI1Z0NpeENncFZK?=
 =?utf-8?B?RVp2VmlRYlhtV28xZDNibERuWU8zOTNIN2EvOVN6SkQ0UlgrOVF6Q2YxRVBH?=
 =?utf-8?Q?T0w5Tjq/WX1al1DLi75DgpyqD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edfc4bc-1141-451d-2613-08dcc8569dbc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:15:52.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfVqQowIEQwBvbLXrxy36ZIbeOZPfarIbDCYZIockpMMdY/OPZ+Um6bkrmR5thgWUKTTMcG7jTLBOYYltuWzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

Hi Jason,

On 8/20/2024 12:09 AM, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 04:18:39PM +0000, Suravee Suthikulpanit wrote:
> 
>> +struct dte256 {
> 
> [..]
> 
> This would be alot better as just
> 
> struct dte {
>   union {
>       u64 data[4];
>       u128 data128[2];
>   };
> };
> 
> And don't make a new type. IIRC the cmpxchg likes to have alignment
> and the u128 provides that..

OK.

>> +static void update_dte256(struct amd_iommu *iommu, u16 devid, struct dte256 *new)
>> +{
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +	struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
>> +	struct dte256 old = {
>> +		.qw_lo.data = ptr->qw_lo.data,
>> +		.qw_hi.data = ptr->qw_hi.data,
>> +	};
>> +
>> +	/* Update qw_lo */
>> +	if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, new->qw_lo.data))
>> +		goto err_out;
>> +
>> +	/* Update qw_hi */
>> +	if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, new->qw_hi.data)) {
>> +		/* Restore qw_lo */
>> +		try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, old.qw_lo.data);
>> +		goto err_out;
>> +	}
> 
> I don't think this is going to work like this, the interrupt remapping
> code can asynchronously change the values (it is an existing race bug)
> and if it races that will cause these to fail too, and this doesn't
> handle that case at all.
> 
> IMHO the simple solution would hold the spinlock and transfer the
> interrupt remapping fields then directly write them without a failable
> cmpxchg. Maybe you could also use a cmpxchg loop to transfer the interrupt
> remapping bits without a lock..

OK, I'll as synchronization when updating DTE.

> Can you assume cmpxchg 128 is available on all CPUs that have the
> iommu? I see google says some early AMD 64 bit CPUs don't have it? Do
> they have iommu's? I had wondered if the doc intended that some 128
> bit SSE/MMX store store would be used here??
> 
> If cmpxchg128 is safe checking that cap and refusing to probe the
> iommu driver would be appropriate. Otherwise a 64 bit flow still has
> to work?

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back 
since family 10h Processor 
(https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf), 
which is the first introduction of AMD IOMMU, AMD processor always 
support for CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.

So, it should be safe to assume that cmpxchg128 is available with all 
AMD processor w/ IOMMU.

> Finally, the order of programming the two 128s depends on what you are
> programming. The first 128 contains the valid bit so you shouldn't be
> writing the second 128 after, and vice versa. This will make
> undesirable races around Guest Paging Mode and eventually viommuen at
> least.

Ok, I'll program the higher 128-bit first.

> If you have to solve the 64 bit case too, then you really should use
> the programmer from SMMUv3. Everyone seems to need this logic and it
> should be generalized. I can help you do it.. I have a patch to make
> that logic use 128 bit stores too someplace.
> 
> Otherwise you can possibly open code the 128 bit path with some more
> care to check the valid bits and set the order, plus the interrupt
> remapping locking.

I think the cmpxchg128 should still work and would be a simpler 
solution. I am sending out v2 shortly.

Thanks,
Suravee
