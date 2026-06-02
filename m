Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB229ACC5
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375728; cv=fail; b=I2+oUalnTYX2/RWYUYiHbEnhgxYMOLSRLC6NaxfPLceFw/ovGHfqjCHZkyRQ5EFb8x3xGTzqPlSYOIY3wQPFAflgBGwmAYiO0047ealt2eHVmv3yH2JVKXOMJpgxxpvWM5Yc22Zd7QMJvqfpimNDHQ3c4cAlBUANsMr6k+CKXks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375728; c=relaxed/simple;
	bh=mOi/JQXC5cwGr3Fc9hYS+0qZS2F0MKCTTH8yqWFn7sM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epXplwAMW5YrCQBJ+pRwHNymCnzYb7brstd/Zjgq1Qga4Qr8x6CxAYhqxozf6u0TUhNKISxXE3bP6Y9vdnIQ15/mKE5/3uAvZ+Zs49FZ/AzmbATrB/sa9zXLio2jjIx5B1QdjsOAfb2ezTG2KQaDgCV4TXcBIyr5knVvJ4GfkHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wEOHEfqY; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wEOHEfqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2fSGar42aXl3q80vaxfP5AXNMuYt6Nlkmz9HMh65cpJZpXOfJIB5l6EFctD5StrJQvTsZMiyQFT+O9PRf7UcssdQHLrNiKKWRn4QiSndxgbyngevEKMWUTNJwZrOUqzecmulRdC9eaE3cK7rJxyHkqpnmFnV3x7a7dUyHVyRAULAy1Yir6C8yYM1vJl3GO5boYNWoJ1In/mnjRXI+jBrZ7RLYIa5fI8m8+/U8Dqt+9j10YiVdmr7mPHu9DZ5mXwtgFbLViPnpLfn0pCp/4p1qbCjCZH0naXIEBpU7SIoN2+NIQnktWId0UkZAiKsvEn7bs4uUpiCeNOuePG+4fz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30UlC0p+PumJFycZUCMkMtgTjMMiT1YanW5EzqLp+PE=;
 b=rqQPdl7QdKuqiviApMPNUnCbL/2tRMK3+O8MT6u00VKGiNiS0LbbdfRIEOhNJy9t+HqPigPRCZdiI3wtoQ8y0w0JJXIGZIFmAyIcLpcXUHmaDVXa5pSflBhNEucpSpDC/hDekRo1k58wjhWQ903Bpw7cT+i+QmTJq/F7xKbOnNdtyN8W1DvP6WC8KmSq6YJtdNryfh2c/Gzk469LYwdePZz4OS0MRCeqa8XWYmKYworBFw4d6Tg4HE9zsmwQyCb6LukZ1qugI6mzaKwxhOwWhjB5aFZcS9LQ5TRFb5EwGYOCdFjTdFL3/WAJQMLCCvX8Z+FK4BKVVsdv3uAAtw2HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baidu.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30UlC0p+PumJFycZUCMkMtgTjMMiT1YanW5EzqLp+PE=;
 b=wEOHEfqYFieMpQ0xv76VdbKw0/HukLRwyWO4g0pSima/u1+IQDge3hegS1xMGeiWb5d4Bpkiz39qu6iuD5t9jCukYngx7cNQu+oAJrAyfpq8rc5JN3AYtWXUNPUZetjhtdls98urz1LfPs8ataMlWFP6NjoBnCOBTef62pXw/kc=
Received: from CH2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:610:4d::13)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 04:48:42 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::3c) by CH2PR19CA0003.outlook.office365.com
 (2603:10b6:610:4d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 04:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 04:48:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 23:48:40 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 23:48:38 -0500
Date: Tue, 2 Jun 2026 04:48:33 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: lirongqing <lirongqing@baidu.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Fix undefined behavior in devid_write debugfs
 function
Message-ID: <sw4p7b4v5fhguzoxu7oxiy3tjtarcivzalr36cjn3e5okbngw5@zj3oaab3ctxt>
References: <20260601121240.2474-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601121240.2474-1-lirongqing@baidu.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c213768-d449-4a60-90b2-08dec0623801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Vi4+Xtf6VjfuIuLUxRS3EpOcLaizd416f91d85pjPUqnicguq1md5lNE7tfy8lvBufUSac7pVgXjgoTv6WNYmGbUPwih1QUnluS4cLMBmi8EMdXoH8zmULJgVRIq7B/OAWipewdZGB7DwcIXfjFY+8PMmQmDEbA039/Hs1OkQB2WPdPZb/bhp2FlAa+lVMYWRo0FnA0SVJmqQK8xlGIXyCHvwehUks6qyo7XjzekSV5hteNVqD6iySWpmI1gSLAfBs7WcnyI8ATFkup8oIkHVQjtoJK3vI7UFXvv7rfl6ioVHJRUS9fOxANPLwVjVtkgeBi8JMkxAjkH7iF+9N7uy4ZQRl1HR6zUHOiiFCO9Y5kcxMWCgPhO6DU0waj8vflb1tYic5laUFCMFQm1ILThgIepiomIyfkaIEDZ7HKEopCUzafPv9zVuY0ynfv4ICPnbeGLbkd7oBfHx+nALFxKWCci51xl0xVC9jpRObBOLKtpdllYV0ctuIsAOsQ9PlvQEiqjGdFleyf4nrO+4COGyTcfF7SZWz/8MFn96aJL+4I1h0d9sHT0LHpfiBaarat4HBOcDT2wqvGqIo9S0W/nIawy1R1ZRCoVcy75pToW77V5F2n1CcANhlThWPc45eNPdIfH8weSzlK+JULdlD4J+ZLDwzcUR8tO5rleX+RuJXO1kG871YAUhzfjy6W9/zCudiZ9uTpN1TlHxjIrub3/gOBEIcx5FYmEslpk3t+6XGE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w9Mnw5u/QgdC8MADilCatWGCOfYUPBknVP/7lz0UryS3EaiQfw9FOi36tP7FqF8yylH6qlm/xMKLGn0w5AWX0kgsoYLwPMmGl+NESevY6jwpUZwJ4U8V/3+OwNp4FD6yEFXaNtW+XWIYGusJEPGt2bKR9Fb3PJWRrVRESlTq4c4K3utLD/MEAzJvmGeoLD24T8ZL8GUpdo5hJLBt7MmdxW2JHieJEK4s0jOhtLbKUTXzMz4UwzCjTs45Ka52grCMcIdq7qNz0aBO1kvItUKNpcxIFJfVm3dTzemjo9I41EIvoHRV2LYysiKhCvOb0lMQeyEznFy1BVCTYf2bsN2Kmm6VykmZ1HmhS07wMetZGAP5T8cUBRVgPJUv5ACniUE01RskJn88Cl/ff/lQ6Gj8eyYZxXZOFkfkE1X0BISMjsGT4yD/CvShjOaP3xgbFZuG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 04:48:41.1596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c213768-d449-4a60-90b2-08dec0623801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A

On Mon, Jun 01, 2026 at 08:12:40AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When for_each_pci_segment() loop completes without finding a matching
> segment, the pci_seg pointer is not NULL but points to an invalid memory
> location (the list head). Accessing pci_seg->id after the loop causes
> undefined behavior.
> 
> Fix this by handling the successful case inside the loop and returning
> -EINVAL after the loop if no matching segment is found.
> 
> Fixes: 2e98940f123d9 ("iommu/amd: Add support for device id user input")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Hi,

Thanks for the fix. Looks good to me.

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/amd/debugfs.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 4c53b63..5c573ec 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -176,19 +176,13 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
>  			kfree(srcid_ptr);
>  			return -ENODEV;
>  		}
> -		break;
> -	}
> -
> -	if (pci_seg->id != seg) {
> +		sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
>  		kfree(srcid_ptr);
> -		return -EINVAL;
> +		return cnt;
>  	}
>  
> -	sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
> -
>  	kfree(srcid_ptr);
> -
> -	return cnt;
> +	return -EINVAL;
>  }
>  
>  static int devid_show(struct seq_file *m, void *unused)
> -- 
> 2.9.4
> 
