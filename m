Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A781DD0C7
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299495; cv=fail; b=ITrZLnCk5H64+RltFZUdBIxkqyVBCM6HuOMqeWqQV126LqDOE6wskstohcbSZAXUxx5UKco7wWzagbwOgO5RnlsOGxjknbbmsYOsYBsgXutGrbE5pZck0u87cmiUqz+IY3CEjz51/Gs/33vC+wjgYWCgG5AxPMBV3xcKtCOzMRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299495; c=relaxed/simple;
	bh=70cXUpAcKOxjJHRbcFAE1QNxETSE7ldSY4cJ4w7hcPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzZsQ2KnjaiB6cdhaK97Gd2ChcL7yqKNSJJ7sqPaTvenESI3rNhQYopkoi7TaLIveK4AQmVE0kf3BbL8hhMP0OpVBHWuH44j6Uk3wnAbTED9+BgRdHMxQbYRpRi9gQu45oadN/pP/WchAMaX4WNWjukHClSISZeaHOKZY8Siw2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1/gxN3c; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1/gxN3c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3Wr6HIKmONokPvhc89W95ymgTIxPqVDfw9Wl+hy003920obl1ZnMdZRWW4PDr1045LociRDWETzybIg3EfTkf10K4Ov/SnlvFj3bNzbSseCZxWZFvisjFsJAc78+g5U94HlzAxXqJOzV8WuJRCSQFibV2VZd7TQ672wOGeyCbpi0Vy9cbO6N7TtmgG0ODt9pmzuiOU2SHjSt8nq3bcyAuzKouOfcucNGmTmNaKf0SzGIRNIDATEJ1c2uhihsUX26rbxzCV+3+XIzoEuN7afKe5AIn3Tgf2f02HqteW2cYkMui85KiVF08LeB+P+nQcIYT3k7wf+le2+hvdQHJ7t+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y14HCx8QWbTe53eGyMp4nY09gPxCuK58h9nKF0d4UGk=;
 b=TQ5MzGImTkH8r/LmDs/uN4biIvkm5G+pa9koN/zefwZjuDI5g/Hfu1d5S1bdnMTYOMzhl1OvFm72/TCpDwTXulcTtxhP03DNgWfZJNWuJ1ELP/4dlZgNMja/27+HH85hF26u2locw49oMImCk/xx4h+r20zYyCuuhrNgJvRI1t2tqnbTDxh2K/X41yYSBD5Ov5xAC7oXyTt2YGKWCjXOh0qAf+LSh7NnLeuwnKKh747+ZIUBVqoyYJKsvzklkIFstArV7gdD5oG2ZIWTpoSHYYzLLfv2eQdr4nG/0C2lMvbLJLzGx39trLFlkVlo63lcCcUz5ElcXp89Vmd+0toazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y14HCx8QWbTe53eGyMp4nY09gPxCuK58h9nKF0d4UGk=;
 b=b1/gxN3cnQCPuJIJ+LyjkT37H/xNGzFHHvp+3vsxu+GiHtHqSuk3XJIBTg/d5Ctd8Yaes7W1n/ac+cOjJAbn3gwZVNcvrK+OYJmRh2tr0gmbi/Z6BlmC6/QSH6g6mxd3ako28cnsptjv+J0COPFAh7etAldOz6Heg6I0dhlE01hvoV2iZlMaxkrxCb5PnVsSUsJOvxU0AKXI5xqr2hGIVbe5ntzvcbZ+gbDOH+MnXR0AfxoMHoyZwefuJay38eUsThSfd++JaSngipTUmRyg8XeVB8yallnYYZZTh36cnRZb2qCqjJqXBdMtfkrWNrmY4g9+lSnpQZhzhPcmzC6iOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 12:04:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:04:49 +0000
Date: Tue, 18 Mar 2025 09:04:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 02/21] iommu: Wrap pasid_array entry creation and
 setting
Message-ID: <20250318120447.GE9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BN1PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:408:e1::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 968955f5-1fba-4ec4-0e47-08dd661514f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkNc1C8LxlItVewbZJrLgLC/3A1Z9ZORv0nQsKBP/XdpkvtMktuTBvSaiGRx?=
 =?us-ascii?Q?6yOKzOrgBmR3Z7E4UGsDooG7AGG8c6ZmRyf12tKVieeVvveJqpvhC/8/NPKa?=
 =?us-ascii?Q?Y5ESZpei7vq9eIYvPw7tVw0a2X4s+RosvRSRRPHjuYSct1FmGBjaAYa0ygHy?=
 =?us-ascii?Q?u7NzszZx8JuUk5g3w7fXuOIQJZ64K3hqvNxM3w68/SqNZp8JtNbphjYAB6Uz?=
 =?us-ascii?Q?kctZhwss8ZiJuBnWQG1I2tPbOrpTnw+UU8J7zZV1wKHHX3TLXB+c9T1cbxfc?=
 =?us-ascii?Q?UZGf2S7f9PYV3XdqzKfLDN3cmWzg4WpHwQ1/L/avNul3HESZ3vPM22xvvxAl?=
 =?us-ascii?Q?JGFFQVbR6V1KTZGrZvhXPXV9NQl1F9R44ewLZtGDnJoq/JBBKcPoUrnDtZMv?=
 =?us-ascii?Q?FTWqyXl3bwC5VWUlx/OCCfbIi4MgRNWh19v4E0bmKDfonBUafKJlsrzb3unQ?=
 =?us-ascii?Q?xlIjmFY8kvyfi4dnWJuerHNtiRgOKd5BHmS47hbKPbtGIM3tnikX5HGaN7Yh?=
 =?us-ascii?Q?sIpMdqDrNIMYZTn8RLT5b0e2FBheq8ukxXhQHNjvthlZWO4fnEJErJ4IqyzY?=
 =?us-ascii?Q?dsQJ9BXQTan5eArLJK6IqPELAc/hbAPIZ6cvT+MuDUegPbMu1vRPyrh9REX2?=
 =?us-ascii?Q?TY8WtbAMsoiUApR+aMXCQiKJK9+nymF0JVXnv45PtVEHokNF91nsjiQkMg5i?=
 =?us-ascii?Q?JuoEe+U2g4SLj1KTWGdhn9U9zUVvIHheuei//L0GkvezgQLqkIwFKriiv/f/?=
 =?us-ascii?Q?aYmbg1a7QDU9OihezfUDIhFHWY/uOteDkxYgH9AzJ9l6e70B1eOh6X0YDCcX?=
 =?us-ascii?Q?zSHEFkyP4ZE6Pvm4Y5XcinLE05RDas9H0wKICUsVdBhS/aL2dg5jXsSi+GDm?=
 =?us-ascii?Q?nSqWAhJj9n2ohby4K8W2xseiaVE0lRWLh+XJaMbOkkVboJ1ZVWdAnv2SFjKN?=
 =?us-ascii?Q?Z5CsPpc8H7IaRShm0HTquuHZn336L8vGBmDolCt37Perm8QUdfpRBvDDVvCC?=
 =?us-ascii?Q?Rwu1DmoQSfT6g2/3F1AHFM6yMmc+PPlaAOnAXicpA0SaFEfWhbQjOruYYUxF?=
 =?us-ascii?Q?C2cKEt5BrvMSojomGOQSZqJqkWRlHJ+OARoOTMCtNO9b4uAqfEZ4DsxLskMC?=
 =?us-ascii?Q?Z64qYN4d3sgT/Z0DgDtSDiDh+DslPQ8XqBkmG3B1Lam2pFkTBilLlQpzArUS?=
 =?us-ascii?Q?WfdcXfuhVKRkbkgZjw54zmkRPMpoBRosr5T2uskN7wuOYI9ZLsr1+bG7PMWM?=
 =?us-ascii?Q?BtAhl585Y2cIr96ExzpmQv9+bc74nWVcjEVcwym2xwBluIwSRSjNHkHwUY2M?=
 =?us-ascii?Q?MYsL0TBCvkXyuJ4EEFYW5apLYI0oQXseHtRUUJFa/WR2CPiQZBwrLiOAG3S0?=
 =?us-ascii?Q?2vWTYWJbQ81Pf3isgOHPAB6rFRrJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kebb1l8eCHyQKqe91AIka+SWM1w9zqHwmMSyidRk2FimeykvK9804jXOx1wk?=
 =?us-ascii?Q?4ilOmXCaj2T3TOI6Q6COUFWLXxlnk3h4vG+Pl8E0PGw33vgD3L7uZqvKEDeL?=
 =?us-ascii?Q?1fmwrg3glx+T5Dl6lXlWlLzS8pe0OLTJA5AZ7mse7A0pJoAcelsCjyjrXgdI?=
 =?us-ascii?Q?A33tEj4PVK4vJhs91I8iUo4y3S5xbllg+EBd8wDpdxIFfH+xH2GTP/ihRDUZ?=
 =?us-ascii?Q?PiQ6W9aIPGZArmmPfE5cJMcX9q+fcPfUx7CrqzuxsHKM5VE8tGZMxaqCXEU/?=
 =?us-ascii?Q?m25Ih7eGTohBkhU8AADM5UIB7a6Lu/z8xW4bv28aD5EExAE3D2yjh9D1f+VG?=
 =?us-ascii?Q?kf0VNvv/4WmAkiWa3Zagr+519AFr5bf5cq8J24JR9jYKsynpVFp4pQcM0GSE?=
 =?us-ascii?Q?TA66r7s0vlA7yFG4z2UaQ5ZH3yqebwf4kVyQZWDkEjqMk0+ZPdoLT9c/QhST?=
 =?us-ascii?Q?YuF/OFr4vBROMgGebQh2dp4K8r+0seJFA65l5XlOIL5G+FAcrNhoHQKTbkDK?=
 =?us-ascii?Q?pZsNdpAoHh90O5Dv0Zc6Pd0bZHpt4DqM7LseXfEkT6EXA49RG195ga7Q896x?=
 =?us-ascii?Q?0qaxmItws1RYa0L46nC7z591CL9V020THYnUihaSWZX31JpMNcHW3yINU7dJ?=
 =?us-ascii?Q?vYZHM44DoJiePj4xnKZKeRhyu94uClP2UyfYd+iLRFgI/hIVlHzRLFvpizWZ?=
 =?us-ascii?Q?QLpZof00hyNCoT4Up4lLYnwJ4ZkRTnP0njoFpFbqlotKp5gC7z/Co5PuNWyT?=
 =?us-ascii?Q?kz2IiwYI6M0rd97rzbygM30QYZFLIApLk2X099/PCAodUsTDsW11UK9a3HIw?=
 =?us-ascii?Q?b8wn6ppT9nSXc7/Q97iuyWokih67tK5Acs2qvB8b5Oz8/FvcGzm4cppsxQRa?=
 =?us-ascii?Q?/221pILCzCsr3EIS83DxL2GvhWfllyhRO73u23wtpS5VFBohK4itqVv12bdG?=
 =?us-ascii?Q?oP8pP+0ZTVcp9U9pe1sq3MD+v5Tc5e/m1NFM6hyeXw6uAVYs/YQWpK/XE6Em?=
 =?us-ascii?Q?DuNIpxWDBtnX+uKDkD8yzzhnNzDqGB3QyYHPPbOzAmZ8RN85d2sPHZPfjt29?=
 =?us-ascii?Q?wwEgPK6obqdTq20Z/tudrtbMleTjC8mykon+va0B3SqCmcTXHToL9wzBbJ/+?=
 =?us-ascii?Q?ugksngeXggARpnntB52/QW52N6eenuiW5P9hxyKKWU6wbK0IQDXmo+hsY7Vf?=
 =?us-ascii?Q?0dBQ/TLphA4Nrb++hae+HRdbaPuVE3PIZs+xMR+A/2s88hdsU3HDsznHLBFN?=
 =?us-ascii?Q?YB4+kXQnBsICV6+gMwKt33juF8pOxV6N9ImRsLeZp/rit2aKJdyzaV/VxZzM?=
 =?us-ascii?Q?lqndbX1RDmyqvqrbEn6RWr0h3EBT1Hakkxo6DuAxMB/HTOslsrNdoB1NMM04?=
 =?us-ascii?Q?HCbyrrOVmJVV16uultyhNHAgE1RChOTiODMu7M09jeO1ICcltd6AMWZYNzdI?=
 =?us-ascii?Q?Dq/7HQnp8AhzYRD1tMQgZ86IKjadJQyvOm3yP/bubzzytRXc9vl4bNJVgFbT?=
 =?us-ascii?Q?wFAzEBR2rXAYuLQOQSSHMuAQckc1TTxoRlDGWkM+hacQsJfx43EZrxFEcsGH?=
 =?us-ascii?Q?uqv3SMEsHxv0yQoen6Y4a+0Ic5zXPn978+sO1CYJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968955f5-1fba-4ec4-0e47-08dd661514f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:04:49.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiPVtc4P2dY1SGS9+RykldPIte00YtSwuYEIBTdhfuoBC4VSrXaRmdPHK2/lkcBW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983

On Thu, Mar 13, 2025 at 05:35:13AM -0700, Yi Liu wrote:
> The IOMMU core does not mandate that callers must always provide a new
> handle, allowing for the possibility of handle reuse. In the replace
> path, the existing handle can be reused. To facilitate this, the core
> must ensure that the pasid_array entry is made or updated under xa_lock
> to prevent race conditions with callers of
> iommu_attach_handle_get().

I don't think that helps, the access to handle->domain is done unlocked:

static struct iommu_attach_handle *find_fault_handler(struct device *dev,
						     struct iopf_fault *evt)
{
[..]
	if (!attach_handle->domain->iopf_handler)
		return NULL;

And so on. So even with this locking change the domain value is unstable.

The driver still has to fence the iopf queue to flush out the domain
references during replace.

We decided the instability of fault delivery during replace is fine,
as it is logically OK for either domain to receive the fault.

What is problematic here is the repeated references to handle->domain
in the fault path without locking during handle reuse. It should be
using READ_ONCE(attach_handle->domain) and it should happen only once.

> Additionally, this operation should be performed only after the underlying
> IOMMU driver has successfully set the domain. This precaution is necessary
> to prevent forwarding PRIs to the new domain before it is fully prepared.

This can't work, we need to change the xarray, then have the driver
do the fencing to flush out the old xarray value from the fault path.

Otherwise the old handle and domain is still floating out there after
replace/attach returns which will UAF the domain pointer.

Jason
