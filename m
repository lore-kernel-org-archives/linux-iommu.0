Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395B15CD78
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205282; cv=fail; b=ZonxAwFtneNry2nvRK+HvDTh5qvtAFP6csByjmRTQelaE2h/ymZCb+jfNFLLR5Sz80tidRpdla6X1yodm7CivhiEZUraHvxj7oKCYPRe7EJzoWZQ6TeQubcfG5XY++l6IjrCBQ6AtJfjBISmlS5AUVwsmnlJgIoCuQiJSNM/L60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205282; c=relaxed/simple;
	bh=RkhYGZAFC+0gs03V5emtSWRPnMa8PbaxireX6iNXapM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irk/JBLKlAdJrtrNsgf03AKLNoI+ELOleKk2FwZedPmrlAXvMGqqXogw6/T/Obo0cAONwL4r+YTKi5gC5HPuyOQV7for9jtdUx4d1vmR2HkGbxyTB+0U73qJYK9iAoX0CcXnDeajvwjkZpoj2ZfjsKX6ZJTbLL0Tpoh++MvLXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8qdO6mf; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8qdO6mf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggx1RZoVg++QURaLYQHR6qQFqBmrQK96/h8HsMrRFWIjXUG73rfbrvQttZmysGlNDw7knAF2w3fP/Zck2ZPHTVnXsfcAtfISEdCZFqe3s63DmpY6vAxE5x4B2zE0SSOFNKQIv06sOKn2FEvqpnvmpkYEtM0sr5tuqIwYTTeH3a1/GdXlygVlCYWj31+bBEUJpS3x+ra9TdTIyY/sfRRCls+1knxun8aVwCWKcOOWQ7LZoejhMYgrlsiui0yoI9anRH974sffW3YR4QvdanQIEIjuymVnVobZjs5wJHcVjsLvK7jxWHpIpBtkKY0nztj4/iPlhA3aRpG3rDlwkc7SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/8x8IGFq8tjclb++wu2cdEnrz7hrycryK6POh5NOYY=;
 b=sPwo6/EhUxCrRppX9BrcZm95wJ92Q/eP/1olIt+8y0uj0qQJmymyTPhgBPHxMhs9P52Z+Hen/HMD8CFqBej83HHc57SAswUyhGbPalSQjfFtS8/yJQsNEnr171vr2jXlSYjIouW8srJEAcZIMny0AmUVvlrE/KSorEf/xRsvLQApjxXLaDAEONIb0lqn4lYFX+vHfue8ILDr36RM+JAbASSS/nRQR8qOLpA18qvUxC/5dEIoSQZA+6HDPVqhKkIN5KNDXQq9w5R/EZJGvMqbTHX1PySGViP+5/nBTeJQEH0XUnO09TwO0HrYhshWOuYZe6OScIYdDL8c92jb9/vIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/8x8IGFq8tjclb++wu2cdEnrz7hrycryK6POh5NOYY=;
 b=l8qdO6mfRJhXAay74J5hpsNonC92Acw+G6Wed0xRz5/WsOK+BGy5ItqZmTVkuJ6nrHxzap2lnDJI++T1kj1qpgyzdwwhN8EX8CVoQO235MANvvG3/AXuvGy5SFtOdhtUng3h5wbPuMXigGJ6q/U8yfkC0N7IdjRjiYE3M4/v4Fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 05:54:37 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 05:54:37 +0000
Message-ID: <13cf216b-f664-4a7d-bd1e-ed9cc7500a86@amd.com>
Date: Tue, 3 Dec 2024 11:24:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs
 support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20241126211947.GA2654254@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20241126211947.GA2654254@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::35) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7c9f97-2e87-414d-f38f-08dd135ef85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkxUaHNudTlNSHJJVVhORnpkNmNYaGY2cDlzZldDemgyMEpySjM4Zi9tK3dV?=
 =?utf-8?B?VVo5U0c4Rm1BZDludFJGZlZrVTJyaExFSjgrUXMxdTY0RUFQa3hWNnJlQ1Fj?=
 =?utf-8?B?SFhiaVl6bXFLb3hqS3JTK3l0eTBqK3gwaVpqTHVNd055OVBBM25hOWxzSkpS?=
 =?utf-8?B?bEJKRGE3ZlY5cnR3SHNOS3ZsN3Fwc0lLaERZdlJ1SjAwWnRvT1FuRTZQYnI3?=
 =?utf-8?B?TCtwZ1ZuK2NjakJpM1FieGdVRGU4YXNWSERPRW5jUVoyQ3FkSjgwQmNzVVg5?=
 =?utf-8?B?bWU4TUVBOGRxY3djN3U4b2pzQ05KYkd4c1VUWGR5QjY5Wk5rOVJlLzBZU2dj?=
 =?utf-8?B?U0Y0WTB6MHJjNkxscm96VFdMMmZJSVN4S2I5amFmR0s2SHBsVWY5N3JGRXFR?=
 =?utf-8?B?MDh6bERra0xSUGR5U09TUVk5d2dwa0tRRkhBcFlJRmhpS1Nva1hzaHdzQkky?=
 =?utf-8?B?bjdRUDJKUk53OTdtbVFpK21IRXlJY053T1cvSGN5cWg1Qkc1Q1l2MWFWeEU3?=
 =?utf-8?B?M0RHbHN5dE02cU5pL2U5b1B3TDk1SGZJMW9nVjF1K3ZaU0l3UWJmSUgvQk9T?=
 =?utf-8?B?K1pUQXJkMXcxczhZTzRvMzJ0UTNzWWhDOENBUmU4NVRvTmJvYStuVEtrUDBF?=
 =?utf-8?B?MVpCVUx1NlQ4TVBrUi8rekhMUTlNVnBkc05EcHcvVjk2VEFJUXVNdXArUXNV?=
 =?utf-8?B?WTF3RzNZTzZ5K0dEalNDUlg5M0RRREEwMFRSekRqTStCVW5vZURpVDd0Tk1q?=
 =?utf-8?B?SFNld0xZTFU1eGhPZWwydU9VK1FscXFOU0VDbHhLbVNRL1BURDhHQ2xtN3p3?=
 =?utf-8?B?N1NTUjBqcWxiMzl2VDRMRjJjWEJ1d0lCdFVpaDBidXZXb0dPcFpUei9SZDZW?=
 =?utf-8?B?QjVGOHJXdnFHSkVVeFRBRldncEt4SFkrRHEwOWlQRHFlOU1qWHFFUkRmMmcx?=
 =?utf-8?B?Y1lTT1ZlY1U0TndzWDFZTHRtV09ENUgzNytHQkJVWTZ4U09FREg5c2kvUnB6?=
 =?utf-8?B?OXBmbzdEbFlxTDlJN2FDZmVnVWNTNGx1bzFZcnpYbXppa1JyVFRLMm5JaFVJ?=
 =?utf-8?B?c1hkN0wxb0NMd1BMYkx6eGMzbkU5K1lDckNGVVZmVlRYNk9kRldST3AzQm4x?=
 =?utf-8?B?cGpGblMxVWNaSEgxSlRWZTFCb2ZMWFpqTGRWM2RVOW5PYXVEOG4wWkVKd2Vo?=
 =?utf-8?B?TStmTk9zOGlZbStjYy9EMXJSRnY0ZmRablIzWW1UZ0ZZU3VjQzk1SlBUOVVt?=
 =?utf-8?B?Y2JhUjZFVXB5b1I5NG4zUnFIOGNaVTZmV2pudUNUTEJFUm9ERGFkcWsxTXhU?=
 =?utf-8?B?TnpTdDRrYjc4QytqTzQ4cmJIa2VzS0ZjVkFlMVNpUHNZTWRJZUZJUW9BRFlx?=
 =?utf-8?B?cTVDOVMyQ1RkUHM0OXQwQ3FOVHpCV2tsanYySE9OSC9CSjV5QjM1Z1liSjNy?=
 =?utf-8?B?OTJZSDlMdWwzQWQrdUJYNFU2NUsyeGVTMGZOdHNOU05sYWFmK3k4T3dIMEJC?=
 =?utf-8?B?RVJhOFFpekJacnA3eCtUZkV1SHlSYlhSZXkrOHJHRmxpMkdicWhrUnlyUFJD?=
 =?utf-8?B?cmo4SWZLNVNidS9Yby9BaTdqMmNqV2d2SC9URDR6ZERwZTR2UU1yV2RaaU1K?=
 =?utf-8?B?YUwyaG5jZkZLenJMbnZqNU1sV2g5M2w5YkFQSFNNL0FRcnIvWkpNSjJXQ0J6?=
 =?utf-8?B?SGdVWUhkc0VtYUZkOCs1cGZmNngvS3Nyd0QwblBmU0Y1WlI2amNSakh1b3dU?=
 =?utf-8?B?Ym1pRDUrRW4rN0RzZlB1TmhSNm95cUdZYm56MmNoRWVQUmZSTUNqNk0wc1Rk?=
 =?utf-8?B?MXM4eEIrSWxsR2R5S1MxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWd4T2t6RG52aThrUXhHazQyWFYvbVhhcmdqRm1JRmtLUFlzTU1sSVBsNHo4?=
 =?utf-8?B?WmJVQ0tNT2JHbnFSbytkc29rVG9IdUhGUWROaEpjZGlHd1NNRkdRMkZCT3Zh?=
 =?utf-8?B?eG5PT2R3cEsyZCt4WUJSMDcyWFNkUjJrMk5NUFlRcklZdU5QZFZoSmtUSlNz?=
 =?utf-8?B?YVhyMHEvUm1jeUV6RlhuM0NqcDlWd0JxUkxpSEY0Mnh6bWsrWmVmalJtME4r?=
 =?utf-8?B?ZVFWMWE4UFNTWCt6ZjNsRmFsM1VOT2VVOWRmVkFvV3cvcS9UYTRId1MvTEhQ?=
 =?utf-8?B?Wk9zV1VvNWRsejR1bVQ0V3BPVGlMaUFhQ29IWloyV3FWN3NKS3VBNFlLa2hB?=
 =?utf-8?B?VjNLWmJVb05rUGwydjZ2MGtxUDFHSFB3d3VjTFJZMUtodkh5MHoyVmM2aUhY?=
 =?utf-8?B?N2QrTkFkRlJwdEhxODg2aElnZVBYMFNuV0VVS2YyR0F0OUFRTjBhbk9DV0gr?=
 =?utf-8?B?THhZdVFIZ0diTzhOYkdUcTZieEw2N0NSV2h4c3hSNDV3UEdsYjVZSVZPb2xH?=
 =?utf-8?B?b1dTaUZkV3o5aENHWGtFZkwxeHhhWE5ocnZVU3hRdXlBeUpPNFNrR3lhbmNM?=
 =?utf-8?B?VVBXYUkzMXZCQ0UwSWRPM1l0OHVndjRPOVk5aUJzWmxlWXZoWmRBSmJPUGp1?=
 =?utf-8?B?YnJ2VW5vcW41RnNDTERCOFNWc1c5UWtMV0xNSnN5dWErRzlicnNDQnd1S3pB?=
 =?utf-8?B?cHkwdC9DWWszNGVHTW1KeTFjSmMwdUcwdS9EK05CVG1NazlsRVpJTE5oeTFJ?=
 =?utf-8?B?YkQ3LzRkZkRBMjZvTmZSYlN6K3cyblI1RkR3QzdMUkRpeHhyaWFla29HNnM2?=
 =?utf-8?B?UmErTFJhdzkxYXRVVXBHT1QxYkdHQ01HOVdIeTMrUW1sYkM2bXlFY25yN2FH?=
 =?utf-8?B?YzRNT3ZlRzZNcTRRUktjNkg5YUdLMzhmb2hDUlBLM2VkSlNpRThISWJqTHQ2?=
 =?utf-8?B?MDV4MkJyMUxjTEcwVDJWR1lMaFVHckdpR3pucmZOTnIvaW9UR1dEWEZFQjJU?=
 =?utf-8?B?WEtrc2M0b0hRazlFZFRJdzFjTmRjRDVzVkxhbmZqNVBnMTJyT3lZTGhmbm9M?=
 =?utf-8?B?S0hsVEsxb01LbjhpY3FCNTFicU00akVZT082R1o0bjBJckJrNktsZTVIbkxp?=
 =?utf-8?B?b0ttS1VFM0JwT1o4dGs5SGtRdG0xWUFVQm5vQWh6UEEwRVBEK1JIclFOVmg2?=
 =?utf-8?B?Z2h1REZidjJhbFMrWFFTdE15Q3E2MStpR010aG5RbnBYVVpjT1c5VmtvREpH?=
 =?utf-8?B?b3ZKY1VKNXUxRExzWjNCQ3ZhZDhxQ3pKai9HVUUvaWk2ZHhhTzZDMGE0RnVk?=
 =?utf-8?B?WDNJQlN6VEZQYTR6K1BzS3hjaDJMQlVsZ29NUEtGZC9HeXQrTUFva3F5bk0r?=
 =?utf-8?B?QU9FTU1naXo5VFFVOEkzdDNWWVQ3RHQyOExLWUJyc1FyU0s5Ylo5MldUTTZS?=
 =?utf-8?B?Ujk1SEpBZmZVZkFNVytaZTBMTDhpSlp3Y2c0aHBRTGFvUkczRGNHZ0F2bmhi?=
 =?utf-8?B?T083YmNJSS80THNrbUM2S1VjQUZCOVdKRTdoUzAyRkM0S1pKMm1TTllLUngw?=
 =?utf-8?B?NGhtMXVPQllxdmZKaS81dVVHMnlEVEw1Q0ZlZXV2SlhjbDZhS2ZrZHB3WlpY?=
 =?utf-8?B?WXpyL2dFS1E0enRsOVhOOFozUWNWNlhPTmt5TFFUYTlqV0I0QW52VUZQRnBI?=
 =?utf-8?B?ZzRHSjhVRWc2WFlmRWh1NG5ZZXYrOHg0Q3BwT0l3elhLSUttd2d1NDExaUR2?=
 =?utf-8?B?aGRlUkFrR2V5Nkh3ZXJDOTBvL1JkR0p0VGFibUVkYncxOVE4NTlBU21JbWxH?=
 =?utf-8?B?TXNSYXM5UnZZM2xXcTl1b0tMTnFnSDZlUWFLaEhWVmkxSHlqT3llUEtqYVhG?=
 =?utf-8?B?M1lEL2NWaitaR09Wa21EN3ZYbzdNYVViV2w3QmJ3bk1WKzFBQXlVS2pGcDlj?=
 =?utf-8?B?elNvbHo4Wm02UmdUTnlzVTJLU3VZZFVWRnMvdFRlcmE5ZGJzSjYxMFhXa3Ay?=
 =?utf-8?B?cWVaK0FVbFQwL25mYU5IVmhuNWg3ZjB0QVhvb3pVWXpKd1VlS042OVRqbW9z?=
 =?utf-8?B?R2h0eGV5VkNncjBXNDFBMzl4ZWwyM0tBbGpGSk1TaTBNVWxoV21YTHhqVXJ3?=
 =?utf-8?Q?Efuk9rmC7GoBlbYOXG7gEnTrA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7c9f97-2e87-414d-f38f-08dd135ef85e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 05:54:37.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUsOBnj+SSG5WpIVewx1V7F2FYn5e5QHw1aoEZSFUPar43iAu57jcytfmCJkTgeegWsSIKUZmAHIYTyQCoGXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

Hi,

On 11/27/2024 2:49 AM, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 01:16:39PM +0530, Dheeraj Kumar Srivastava wrote:
>> Add documentation describing how to use AMD IOMMU debugfs support to
>> dump IOMMU data structures - IRT table, Device table, Registers (MMIO and
>> Capability) and command buffer.
> 
>> +What:		/sys/kernel/debug/iommu/devtbl
> 
> I guess you meant /sys/kernel/debug/iommu/amd/devtbl here?
> 

Yeah. Will correct in next series.

>> +What:		/sys/kernel/debug/iommu/irqtbl
> 
> and /sys/kernel/debug/iommu/amd/irqtbl here?

Will correct in next series.

Thanks
Dheeraj

