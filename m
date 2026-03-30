Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693D30594F
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872915; cv=fail; b=VTPBn2LU0roX5L1wvDThBkfZEq7LsiFhLgGdOBNMNhdR/MLUu3j4SYoHWB8EXu/nL7lcqYuTvXPkru49LB1pJg51FwwPNwc8ku2zDrAPXUjqDX1rQT3IsnIG2PyV4L6jdAjlYmoLlen+yjAq+Nfr1bUfxlX4yYaeml+iNzUl5+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872915; c=relaxed/simple;
	bh=NuWMBsM2XWTWVlcGmfA4fqxU4M/qJZXP3fMpFran1aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DtyHG9UJXRC0xh6epKinfU/GggzFlP4S6ODBuZ7asXRJB0nPyIVcHAAdRnAsuziiGmplQtwYxCN9/ZLVvhCEFr1r9oD4TMXxf3BoFzK8NnUo7ELfyAa/C+LyS/tx+4xmQS9FDLfV3wWzJQZ/2ogXfU/4Q8+Ee/uIciGNjS04DTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaKBAb6v; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaKBAb6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SobEk8rw6LLAW4iAJ3FZMUuG/BBlGaR2cC+oyDYWpE98KAd5xMSEjelXl0EFxfqzdmTB3dq8p5aQocQv6+NrhJfH+6LGaAyYsN8PsDdg2UjujzMJpNZNgj9tLJZF+f3XfW8Fdn0OmCmd5qQfYKywUuj1TrDOVpVcjXDNT2DCgyms4Be5eKALYdaOdNjAklRfz8E5tCqYuw9kh1YrJ8papw4NqKjJeGedaGIACBrymtmqPO6h36XtwgNoJ5+TKmNv1KoZoNdp+FMS7oKBZwytBLvi3ZdJt4wLLjt7KiCahgQNw98w5uQ/DrRWmQmuYbVDDRPzdvASJq/atIn6xQxbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdiLar1T0LMr2CzjunsRZPEJ7hPEISpPYXtfUTpShBY=;
 b=yh4Mz1tvIuZ/gh0lly4/2R/qoTO2G9Kwtv6DorHXXbn1NC2TmNHgLtI5ShbsmSkW8zRtyhZ4PgWgQj4hkff0dTyfUYs/DGqvr8jqdQ8xK2N3v0VRqLX/WX6XtvuTZ352xcSDDmwXCFRyMcch0vQyCUgJl1rOiTrw1xru+6PCpRNXjJ3znrmDYGoA1gE78Bnbh3yc+Aj1Kwxd8jqQeMuTQmFX6GE4r/Ov+sXGpP9cyGF9s6hB5Yeyc6Xd62AE2QVAlorIQOSKvNuxCUdSyHI6tam+FD1WCC1aCwvRwA84R8EBdz7peyuyuU30wLg6mnlHR3cxtg2psrdHN75qUNqq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdiLar1T0LMr2CzjunsRZPEJ7hPEISpPYXtfUTpShBY=;
 b=kaKBAb6vYpyvVcrVrsHe3ycTiFUqcxG5lbDNvEN78CJw8H3N+T3v0rVVWblR2fMEHEY3UPp8cC0Iqi2teXsb05vYdCevoIeLeMhpUQzN7uGpahYq5iPkCBN02ZjMR1mbmHyv8Qedg9s/7usk8UszpZJLFWA/5bI7dmA72fNeJg8aixY+oEI65dx40i9ibRez1AG5Jvce2Fq/MYHaeqEUw8gf6yWJ5dxTkEcuI8dv8FsgCvtbuyZFR7x+zvizutczJRQqnOGdJz3e7usLllwa8/Fysb0cmDwPgomlameIFp9/aXfuC2fxfYtp6z1Zt5QoktS38F8tbpIhHA6eI2CPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:15:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:15:08 +0000
Date: Mon, 30 Mar 2026 09:15:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH 20/22] iommufd: Introduce vIOMMU option via IOMMU_OPTION
 ioctl
Message-ID: <20260330121507.GD310919@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-21-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330084206.9251-21-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:c0::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8551cbb5-71ac-4301-01b6-08de8e55fc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FgxkVj5wUu6H/zjFjwaSjGlStMs3kxTT5fJWdF+3JIYkIEX5QbJhpx/nagdteuBVAUeanR696vTW0d8kXKMIdBgdRYFn14f4LPJ0iU+UYmDzETdhyduBAX+Z8v9uirJ5bi32Q66zgvHZoCXd55sX8YXUp1ItUDer7SVPXK9RKh2IWzPqvP8W8rp5ga7/bCVj0Zu0cX8siy32if+4Vrr046esWQXiXaW8i57Ni5fkVDBg0wAQWcxGSL938Upu1zmZ1TRX4cnHZlabEnF2NAVEH9vIhPbBHrgMAutgXYXVGIAS53YGTUqgYRF+JMbxKSRiFyPnqf9L2nb/FI8XA5whqVujVBNpYnNkilZB+IoMfA/F+fm90eU+LPm0/S7nbRBzYfDVZMwGJ34JV7VxZnhzoItslis+KL6+xsRbaYAaMjTX1Zm30Lkg1wV/LwlQdkTqFteyk5I8I1xpFL/QEIOaBs8mcpZitYJaild3ueOH4Se4SsI7A9bmZhtJErmbG7a2/Ndpn9kg4A7xV9pJwhIGImCLsrBnBRQB6TMfswG11mHOQq9vNS+rYwvtBuxE7ubRMKfHE4i0bSqwjlstsBL2Ol3C0dCoG4LesCBQ5Jlb9YOs4tyZje2+oWBJSWssbG9LX6WUOm0mBKr1gCHZDyLCfcWRferf5DAnlWcIJ/fqf517mwVdfmN6gchrdXFh2kk9BjqY6pp4timZvnRogdnxfzjOxUH0aYtXVXTCxjEFAW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dachq3q/1uVYuZYcR3bWLhpif3LvTPvlT5qtPDU6uuMcb3M+N+0sqlx863gE?=
 =?us-ascii?Q?y013431zjbEyQTmbaEQ9lKZvFSDinB+IM07Qm9IJvtDmwL4oW4JOPLnDV16y?=
 =?us-ascii?Q?/1ctjuYYF+j8Od2xx5uScMdWcvJ3G00QX2wqrO1jFiqiN2+PibtpQcxUHI2l?=
 =?us-ascii?Q?6viIDFRdGdqswingmM8hh3w1o6hGedZXXn+Zg3g3S56ve43vdALcf6eDcbZo?=
 =?us-ascii?Q?KdRqeD6tBi+OUFB37nEV1uAAM3HCGEMAyH12LEsHB7/U0yqWXOLZpCg0Mm9g?=
 =?us-ascii?Q?i5XsetkWPAtHLeBflpZF7wgGPELQABvthGy1hkZ6NYWYS8LgdSGscL/mdERP?=
 =?us-ascii?Q?7OrDP1Bcct5XNusDkLUBEXsOVzXd7NRo0dc/1Jz+zvbV0zwCqFUBpmVnOvL3?=
 =?us-ascii?Q?zgkc9U4S0lrZpFZMwRMwqC3dHbJZcfJuoXN8XvwgjPstVwnVskYB6i7FLHYp?=
 =?us-ascii?Q?H6n0Ey5EpjZW9FOEXXRZe7MNpUlzyGJWy/F6i0j++A0ZCRyRJ6hqS733/YvO?=
 =?us-ascii?Q?lRlxZHo7m6o8zWX51o8HMFJXp6VwyiGu7/ZAtwgMrGVExPfvUACavjssgyIK?=
 =?us-ascii?Q?TUki5bSZcpYlgriy8nq/VP6hS29bOMkI1g03X4RujqJ6j2cWpTuLP6xAACSo?=
 =?us-ascii?Q?BfR3hRFIB/ueQ6t7DRhrdsm9Ckrt7eXV7ccAwN3WjvFlTgUaiV9N51+pohgq?=
 =?us-ascii?Q?WS+9SoqZrK16BbDd8qRdxa5yLaHKn9gVpRpTjl9bN535L1dswblcmB9uOXVG?=
 =?us-ascii?Q?7W5GVSaGMzXJEFtJc4ckg+4BVCivdHmuRB11lu2odfM5eVXlFXfCPaLhRPsd?=
 =?us-ascii?Q?qFnNoEuU+zki/3nFIx3+YkRaUa/6f40ZI816v7rBOjnKsY+Em45ESIuypO6X?=
 =?us-ascii?Q?ZOEup+WEVN6qjP4G3qBMtymgs3E8tj/REPIuxtzzlapNbnyWG5OMvOwYVkJR?=
 =?us-ascii?Q?XHcerGbxxo2c9XTAF8XovoFCoGwj0fVVF1Fmgbq3NZT8h/1TPV4qppWo0u2k?=
 =?us-ascii?Q?hKd43B4nVTfcgWf0De18QOHJw/Q7T1VXX9B5rxoV/dv5QsD8vrzzm1EAB6EW?=
 =?us-ascii?Q?Go6oIQ0chy+E3UJDzHKLXJ+9LSCWNMgCex6zGhnZprWawNhJf+rcIMZamfYF?=
 =?us-ascii?Q?wKxeygvpHtsN/ZZ42riwTf5nVLPgxhxMraErMbF0DcHP4R0/5ksm+GBXcO5A?=
 =?us-ascii?Q?C/dpg4Y9xtnMgCpMQ9RS8OerFlGtUuZhULMhldw8kzlb+3kri6M4ZCAKTVpZ?=
 =?us-ascii?Q?V+xbGvH2GB+k1yBPk2I3dHIQJi5HKVE0dc0Eg2AqBKmDDYC7o8qfc9wjkQ04?=
 =?us-ascii?Q?5BFpHrDnv2HhixWEWpFuFHmhcMCgMl/FXnUdGE3BLvdWA91ew94pXoBDYh5o?=
 =?us-ascii?Q?kyEY8zIqCaqJ5Pvwc0jOr9rHRRsVh/LtTMWeZxVr+tL05HPjVSrcBubDjliP?=
 =?us-ascii?Q?9zPpiI82mHEX7LU+by581A5++TQyXvQ/m+BuVNhtCc7QbvkFH62UijZRDLTa?=
 =?us-ascii?Q?NMCRVAh2APlUSRoqyTi9mnLiOmE/nu6DyUWZhnaYoBo01dNWIcSBiLonoy2z?=
 =?us-ascii?Q?rjiA/YLTz9KmMJLYs1DzirKDBDxJcMi+p7H4wIiin73vP1c+CAbY85UmXbyd?=
 =?us-ascii?Q?i7hJu/4oL8Zpd6/MlCohBbMkvuW4ZGscjSzOuHbY981cvf2xLCpMwepuDIA+?=
 =?us-ascii?Q?e88HtBW5sJPzwfh/387xh2UqDvS3vsmkZHekhksmUqqz2TsW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8551cbb5-71ac-4301-01b6-08de8e55fc15
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:15:08.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzTarnpd3+80PdaDdfNcmjq3185DSWkzW7r80fqPmIXvdRDsbB/vTPRYuJJGKd5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714

On Mon, Mar 30, 2026 at 08:42:04AM +0000, Suravee Suthikulpanit wrote:
> Introduce a new iommufd_option enum value, IOMMU_OPTION_VIOMMU, to
> support vIOMMU-specific options. Extend the existing IOMMU_OPTION
> ioctl to accept key-value style input, enabling access to data arrays
> such as hardware registers.
> 
> Additionally, introduce struct iommufd_viommu_ops with set_option
> and get_option callbacks to support IOMMUFD vIOMMU options.

This doesn't seem like the right API to use use for this. You should
probably add a new ioctl for viommu "commands" or something like that
which is better structured..

Jason
