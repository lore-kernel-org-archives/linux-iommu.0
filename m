Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BB13AD20
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431865; cv=fail; b=OIardsfRFtPnlrPEY9nqbhHNGBwg5BsAQ+xVZFyXoigQrJD3UREeIS/R6r7BX92npwtpbdoE9NKqhtmbXd7EW61+nV1zxYz5QN4jOk7Hr1t3thFK6PkOKKhKvXqYm0UXH653Pjeqn64Lv3Yn9JwPvSRv0wcSJgKfAePtoZ42fFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431865; c=relaxed/simple;
	bh=6ZKXWKW7f3Shxbf+oq47Dtl0ussoGZU7ed4I2DmZwKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qkSzJqZfuk6amzEB1m33TGePEDLTKrre8a5A1ELmbqR4pH6SkQ5h8D2GgWwsf36rkGHGegR0OQ/R2pP0Sueco8A5e3iuTCG96uJeZciyHfJSUTds/5kyZO7ZskfTjLAjJGqYTCxOQ+6+rLA0zX/mI95sKB6bI0wo0nshYK+fJBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KW8eCkXl; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KW8eCkXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKWExgxrnzsRIni799euFO2LZ5VK8HxD6v2ikHRZI5OJ/ymHgPZ+B1aXID4AO3Bq23Q7zeI00K+V/RH0GC4AalkaBZxhmVt5BdJRLxaQY2NUvo8edp+pR7jQcRd4WNqcLjsbq1SNsCR7u9fY6z9YJUbKGhW4cv00L4DdH3qHFHh/hJLNMD+laopch7Pga9r7ymonv0wVKyt3Gx87PY9rjQ5nOygErOu09qO2zNLYqcuzPJ0CysbOvJKcP97gu48AdPmE53nLLE3z8G5TgLzhmC9fNORSNf1TamwbGiOjy4Ov8jv9NWYjkxFspN0AYYLl24BBOUNRo81XZxYhkt2dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDyAtuuipfXf1z/pf/Hjcp1pPAuVMka1A8iCsH/zh7I=;
 b=mNh/dIjqu0CoId5533DJadwTZoP5ImI7TYxUcQuIEXqOhkzAPmXq2zA1cmYzUZ+MYjeRsB/VN8CohNth7utsIDUSb7slk76p8R+EwH0dHZg8e8UDJtVKF0kMUhxls/4RL/6v+vKFPAHuHwIPZrbnt9UsPM7L4iygwhfMxi0mcANUJIsGAReUonC9dJpo7weZDY2zPPdo1Zn4Tj7OejmcQHNEpJnT3DkOkA2rxj+TQQNwEpca8VVaTMazOuiqgEpMyZCjXONFcT23gESl6bHF/gESzHJnJWEjPnIN//Ixcx7ncl4jjsJM7UdIdNtgOQi/jDTjlr8cXnzqX3eqrm9M2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDyAtuuipfXf1z/pf/Hjcp1pPAuVMka1A8iCsH/zh7I=;
 b=KW8eCkXlIZWJgdQbytyfdH13Co/4cN+gFE8CBe9+uqmYEHx+MoeUhgzV3StGYVjbo/4jkY+Qa838XhAPJTYha/hjBnGxwVzIe9wVSMRIiI5fbp3wNsbDPDGf38EzXoNIZTutByufe+8ttXzTTZB0juPjKvLuFHUnWVSqTxPHjGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 06:37:40 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:37:40 +0000
Message-ID: <cedb5352-8298-4edd-9212-37952cf879b2@amd.com>
Date: Wed, 4 Sep 2024 12:07:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240903072518.780705-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240903072518.780705-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b4ae70-2e82-4dde-88d7-08dcccac122a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERFTG4rYXFSVUJVRlpYZGhYMzBjOWEvaExZOEpTMTFLL3czSGtwNkIyTHRL?=
 =?utf-8?B?Sng0MUYyZnFIeU9tbUFXbnBVQzlOQzIzaXNRTUxpeXlIcE1EV1RNd0Ryc3BS?=
 =?utf-8?B?OC90SzJDR245eFprYTA5b3dkOEtmcCtXd2VQdXNISE5qSWFKeXlEbTQ2VEd0?=
 =?utf-8?B?d0xYNFlxdmlRcFd2cDhzdDFQTGUzSmpWWTczNXZWeXYyZVZNZzNad1JwY1lw?=
 =?utf-8?B?ZEZzMU5oajUzRGFYcGZJbkpsRGhQZTB2cmhZYkQweDEzKzBrQjVvMmtFS0k4?=
 =?utf-8?B?dlFPelpJQ1BwRTRrMFlXMWU1Szc4bnV4NGVrODVtZ2tBR2xvQUFHOFJ1bDd0?=
 =?utf-8?B?NWhWZ1ZKbEtMc2xNVGhSaXdsbTk3WWk5VmhzNk5LcEdQSmVJS2ZTYXhWRUhn?=
 =?utf-8?B?QnVxMzZaUDJOUWVLTi9kdUVBa3FBUFBmdGhEMVBoODRUeVM0VGVFcGJCQlhl?=
 =?utf-8?B?Tlp5eGZnZUhEdjdlWHBvMDFnNFdpZ2pHMGhacUlVMHcwVCtZK1E0NWxrV2pt?=
 =?utf-8?B?TGF5dVJhRFZXQTlDVnQ3TWNsR1lIaWRqQnBuc3BZa1VoSlhJLzF2Q1RzS0po?=
 =?utf-8?B?dCtVUkZWS3dHeHN3VERlRVdtQkUyL3FhaWVlckhjSlF3Nnc4OHB0NlNkcjdE?=
 =?utf-8?B?bjdrODY2L0llVWZzTTJQRGFxOGpSa3hPR3VLZWhtQ0xVSEVtWC9kOC85UXBo?=
 =?utf-8?B?aGRGTDFvWlZ3V0RNOEkxQitiK3l5YnVEM2Q2Y21OemhyK2VlS2lJazB4VE5x?=
 =?utf-8?B?VENMZzVPTXFpNWFvRWJOZ04xYm5CM1RPbmpRbEJrWnh1bzJOVUxZc3Bva1Fq?=
 =?utf-8?B?WExJUmRMbmUrL0wrQjRsemRoMTNLZ1NmdEswTzlLc0xSY3NScXZ2amFKNS9J?=
 =?utf-8?B?TFF5RkxHVjdDMTlMTXpXNTJHZUJRazhRMExxejJQTERnZnZ5eE5oRU1EMWVl?=
 =?utf-8?B?WXExM1FIVXhNMUpjWnByUmFHczZuODhWRkJsSEhMNHRIZFZMODhYaVJCN0ty?=
 =?utf-8?B?eVJaS2RjZjdkM2JhRExPTkpsTVAzQlU2TkpPR1JUWGRyUjFvOUFRYnMvUUN5?=
 =?utf-8?B?dmFjREk5RkpuN09iODhkNi9kNXh1K0FpUjZIaEhlb3BWREhqaCtEZU5EWUlq?=
 =?utf-8?B?a0ZHMHlsY2VVZmRMRytoZ0V5a1VEaDBKam5pZ0k0d2ZRVlNYWlBtN28xTWg0?=
 =?utf-8?B?VUhMTUpaUFZKcXpzOUl6RU90VXlHZlRqVVhtRFJGT2FiSFZ5aXhDTjY2Q0d4?=
 =?utf-8?B?QWdQVGpUZkpEamZ1VVlxcmlta3lZa0lPNlo3OTFsK1dOd09uKzJhdlJET3cw?=
 =?utf-8?B?WS8yZ0dQSUR0djFtMWlyV0dRMFZNSnNtaEFxaDE4eUdpQzZ6aGxQbitpbEFP?=
 =?utf-8?B?c3VTSjJSTWZuQStCbHVxaGxka0U5UHdVOUFWK3FoZHhPTUpKUENKeGtKU3hr?=
 =?utf-8?B?K05SRkU4Vks4akdDUm5VN00vVDdBbnNEMjdqRWpuUGhuT1dzNi9qaGgrVXpR?=
 =?utf-8?B?dmdCOExHZ2J4WjkwTHhQc0NncVJsTE5VcUJ2YzNIUXorMTlGLzJPYlRGa0ky?=
 =?utf-8?B?ZzRRa09YanREdDNRSHNuTmZ0RUtiNkpzaUVlWXZFUktqbUF1ZE5NbTdWNFJi?=
 =?utf-8?B?bzlzUzZsN2dtK2cveU15UjdLMW1HcWpYZUovTGRRQXM1bXlvR3RITHBsYUR1?=
 =?utf-8?B?ZlJyNEdHUkRzNzJrTEJEamJVZ29aNXdrajIwanJTc0pEMmJPWk1DYUpwOFZV?=
 =?utf-8?B?UHdENGRBb2E4QXVDN21QVDNobUN1bk1iTDUxS2RVU0dvMjlpanNGWXBPT2kv?=
 =?utf-8?B?TWRrdEZ2MjRSbFQ2YWp4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9PNm9MTnNRamt4bDQwOXNlb24wSDNnWjhhUVFYKzhFZERZS3FTM1k2R09l?=
 =?utf-8?B?UkM0OHphTlZtVlRJMERyd0gvZjY1MWxUTTNQemdlQ1lQZGw5ZE1QQjhTb0g0?=
 =?utf-8?B?Y3dJUVFIcnMrOTZTT1V2a2hGNVVpa3hZQWFkak12ODM5M0srZnJ1b2pWUE9z?=
 =?utf-8?B?TjVUVTFhQmk3aUp6NWYyN2dldFBsVnk2WHlFekdabkp1NWs2TGtQamJwOGFL?=
 =?utf-8?B?dzdtTTR6SFNUR1N4OWhCckxLWE1yVGloS0pYd0ZqWklGc09ISVZQdjR5R0ZK?=
 =?utf-8?B?TG9ZTUlPOTNCQjluNi93UzU4aDkrK2ZRNnhSR0ZINkhJU3BSOHVMbjJYcUZp?=
 =?utf-8?B?THB6eHh2RHlQYmtuVDkyUHBacVFaUnJtRXN1bnJsUy9SUTloVkR0eEJUYjM5?=
 =?utf-8?B?V2FIdkI5M0poTTg3cWdiTzBvWlAvMjdLUmFBWmZYUHhFRnFvOVNqRWUwSjBx?=
 =?utf-8?B?ZlhuQjgwYUxBN25sWHRESlgzMTM5dVhDaVZEeURSWjlic21WcHZsbjhSRng1?=
 =?utf-8?B?NHQrdEF3MWx5dGpSZ2todUkwb0g3MVNablk2ZHprWUpMUkxGSFl0Rm1UeVYr?=
 =?utf-8?B?dC9GdTZmMERuUjdpUE80TGZXa3lJSGZxd1NyWTcrbnRyOUhhMkdVUjVlcGR5?=
 =?utf-8?B?TGs2eUR5RHZUblo2YnVrN0VpbDFRV291L3VJMFFaL0p0K1hyZ3RVVGRtaXV2?=
 =?utf-8?B?QmZPZCtIdkVpRnlvRzZMQ3RHdmplNkZGbTUxd0RTY3Z5OWNvRy9qUEhHS2VT?=
 =?utf-8?B?T1YyK3VNTWRSaFd0TWE0UVY4KzFDcWlQMU5DVXJXVXBwcVU1cjE1ck5zcENi?=
 =?utf-8?B?VDhMOStyWFptQ1JqMkIwb1ptQW5CdzZOYllIaEdza0FGQjhsaC9NdzdWUjU5?=
 =?utf-8?B?RnY5elFMVmlLYzZFL0J6aTU0MUxrWXJ0aDVwL3VqeVVWUzJTalNjR1c2N2RJ?=
 =?utf-8?B?T1ZFOWNoZ0d2WGVqaDQvUndNUVo5TDNvV0N0ZkZUZlRaK0t3YnRZMWMvRnhu?=
 =?utf-8?B?UHhyY3JleTlKMWlyYjlzeVIzc3lFUnE3Q0RYMUs3V0FZT285UWxUZHJjVitv?=
 =?utf-8?B?eHlndXloWGVVWG5RYXBUbVU2bzY1YUF1UkhLOEN4bUUvRjd4WEF6dEkzV2ps?=
 =?utf-8?B?YW9obDM4Q1YwMDNKQUYrZkNtb2RNMlhaRGFWOCsyUWt2RHhHb3ZYVXhDanMz?=
 =?utf-8?B?NlpCYW5HUFdlcVhVdEpTdGlWU0x0MVZTNUlDQXBlaWh1clFZT1FJdE44UFJx?=
 =?utf-8?B?QVZGdlluU2JwaGhSSXJGcTY5aUVwQU93ZmZFei9mc0htaUJPSTExZlpIZTZX?=
 =?utf-8?B?ZFc3bHV1WWlPMFI1T1Y1VzJ4VTFhaVpycmFGU3pDZ0swZHc2Zm1BYTRjbTBU?=
 =?utf-8?B?K0lGbkdWM1lmZ1FsMENydlR1eGZCbDJyV0NGY09oVU5BTXRnWDFBYmx5dC85?=
 =?utf-8?B?eG0rS1lmZ2Urb3JxVTQvcHFKdVlvS0xVWE5yZndTNThKdHkyMUptckFIU1Jr?=
 =?utf-8?B?ejVkVjY5S2t3VzhMOEI3eC9paEJGdVZNcnRUQUEwMjE1M3M1eUpyOWxOWDRx?=
 =?utf-8?B?T1E0L2xmZTUvamxrY0Y2MC9qSThNTUdLN0VybnExUUU1VENONXBjRlFDbC9Z?=
 =?utf-8?B?RWliRjY3d01sS3VsUG9JaU1aZ2xlTWhKck50TzQzSWszRlpxRHArTnloUlhs?=
 =?utf-8?B?ZXpCOE00SFNJWkdiZGR1TjU5N3c1dHhIRUR0ZkRQQSsxeHJTL2NwVGdUYWRM?=
 =?utf-8?B?VUdpWnBHTm0xeWJ0VVVnOHJXc1BQUFJMNmJTZHFFdWk2SHVJN3AwNEh1Qzgr?=
 =?utf-8?B?OVlKazM3ZDVkQVJYWDVWYk9hY0VoTmNVc3dhZWFpQ2I4OWZPOTRJaUEycEVr?=
 =?utf-8?B?ZU94eTFCblZqUTcrWjJNclNZbHlMa1YyTVc2bUhyTFNVZU5sZnNzbnhHT2Uz?=
 =?utf-8?B?bUd1ejhZUG9ld21HZFd1MUdqSDQ4NVhUWno3bFpjNmE1bnd5SGhLTk5GNnN6?=
 =?utf-8?B?Z3NhSmc3M1d1b1hQb3ZYZmFQMjlBaDFWRHVnUzBxQ0puMmhtM3ZIL2N5eWp2?=
 =?utf-8?B?WXBNT3E1di92N0NwL01SMEo5aVRZZmcrTXdsNVBUd2FYTUlSTFltcEpGTVMx?=
 =?utf-8?Q?sr73CIcCE4P6TDG8mnaIrvIlZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b4ae70-2e82-4dde-88d7-08dcccac122a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 06:37:40.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbR9JivkcK/HhzBG68b4K8iggcVm7xNlBwuvbwwiipUbtLLg2m3qj+JBg/bRZ73iUT4dFWhE+tWCdrMkVbt9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

Hi Chen,

On 9/3/2024 12:55 PM, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.

Thanks for the fix. Jason already have same fix as part of his io-pgtable
refactoring series [1].

[1]
https://lore.kernel.org/linux-iommu/0-v2-831cdc4d00f3+1a315-amd_iopgtbl_jgg@nvidia.com/T/#m79d88869627b02eed4b954d31c8b96090f3e0b5c

-Vasant

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index 664e91c88748..67f1fd8fab07 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -373,9 +373,9 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
>  	pgtable->iop.ops.unmap_pages  = iommu_v2_unmap_pages;
>  	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
>  
> -	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
> -	cfg->ias           = ias,
> -	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
> +	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> +	cfg->ias           = ias;
> +	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
>  	cfg->tlb           = &v2_flush_ops;
>  
>  	return &pgtable->iop;

