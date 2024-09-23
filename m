Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84519922E
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103796; cv=fail; b=PLbx5uMiXSH5l1cU54IaPxN2HnqGYXwOYS7L9B/AKyiM3miAC9o76NEiBu459vZhFsWbt8QwFIpOivswAokgTdcC/5oYyk5fmuHS83cBBZiCB42GOsd56kzzXngdjJH0ls1b3GYCehidg5iVxAeJUrUHMCoMmbr8I57MLAPmgC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103796; c=relaxed/simple;
	bh=Je/YFPOwiNxaH5uWZOSacbo6N/p4MZjEGEwV/mif1RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GAtpnClVamFQIvea+6JVoYUdU4nGudMZ29fSrU7XpXPivBiq/HecMIDiQDEMpKBvN5TNpldmHdSyrpfDaODoepvZ6A5QdkZRqA6+m2Bypk+cloCJC/R+gVftVk4aNhchM3Iy/9WTVSbGxKjlNS3HVbqEUwUcTZYxf/hiF2BDzzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7mS27/V; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7mS27/V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHd4hniV/vvbxcm2Fpa0LN8TfEOCeqKtes2TFi5dRaasVaoR6pHHz2XUPwt6Ck+El7/eZ2vI7A1QoSSGbiepNf5sJKGiBuMMXG3YUqjopATNab0iFePIJYXzn/9JXH+CS2hN74YRcLNVlzBytmgAqW4VJqFmZSIvthlGDa/d6QzIrQURruBEG77dVx4gElmYVidoDgQybgEDdJS1jRy+o3Ta7Pbj0YtG0NG7vyLyjJXjSvPnKjCJ4JKc6EvPAijAKkjvgZgDp0r4HVixkvmRuWLB8PZFdh5vTmhd6sax49lduSIBF1ISdbBTN2nNkZpUXQA8DOMhWKqK1Up6B+mH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lw0ZqxfmYnNZwWkHmXv1IptJoQrPFBoh/j/j5uIerg=;
 b=tSQNHfd23eokBQMoZw5BObTeJDnCzRZLvIpWhsQNeVUKjpDRntNvu4YnrIGrGZiF2aAZoX38k78RMvTBbH7rrZkkYn5O6+5XF1aZu3OOmXBZ5NvJwjJUVuA0zkeEwVlgwMMhwRdGY3WSuFP9CAxqKOhJHCjlyxTOoOPFJHqKFj1/csg6QEr2NKT6GTF2ciekZ+E5hi2QuT/ojF92WvVKrBzC0rvTrwOSRVLgrJzNXemo8iqhgcV0El5+cQZXHkkIbEWl7Ii+xIzxJg4XDPzI4uNqJW5z60bfgCOOPq0akbnrUMMGzjzzTGceF12Qcq+9zlQgFw9g3ItZZmB5N3SbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lw0ZqxfmYnNZwWkHmXv1IptJoQrPFBoh/j/j5uIerg=;
 b=K7mS27/VHqnQtwFcRcCquUT+vja/skU7UNaPIYQMJQ/1cKhlQCblD6wRQfWWd3xJw+Lo1KLEjENStCQImd7lOezT4e3Mm6FqyiR+cXUL/DgMAOMIdqWcTAwFy6RM0M2gcQixb1u1p3a+sptgzCXB19v1+ZmSuWnhJ7ArR6qVJDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Mon, 23 Sep 2024 15:03:11 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:03:11 +0000
Message-ID: <668fac7d-79e1-4cb6-bdf4-e15808cedc46@amd.com>
Date: Mon, 23 Sep 2024 22:03:03 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] iommu/amd: Use 128-bit cmpxchg operation to update
 DTE
Content-Language: en-US
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f8b3c8-0a2e-416d-bdca-08dcdbe0d74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXRqRHg0KzFnRS9yaGxJQWVlSWdCRzI3M2g0NUtpaVlHTFk4SytaSHZWMGR5?=
 =?utf-8?B?dE8vZHNEQWdUbXJ1QjEzTW1XNGg0cmJab1JxU2RNV2RXUmhqZFdVelhFOEh0?=
 =?utf-8?B?bmxhUng1L2hhUmVxT25FWjdmcVNhaFdpa2tPVlNyNGVpTVdwNmJ3dytPMVhQ?=
 =?utf-8?B?cDZXZjdvalhodXB4OFFnK0EzY3hNL3lnRXpiUlp4WWRGWDFoNU5VNnE4R0xO?=
 =?utf-8?B?Y1k2cytiRVMzZVNqY1NVZnZJVXFOT0gyNHdVTHkvR0EwdFIzbDc5Ym9DZjZ6?=
 =?utf-8?B?MldqZTkwTzQxSVFDblptWktrTS91TU9qK1RkMjdTYUdydzk4UUdhaVdpSERL?=
 =?utf-8?B?VjEzMm13YmQxUmZ5YzNiYkh0RmxvSnliaUUzZnY4bHpxNXNEUGE2dDJHOGpr?=
 =?utf-8?B?RmNSaDd2VE9jVXlQSG5SNmVlUk5lVXNFTzNrUGZrRWx4Z1NQSU5rUWFHM3Iz?=
 =?utf-8?B?Vld4YXJyeVlKcEM1ZExGTy9VRktaQjl2R0ozWWRqTmtLN05SL1ByMldsUSti?=
 =?utf-8?B?QzBGZjl0YUxPL25JNGVaRWVwZlAvMVFTYXBHM0VJaGxJZ3FDN1pSRTUvMzJ5?=
 =?utf-8?B?VTB3U21CQ2l3eWZWcjJ4eWdrRU9KUkJVamRSK09XM3I2dXgwMFAwZWNia2hp?=
 =?utf-8?B?Mld2RWNrMnlBamZzTkgrOHhad2xXUWdYTGRxa1VGY3ZFanhMSjNXSGxmUHZC?=
 =?utf-8?B?UzF1a3ZpVzltVjJWMDFzWjVxY0tKVi9wYld0Z3dpVW0xZ0RHM1Y2OFJMa09z?=
 =?utf-8?B?TEpuRldEWXRXY3RURU1jQW55RFhmeE9lb1JYZUlHMmFFaGxjMEpBREFrTmUz?=
 =?utf-8?B?Nlh3NDQvaldQVXg1SUV2a3NRSnZ3Um9rNHdvalJVSDNkakY2N0JPUHBHN2xV?=
 =?utf-8?B?VnZ2bkxkbm9xZE1vanBBV0RQVjJlWkV4dTlqKzFqVWl0Um5CWEN1TVpiNGl3?=
 =?utf-8?B?OUF0MHVtK3B4ZlVjbkx0ZldTRjJmbytmYTlCdThNVFJRb0cyalp0VlAxSkVs?=
 =?utf-8?B?WVVvR0pNWkFFQm9KTmtnWldoY085dE0zazdEY0k5UUw2WUtCT2tVeU9mMkdq?=
 =?utf-8?B?MlVKWXVEQU9kQStWREFVRFFYeUF1WlVtRk9Oa0tYbUtUZUpUSExKSGo4WE8v?=
 =?utf-8?B?TXA4ZlVaUWprQ0s4UFIrMVdLS3o5OG52eWtNenVvRndGdHEyY3hmMC8vYWY5?=
 =?utf-8?B?clhndTBBM2lvMlB3eGJpaE9zRnR6cU1hcHlCZTlNSkpQa3NjR1ZNdFpObnlQ?=
 =?utf-8?B?ajhkQXp5dk1tOVQ0ZmYzOFE3dlRhcm8zbDVrZ3YvN0RZYnhuZ2xLN2hra2Fh?=
 =?utf-8?B?NW83TXVidzRncTZ6OUtJUWdBa1NKUTA1K2dZTDFZd29sMmRoZ2dRZk5UeXpt?=
 =?utf-8?B?emRLam9TL0xHMEU5SHRYS2pKTlhiZTBMR2gvMnoweDY0SG1aY0NUajd3TDFC?=
 =?utf-8?B?MVhiaVlpd201eWwwekFsRXpqWU96b05vUWZiNWcrYWlMdzRHZ3RZN1FtV2ky?=
 =?utf-8?B?Si9qL3BodThlRjlwMW03ekxvQzM2c3lPdkhYd0R3c1oxQ1dZTEg4eFVDaGJI?=
 =?utf-8?B?QkFTcHF6Y05sd0ZuRXVWd2t0Um1OREptSC9aL210R0kvWlhlWTlTb0tOaW9T?=
 =?utf-8?B?aForV1lURG9pSjVDUzYzYUtYbGNRbzM0VmpwVEduK05GbTl6YnFLSFZadExs?=
 =?utf-8?B?VWdKYk8rMUFVeWliTVowWUNRMkFiS2ZJSE5WVTBwbWRuOUpPRENPMXBiSTZv?=
 =?utf-8?B?MHp3VFBpbnc3ZzJiem5GSXVlTGFDWGJLQ3JKTURoTno1RlpnMnRyVDZSa0J1?=
 =?utf-8?Q?ZaWM7vHtaKXPzPdJfpjhRp5uc1reXfO4rbzUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktENmJQSFJuZk8xQWZYSmtBTnpXNUNVOUxPM1lTdVZpdnRicUNXRUFHS0VJ?=
 =?utf-8?B?TnJ4em5LTmNLWThjZnQ0V2ZRTlRQNGxiaTdNQjVEZThDY28zS3V0R1Q5YmJR?=
 =?utf-8?B?U3ZSTnJqeXliSjkrVGgvUjJOYnBUQTVINGlJN29zUHptRTNnZ2taMkpTVGhU?=
 =?utf-8?B?YzFuTVh1c3NIRlpkM3l2SmYwNDFJYUNqcDhua3pBQ2Job081eHZDbDdWWFJY?=
 =?utf-8?B?Z0lrMkZuckl5TUlTbk1VODRDaVFnSGpCNklBYzAxdzYxNTVCSGs0UmVqd0lJ?=
 =?utf-8?B?MHRFL2RNOEw3MDFhU0Z3VkF5U1QxWWVXNE5MM2tncnVMUWRwbjFjdXAvYUhx?=
 =?utf-8?B?RmFCeXdaT1NISjhFTk0xWjlodGdmQ2d3OWFrZ2s1bEJzczZHeEFiUE5KTEpt?=
 =?utf-8?B?VzU5Y3l1akpxV3BlTHMzVDNyYzdveWhDS0pqMEpmSzNOR001U2w1WmJSV3Q1?=
 =?utf-8?B?bVRQcDBPKzFqaUpaaFYwbzFkbklRcE9wU0dkbWU4Zy9hcDJMWWhRTGx4ZDdP?=
 =?utf-8?B?RjJQbyt2dmZnRWNmYmFxalNybm9DdDFLbFBDdTV3V0lrV1RQSHdBUnJmSklq?=
 =?utf-8?B?VzZKVi9EeVFVNHV2dnByajRPOS9zeFloUkFaaUVOUElTb1dFVDQ4S2xkV1pj?=
 =?utf-8?B?bUJ5RnFIMGN6ZDlaT2JxUi9Zb2FEVjdhejdnRkxWaThjRjJpanhFSCtMRkpV?=
 =?utf-8?B?dlJaRS9pcWs0YlFURHF5NWRIMlB4a2JmVmZGUHhWdzRWVmNQSzcwNEI1WnpK?=
 =?utf-8?B?UFUzR0ltK3pHbGRjRmlCUlRyZHUrcDg3OUxOa085ekU0NkZnOXNRU1pCVkZw?=
 =?utf-8?B?WGJScW5kQUZjczNuT1J2ZnhaaHNIRERvcUc0RXZ1Qy9pY0h4MzBPQklYUlA2?=
 =?utf-8?B?OFhZY3BGNnJKcVZCbklFMjdZYjdnMWZGb2dVT245TThUZ2VVcUtJVjQ1Zklu?=
 =?utf-8?B?N2VaekwxblBTZDFnV2NVcCs1VnJoSnFaa1BVdG5FSkxPVGZkbnNMYkg1UUlI?=
 =?utf-8?B?c2dQWU1UREpQTnVKT2dOMDZEdUVhaGIxRXRoUHNQOEUzNk9NcSszZFJZODRF?=
 =?utf-8?B?S2dQSnpnSk5saGRTWDdJZ0lTRnFkZlVKSGN2cTZOUGI3VnIzcWpSQVFwT2xT?=
 =?utf-8?B?cCt1dEJoN1orQ1YrQ1lNNloyczB4enF3bDZkdTdqMkJicWs2K3VNNzI0bXd3?=
 =?utf-8?B?djNmNnZaOU9DQ1NWM1dYcFlxSndGVUZ2NTFmY0Q4aEhRVVhINDhKY2pxSXBK?=
 =?utf-8?B?SmEvdDEzb1BYcXQybnRtMXpQd1NFNVExeVdtaHhYQnpmR0lIMTRZN1k3YTRR?=
 =?utf-8?B?RUowNFBoYUNZek4wN2RYRzJXS2wwRjhrSFRKdXVISEVtN2ZXRithbkhZNmVr?=
 =?utf-8?B?YnZxTms2Rjc4N2tvT0FwcitZNTFOUGlteUNacGxLUHRVSXpJampRQ255NVJx?=
 =?utf-8?B?eENZS1ZBWHo4ZE84VFJ5Ujc1L0h1OTNjYlFjZlBaK1BaN3lnYjhJRnR2ckdI?=
 =?utf-8?B?K1J6cUdOZENDT256Q2doanFUb01iRGZzV1ZZQWp3MEcvNUhkTXpldVVCVFVk?=
 =?utf-8?B?RnVpYTQzUURlUWtCd3IyYi91MDZHYTRHS21ISTBmcWZBY1VaM1NUK1FQRXZj?=
 =?utf-8?B?UlZWWnErNTFDQUttckllMFU3QkFyeUEzU0F3ZlRtQnJDQlAzSDJxem9VNW1F?=
 =?utf-8?B?emhPMmY3V0EzTnY2ZEdIazlHVnNUaG84dWl5Mkh3VnV0M2ZnUUp1dXZRd2VJ?=
 =?utf-8?B?Y2VvMHA4YkttMlZpZE9WSk5kSUlsVExwenc4SSswVS82c1RVeEdrRHpURnVX?=
 =?utf-8?B?UU5xZjVhMi8vMHNYQmNOUnlqLys3YlVESDhEb1hkRUZ1ZCtEQ0E5bU1vcERC?=
 =?utf-8?B?UXAzODlsRFFrZXNWQk9sa2pPUGMwUFFLZ2prcVVUTWxmT2kvajhjMDgwcVor?=
 =?utf-8?B?OUNHa3dmMlJHV2xpNjBSM0dGdEtRbVU2bndNUTMzUTR1T1YrZFN6NDY1RG55?=
 =?utf-8?B?UUhJR1dJUTBkRHA4c1liR0VxZmFjbDRrRklSVFhNNjkrSjlkd3RRZm9tQ2Rh?=
 =?utf-8?B?aWk1dWNsd0JzNjRJRjlCUUlBbkFnb3RBcUpIVU9WY1NmQjRsNVIxUy94U1lW?=
 =?utf-8?Q?ZRXuaOXLGLQaUKbVtzOsGpP4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8b3c8-0a2e-416d-bdca-08dcdbe0d74c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:03:11.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPAYsO1j8GVMy59DVMP5iA1LzjapW11ruDBIAzzcTIrVuhbHwctDuFfMeAfG5bXf7yJj3fjcNYhzZgGD1ZFuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998



On 9/17/2024 12:17 AM, Suravee Suthikulpanit wrote:
> This series modifies current implementation to use 128-bit cmpxchg to
> update DTE when needed as specified in the AMD I/O Virtualization
> Techonology (IOMMU) Specification.
> 
> Please note that I have verified with the hardware designer, and they have
> confirmed that the IOMMU hardware has always been implemented with 256-bit
> read. The next revision of the IOMMU spec will be updated to correctly
> describe this part.  Therefore, I have updated the implementation to avoid
> unnecessary flushing.
> 
> Changes in v4:
>    * Patch 1: Update commit message
>    * Patch 2:
>      - Move get_dte256, clone_alias, dump_dte to patch 4
>      - Introduce write_upper, write_lower
>      - Introduce iommu_flush_sync_dte
>      - Reimplement update_dte256
>    * Patch 3: Remove spinlock since it is moved inside update_dte256()
>    * Patch 4: Update clone_alias() and dump_dte()
>    * Patch 5: Update clear_dte_entry()
> 
> v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
> v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
> v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/
> 
> Thanks,
> Suravee
> 
> Suravee Suthikulpanit (6):
>    iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
>    iommu/amd: Introduce helper function to update 256-bit DTE
>    iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
>    iommu/amd: Introduce helper function get_dte256()
>    iommu/amd: Modify clear_dte_entry() to avoid in-place update
>    iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
> 
>   drivers/iommu/amd/amd_iommu.h       |   2 +
>   drivers/iommu/amd/amd_iommu_types.h |  10 +-
>   drivers/iommu/amd/init.c            |  23 +-
>   drivers/iommu/amd/iommu.c           | 332 ++++++++++++++++++++--------
>   4 files changed, 265 insertions(+), 102 deletions(-)
> 

I am rebasing and will resend this patch series.

Suravee
