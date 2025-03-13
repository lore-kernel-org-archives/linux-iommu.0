Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C51EF097
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863194; cv=fail; b=nQKYFzbbUHpyRW7FDCpYe8/oPNOjUhTct24doXKxDLGvqpBz105cObXuSSOZvTfOXSUJWijDNVzOk213DhJCbPL9VQ/DQao0snVt8oZ7z31G6bPxQnCD4N7nPpPjwayQ4XX7deJUqbuVXtJm33PIlNAmZ0qpV649pVZiRWp7Kr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863194; c=relaxed/simple;
	bh=J6Zk5kZjRTVZiNvAnWxmtqlv2sk/T3ypWGEq1tzS1U0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KsemZfVUBWvfHr9oMhOK3p9Rr6b70YJOUQicoNGf3Tk2OgDthzVfHMv3Il5L57PjdoNmEEmXQ+2zHGXTAhct/FbjNM2cZjmBquRvqGgpmija6VF0lAWb8QsOfI0I3ojYZJNTYzokZtoEhAc2VPVDKS7xe4Pp3akiR9ccZFXOraE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOP7hUTJ; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOP7hUTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqLVFo28krZO2UWLfD8vbbs86KH/qGS+pdmIKp6wNpAnDfnqbyqERN1zk4Ug5jJh+UCBkUteWBfiIdm2vw/4fg26e4P9vPzbAXqjplnFzDHSsSwhYEOi2sADVOnR//05i+JbnAbbWZFZ7P5yVKpW3XE69lps1J3Ilz586WhDWTO6cCKdfogRa8LCbvrt9vdL2jPxYAkQutF8unLY+gXNenZBzHyiLz7rwxdrSf6yjk+f9u4MPRoQkmcdF3b2u1YAXQMKU995RLo4a9Ulu7MC7TBaVGvg3lTfEfDAJ+JKNXSBDI4pPTHBmrL04tX7KHLjWbSC85L7p/zR1+25uEcTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6Zk5kZjRTVZiNvAnWxmtqlv2sk/T3ypWGEq1tzS1U0=;
 b=ymrT4AWSYEF4JgN2XzjTXKrN6SLJfwp9MQt4De39lLx2X4crT852dfBVBufDmAU6zYEtDYKY+TDXWeiFpIgC/WLOi6/x6Wnu8yeH0zYXHx1GAUKT9MdEIr5jbIycUYJuU86gsUHqLAMQuI5MDyC2Xv4KOs3XYBrLbSs6AHHYOpqAxEZlGs1vpg1adqHLHzpPDOZiGfbJWsjKqpUWIjVrs207aYjBv4WOJnkatV1gc4nCAsHUlNlJ1Vl/UbEKJIso0VMqasAMUKtNT+2ZXqZvwYxQ2v+ti8jiiFImKrUjFF8VpIcNY6Ygux8GFnOdJCjFMQfKyptm9WPKo+xtkBnNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6Zk5kZjRTVZiNvAnWxmtqlv2sk/T3ypWGEq1tzS1U0=;
 b=DOP7hUTJC/g94AJPL3AHSMtLC0I3pbtNBmS51pdzr0tf7wmbxVtPwoWEjUHGbip0PfnRxO3nDtPqS5cROZviggS0IdiXrlPa+sJSA/xM/4v4ZyLQk4Uf0qT5I1LE63DqXjxNa6ofbaQdUap9k8HJKawaqGcFMUii6gKrlI7a5+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 10:53:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.028; Thu, 13 Mar 2025
 10:53:06 +0000
Message-ID: <5c48b79d-6b94-4e7c-a78f-bb170b01a9c2@amd.com>
Date: Thu, 13 Mar 2025 16:22:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] iommu/amd: Add support for device id user input
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-6-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-6-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf5641-7f99-4342-ee30-08dd621d3bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFiMTFhTFVlU25IMDB1S2YvU2dDajN1dmlRMG40b2V4NVRpdi9GL2tSQUtQ?=
 =?utf-8?B?cXlKVCtFNlJlSWNpcFN1L1BVUHFkMFR2VUxiaHNTSk5MS1lRUUd4ZE5YNkR0?=
 =?utf-8?B?NzRoOHdLR1NmU1FDZ0srK1UyaDd3MTJhTXBFUzVrbHBPZDVNNG5QTHRKSk0r?=
 =?utf-8?B?MG82c2pWRklkbUhxQ0RYRDVGN0kvL3dkRDA3UDhSK0NKTDV0czhBUFZsYVNv?=
 =?utf-8?B?TjgrRW56THRENVZUL21tQzVUVXJVVWxwSkV0UFlBc1RsNG9SWWhVdDQrK3JZ?=
 =?utf-8?B?ckN5OVZHMHRid1ArQkRBMWllK0JXdDFZWU43QVlKanNad1AzTjNGV1pZQWZP?=
 =?utf-8?B?N2dLWjBlTTZ0RGxCVVNOV1FDTGN0MFczUDVqTXN4UVdvMDBBMkNVYmtLTS91?=
 =?utf-8?B?MVFPZ0U3SDdlWnEzYTVhUzFucFA0dTJlZEVIOEpuUEdUdlRrQk9pd0Rjd21F?=
 =?utf-8?B?SUVxTTQ5djFyS2FXd3ZiTjFkUVg0SUJzZzUrVUhyQmRnRk0vdklER2wxSGFZ?=
 =?utf-8?B?cTB2aG9vN2JZdGFBV2RuVGUrY2xlakhDV3Bzc3laQnhReXVaOElQalM0YW9I?=
 =?utf-8?B?bXJDeXdDL29ubHZZbTJzNmxFdTJ3TmVmcE9UYlJvc1VVL3g4SDkyckIxWnY3?=
 =?utf-8?B?YklYTHBGSDJ0YW1EYzZweWtXY1Y2OUlpdDU2bjZ6d1ZQRWJTY1d2d0gwR1R2?=
 =?utf-8?B?K1hVQUNBQ0tuVER1cXIrZVhIdEZkVG5DSjliSlhZWmgzdXFLSWVFa1FpYy9F?=
 =?utf-8?B?REJObzJGaklCbzVtK3MwTWs5eTVvdjNoWk83Y3RWNzI5NjlVT01HL0hUMUJ3?=
 =?utf-8?B?NXhOdS9Sc00wekZSQmNOSlk5Z3E1YTVTOGRROENiZ01Ocmk5elI1OWpITm5l?=
 =?utf-8?B?YzMvT1NvQis5TFc2ajJiQmZmbllsRkg4ci9EbVluUFp6M0JuV1pGZG9TZlJS?=
 =?utf-8?B?cHZkeUF2R3NlNWwvRkxxOXZtcVovMjArN3owMVNlckxMQVo0OXF4elY1Vldo?=
 =?utf-8?B?a0xraDdlbkh1azVXYmNKUkEvSmNFSHoxRlJvSis5UW5ENk4zSkVlNEdUU04x?=
 =?utf-8?B?aEJvT0MvcWNpaHU1dCsxUVdRK09IU3lZOEZadWJYcERZSzV0S0d0MndyQ0Za?=
 =?utf-8?B?eHg4VzY2QXlrRFFOWnRDbFVlSjZRK1NXblhiU2J6M0FERkdVZzZXdTFvL0VG?=
 =?utf-8?B?V01DbHkzQnRjMFJvVVlqdnRwT1lYVUIzS0ErSWhWTHpFaUVwNWY0bWpsaUZC?=
 =?utf-8?B?cWVaRWdtTnJtV3dkZE5sU3czeTJ2UXBCdTRIWURFNkdsOHhpcFVlU21KRk81?=
 =?utf-8?B?ZVNqKzZWRlN2SzBhRlk0cVdSQzRSU3Vya01HS1loMUQ3ZzN6TzAwZ3YyN25j?=
 =?utf-8?B?eDNUTGpaVnYrMUR5RFdmb0hUSG5oZWhzNERtS3ZKUkZRcEJlSWVITHlLWUcr?=
 =?utf-8?B?NlJWaXMwNnlQY3RaODZ4QldvcitiQkVtZmtmemZYczlaUXhPaXE0UlhlSEJs?=
 =?utf-8?B?b0x5SVB6UWVJMlMxRHFoWWkxQ3dWbmpuOWE2Q1UxVW5tc21GVkVhOCsvem9K?=
 =?utf-8?B?TmpNdWMrWVpUcDA3U1I2TGRoN0Q3YVg3d3pHeVZSZVdWNmxYTXVKbzRkL0tP?=
 =?utf-8?B?dWJjZVdqV002Rko5Nk1xamQwYVIyWkc5cnRZZ1NjY1lBK0EvWnhYZGhkNGh3?=
 =?utf-8?B?VS93cG5BdEhGdVVjcHVaQUhnaVNOQk4rdkRqeG5XN2tCZElpQVd1c3pzQnRO?=
 =?utf-8?B?RkNoK3BNWWxMZjlJZE43Wkc0OHEyejJET0ltTjNwMzZiQ3dOT1FQNHFCZzdJ?=
 =?utf-8?B?TUdxT243dFVkQlpzTzlyS1d4bk11dDdYOWZra3FxZ1JsWi9CYnQ3UkNwYURq?=
 =?utf-8?Q?K1DoXULwbTmXg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZjQ3RTL0RRSmZhelNVaHN6UUNScm9pdXg1Q3laL0lKcEk2NmgwTTVXYldL?=
 =?utf-8?B?eEVDalE3b1dyb3JNTlhBbC9yaGMvbjNobnJVS0M5WkpOMnNUeWJUdFoxcmZy?=
 =?utf-8?B?eXNHS1NGOUU0L1RQYW9LVkpqaUZiSHRIQ0wrbWFxZTBSR0RzR1M4L2JUQzlC?=
 =?utf-8?B?dnJ2UHd4LzFnRTEraTdLd2FyaWs4ZVB6Z0h5NzIxb2lxOUl1bitUb1JzZjR2?=
 =?utf-8?B?RDVCKzFOVm1XbzVlTmFMN3RUMTM1WnVoT3FCcHBvWWt6dXhIVHRicmhIV001?=
 =?utf-8?B?aEN4UzNERGVSU2Y0cEViU0syQmVBdlVoS2owbzlvMXNkdWJ2QWdMMVU2aXRF?=
 =?utf-8?B?VzFsNlBzai9DZ2RRbXE2SXJ0bFV2RXVNK3UyZUtQZVFkUGFQaUM5MHUxWG8v?=
 =?utf-8?B?K3MwQ0ljNFlMa1p4Y041WnFaVkFOODE2UVVlRDFUSVR1RFE2dE53QnplczlU?=
 =?utf-8?B?Um55V3QvRllQdUprZ0Rnb3ltNmdNclE5YUZVWEJzQ0h0eDdRN3BkZTdjb2dB?=
 =?utf-8?B?eDV0MW4rdHlqa1lMNnpKbW1yRjhXdmc3cGFoeTgveDdOaE9HUFJRTjNLa2J3?=
 =?utf-8?B?OVRkdDh6UERhZ2dhU21hKzhuQTBXODlHS0tad0s2c0pYWjlZS25rN1RmbWZj?=
 =?utf-8?B?RUJMS2JiUVNPTm1LcVpqSkZ3LzdoVW5KcWdPUHNWQ3cyT2dyZUpSTkxObmxi?=
 =?utf-8?B?RmVtejV1eHA5ZHFhMmZtWjlKbmdnODBIT2FQWnNpVE9HcTA1em0wYnArbmJh?=
 =?utf-8?B?eDg0TnFxemFRZnJhU2hqRmlCN2V6UHZWTlAzSkFETlYzcGNkOXBwRHpiY1A2?=
 =?utf-8?B?cnJpd3EwYVlPelRnOFNuNGNmOTUveG5uL0JKcGRtajNqUVhTMGh5SXNLYTlp?=
 =?utf-8?B?a25IY1NFenFqMmVFMjV6eWcvWkpNVjdKa3BvV1pVZWVEQjR3ZWtVQnNtSnNK?=
 =?utf-8?B?dnJ1bVE0VGJ2bU5hbXZsYXlMYXFvTytNcUVtK0REZXUrVHZTZW8zM01ZRjha?=
 =?utf-8?B?MXZGdmZ0VENaZGd1RVZ2UEIzSkl0eDMrMk5zbmNsNDNwMmxnSGI3NC94L3lo?=
 =?utf-8?B?cFd5QytkNnFGSFlMS1ZBc2t6dGRZZzhHYWppM3RCd3JPNjJUTG51c0kwWWJB?=
 =?utf-8?B?SDdRbU5QV0VjSFZsMGthNDY2N1AxajRxc1JHUEdjOG1xVDlnMFpodEJUSDYr?=
 =?utf-8?B?UlFkZFdobHJKaFJoTTFYUUVxZXRUdHNPWE9DY1pheks1NVg5NFhWM1dZVEUw?=
 =?utf-8?B?ZmZiMWxIcUdabVBlUHE2RGRlWW1IM1VjMVg4VUtPZ2VuZGsxVGVYQlBpQUVj?=
 =?utf-8?B?UGhZaGdpczJ1ZXREcUxRQWVnUVFXSUlUM2V3VHJJL0duMDBvTFdXa0lmK0ZY?=
 =?utf-8?B?d1NYc0lhZjJjTDZRZDlhb0ZCVGtqRFl3SWpzbHdKVDFYN0w2U280SVhVRkRU?=
 =?utf-8?B?RGxRWEVEekMzTzYrRkxFcjBlUmxxbk9WRHk4RDRRc1FJdndRelgvaTBhT2Fq?=
 =?utf-8?B?clVQcmlTRUQ0ZWVPVmpDT1Q3d1RObXQ1eWVCNXBFanhibWhNaWpNUEN0dm14?=
 =?utf-8?B?by96NVkxSXdacXRiSS9jMzF3MVFHOGcxc1B3K3ExYUFyZytlclpNYXlJSmlQ?=
 =?utf-8?B?VjNMSFIwb1g4K3JwS0pHb3BFNXNKQ0FSZzlPT1JlWXMzQkFmcjZhQTR3RGtG?=
 =?utf-8?B?NURyUkE1WHl6Y0dkL1BZMldMOHNjZjNQbSthM3N2WEtuUFVxTUV0L0JLSGpl?=
 =?utf-8?B?U1l4OFNqbU1zMW5qNlpKblN5UFcrNFJTbXpoRjIyYy9RM3JOT00yRys2SXdS?=
 =?utf-8?B?OGYvYjk5ZmZ3ZTVFbnN4RlY3SE9XSFAwWGJYWktlcGFUN0dYenZTTTN0a2Y0?=
 =?utf-8?B?eUl3MHlUWU8zTGl4ZzJPVEFHVkh6RUh1SlhsbU1DNmt5QjMyV3hhcGxVWUI4?=
 =?utf-8?B?UzgwSENjUUZYbVF4TEZrTUNzek1VdUNYa0xDQTgyYVBCanluakwxMHozL3JL?=
 =?utf-8?B?WEtuVnFOU0xaclZiU080ZFF2ZS9GWFEyQzhiSXMweDJtLzFtK3BsZmNDQW5E?=
 =?utf-8?B?M0VxSHZuV3J3NUxqTkt3TjZjU1QvUVhQdWZiNWVEanI4NjVhTDJZWHBXOEQ0?=
 =?utf-8?Q?ZRBScOPx7+XOTvb/gXYUhBpJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf5641-7f99-4342-ee30-08dd621d3bb3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:53:06.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO9XAx09CDC6bCPqsGg0k8gIzde23vZN/YE+ffYJSisvB0cgdrwSR1BeiLFKaSuEjy67AF39HqQb5vUAuEnetw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425

Dheeraj,

On 2/6/2025 11:30 AM, Dheeraj Kumar Srivastava wrote:
> Device id user input is needed for dumping IOMMU data structures like
> device table, IRT etc in AMD IOMMU debugfs.

You may want to rephrase the description with our approach of printing data per
device instead of printing everything.


-Vasant


