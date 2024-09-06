Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBA1CEAC9
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631698; cv=fail; b=laJUTHvEzVBEfN2odVLTHnQhD2iT6tz8oEjaqwgrv9G9sRhhH/mcN+DKm2NgGvbbBQjnk7uP54A8HGz2/lGqglolcLd10tOjLN3OBLNkLdtHU1cdpHfULQOQdG0fOBTWUfiy9FknwIklMBasUI3OmmLePk7Syyd4Iz3BE0pEw0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631698; c=relaxed/simple;
	bh=sp92ndvPXfZhQt48fN3xBQ2PIJN76g0M+IX0YiDIvmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b4pnc5WiyhrehuKmoYyfeEfXelcr6OiAgpwQRVoOeFkr87dwAZX3PYEDNTlwA5e2HhdOJa41b4cOdHtgzBGz7Vrgs6jtSq1EtbLGzkLxu9s6YFkFl6YFv7AJVrE6pygCMkE2hR8CQyJ54dfMDZocp1XB5qObrcJMLLNcjZ6mjxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZEBzVG6G; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZEBzVG6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5OacEFkEMdQbttwtBBd5fQKl6gZzVwnQCdevgwAuyHK4cIisUTvlHuWUI8YYkpPjTrka2/FocQj4uqWYGWOyRri42ZI4gsJRWnkgZxL/Xz+JPBRq3iuOcyP6/6RwGVD8ydSANFh/OcBxi7gK1PMxLqJrkkxOki/ewVOGbZU1R4OmecGW4TOXlb0BqC2jLRKb0qQbhIlIy2T36xIm52bbZ4fbICwL0meENA0TtWHgyLaUMFue8NZfoVmHyxMDCFVp2J8skWlisZdcYNEtNm2IgCGnYIx9CcpNmCOTMSMd0bdCqXsRga8IhbMnRI1kWFuZrHlN+Of5aGPa/u2xYB+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx5ZXtHO4W5KkUMz9KMV3pZ9k4tVJvirLtzBvjGtXS4=;
 b=rJ7y24rJV1wAYE4UW/Jo3eX5i9/moCxiF1SR3fPXV0gI1GvMFeXn5QFIsv2hEWi5A425NF2h5U8HAD/53i/aR2hseCePaV1WpdzG6KAyR2aIKoTAuFGHOFriTZiMhJ6/xUut2BovbZOzTKQNIy1dTiw8OZY+eHRxVRi/J54CWBqtUCkFSua3zAWsGlMScBYDOae8evlDl4cWcCC0SHsQ/QyT5EmD6S0AuXaBeBDbtOvFBSi4tq3ElCiLnc3BrNrgkVI9qH6lrau6tlGL7RkciWzhbc99HnifBK09bw6fbUYXXnbxEGStHHbT/tw2791nPOIyCxtX0ahNLUXDfxzlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx5ZXtHO4W5KkUMz9KMV3pZ9k4tVJvirLtzBvjGtXS4=;
 b=ZEBzVG6G3rKgg5M5KwbRBCVuCSqI+xba4+J4TESR+BSTaQVU8e1nKXoqYCxLH1GHb8OhS+EQlMr07FbMOdb69zVGLZeszoIrkuE6MzN2F3gRPm3AT2LNapETdml1jOUBT1IUDCbQD4EqT4oCM91qTQOZvfbzFphNMI2zjCO2Rwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:08:14 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 14:08:14 +0000
Message-ID: <7536443a-9871-49f3-a42b-28320dc57fc4@amd.com>
Date: Fri, 6 Sep 2024 21:08:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
 <20240829192804.GJ3773488@nvidia.com>
 <4c72db01-448a-4bda-89e0-9c92a2f89154@amd.com>
 <20240905182105.GZ1358970@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240905182105.GZ1358970@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 424f2423-6e32-423c-dff1-08dcce7d58b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0RpWXdJaHU1bEtnQzRGMjBwczBubGQyelpKdUZma1hiVWUxRURxaUw2aUxw?=
 =?utf-8?B?Y2diNGpCbnZOSjlzM2lZeFFzWkluZmtVbVMwcFVhWHFNanQxMzJTbC9ZUExw?=
 =?utf-8?B?bGlUcGJXQ1pvT21GaW5oTUJQRllhVHlEOXFkQ2xFdFhWMTVCUk1ZL0wrMU05?=
 =?utf-8?B?b01kOU82TUFuK0ErMFFrT0RqZG91TERPanZFTGw3L0dEVzdVbTVNbG83d2Fs?=
 =?utf-8?B?K3YrMy9wQ3V0ejhRN1QwK2hIbkMxMGJOWllYMTRxVkN2bDFOY3RzNnJTaElC?=
 =?utf-8?B?MGhxOG8za3ZaaG91U0lWSmQzMzNZRzFsWXh6MEo5UE03MjFsVVhzdGh1RDRB?=
 =?utf-8?B?R2ljdzlSM0todG1rVWtGWml6bGZXM2RwVitJZ3pReHFRZ000eFJ2bCtzVHQv?=
 =?utf-8?B?Z3B5RmNPbjJ3TUVKNnhrUWx0N1UvdVhXL0krODdBQWhEejN2Nk9MSzYzUEF3?=
 =?utf-8?B?a1VFdXN4Zk9HVVlMK1pWbmtSa1AydmRuZ3RPWnJEQ1FoQTUwTzZvUUh0ajUx?=
 =?utf-8?B?RVdoZVFVV3cwTC9waG9CbkM1dUJLSGoxYmdWL0xYYW9uanNjajhtd0RrZlMy?=
 =?utf-8?B?NmpBaTlsUmJ3cG1EdFYrOGNaYnNMdEZkSVJWWjhqZUorY2ZWQXduYm9BcUoy?=
 =?utf-8?B?YzZnR3hHQ25sNHl5MVBOOCtxMXVaOEZsNHd5dVpnQmhqRDBxRWhNc1ZEdUxn?=
 =?utf-8?B?YWJlYWFPRVM1UTJNUnRDNUsxTGFsWlEyVVIvMVBaOG1CWnZFeGovbDA2NFpy?=
 =?utf-8?B?QmtkL29wYWZaTnRuREtFWlFaUVJoNWtxRkk1UlgxOFM5TGF4K1Z1OWdDOEhp?=
 =?utf-8?B?aVUxWk5pUlExUzdWVFdVUllpRHFXblY4bmplOUxlY1F5Y3VCdm03eGpSV1pq?=
 =?utf-8?B?aEsraUhGaVVuMWZyQUo0R2dnQnFHWTNvTG1lZVFBdTlPa2JUajFVTkZPZVVN?=
 =?utf-8?B?Mm9vQnE5bnh3a2lCV1M3Z2NzZUNwWldodlRNMWdJSStVZmlBa2tEUUJERkhT?=
 =?utf-8?B?T09GbGRuWDc5b1NOQjQ4QUFWL2I3ck9OSlE5cTNYT2FWVUZPZmVaYVA1MHNa?=
 =?utf-8?B?L2xBallXemVxRGd6RmUwOEw4NkdmL3BJNlBVeDZpQ3lzV2VCRXFLK0hYck5o?=
 =?utf-8?B?NVVsMFZiNGhFRUhVSXVkK1QyVGpoTmhXZ0JveVJUNXhxU0dYYUJkK2J0cmhr?=
 =?utf-8?B?NDZHRWdYZytlS05JUVRvYm8wbUo4Y1JTQldGS01RNTFvYlRoOUhLTEJJTXFj?=
 =?utf-8?B?TGY5Yi9TeEtxbko3c2hjMFRKUGJaMi91UW5vTXNMbHc0bWM0SzRMbVg4RjU0?=
 =?utf-8?B?Rm0rK2ptbTR1ZkVnQk5XODdxTlNvQlkzalhmdktFbmFwNVBzN1BwSG9jbmhw?=
 =?utf-8?B?ck1tUnFUenVsQW5PY045dmUyOFVhNWdXUjQ5eXZBVjBMMEhraXl3Y0VlZnRu?=
 =?utf-8?B?RnR1dkZJNmczdndoUHJySVdveWVUVEQ0RmdZRitkdnpVU0JFY3BiVlJYY0RN?=
 =?utf-8?B?a2F0aEFkVERtYXhjUElOUDVSb1VNKzNreXpKTnBac1BweGljTWJVMURHdVI4?=
 =?utf-8?B?NDVnNFBGQ0ZaODNod1FXSWlwU3BkV1p5cUxIM1FCRTRNcmVleUxlY2s2VFJx?=
 =?utf-8?B?S2hicnptbitiRU5Ia0hEeDcxaEw3N0xNb05VWC8vdFVmNG9HWlNhdEpEMDBk?=
 =?utf-8?B?Vmh5UE9ETTVEVGhkV0g2ZE8vRXpsbk9tYlNGVEthakp6dU50bks4a1BQS2U0?=
 =?utf-8?B?OXRNdDNuL3hhcHNVRnJDNzllR1hxcHJqdThkSEdCUlJHaUYzL0Q5NnZRK0JY?=
 =?utf-8?B?RDl3djJ0SzY0S2dmU21UUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkRTUC9CQTZ1enE0NjZnL2JTVTdyNWVXbmVjZG53L1ozWHJvb0ZpWG96YVpQ?=
 =?utf-8?B?YW5WMjNTVVpBL2V1dTI5SXJBV1Zuc2I3bWdNRWh4NTRBSkZPSnRZL2VYell4?=
 =?utf-8?B?MmNrS2k2MWF1a0tKRUdXZEFFc3FhUnJNcm50Y1dpdDZpVGR6ODAvWG9peGNu?=
 =?utf-8?B?eGE3TmJsb0xUZmRuUEcwT0E4empnWk9IOFFlb1Y3d0VmY3pzWGtjZkhkc1BY?=
 =?utf-8?B?Y0tKeitMa0RNN0hnZ2huaTRSUkRtNXVJVll4MXUvN0FFQmZpY01iTHQ5VTJw?=
 =?utf-8?B?cythaE9tSjlaZlJ4dXgweVNmY3g0UmQ4NFV2b0t2TDEyVHNxZzFwQW5obnJ0?=
 =?utf-8?B?bzBnUDlSeFk3UFg3TUhvNzhUeTc4T1cxaFhYNmFpOElIOVAyNWlGNTVQTEp0?=
 =?utf-8?B?RFFhV3pHMU1TMG1FVjhrN1BzQWxqSi9OZHhrV2Via2t3VDdQT2xTQ2wvTjl2?=
 =?utf-8?B?dXFPZ0ZMN2FRNGJsci9NY0F5dzJnUzJxSTlNYmowL3QvNlhiNlE3elpzOHVF?=
 =?utf-8?B?ZFZJZnVTY2szc3AvWmlSelp6T1cxT3NWak5JOVF0ZmVHeWhIYUh5T1ZMejdB?=
 =?utf-8?B?TW11WlJzckpBWnZNQzhSWW1SSXFLMnBOdVlrMUM2T3cvZFNkSC9zbDNHVnFD?=
 =?utf-8?B?ZFNQUHp0bm43eGx1ZlRBOXZHdG5uVnY5N0JCd3R3YXR1dEdBaWZnM0t6WEwv?=
 =?utf-8?B?ZDZINmtkdHNkNGp3cFNHS0lJZERMbi9kTm8ySjRpS3pGWTV4Qi96R1NrRmRT?=
 =?utf-8?B?QU5TYzlOMFZmZjRQRXZHbWJGcFc0YkI0bHZSVS9kOEhhSytKUHNmZUUzU2d5?=
 =?utf-8?B?eXhkaEtkNVBIUldqVDJwUFNIZFpMRG9ZQzZNN3VQTWlHUGJ1YVhWUk5Idmox?=
 =?utf-8?B?NWF6cVpnQ3FOcVFFTjYva3dqUGdBWVNnRUJpUlNUU1F3RW42Tmp0cTdVOXI5?=
 =?utf-8?B?Tm84YW1nQmxXY0Jsa1prNldiMHhZVFErTjk0WDBFTEo4b2pCUHFtSXQ3MWc4?=
 =?utf-8?B?cWU1QVUreDc1M0ljclNIY2h1Z1JyQ1JTTkpYZmliSDJBNzBUTGtNZ1pubGNu?=
 =?utf-8?B?Y0hYalYxOWJ1TkJzRC9IZEpCRmxKUUVub2FGWXpzMFphRFlIaHhUR0dLZ01B?=
 =?utf-8?B?OEVwbGhoQW5weENzY0FOVk9LV1NETUYrMW9LdzFJRXJoYnFCZFhqdGFYeU5n?=
 =?utf-8?B?SFJJL2dLZFk2TDJmRFFjd0tjMyt6azdCYjVpWktYUCsvU1h6RFdKS0QwcS9Q?=
 =?utf-8?B?S05GRVZJaG0vcGFIREZMNkhBOWhsTHFXUUZ1TjJxZHFxRG9zYk4vUEg4Y3JX?=
 =?utf-8?B?UHhnMm94Y0RPRkRydklPNnV4TndyOURmYkFsREQxOU1oN0NlWUx2MldxNENY?=
 =?utf-8?B?Z0hlZkhwZXFhdHlMdlNlRklicTBlN3JqclFwMEd0Z0lpdEw1THl2djVmOGdt?=
 =?utf-8?B?L0s4dEgwaERSdTN1enByblc1R3VWVXF2V2gya0JQc0VHdVVPZHFjNlM2cWY2?=
 =?utf-8?B?U1N5aGpSU2F6cnovaFFrYWo4ZHMvZko4bEtCSDh1Yk8rUjg5ME5SN2xST1VI?=
 =?utf-8?B?UUNGbnlNSUFuQ0FEWjJHUWRBbjFzU1Z2ekIyWGxZQVA3SmlHSnBObEdhWlVT?=
 =?utf-8?B?ejQzSXo5T3g1dzh0V0FhQmFWbWlTVVNFTmx3MU9SME1ScXJSZitCZTZya0JM?=
 =?utf-8?B?RmYwcmZsZWZ5Sm5Ndm81NkllQ0dvOC9hb1d5emJ6ZG5oS3JNQUlabUhhMDd1?=
 =?utf-8?B?emI3aGhwODY0VWpnNHg3Sit0cUxuZWpkYXNYbEpRaWJKQVBpVFF3ZzRtK0tw?=
 =?utf-8?B?VEdwZWNDd3NGNWlteEx1b3ZxRmdPMUEvS3BpMTcvZFJuWUdUMFRBcksrdUZW?=
 =?utf-8?B?SkY3WE5rakNnRnlEVlN6YWM5YlBlTVI4MGVUVmc1a0EyZFJkN2xWUm9xWlhS?=
 =?utf-8?B?WlhaSkFzWFVwK2I4WWkyQVdqelZEWHU5NWM5VG1ycysxd1dRUDJCZ1lRdFc5?=
 =?utf-8?B?UmZwR1A5Q1NtMVlGMWp0ME0xbkN2eSt3WnZnTlFFL0tJTzZOOWNIazlTT281?=
 =?utf-8?B?aFQ2eDlEWkNwOWZjYWtWU1M2V3czOVFKTUIwYS82TVR5ZVN6UHNFekNhZGk2?=
 =?utf-8?Q?5BFccnz+N9adCTB7fGarmsIYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424f2423-6e32-423c-dff1-08dcce7d58b3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:08:14.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqxeMRHTE4Vloa3yGTWcns1Hr3T4WtgD4eff4qV7pg0TuF6OZ3FoMMIKcbfq1F2PkZslyCRV/L+jzjKwYS2GcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

On 9/6/2024 1:21 AM, Jason Gunthorpe wrote:
>>> I don't think you should restore, this should reflect a locking error
>>> but we still need to move forward and put some kind of correct
>>> data.. The code can't go backwards so it should try to move forwards..
>> In case of error, what if we pr_warn and put the device in blocking mode
>> since we need to prevent malicious DMAs.
> IMHO a WARN_ON is fine, and alerts to the possible machine corruption
>   
> No need to do blocking, you should have a perfectly valid target DTE
> that represents the state the HW is expected to be in. Resolve the
> race by making it bin that state and move forwards.

What do you mean by "making it bin that state".

>>> On ordering, I don't know, is this OK?
>>>
>>> If you are leaving/entering nesting mode I think you have to write the
>>> [2] value in the right sequence, you don't want to have the viommu
>>> enabled unless the host page table is setup properly. So [2] is
>>> written last when enabling, and first when disabling. Flushes required
>>> after each write to ensure the HW doesn't see a cross-128 word bit
>>> tear.
>>>> GuestPagingMode also has to be sequenced correctly, the GCR3 table
>>> pointer should be invalid when it is changed, meaning you have to
>>> write it and flush before storing the GCR3 table, and the reverse to
>>> undo it.
>>>
>>> The ordering, including when DTE flushes are needed, is pretty
>>> hard. This is much simpler than, say, ARM, so I think you could open
>>> code it, but it should be a pretty sizable bit of logic to figure out
>>> what to do.
>> IOMMU hardware do not do partial interpret of the DTE and SW ensure DTE
>> flush after updating the DTE. Therefore, ordering should not be of a concern
>> here as long as the driver correctly program the entry.
> Even if the IOMMU HW does a perfect 256 bit atomic read you still have
> to order the CPU writes correctly. It just means you don't need to
> flush.
> 
> The guidelines in "2.2.2.2 Making Device Table Entry Changes" make
> this clear. The indivudal CPU writes smaller than 256 bits have to be
> sequenced right.

For the interrupt remapping part, no special step is needed if we can 
write do 64-bit write. Similary, for the address translation part, no 
special step is needed if we can do 128-bit write.

> This section looks like it was written before translation bits were
> placed in the other 128 bit word - it assumes a single 128 bit write
> is always sufficient which isn't true anymore.
> 
> So you still have the issue of having to decide if you write 128 bit
> [0] or [1] first.

The GuestPagingMode bit is in effect when GV=1. So, the higher 128-bit 
(which contains GuestPagingMode bit) should be written first, and follow 
by lower 128-bit (which contans GV bit).

Thanks,
Suravee
