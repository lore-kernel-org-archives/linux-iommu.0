Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5C7E5
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885952; cv=fail; b=GpM9m1gSzppi7f5Q8lgwZcfICdq9pQcWn65I3/13BTaRMOBq72kYIIbctlEj+yEp5mvHjivLb4EfBns3bsAMBCUJ2Q+GEuso35++peYr7NkNLb8QHBItzJOiiN7SkqQHTbgOWA5PJmA7CMcJpGimb3/AbB3giS1KAGetMJ70fF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885952; c=relaxed/simple;
	bh=GC9jTVWgF/83O7CgYMyMq+R/bfV/WIOWPxiG+eMV7y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VGwVU5h+7C8JEooz+morkqXdYDElRJ9hFevx4wyKsF/vqwsQhgEXbx9Quw2l3dXBzB59eOgFpzh9APXCpVQpypBG7wR/DT59JzQwEI4nPHPl0oD36vLi5fzQ7GH2+MlvEzC6OM+oPlbcYmA3HL1PacnfY7l0kca5sFIG60XFh7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tmeiE46g; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tmeiE46g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDZYSMgbIAFmrW8dZSw8yWKsbkNGwDNxtVR2VYOk/GH4LhAZUEAe496d1nAEJtaITbF0Crs/fuAGMRxu7iiyaTIKgsawFeRpbyVRG3TMa1zymwEHqy8ME3LWo8WHTbh2kQ4hxQbJyTa/C1zMbtQrT40IgToQ7oYj4smITmNEFKaDmUB3ZOa1rWRvMVt+IH2X7vu+WbkhV585Iz1HvDQ4zPm+ZScrD8X912OaysDeRqS8TCt6Wr/frIsBWiL2BFoElcgU4NT56S1PrEmxktFKOLNH/4go2a6RxeLr/5KQrDb8y5Lo5zELNJaoWaz9uqGrLWuiVM8+PJbZOH7yqGiEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vaz/QAqnKrlB0ysLRIbk5XQ274e9++F5LsRsWAMiHE=;
 b=mOEI0t0bZo6HGQfUHQ+0DZstSelCqvq9zkG5BkVXExlYTuKrRxJDeMiT+ezCAbYhSZTCKEFdAprWDfWrdNjBm8cRwb3tx5328utJI4D2t/Hg3xVGaVIiIp5QXhHMAEFjsa3ok52XGpuIFnXwzFLaKxq9UCIiRYR7brMdVJF77fV1lmOlKC/hAgJaxolZfWvD9MvvXRP5sU/L1NKElHBom7q8SOqZTMH8way4gZ1BjfC2Auc6xY9x2Myucksj82FqrQUXFYSmGX8NxLTGITWDr9dux/K0EQUditUcDqtNdukz7uppxf2nsDWLFt8cFkrlZGo9GxMDROlCojrL0gIcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vaz/QAqnKrlB0ysLRIbk5XQ274e9++F5LsRsWAMiHE=;
 b=tmeiE46gnrXEO+j/G1zsP1EjWd0SQeqAjzQTlgOTq3/SeHsMi21xFLgbFomh1F4yHWY1RGpNxQEZdEvapx1Gsm6reHGr6Fi58iRzakUw23UDW35y42RuYHx8JDTYmVgNQ4wCVoMH2jgCl/RmZk8ajZrTOg6NpqfxMsJrg4t2ftn9sLlzOrSU2m8lq5HSRBdBlIQKKNHeQxZeIQHGZ1ycQCacvITxUuUHSn9GXU0qEQ9a14OAtV58jfN/lq84YwIRcVF+7n0lH4E/YM1y+EHeVRg3DdebpIPZIwZNttsJ3fjPJBxsfHq7LSRbEHAxcYInMeG6rpYIe6fvSa+tvml08A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Fri, 2 Feb
 2024 14:59:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 14:59:07 +0000
Date: Fri, 2 Feb 2024 10:59:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20240202145907.GT1455070@nvidia.com>
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
 <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
 <20240202133557.GR1455070@nvidia.com>
 <46d7086c-36fc-4668-b95b-454e339b94c0@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d7086c-36fc-4668-b95b-454e339b94c0@moroto.mountain>
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e1f555-d6a5-47c3-79c3-08dc23ff8189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cXpInbHbgSnnIVVyl9Rt0F+XZx7Dho/2z9ut5hMxwOGBXwgtWZlLdWeYJGtsD81PNDmjaW7RGI8SItwB2Y6nsJXbr2HHXXSPCS1+6iS3lNzYaOuPdJYm5oEg6xaxfwMXtzYRU4uwGqWtsTW1x97aNkQGdyAD2WdSuVTLBHUOie3a3EOOZXg5jkyCNiHV4QjG6eS4OCSyw6QXK+6PjEnrTf7XnLOlxO0EERq+3zOELTHtNYEWwb/PR5kHyuktt4WRGpf1h6uaM39pS46p7jHUXieErBECxtyxcOBYyUencnx1WJR/on9w2k1q4Qs/lqC2LnF2pgESf4leiD/eEwvfrez1ezwGqC/CrNkeyS73Uf48StHsmh0hBwCacYvZg5mBwj6wghwc5vtZ1HK4rFhuL7OVFy/XuWMNDQ27a6ORSQ+x6sgHH8rBFUdvu2tjrHXBXWv8g7NDw9B5pqqCvYtxkP0FZ5zAixLsEg1D8oSR36YgsuslpG3xZcZd4dIxd51wMWc6q6HbxslLnV3CMCmKAtbxgRdTpS134zCft5x051oS0RD4Rp8Qe6DnSAoc5pAicbTDtim0Txd8cgzMoawxi6ycbn4r4HbbZWrtD5qKMQ8QS2MLT2tZq65xCK+uKsgq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(6506007)(38100700002)(5660300002)(36756003)(66476007)(86362001)(41300700001)(33656002)(8936002)(4326008)(54906003)(316002)(6916009)(8676002)(6486002)(66946007)(26005)(83380400001)(2906002)(4744005)(66556008)(6512007)(107886003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C85Kyq7oMILNSLQXhDdPdS1deGzZgIT4YcbnJYYlRZn4GwxpCkmw1ymiJA8h?=
 =?us-ascii?Q?bXM/LcCazMjmz9Gb20xgxpJzR/3Ur/d22YJ4HTNE8Kss0AZ82d9070zUVE9V?=
 =?us-ascii?Q?0CxS2Q9gdeULmxDZmARGFXbjPivjLoEz6J0k6GuJbPnxNyMk1+ihWXgzC2A6?=
 =?us-ascii?Q?/XNuq7l6fVYcLRpEdUnMiTL3QjHY4sFoMzXJ4fPVKBqIeJ3hAJb4REvIgfP+?=
 =?us-ascii?Q?Ocs9Luac5aqScJRb6UIEXiX5PHlR8rlSMLWhGo/xtyo9wj0g9r/uysG7fFHf?=
 =?us-ascii?Q?5zOsSi7laLzcuzzgbv4JF9GrYywkc2Z46yjyhW4Cy3T1OhvhyCEhn4GFd1D6?=
 =?us-ascii?Q?jH5iLpp5QJ+jlCVGnn7a3e84cj8a1YbgV0jsHTzjGgeQAbP/Xja1d45k//dS?=
 =?us-ascii?Q?fRJjjnaNXuZOQsfZbCg9IcB4yRhaXU4aseEzA1VMvhywLBKP/xWhXV7Fz5Z7?=
 =?us-ascii?Q?1YGIMa/prK8O17UiU1LCphFQQfPyHtTgV2z4j9r1BRufzkyTp89OiQWip4VN?=
 =?us-ascii?Q?NkfTqnZDqKYhSsYqi5Qe1F+ji/B3gf+4iRC9KzJxHFpbO907Ao8gOSC3KTFl?=
 =?us-ascii?Q?iBD5TIhRBVMJd2scYjOEJ69WjWfcM8Zy88A/y7Rt5/i/a+MUPKzhapyS142D?=
 =?us-ascii?Q?v6Xd0ILQtuVM8RusGblBUKYqAyVD9JUyx44+vfyr9Emy0qpWCP7txZLtR5l3?=
 =?us-ascii?Q?Ze30/KnEbUu/+7k4GLfgecvDmKypklaZul2jt8/GpoX6cPlnLEHX0e2Sc2oW?=
 =?us-ascii?Q?3lq1wI/xrr2OmkYiKnTI4LHwtHCHkCyvyd1fPjXMKrQSsSpoRfH1vjRQVOF3?=
 =?us-ascii?Q?uhbzkaa333fZBFRl3N8xL2bz/J+qPFh6jzoLWlQUH7Y3mSWFyBTRaRIRgIfv?=
 =?us-ascii?Q?0jYneYt0f1BRi+0W3wc5s16K/uUir1ehGTRwyCHQeFc5d4Hc4yJmUMKK+LC8?=
 =?us-ascii?Q?fbBOi1oDhAn39RYQvUXFHzB8rl0LemC0leoo6x95a+ph1X6UyUzpN0Ff1HL2?=
 =?us-ascii?Q?3yBzIaJXoeYTF9FFzz4tRFXmXDDmklR4K2RgPKtbMPPq0zEWfmBp/pTCjBTQ?=
 =?us-ascii?Q?9zKt/yhhg/q8B9pB0mvW3RulklSeB1h0ix2lPiERZQEJVw3Tia32X18wK3tH?=
 =?us-ascii?Q?9X45I92jW39i70sAf71unrcCDWC8if2TddNtWia4ipUg+0ER3EDeVILq7CEz?=
 =?us-ascii?Q?7ululrimQNG3oWPnr1rcjefEyAJvLkdbDxLg9yIvUDEqIxVNIz58+H4SU8A+?=
 =?us-ascii?Q?EJdS1HlqJCeOACv8Nt3wHz/4lraGsGs1fi/6mmsW6jLKw3eeDV+vYPVuVD3H?=
 =?us-ascii?Q?ORE9MqMUt8PG2lzYPV6CIOcQqn7xMRP2H2iN6H8/NJcF/IoMV/nAyZrj3Xc+?=
 =?us-ascii?Q?c4tDcQ5z7coy11Ou2XoI357XFSz/9Equ5BizjA8K7JdUXWHgaDhaabtS8GtK?=
 =?us-ascii?Q?aoOGmLc0g3LjhSTS+z+5vDg6L8sHoluCftSF4yPuouW1LvySFTAJxFy1S3B0?=
 =?us-ascii?Q?Vlsz8Hdd7JH2E/vi410UfOHENQ5+Nbe0IYInP04xn+VPJ38mpRi0H7cz6xti?=
 =?us-ascii?Q?3OpHPR+xScxZfrpY/LI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e1f555-d6a5-47c3-79c3-08dc23ff8189
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:59:07.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jrYX9Dui0fPY3SShyl7SzR4D27Sw5PfwcMg2n7Exmqz5Jtt4t2yzjBzFNc4tGm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

On Fri, Feb 02, 2024 at 05:45:43PM +0300, Dan Carpenter wrote:
> On Fri, Feb 02, 2024 at 09:35:57AM -0400, Jason Gunthorpe wrote:
> > It won't silence Dan's warning warning but it will correct the bug for
> > now.
> 
> I could just modify the database to say that
> arm_smmu_update_ctx_desc_devices() doesn't call arm_smmu_write_ctx_desc()
> with preempt disabled.  I don't think it will silence any true
> positives.  That's a one liner for me.

But it does and it found this bug :)

After my series we have things like this:

		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
		if (WARN_ON(!cdptr))
			continue;

Which indicates the paths that expect to have been pre-allocated. We
could also have a no_alloc parameter to really make the checker happy?

Jason
