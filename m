Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A44696
	for <iommu@lists.linux.dev>; Sat, 22 Jun 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719039145; cv=fail; b=sgxlwfgOtweRiJ3puMdIVO2d8rQPkPD3rKp5I2OqXJcpo8pX6iG3RrwDTrre/lpnbynxWf+QtgEOew0UsvB7s8M7uyh/SkFbFP47hW9bT6kKnhj6bivJCRLWDDnNHk6FfVXpKtyMKPhPCZwEwNwba+NcpyBkwgvPz7zH4yEd+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719039145; c=relaxed/simple;
	bh=Gqm7Nod/9uS0dDp1bJBVe9YqpQaw6aigOBrCvoXZmQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbBWm4ffWV1yvZmvGmTygAs8WeyZwcqjbA3QMqj3pOyYcXSZeqFr6YUoqv2Zy+aqW4KA6FXNv8/t1f3e6gh4dTzq/grnLld97HLjqFhWhBhHXZHy+rslSZH1fqDFZR2W6efvMXWH+agNkb1+OcUk72hceEEaB9wlhDirnJj/OpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o9l6Hrxi; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o9l6Hrxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEt2FjNu6dZFFg3BWpGYbMPQN9HpVfmoScCmhLJcsQyQRC6rzeilTmfe/E32ZxIf01vE7+JvvfMgISvYQPfChBUN26T7Nd61fO2EwflRNtaLBuURyKDsVaZGphVRL/rUQXajLLOCtkKOAjdsHaFz9Ke2sxEX+US2uLckxlwPJIXubgYJvq0h9H64LXmUz4ixqI6p6sps+q+Hz4r7QOU8aV5ygRtohyy8TfdDXZl53bXid6GAR+eV3K5VKHkD8+SIhow86c8epP7He9axJvszOoQoKyMrrb8HkA14+fo2wccczR9WQk6TDeNDWXATpRicJ+aiXwc2qkoS8rpHffbjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQIOtn7gMd0HJZsqEmnXx+W7Na8QPtWk8+k17DuABmI=;
 b=PvkvfzV59BZcVcxYljcsAB95D+kZgObqRkpPwlYSOUjimDxoCqs051AVCD+skpgOCyik3mwGI8fFC6YY/+1RP73Mw4nQ9hp6YFQbUmBSUjS468Kqj03X/jsJeJNRNKtdd2T7i+uhNJHYbGGjymqzm12GE0JXC7WQ6rthciNXggNLj5+4OcGL0In/herPu4JdllV2zq6UM6CwQLtJmLUE58yh2vOQ4LTJSsdbVkUae+TR51YewtFRFT5HtjJRhvaA6BHcwJd/r+KDES7Jh5oSgKobiSi01OnVLUpmoSU+1NPGNg8GOetcpgP+tDuPDE2UqoX8S3DrB54euglgo3wAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQIOtn7gMd0HJZsqEmnXx+W7Na8QPtWk8+k17DuABmI=;
 b=o9l6HrxiGdrL+vboch++Vu6nWqThObJkSTMovLeKPCqoCrcl6s8Al66RKuSyRBDa0tXtzgyvpSyj1ZpojTAAfuTwtSx5xDOnp3aMvKncLS2N3/ESKdDjUjDtxNHV6j48S6S73A2/4+msRcWPf777+MMedp5QwtybCNuyUtGLpec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Sat, 22 Jun 2024 06:52:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7698.020; Sat, 22 Jun 2024
 06:52:20 +0000
Message-ID: <4d9949d1-8c82-4677-a5d2-387dac20f1d8@amd.com>
Date: Sat, 22 Jun 2024 12:22:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu/amd: Fix GT feature enablement again
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
References: <20240621101533.20216-1-vasant.hegde@amd.com>
 <ra4nsmclnp27vm6himfmrefxtczknf4rnsd5zbynvcsoig3irg@iccfqj6n7tt7>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ra4nsmclnp27vm6himfmrefxtczknf4rnsd5zbynvcsoig3irg@iccfqj6n7tt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: ad11b3f4-d8f1-491b-7fb8-08dc9287dcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFRWcis1U0M4Wm9TalhuU3oyQmltbjNpNEl6bDJnMlZaU3J4amp5VTBsYnRH?=
 =?utf-8?B?eFNiTTFOY2V6UllTQjkvdlJHS1BtbXhSSkRPamN1NVBXSVBEMElHeEF2U3I5?=
 =?utf-8?B?aFJ4bHArWEF2Z1Y5eHpLcmJZU01WUjF5eXRwdno4QUtJU1U2bjQ4SXNnSWJu?=
 =?utf-8?B?cDk3bmcxRVFNbGduRzNmVUEydUFrVTlyUEYyQ01aZ05qTURKMDVXQmcvdXVE?=
 =?utf-8?B?OVgyc01uU1Z6ditOTDBaZXkvQ3Q4Zm1Ic1ZFU0NwM3ZhNWkwYmRNUEtvWTlW?=
 =?utf-8?B?dDZJQ2EvU0IyNk9SK1hIUGpRMVBQR0RmUjFFNnJBTjlLRkZ5TlNzc2FnRXVD?=
 =?utf-8?B?R0x5aVBRNWF4ckVKOEgvS3RjSVNIVkhqaUhIRjA5QkJCd2M3ZlduaHgyMXFM?=
 =?utf-8?B?ZTg1enVsUzZ0WTFhT2hURjdoYWE2NDd5Nk56dFZ6VklFZlo3WUc0K08wd1g4?=
 =?utf-8?B?WnVzbkxhc0V0YXdFYjN4MUs0alBWcVphdGpYSTRCUUFxWTZ0RklhWjJRMGdE?=
 =?utf-8?B?R1ZkSjRRejJ1SmlNZ2JZUzM3alVmUkFXelJVMGs5eGFCekR2aWI5QzY2S2pp?=
 =?utf-8?B?T05BMk0vT1pSdmxudEdMa3pQTlRiazdsNjhsNW1KQzYvOEc3cFduTmRPekN0?=
 =?utf-8?B?R2FycXVGT01nUFBkSmg4azNMbG0vWmFjTEM5R0V5WVZLMXd5cHo4a01MWkZm?=
 =?utf-8?B?U3QrWnEvWVNTaWtudXZTekZnR3Z2R0xycVVhdHczQUZPQ1JrcGZ1UFlJTUtH?=
 =?utf-8?B?Y2tBNVIvaGozZXh5SjdLTVRiRk9DVy9SMFJTYW5QSTlvN3FrYm1vL1hCcmxy?=
 =?utf-8?B?VFFKeGl4eXFURU81SUttZGVKQ29yblNsU2szWWwrV01RYzhNOERmSDJ6aERC?=
 =?utf-8?B?cjdHYkN1d1ViMEJUTzhuYzdzekdIbk51TzV6Qy9kRFNKaEhiejk3MCtQajdu?=
 =?utf-8?B?ekF3YnZKNjFBcDg3QlVnRTNxZkxNaEQxbThoNWxHV09yeGtMRGU3WFVHcnl5?=
 =?utf-8?B?NWN5cGszZjJrVUYxUVpOaVY0QlhqNU1MQXp2ZS9xV2k5ZW9nZjZENG5yN3Nz?=
 =?utf-8?B?Yk5ram8vTkliOEkraGFYTlp5NFdYdllxQVBnczl0aUh1K2hic0lWL0NwSDRI?=
 =?utf-8?B?VXFDS0E0UERTU2VxeXo0VXI4bEM2Tm5PRmVhS01tUHhKVU5KMzVCdUdJZE1l?=
 =?utf-8?B?cEtGWW5aRUVYMGZSc2taTGcrNkorWDdhZ25OZ2I3YnE5ZERQU0xvVkFPSTJB?=
 =?utf-8?B?UTV4bmtuRUp1cEJ0QVFybU90M3hWSzd4eU9ISm5XNWlsWElyZE1TQTE4ellu?=
 =?utf-8?B?MzZST0FBUENabWFNUUMrVGc5Qy9Jc0tIVUhJREpYVjNnZHZqOTdKVFhJMUZQ?=
 =?utf-8?B?a2doemhudWtwbmRFemZaTDZhejA2TDkzbktLV00zUGRXcXBsOHpVZHU0YlVo?=
 =?utf-8?B?QmJVQ014TFlaR3FiUGVxNEFJY3ZtQ1c0N2VVMUF0ajAyempIK0owUkozZnNx?=
 =?utf-8?B?VFkrcmNndUg4SVBpL0hPQ2NSN2hWdWJxZHZuWmRCVzBIODJzVVlGTkdSbXVz?=
 =?utf-8?B?UWptVUJhMDRLR3VtL0hqT0d1SjI1YnNteTJDdnJoOGUxc0VlYldRVFY5QkdS?=
 =?utf-8?B?c1hEbmhmMEtKZnhuZHIvVHVIbjRHRDZEbzY3b0N2T1VJV0kveGtrWXhvWFc0?=
 =?utf-8?Q?ipnlChyIIHBd2tYzX0G7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZaSkZkbG9jNWxiWHJvRERXS2J3U01URTlrZUNoMDBxOWFtLzJzZ0pabnZt?=
 =?utf-8?B?c2FuK1U2RWxZNGFmR2VzcHYxU2c2T2tncytrUjZpbTBQbmJ6SkJsVDc5TWxw?=
 =?utf-8?B?M3dSZDZBT3V1QlNkQjFySzV2Y0lGVU8wdnpKSzYwYlpUdjdmbTJaWjBQdE5R?=
 =?utf-8?B?aXBjbThPbXNybExhMkRrMUxBa3hNRGxXaGhTYzh2TE5ob1JLcCtKTFliRU9o?=
 =?utf-8?B?Qmk0NGRDeEZzU0pqZDVTc0ZveUtSZ2tUWFkxQWE3L21YS0xmYi9rTjhiUmJx?=
 =?utf-8?B?cGdZZUN1cG41bVN1NFZJb20rb3lkamZtUmU2NVhMeXVoZXNBcVBJR0d4QVRo?=
 =?utf-8?B?cjEvRHdiZWdEcUhtQ2JzN3p5d2VCMWx0N2dJYyttSUlkY01WWU14bXQxVW4r?=
 =?utf-8?B?MUsrMzFaOStiYU5lTElSOUUrVzNHY2l6M0o2QXI5a2thTmFNaVNEdGFCNUdB?=
 =?utf-8?B?ck53T0NrNDZwNGMrVkFlZWNQcGZQTG9VZHlabXVUUUo1emNNNXZ5SUs2MnFh?=
 =?utf-8?B?UGUySDlkVEt6Sk1OV050YjdNUzlwd3Fyc0E2K3RGd0tFS2U5RHRDY2xFNUdh?=
 =?utf-8?B?OC9zcHFNMWNTWUFsOVJLNndQRzNrd1QwR0QxL3RqWGFQY3FESk5ROFowbkNx?=
 =?utf-8?B?YnZiNERHU2ZRVFNzWGY0RnpEeE9Ra0ZkRUtGUmpEdXZKeDNrSGhpQXpsd1ZE?=
 =?utf-8?B?bDdwT3lxQnRlVVVYM3UySlA0V2hvMUpzdVVWWVMyZ2FVS3ZsUDlvYmJVMndH?=
 =?utf-8?B?WWdVM0RMSUYrQU9tRDVjeWp4TThOdWFzbjA4RTlFYXBBSXlPZUFzcGJFb09t?=
 =?utf-8?B?NGI4cXZCYldYRm9ISnVRTjc5RTUySEowYVRrbEI4YU53cDJLbEJsNHlZZndM?=
 =?utf-8?B?eWJrL1lVdjl4Nm0wSDBJZUswb1VwaTcwWEJoby9LZUVmVXBoR0JJR2wraE12?=
 =?utf-8?B?ZWZmeFllY0J5UUg5anhRNlNUdTRFSy9pUjFrNmZQcTZoZlN5OWQvNHdHRDBs?=
 =?utf-8?B?ZjFEcEF5cys1LzFKaGdDSDdoNnhsSmk0KzdkT3E5SkpqdlJuQnRDQXE5SU5h?=
 =?utf-8?B?QnlRS1gvdnF5dDdqcHFOSURvcXF2aTA5eEY3Y3pDL0VKV1JrRmdESlllckhY?=
 =?utf-8?B?OVhKbWhyY2FQaXNNT0ViRFFiM2pqcWtETm5mRWlOdVBCY2ZFUnNMaGYwZCtX?=
 =?utf-8?B?d01wZ1pNdXFvQ2hsYVUrb3l5UEVJeDcxZHpXNWJqNTMrbGVKR0pnQVp4dnVF?=
 =?utf-8?B?cXVMZVZFM0xtTDUycGcxSlVMSnB6VFJwbkRtT3FaQU16ZFFaRFJJZjUzZ2Vh?=
 =?utf-8?B?ZXBBS01uV2pKTHFNeHhTZWI0aUFGNm1tbjVMaUFURWkwNEdoTzJmSDJOSnZF?=
 =?utf-8?B?QUhJWVVpa3RlTFRBcTBDdEkvTFBWdTYraFpmOXBkaC9DUkM4alVTdnFONGhG?=
 =?utf-8?B?cDU5QWFJTGttR1hnL0tyVVY0MlVDR3VyUCs2ak9qc1ZuZlVPM3g1WkhnS2hZ?=
 =?utf-8?B?RlUzWWw3WEVQQkRNUzlqcmszbjFidklhZGt3MHAxZnFaNk0zZmJPd2VpWWJN?=
 =?utf-8?B?TVU5cEttOE45emc2Qi9tU3RhUUdiYnRiT2NqeUNMMkl1MjhhSzdzU05OZVRx?=
 =?utf-8?B?emJFa2prTkVWYU9WUWFrVUZMVy9abUZnMHFHcVFKNmNNYmFtcjd6dFJCOTJk?=
 =?utf-8?B?OU9ESmxaSjFBdERHTFcwUGFkSGJzL05xa3pSbXk4VU1pRmJtUGNZN1J2L2RM?=
 =?utf-8?B?UEtuNnpDTnJuWThpZFNqa0IyWVhGOXVKdEtMYUV5MmdObnIvaFJyUGRtWmNw?=
 =?utf-8?B?emRGbkdKUGEySTZ3ZDhDdjJMR0JXN2h4VFk3cDVOVDRSMjZDcUNJT2YrV3pW?=
 =?utf-8?B?T3Vvb0pFbGZPUHRXOE1veXJGcHVOMXF3MExlQW1yUlNyL3VwZ0RMa0FqRTJv?=
 =?utf-8?B?elBFbU16dkxuQjN2dnhiNCthaHpGR0pUWXhLT28yR0FBc0lhMVhNVU5lOUN5?=
 =?utf-8?B?RlQ5eFFmSXJPdTlsTElIblB3THVlMzAxeC83SFZ2dzI1RE01eXIxRzk2WDJK?=
 =?utf-8?B?QjYxclZST3k0UVo4cnZZV0QvL0FFenlEbWc3ZFZQcFgvc2lmTzRyMWlOYmEw?=
 =?utf-8?Q?fLaLh3ywEFY5x4vDZGciYSHGI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad11b3f4-d8f1-491b-7fb8-08dc9287dcb4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 06:52:20.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob5PW3lK28TvMiGUyGy7WKvTBtPi8OaG3T2vHrR7gftWerxIfigcezpxiT1Pp/RL+jxx2hMD4/aMjwGKiFR08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

Hi Jerry,


On 6/22/2024 6:02 AM, Jerry Snitselaar wrote:
> On Fri, Jun 21, 2024 at 10:15:33AM GMT, Vasant Hegde wrote:
>> Current code configures GCR3 even when device is attached to identity
>> domain. So that we can support SVA with identity domain. This means in
>> attach device path it updates Guest Translation related bits in DTE.
>>
>> Commit de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading
>> IOMMU feature register") missed to enable Control[GT] bit in resume
>> path. Its causing certain laptop to fail to resume after suspend.
>>
> 
> Does this bring back the issue that de111f6b4f6a was trying to fix in
> relation to getting a bad value in the IVRS table?


Actually it will not bring back that issue as I have kept the GT enablement in
iommu_init_pci() as well.

So if we have bad IVRS table, then it makes second attempt in iommu_init_pci()
path. So we are good.


We may have to rework some part of init code.. I will look into it later.


-Vasant


> 
>> This is because we have inconsistency between between control register
>> (GT is disabled) and DTE (where we have enabled guest translation related
>> bits) in resume path. And IOMMU hardware throws ILLEGAL_DEV_TABLE_ENTRY.
>>
>> Fix it by enabling GT bit in resume path.
>>
>> Reported-by: Błażej Szczygieł <spaz16@wp.pl>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218975
>> Fixes: de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading IOMMU feature register")
>> Tested-by: Błażej Szczygieł <spaz16@wp.pl>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/init.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 161248067776..c89d85b54a1a 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -2743,6 +2743,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>>  	iommu_enable_command_buffer(iommu);
>>  	iommu_enable_event_buffer(iommu);
>>  	iommu_set_exclusion_range(iommu);
>> +	iommu_enable_gt(iommu);
>>  	iommu_enable_ga(iommu);
>>  	iommu_enable_xt(iommu);
>>  	iommu_enable_irtcachedis(iommu);
>> -- 
>> 2.31.1
>>
> 
> 
