Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4D2652B4
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623051; cv=fail; b=nhvEoQLvtBQpuBRw5V8sxj7B/qQkirU+p9emFWXnsN87I2LEXbcjR6l7QAJk5ysx8nSFcpqjHzVXAf2XdP7aV1W2rDpwUI54z8CuiNQRgtoQZqlSiNaSCk5C4j47KmZdpnQkmNcI8Zo7bAAcw8mUp7fSsZVzRk7Dr6OoK1qIsTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623051; c=relaxed/simple;
	bh=J3bW3UCAV22B7lUTf44uX+z3n2x6j0/7H74Ph4CzD2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZDxSHmteJUz8fCVxLgvPMKkAyDrbvVRkms4lNSt67pGyo2otl7Xgq8fCpYtSbbafClDolRlxWPlH3zb+gF2mNarj3eworhHsxWb404IZh1Ddc+VSBaTXUdhcQJDuSW8/6kX3kyTMKqfov+DwEVwkxIfyNLG3I2QKv4nrFGVnB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KijV1yuW; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KijV1yuW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4gK1Rj98mpViYgG16a7M1xLSzRMlQDhklk4q04jwMvnaaI0ZmpmztUwlo5GsYNn3nIt0TzXuNf9U/dSULXEbnHiZkJSe8CiiK8FD0uq7tthlm5lar+U5DvQa77TcjRq8wKJJx6NJXrLJWbrL/U4YosLuW0UyQD21CFGmgTH/6ZJpidXsKwn/aTpgdB/76Xte9p6pTsn+vTepT+d8Yd+iSZIpOs2UNO9CgjV63Tlh6Hh+Hddsr2WC5aCvlZepiDZMv7hjK/+WCQrwidFrFEAExRzMeyiPNnRbAb8lYAORzu9mvGISUjnHFi1e0CpNecGlROlGGBjOW63VgUL11s5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UwX2ZEe+CQA4aA1DVBVvkGayl5CFsLIc5/v+ZoTAao=;
 b=D6+WdMKFHp8lu0aHRKh/GsYqNu/8xFJPReXYnQoByp2gu7iAg/6sd1Y9I4r/q4L7MUFAqhQwdRkuoHLK3/Amyv6M/wr07IzBkia28Si6/MoMbeqanExZONlTbKciOD7UWW6yWSGmtFvFnGFlKz7yuAhignpmbnLApbKuZ7QO0MfzVDwVfKZLjZKlm1e6LGhi7hIRQ+2k+ZZSa2WbPYV80db1a1J9URK/6JxHqEBL3ZC/o0ne6eeEphlr8yzbdMV9nW43xTxgz8NbFzakdA9YjoCRPltWb033bUw87znUx9k2SGXKd5uZ4a9ImKDNkKjIpWGYzVy6dXB+Lfr34GvWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UwX2ZEe+CQA4aA1DVBVvkGayl5CFsLIc5/v+ZoTAao=;
 b=KijV1yuWwjMREgvphPjlFneFmlJ1I7N43jtWmXEpnjMfpSb97uM92KTLzWcSWwbaMj0XgWL3s/ydYao/YYZVFjQxGTanr9CdEFEUpori3DTN5raxoy0+CNGdx+alENhijZImIJqRBrnsmTcnzIoMqluiLuq6vonBOmsJLbAyQnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:30:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:30:47 +0000
Message-ID: <33deb969-160c-48ca-890d-2b64cc0408f9@amd.com>
Date: Sat, 8 Nov 2025 23:00:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/16] iommufd: Introduce data struct for AMD nested
 domain allocation
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-9-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-9-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::36) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1126f36e-2b4f-4b21-eaf2-08de1eec8d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2h4dzhRbzlCRkNkeVArcElVSU54QjBkNWIrRTNKdmM3ZnE0Qk9QeGNYNlFn?=
 =?utf-8?B?d1ZaUXpwRG9XT1ZSbXByK3AxSmhBZCtEaURmSnNPZWJRV2REVXRheEp0eVpH?=
 =?utf-8?B?NW5EaFIrQ2VnUktZVTNVNzBEWm9kU2M4MEJtOVBXOFdVYUc5N0o1WWFVMEZx?=
 =?utf-8?B?YVpRQStta3Z5R3dseHR4cjJsMVZaQ0pYeWVRR015TnNxc0pQeVpucTVVeThp?=
 =?utf-8?B?YmVFY1RsMEloTGRTYWNRT3VKTTBxejRnR21JQzZTQWFmZlgrRW5TcUlxTEYv?=
 =?utf-8?B?R3RsbmRkZXpGb1Z4NTY4azZia3NQZ1N2QUg3YmVSbUhxbnN5eXBKaE9VSk8r?=
 =?utf-8?B?NHV6Y3dCNGgyY2NrSVpEb2dPVGY1S1UzRW5IR21ycjZ5VUJ0ODNnRkFsS3hh?=
 =?utf-8?B?eVBWeXdsZkRLODVuRjdYdXBzQ1lDOTNUL3Q2UUU0T0NMZnpwNmpNdzVhc3Np?=
 =?utf-8?B?WHpEMk80MitTUFJML042ZkZKNDdGUHRwcnR6TTFJWHRTZ3dWMXpqMXJZZTY2?=
 =?utf-8?B?SEdKNkJLWUNwVmRnY1FiSjR3T1VoTG0yQXZwV2lIODZkVHhjbmpuZjV1V0FV?=
 =?utf-8?B?TkNwaFMzamZsZVdENld3d0VXRkxTUDNhdlZua1poaW1HMEViSTF0UFlhRGRS?=
 =?utf-8?B?WE9YbWVmVEdKK1RTaXk3RHYzWVdlYUlYYVNLY256RXYrYWV6cVRxQ1FkajFv?=
 =?utf-8?B?Y09vWWxodmY2dFBkME1reXYrNE11eG5ZZEQrcjFUOG02cmNmcGNxUUFNTmd5?=
 =?utf-8?B?UmVJZVF4VG9hNE5GQ1drelhKMHNpUHNnaG40S21hSk16VjZxUVB4bkJxWTRU?=
 =?utf-8?B?TVZrd2ZuRlpRdjVKd1FrK0l5bHVHSjg3WGJxUDVVSFJOdXAzdlpiVG9FZWRG?=
 =?utf-8?B?NWtadVVRMGNFaklqVWovekVoS0JpRzZuclpBbWhsZU9PaTZ4TUZzcU9jT1Jn?=
 =?utf-8?B?QVZTQVc1SFFjSERyMmVhYW9oMTI0NEpGaHRNTWJmMlQ5VVgybFFaZSs0YVRs?=
 =?utf-8?B?d2FteUQ3Q0hDVUNzV0tTWCtEVlVsQ3pBUWxyYTlsd0E1NkZnUGJzRGN3MmpD?=
 =?utf-8?B?MTAzVmRrRElUT25iK1psYnJ0bFl2ZXBTYzZpWE5FNXFZVnBlZzBid1RxVWtp?=
 =?utf-8?B?S0tFLzgwdVpvZnBScDlhN1MzemNiZ0Y5Q3ZBbVQxdlUxRGJSRzdIaVJ6RFkz?=
 =?utf-8?B?NHEyeG1HejYvU1hmVUdiWWVYS3NLeURnOS9VOG5GZ1RRalR4SDdXRXJ1YnZ0?=
 =?utf-8?B?TnB2SjRFTU5zcVNHTUdYbkN1WVhZbW5MbDFqUkVpUXczcnhpR3dWWno5RmRB?=
 =?utf-8?B?endqR0hmSzRxdGhUL0RvSDc5cHNkVzBFWmQzR1ZZUUxkTGRKYkE2d1lRN1pD?=
 =?utf-8?B?WlhpaUZ6eHg4Q3ZISmQ2c3lDeHpleHhoMW03ditFLzZXK3NkdTFzaG40U09y?=
 =?utf-8?B?T2s4NFZnOEMzR21sRVIxTHFoRHJIQi9VcGdIUVZ0dng4d3BpNW9jaXhTZm1W?=
 =?utf-8?B?d1VTaG9tTTh1c3NwWjVmUXVrSjFza0xBUmhZUDJrc09kWmRTcDNhdWk0YjJU?=
 =?utf-8?B?Z0VYQXcwdlNMTDdKZ0k3Ni80UjlQQmZOQnFiODdzMVA3RU1VVHZmZklHcVps?=
 =?utf-8?B?dkF0MW1Fa25LSmkzNU01elRWY2szbytiaEFtaFBXaW1rQWxyTk1vSFVMdVhl?=
 =?utf-8?B?Uyttb3JkbEVDVkpQV282c2J4QXMwaVJVUzFmZUUwYTNlS0RqSDFkTU51NDZ4?=
 =?utf-8?B?eEh5Y2pwRDZhUHNrbnE1ZDBVdTZxUUtVYXVEY01XWmVab29UNGYwUHNTa0Nh?=
 =?utf-8?B?Qm1hTUY1ZmpWN2ZZQ283dDYvck5DeURlWWE2M0ErcitLU2t3ZHRFUkNlajRy?=
 =?utf-8?B?WUZLUnNxei9ZQlBNZ0J5UFdzbVJzNWYwNm9VdVBBejd4U21uZDFvd0dNeTUr?=
 =?utf-8?Q?eSRAjWuM/MU+xAI+HXOPDwVTolILnPt/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBGNytFM0N0eG1JSGduQkRhTXdybUYvcjUvcGNzRElqUWhOd0k4Vlc1MEwx?=
 =?utf-8?B?TFpLemZuK3BXblNNMjZuK1V1K0RHQ3FTcUN3VXR0U2cvSW92TXNoWnU1RTlJ?=
 =?utf-8?B?RGIvR2MxbW43V20rLzd0TE9YSzgxd3FXd1loMkdDc1k4eWpUYy9OemMxQW1j?=
 =?utf-8?B?MENZa2p6TWt5SWcxb294VU8yZUFiN215aHlXV0xoczBDZ3VXTGNwckhjd0Iv?=
 =?utf-8?B?TVQ0MCtwVHU1dlVYb1BBVWRhY2RWUjUrSEh4eXdpNGlsdVpORTM2QzhaVjNu?=
 =?utf-8?B?cUlJQ0M4ejIxV2wxbm9jWUdKemlFQUVLOUtwYUpuTk5BTm4zcnBQQnJvblJy?=
 =?utf-8?B?c0dtRUt1RlRlNnFhQytyb1dOcy9Hc3lwZ2xIaGZ3RzNHUXBOdGNXdUFPbDY5?=
 =?utf-8?B?SFFtb1Z1Z3ZjQUx2ZHVxVHMySXVzdnVPdEU0WG5OVG80eW85SHFMS3NOem9y?=
 =?utf-8?B?RVh4UnhBa1RtSGJwZmxCS240WkYwRzBnc1psbHhZbnJGMy9HWXoxUVNTYyts?=
 =?utf-8?B?eGVVU1gxSXd5QVJiOW1nc2NOYXBKRGZkdnhWSUcyckVFS0Y3aFdidjFNMGlT?=
 =?utf-8?B?RVdGYVFQRU1TcGRPc3FrS3U2c1l6Z25XTE1CM2NvdTNScHYwbjFUaEpoM09P?=
 =?utf-8?B?YVp5bU9WdWhteUtUWllUY3VkZ3VEa0liL1hCOGpYSzNCck5oeDIvMThURFJN?=
 =?utf-8?B?NCs0emw2emhQWWlLWFdjRFVvRjVqaUFxQXNlN0hSTE9aZjFKUytwbHNaSEh1?=
 =?utf-8?B?OHZMamVaKzgzQVk1WmJRQmNxT3JGcmgzbHNQT2NXT2xqVk96ZXdsS01RdU1s?=
 =?utf-8?B?NDhvY1lmTmhPaHZnTmpUa01BekE2bjNEZ0JnQm1UbElXUlRLUzM2R1JkZTFo?=
 =?utf-8?B?azZJWXk0Nm9yUS9Sek83WFlZM3lIRjBzbSt5cncwZU9WL3BQWURhcjdqcGhG?=
 =?utf-8?B?N0RiMUl3VkJwNmwzSWhnUUtycDVZa05tVVQxa0pEMUlqNUlZekxBSENJU2py?=
 =?utf-8?B?Rm43bCtpU1RYd2prMCtnTHNMdFdqdjhKUXM4dVU1TWVnRTNFeVl6eDFBaHh3?=
 =?utf-8?B?UitEWWl4MHdieEFKQ0NYZE5xWVY0b3MxMmZVbE9FbzNGWWJLT2xsZDN6ZkhT?=
 =?utf-8?B?WTJsd1ZRM0RDNlN1YUY0OFJkUW5PeUtNMVY2aWdPVTRmdk01Yi9qUmRLTG9E?=
 =?utf-8?B?Z3pvdUtIQXpheWMwUUFDTkVqaWt1YytMTjZJQjhBSmZVZzlRbVM2YUpiRlJr?=
 =?utf-8?B?eVNJaXhTZVcyMU9uaE5ITGVRWEYraTBCbWlxS3Z1Z3ZIeEdyUDMwV25tVWhP?=
 =?utf-8?B?Q3Y0MS95UWhrOWZOMklNUVg3UWoyZ1pGUXA1TkRUUUxzbEQvajh6S25NM1Bx?=
 =?utf-8?B?Qkg5OXBZOWh0dm1IWkpjektsMEFMWElVeE94MC9GNzdWRmUrOU1YanhGbElU?=
 =?utf-8?B?R2hSVzNoSUZNZmpCTDdZWEM5aUkvTWNsdGg0R0c3MGFrdjk0RUtRTFRZVWhv?=
 =?utf-8?B?V2l2dEQvcmZmSmVKdFZpd1NFR3JWUWRpZGs5UngvbWRXT3VGblJkZFdJcHZi?=
 =?utf-8?B?eGZGc05ZMit6dlVXNlB0cWhNa2xPZHVFRi9jQmE4dHIzVExmendGT1RyOURY?=
 =?utf-8?B?dGlyK2VtVUYzUzdvS2JMOHk5R0RCaUhpRWRlalV6ZkFJTFlPc0JPK2FYWXBy?=
 =?utf-8?B?VlFNekxtaXlGc3YvMk10ZU1OQXdyY09iR0JKZi9wQktnWEJKak8vMVE1Z3pw?=
 =?utf-8?B?Qk1mK0s0cDBSY3dGcm5qVEd4VGU3ZmlCalIxRHlvUEdSYnZZVFllZDhvd1FI?=
 =?utf-8?B?d1NtVmNRUDV6TWRoZnROQk1tcUVDMkNyWHozV0xGMjdYMU1nSEZsNUNYazgz?=
 =?utf-8?B?dzA4THZlLzNjM0MycG9IU0RHVGlhNGNMa1JzVUV6SllaN3lUZWNlSVRDVWhy?=
 =?utf-8?B?NHFjalVlWEZEVzhZOGc5SXZxSG94aHRQYUJmdDh1N0lSUS91SUd0b0wvZ2lu?=
 =?utf-8?B?d1l6azZDSU9uTjhOOGlJTXVpZkh2Q2RPTW5hS1c2OGZVZit6bGp2SmxXSzBF?=
 =?utf-8?B?RmVZWlJ5c3RXUXZPeGM3M1pReGU2clFGR2psQ1F2Y0lYTitlMWRLL25UY1Fp?=
 =?utf-8?Q?nzJcFQyC++drPcQeTNEeX0O7i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1126f36e-2b4f-4b21-eaf2-08de1eec8d78
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:30:47.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GDDnKDkJfrYbd+XP+lII3iKZisAaOaUPxDNw9k8YrtS1n/aSucKU8+csPYqVICuJ4g18R3KYk67bpPZJXcVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> Introduce IOMMU_HWPT_DATA_AMD_GUEST data type for IOMMU guest page table,
> which is used for stage-1 in nested translation. The data structure
> contains information necessary for setting up the AMD HW-vIOMMU support.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



> ---
>  include/uapi/linux/iommufd.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index efb52709c0a2..d111ee1dc572 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -455,16 +455,27 @@ struct iommu_hwpt_arm_smmuv3 {
>  	__aligned_le64 ste[2];
>  };
>  
> +/**
> + * struct iommu_hwpt_amd_guest - AMD IOMMU guest I/O page table data
> + *				 (IOMMU_HWPT_DATA_AMD_GUEST)
> + * @dte: Guest Device Table Entry (DTE)
> + */
> +struct iommu_hwpt_amd_guest {
> +	__aligned_u64 dte[4];
> +};
> +
>  /**
>   * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
>   * @IOMMU_HWPT_DATA_NONE: no data
>   * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
>   * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
> + * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
>   */
>  enum iommu_hwpt_data_type {
>  	IOMMU_HWPT_DATA_NONE = 0,
>  	IOMMU_HWPT_DATA_VTD_S1 = 1,
>  	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
> +	IOMMU_HWPT_DATA_AMD_GUEST = 3,
>  };
>  
>  /**

