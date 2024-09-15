Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C5171AA
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432241; cv=fail; b=CJcOY8W9JpmLlVimvh6lk4JHHbW06R0xkQ6Kj46dKpKFAVjTJ5k9Amt4EUHL2ilRrSoXeZUXeHsrVfJyw2+91ClkIP+Q9i4d9RWztGwwPl1a8v1JeABz4egVhiYpzGyadMMonE6GJXDGAber5C0n2/fIJOTDSRl7IPoriKzI1ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432241; c=relaxed/simple;
	bh=npdRZxjVqJXb1Il37BVoIO81tTey/CEy/MouvXjpVJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=msEilWthTquVERXDxqIx2/Qnz+TXpBbxwa/sw7s4/AGzbZ4YgehSQs4zK5GtKeDmBvMt1DHqVAWifJaCIamDj06u1lonCHR5D4dRmfc7wm7lo3ZSt5lq36k4A2VYPBWc/CyK3fA9PhEpAa1nBJbRpZkolw6kZ5fAOyvbOC3Pw3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LNT65/S9; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LNT65/S9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kakLP/MK9TrfE5BellnNG/ZP4WRGsn+PJpk3d6AZLhLlgK1LJWd4vsH9sFfbW1fBJ+jxV8jViPG4/FkLi8zHtfaVBc9IE1smupouBrlnSgiWlkl8e3Ge5ZIabwmto+Se9whSCmWHyyMOmxB5ln/p1oAetD9LuZjU8GVzRPPUZFNAbGj+6Cu21urCckBFs8BExrXKDZm3nfjPAFOLqGUKNvZzKppSIy6ehhUdqnBk7jy7VJXY30h5PE63bmw6uCFtkFfoke2dy1xkFOG1C1BR4oqy2UlRzV6DeUVca8P0c5feF5T9Q8EHmjNfhNga7S/nH6GMrPlVgdXWmCo0a/981A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ize+ZEixbEAo5VXyeI2eIbTrAm8CraVoGHP3GSUzRL0=;
 b=SmshRP/bV/LG00ddkugwmHYvI/xBu5W3KvW7pfaozhZFkfz/34T6gGddb0wIHlKE0aVs/IALCZwFVK/ntzqSk4GVJVuZwTDiyjYt+mTJS5e69ZCoSIf4r6x+RAmBHuWXUOmqLCmrR45XUNorQg2ut3ZYVjOnRxhEci66qa9xhwPRgkwdzNbX/l3DrsJG2XGMnt7RSe9kGwsbpRR+gwTx4B92dPe6OvN/zAqm5H8wkfC+EEP89wYhv6GP8SMMhUSrRumlIDL5+jeNWwKe2pHUYwvTVqHkVj6w0f1QJXf27xay6IzYU1iM5KLvVm6/Fdk6tzvw5V85edMB68nxB1vSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ize+ZEixbEAo5VXyeI2eIbTrAm8CraVoGHP3GSUzRL0=;
 b=LNT65/S9J8IA3Bf8SRqSVLbYULHPhMMVAGQTg4X7ibdI4tnMXqeiytSRLeCnc6ALvg6VzuBuhJ4tETl9bcNR9K2Yr4yz7QWGlXiFlsff8QgF9OzuNsw43Izxc42Z04DHP/5hgrlVGXMeQQs2JwAfcfK1Wc50dCBxUTN0+uamOr2GQqHhSgBf4J64YC5gxLtMU2vKDvQja5tMcIWqbNMjLuPqq31hNZLWgQK+TtxI3ydwbV/cgfTce+SfBTZv8fi+X1AvhwTFkpNl3TudbfWDPsCgF5ti2Z7ZhMVf5tOjJkwlOTYl62aCxc+3y7iKsqgYATzGbKHWs+ILdf6nltLbfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:30:34 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:30:34 +0000
Date: Sun, 15 Sep 2024 17:30:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 0/9] iommu_ioas_map_file
Message-ID: <ZudD6O0Sc5Xi+JFE@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YQ1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: aa89b24c-6ae9-4554-63cf-08dcd5c54012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmthfBRGsQabO0pUa32Q2lpPKI8B6CGPuaQIORvT9r9+0LG1zcghodY/PQK2?=
 =?us-ascii?Q?lkTxbpXrLmJCvd6uswrBKh+I9ubDrg9BCinqa9KdGx0MFNx6vmrv7mkAeIDO?=
 =?us-ascii?Q?o+HcN4/HUJbYHDYWWGEuhJP5OPwIUwFNJCagVB6+Xtj/tIAgao3aboJQ90FW?=
 =?us-ascii?Q?ywI13nMiP5G1EjaZuTeMWKjktSJ/uhm0ZUsaLMWLU5KdiLfODahfu/0tVtkq?=
 =?us-ascii?Q?rfb7INlRrBSnODfqXUii3a9nzyqyaCcZ/nz6VoBmeBt4eepNhERPoB5GGRLx?=
 =?us-ascii?Q?Gg+O9jg85rmBNCdybEi4izrUe8gJ//vNcRtL0tx8Ft0aVoKux4VQiJBbTGIy?=
 =?us-ascii?Q?9euIlTOyb6KmEUr+Lr88mTiucf0G7IdTArmaq9W2W7/T6p0MsamCjs2aHNzh?=
 =?us-ascii?Q?KBoGbfA0PVKTl90EOp41TUGV1dM1TR9eT8437xWMVm3tWqllHahLWR7Hanbp?=
 =?us-ascii?Q?a2EZqCAVEPyFo5xLwIc2N03Z+QIGmRMzKzxQDNrUxQMIg/IP56XRBKEY4S8q?=
 =?us-ascii?Q?ZNZ5R9BvRtfsyzaa/3Gk/hjqch+zIre2sYvJnyt7xKQhh7bnz+Ji2lI0qBbe?=
 =?us-ascii?Q?FEuCSbPo7TKsHPR+7G1n6nay3DNniddCvnGesimbtTYp8XoURkE3N3YqvRt5?=
 =?us-ascii?Q?2ysL02MnJRoJ4OluKWCC4I+tscxIGjnrstXcOLavOcc8ZRDLqYSE62LvTmi8?=
 =?us-ascii?Q?F9DNj7Fb4/JHz3QA+X5V0ZdxNf2inCqp1jWRkGUHSVM+XgGq7wh92S9O/RvS?=
 =?us-ascii?Q?H7EaV4Ls3z5LPYqpCopdfS2uV5XwAO1cQwxYLDLtHzeNIzIitnRVsUO/rqa1?=
 =?us-ascii?Q?3FaIf/cxucaz676AvUu8UwxzrDKEHM6sZiBRoIkZgfYMvKaYRQrwLa+6H7Uo?=
 =?us-ascii?Q?ZKVpGl+UVsAb4Cqkg2JKWG0q1PzGNu+t2BLGFfFd0dffN0O/ijJVzIr2VMbF?=
 =?us-ascii?Q?FNM+blLxRWa0xjTU0Vzrnj/cpkca69lp1b9ruGsOcetVPHcMMQPiSuK1uM3r?=
 =?us-ascii?Q?yGW3OL7ltmFdJu9dTQQVLXIN0qPN4mmeelCRIEKtFg6WJeVZXudhBDZhl4cn?=
 =?us-ascii?Q?h/XR2qZTAalFFAZIaSjVjYjqLV2VeqxB+L8uEYqwd9bikKCF+mG7Lwgr16b+?=
 =?us-ascii?Q?yFAOQww4hkHfoeLgFtvJh+DT6wOUF9xQi276myQCeb/ecr4C9Isb5fkd9PSW?=
 =?us-ascii?Q?we16P8Y6FGVCBylxhv6oPOLnFeWywBkZJN9tuLLtbgz1ealzijdJKCK5/8Kh?=
 =?us-ascii?Q?shFjtfwb+aFByUmR+Gvs0Hyfnhbij9FQ3GoWHs6n+z2h91un0ljVzgrH33O9?=
 =?us-ascii?Q?jQoyoBwLiJvy2Tusl324tCguZwvssNL4CRLjBTXWm8f0kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSTEDAxYsvAA+9xIPngqng2krWLTeqFtaevaBnEJ4wBrL2/tl+3UeCWIpYit?=
 =?us-ascii?Q?29yrEp4MRAqUF+VmnB/sT2F7ZOOKKOfmMxHhAle3C9tKqPoPrIPqQtz0qLiH?=
 =?us-ascii?Q?l8dBB5lZTUm9B8f6oNEb+82l9jIUURRYjmsJUi9kvmunp7so1Ki4t5ekKlRA?=
 =?us-ascii?Q?ExdgTpZTr/uenF1XbfONDfikuRXariSOZB6maZS1kGILezvytSDGiBDP99vi?=
 =?us-ascii?Q?Adn6F2jwTJ3fVdddggTMFI98Q4N+WTYgOJjznAbXhjArD/tL/EyZpEEAp0VK?=
 =?us-ascii?Q?AIvLuQWc0KwTvb4mGJKLdh0MXcwf8HYulbOHJlxsasOqvnINkrM6eWykWkZK?=
 =?us-ascii?Q?FwhnGzxSKdhVXJuoBqaZ0F4cLqb5RByX3E7m0cFTLCLnRQXmxB8db3zkSmX1?=
 =?us-ascii?Q?yIG2/I80jZB6aptUyv4zrijgRipE0vu2Yqs/bNK4D8TCo8dSEpazepucwkkH?=
 =?us-ascii?Q?rZqZFvj2o1/vdpRc7KTg9ddG7A1S1K4N8SamQ2FnG1TJYrwIOFcw9ndNWxjd?=
 =?us-ascii?Q?u8nZQ0xYi7MIuXDt29EIF/3cjBtOAribmRJmL0fkKn1VKx7SyP6v6rwNZcGh?=
 =?us-ascii?Q?e4pigZv25MQmELXudC/9vp/tPXB5tExqKh0Y04PK4m/Cxigx8xTQ37Nos85a?=
 =?us-ascii?Q?nsTY4A2f1WK0BARuMUZQrcYf/xrn06+z4xH8PkfQY55wfFNZ0OoRADcCuDlP?=
 =?us-ascii?Q?sJ62emycLzmu31huJrvx4C+poyh3lScxpY90ZEdbIfvZ/JeEZ73tW1NFPG+u?=
 =?us-ascii?Q?0Bnuv8eyQGkJvpqydnCWR2in58UPsFVeLCbP+p0x+ximlLR9ylQ3mV2mymkr?=
 =?us-ascii?Q?GtN/1MMCa3en38kH+faJOAD0Rdc6k6ZVoWkTMpG9qkYDFmny6pJsBiFG+Vyr?=
 =?us-ascii?Q?+bMbvCeaQlElMQlZPpswv0yn4UbbyBwAeCzjY4f1h8IF67QfMpe+hOjDzaG6?=
 =?us-ascii?Q?gr3XYAn56QTo19xMlmIrQwIrZWZeEdZKeeT7Mnv2hHt2HbQy7IFLtPL+M9oZ?=
 =?us-ascii?Q?188+wBmfCDXrFKj6vbQZoiQKf5Hbpy6eXHmwqYQbiEQObMXoafUfoTuXIJLt?=
 =?us-ascii?Q?anmQLGfPbBr1I+Qm+m3JWz8dC1DA5bMS2Vj0QH1r/hD4sFPDjv55aCfQPH4Z?=
 =?us-ascii?Q?sQDg6ZVBXE6akZxyAHq9871YeMI7L7XkgfS3KUbVmJQdmo8vcPK5mLkMD5pI?=
 =?us-ascii?Q?bOZVCtUhjIFfVkgRAhCpCrSuiMkWyTEPk0jr1rW3sTfcoZxXNHDykhh7qtsS?=
 =?us-ascii?Q?MQC+sXZw1gMF5zgJ+D1KPF88YHB+XOlQjQ/8dVVU5EYwt8RNGMJ3JeU3RMmb?=
 =?us-ascii?Q?XK/WeP236XN/a/bCeoQX/w14eVTMc/sWjIcQvGE7hnfXOaQyk9lCLzG787K2?=
 =?us-ascii?Q?mZaqwwlsaybqiWIu2q8DbO9k4DyEdbl6BjYKMw407RsU6Dbf4JI2UBXINu+j?=
 =?us-ascii?Q?hg/gVi36tjN8kW3J5ZVxWnayPUeAx+CBwvvfGppwobyrtBqBxNPAaXnddSjI?=
 =?us-ascii?Q?Mk/gyb/MXrsA8+FWNsPY4jUVtapLbrCBOI0y2AJBgO1Fbs3Ob12Ucq/XeKh7?=
 =?us-ascii?Q?knYmSwsJM8MDF7d7+hySs8W+I9bLntzfJeLuM4DA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa89b24c-6ae9-4554-63cf-08dcd5c54012
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:30:34.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjAeY7gdyXhuzhfTXVVNA/+NYarr+6iKScRPlXHXmWALS/Ov+n1QjNvGy4g2UXbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

On Sat, Sep 14, 2024 at 06:05:49AM -0700, Steve Sistare wrote:
> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
> memory by passing a memfd plus offset and length.  Implement it using
> the memfd_map_folios KAPI, and the proposed repin_folio_unhugely KAPI.
> See the individual patches for details.

Do you want to do this and the other patches as well?

This seems much easier to understand, and over the long run I expect
to wrap VFIO in a DMABUF FD as well, so it should work well.

Thanks,
Jason
