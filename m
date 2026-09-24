Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C24CE689;
	Thu, 24 Sep 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278940; cv=fail; b=YVE7Qp7KAhPjaWWo87DiwWi9mBjskuaXM9q6qntQVTXZ0CJkJHHvmucEEONiM9CplMftBOqtmlZM1Qh+T2R4P9XvK94bXRLFf75jKmy14evQT4QOZEf5mfAsKDC2wjOmV0JnWpoWkRJYgSsj/dGWJptwCU6SGj33ntVAJCoxJ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278940; c=relaxed/simple;
	bh=fNLpLZBqR2D4RKpd2T1P6anQX2oJriu0r6Nv+uLOrbs=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=ffWy1RSq7SjNVAGjzEqGyYFGV+32myqnibKPfjFa/NN5decu7X4dRjjjZXVlNq4W0s2KyMz26jU1aJshfU/nrD2caSDW1GdQ3JDS5DkJO3l9K8ggWf28I8relaRN2H1tdzaiWpeBL+kaJJUsTmRR9odbLrVKZUo61JenOF4cfwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AR+HNjwO; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AR+HNjwO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIJfNpIY0N+iLS2YEAHUPNv3En6EyMMfvwUU4CGjdoYyTKtqp/jXvVRy9RMAiHR+L0kqBlZYmdeQqvAb7vMEqb2YfhHUA8Iva5w3cjsmzzaZcpgX1bxGpZSg/pA6NnFSZ5YSBcj/UFNVBM6Cu42BsC6wQWf23QnD2zarL5hC6Plo5Qld8PplQ/8dBgKniaaBANQIjfGnfApUMSqzRY9jFuvObXwQLbA9h8Yi2HoheDneRwPyimW5JNtMSyCUgyRNLtZzItpp+IyiRfAp2atXGpW797x+kMGMS48ntxzSgrBFxGw6s5tOWk6bDo4TBOf1wRyHuNawLyYQGsaCFr38uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj/a42ZVTwANsvDbirvLp0Q3SekwlGPbt56hCqfoP7g=;
 b=BxL2JRtcjRkQd65AjoVEpf+tuKY+SvxXuHlCNm9xx5eLwKPwTK0PG/hFU8Z+F+Tqz6Wvrau/CjSAFytdt3TUm0IfLfDsWXyUqWGp5nLCO4xiw6mkV3zCfUN10Nse/zeVUGxDWyKj5GCiRDDFKEP+qr1fUU8QtBVzyh22jjGJHUgPKP1uWr9NeYfzBxorZl5BRJckiozcb/VeYWDwrAkKKxxQ9jYlw6f6XBiOT9fJ6P1ZPJTJ3CoW7OURPEJ2QpBiHw+oawGUlkZMC/EImWNVy1NJJpdLu0LonWTJzU2vjJHk85nTE09V0D6XWAsbTpWKHdDW4gGlWmN96QMtoea9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj/a42ZVTwANsvDbirvLp0Q3SekwlGPbt56hCqfoP7g=;
 b=AR+HNjwORMwpKT4MVzm4L4PKIiPcILm15ieHUNg1oocFZfa1Bmud/qK4rhZ6IeGcgppBOj4viyrI/ebC8qz/UJXp+EC+/VY0u2wGn2hx4UY9yGaHuyFaVFg9c+eOq5RV6VzoGXKJePfTkvWt+GzEIB9h1+bithXxsq0j/+sHnVXb0TKEzqms6a0MIuLIZd6ru1ROGC6uGEjGpPF76BW5EEAvcntU+UQXuaqJLhi2mrMISPzi5DRCQ6HJukjx1RiIr8EfQkDH5kJWvEPEzbChZreDqYNOgggmoyl2F+ZRNaF7UlA2Q67bcolSKn25rCon6E2HAcUEQ/3wiB2eoIrHxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:42:01 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:42:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 01/11] vfio: cache KVM VM file references
 instead of raw struct kvm pointers
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, 
 Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Anthony Krowiak <akrowiak@linxux.ibm.com>
In-Reply-To: <20260917140159.1163281-2-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-2-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891416.104879.7094081421035070060.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: fc05b2c5-879e-4b62-b618-08df1a73e589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	urXZaUmFZ3N4xPuBVNSi2If5ll8/ueW6m2GSryUyjsuPV66cESDh8cAfnUQWLwL7EBchZ6HcGufYl4xI6HZTJ7lLOiEAnjrHNzKu/xt8ctwhEG3b4NHICTNoxtgUKLdizRQFnw4v91NFZuJk4nqiB/m8G5EkDPr+lnbZJP5sS7tDSIEe1E8E6OEXA9+BiRMRN+Hu3LQffNRfFeDtXEhfaSJlH2TNpzTg27TuB/9xlH0mNEDiO7VG4Qt3N3WCGrDmB0wiPMDUAv6TKwdgDsJp4BK/6KOMWnzp3HRo34o0F6MxYEYbvkc+wZwMr2PPZDlNpvTL7BILTB3rPdcWgqzssWF45YgJ9pvrD9iQ2yRJiDMad8s71DiCTMGq6KAIWv0Wjwb7cAupQp9SRuZt9vs3LSpX50AYhXuIPcxQvbuOoNfe/6mE0yP7JPRkREeTyny+nPXZlm/lOdItTAPfYw8HogwelNMWqrM1KGftjhWpPXR80WO7vWUacX7QR0xyrHhn5lmFmOi889e1wtFW+D+vV+MTpbjieEkpWosgvy1wpUyIRL2yaTAWNQf3d8QoKIdGZVGL20wBFjueQlMqrvfrP2rvi8kfxDr+vqdroJkg1dFyT69WR1Z/4Q79SIBEdnkA/yvt+nFus3AWVn3NIJuadVv2AgcM3nKaAQRT9UO+UQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRoQmlrWDRhNkIrL21JNUVrU1I3eDdvVU8ydTNmQ2M0UDhJY1R3Z2h1ZkNQ?=
 =?utf-8?B?TkxuOHRham1ZekoxVFlKYW8vUkRwWFowbVh2ZWY4bytRRUF3ZG42Tm50ZkV1?=
 =?utf-8?B?aVlJeHVIR0JGZHpQWTlzWVN6NWp1ZFVVT0xickxQUGFKeU0vSm9DcVUxbzY5?=
 =?utf-8?B?azFXakZ1clRSZTdYcUdCc2ZLdTRvaFlEa3hmRkcvd1BHVzFaaG9UY1hka3Vt?=
 =?utf-8?B?ZEZ4cmlIdG0yV2xQSjNQRnRjRnRTbnpBeFlORzhhMlJ3dXFDQ1ZDY1kweGYr?=
 =?utf-8?B?cUFlNWZlUDFUOXRMV2p3YWF0eElUcks1MndMb1c3Vm1OZFlQQXZhZGFYUDB2?=
 =?utf-8?B?OVVmblhmSnFRNE5OOXAxT2RvclRHSDc3ZXpqQ1VUU2twdklDcGxkNzB2WG50?=
 =?utf-8?B?V3FkcEhXQWNXZHlpUjZNVVF2S1V6a1hJUjZmZ3Q5WjAwOGhGdzRNcFBrYVIx?=
 =?utf-8?B?bDBtcCs0bDJtS0VndXRpakY3VXVIK1hIN1RzQW8wcFFlSHpncVQ4dnltRnds?=
 =?utf-8?B?VTFiaHlTVmhwTzJXWTVJeW13UFRKR2lBZ0lkNGFheHNweGFTNXE4SW1nTGR3?=
 =?utf-8?B?K1dmdDVkK0xHTmtDS2lVVFVBR2R1eHJMaGlwYUNUV2tXSUFNUkppeHlibFE1?=
 =?utf-8?B?T0NkejlDV29rOUpuMFZiWlR0QU90YUNjZnc2V0FEZWlYc2E3ZCt6eUdyYkJw?=
 =?utf-8?B?NUg4OWFLSXk2c3JaU2ovdHhUQXhoWWJrTDV2R1BpdlFWdWJidG9yUDV0bXJo?=
 =?utf-8?B?eXNDVlRyUFdUZlFJeVV1ZUZnR1lldXNFQWlPZTNsaU9jK3JtQTFmTmQrMGNH?=
 =?utf-8?B?K05QQTJwWG5kamw2NlVlMkt0ZjRZcldpWElUQzJmM05YbGRuQzR1T0ViTy9K?=
 =?utf-8?B?UUNlZDgxZU15QW9KSlRxTmFndDRhTlZYZkZLbEJ0ZzZ4RVc0U0IzbEswSnNV?=
 =?utf-8?B?a0JmWnd1emFyRENsbVRKWit6NHNSUkZQY1UrdklHVDMwN09VTUpTVjlWVzVi?=
 =?utf-8?B?MEZaY29sc1J0czNqZFRtYkhYL0phZEVlQXc3aFhRdjIxbHV6djBmeW5HcW1B?=
 =?utf-8?B?bWFiZ0NsRFpSY09DclFlRFpWc1dNTHpKL2FUU0dHTWNjZCs2eHd0QVRkbTdU?=
 =?utf-8?B?UmtIdVhZVDZrVDZVR0hjbDhwbjk4SkhGTDA5VmNCeTRRV2o0OW1rQXR2NzZa?=
 =?utf-8?B?M043MkJqMUxZZUhqSlFRTjQzOU9sV0huVENrcXhhQUw2SkMzVm8yL1hXbjZJ?=
 =?utf-8?B?RXFrUy92ZEwrVkFMRi9QYlk1ejREOEFuV1RySk5BTFpEMzZXdlRNbmhqOGdK?=
 =?utf-8?B?aTQ3dTBiQTF1T2F0T1lHV2ViSHAxRHJpUHBucjdXZEZLSlFmd3FjY0huYmVW?=
 =?utf-8?B?eWlYRkFRdnFuSVFrMGZWaUpkTi9xNDZqQjhWM3phSkRWa0ZHOVI1NDR6QTJV?=
 =?utf-8?B?UFgyMVNxS1F3UERJVVRicElOSEYzWHYrVjY1VE93Sjg2SEY1Q3p2RmUvYzNo?=
 =?utf-8?B?bkJBb2M0czNzS0lic0xRUDB1Ri94dk1acit1MVlON1hFUVV3bUQwTW51UTJG?=
 =?utf-8?B?Y1hnQ3FUem5Cd0dqd3QxbEZUSnhraVk4aEFZQnBnWkxXeEs0UGt5ekJpeDFi?=
 =?utf-8?B?SnNqbXljZFlrdi9sR3QzTnFtUHpWUFhhcWxlOVpnYUZ5V0IzLzJEWGR3S3ZQ?=
 =?utf-8?B?WDJGUVZYdFgzRzBiSy91azRBa2xudW1sdTYrN2kzWXJhNzlac0NUMXVLZ1ZZ?=
 =?utf-8?B?NVNIQlQwYmhtT3VKaW5VNVgyNlBWRC8wUndaOHROT3pRazRKMWtHazFscWJF?=
 =?utf-8?B?QUR4N0tCbnJ5WXZQTXFseTRlVHk4MjcyN3RNS3A3cnVneFBLMHVPcWV4eTQ2?=
 =?utf-8?B?UXNFYStKS21uaEY5dkgyaGN2ZUNVNXhsWnVKSVZLMWF5clhDVFFyeDFCY0xv?=
 =?utf-8?B?MkFwRzR1TTlxdDdlZ2JkVzMrUnhlWUdmRzdESlppT3BXNWw0OTB1Y0NwdWI0?=
 =?utf-8?B?ZXdkMVoxekRkNG5NNk1ybENIM3lPQy8wRkVic2FwL2xYR3ZWME44aldwMUMy?=
 =?utf-8?B?Z3lFTVlDak85S2M0RVVFNGRZa1BGcW1PcytDdURmOTFwLzZkR1QwRERXcC9T?=
 =?utf-8?B?b2F6ZEdaRVd0My80UEFac1FkNml6U29CMTk0eG5VaWtLeWxUT1NFVVlqaVpR?=
 =?utf-8?B?VUZiKzZWUTA2ZGlDY2FDaUZtczNkTUMvS1NSZ1NORDZGSldCV1JlR2hUcHUv?=
 =?utf-8?B?akthamlOV2wyNzhHQjFacW5YY0dFYW5iRUtKc0VQVGNYY1RrbUFZekpsNU43?=
 =?utf-8?Q?XsFPNTojz7voHHPFbV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc05b2c5-879e-4b62-b618-08df1a73e589
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:58.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM2e4sEGCOKUZy+zVP0IUcnW4WYJY2Z50fk99T6jJaeY+QYBQUhMaAUsLUMzNuMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

> VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
> and the opened vfio_device. Switch VFIO to track the VM's struct file
> instead, so VFIO and iommufd can use normal file references for VM lifetime
> instead of depending on KVM's internal struct kvm refcounting.

Are these few patches the same as:
 https://lore.kernel.org/all/20260924-vfio-v3-0-4a294307797b@linux.ibm.com/

Can we align on that series or is there something else here?

-- 
Jason
