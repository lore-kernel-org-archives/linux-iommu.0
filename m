Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFD4B487D;
	Thu, 24 Sep 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276986; cv=fail; b=DZTsWkuoPaxXumIVkp9cvjPoRdHXk6k59e62obOSONG29H9gBJGM/FH+U2KdGPbsx1tZ7IOFFJZCzYLjon7g4op4wB0rnTePbtxP+VVir0jWc5SQUQ6FbI4f5TJtDENh3aIxcALBNxzbKt1CzmGNZYB4waJ02sOA6CMquDxXkKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276986; c=relaxed/simple;
	bh=3HFX6ncPGs99InXQQ5GtyGDw7XVRGTWQr4l9/dm7TXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EkvLMkb9xoxjj2vNbTNQXr3xiNTIsTs9Qcp+h3NTxPukShC5AAKeYJQF8uuoNvQV4SlYFDkeFBuJulvez0dHzLF+aUvXg8M2NokmceGZM3+P3wBZWoF0yfXgEc2dmYa1KdGGoJ+1Tm211LJh3dZl6X0t6NKBzHRBSy1Rkxltn5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTEGFP16; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTEGFP16"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl++dq0o1lPLPq1Lq1zeux15eDVE6CwlpXxhk0gZoxIxcakokJiJeLBy8XbTqFMu/fVjJPm6gS4gO7AJ5VZ7g8elD11XgUnAZXC4fsHAFRlEqjo/x8JzaTqjmMQpRF2Nd6W7MftdigUv8waxYeTyI5A71KCqCncV6786v14UcGuHG4uNw//Os2rzfnpDr8VTeJaSfug4kG3+H1Nuo0mSS8iHdTlcKqKvQdE1A+R4u9HEo6z+6kCZu6Yomhuphs35cQONd9uaum4hxULX13AVimzg7WlvaxqulQnh1uvKxZVnEztjAvIViKYszkhkkUzY5eNBnY01C2YvK9FXpSYoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HFX6ncPGs99InXQQ5GtyGDw7XVRGTWQr4l9/dm7TXc=;
 b=ANwMbo0T69sazaVMhh0ck9htMqSbJn1+1aTJoQqwWjdfjFTFBDkCti4SIzO6UYzf69othD1Co6mJ9pEdASAVOXY2yccOG8q1J4ex7f5fuL4po3124w7JenzEVYF8sliQZcG1FtHKrWEcVkBLrKwDFiXby5REzlFS6lA+9VOnmAfrbbck3xQbP2A1uPtCjKB735rNGVn9BAx+BSF2LeNwsIS3BqsSh/OTIUC1ClutnX/oP0hGblIHt2eM+T7kVpaLk2Y/lMt6Ta+GbCCFXPU8/qR+wt0y4bRM1tl3MnMosSH5l5/g6bBEVjwxAtCsc0K2fZruxRlt5K8KJ8Wyi3WQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFX6ncPGs99InXQQ5GtyGDw7XVRGTWQr4l9/dm7TXc=;
 b=sTEGFP16KkVNFK7gn3KOYMocfE5MU4l3+1GDG+ZRGDrpZXFrpSPuY/sa8GYE7UV6ZaXbyIYRLbaDvsKoFhgxrgcLPk389NdRjYMCNvNNX7nLxAWQL7woRKzhnZApgnZgZ/QwOUCnWnJVgSvkktBkA/nUYJrPG7hMb/PBVaG2+13x3LzDy3PzyQufbbeUeoaHsTRCiX9Lh4i4Cwvi3cIgRB8z9gO7elnXfv6aSWZyxqvbnIlO8xIcSroZ3jXK6VL9PMimpzC8pXlYZ2XYfu1cql+zfOhIpTz3ropHGmhKFlY/0Xm1XVLVZjijBcdltzWiVmNbK0Ui2LPspol8BcTFIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB8221.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:09:37 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:09:37 +0000
Date: Thu, 24 Sep 2026 16:09:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Message-ID: <20260924190935.GA112301@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7541e083-a276-4a0f-c8b4-08df1a6f6065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ttBCe5kZt3G7X6OUVNyQLlbSxywnxybnSj+yrELpeLum69MX8Kp5JHTgmHxWzsPm/hLWdv7B15jkMBWDpLAMh8roHjLRYsMfQQXnQjWaHgbop8FseirwsZLLJh++JHbuTVJxWFzCOex3Nic3Q9bwxRWSmm3Ld3Ptsb1Ks0vYv5P32o5Elu7n7BHJoGlx7oUd+13+/nvbkQC0/2Iz0uv3PPEr2wyKXS7MwpZe6RZDRS58K3tk9ADNVg+EIk45JcSYMZyD3d17E8+gDZFIGKZJkzTXCA6MUeg0WDVfq2TwMjQsLhMa8FSPZg4NM6j2TwLB7X8afe1ZMBJWmaYa7VWxmVfdkqKbxNLwhJlFR+sLVC0uVbZ3IMvkwFNWeOg/i237UtJ3z94TO01Rd283LxSOtLNRp7vOGMEH7HGroVrbSBeYwoRM3bFAv3VFqWf3DQ8QZWYk7Xm7H69tkwrPYyrkybA7RziGgaulacq6iIEmjXWPIs5u8hGNYrXry7nbmc8zncr2qUgPcH+SDt3GwyLQoA6nRPpuXr492S7GTthzjp7kXyg7hCBsdZXN5///JKp+dRnTfIeXQdG5B5rxX4uu/llV0nIzkOnE4a1y9ZHBRdVbxiyJaMEcMhH5mIIlTmRETm3HKoy9VJSJh7uwExFpvNj/mRn9bSjrP0IUR9wVz1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aO0roMTSf3S0k/G9/zFJtf73qILcv/a9ySqhDrklIhFrYkWeK71JNHynsspc?=
 =?us-ascii?Q?6MLMQ/C4FQO0ibkDjj2m0vctPWGs7muJfH4tfFu7FvVGhqV5bHDTFDNBODMd?=
 =?us-ascii?Q?To10D75ZDjVmrMiy839H6+l9VsAcr0XLy20VFypZt9sSJUjy9VsHHnMh5HrK?=
 =?us-ascii?Q?WIgyXb7ZCgGE/rjQCgyDHDw5tc5eZn+eZghD0FmJlcoIOMHh3SAbQhX6R7kD?=
 =?us-ascii?Q?xxaQPe3cOMGgQhLWUTsBVx+6nvJNMe+0RlMq5QbEQFwdhdED4YN/b0tvPRYb?=
 =?us-ascii?Q?TZ3kEXDjYcyewaQz7+WqWUjDt0aVcQlrI0LBciT/HCFWf4741VDnoCFJ8vbx?=
 =?us-ascii?Q?6+GWMoxZoRYyg3E57facN0zw7usAvQhAvyzwKBxSOzfKhzptBXxdfNYx5uIC?=
 =?us-ascii?Q?WQTR25gCEcQhFAQMnbfgPUDRob1a0X7MsxdYGLfhOH5uDGpTwhE+dZ+tBV3y?=
 =?us-ascii?Q?tzQZ5pGfBuFrE7eUBylR/EyvQSytiCgsVGHLs+Tnp8sc4/VyiQx5ljsV6uw0?=
 =?us-ascii?Q?ted+MVMie2cR9xgO/HLjr/JltWTKnZa0Pasu3UCAeM3La2In1NKG2y52GffY?=
 =?us-ascii?Q?5y5+8VE2dYHk3tMQwgNy79BgqsCo/1bflWQGThMX+cEcwGfoU/gcmdIDMpZW?=
 =?us-ascii?Q?gtgkT+kSKRUwRzwhJcyJ71FtC4VESMM9qXp8YxYcr+ieao++4Lyjbhx6qK8F?=
 =?us-ascii?Q?eUOiUqGSRmnEr9XQfYQXWrVExwPmXcsNRK1c1PBSfNzv1VNeix0CEjvqEUa8?=
 =?us-ascii?Q?IcfQuKu+6kKfUTHdW86qJ77vS4U5UxjbgUPxQzqiDrqRGHnS+eWYmnO+t+S+?=
 =?us-ascii?Q?CEN8NNDYsCHaNNZBPz7u2OTv12n1cnRZ+fjIof+VmKvJE4Qy5xkelLn/N9UG?=
 =?us-ascii?Q?y+4Llk8vJl4I2stGHH/Gk+v3OLHUNvHqMGLCwwAJnzvVGiwPoI2/SOctWhC9?=
 =?us-ascii?Q?xWH6XNZ1IMScaR7KLeEod/GDo7Wuk+uqGPGP0VZsAclgxo+gdbz7AfiOWX7O?=
 =?us-ascii?Q?7pmKUZYSofMrEtJ12DVK9rMqHssxSoDbPxviBqGqSqJZfPNGX60BNmnDBfkI?=
 =?us-ascii?Q?rR42/OuoZ+qRUNhgozz48HJLRP4R2mCDPoLw/KX7MGyYlsTwDW6Sxrr3b3ky?=
 =?us-ascii?Q?EeL9T+2yXTkrYMX/iRbifOy0+Mg9ZE86i/gC85wMxPd7GIjo2LXTiWlWlEqg?=
 =?us-ascii?Q?16eJgDmVhyjPynwLTxkyJ8H0U+v+rtpY7aqiAAagt+kXULPnxOO/ep+xfB8J?=
 =?us-ascii?Q?iXV7B70uvqf/Sr6qyJtu6fwDGSTbNAOBD5Gp0R+wTPjQbEQ41O9eFlqo20pJ?=
 =?us-ascii?Q?u0REC808Xp+Y0DqrXfxxBlrwbp7q9JkKu/nqAO2/IzYO24G+XQ8vjDJlPnRJ?=
 =?us-ascii?Q?i/LOn8J7zrZBTkMYl1aWiUKKcB7odTAgvVsaGjBUWyqga1VSYj0QyYHZ5sOI?=
 =?us-ascii?Q?I9nUu9rFd40PfTfeBnD8TDzLHY+zxBLRpoFYJq4LGzgUJIzD1eBNY/g/VOkP?=
 =?us-ascii?Q?EV3mAgh60pEo5ZZFfVGvXMCy5RnyqERWJ5cw9nwpyuNBeae8fDpAm4v3kNvq?=
 =?us-ascii?Q?pl9a2WVxYNExQ3hgBSjfzErBSeD3Nv1i4aNsiipDtbOcFfx+KJ4ViP2rAMr8?=
 =?us-ascii?Q?qKJDBpyXuulK7fHXapUhQQFJu/kboCtkQBtK1pC4SuovWhujGr+d4fqdbR1D?=
 =?us-ascii?Q?YMRjYocLJR0uzgoRaF/b+5l01hiDf6cJLLRuRlYpQBVBo8Wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7541e083-a276-4a0f-c8b4-08df1a6f6065
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:09:37.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt+fJd90lZR7DNU9Gb30xVyxsNrJ0ngyL72qG7cbo7MeMmgvUglLv+tBRiiOgtUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On Thu, Sep 17, 2026 at 07:31:48PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series adds the IOMMUFD and PCI/TSM infrastructure required for device
> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and the
> IOMMU_VDEVICE_TSM_REQ ioctl.

I couldn't guess how to apply this with b4 review. Since it requires
the series to apply I can't use it without knowing your base..

.. and for some reason this series doesn't have a base-commit trailer

.. nor does it specify a git URL to find it on.

I strongly recommend consistently doing both of these, by script, so
it happens right every time.

Please send all your series in a rigerous way. Make sure you have a
script that does all of this stuff, ideally automatically. I have one
if you want to see it..

Anyhow, I used a crazy AI prompt to make this apply on top of the last
tsm series..

Jason
