Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9741166E
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375067; cv=fail; b=Y70AZJ4bdF+HywlC1OgIKqs4hxjmaRVfrSe5yWuVlYGQLxyzs2JZ+iiW+KAb8pz6wUvhoZoYM/Q4VbfjzD2tlF+I1a3QCmllZZ/JybnA2mQ2L9J9eOjPkVqWOnDUIIkYO7eg3BDe5ZGIB5kOp2UJV6vmPDHsm+clDU1pYr0k9CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375067; c=relaxed/simple;
	bh=RWlcdqEtWisvomsAnoa/lnlWuVJUbXJKFSK+awO2I8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+yI0yiFYp8wBai0Jgwsi8K8nz5ssuAtGOnfJzbDPeB4d+rErddlWyoo0+Ov5hBDx5NLzYKFv3W27n6Dsd46s90ikfjtKPlZyon4vR5qQPmtTJbCBMXT1w3cKSyHubBmbOrIP5mgLWjYAtbh/Sn8UNLRbW+m5q6EBkgofxbWx84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ojXTI+jH; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ojXTI+jH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgCctZDy0Z9mKUZSZuE4aiwWvk4c8eeBQqJAlfO+CMQXEUWQlunZK6HHkajihwbzVL8dcKvEAd9WyjTjObmnzZ8Nv+xlBrPVuDsInDciShxt+R+VKsgNQP00vIVa9V5uHPRFilxgAayzCzaYtKIIX89ohk8cHBHiIIUJ0uFH53uCOpca02cjoYlNkgKU0h8Y0HYM8wSup+sFXCINoK8HVsCPW5SbhoRfXXLC4vHX7Rxkvn31Vj6wiERihetERfxaVzEqI7SCsq1gyFN1Oa0G8noGfIULYQ8lel3enNEQrtDbQtxfEkY/2IeoHMtifef/VDC68Mgi9QgTE5rzEuTVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLw5ZWmtqrB34fJmjIE3AKbg+nKFP+E+c08PkqlsaMg=;
 b=gXYWzPJUMwHNnV/sjIDzjUBe/E+tbsstShpDNOhFKB2OsD58cZZ64eRi/xfa6d1CEFF+6O0q/CaO4DXJr/cB+aLcwAvkOrqRQLVo4uDjfH4VosxDhfObUEmXMrIkKgHq9ITzc8KSJhY5AP39ufN0NCyBcfZMlUhRbvttuPdjtZp7htjSRgKG7VKiZ31Y9tH0VCYHMi8uHS09/cikslyth0dy3tb59xlCAtf/zEr1XoYohI0hNnQj4yBeLGGaWSOYVSeMenxgpYiQcVioV5HpV50dEepqTQYmODi7f0VZY0GUh8kg2Hhn8JbkTceOZG4ZJCNANDxBVOqm4BYgA/Hg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLw5ZWmtqrB34fJmjIE3AKbg+nKFP+E+c08PkqlsaMg=;
 b=ojXTI+jHLskukO7/cyAa24BtPoVQAWZ1G+dMYi7GY74cS/n6Z49dUGV7OI36RzzoRrL7TGyve+bqO9Lr+4GiW84nePPIFse5ocPzEPISzgGWBm4t7JkuK4+5QIx7KFMXMg5KWoKojicwsP0tdFwB3+mi680d1c+VRB4pQXeMGSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 15:17:35 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 15:17:35 +0000
Message-ID: <6aa64964-429e-46b9-83c5-5b029c698fec@amd.com>
Date: Mon, 10 Aug 2026 20:47:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] iommu/amd: Introduce helper function for updating
 device ID mapping table
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::16) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 28129bd5-42df-4e2b-dce7-08def6f28176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	vMZR8iWKzQequiy5nIH9cqVa0pQ9l1Z3su6BBgxljzBz3Q2Twk/M6A7otpGSrdLvn+0sB+YxO84Fzbq+QEcrv0ClE/wKk+/FpjiH29ZJ6Iq3TKHveakympIKKH5CHwAMzJbaEYrUNJYfZmPKgg7jgR/hgJ+sjXfs9TwPMQLNVTmTBFgtrVK+6vUiFC+nXiR8HnsCDeTRcO4AVXGFNcuJ837GzYVFx4aG/u121gclKZrqahXJbTSH7EQ/hEMJ09W9lPykQ+dehIXULF/Auv0ME02ZZJPL7pm6eIasNJcoIoCE6Ou0m1V/5V+RsDJCkZyzkg/1btW8ZWQqJm2gl+lr5MrGosb1Ps+w1ofApd9h7lhjRoOgRyT/kyL6cdM8t98B/c2TqZ/zulLXqGsFWNGCbhk5J9oNKgsYp3OncznR8uqLBN+cuEq441wSpIrRZLK9YWtKd+dzY7chkIS+ISLZwj3zMu3FajugIg8jXmkaXkm12ixSUPPc/9KklALHRFqjrHC954RjRbJUh0go9bGEuqzvNgBejQJTwA4m4HRTOocrY+EA+S65DAhWSiSQfemmTXOzvDrruA1/3Nkx6Fp9WbkF2Chwm3vvC5D2H66+0/1H5cAwq5kNrpD1cIVf6wF3Sb8j7O5R9doCt8OXK5K4j4sEDcvQrq4ZGb2R3ntJ440=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHUyUmJMN28wcjF4c1FLQWt2TnYwQmZOeGplWnFBSVRFa1hDVXZmalgweU0z?=
 =?utf-8?B?SUZMNzFkUUhvL1dCMGVYYXpLUTdRc0hyaEY4UDBrR1ZUMkZ5UjBDNk1jRDBL?=
 =?utf-8?B?UllUcjlxdlJjRkVvZ2hqOFNZTkpqTExQQ2VSdlFUaWpMTmQ1aXNiWFJnREVJ?=
 =?utf-8?B?M1RNK1NaMTl5cGpydjUyMThXSitibXZIdmJKMWVMUWw5dWJ1S21qZS9IWEVO?=
 =?utf-8?B?Q2NFYW1mRlRGbnkzbmZ3L2EwWUNlQkR3cWU0TUpYODBJYmh4ZjdZV1ZEbCs5?=
 =?utf-8?B?blRQK2NlQXU2R20xV0pmZUNqbC90MDMxcUhuNjlsTVlQRnJaa0NnWnNEUkRI?=
 =?utf-8?B?SnNVa1FaVXoxRTgzRUFxVXpnUXVOZnVRZkdDMWlqOXpTSk9pNHhPVU5ibVFB?=
 =?utf-8?B?SGZQM29uaDd4MDVxOU5HTU10UlUxdm9HMm5aTU5oRHl5SmExaWNJOTQ3NS9N?=
 =?utf-8?B?dVd1RzBQSTUxRVRaNW9sZmFsd3VnMmpVYU9qRDd4MHc4NHN5N2VGcVRJOCt3?=
 =?utf-8?B?eEZSdWhnVnFWQ3JLbGorZlkrRk9nVURiOEJqR2pFaTF3d2RHYjdESnFVSFdl?=
 =?utf-8?B?MUpYV3o0VE9FZXUrYjljVnZCNDZqQnhZbTloNXZDcEpLS0dEMkFUZ1pibEEx?=
 =?utf-8?B?cjhRQUFIMk9oMUk3MU1tMldEc05INWVReWRYbE03VzJLcXRIdlEwajIrL1dj?=
 =?utf-8?B?OGswRHdjTlJIYkRHWkNIU2RkMlRwbStGbW43dUR2MVR3OW0xR1BPTEhnQjRp?=
 =?utf-8?B?SERhSnVib1FZT1FtMFRYcnBCZFpQQUkrQkIvT05RdEIwRUhZbjRnMGF6RzdE?=
 =?utf-8?B?ZGdEa04ya2gyUVpuUmlackExK052QkdFR2lRdmhIakFBYVlrZU5Gc2ljRVg3?=
 =?utf-8?B?NWxpamd5UDM3VlZKRlpDeWZmc2ZuWEVGTTJZa1RjVHJDTW1EbFBudEhwNnVw?=
 =?utf-8?B?U3lxY2JmM3VMUzlSNUd4WlhyNnhsY3hHeWZvM2Yvd1cxRGdYV0dlUEtQMlI3?=
 =?utf-8?B?N1pRTU95d1lMR3dUeEJJVW5CeHdJN2VoZmZsQjBmMW4yNzRRZ0k0ak0yOWpj?=
 =?utf-8?B?NVJpNUJ3OG51emFDVXA1ajROaGlVTVY3bWtxZFcyVm1zaHdMOVNpT1daeWxO?=
 =?utf-8?B?NGtqd0hhQjh3OG9MbmR5bEhzSnhMbnRWSVF3di9sWlhTS0E5Q2IxSkxtR2wz?=
 =?utf-8?B?b2NLYVJHOHdwWUNBWW80MnkvTkVuYS8zWkg0WE1HdWtFMjZzMVMreDB6Qzlu?=
 =?utf-8?B?QTBnQklOSDZST2ZkMmVKWTk5bkVMbjluSncxQ2xHSDRZUmkyQmdXMTJWUHZs?=
 =?utf-8?B?Y3Vna2R1VVpwbEFKNENpMTlmRGxZYnR5akgwNmQrTkd3TDA0R2RxU0hOKzYr?=
 =?utf-8?B?b0xUODBwN2htTUtxd3g0V3RhL2toQlVBUlg4WnNUOW1FL2lMWm51enoycVll?=
 =?utf-8?B?TG1neGVpZldxQS80a0xCdjA5dTgxMmlXckY2V2NHUTNmUGg0OWQyR0NLZEFn?=
 =?utf-8?B?UHhVdllpYW1UdysxRSsraTVDRkRPSjdENVY1OTUyS1NmRFFqY0gzNnhNTHhY?=
 =?utf-8?B?Y2JXUFovR0hwWmVicFFFdmVnazluRVQrR3pselRwd1QzZU1pWExWU0xnZk5J?=
 =?utf-8?B?UTBEUWdIUFVaTE1aSU00OVJPMXpkMEdRWXRvOE5lYXFaUXc5K3A0b2YzQnlL?=
 =?utf-8?B?Z29MNzZVdkhKNUdPUHhwam5LSDNEMkhFWmNoRUREbXZja3lnU1duaG56N2M1?=
 =?utf-8?B?TU1rTmhNQ0I5Tjg5Q1EvclpxazVJc0ZCRThFWHNtbnBYckZ4ZGE4RlpWRWNH?=
 =?utf-8?B?NWpRSDBYSHZTMEJ2eGRETnIwa09oVzN3TG5IK2xwcjlkMmd1Qll6SS9GM2Zw?=
 =?utf-8?B?WDcxK2NZbU43USsvZ3VZYytZMldHM2UrSm0vTG1sYkgvb0ZlVUdtdmdtalJj?=
 =?utf-8?B?UEpZY3pnS3NlR3BhcmI3UlZjRXVCNUh1TWQyMDlhb2lwQjR4ckRTbG9KcnF5?=
 =?utf-8?B?R01BZGRpL29vVjNvZzdDZW1kNUkxZ3BFZTRBaDNKZEtPQzhnUThVOC9rRUE4?=
 =?utf-8?B?aEh5dXc2ZGpnUnJScm5ndGxvSVRmWDFZaXI3WUZQd2l1b0hkQXNUNDAvUG9Z?=
 =?utf-8?B?T1F3bG9DRldueWtVakh6YWR3c1F1OXYxNW1SL2R0MkI0ZGwreHQrak80Z2lL?=
 =?utf-8?B?NGxFbnptTkhyMjdhUHlzdHFaTmNxWWZnTUVYWjRyQmN4allxVk9JdFRzbWh1?=
 =?utf-8?B?WjE5N09Ua2hab2lqVUM4YzhubHk5MHhHZXluekxiTE1Gb0ticC9ocFYweGNS?=
 =?utf-8?B?dWZEZzhVT3JXbzFFNWFTZVFOUnJ2TEc0QkQ5RlZJZkxuYklZVUVwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28129bd5-42df-4e2b-dce7-08def6f28176
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:17:35.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYjrJzax+96wQHrd6U5+B1h1xvfPqVQgYV/OykTbXcRbosjxIBSpEVCwz4trphx+DZ98h4gvMrENxLvXoR3ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746



On 7/27/2026 6:59 PM, Suravee Suthikulpanit wrote:
> AMD vIOMMU hardware uses the Device ID mapping table to map Guest Device ID
> (GDevID) to Host Device ID when it virtualises guest IOMMU commands.
> It uses GID and GDevID to indexe into the table to look up host device ID.
> 
> Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Device
> Map Control Register.
> 
> Introduce amd_viommu_set/clear_device_mapping(), which are used to set
> the entry when initialize the IOMMUFD vDevice.  Clearing the entry is
> done during VM destroy.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_viommu.h | 10 +++++++
>  drivers/iommu/amd/iommufd.c    |  9 ++++++
>  drivers/iommu/amd/viommu.c     | 53 +++++++++++++++++++++++++++++++++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index b6fd5ffc3b82..ca09a9856938 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -6,6 +6,8 @@
>  #ifndef AMD_VIOMMU_H
>  #define AMD_VIOMMU_H
>  
> +#define VIOMMU_MAX_GDEVID	0xFFFF
> +
>  #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
>  
>  int amd_viommu_init(struct amd_iommu *iommu);
> @@ -20,6 +22,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *vio
>  
>  int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
>  				u16 hdom_id, u16 gdom_id);
> +
> +void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +				   u16 guestId, u16 gDevId);
>  #else
>  
>  static inline int amd_viommu_init(struct amd_iommu *iommu)
> @@ -45,6 +50,11 @@ static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iom
>  {
>  }
>  
> +static inline void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +						 u16 guestId, u16 gDevId)
> +{
> +}
> +
>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>  
>  #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 1975b2932107..7e070f72f02e 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -136,12 +136,18 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
>  	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
>  	struct iommufd_viommu *viommu = vdev->viommu;
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>  
>  	if (!pdev) {
>  		pr_err("%s: not a PCI device\n", __func__);
>  		return -EINVAL;
>  	}
>  
> +	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
> +		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
> +		return -EINVAL;
> +	}
> +
>  	dev_data = dev_iommu_priv_get(&pdev->dev);
>  	if (!dev_data) {
>  		pr_err("%s: Device not found (devid=%#x)\n",
> @@ -152,6 +158,9 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
>  	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
>  		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
>  
> +	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), aviommu->gid,
> +				       (u16)vdev->virt_id);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 708f2c7496a4..eb3f5217d856 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -29,7 +29,6 @@
>  /*
>   * Guest Device ID Mapping Table
>   */
> -#define VIOMMU_MAX_GDEVID	0xFFFF
>  #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
>  #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
>  
> @@ -40,6 +39,7 @@
>  #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
>  #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
>  
> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
>  #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
>  
>  LIST_HEAD(viommu_devid_map);
> @@ -422,6 +422,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>  	*entry = NULL;
>  }
>  
> +#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
> +#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
> +#define DEVID_ENTRY_WRITE		BIT_ULL(63)
> +#define DEVID_ENTRY_VALID		BIT_ULL(0)
> +
> +/*
> + * Program the DevID via VFCTRL registers
> + * This function will be called during VM init via VFIO.
> + */
> +void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +				   u16 guestId, u16 gDevId)

Can we avoid CamelCase?

> +{
> +	u64 val;
> +	u8 __iomem *vfctrl;
> +
> +	pr_debug("%s: iommu_devid=%#x, gid=%#x, hDevId=%#x, gDevId=%#x\n",
> +		__func__, pci_dev_id(iommu->dev), guestId, hDevId, gDevId);
> +
> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, hDevId) |
> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
> +
> +	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
> +
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
> +}
> +
> +/*
> + * Clear the DevID via VFCTRL registers
> + * This function will be called during VM destroy via VFIO.
> + */
> +static void clear_device_mapping(struct amd_iommu *iommu, u16 guestId, u16 gDevId)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl;
> +
> +	/*
> +	 * Clear the DevID in VFCTRL registers
> +	 */
> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;

May be just call amd_viommu_set_device_mapping() with appropriate variables/flags?


-Vasant

