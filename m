Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57751156864
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365829; cv=fail; b=tF0o9qHJdVHkwDv4vltzJbPyrm7O6/rWUCc2AVeDmvOb9vBBo95Muyp6krASKKa64ZuImNYmlyscW1Na/JARNH7irGmtySRSshRsbrNwgHE9AwTEqAgj6af3nKIPbTopL6r3WmyjDZLDk1XwGFCWFb8x+VlCVrCcC+LqZpoxayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365829; c=relaxed/simple;
	bh=GZXoQ1Rk25aGtsYtcidCMlGse/Q+Y1oYoqZimoT2okM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktIZGZJHrqClkZmiMMVNab2YjzHefS+Lj3SzijfAYgKchrBbm3XrO/2mbX2TbuH4szrL/5QlW/0SDqStAYQNJs18ikUQV0MkAFh9gMy0aAmL/dZBHD58JnymP49p+b56tdqKqgYvDkCfXOayz5LuRdb/lQCGY6lu3G5Xkl79paU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lra2u0EN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aZU0HjPB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lra2u0EN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aZU0HjPB"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFibkO015203;
	Thu, 26 Sep 2024 15:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nEHTSvT3EbUZ7ie9ZeBIP07X1QykNo+uG+w2S1axDRc=; b=
	Lra2u0EN/4iv0gmdbS7pDJ4zc7PEoiE58j7fvLDE1/ODIyZYcPm9vYWOLxbcUF8P
	TtgDssjGcYazWC4BeHJTQHREHP2364Dkd/LHvJXWcQTwLC6vWc0eAj7q2z1hDyTH
	giKVGyXB+94uY6fomoqLB1dOFxoIWPSkWofOxVbCLIkbKAcwNpGA4H9/z+opueV0
	F4QVpwTER6RGu/jNNwYSeUXMIF8QexJaQE8Oq1NdWM59a5O/aRCQNgiSy2Ei3r69
	5HHS14h9g1vMmQuV7BXJ2qhVguywyRItsPqbTsj9VWf6Qzcsk+JAzQxALbq5HoSd
	X2ZReV1J1aavwxEfLqQ24g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjdaxe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:50:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFK9Ub009839;
	Thu, 26 Sep 2024 15:50:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkc1snu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drefiM4KQzlBlS1ykr/pqRiKtzmBOXhZZGvWOFQz7GuU8Doz8oj+c/EcZ5q+xlftXE9RLRj4d7X0ZpZbuu5YAFiXBaWpk0zvgjZdJhR4bniyVlx+9K0JGOyadrImdbOqtDYxMeUOOsFPYLI7Cpm/14Q9v8NsYZkeB3S0drnAKT3begRbuFQCNvHoKDHaN8FY+LIBsyB2iN1idaXMyb4FnqzH+IJcS6BklgVPvYh65jgkLXMmmgMUmI1l7r3pYqGdCKx2KTYPecP6GAGPBXgrWhDxVxaqlzuC/jYKjCYrnIHifDhKQTTO26lpR2cqH63QvJZ/seSOSlF6F1DyNmibGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEHTSvT3EbUZ7ie9ZeBIP07X1QykNo+uG+w2S1axDRc=;
 b=ykIXwZRdHSG0zarOTUMlMnuW9cfApfFBU0i6ZYJe16y3Wq+IXapsTDeVCzLNsIuM7dyi3nBQmm2jFHyhxDk/IyLVvJJ4nd3Nh8W9hqcmYpAYWZOuIWgRYhkrxckP4dHkXHzDpVwn74hS7ccNRJqSVCb+OWoXIA4/3L/ZCAva+bxzXsMOP+Wtj0qphadMN5lvK2aTCS1y1RK+wt+4I7cEWOZW3i5AmZxL0UPq1domV7e63D3IWPgmZ8DxCcKa8crq+oXWfVXIbb6ary9YqEm87RRCjeKQqrPa2Vym/Z+/j3vPU5Tajq+fCx5EPu2T4NLTj2BPUGelL2P/wPfbzWxSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEHTSvT3EbUZ7ie9ZeBIP07X1QykNo+uG+w2S1axDRc=;
 b=aZU0HjPBLio8TcCTjXJtV/jZV5N5km+HAH6Wwc5qEwyjSf1eXtW1cNtH1f1glBC2a76Pm8fIObALqzd3cgpb2Tm2k00IFGpNb8Y+N5+vi6xrnFGdRq6Tusr/M1+tfysvbJ0oIgVVxUImzKZ9ESR6GM6bcDlux0ANfNeuPT6VrVM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 15:50:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 15:50:21 +0000
Message-ID: <711cada4-3703-42af-8499-6d9db1351848@oracle.com>
Date: Thu, 26 Sep 2024 11:50:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
 <ZvMqMcJkWj0Qfaef@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZvMqMcJkWj0Qfaef@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fec184-7154-4731-781d-08dcde42ed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkkreUI2UmgzZk90dkhwclF6YjltczQvOVlTZ3pPNmlkcjlTYThxWXBOeXJt?=
 =?utf-8?B?dEY5d0wrdHNYTzhtRmoybUlrcEh0b2dSNmdxUk0wSGlNN3BPTDlkWXpiemlt?=
 =?utf-8?B?REtFVGpJT0V5WVM0dHV1b1Z1S3BJS0U2YTRZbHR4YWU4WmtQdU5lejBwcW1h?=
 =?utf-8?B?SjRmTDhjbHN3Rjg1RTMzdlBuL2NUR3JZeEZ6RVhEYkMrWERhdjhIdk5CZzUr?=
 =?utf-8?B?N2pkV1lCRmk0VGt0NXRpZzQzVjFTTmFFYkpGL3h4T2JVM1hTdldQb2FXTjNT?=
 =?utf-8?B?cjhwTTNWdTFkc0ZIWXcyT1AyNnI5UVR0OXV1dUN0T0lSVTV1Z3JYT2NJajRQ?=
 =?utf-8?B?dVRpUjZVSWNiTzV6eEpveGZuUVlEOUNjc3krVWlUckpOQmpnb1ExUTIrZWhE?=
 =?utf-8?B?MGNTMUU1eFVOb0dUWkZnYVU2ZU1SVk16d2FlREEzQ2dCL2NzVm1vWTFaa2Mz?=
 =?utf-8?B?NGliQjBxc29vaCtQaWtUSjRXRTZZcytyZFh0YlZ0SzhodGNKZ0RyU1BNdVFC?=
 =?utf-8?B?Q0R1dzVkUVRzYlZZR2gzOCt1YzUxTVFkcFdNR1M2TGY1c3RnVlMveENHZ1Ba?=
 =?utf-8?B?MGRKa0ZXSGRzekwzV2ZWV1JqQkVJQWM0T2RXQlNVTndTbkFLZ1c4Ky8vSjNB?=
 =?utf-8?B?U1VsOW56dWd3TktKZ3N0UjJnZ1pGNkx6Vjh1ZndORFZXOUFZVUExN21WR2Fl?=
 =?utf-8?B?TklCQ21kZVc4UCtqb0hDWGpLenN3Z1Z2RXNabXdGd1lLVElsK0hRR2N5bkpw?=
 =?utf-8?B?ZFVuOU5hd1B1d0FubFRJb09CbDhWVWRqT25WLzNLRFdHc01RUTFoa2Z1WDVk?=
 =?utf-8?B?c2FNUWdSZklVWnlXOTRqVHZicnBpUWZ6a3NHNW5PVnZOa3VacE8rTFRCNlQr?=
 =?utf-8?B?bzRuT1FmMHF3dmJGYlQ2TDBKemRxTDdNbEx4aVhIemlIc1BqcVFZRjRHb2tw?=
 =?utf-8?B?WGdZb2krL2VrTG9YU2pTK0E2YTdHbXc0VERyVnVOdEI0WTFsNVU1VDRVUVVi?=
 =?utf-8?B?WE8zV21pTFhHZmpvZ2Y1NzN3VzFFTWZuOWh2QVVaQ2NYdUxVMGxOYkV4dFBV?=
 =?utf-8?B?MDMrOUhoMkxOVzNxSHVSV1N3SHh1ZGoyQTFLQ3I3Yk90cllaTkRlVkVYOUxI?=
 =?utf-8?B?Q25heVBjZ0g3ZWRVcVloOTBYMkZUOEIwa0RvQjdUc0Q4VGRDRmdkdUY5dUZF?=
 =?utf-8?B?dElnRlhmVjh2ZThpODl6bkJlY1JFKzNUMXZzZFhRRUpjd2VNYjV6MldKYjgv?=
 =?utf-8?B?cVcvWUJWVlRTZ1dMWlgvdzJjcXBTY0Y4b2JTQ3c4RXJEREZPd2g3R2JCL2VB?=
 =?utf-8?B?Q0dQVkRiN3U2RFpmUTNZQXBVZU43Zzc3UHppRXpNUzZzWDc0NnpMS0hTTVpy?=
 =?utf-8?B?WE9JUjJKR3IwdUliaEw0NTRJWC9KdTJ6cmJJSFdKYUdCckdzbHRrckVwbHNr?=
 =?utf-8?B?VThKZjlsVXhkQjlzTXVaVDFWNmR1YjhMa05SY09xYVFPVmEvUEdlQTRHT1V5?=
 =?utf-8?B?bmdYZW9nTmQ3MTdDUkUzWjJvWTlPM1d1dC9KTTdVSTJNc0NOZytWeTNKZllX?=
 =?utf-8?B?VVkzaWJjVjA1SkJjK0UvVlozVmVNWWtJbm96dThNd3hxbnU2akZQREVZcjU3?=
 =?utf-8?B?STY1ajlHWFRwbDgrVVJFSjNPMGxFS3hVa2R6eE9XNmhEWHhBUG0yMmFxNER4?=
 =?utf-8?B?RWtsSE1oRUVmWldCNjZka2hud2EvUjlnVkhmWTBQZ0o1ZzZ1UUFRcFM3dnB5?=
 =?utf-8?B?YkhXQ0NTTnlLNE5WWWhSUTRiZ1JoeHBCK3ZpZ2xQTUdEMk5lRnc4bE5paTJZ?=
 =?utf-8?B?V3pwL2FmZVpVdkcwZEpiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnhEc2w4dnpFa2g0bFVjYmZhUm90YktWekdsTWZ5TmVocnpvcEVueG82OG9v?=
 =?utf-8?B?cVVmU1RROFdCK215ajhFMjUwaDNuWTdHOG5obGlpUlEvM0pmM0NCblkrUUFQ?=
 =?utf-8?B?UU96cU9nVy9ud2xmb24vRjY2M0w0TEg5bllsYWxMekZldUd1RHBURmNCY3RC?=
 =?utf-8?B?RlE1cEp1VmhGbzdsTGFsZXIvMVhZbkEwSkV0S2ZMdnQ2NWlzRU9EUEF6MGxz?=
 =?utf-8?B?cUhQRDQ4WmxGLzVoUnV4emZwWjd1NFZLUDRMNmJWb0NHb05aVXUvTHZEei92?=
 =?utf-8?B?LzVRbHVXcVpsdGpqQWdIYkgwQmRtTzdoQWN4UmNYNHkrZFFkNS9iMitaTWxj?=
 =?utf-8?B?ZHpuMEo0dlBrOFRVZDF1cmJqdURoZHp1S0pKRFBVS1JPYndxWG0zMzNBNzFm?=
 =?utf-8?B?TGNWZkxCMEJaUXkwWVRyMWZNeld1M2ZQdEdUUGdQODJIWlVMcHVYQ3h6dUZi?=
 =?utf-8?B?a1h6T001Zm5VUi9rcURhZWQrUnhBZHZ4cnJyZkYwRVgzK24xV0NLYXQ1Ukpo?=
 =?utf-8?B?QWFCL3RDSlJKV3pVWUxMbXRUNno0a3JMSmhxTHlxMzVNVTFsZXBtQ3R4QVJK?=
 =?utf-8?B?cFRjRHRRdUJKTnlJKzFib093K3h1UEtyTTk1TTJNcTh3d3o3VUtUZUlYTS9W?=
 =?utf-8?B?ZWRUSW1ZdGQwekV0RzgvdHVLQXdKVVFTRWh0Y0dORWVUMk4rTDdpUEJlblFt?=
 =?utf-8?B?OXJSeEVENHl4M200d2pMUG5sdlFGM2JnYTdpRHErWXlIaTViWkhSK25abXdY?=
 =?utf-8?B?SVJxQ1g0eHBWN3NQaThsMzlBOFpyU1BFRmRMenMzVnM0blg3c0xTT3dWN0Vs?=
 =?utf-8?B?ZUtSZC9qVWVsMVFVa3kwMDFpOXVTaTlTejlsVVo2eEt6Tzlya2xuTlhWM1NT?=
 =?utf-8?B?NlpxcjFBbkFaeENqWUs5alNTWHBNVTNadXBteXlaRkdoOEtCWmZ4OEhJTTYy?=
 =?utf-8?B?c09UdXlIcldqK0czNk9LMzQ2V0ptWisvVlRNbE5iWXAzcWhTWkpIYmtpMXNw?=
 =?utf-8?B?NG9WaTU5SGFNMjROVmNOeVZzWEQxQ1lBd05IMWFoZnI4Z1dNYnRwQjhmd2Y0?=
 =?utf-8?B?Y0lwZ085dXA1YXZhc3hETHJDMU1lQ3VEZEtOZlRGaUM1WkxRQ01EazNRYVBW?=
 =?utf-8?B?dWtzcmZIMFkrR2FnTkpvUzFJQUZkTEsvcFFwWnJTTStZV0lZRlZJN0RKRDJX?=
 =?utf-8?B?L2tLdFNJbXhJZzhaTE50NXhrVFIzN1d4bzNwY1lVKzlQSyt3SnY5RGpVMmFT?=
 =?utf-8?B?OVNkVm5mR1pxazhQMDBnaGRoYThNUWo4empsbXR1eSt1Q2grbVhlV2RocEk0?=
 =?utf-8?B?MitvdGVEdHFWcVNWR3ZzNFFFTVdFcVd0THdiK3VNVWJjMC9zMnVlOVdFM0lX?=
 =?utf-8?B?VVNkakQwbyt0VE9wQmpkalZTbEZpcUZnWUpXL00xeHhLUFpEWkw2bTdkMUZS?=
 =?utf-8?B?MUxNR3V2RGd2SENGVmQ3YXFqenJCRjBSREp3N1Fnb2x2TThEOHBLU0E4S2sw?=
 =?utf-8?B?eGxadU1uMm5FWWVsT0hFd1YrL082bzhER2MwNVpSN25jTkJYSVV0eVcwVHcr?=
 =?utf-8?B?VmFXbzgzZ3k3MEJtTSs3NURBL1JzS1ZuS1haclFOVFZzOE9EL21BQTl3UlZm?=
 =?utf-8?B?ZGRSNWhtNWlhMXAyVWZEWndQQ1FNN2pYSVQ0OVlncE03YlVDSmNCWHVXTnRk?=
 =?utf-8?B?NDhiT3g3Ty8wbXNMQ2FLZnZNaGVtUmFURkVFZ1I0eXAzWGluSG9UbVFxOGll?=
 =?utf-8?B?U2xPeFVpSnBRVVd6ZWxjRUxPMm53bS9CY0Exazg2WDl4LzVTamtuTmc0UXlP?=
 =?utf-8?B?ZWZBR09hSUpkeVdqV3lNTlVzUVIxd1Z1TkN0QUVZWHlkcCt3M01NNWpkSlZH?=
 =?utf-8?B?SUxtb3hFdFZvMlk3SG5TRGJGa2xObnNiQTlyTnEyRXdISXBlT0h3cmxJSWw5?=
 =?utf-8?B?M056L2s3ZEk3Y0hBSEgrR3JOYnVWTGprcFRtWFA0R09zME5Ob0JnU2NWVGVL?=
 =?utf-8?B?a0VQWTVwWHVCdmxjZ1hLMDM0TkdhVDdFRU9LclJXQjllbUZkbzRDSlVZaFdE?=
 =?utf-8?B?QXMyZlJUYTRLeVdvZUxmaFkrZXZXcThEVXlrK0s5NVVVa0kxV1p4Vks5cUhQ?=
 =?utf-8?B?aGsyTE9VUHdURDlzeFk1K0ZRMFZxaERNTU44Qm9wcmt6U2pSK1ZOcDRlUnlL?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3dgu/o/cZGkshtx1XSO4oyiGQtyfKMu2ujiXtQzbh/GvLmwSfDhO2897z8ENO7bbccz4HpCFfmpyNoPmaChzYZARB9BcFah1AsLkoFLcWFgsVLxLCwDOVwSEHuO5+hGhv10eTqQ8GBvLyI2+o9gaisU3geGEXCuuWe/gztHd/pD9cpq1CLHfulzI769fuIOv1gt75qWDbZy3nqxvzAUSt143Z7BkBpjgpLjVx0BnrUx0GB+D4wlvLuWYwE7D4a6rkzww5OYXGhLBzVACCk8QlDEdhz37AsuLNhOAnRgOthw3V6JrYpCPfUL1VY30ORslot3ypRNVPS4M+AtZdXFCvayxbPd+SVneHYxEOYFLlIMUgXUVT6mXxmF9NRWAxIVfF40unTK943gHLmWzKnbZbR9Kj4d3FzQLHNXHXCR8Yh2o8dr3qLGBJv0J+q/2SDZfu7TnMREdi21Rug/uc4N/8p1Qwd9dMhBXek1x0XvFMyACHV7oZWpfFhpGBHjK1zppKSbxYAqjTg/Avx9QRyOICHN2sHLTU+UF6uwvvoiThwvPCMjQ1S1gygth4tYQLnGXC9bflOqWip6NI9DJKC1X6Y7OaE6vjWl4Fg3Po2jFzMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fec184-7154-4731-781d-08dcde42ed3b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 15:50:21.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjHixCdzgyF6IC1EEZNCMr3GIykVACdjjrw/Uyee1EIbEeBoWK/fj6yf0dQwoH73/JLOc34TGzIkXBjiDlMm0F3oh5LQg+enD4tem9lsSqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260109
X-Proofpoint-ORIG-GUID: DcwMpSayTZwmJUZ9GItvqm-aXt-ckwxo
X-Proofpoint-GUID: DcwMpSayTZwmJUZ9GItvqm-aXt-ckwxo

On 9/24/2024 5:08 PM, Nicolin Chen wrote:
> On Tue, Sep 24, 2024 at 08:05:34AM -0700, Steve Sistare wrote:
>> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
>> index a0a66f1..1e14a0f 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.c
>> +++ b/drivers/iommu/iommufd/io_pagetable.c
>> @@ -259,7 +259,10 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
>>                  /* Use the first entry to guess the ideal IOVA alignment */
>>                  elm = list_first_entry(pages_list, struct iopt_pages_list,
>>                                         next);
>> -               start = elm->start_byte + (uintptr_t)elm->pages->uptr;
>> +               if (elm->pages->type == IOPT_ADDRESS_FILE)
>> +                       start = elm->start_byte + elm->pages->start;
>> +               else
>> +                       start = elm->start_byte + (uintptr_t)elm->pages->uptr;
> 
> 	switch (elm->pages->type) {
> 	case IOPT_ADDRESS_USER: ...
> 	case IOPT_ADDRESS_FILE: ...
> 	}
> 
> Would make it easier for us to add other types.

OK - steve

>   
>> +/**
>> + * iopt_map_file_pages() - Like iopt_map_user_pages, but map a file.
> 
> Could we just write "Map a user FILE to an..."? It's not that long :)
> 
>>   int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>>   {
> [...]
>> +       rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova,
>> +                                file, cmd->start,
>> +                                cmd->length,
> 
> We could merge cmd->length to the previous line.
> 
> Thanks
> Nicolin

