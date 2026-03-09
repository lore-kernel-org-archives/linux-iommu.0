Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54D38BF87
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063736; cv=fail; b=l1xPaxBjePxpgZWIVE1cuyNysx5310QrxuTBqX/ovxgEtPj2iPNmVazt5orUIBGWutW1VxNJRJARwz1zEWq4+ttoBc14Kwr0e/rXXP/ftXAzMUl07sk+B66p48N6uwcIxEKQ/zrM9Nnctqu2x/01KmGMtD/c80TzqYvPoyAF4mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063736; c=relaxed/simple;
	bh=vxeIA8/pcsTPXdnTiShr9J2HcJf3B886snUhC9zmR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BF5sbhWI6+mKUwcsMixxg/bsur6/7ZCPVPo5U1h7bCNwpq7B3U5rt3Nirv6XLnXvY+S0eVOEU+klWCG3SSP4kMVHdxKbKywVdUl8O/E6XzdtLY+KI9zzCbT2vxb40UZ9uPDHVKkZgHCo5q5g0Ida3inA5mh6IC733BA91Qrq5LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KFNkqrKX; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KFNkqrKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS1wlKgGMHokVOY/pncCGUs//7iwSLHEqtw15fnN/ttFqxynpmt5RlV6CF13JFeNbksWmVr6KHV9rsc/9WOzQ82T4zVoD7qXRwjuOUYrqC6fMBjgy2R3djtiaxkPgYo0yBzphmhjGuz1EIjr6UaGIiAR+Hcjy3FCGsBpBBuJWSEJIVKCOMCWTHB+/kTlf+kSXA9yiaX0JoJLtNJfSQR66bDjDmY0HLivTL3jVxS4c5c/LODzgU90ep201xvzZflXcsig5ebwq7zDyRdwq51j07xgJsNHXVazUZZ+9pIjk0Zp10dpiZLbaoRTosuJyBzZPfTlnvbWNESTr+uhU66OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voOHBrXkgglwtfNzUlkWQ0CQsMPCGBdGFwOwDlAJTEU=;
 b=uxWWlVY+cMYJsxSTNMJzcfrX0nKLrAqgj+w3s0DQR1QKxbFpTBPdCL9HARp+30d99cR04jUc9Q1GrC/5xeWC+td2tManR+H6ebtDJlFdpUnadcmw5AwOXOAu9zxP+0vCNV9iZ+P/6gHGNRh+RnF2st2hF91oQXvU4N8FLxJaLsadmUUvh4XiYuslyFsrHgxwhyKfukjlpSNO0uFgHuPNOwAfDPW4FF9ft4FHh9L0hr2igevfb2trYX09ndj8ssA/4AQD1LdMW42C2a/DC97LQEWMuzqRYDxEMSK63WBkIrwMq/ecB99P3wfnxTl1hTuVxp/I8JUcke7qLS+yqpHYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voOHBrXkgglwtfNzUlkWQ0CQsMPCGBdGFwOwDlAJTEU=;
 b=KFNkqrKXiaLqGuzDiMKIRsoTPIzW0suNA3DYi1WKByE2x+Fc9vcZOp/pZqDHO6HT1bAO/cTblC8gCPl87fiPmqyW2T7UbLrg+EKLOp3+YvRkPee6tfK1hUM9nCULDMhuFsAmKL2cOvEF95+Jnt6kq2fTt1EFpGvH/a1NAWDh5riL2HbZT/xS2zEfLJooHNwyplwg0EGgmEyHsbpCfBITvZBPeYL2oXVfN1Osy8JuyKQ8omIfgRtCYjWHVUoseD9zU5qffEs7u5JLsSBoALRO2701NNcDAr1+JnKSxpnZ4jJjzMTne72LNGT7+32WySMuqZmzzkvSyqyVxqGRIObVZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 13:42:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 13:42:09 +0000
Date: Mon, 9 Mar 2026 10:42:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iommu/vt-d: Require CMPXCHG16B for PASID support
Message-ID: <20260309134208.GF3717316@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309060648.276762-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: a539e3fe-0d95-470a-e264-08de7de1a931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	7BEboArZ4WLKEyWoy/6YuAK4th3mefVI/hhLdw214aioI/hVxz1+cpNzxkbkLdW0YJmFqMznPfWwC8sTldbjm1em21kTBDi8bRD5FPjZiF872pnJUziUNUk9JMrhOT6Pf5ytojzjHq0UycSlCl0TpOKwyoFgNCvOP76WopLJHg5JI1AKyr48B3s6GzbVlX+hgNw4V4GLzzmuUDk06PZk5FE97VXCfwsGu8he3OpM96ScQC8CSX+uFcpOHyJLtUVaFfHrVFxmeZZbHIH4KbWu7kyOib5Jt/CpK8Q1MKXnlAmPH8LQxLxMmNP9NiyXQHnsgg0ZaKTHDXBhH7SfIidCFClWp5kISv7gtyUsHVw6cLCjRpph/+yKi3elmTVuZ3ZTs8B+dv9b5hzXFtb3pfzuPnAQqFhST3xm9WGICqY86tvq9/kFfN/K3wJtYdrwqL0gUrQKSaJ9/PHJ3gqfBMOUVho58P2qLal61G/qKTJqTJBc3jFlw+oLG5ePAX3gCcLvpgHaCjtxD8V9PYB6yXVi0Qur9HmXAH6PO6IgTHeT7n/TmOdXMfNOjiKJAuWEkU/G40zRxem4g+OWPrNlu6kJbYgK/AqUFHTwnaacNl5LNXK754xj2Oe2hAe5/IshFFKRyt3UWNzXLtNeFcG+zGifI5Ryg1o6WPnuoqUqdwrIeMI9dzs0+bEdCtz9vYwWs9ogJl7KdGpJOuIYDcccCEYkwTC/z0Q4+G0UUtl1EaksEGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6U6mRNzNNfrv5Ss3183VGUVSK2AdQ9wbbjh8skPACKNAzSETBfMTlAMfBiDD?=
 =?us-ascii?Q?Z0d40W+rx8nBXdv1d5KQACWuyG691SvTIt0D5wIm5AI3T33uKJdOqGlk+NwI?=
 =?us-ascii?Q?5FWVeh4L2EXzMwcZBFUc7kECU0sRpKLAu+85eDWJ7/kK7JoxlL96rW8eP6Nt?=
 =?us-ascii?Q?Xz39zmTqw+RpizLKXhysLmI/LFdoQmEYNomNoyZpFs0nhTBjXdR/4L7VdtyT?=
 =?us-ascii?Q?lUpILAcr2sAm3qrMKmkjAuJYuvAAacdxy7d7u7lt4GaXbGAjReFPDCc6OCyE?=
 =?us-ascii?Q?jF+YrQ+vDsz650PuK3k9kuzyY4nqp7C8xor9EjPphlwqaAm8J5o+1SJJenIP?=
 =?us-ascii?Q?8JuLqXQN4Afy5hWxjfYe5hfpAGrjuFcXfNnP7pEgn9qeVhzjh2pDk/YizN36?=
 =?us-ascii?Q?lVLcgmMCO7K1OS7RklLDvSC1noMkpr31c9tGXePImyJw6KXJKWPUk+z+epnp?=
 =?us-ascii?Q?hxdCNQSUNjhB7C4hbqcGg6aNE+SbMhjRADndqG2lGiQMJ0L2thPG8TNs46nm?=
 =?us-ascii?Q?e2d6ysFhmLtu8MFISI0LuTXFndppwsXiCYOvwx/UUt1f31KT6dOyKSqdslFQ?=
 =?us-ascii?Q?7xuNQcebm98wByneA9YGDG+HyXz6FOh8iELL0pxCF/ry5k4DfGU2ywV980yF?=
 =?us-ascii?Q?7vF3yieXkucwJ3C0/8QsmLpcLQo68+v42hVNp/hOTTY20Y/PtbGPWc9NHcHO?=
 =?us-ascii?Q?71h8n7Jx0v3K65cZOU6MVbsMVYeb50auoMvQ8xEXWRMyyr7zNIhTjvSu6TN/?=
 =?us-ascii?Q?gy2SGgmmXtSk8eMhF8yFyo01qShQUFDOkjqYOQ9aVs5XbLW50fSVCZ3MqfO3?=
 =?us-ascii?Q?H9KReN9EeczeHp7uHNZpxhSbghaO99u+X5taqGJORnVgHVaQg8l0Cwy8Ve6f?=
 =?us-ascii?Q?o/gx8T3SXgmKoRCWufZVdC/g57oe7wgwNjGDK/iC021RePaXvQPlZzTrWEGt?=
 =?us-ascii?Q?A2x9Oas11KYtFOZ2kCDyjrVifsIUYEbSyBYboAt2sFVkf/yC1NFeKEDNWFTW?=
 =?us-ascii?Q?HP+e7mTcI/msK561rsYiRYzOr52b6gTstaUBEdwRO/up7KUv+Qd1jGBHyI/d?=
 =?us-ascii?Q?scLcw+rhzGnAR1iagZ49UPu0vTVTtYVLgzYg+wZBonQ5JZSDKubX/l0bZSf/?=
 =?us-ascii?Q?SaY+D8NvQUDojMLiXoEKtkc1EBigykj4JImJBNhVt7d9RUOeBhMPwHlhxlFU?=
 =?us-ascii?Q?rgT621hAXQwVZJ5kmCng9HGX/Njj7HT5ps27SADwcAq17h+Dc8R4oMDkgAGe?=
 =?us-ascii?Q?bIhR5aLJVKCPAgeTwJ7kNlGrVOuPWL5qJH2BKYJjc/m6hee/V0dir4QEP/bq?=
 =?us-ascii?Q?wVNo2O977vxcQzQFxXnz7RogMQfIZ1grFgRjABe474I3+kPnh1+zvdrSvDUo?=
 =?us-ascii?Q?HRaH+uAl7kJLNIZ3YPkWh4JBwfAs9XvdfwlVbPfbLoWmW2gakgvwN8ppstY3?=
 =?us-ascii?Q?axptW1kZnMIGViD5u7bGTmqDsGzfHDMugWSfdVIBCMH5ysFdV4O26CBuTumA?=
 =?us-ascii?Q?LItJtayvz//IlBrsXC5dAigmt6pxOwxPkmpWJ/a9oEKKoOxtIocSeohzjvyY?=
 =?us-ascii?Q?7tA+iz4IOqIE3zf3Il7EIBk03Wp2xA2xXQDu/uRV8MREAPu3K3C5K7k0euns?=
 =?us-ascii?Q?Szmhg4lqZfiMs28Sy0aB5FkTuPUhgKE1PiZ9YLA7MWvgR6R3MIDrKfFw44t9?=
 =?us-ascii?Q?T/Tr1oolESkUB/Duye2JwJ8lLGSCE6C8QD7cIzr/WlD3NVYlCPBZ5kvIaLuu?=
 =?us-ascii?Q?8Fi0xgKoJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a539e3fe-0d95-470a-e264-08de7de1a931
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:42:09.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivZidN2EEZKYnks0jK8V8DfTVbXz2+QcYnpUueXXdjSKpUzfOqQKm/1lXxcCfFNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

On Mon, Mar 09, 2026 at 02:06:43PM +0800, Lu Baolu wrote:
> The Intel IOMMU driver is moving toward using the generic entry_sync
> library for PASID table entry updates. This library requires 128-bit
> atomic write operations (cmpxchg128) to update 512-bit PASID entries in
> atomic quanta, ensuring the hardware never observes a torn entry.
> 
> On x86_64, 128-bit atomicity is provided by the CMPXCHG16B instruction.
> Update the driver to:
> 
> 1. Limit INTEL_IOMMU to X86_64, as 128-bit atomic operations are not
>    available on 32-bit x86.
> 2. Gate pasid_supported() on the presence of X86_FEATURE_CX16.
> 3. Provide a boot-time warning if a PASID-capable IOMMU is detected on
>    a CPU lacking the required instruction.

This is fine, but it also occured to me that we could change the
writer somewhat to just detect what the update granual is and fall
back to 64 bit in this case. So everything still works, it just does
non-present alot more often.

Jason
