Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023137.outbound.protection.outlook.com [52.101.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250671DE2A0
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326593; cv=fail; b=VgGhBHlYo/6GRhiVBp6x1c26hsE9Y15IXLpukl0ALnYMkvp7gbZSioB0+OgIzXaUvfnN7AB5DvxvXqH/JzdEthl//563sXMbe4OfzAItpIUr3pYpUCTQIO6qjBd7WKrGVPlHEziN41sjL0/u0zJ/BAfTyO6FTCkLTfOPabsuztQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326593; c=relaxed/simple;
	bh=Yivz6XE/4V86ZtBtBODTauEQJMtCJvQrFXEwLCVZpsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fcDWK1rR8Ci8PeDASG5HODj7vo3NojAxY3u17qVrrYuyAvD0pPFQenzUMyYiBS6pdsVJyDlbleC3HUw0+16c8Nn2Y3GYH2kq08+mx537JLJf4y8IvQwzb+G4hsm5fu51CcdLM51Ou6DWyY1Y/XM6rP6Mgh781fg/PBVw3wtTb44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oITHCZJq; arc=fail smtp.client-ip=52.101.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oITHCZJq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0L23h6mdZc/LQgP1Q3pVuM0qeV588Bi24LmqR/QvoytI2th/DfhL0wfIFmE/C8R3KkApjoZXHmRIV0dHpNk50BH+gr6P0TTLkhoIAwtbhlU9w+tNNVR/EZ/D+b17U+Jics6saK5VnFt4McESPgG4lmEkKaBPRvrICU9cHzIa1DARTUosNMXsZphh2dejkayvWb+yckkcGYAH5+z/Y9Qxapyk5vzXnrls0nnHC3VA2l5AqI0Ds+8HSuTbWGKUI7M6z9TUxhlgeFC068t0wuCcv/zuMbK1b0U2egQ4A0Mkfr/vSvJspsWQYF4PK3XlTVqFo1+M2nzswwbaQuuQNzGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhojFTBtUZ/tqNI+czjook8z/mGfEXT0/XjjaHdIIUI=;
 b=fzkiTQqzkmp4jYRig5g30vUokU/M/BD3fRvPZU7jhEMqCUtypfyQ9nMWEbm7SNzsHaEiKFy0h7QseQ/jZlfjswHL8UFtRSBI5UZIFRJJAgN8esFiRqckoKEzuVbcFeDDHkrtPqmwogKjzx3jaDIdZFvWSg/+eFoyjjvhs+x+sZmgV+9Faz7bC06gnGX1XtOtj2D0+CU3+w03/hgOQdFYm3kXFB2PaIvN/QQ5i0icjYgjK1Cw8Us/Qya4C+BAa0SRHXo90UvDk52hyfZpMRBH5Iay6YfzSH4fZksMLW3f7fXgo99DdMKT/LOrw/azTMK0JSBa0QEZYz4d34uTWoSrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhojFTBtUZ/tqNI+czjook8z/mGfEXT0/XjjaHdIIUI=;
 b=oITHCZJq/q0X1CRx43SC0pJlgt8VAKQm8ScNQCJdsHxcvbG9gEuCFfSbrRwY8PL4D0Srz1/0E+Efn7hltie3L6YfX+M8uUZVNQOIOLY13VfUkXigGZ6lWj6uFbAhFYcppbd5jJr5kkttymBkp0LUEwq+Qs+LM52BubX4xNzOZX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6405.prod.exchangelabs.com (2603:10b6:510:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Mon, 7 Oct 2024 18:43:07 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.033; Mon, 7 Oct 2024
 18:43:06 +0000
Message-ID: <c8e65640-019a-4ec4-b9fe-73465a901ff2@os.amperecomputing.com>
Date: Mon, 7 Oct 2024 11:43:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Mentz <danielmentz@google.com>, nicolinc@nvidia.com,
 james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
 <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
 <20241007175032.GA762027@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241007175032.GA762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1799a6bf-cd94-4b47-dbd0-08dce6ffe238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZldkYXlWSyt5YnVhUWJwbE50VExJYkVTZVJwU2l1bkw1Ym54ajJSNWh2ZHRP?=
 =?utf-8?B?djM3T0UwdSt0aWhHTTk2eHlpcUMvQzBXRVFXTkVoMEkzaHRqaDBJbHphSTJU?=
 =?utf-8?B?M1ZBTThlbE02NHB4Mzh1UUNTSUtOQVZta3Z4S3Nraks4VnFKVzdtbG9PM3NV?=
 =?utf-8?B?ZUJNQTkyUERBRUhiaTd1U0xVaGIyZ0Z2MFM0b1dvNjNLZ0U5ektId1ZTRTU5?=
 =?utf-8?B?bkhuaDJSay9wMHpMZXVNcWFTWHdXeTl2KzJNUGNyRE52MkRoVWZPaWNpM3Fs?=
 =?utf-8?B?SW9aM01xZDJ1cXZNOHRia0VoanNUamw1b25maHNXMjhjZHhOcXAwQVJBZG9G?=
 =?utf-8?B?VGJ1VmRMU3FWOFZqZXBYOENyT3A3U1gzVW00dHpjdVJkTk43NythdkY3QSt1?=
 =?utf-8?B?R2dHMWlxemtSb1RwdGZ1UksydXF6Y0x3M29kd3M5Z1ZpWWFXWFY1VEk4RlUz?=
 =?utf-8?B?bGtUN0RVcHBDM2xqcUd6KzB1WjJRclk0QnlmZDZKTlgzdmZ1cW9zYk9FQnl4?=
 =?utf-8?B?aUdlWmppZWlVUER1V1lyRkFBMTAwQzVkMi9QdFhBRXIrL3lDVGRMRWJWUHhR?=
 =?utf-8?B?emNBZlhuMW9mWVhwU09BbCt4VVpyM0dZYjUrU3lKVnZ5a1NzdnBzZlgyRXNz?=
 =?utf-8?B?Sy9uZFI0Y0VrOXZ5RFRKVWlFdDV0bzZaak4wVVhKZzJhazhQVVlqbVZaMVlU?=
 =?utf-8?B?dUU5TWtsUXRaZ2E4bk5IdFJMNnBwYktnUVRFd0xHbDFqUmRRUjRzRncwb1Vz?=
 =?utf-8?B?UUJEdUFMTjNzNGhaRjg5VWw5OERpMTFiNy9JOGhkNlRsUWZhdUFsU2pydUVE?=
 =?utf-8?B?Y01FMmlZdEhSVEYvaHoyNkZQUnA0RFM5K2NaOFUxdWtqWXgrMGZSaUNkcVZX?=
 =?utf-8?B?UjZxVG52ak9NcmRkMXlua2lBR2NkZVZ4bStuQldhaEprUjJZZFpxKzZ2SEkw?=
 =?utf-8?B?M1h6WTN6bS9SeGZjUVJpMTB2YVIwT1cwdG1QWmVGM2xSOEZTb0FGK2JxQVFu?=
 =?utf-8?B?bENjWlp1TFV6bDIyZks3dnFJazhodmdKRlBvTGZDQUpTam9SMDVkNWxMVDRl?=
 =?utf-8?B?MlU3c2NBZ2dYeTBJYkZKVlpqYWRBOGpBT25NdkZOamo0MVl4TlFON3g2bWcy?=
 =?utf-8?B?QStpNWxKdGVDSnZYZXhCKzZJYnM1TFBpaytPcnhGQmhBSmYwUy9GSTlibGEv?=
 =?utf-8?B?RUhwTWJONFFCN2FWdkh1Yi9qaHp6OGdaMm9SVUgyaHN1dUs3VkFzbUVpQzQv?=
 =?utf-8?B?ZHFwbkhmT0U2UVp0NXUzYktFcnFKRHVicVZOeHhWYjFWVkV0aWY0K2lMSHA4?=
 =?utf-8?B?WHc1WkFPb09KMVlRaVIzQzNGNzBxN2EyZUZMZHdacU83K3RQUzBXWHl4dWIr?=
 =?utf-8?B?S3BlUC9wbnBBdWV2RXZEb2hKSmZWbTJwR0FEVHpacy81d1ZXTkRVMklRdWtk?=
 =?utf-8?B?VVNHUDNNaGhEdGF5Wk16REswclFWWElPZStqd1Y5RVFVV0ZnR0xNcXI5VkNt?=
 =?utf-8?B?NGFzdUFrWjZRUXZZQUNuQ3k3bXN2NEN6ME5jdGRjTnk0K0NHeFRWYW02Q1h6?=
 =?utf-8?B?SW1RQkxYNmpTbVVNc3ZjYzFaTjFndjI4RGJyZXN5ZGF3NHFnZlN2K3d4NlJV?=
 =?utf-8?B?T2RTMUdlRUxRdlVsc3U5ZG4xeXhhWGFtSURiODh1eGZsSjhrdXlkbE9iTmhZ?=
 =?utf-8?B?TThlaDBvNHNDM2VKNmVBOUtxU25OcXQzZE5SNlc0Yk9HT01Lb0NsZnh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9EV3c1MHJJZWZubFNxbXBWNEZqMjhzMDVoRVhjRjdXWFFFV0V4L1hTb2s2?=
 =?utf-8?B?T3NiOVFPVUlHOC9HdTRUWm8wN2U0R01JV3JTaG5PMFQzZS9RclZiRTkyZ2R0?=
 =?utf-8?B?UFBVN3Yzbk9wSTByc3VJYUFSVURsdVlHMmpJL2IxTld5SGdjVFVFK3A2a2Jy?=
 =?utf-8?B?TTJ1ZE9sTU1qMGNsRGtlczFPdVlUemxVNElkQ2lGUjBQQnJQTVNBWlpPWTZW?=
 =?utf-8?B?UTM2MjdEenRvUDhTNXlXTWxvMHFiR0QrbWpKYW1XWTFoUUhEMlhEQUtWZ1hl?=
 =?utf-8?B?dEFRYmlSTWIwRVdVdkpDR200QmtxSnhyQTBTZUFqTUtzaGlZUFQzQlI2Z3Nm?=
 =?utf-8?B?QkhFUEhRRml2V014eDZnSXhPbGVzU3VWU2xkZHZkWjlkcXkzQXZGaFU1MFdM?=
 =?utf-8?B?SUcxWjZqd3NhTjUxSzFqc1E0eVJzR054WUJzTldudS9DbFJHNmRhS0F1MUx4?=
 =?utf-8?B?MXByZVc3Y0JuNXNsM1ZzdVE3QzYvQkVGZUVBejVtVldtUGRML2JiSUNLUkdM?=
 =?utf-8?B?YUlqQnk1L2FNSWNkSFBLNVJiaG9lbnVoZlM0MWdTNUFNMW45cWF0UmJ2cDdq?=
 =?utf-8?B?emRUZ0VqKzF3b2t0a1FkaHQ5cWY3N3UzaWZBTVVzeHBHZ1R2RWFMZU5hekVY?=
 =?utf-8?B?SkVRK2k4emE4d1FYOGNyRlFBdnFTMlBJOWYzTFBrY2NkZkRGZmNZZzZlbWVM?=
 =?utf-8?B?Z0ZCOXNpU29GYmFSWXUrWmF4M0sxREcvNXMwaG9IdExTT0o0R2pPeU5vbXdE?=
 =?utf-8?B?MDF3QldwWWpQR084TTJFR01nTHByeURaSlVNVTRiRnFVWUJpckNKZS95aTZL?=
 =?utf-8?B?Y0FBYm9KeHZ3VzZLNHZzNkg5RkcxTUVINXVMMVNhWnhCc2k5TWlNSVF1eVFG?=
 =?utf-8?B?WFlTc2Naa3AvN2dIc3BTdkdnVTVqMndyUVdSS1BBUzVJSlhwU241VVI4NjFx?=
 =?utf-8?B?L2UrdnJkaUpFQVBEU2czOUtraXFYWWxNZ1VzUVdaaEY1OGRZQlZYUmYyc1BF?=
 =?utf-8?B?ZmFZRDBUemoyeHJGKzJ4YS8wVHIvN2RYUlZlZHZoWUU2NUROempESnF1WHRi?=
 =?utf-8?B?bko5bVFHOSs0UTNWVlpDT3BXREFhWGR6VTZNNHhweENuOU40blN2YWYyUVhI?=
 =?utf-8?B?SkZZK1I2aGozY3pScjdjZjZWRUFldFFnaG1BMkllWXJYZEJuVnNXMDVpQUFS?=
 =?utf-8?B?dnl2UVRtTUhpY3dXSzJQcS81K09vdVVjTU9QSkhlOTdhSCsxaU04Qm93RnBt?=
 =?utf-8?B?aU1zS1JvdnRScEZBSHJTT05iWDFCdVFPdEJhRCs4N0RqRzFFcUZsZjJSOXd4?=
 =?utf-8?B?b1RveFdjMWdsM0lsVWl3cFJ0UzJUVmpEL05VWC9YRDZCcHRyWkl1Wi8wRzJ3?=
 =?utf-8?B?VHlzUFNxd3dXbm93VUVKOVRmcWNEWVI5aXVCanFuNHU4YXEweFRGbHdIT3hL?=
 =?utf-8?B?M2tFVEc1SERnZ0VpY2g4NGU2dE10ZGhWUThrc0Q4NFdCTkp4RHoxbUZpeXB5?=
 =?utf-8?B?aDhyaXFnYjk2aS8vOEI2Ri9BeGZReWNHbEtqcTYxQ1htYlM2MTgyTjFSVStT?=
 =?utf-8?B?bjlLSExGc1hJeVpXRFRUVnIrOEQyck1HUlZoUzNSWis0N2ZwVFhrZG91enV3?=
 =?utf-8?B?SnZSeUhkZmRmbUVpK1FhVnh0aU5mbFpKR3VpL01hZ0NYM3J5TUh1NmdjbmRC?=
 =?utf-8?B?SnJYZ2FleGdFM2RzNXpZREEzQ3E0d1o3aFo0bTJUNDZHcTdCUG1UTGtZYWFB?=
 =?utf-8?B?QXRnQjVBNldJTVRsVzlFZVJocGhQN3lKWjZPdENmNlZkNXJDcjB0NnhUODNs?=
 =?utf-8?B?dUpueWNOYU9EVE5ub2gzeWdRTHh4SVRxYVhuZk8vazRpdHRuTU1TMDlZQW8r?=
 =?utf-8?B?OXQ5K3hNaUwzVkxxOG5CUSsyMDFsQjlPT1VVenlNRVlUQlhZb09aaVZ2aER1?=
 =?utf-8?B?NEdvSXl1aUVjamU2VmJzL1BxUS80MG1SRmJmZFlpUDlmL1ZqSjdoQjVNT3FU?=
 =?utf-8?B?NkZzajIrc0hBaHRNS1pRWGwxbTV6Uk5BVEJvbjRQODRWOCs5eG9TeTg1KzFZ?=
 =?utf-8?B?U1AxWGdZRWNzYmtJbWM2cFJONXhTTVplZ0FyaFR4bW9mbDlqZGVoQTl4bm9x?=
 =?utf-8?B?YU5nZVR5YVhWY0M1MEJsYXR2NU9RZmVmU1lHbno4SU9WNnRicEpyQmhYVDFk?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1799a6bf-cd94-4b47-dbd0-08dce6ffe238
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:43:06.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vtp729MGwfSLtUtbeenDaC4CRhxPktf2O8JLQAly5W0SKrbXob1X/U4rOL7kEToV39iGE5omnUBnRc3Q0IV3HU5V8z5cOxDB9zoNufDL1MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6405



On 10/7/24 10:50 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 06:53:25PM -0700, Yang Shi wrote:
>
>> Yes, SIZE_MAX is ~(size_t)0, but size_t is unsigned long on ARM64. So the
>> check actually doesn't do what I expect it should do. U32_MAX should be
>> used.
> SIZE_MAX is right:
>
> static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
> 		dma_addr_t *dma_handle, gfp_t gfp)
>
> It is up to dmam_alloc_coherent() to not truncate it's arguments, when
> you pass the u64 bounded to SIZE_MAX you guarentee that size will be a
> valid value.

SIZE_MAX is fine for dmam_alloc_coherent(). The concern from Daniel is 
the later assignment to cfg->linear.num_ents may truncate the value, 
which is unsigned int.

If I read the code correctly, it looks like dmam_alloc_coherent() may 
not guarantee to fail large allocation, for example, a very large cma 
area is configured. It is ridiculous, but it is allowed. Please correct 
me if I'm wrong. So the concern seems valid to me, so I proposed U32_MAX.

>
>>> I think it should be capped to STRTAB_MAX_L1_ENTRIES
>> I'm not expert on SMMU. Does the linear stream table have the same cap as
>> 2-level stream table? Is this defined by the hardware spec? If it is not,
>> why should we pick this value?
> Well, the way the driver works is in the 2 level mode it caps the
> whole table to STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES total SIDs
> which is 0x2000000 or 26 bits
>
> I guess there is a reasonable argument that linear or 2 level should
> have the same software enforced max size. Though would put it at a max
> 2G linear STE which is still larger than Linux can allocate, so it
> doesn't really make any practical difference compared to SIZE_MAX.
>
> Jason

