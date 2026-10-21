Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792577374;
	b=aGrLKHqXtySVcLGR0c9WwpaHOhl27xVlVAZ9DU7+LMoRTBTETrOUzpK7VCl7lanaqgtj
	 j4/dYKaX44zRg2IC1s9iUu4JUsdemxmvcEeyEvsuptYwqyGE2KNS5+zBulwVtmL0jBE81
	 Zh2+ss1COtlm1/9FNTeecPKI071xxkgmWUMZ5vFGM44eTh0iqTK49nLJN7YSeJp0XeFVx
	 yB7jPnrNikU1XzjRaXAaFkWf9hVuICD0bKMImxhiZwtC0ud+oGV8zyo1ZaVr1Y74+B9Hj
	 f0ceahfuokdmG40zr1RfCv4TwLAY1yyVUqFf81Hj8yoiC2ceSYwNHvVQDluOmz6VfgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577374;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jg6Or68TDMePlT45ErBiXZH/xRr2ye92FSiipzLKHCQ=;
	b=nB+J/t07lK8bCOdRbNFuicgiKIoeKwO69CKdKOkvDvfDUNamUgMoCPUZjJdEETTn382b
	 ki+3vZpOBu1qMXFEOicUy3AKvnnWRcVl9JXLYinmwbhe2eiFUFx0Gviq3g8DeWz+9v1Mu
	 OAHQna9N/tkTmZSQ7vRpvvkG9L7r0XBUroZ+OoW/gezJgIHdAw3IeNejtu90cKj+BjKRJ
	 82fh58ljutjCxqJez6MlcRdQdYRNxxpXZGwC53LlXBIZ4GywK14aioPt52hN1VjwLdiKG
	 lEVUo6Ck3ktWPCEBe2bmWgSDlMQISImXW5hSQuvDYjTaWKLb/w0NVD+coENfZ3NMkww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W3VTUzD0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.36
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0631606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0631606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W3VTUzD0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn7E/yzn7jN1YbYxEDfdu7hsEDSrLeyOiDmSB+5WLoaZpVY+zSJWgckF0PwFcGim2W17SJEmrEWaI9eNsNIF+uNmF5bltZ/yQgCagsUdXl4Rpv3FR7GKVYr1mJiDXf+XfZCJkyRgJIhc7o8nSntzYswhOps6mm7l5kvLbm7OczuwRsP8mJw9F8ZHVYsH6BuDblfgoJbSFHCcmsfqMzwp5bN+RjqHn9euKTSxdGxaLJxk79cYQ2xq0Y3mvabG7TftdwzC//vxW9UXohv1ZF85vqlRP12JGMMo9VwoQnuvMcuBKEfy3Fh6BM4W5lNyXt3qVffqIsQpmLXbKGYWT88JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg6Or68TDMePlT45ErBiXZH/xRr2ye92FSiipzLKHCQ=;
 b=j6fpq38814p2/JviVJvFKlHlX9NRbbhT5w7qntFPq7dX7J0dH4K8FR5wMi9q39ow8bZp7qfpfaXrCFDxmvX5gHMl4gLzykcniqrPHQUjCjzvbv9axs65xYyrxvH94UkF3g2x59jdfItvMXCSRk19RGS9vygYzyS60iNTq5G5bygdsxc+Q3ri4r5wPtCKp0785kPIqYlrKVnLkTP141tU1dLH1k+Z08sB/3ipIMNVMNLfxzuRtWZ6oLZZmyqwysMucsJxujGU9ODhSCZOF2Ki0+ah7m6Kn+Xr5m+wtUhjhH03kPMMteLTQeu0Z3n3W2JLtxBHXVpl9Au0JjcggGW74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg6Or68TDMePlT45ErBiXZH/xRr2ye92FSiipzLKHCQ=;
 b=W3VTUzD0EYluWmCQbx7QoTPMiBSMadLDQ7AlkgSefnuGesfMl7uT19MdbiuojSoMazssnM7kgciWJ4XyjzQupSfDY3aebwcftLZ1dj2V3ivWYe+h4NzysGoaSSaVqx5QTfleDT04wI524Nv67/6wKbko6fBA1+GdvOM+z4DzPfM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SAAPR12MB826020.namprd12.prod.outlook.com (2603:10b6:802:300::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:09:31 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:09:30 +0000
Message-ID: <66a43b7c-42bc-4f87-a26d-66cef6f24812@amd.com>
Date: Wed, 21 Oct 2026 15:39:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/24] iommu/amd: Relocate vIOMMU translate-device-id
 on PCI reserve
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-25-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-25-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0238.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SAAPR12MB826020:EE_
X-MS-Office365-Filtering-Correlation-Id: a2246a5b-3c78-4978-72db-08df2f5b65d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z6Fy3xQdQxZOhpgpwmdw8wTTQNrtepCi5hcfCDoSjn6wN5eVpZOvZ/bO9ythxPdranYykdYslRfN9f46QcPit3QrYpcoaGM7nilGW7aBLF2mFZq1RNN+4UgW9pzZRb6LtlguZee64Wz7to9oeA/M+5DwLL2/roIZlDRBvXo/xdMW6qrRJ3JgcAP+uAT4B9RLmUC/aimmSAywmjPD/MoR5t4BnToPFcDSbmd9K0qMt+QQRZ0aZOOqTGjvNTUm/BwoGJ5t/lbk+2t8pNrKq92E0DBXo/afONFEGPqzpwi1YRchR8L6PFiXVgAIWFNpGqeix8RfKTZZxAnI7a1NHxCkaRLb4IrXIru7YIZCxgN6E5cuG07m2oETThA8WWoZhQYYBCuizLo8gisWqq53yKN5HkXjlZVPCBvlKCI7Kk9tmw46y9y4nniUhx5aqlU+0PV+VgTBjzSKJJnsUwCvGlxHZtYpxQ/QFhr64OR79zon1e+DNSd/nGyl/FkjjkfjqryRQNh0gBBv5hByHkCeka6sbpe4iNeFni9CTcDosp0dYjPnrWii79N28oPxO2UQm8Tzq4LkF69N+vihaE0fXTuGRD+m6ENZVWh9phrXtm2ka76jlq6xEsDjDUhkIhZ2lDFVMFi0wupS0Lq9EG/WpfsUZM/LPPnRsuiM3g0ypA1sktU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmhEWUxIY1p5NS95azhxaTJvdmU3ZXhSc2tCRk9PTk41UGJ3a0NyTVVSbkpU?=
 =?utf-8?B?U0NRc2FwdS8rb3IzNkFVYzdveTBPNVFoRUlpZTRSbFpxZ0JFUU9hQkZEUjNl?=
 =?utf-8?B?SmJWWXFJRXNiWUttMEdYWSszR2NydkREeWhwaE9sOGlGVXU3aEVJT1dXVkNt?=
 =?utf-8?B?MTBqZmFBSkVPZE9VQjd2MEJPb1RiemlzS3VUMjRHZTU5TUwrLzFxTnhmemgv?=
 =?utf-8?B?V1RlTEM5VkV0QWZ3djhhcVZlZG9MMDlNOUpLVXJHc3NNRGg4S1FSd09pclNX?=
 =?utf-8?B?OG80YlM4TkhSZTBrZkNlQ0k4RTBqSlpKS2lRMEFHMVJtdlRYWVJkZ1lhOHVi?=
 =?utf-8?B?bzcramRvWEhLVFJweThQZVNDWmpCVUtrd2ZJL3F6Umh6Q2F6QVp2dzV0Q25R?=
 =?utf-8?B?aGRLdlg1T3FrV1ZseTREcm8rSzlXODl3Rnk3Rzg5L2RRU0I3bW0rdkpKaXQ4?=
 =?utf-8?B?Q1Z0VUU1bWlSY0VaQzNWb3RKZ1Nocy9wOXh6cmRxTkhrS3A3dHhNS0d3SkVC?=
 =?utf-8?B?UmptdmJKWTVGM1Y0b1lCaXRZNTdNcVdyTk4yNTBUM0hDdzNtSzEyZVp3Zko0?=
 =?utf-8?B?eWd1NkpOempEeVp2N0d0alRRaDFMZ0hTQmVjZnk2TzZRWEJnbkxUblJ5YmJX?=
 =?utf-8?B?QmxwQ3p2QXVibU4rU05oelRqaER3bDBuWTdqbmlwRXp6VE82UGpqNTFSL2FY?=
 =?utf-8?B?Ylg5K3BJU0gzYWFnNEFWL2p4bXhwSFR6eE9kbExlUkFHUmxDZm90RGtjZEtQ?=
 =?utf-8?B?VlA3SVorOFJDWUFaWnBPa3NhVm9BZWtBcFJpVDZnU3BRbGl4S3FVV0NUMjZj?=
 =?utf-8?B?bnM4RmxaMVM2c3ppVGU0QmdWUFAyakpVZlhESTgyTFVsUHM0cmFtMG9nN1c2?=
 =?utf-8?B?NUdQMVZ0YkpxTnlRYjl3UjdjR3k4YUkxMWVYYUFKTWtTWmt6aVg1VUJPRnVr?=
 =?utf-8?B?VUlydDBuRlgwUXpLT1VsTlZsZDVIeDRxeTBtNndQTkI0ZlBhTDRoRmFqMGoz?=
 =?utf-8?B?UkR2MXUxTU9JcU9FVXo1aVdjMEhrZld2eDRoTklQSWYvM1NjMjhlSUZTekw0?=
 =?utf-8?B?aVk5M0tSdFJOcGFUSXU5Ujl3VmRydk5lai9OVnpXVFNoOEE3Nys1UzA2Ums4?=
 =?utf-8?B?VnJ2VUFoaHpTYjBwUFArdGdxTXZtWFAzTGdCRVU0bldJRHluM25XWGlEeHNp?=
 =?utf-8?B?UkFzM25XWVFNOXZnVFNFVk8wUHp1ZzFGaUY1L0xTaVhtRHJXM3FiL0cvdXha?=
 =?utf-8?B?TFAvd0g4SS81MjV5NlpyVFlhbmJXazR5OW5NaFJweklEdzVla1JaSE1yU1l1?=
 =?utf-8?B?eGR5TGhiUjhFTXZUWUM0R3ZBRWRkOGIrVVBmaXBtREVaMndMa1EwTjk1UFBY?=
 =?utf-8?B?cktQUTJkZDhER2Q4dUNUSDZRS1hNQm1CYUNCK04rY3ZyWnY4OWFsbmtvY3lV?=
 =?utf-8?B?UTh0Uzd5Q09WbERDUW9kYXhEcWltUUZ3SUpOYi80RnRSaGx2bDVQMjllOGpZ?=
 =?utf-8?B?aHdWVHd0VDJpdEF6dzQ0cXhDZHNaZ1dDODF1dEkyOXZUS2g0Yy9WSkNKaHFk?=
 =?utf-8?B?aVM1NENLUHQwaU5lQ2V1aUtPMDUxMWQ2Sy9hcnkxamNlSXlqUHY0aG45NlJs?=
 =?utf-8?B?eUt1TVRaV1pXN3FpS2lqVGg2OUNseS9mTmhHODJzbFo0RlRlUFV2SGJLcWtF?=
 =?utf-8?B?U1BHd3Q3NlozYWFBQ2hNWXNMbG9memtxYjBoTEVJUFBKLzdWYndoR1hnRHNh?=
 =?utf-8?B?cUd4ViszN3RVRU1VN241S05LRmNVOXBkTGRFbVp3MWwybStHYnZMMEJDaW9t?=
 =?utf-8?B?U3dTZDVZbkF0M1picHZ4Z2hSaDNhT0xNRXk2N3FySXBESWR4TmhKME1NU2J0?=
 =?utf-8?B?UkxPM0d5VXdIQXdnZ2NyVDJvYTgydmZPOVo2b2FTcUM0L1NOZFJmWC9WYXk5?=
 =?utf-8?B?bnJGb0JnRS9CbER0SXdjSEVqTDZKcGJaa1kyR3N2alQvTjVaRWNoWGtYRFhE?=
 =?utf-8?B?L1V1WXlzak90ZVYrd2VhRFM3WFBVZUVSVFNYMGdlUXcvS1hwSm96c2VDQS8r?=
 =?utf-8?B?aUw5KzFXOFJ0K3MrRzB0RVMyU3dycVZMa3dwSG1sV0xIQ2hCaUYzTHp4Nll0?=
 =?utf-8?B?VDhwNm4wTEx4L0RibmdGRzRGZzZRUVFUQ2JLVzZIVE5OMThZU25xQlI1S1BW?=
 =?utf-8?B?Zm5xZnB1V1RRMmtuLzV0MDR0bFQ1bml6d3ltT3dscVl6QVJPeTRDcHpveTV5?=
 =?utf-8?B?emJJeEtUZlRBQU5YWGxuWDc4VFo5ZDJBcWk3T1U4SkpDZG5Memh4UWFsNmNl?=
 =?utf-8?Q?Oafh4VEz1XupDA/kxz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2246a5b-3c78-4978-72db-08df2f5b65d7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:09:30.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFyVgba0q5pJJvhrodJSRWull7Q9s6im25l0ZCHKApsm0L58Jw0bH2kapZx5cDa3vRHBtxsxvQ05leUhHoOj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB826020



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> When PCI probe reserves a BDF already allocated to a vIOMMU, relocate
> that vIOMMU to a newly allocated translate-device-id before marking the
> BDF reserved for the device. Reserve holds the segment mutex and
> trylocks trans_devid_lock so the vIOMMU pointer stays valid without
> reversing the nested lock order. Reprogram translation DTE and VFctrl
> under trans_devid_lock; roll back the pool on failure.
> 
> Mark from_id reserved with a raw xa_store so ALLOCATED->RESERVED does
> not WARN on the non-NULL owner. On MMIO failure, restore from_id the
> same way (RESERVED->owner) instead of install_allocated.
> 
> Reuse the vIOMMU's trans_dev_data object. After programming the new
> slot, clear the old DTE without freeing the object.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  10 +-
>  drivers/iommu/amd/trans_devid.c     | 146 +++++++++++++++++++++++++++-
>  2 files changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index c748bab27509..347c6954439d 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -558,11 +558,15 @@ struct amd_iommu_viommu {
>  


.../...

>  
> +	aviommu = trans_devid_xa_owner(entry);
> +	if (aviommu) {
> +		/*
> +		 * Pin aviommu with trylock while the mutex still covers
> +		 * the xarray pointer. A blocking lock here would invert
> +		 * the nested order (ABBA with destroy). Dropping the
> +		 * mutex first would UAF if destroy frees aviommu.
> +		 *
> +		 * No retry bound. cond_resched() avoids a soft lockup;
> +		 * progress is this owner dropping trans_devid_lock or
> +		 * freeing the slot.
> +		 */
> +		if (!mutex_trylock(&aviommu->trans_devid_lock)) {
> +			mutex_unlock(&pci_seg->trans_devid_mutex);
> +			cond_resched();
> +			goto retry;
> +		}

AI comment (looks genuine, hence copy-pasting as is)
This is an unbounded trylock/retry loop in amd_iommu_probe_device(),
which runs under iommu_probe_device_lock.  Would a single per-segment
mutex covering both the pool and TransDevID/DTE programming remove the
lock ordering problem, and with it the trylock?  vIOMMU create and
destroy are not hot paths.

The reservation also runs too late in probe.  amd_iommu_probe_device()
calls iommu_init_device() first, which goes through setup_aliases() ->
clone_aliases() -> clone_alias().  clone_alias() reads the device's own
DTE and copies it into every alias slot.  Only afterwards does
amd_iommu_trans_devid_reserve() run and relocate a vIOMMU that owns one
of these RIDs.  Two cases look wrong:

  - The device's own RID is a live translate slot.  The VM's translate
    DTE (GPA->SPA) is cloned into the alias slots, and the aliases keep
    pointing at the VM's address space until the default domain is
    attached.

  - An alias RID is a live translate slot.  find_dev_data() creates a
    host dev_data for it and clone_alias() overwrites the VM's
    translate DTE under the new dev_data's dte_lock, not
    trans_dev_data->dte_lock.  Relocation then clears old_id, which
    wipes the alias DTE the host just wrote.

Shouldn't the reservation (and any relocation) complete before
iommu_init_device()?


-Vasant

