Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199C5DF15
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4S+2Gv7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK9/8aCz4MIgKWu/HeB8mwCDWMmMvhDECsWjMmzpY6YWPtgBDdG3+uezNQUOthfuTg8k4R18n6cckXsEftVXdtAcM/xIW3fRoTj9DDzCwlVKMxRsp381/C17vESyr07wtglkOrNHJZKYf4/6usUcvNwPPhLdFv5mwvSHRiQ3pnG7eGORMUst4iJX2mIQC86ziYERCjdwV21qGoeFsKJhzMJSgFaxq9KKcDC7g9Up0G+u2dnice2K9LLoG9bh0DytKh9qcsKBoc5Vtf8IerdYMkBkBXyAnq6bN801oH3CG8ufZkMFSz2pV/rPDmxi4b2wGTxt077CsMbvUnLGrHdhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3PLz2kQ5eJCAfU1v+2v/fELjOHqAMTN0C2Z3hyUQOo=;
 b=TXO96VvpmfUVjs2QUjaTxoE7pkBCuZBxbUozr9+ogfiAi+QE2D7xFjgwPqDcSyDHAbXagn6Bsu3rYcrFRhPBWz4s85JvpYRV3pMp1j9K4HsJg8biavM3wH7jk/2lqZW77d60s9XLGRciWOIi8DmbWMatcvV0yIJkjvdINpVV8Tqk9bheJH4VNYJG8YD6pW524GsLl/jVT0034EPkE8OxchqSEoKire04SX3Al9KzO5vIlQL1Rb+5Hu6/6Ut0kLef8MUoZAMe4Rx11vVY17mDBkgbf/SbF5fvS654VPVW5EDVXHNsL+zdjkQEZbwD2zEMO1xrkBQIdagTds/qxIIHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3PLz2kQ5eJCAfU1v+2v/fELjOHqAMTN0C2Z3hyUQOo=;
 b=J4S+2Gv7Y00nwAPDaMASy2X4MLnv7vZl70mG96RYYqWVqtfTnVF6b2vJunCzTExzooquQWJptkl+9uQVQXvXnsVqHJLyzX749+t0gXculycgyQ8k2mxG57M3z1dW+aLFdsgNsZMasx50MeZUWB7nYViJdm5PNldBtQoFuHEUSt6lh6CLlIj2Blkw2XgxXsza/+rHfZIfCq4dARYI0WIi4rrwTxFepXrv54RlE4a0/7yZAcli8sbD1xv7G5eXQAoGZSJTDIEd+knHKogxKFBN5RbLWw/9a4MHcCtlGFqXyGa8sbQWKGqQnvLsiI2eW5uVdorlmkvjJQ4dlb7QfLvrsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 19:30:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:30:52 +0000
Date: Wed, 29 Nov 2023 15:30:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
	eric.auger@redhat.com, joao.m.martins@oracle.com,
	jiangkunkun@huawei.com, zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 2/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20231129193050.GA436702@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094940.1344-3-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: DS7PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcc82ea-66d1-44c0-3f8f-08dbf111b2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JmITi4VC0iyaLtqrUL078dnr9nuMS4ogHozGaV00jlRc+bTlpW/4SUUwqK46KLWh9T9J2V9WkZ/7QF+jE3qoQM27K7sJjI8oP/CJtFxQYORbN+LPJr2BCdct7NtSMGPoy2S4+rb6yEsyPaU/ugHOw1Jam6YUBNkqx2Dm7JjR9n8q+l/PBRm8jCXgtX2/MRUkGOZgz8kYL05OEgr+mMl1DAceabwm7kH4QNIkM8IAQAC5nkmrkiLfjecdTbDSgBoLZBR2M+P7NMnaAhua0xK1HzU+OZaBQG7LVKg924MOiHEn24zVJBU/8GO3yAH2MXck+3ueGuAC0ud6a4VaKR1sE6j+XJtFQ++P4Fj4knh+/hG2+lIMX1llcGOTHdfweru4ubyViWY4KNJq2+D0LLguKWeKnKPqklQ4cntYAXT9h1Qc4w62BkzsJRZllD5WfDlmLNIqgymjeRh8HKF3OVaGAxkdNo+nKZ4K2Nt7nd5dVi+2oOZbDaBBycPFr267Y3RB9g2qisdVFfPYBqnDzTa2CnA0NNNLqSxQYzDlI9dV6gV4KRu6cyWuLtdfpQmFKofUI7CJNezI13p1pvFQ7g6Yo+hC0wToBgpEyTtlsPZEqZaKgdAXFj2iPdcc69Pz0EGlWmbsiZ51GFMz08qYFheWng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(4744005)(2906002)(8936002)(8676002)(4326008)(7416002)(41300700001)(202311291699002)(316002)(6916009)(66556008)(66946007)(66476007)(86362001)(1076003)(2616005)(478600001)(36756003)(6512007)(6506007)(26005)(33656002)(38100700002)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsLftnTHbOLx6ueittYXiEnA4rRRbyb0sOCyuPr5eSHTdzPjOdGrLaQzlwjw?=
 =?us-ascii?Q?j2AB2WJlhsaZMR2WaAimGbVOPTQD8pK4zzXQoB3zHLjMWUOSNNc9wdACPtus?=
 =?us-ascii?Q?gLkqj4UjNBbvHpiEGmKQ0GaZyyWM0QPhg4PcmOIZrtWQTiK899mkt0xcMeLb?=
 =?us-ascii?Q?TphrSSuGUXVfcJUVOEUgMBvXYUhHlLzTCON4/RkvkgEaSpy9OBS4gdKPIdqV?=
 =?us-ascii?Q?G0GpjI89RCloQtI+b4s0YshS1sVqqpNf18C+Inzw1CRYIDLPIRZl2KS7BV54?=
 =?us-ascii?Q?f6Em4RiJVtngauU9s2XnBlytiQe2wzuPDuQZ1N6mzDcDlTt8+LUO6r4ugYc3?=
 =?us-ascii?Q?8SNxtcZt++G1ygH7WZDQqaf04vsCYkiiodAoGydq2L/4RqAbXCIVQoKTOVsn?=
 =?us-ascii?Q?tb1bUwEPFJ3ApgWTaGud8n8Y3qQwdCeDFCPxQfFKr1EShm3AGzwGbaX9FWhq?=
 =?us-ascii?Q?V8Bm5ZCgoWOfopGJS4unpqA3C5Ep6fa1F07pv3pVXRxSzqkAaF6KiAB1NRcy?=
 =?us-ascii?Q?7uX0GgiVMQ+5Uxmht3q75XCmIOJ8C3KxM87bZtUM+FXeKwS38c3EKpWdiUQC?=
 =?us-ascii?Q?aeMfkrfPMQAIHgbGx/WTWWt1UjrgGMxSK6e12uC2jDT5Gl9p2wTu7kymp9PD?=
 =?us-ascii?Q?9r0YwGTF6pX1vvg41+FEK2ZEq7onfNmN/04HunEFuSOPal5E69bK4ZV6BBDd?=
 =?us-ascii?Q?Kc8dGPb7hOb6zgc+q/DLKdhe9XIJm9LHoo1A6HW4NR3RauQ6G1EUewW/hCit?=
 =?us-ascii?Q?Uy26lGdjaI3oU4/9whN2s2poEeC/zAoOYbvE4BRBtUMEQzOFLe+2sqSNsApX?=
 =?us-ascii?Q?mM21BEYxRFGBJZoS1PikJx+6Al9U/fl+m0I7KWtUbuIWklTiEfywysDB1k95?=
 =?us-ascii?Q?QcGdS8pfhf+voD1XQ1UgAjAghJ0+o42joqTWuMkfYKs76cBwjg1SA9WuVaVK?=
 =?us-ascii?Q?od3IE5CVc1LAjRakUJktMe4Xed/rh7raKU3/dJuMkrtJACPHIGUVdCC2uAZo?=
 =?us-ascii?Q?HqzUQJmtNcMvRK1KaNm9JuU6F11rJRaB6Zt4V1E/3tS31EUxH/Y9EU9P6RPV?=
 =?us-ascii?Q?/V2d+So4iSIUA25HfTY/vYdkLVaBARkV89BQgAdfO7zTJ5awBIVhGhH1q/wK?=
 =?us-ascii?Q?oyD+g1Jh3OD2v3Kx9fws+sLFhdwAUWTgeWsq7h68ci7CZtazAjHzeQl7ZFzm?=
 =?us-ascii?Q?w2FZDGr784jHlDSuYWdzZfqLNagExh9aNB/XxCSA+qUiZfmprttIQBs57l8e?=
 =?us-ascii?Q?Yx/cb896QEepSLxxs9h6LOhYsyXB5ozhz/EImAwr4wfwLiM1FNCDrrUaXJ5x?=
 =?us-ascii?Q?/TZ9OdNcfFZFKdWo8wzBOAVNsHe0q/C7/Z3w9miUcDol34hqz3SxNI5hRQY4?=
 =?us-ascii?Q?6I5QDTsqBBaOkg688aadrqgMwm3hjNAGYrrM0rltiy5NcRufTcFk+SJmvyPd?=
 =?us-ascii?Q?QHi6SaxRbiR0jOsUIuOzsaTa8PhInty0Ewt43Qwlw782qKg2nuo0tFxytRDh?=
 =?us-ascii?Q?dzX8SnO3/Y6hCDc6BRI0hYQ2eWtYQupZ2ERc3rmkdPs08yf7vz97kccSAWo2?=
 =?us-ascii?Q?Iklo6CC/9nQ4tzX/1tYXwUqE1VHY9wmeRiA2etLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcc82ea-66d1-44c0-3f8f-08dbf111b2f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:30:52.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk/iOKcN7hP+s5EueiDK7HPW9hTYIZkoqnYwdBSaFfNa85BJA+BkNKEgO/jlutEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

On Tue, Nov 28, 2023 at 09:49:37AM +0000, Shameer Kolothum wrote:

>  /* IOMMU API */
>  static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  {
> @@ -2401,6 +2413,10 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  		.iommu_dev	= smmu->dev,
>  	};
>  
> +	if (arm_smmu_dbm_capable(smmu) &&
> +	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
> +

This flow has become a bit wonky, the switch statement right above is
already checking S1 and partially initializing pgtbl_cfg.

I suggest moving the pgtbl_cfg init to above the switch and making the
switch store directly into pgtbl_cfg values and remove the stack ios
and oas values

Regards,
Jason
