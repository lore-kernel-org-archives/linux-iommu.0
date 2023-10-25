Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DA15AE5
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EL6gpZU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkHfQ5MH1aj0217i1NQX3qxYbusvhuVdN4FCOCnJB205fBRRctdslFc6Al0Tp9UDWwNqTiQUjlp405hvHla9xfS4SZye79lIbriYe4lWs/97uJxK26wk0sSxzhNIasF346lqOCWcLG507IuZgpkkHp3lIx1KadMoVBQEHZR8tzlJbvk9xe6vMQRKONb4ucE/KHf6ffUGRq5PY+q0OTC3XRCikaaCnqWURxBTe2IV0e9Gdt5+MTjPzxuOYnywG8tmHxBgD6sYh+LhGpRre338hZVevH+HRwVmAgagxiFlc+4Ukc64nYIPtqpD6UY8ls8nzqmQc6czp2ehmisBH2JVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6m8aje2unD5e1c5iTfAthUIaDBYkYTXFAaEXrB8hvQ=;
 b=PhQilORVPIf6kg7nTMK5RptvEyjF9Yyn0ec1AY8t98EwSUAna1BUzu2NVDR/Ga+YolPNykAejdk90x8Vq3vlFDseSd+oTpUkdVn9hfBM6XCpr0agyotjBmae4Cw3sPJoYD5qIY17nojdgon/NjKa1PC1mHQRy/PUQT702oiS1pSXC95o5r7u5nxTGgntzWWNvbroIn99jURh6TFSutJO7gDJnAwha5ADPP9h2Gujmjo9Nwk3DAF8ANEDCBGgfjXi/pF6PEb/oZfSsb279WT8ScFevm67FgXNv4worurHJDImU4ioAIMELsttUkCZ3Rj6aRv4Qim94JAbF7RxJeUjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6m8aje2unD5e1c5iTfAthUIaDBYkYTXFAaEXrB8hvQ=;
 b=EL6gpZU1ANKiAytACxTbtnPVm/PvSOfphlsdjI4q4z5+LlndsYaz64Ht6mAz2cweDGioFMnplQtLwV3fLF+1MFko4Jj7BrzSIX2RaHrkjXUtTgQo4R9Hw1kIMyM19lhs0dEWOB9ina7TIxdGzD7Sh13vQK8YSuQ9Fe8dr8+Lagmi4l+Su/hSJY8sgJm02vKA5rtMEPoHyaiEPjNy3vuY+uS0QNXg4z3vAuxSGt1HbP65zjoi49rA5avRUfNw4LnHltueRlbBxSkK4fuwazqbm+pfA+TtfKvFrO8Mh7ARYaB+L/sBt41wBfkdaAC53D86XZPZ18iyXtOfQZM2PLP4UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 15:10:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 15:10:30 +0000
Date: Wed, 25 Oct 2023 12:10:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 25/27] iommu/arm-smmu-v3: Allow IDENTITY/BLOCKED to be
 set while PASID is used
Message-ID: <20231025151028.GA1132325@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <25-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f190314-a09c-446e-7cd3-08dbd56c8714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q+ap7/S8lQdV5QW9sEbTqvpJ5EefbxZoHMa081d+/7Gsfhlzehg2cBYMTVuw2BVuPIWr6GSd2VVNE1m1fxrft6fc5NJwjP6GHM4fecsCo7IunjiVjjETO0iIOX/914gzJw/bV0P22hbwUSI0Te7OqutwLyTM9Ouesde6tGkrluo4nW7s5dONdfem2t3UmDWRZ5PQpQ2FR/S8G9g86XH4eyLKO+9W/24xdQKZUEee2t0eyJSY1YSq1UqOCUs7JmJYklsLtc6BGXb0O2WeAZI+0vzlC7sulzc4NpkEEhmz9qMvHcZS2/r70NfeCIT34iaFtepsAUrn018MYSJZhmGTfLf4dBpEN02O63R02+9Qd0MB2viuAvPu0shbq4krzCilcavMACvF8OephExoTCti/VsQdfduTA7ukEXJbPQj3Ri2C7/S138IYJO88RKlZoKhG5nJLQS25V9WxmG28E7LWAqg6Rr0C1E4DyF+vqVKpDBiMuHIEsO+r+xBoBnnWzmjwslsyoUcVRDsaEzlQbkMHUZxl2vLOKxZHLF8RzhCWJw6cdvadAbxZIsDsVXXx2zfsitkdRM2jHkoVRxL9B574BesLqu3Zxvv+foK0DPOH2+FHz6fJayMKHU0vhPN/7VIqdhvOQDSJ2AjZC3k8JsXSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(38100700002)(4326008)(6506007)(26005)(6512007)(1076003)(2616005)(8676002)(41300700001)(107886003)(110136005)(83380400001)(5660300002)(86362001)(36756003)(66556008)(33656002)(8936002)(6486002)(316002)(66946007)(478600001)(66476007)(54906003)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaBUeBCC8MpT6v+13PMjRLz30h8/PFpcK+xPPBxyRkuc3VqMGAYTqCFzBuAa?=
 =?us-ascii?Q?QEqf3Ay2DA3pooyJMm8haCzRAWPpbCvkoLlrWNEm1CVYb3qfpGAQwDxJsuGE?=
 =?us-ascii?Q?JrS4fEHHW/JfgVeFqhfPPbYK/sOut12bRcyM0fT3sH68GO/b4y1Y9T1mCCgk?=
 =?us-ascii?Q?qffGt3RZUEuUuJWJ3O5jt0pHm7p+/X60kM75x1ycx3IfaW67DWZjFvhyiB3Y?=
 =?us-ascii?Q?NjVSHz5bpAmWjVX5i6Y4N7qceygclbKx0yvOHSkGs3aXy5xSGBZpeYy+vHqi?=
 =?us-ascii?Q?Ca4nEAfiGVBv/fXhhVpYbIy6sotfPTmNUYFP7w2fqpAfGOk8lmMxPQk2tJnY?=
 =?us-ascii?Q?jt30/KbP/qTFxTXKa5W3Bw9cFTjbJ2rAp4xSN4mWIOpcrvymSBaPBNMDO2vC?=
 =?us-ascii?Q?ryYN72UzIidMXYnRX82JL5IBuzhCQP5X0bIWeXsHn3z1wA57pt+DdSY1187d?=
 =?us-ascii?Q?LyzEIUvxeiFzJJTf1TFbUk1v/U50tdgV1x9euLA6jtb/jPAvefFmYWH3E+RC?=
 =?us-ascii?Q?C0hibYO+8r4QnVGC145pRvxrnIo0HT9LVj7yDBZllrDHXk2kQRiN62ftvUgp?=
 =?us-ascii?Q?5c8Dsnuc/AolW8ZWPknp3EcOJbUmWZQEbphaPjKVGD6t2ERl/5HO34G3VC+M?=
 =?us-ascii?Q?Ob6vqZfdAOzNRo6uq6UNIbG+owUWbNUfcctrMCoXVl7p88qcet2lHTx4znky?=
 =?us-ascii?Q?/vUZ51KR7JX2MjdH9IpfZBeZMoCfsxK/uN0RsNlfooFuo5C6MdbYHB4S1Sd4?=
 =?us-ascii?Q?pZC3ZCNlKrPE3arOFw9QEAErDr0M9dzEpvIzBdD7+2bZCCockBSrOOIwn7GX?=
 =?us-ascii?Q?CST2DxsYlZYlWPBFUC2NBnPqKtaKAGWsqwIgDvIlS5l2isaOab/4l3qqgryT?=
 =?us-ascii?Q?b0w1EQBwIStFLJ8XsbmYi/4C/yXSpWpWGfiqTxQARIf+mqEGWthG5WBd/CMJ?=
 =?us-ascii?Q?Yiz6Q1NWisLKff4yXZ/jwpbIupJHD+gxVjvIwxZUdPbePLpWiKmmhem+1XoG?=
 =?us-ascii?Q?NdJVHV+Stq7f6//zVhiEElLLmgKtA9fT3rck5tJx0YmDMmxUqAmz2I8xEndU?=
 =?us-ascii?Q?F0n53SqTpVm1kJfUJBxzd05POCVcEf+UpxumrUE7f0Be0HZavdwNlkEoeZ8x?=
 =?us-ascii?Q?kkFoY9AMDd6vZqdLiXb+tAgIl1+gAaU3sQPAtGJKj9lBKX9gluY64u3w50jW?=
 =?us-ascii?Q?89emOAHLfPQd4t/EuZpIS9FI2Npl+FJfvjdxxi7rrYfteo2sCy9G2ZUapjeG?=
 =?us-ascii?Q?i6vb/G9BdRqLDA9rEj9F9rWorjHrPhW/QMhgBSglVs0nB1EEpK3adpjYoFhX?=
 =?us-ascii?Q?FVC7jc7w++xQwsoy1ZL92AaJzeJkil2VhhOPac13RBQv3zTo24mvd/IzJfc/?=
 =?us-ascii?Q?TOIHFNglXbb0gYhqSjXIXKX51EI+Xc+smWj4meY5TGOaeGW4I5ENL5ZcTXUx?=
 =?us-ascii?Q?Let+aQicUSw48ag2gSi4whqGXQWapmKilemEVRjIX/ZqZIBU8EKBbijAuDGM?=
 =?us-ascii?Q?J3ec3iBTYHyBMxw8SVXIby5mYEkeuVGQfBdJCtmJDNY4C8P6MS81RY+GQ+NB?=
 =?us-ascii?Q?DTmq+1S8WxJ1l+MmUOrmRMuUeM4qr8aGGfbKzR3l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f190314-a09c-446e-7cd3-08dbd56c8714
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:10:30.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujy0Mb5gO23cS4XTocSpYrDrnVGcaWUizimCjfkfVnxX1P58xJTSngPX741o/RIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

On Wed, Oct 11, 2023 at 08:26:01PM -0300, Jason Gunthorpe wrote:
> -static int arm_smmu_attach_dev_ste(struct device *dev,
> -				   struct arm_smmu_ste *ste)
> +static void arm_smmu_attach_dev_ste(struct device *dev,
> +				    struct arm_smmu_ste *ste,
> +				    unsigned int s1dss)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -
> -	if (arm_smmu_ssids_in_use(&master->cd_table))
> -		return -EBUSY;
> +	struct arm_smmu_domain *old_domain =
> +		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
>  
>  	/*
>  	 * Do not allow any ASID to be changed while are working on the STE,
> @@ -2755,6 +2760,19 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
>  	 */
>  	mutex_lock(&master->smmu->asid_lock);
>  
> +	/*
> +	 * If the CD table is still in use then we need to keep it installed and
> +	 * use the S1DSS to change the mode.
> +	 */
> +	if (arm_smmu_ssids_in_use(&master->cd_table)) {
> +		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
> +					  master->ats_enabled, s1dss);
> +		arm_smmu_remove_master_domain(master, old_domain,
> +					      IOMMU_NO_PASID);
> +	} else {
> +		arm_smmu_attach_remove(master, old_domain, IOMMU_NO_PASID);
> +	}
> +
>  	/*
>  	 * The SMMU does not support enabling ATS with bypass/abort. When the
>  	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> @@ -2762,11 +2780,6 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
>  	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
>  	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
>  	 */
> -	arm_smmu_attach_remove(
> -		master,
> -		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)),
> -		IOMMU_NO_PASID);
> -
>  	arm_smmu_install_ste_for_dev(master, ste);
>  	mutex_unlock(&master->smmu->asid_lock);

This is the last bit that had the ATC invalidation sequenced wrong. I
changed this entirely to look like this, with a clear order for the
ATC invalidation after the STE is changed. This probably eliminates
the need for the wmb() as the STE change and ATC invalidate will be
sequenced by the SMMU logic. Even if the device issues another ATS
after the invalidation is sent it will be rejected by the SMMU.

	/*
	 * If the CD table is not in use we can use the provided STE, otherwise
	 * we use a cdtable STE with the provided S1DSS.
	 */
	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
		/*
		 * The SMMU does not support enabling ATS with bypass/abort.
		 * When the STE is in bypass (STE.Config[2:0] == 0b100), ATS
		 * Translation Requests and Translated transactions are denied
		 * as though ATS is disabled for the stream (STE.EATS == 0b00),
		 * causing F_BAD_ATS_TREQ and F_TRANSL_FORBIDDEN events
		 * (IHI0070Ea 5.2 Stream Table Entry).
		 */
		if (master->ats_enabled) {
			pci_disable_ats(to_pci_dev(master->dev));
			/*
			 * Ensure ATS is disabled at the endpoint before we
			 * issue the ATC invalidation via the SMMU.
			 */
			wmb();
		}
	} else {
		/*
		 * It also does not support ATS with S1DSS = bypass but we have
		 * no idea what the other PASIDs are doing so it has to be left
		 * on.
		 */
		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
					  master->ats_enabled, s1dss);
	}

	arm_smmu_install_ste_for_dev(master, ste);

	if (old_domain) {
		if (master->ats_enabled)
			arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
		arm_smmu_remove_master_domain(master, old_domain,
					      IOMMU_NO_PASID);
	}

	if (!arm_smmu_ssids_in_use(&master->cd_table
