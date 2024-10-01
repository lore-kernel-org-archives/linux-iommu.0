Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431319C56F
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816717; cv=fail; b=oJ3KV4n+lnrAUUKzkzsWpQ7KAY68qFuwjnYI53nqpYzZib0mK8P3MMRFFf9dnJsS/hCqPc4XFKi9H6A7rJw3H8LQpJcFtmwsgcNL8o6ZlAsUKDb+qFNTRkxRyv2gFpo7KAO1NMwMTUe1VOu2mHWkY0fVBLa2Zp+RUws5IJj2xsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816717; c=relaxed/simple;
	bh=UJKV9YqEwCzrqXioPPE8Qe9h0DX98DqvU7ETX8TomcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JxHegi7Is+LsfJjoDnLuFMDMRRX5y6cWxisVKqQahgPtbr+xJ6yunpbLQHbDBUQ0OaIV5vNNJVWzhM7FZDG5yH8+J79TLQtbilBMghyfA3t5wx4fox/moXBvzFHa2DKCqsHqhnFe9LHTSeFld1EVwbYUoBZF/KWAYYLftcnBHrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=od6DpNrL; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="od6DpNrL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqQ6r80QyMhcPY2m9vuh9PSOYVb/1xOmEQC5iLV8qHTN8Mkp1Ru2J5raLD7J7mF0ncVTNV3+tJeHRoP1Nb7Yl/0HOv/Xs6cRnjUVJp+tvvUtl1XovEXq/j3S1m198vTTzTXVBkCOLiwf9N68V15nBTYllt4BjbMsmIXE6+UGH37kvdngGbgwX/9dmtvrVgvEM+N7NPd+3TmQ4V7STa4k6eDCJR1zf8KLEi+4Sj6LLR2W/V5D8o6YsZT6rJBM7CKKkJCayMndpcFVhwdjrK5BpAD1lzQUaUwLcC3tVvAwbly6xdOnaU7e2euuYYiZZb8RG6+HvGczzfvktF9oorv1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NlriCQ6GrWDf7kInGLwYMQBS6O0fLTKWcASI/VuppM=;
 b=CvzBaNPrBXa/c8jEeYnrO8cDdHoQXDMa2YUBXEW7aXEy4yI7XTBxrh9osXm/rz75yGNygjZaLApHCb5+FUcaS6Gkb2JuxGZ+DkNmDUibwOTo78ARChwM3fW6eZ/aaYyCf220Tx5+59KI4kdCT6QKqG4pQ5NU4Tu5+Y+/BxLmg+2EK3dxeKLPl0JDEN7nGCXB3q4vea4ID5v9k4U6LuarYvXDwdPddaDlH9ail3MS8UgcOs0ZIXrogQNf0jjBGWXlB+pMAGuFzbCuNqa3XGbbBFO1p05jzygoo+7bogg/yBl93CexsZHLneT7aQXX2dhYoA3J1Y45BKnHS+FcqCcg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NlriCQ6GrWDf7kInGLwYMQBS6O0fLTKWcASI/VuppM=;
 b=od6DpNrL5VpAPmnt0fehwQ0c54yI0+Lr8ymqco/1DkRJhxS98XJVlrVRXo0JP3781BzouKFWfTdn2rcFtcm4L5i6fEHudbLANp8YqS+xampIVYIjYdc3xb104ImzdPt0ueZHIhynorU97bbExaZQA93NqPoYPcE2+4OjcKZ0bwnhDizQxJIMSJvcuqAqO55WZb49PzFgxy4yCKJqceNjfafEIjrIfKboVMliL7HT12ThzLUybTZMu8nuUOINZYratu2PxcJSeBCw/doGBwXbpnyFIcmeh/e4fqlaxqwEA1nVXvtyxtOO/smMdc+YY0WAw2NOqLitdYsnsZOY7MmrZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 21:05:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 21:05:12 +0000
Date: Tue, 1 Oct 2024 18:05:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 9/9] iommufd: map file selftest
Message-ID: <20241001210511.GP1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-10-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be53214-1447-490c-da29-08dce25cbda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se84rxTCNnGJSU11zKtaowyzpzNhF40w5uj+73yYvne9AUGbJZ4vYCCTS+g5?=
 =?us-ascii?Q?iQX4d0AkSlHXrdIidgcx3zclPVKEolBETZQxBs5yQfBRo60daAsPMc0Si8Pg?=
 =?us-ascii?Q?xDdB/zgWGX4UPEk3Ex1QszAjO6fJ82AghGoC00ppRuEJElRBRq93gpiRg0hY?=
 =?us-ascii?Q?wv2f5uQn/emT3Z+9o/gVNX3u5R/oD7O0mK9mixAXJciUwaesrBlOSedDn+mw?=
 =?us-ascii?Q?NJMksnfZ58WIMgn000E8c9qS7BKOD+4ZWlcH6sxMoYaLIVfx8+UXsQpvujCt?=
 =?us-ascii?Q?q3mod1f4X2vGqRG0lbr6TFQEsyC2fgegwZn74Z1HaFD9WPhCYRUSfZdqdOOc?=
 =?us-ascii?Q?Gva2pwXtHFn9suT+8nKx7pRwf4161/oWL3qSEFNPog5qh1WMelosoBqBxjGO?=
 =?us-ascii?Q?Qm96lRqm+aPUqQJ4O13Cd8Rg4C4j2qACIW2O2HGF4/QPYKzBodPatyXe0EUv?=
 =?us-ascii?Q?xF/IRrS/dQw0DkwJsTxWFS4XjeMXbsInFIvLpqfIj+H/qX6F8Hvk3WWUc/+d?=
 =?us-ascii?Q?Ab03BhQuDhN19/SsNLlhA9vv15Ro4W2aGQr6RVe9hqJWYe/yokvOtcr4QfNs?=
 =?us-ascii?Q?rqd4KXCqMqD9SGk51NvQxDTfClDzHslsc3fweX2ND/EqpJ/HodiINdUm0DOm?=
 =?us-ascii?Q?q51n0Ifm00ogNgE4jCtdIJo1YYYjepnyQ2kRkiZuvC0nQ15AKR8G+zRl4qlp?=
 =?us-ascii?Q?iGHaaBJkxsWaz9w0bNi1Yl0p3SHT0wwhWh6IIulxstqat0FYpqepMJidIARx?=
 =?us-ascii?Q?h211Q0GGJ1SWinPGSuwUP8WJmH8Sn78Etvy4RDr1Cuo0pIReib2Uc6ROxzvX?=
 =?us-ascii?Q?29LefcV4Iza3G1yGENvKiYIpfH0+Qj5zk1u12k4Q3gh0AqzRZqE8MSd0CBKu?=
 =?us-ascii?Q?ygmi0Swac9/dMwWN1jRxXEvpkIINMEDjKENnZ7NNrZRgmgqWlnmQ0bZweqEu?=
 =?us-ascii?Q?f4v8G/i5nX75gdwLQSBMi7qjqnKif5d15yx/u5JR0D3Bs6FZIP1mO/TUp0hu?=
 =?us-ascii?Q?4mWmclrwpvrafgDT/0l9zBysvpallPxW8zQoKqPYfL5Q/DrIGFWavRtijYr+?=
 =?us-ascii?Q?/gaNhJpA2EnZIhFqC9oCzDdmYwg7T7sSBXju3WGopreXzSHdSJzDbnUHlj7w?=
 =?us-ascii?Q?sgU76Van6D4oU+AFrwwLwxQizQZKoIj1FKCOMQ9FHjfHH+7fgcoIsBJBQP0j?=
 =?us-ascii?Q?sXy5cMYISYTAM8DD0kzHBL6ANM2yVbGJEN5K/qxZJnbydR7JkZ4iwZyJ7zUX?=
 =?us-ascii?Q?rCAhrwvl9WAlMDrbLNt/gZN2vBJ/HpKErA5QEXsd0ZaGnThgBNS9B9z/3Wb/?=
 =?us-ascii?Q?8v5ww2W5Cl8Fy6uZUg/dRHySc0rHca9qUUXU/1d93Ywvhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18N/7jFmqNtMmW2qA6Ng9rgBtWbvq6Ynd61EYAbI6qUAKtvlPAHuUj18Kyt1?=
 =?us-ascii?Q?EI7Ls32fRH/hnH6zPOABQVyLVnfSqZHnrZ8x6EKW6ArpILENiT/hoYefihoE?=
 =?us-ascii?Q?5oH2rZZJzcx7+M37LExnoGbVzkWv2CkHzr9Ufob4rttFmfgUxu/s/v6JSH+j?=
 =?us-ascii?Q?u8d4mmVvYxN26+3W69NprhS7c+vxNGi2e7PxcurQWm3qa2jWkTKRTgIAlYzr?=
 =?us-ascii?Q?xU8QmsN0TPhVRDuo20elcBRYqlj5CUQrNtT9v40v0FG226FzdfrwGpWLTo2f?=
 =?us-ascii?Q?tIdxxROuqGFs6stdqlQ15EFn8it9eG2+2xE7GDT+0VKuhnaVaW/NDbP7cpTp?=
 =?us-ascii?Q?sqmhuITeaiQHW1mGxCIyKxRmBLopyRPp8B9W99hVgEp0nB6opnC021M7mS23?=
 =?us-ascii?Q?nXxTRZ7KBsuvmY4o0HthKAFJS9rV5OPkmLTyXgZWkiU75jOQrlPKt7v04AMi?=
 =?us-ascii?Q?JskgdMAdtl/3Pmf/kb89ffwiOHCqXBLzyTtkUdUuzKG12NO2uXCj9FIB34uA?=
 =?us-ascii?Q?MZBQV0aOk0XRdW6TM2/nDg6vB5XO2+LSclzrIqEYgu5eTqLFRKPhFFVFIcSV?=
 =?us-ascii?Q?GuKoUHrVD1RT7IlrhPHuiqyO6aoJwKlq1LufGAUTfTSmZa78zTBGVm8avfNI?=
 =?us-ascii?Q?ls74WXO5XP/MyJ6UQV91mnKCsP5Sj207EpinO9ljvdCnRn1ckp/XGvbXtTBr?=
 =?us-ascii?Q?fCqIBRdmjuD2BuHR2kL0tXXuLnZAacFbbesCIRZOhFH9MQTsXCr/sKNNQB8h?=
 =?us-ascii?Q?0FMVSd6QQDiOY7cG0y+eFGaRZE7sYAXHlKeeMbDS2EhxH0vWJkD2bUDy1UzV?=
 =?us-ascii?Q?sHkBXsKYfX3wHVV7FjVk6b1WnYr4rZOWNEHFIFf5592/uW8faHJuBu32g/mQ?=
 =?us-ascii?Q?EIFJC03wLIXlKx1V5rSbrbKNnbS5F4GvbZfuNkmvPktiS9KCUq3Ryl1uvgjz?=
 =?us-ascii?Q?cWiVVTDIc7T6Ugl5jX7hjzCMoAqTKZc/x8V3B59PDgROwOCaSHVeisysK3Mu?=
 =?us-ascii?Q?JflPxHsA+Y0dMM9IPrD2P+paplBpYq1vSzw1TBSCQzjTPWlaW7vEhNj5P7Y4?=
 =?us-ascii?Q?gblP/DQQnQwXwOneYokt4DAAI15OkKXp8iDI1L7PSjqaxnLE4UR1dP64zDTE?=
 =?us-ascii?Q?aWEmbM5hnlThV8uzYQMN9tDj8mWkqV+E01u/aFIXhz4eKy+SUMZG2ixnj0sd?=
 =?us-ascii?Q?VR0EDdbmMZf0HOEF4r8ygMBRf9XFkvQW+SWkjjgnK3JXK0v52a5jovmSgxpz?=
 =?us-ascii?Q?Gt1ACAx6wSoIVP7edmeOq2974vbmRdUsbAJXuT1zZnHlP+Sm5gqaEv0mJytY?=
 =?us-ascii?Q?6kb0ygA9+bTCdcqvbde2vlWqvfqABYz2H9LkEO+xs1j+oBxT6vP3dsdURfV+?=
 =?us-ascii?Q?ywus1L4qE0vMlRxVY7FuVCb15zylNrzyWvQSbNKDCr0M6ZMDBtMF25m3fXId?=
 =?us-ascii?Q?H+LBBUpTIlZGfF8zXAVoMiiKAg3Jnf0Nq3+VmaZnvV0M4mAI/EYyQWPEPZar?=
 =?us-ascii?Q?5JRLQOU9LfirCVfIlnr4439QEPvJsrzR3dwC3bHI+kJ7dNlaFkhBvcmsN9c2?=
 =?us-ascii?Q?aGyBY/v62E/vJKkM17g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be53214-1447-490c-da29-08dce25cbda5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 21:05:12.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4us0PUFLnpDHdFnyrZoPRKuBJAFCDfM0jmZJBzpDW8ICNmabuodkuVFJDtyC+V6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

On Tue, Sep 24, 2024 at 08:05:38AM -0700, Steve Sistare wrote:
> @@ -33,6 +37,24 @@ static unsigned long get_huge_page_size(void)
>  	return strtoul(buf, NULL, 10);
>  }
>  
> +static int memfd_create(const char *name, unsigned int flags)
> +{
> +	return syscall(__NR_memfd_create, name, flags);
> +}

I think we should just use the glibc definition, or is that an issue?

Jason
