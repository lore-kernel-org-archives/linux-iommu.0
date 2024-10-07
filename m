Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023127.outbound.protection.outlook.com [40.93.201.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CD1DDA06
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323415; cv=fail; b=Edaymj/6Uwo00hJSxb1dAydb+J024HYwadgW4J8S1ytY3R5uOj8mSV9yzqAXF7LBeBt+k/O5eEMaXLaGcf9oXAooLPGj/4Pq89TIumwikDRRm55+98LrDx53WLym0LWtNw8YTfuiv2jgePS985dBvX4kxzgYrBNnO5OWwV4jnXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323415; c=relaxed/simple;
	bh=ID6AVNuOsK/tg+xvHkr8RTtSDvp5c0JgBpREpdJ7pRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv2lUxuYEyVUcxYVrS6/dWMe114b/4EOPf17JZLBsrgVjtC1y/rNPfUPDclsJZikuOA5ibFgRDJp0DZq3cWdfRulVf0wXSROD9COgc6mFOP7cCSLrdOnu6WqhZ6UwlCoxoAEUWaes3GT3nvfQTRKz4s+GDLlAXBqSfGmb4gVtqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UHvT3XwA; arc=fail smtp.client-ip=40.93.201.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UHvT3XwA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHvh5/yeL1K00hy0OQQ2CuypmpGgtFnGpTQSGb48c2TV9XArQ5BQ5SByYOL7rDWLbpHsjt5NCbVKttUqO6prv7ZbQxotM2PL4HuP9ftViBuwHHsktIrcgEIxEA5eLZbFQE3RQ7wy0eD6WXDta5RRC1kTvBfy9z7o+/k2U9rVq2ls1fc5fbcQFwqedfuyKhl1uz8siSDTsaBV4/Q0JGz3+NHrenhE6ifRKU0sZ0jHRd7dKaGks5yeUV/3rWuq/74BUyxr2Ob1V/mucPlrp2T+BbDkZoVdT7StkzJFMIbMIzaG5V9ry24IzaZuTZnipWZbRunwMNmm0YwkuqyV7JWbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7thfPDgyG09cJxALgW7PYLbJLwEPQW6vhgUqk63kzg=;
 b=sC09BV1Qg7ZdQlBeXBfkH9GTMNLp9VoSUor6bUgCyJKTgonygWI9d4ltxjOmnzfIr7O//tI5cQIJ6PXwKf8uekemmEPozD138T3hr6FiKteYeb6hq7X9jPJDgOnDrXU4u/LjMqFa6SSha0KESmE5/FkQD9DE7/pAaLS3n9vgqSURtUTJeTfZh/G7r6jN4Hp291JKPgbRgRfDFdGh72Ykanzk9mBZr2R8hYWK+fLXa04a37p8+5Rx3cq1TlJroXeRiXa2v5vVuUJ2oqd+N7a/+JStzW2037AaNszENnISihgHzeMf+aQM7A1rRZ6LTqkmnEfGPx0+bL1s4fKZgr/LVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7thfPDgyG09cJxALgW7PYLbJLwEPQW6vhgUqk63kzg=;
 b=UHvT3XwAAZxtnevfZV7KIlgQxOGR+sjtuaSbJUfdwXpW+KhGTScq7B4a1r9s36MhnQXcnskmFfblw0Bam6ik95PyIlTwbOt3G8mC5kSfTdzKBc/Xs/HYQwe7mNL0BOzt/E4uoIAnrqcjIlQWR8wN3PCVpbMEHDgLI4OkbeNEGKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB7263.prod.exchangelabs.com (2603:10b6:806:1f2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Mon, 7 Oct 2024 17:50:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.033; Mon, 7 Oct 2024
 17:50:01 +0000
Message-ID: <f434f714-b38f-4ed2-97f4-8f00a03b855b@os.amperecomputing.com>
Date: Mon, 7 Oct 2024 10:49:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Daniel Mentz <danielmentz@google.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
 <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
 <CAE2F3rBBx_bMgVi5R1G7d-B+c3UdXiUB4sEL6KnsNc4gWJHroQ@mail.gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAE2F3rBBx_bMgVi5R1G7d-B+c3UdXiUB4sEL6KnsNc4gWJHroQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f51a08f-e5dd-4615-d56b-08dce6f877b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azZoL29MaFU1RGc2RFk0NkIvZExXUzROa25jU0cxbXFWbzllQ0w5d083R0tX?=
 =?utf-8?B?Z0RMYys0dS9YVkhuT2VNUGJ4b2hyeHVZWHg2dThpdis5cUowQWk3VmJiNnV1?=
 =?utf-8?B?MmNBM3ErVTZweW5DMXlndlB4Q1gzQkQ2NmpDUXNFd1Y5bnFGbDA3VWg0YUF5?=
 =?utf-8?B?RW9Ea1hHWVpLdUJacGk3MmNWcTkydzhwbW9kbm9JaXB1RldGSVhEb2xKcFJB?=
 =?utf-8?B?UnRkZm1WR0xVVWR4NzBZK2U2U3ZJWDg4TWd0dGY2VkoycXAzMG40NG9Jc05Y?=
 =?utf-8?B?YkM2aEV0cEJzVXJ6MmMrTkk1eGxUbHNsVFhFa0ZubGVHazBDZUhqVWppSDdG?=
 =?utf-8?B?Z3o0bk5YWnhTeTIvRGJjdlRLbzBIckNvR3l1bHoyZGhsdnU3Ky9vYzdDclZi?=
 =?utf-8?B?eVNGMGU1TE54L2V5cFNMWkNlM1NTb2ROQ25yNGRHY3BTTitKQVg4UlN3VmU4?=
 =?utf-8?B?dzVWQWRhRDl4c3Byc1orRm9QcUdPZ2U0ZVFBRFBoaU1uOXNOcGhRQ0QyWUNP?=
 =?utf-8?B?VVhtMmxwSVd2NytuVzZreTY5Q3hiVUM1M0xZOUZQWm8wNGZTNS9xTUJLUEQr?=
 =?utf-8?B?SmZuTk1DSjZhVjhVemRBTFdJNmNQcm9MZEt6V2VET3VJOXdCdnlWRWtUN3pC?=
 =?utf-8?B?ZXdXTFdZNGpwRVd4Y0hmYTk3Tmgzc1I3d2t3UTEvN0VqSkl2STQwd2dUWHNR?=
 =?utf-8?B?enVtVzA3aXZGdlJYRERFUTArRXMrc3pIL21QVkNOa2RxVFQxUlBkdTJoTXU4?=
 =?utf-8?B?STh6ODlueDBiV0hhT3NVNXpUU2FQK3V1V240cHVkT2I0aW82a1pNTFZTT2JU?=
 =?utf-8?B?azY2M1dxVStkTEJ1L2ZxRGE0RnJyRHJPSC9kUTYxTGtlTEhqY1FEaXV2SnFw?=
 =?utf-8?B?T3ZmQVNjdmNSbVRxN3NnUkJvYVJGclI4MFpJL1RxR1ZDVVh6VWtsRXRaYmgz?=
 =?utf-8?B?ai9QSEZXMFZ1cWg4SkVQb05ybi9QZnBpZjZsbk0zSG1iVkltVTRiM2gwOTFU?=
 =?utf-8?B?cnlsZ2lETURxejh6cXUxNjQyYVN5R2Z3Lzd5N2xCanlxK1RXVExSZlluL3lp?=
 =?utf-8?B?M3VLSExpZ2pPZUhJTGN6WTNlelBSU1hyTDB2akxaL29uYUx0SVJ6YVZUSEpM?=
 =?utf-8?B?M0NZdmFURGhPWjJaQzVPdEZuYmtVcVZCZmNQUGdqeCtXeEdyak5sN1oycnR3?=
 =?utf-8?B?RC9zMWRwR1BaUGFFV1oyWFExNEd3WHhYSEZKK0FTL0tzTllHWnJia2ZTRFVa?=
 =?utf-8?B?R1JySkI4dFBVbGs2T2FobnhaMHZkMlI0SU9SaFBualJycnh1QUk0Mlhockp1?=
 =?utf-8?B?TmpzSHpWUU52R1BvU05obFZna0pxQjg3b0ErNnRLZGRWQXFPdGF1NC9qbVR1?=
 =?utf-8?B?U2VFdHVOZHBuQVZGNnV1N2hPWjhSaVNaWUl2U3ZaYmtXMHkzcnRacjJiQ2ox?=
 =?utf-8?B?YkN1Y1RCRW0wY0ZFMGh2d1hLaHVqeVE0ZmdDeXZYOXlzc1B6eHJ1bnFGQVhI?=
 =?utf-8?B?bm9tWm5WbzNDay9NTGVBakUxM05qU0hqTTF2WkswRFJwMDNmTHBRaWNPNHVq?=
 =?utf-8?B?dXB5V0daUjJxb2luZWxKSDBDMnlIdExaMGxnZ0pONXlVZGtDTVBtMC9sRG12?=
 =?utf-8?B?T2FqK3NJYTdpc3hpSG1aSmIxd0RYNGJyc2lvZlYyLzBhYzlvZytOM3lwZUxM?=
 =?utf-8?B?dkdoNHRRejZTN05PY0pyVmRWYlJsNDFTK3NNYXJIWXE2VVJ0RnNJR053PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hJeVZVS2ZXNGVuTXdOTFNRZXFzTndyRkp2bVBWcnVLdy9JOVVzVXdNQzhi?=
 =?utf-8?B?d0cxVWdUc2dnM0RXV0dQYkh0SjVWbnBGSDM3R2pzMlNRQm9IYzViOHk3KzFx?=
 =?utf-8?B?SFZBSW1UMEFmM3kwdkEyWEhhSFJVMzZCN3R2NzQ1UDBCdEcyRlYzNGxwWnE1?=
 =?utf-8?B?bDZiOGJrTHVsMFhGUzJhSkRXUFVNeC9INEtFZUtIUmN1UlJHaWRnSnFJdjM3?=
 =?utf-8?B?ZzlhQ1IyOGlvME52WWxDTWhzMTlTdWlYa0NYbWpaQnlaMTgzczJMUXRCcmlj?=
 =?utf-8?B?NkVHODhTODRkNk95ZzVqUnMwYzhsTzhDMVRwdlZzdm8rQnVQS3k3MkwvVVJB?=
 =?utf-8?B?MmFPRExxNjhIMk1VNkQyTGoySHV1MDlXTW1SWkMzRXF1T012Y0lwWGZBZStn?=
 =?utf-8?B?S295RkJKM0RCVzM0MUdSNEF1bms5R3dPeGFXY3c1azdNMzM0NTNWQ1k2Rndt?=
 =?utf-8?B?Qi9RWTN6QWxnaldacEw5eHZwN0lWTkF2R2IrUFFiWVlwT3NuTXg3MEUwbS9T?=
 =?utf-8?B?OURLdzFacm5idExwZzVaaXZ0MXdiRFB2anZVYllHeVlMcGRmc2hhemJYUGFK?=
 =?utf-8?B?b2pWQ3ZmaGlON0JjMllhOGkzTHY3WW1GUDNVbGFxZU9NbGxnc3hPS2lhL2dz?=
 =?utf-8?B?d1htTGZaSFBzZWlTV0F2d2VBUkt5RS9Oa0pYWHhSQk16SWRrZHQvVlFQN2ZE?=
 =?utf-8?B?Q3FPTzNvOU1rNmVYR214dmRoa0E1ZEJHUnVhM2lvaDFtZnVUSDdxUDVIa2xT?=
 =?utf-8?B?K2FhMFpoRTh5cVVnWVpUdktIWFlZQkM1eFJJb2RxRDFhS0dEOFZyOG0zV1A2?=
 =?utf-8?B?UEIvR3RqTXkzdFFIK1pEekRDVEd0MmhHeWpRNmZMQzVkL3ZHS01kQ0I2WjAz?=
 =?utf-8?B?aDE3aW1pRTV6c0RCMzdBSmppOC9tbGRNNUxpL1hmQ3JucFkzZGpiZzNuc3R5?=
 =?utf-8?B?UmVVWGM1WSszQ1Jtb2xmR1dreCtLYzZIQjUvU1dDQ2VNLzM2VDl0aUNZTm92?=
 =?utf-8?B?Ly9WSEE2Sk9SWU1NU1VabncrUkd0cHdBUURoTzJmc1A3bnh0bWhmWDl2cWt6?=
 =?utf-8?B?bCt5WmVwRDFoV0hoOXZOY0JQcGVNajJ2Si9ZRjBLSTU5YmdZTy9iNFpqTWNa?=
 =?utf-8?B?OUM2dDF6a2ZST0F3L2xOZStKN1FmRHFkQkk4QVJtb0F6NTdyaFlNS2tBRUFZ?=
 =?utf-8?B?OG93MWZXdGhOTHY0VHhTL1IwSU42YXRIbEErT3E5TkIrbS9hMTdDVnNIbUxJ?=
 =?utf-8?B?MjBQaHljQkl5SEgxMlVPaDFkdC84VG5mQVVMdVB5eWlhaGFNK2tESzFpQnRL?=
 =?utf-8?B?YjVONTBOWC9WU1d3RmJzRkhqelZFcC9xUWF5amVuRllUY2lycXRsYmtwNWxM?=
 =?utf-8?B?NFlUOUs3Rit2RDFFT0JoaUIwSEhGcHEyVFJVWVV4c01xVm0rbEtTM0lUVWc0?=
 =?utf-8?B?WTRNMU9uTzJZVFhYSWVhQWgrci96NFhKTk1YN3habFloN3dTc3V4NEZBZUFP?=
 =?utf-8?B?OUZxcDRnekxZSDhLM0I1T3NHQ0UzTTFERHllaFFqaGw5OVFkRDFoZ2tZMVVM?=
 =?utf-8?B?THlZNk5yMXVqNVBudTVzUHArZ3I1ZWY4WXoxTzE0RzNVZW9NQWJQZ1dpSGdu?=
 =?utf-8?B?bGVqZTFUbnJLYUtBenZxSnFON3FoNGx0eWR5RHJ1YWxEbER3c3NBc0xSODVN?=
 =?utf-8?B?RVIwSlUyYXc4bjlLY21aM0lZbFBwdVZUOWtoRDRURUhzUE5CTk0yOE41TE1n?=
 =?utf-8?B?VDA5QlFFMDNWdTl1eWJ4QzBoWml3VU02RDNySmRNaFkwMnBrNjVzY2hRWjkz?=
 =?utf-8?B?dDJxYXlNdkcrN1RDYXBMaE1ldCtRNkhLVk1TTWIxNnVGL0wxdmRTTVo2YUNX?=
 =?utf-8?B?Z3poNmVoKzRXYTJ6QlpJOFFFNGlqZnplS0F5YW53WWprNVBha01JYUZkc2Mw?=
 =?utf-8?B?RVRKU3FWMzhtdktiNThMWFM2ZHNBQkpoNFc2TFdQNkIxYks3TjBWN2pvVEVz?=
 =?utf-8?B?RzRFZmxhbGlTSUtpdGh2WHRSVUNEVjRDREdsSTF4L0lzNEZVVzgyR1hhdlJz?=
 =?utf-8?B?VVBaUGl4b1p3MG5qbkY0WGdPdlpGMFg5RUVhVHFYRUN3SGs4VkFGbTFFRXZm?=
 =?utf-8?B?Wmt4dElNd3FqVkVZMkI2K0RJOTlzZEVRUXhiUDZZaVA5YkV4ajJ4ZTZ3MVd0?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f51a08f-e5dd-4615-d56b-08dce6f877b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:50:01.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ssHOXhdmApyjQKRaG4ySTFfH8ZP6rnIZFhW7AVbBLdjek8XK0MHOi8olpYBPguqsOeddY9zXDq8mL1SEi0jhbT0pYR0U7Cc9PHu2LgeXKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7263



On 10/7/24 9:36 AM, Daniel Mentz wrote:
> On Fri, Oct 4, 2024 at 6:53 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>>>>> On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
>>>>> number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
>>>>> tables. I'm thinking it would make sense to limit the size of linear
>>>>> stream tables for the same reasons.
>>>> Yes, this also works. But I don't know what value should be used. Jason
>>>> actually suggested (size > SIZE_512M) in v2 review, but I thought the
>>>> value is a magic number. Why 512M? Just because it is too large for
>>>> allocation. So I picked up SIZE_MAX, just because it is the largest size
>>>> supported by size_t type.
>>> I think it should be capped to STRTAB_MAX_L1_ENTRIES
>> I'm not expert on SMMU. Does the linear stream table have the same cap
>> as 2-level stream table? Is this defined by the hardware spec? If it is
>> not, why should we pick this value?
> No. I don't think it's defined by the architecture specification. I
> don't have a strong opinion on the particular value for the size limit
> of linear Stream tables. However, I do believe that we should pick a
> size limit. Today, the driver limits the number of Level-1 Stream
> Table Descriptors in a 2-level Stream table. For consistency, we
> should limit the size of linear Stream tables, too.

We are on the same page regarding having the size limit. Took a look at 
the definition of STRTAB_MAX_L1_ENTRIES, I saw this comment:

/*
  * Stream table.
  *
  * Linear: Enough to cover 1 << IDR1.SIDSIZE entries
  * 2lvl: 128k L1 entries,
  *       256 lazy entries per table (each table covers a PCI bus)
  */

I'm not sure whether the comment for linear is still true or not with 
large IDR1.SIDSIZE. But using STRTAB_MAX_L1_ENTRIES for linear does have 
conflict with the comment. I will pick U32_MAX for now since it is the 
largest size on 32-bit and good enough to prevent from overflow.


