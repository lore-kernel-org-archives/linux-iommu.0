Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4973B5DED;
	Tue, 29 Sep 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684255; cv=fail; b=Ey9EzdJXX+JJPpylyIpiIcypcwKHzk2ogz5ek1YchPxvoV39wmrYMVF/U4HTLgfmrJIxxz8pqzSaWXl8vX0jkiNzJ/RfvluVSdyFF9V1v3HB0oSGx2mX3ZY16WJP+touPyouL8LxbqXPuj8WX/2QBNimcLTZT4ZmDYSRg6ERBnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684255; c=relaxed/simple;
	bh=LEVfnFlSG/BfRwDOok7l6G7jF3Hv3MCl4Gz4ivyPTaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mE1ua90dxUCBMgTmyDdoqE6ckuK58u7vvMpgdt2ItrVODMly9Hali0LYgsw93CJSztnbXXmONWWj/bTKJobhUma//c1asRDG4Wh98aS0rV/UkxWscqiQP3ETQFexTB+2k7Tp0Cnaea3bW3HxgEK7vmIC4EqK0wJaJhEWD7LnUSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=karV9SRp; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="karV9SRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUy9XS83qLwqX7s7vy2i76CGaaTspPCOvJxUGzVuG/AcsyTNIHjvc2OMlJzTCxHLhKa4IlzXZ4YpvX9nUI6uU5PjlWqwF1Ec+X9qrC6X4OCpWtNCw7WzwA5htsfl+oLOoxqSXHRCypIFf1luRSOGXE11vrgSFkk3VkWMBMsryHNT9qAbjvW8avvHzRrAllaoM5xR0SKWkZl2osGQonYZyzUhjDrAI71aXMcZQaHiX2qAJRhTIRHSEbxm3CK3VAV8N3rx9iTdHgmYqgYccLGicGXGSkQh7i68o+PjAUf9tK9EV5zSRgcalAGoU68p7rIFGSZCF77frS4dtODtyVJU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEVfnFlSG/BfRwDOok7l6G7jF3Hv3MCl4Gz4ivyPTaQ=;
 b=nM1t0gxyooPXtLeys7QqrzeFMQMAHaF6dsWlIE8JgRwiyCkOOSbhKEp5cc8Unc5Q1+lbHkVXDueFzNpj4S9kS8utlkV+C3r7ClWiiPktVphII/YA4bs4GFNigwOJUwop9rto++aG7wu2YefK5UVdqXoqc55bNrUowoKMmH/LJ+Zd35uca5rb9OTHA64w8kmHxGQoyICeXVM9XE+rplwzXK8et49M2B/tzPJebwrd2+vpwuuln8vUhW9CSXYqMhuG/ilBfOpIpzcudPj/8juTfF/v0+Y/2CiUHrekCHjCd5kD4O/RwiRmVFXgYu6fuGsdbxxOeDutUM4WJTB7vsHcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEVfnFlSG/BfRwDOok7l6G7jF3Hv3MCl4Gz4ivyPTaQ=;
 b=karV9SRpqyd27DTVVJmUi9B+wioeiG0/bvC5HoUevkqcQM48SmnVZVTHUkNvToQwiZbQa5qhJesAtrBf1xHKHTzp8TqBYe85RDkEfNBi7OYNUVJxGj0tNmGm6wpfA6zPMWmEO5oVA2OrlEINSf+qSyjUCMLbYZjsuy+zyscPZ+HEpQnwPG98pWps7qJKKvrCQHH9S+5318NXyYOhmXLxAOFPmqlcEsO60pFycmMzMl85u8n7BcgIiDcK5DSSvRSpKsZPdqEv+H0/w+eS9uxq0ONjnjYw9a8/n9S9GG68TVIduKPyx1NcaQtDGUQeAV9B3Xk928hrgtFCey9VBwtNfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB8584.namprd12.prod.outlook.com
 (2603:10b6:610:164::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 12:17:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 12:17:26 +0000
Date: Tue, 29 Sep 2026 09:17:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Message-ID: <20260929121723.GI1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org>
 <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5atsn8posb.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsn8posb.fsf@kernel.org>
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 978f6e9c-40fa-4e38-69dc-08df1e239f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sCyWFD9vH99OE4ZNjkkYrSWQVDp0dTmfLX7q2J/GlaaA7ikFAjW4QsOynPjBVyo1yIla9bYCoJYGvOCwzJpJf1loJJPI9KZLvInhx4RrbwY2Pqy/tWgVmEoUJAr9FUCubQjUvjSrD+a/9jn/2atq09sAQFmgtMdP25Kl943xGHGR6MeoUigFLxvWoVywr9lB3hEfdwS772nzP9Yz+YNAefEt6HY8p/wwCjAXgDlzdPB6Aohv9W2AHYF5TfgQT7yNhsYuWxchPt4EKli5QqbTbLuiwD8M1oh2Up9h/mrgGKYo6sjW3n5n0bJ/BUSzLLPkq5X+F4LtnqT6tD7icibWNyOVZ1S9u4i6Lzm10p2I8/mWyG+Bn1Q+sd+iNcPThGPhiQ9RSrj85XSL5U3jfPU7FABmrTb4PpNJ3zcj6lqOEmtIz8c9ToZNgzhNTJIHcGFP9rI9xChRmxMuNEFWqx4E9gpWMCiS/VntrBqhiw7IEAue8I+IrWSZau+aOixpamvECF88qMgj79iZbdTcUhl1I7W0FPP4KK+tdChJTcGutw4/FTCqZzUQ22R6zlGXC/rGrft3Q5rvQN1+bwypifsVC5ipL/27GsDTZiuMPz8OiM+A/75ZOCm2OEG4zZXTtJSc9ObH+qnUJtV+XVbJQ56T1GAZeTVuze5WhwXXqrTsdAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMmXkP7AsKUQH6p2+QDlcfbL3TE2LfIRZqX7IyJrquJJIRpkKlLtPJxsDHrA?=
 =?us-ascii?Q?qc6h4g//Yi7joMzStKzkizTzLcwtNfU/DCTUO6hrBYDb/rd0g8YJN8Hx1urB?=
 =?us-ascii?Q?ON9Klf4pN0oemo0IAyy++slBzcIF4IxiiRHu2LWh0gQYYiqE6Aatao7gKCdE?=
 =?us-ascii?Q?9tNUVEw16ADV3CsW6as2GuwWtCZL+uk0ow4zpHIpTq0EFVxjdf4TW5BL44L8?=
 =?us-ascii?Q?0ASFeDewMTk81KIlrzLDQb14i9Iyzp0HHNUOAp/0R0FkWLmCSFHvSLoFcWpq?=
 =?us-ascii?Q?0qhUJdEV3C/ukRosk81OyfN5Zt23/VviM7rlzlqZNgNRu9WdwpHnQE9VErVD?=
 =?us-ascii?Q?gvs/tBDNKUnH1VQ8+dXAaEUgxl1wLYDZSHcCoh8zOgXnkG8w8sPmh85BEuOt?=
 =?us-ascii?Q?XiJFi0WF/v6QHd6OEX36Afn/H9ceiSCsmbaW2lHc8V+26y3i7AjsPPMMqjpX?=
 =?us-ascii?Q?oNDRtC1xl9Cw62NwDNPPZ9f+MuWXAmIo2xkfWV+SeVEKAxdaFFhhQSzqP/IO?=
 =?us-ascii?Q?/uo2niVUWwdfJaBqNBDvK42G0o43GQdhlqzufEhvF7pzTKMAgCVjQe0/gPYd?=
 =?us-ascii?Q?C2UURs+6jWhZnC9Jy+w+fVeTTUI+1QarqMe92IqWib88N984zrVBIRSOztRt?=
 =?us-ascii?Q?qU9AghgMPugek0dYKnjkOfuAGSC7FNVvQ4lNbeSGS5+7thfC7KpEsHbaaXrJ?=
 =?us-ascii?Q?5sUlJbiHJLmbIqgaqqgMvG2cDVdKQX3HIvOls8dRisHdxVswkpG4YtY1BCEi?=
 =?us-ascii?Q?Y4dS1TmvgcQX2cmBT57N8b8sZ+66QBDK38SEob28PSlMYGj1Np8ZXI2LVJDk?=
 =?us-ascii?Q?1zydiaEW1Nfdp5iWX53Lr2hBqCUjnRlbOiG4gq6D7WhYADyfn8TySMhQld4N?=
 =?us-ascii?Q?KHCEFATC+9vich05NmJFStlfGA7uUVa0oBBFHaGIq9OwyU8rHSeOCfjOa22g?=
 =?us-ascii?Q?ET3GcYSOodcQvepV3f+oHzG8sLMIkOCIgWdJV5SHxKlFFG8pSXXjMx5U4bFM?=
 =?us-ascii?Q?N24n8aQpmrDlfdrMoX86bdFBw+iwtrIDRHKwxPtFd50BiFT+o2Dp3AztB/NG?=
 =?us-ascii?Q?qXSNtchmNrKoaTObPMo3oJzvI55ISqTvdDySmuD1Ynj8lxvNes83bYUV/xgT?=
 =?us-ascii?Q?XX9aV7x2QaAN31Kl6rOa7WcMFamVaMBRb/zz1PX7atbBVrj2VuvT4E1srUFs?=
 =?us-ascii?Q?o4ob9Yu0GEXhod48n3cnTKHccizI7PgiNFFGZPnXU+C2T7M2ByrgCsrQIGpn?=
 =?us-ascii?Q?bhyFm60m9K0csKRjS+jMsTWKgzTKhMreZmqFmG3TKEQ9IemBz/HNJPjcjBcC?=
 =?us-ascii?Q?iFg4OkHROgznRqrKZ7IXH5LIK7MPCwYJtz6x2a80RCR4ilapSQ499VpkyEaL?=
 =?us-ascii?Q?qXznrmyDSsrEG97088QoR17jQHK9ULi0/6Ha56nA5mQa9BS7Eu7AgZULw3Q3?=
 =?us-ascii?Q?J4ycnM0NLYvDA2Ah7DKFK2cy2jjDlTY0xKmXs/kqK0o9GDkyDXX2jvD9ii6i?=
 =?us-ascii?Q?XDlnUQgUkpikyJ7O0Tk6FM5qa+tofZoD1ERahFGQrNjZp46zn0fJoVf9GKvB?=
 =?us-ascii?Q?YfWxxWvOa/56kgHqg+wTTTDK1W4k4nlaQ690dVkqBryJJO6rMKgMSkMs0Nf2?=
 =?us-ascii?Q?9n0yR/Vt10P+hhTq+Q/uyE/26fk2iyUb3MrkM1kHRN7I9O+VwOKEQY8xBojU?=
 =?us-ascii?Q?wg0n58ATNhzAv5Pb0bJd7dq3XdO8OSbDEBeyMVZO5eaj4WKH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978f6e9c-40fa-4e38-69dc-08df1e239f81
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:17:25.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/wgnJiEVgUyq5E8X1iOjEh2DLj0/EAbt8F8mGjgcGVZ1NSxvHAzf89JuqBs8bzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

On Tue, Sep 29, 2026 at 11:44:28AM +0530, Aneesh Kumar K.V wrote:

> tsm_viommu_get_ops() runs with pci_tsm_rwsem held for read and takes a
> temporary reference on the backend module (the CCA module). This keeps
> the selected ops callable until vIOMMU initialization completes. iommufd
> then drops the reference. This does not pin a particular TSM
> registration or prevent tsm_unregister().

That seems over complicated. Maybe we can't get to the sane locking I
suggested earlier where TSM module is stable while a driver is bound,
but we absolutely must have sane locking where we can "pin" the tsm
for a pdev and it cannot be unregistered for long periods of time,
such as while a viommu/vdev exists.

That period should start right before getting the ops and continue to
until the viommu is destroyed.

No hot unplug of tsm modules while things are active.

> CCA vIOMMU initialization takes a tsm_dev reference, keeping the TSM
> object and its PCI/TSM resources alive until the vIOMMU is
> destroyed.

iommufd should do this, so long as the viommu object exists the tsm
for it exists. It should not be inside tsm drivers.

> The initialization callback also takes a reference on the CCA module so
> that the vIOMMU callbacks remain available after iommufd drops the
> temporary discovery reference described above.

The initial pin should do this since it is the only way to prevent
unregistration.

> For a link TSM-connected device, a vdevice holds a pci_tsm_context
> reference. The context holds device references and increments PF0's
> context_users under the PF0 mutex. PCI/TSM disconnect checks that count
> under the same mutex and returns -EBUSY while contexts remain. The
> context is released during vdevice teardown. This prevents link
> disconnect while a vdevice is active without blocking tsm_unregister().

This one seems reasonable, but not sure a mutex is needed on top of a
a simple refcount scheme.

> A new unregistering state is added to tsm_dev. tsm_unregister() sets it,
> unregisters the class device, and drops the registration reference. New
> vIOMMU allocations, vdevice contexts, and PCI TSM connect/lock
> operations reject the TSM once this state is set. Existing users retain
> their references and can be torn down normally, so tsm_unregister() does
> not need to wait for them. PCI/TSM teardown occurs when the last active
> tsm_dev reference is dropped.

This seems over complicated, tsm unregistration should be made
impossible while it is not able to complete. We shouldn't need the
complexity of states here when we don't need to support tsm
hot-unplug.

ideally the module refcount handles this and the only way to trigger a
tsm remove is through module unload, with no sysfs path?

Jason
