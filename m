Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC4101CA
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:54:03 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBPbtP008553;
	Tue, 20 Jun 2023 14:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=toQbOdMZvOeCmavOo8zoznqd+PH/51Z9Wkn5Mj0MbTE=;
 b=yyzkEtqM57dghl+2Q4kOUzL2I+We2PtZjdvlnzvUz+stdIsPbKZnJpbVt/5rGBmcOmu5
 w48jSDZXKed+pMNR9qJ8FD171/f1d9AkufsH8NyVDX2y/ncmbjKwr2CtmU3gM9iV4E16
 cE/CEnsitiDthoZvulwUXRvIqN/a3UyHkeF85RJPyWQdQz/VNDfgPd/u/oVbZhNcSKyW
 Kqo455ePkUWSChTSJgVblOCXQTE6OwtglQoezJ769v4sFiLUpCvoSYWhJdEmrbzRUh38
 hMG+CjIw7jryLEq6sR41xVB7tqkNiokPxcEA+RVm3mtw+ThRbTswhu3cNHkBZbOkzyVn 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3n131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 14:53:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KECoXi008320;
	Tue, 20 Jun 2023 14:53:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394ysyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 14:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjnFDhaOz7Z6yIq6SdQKjFsgxQ/06hr1b52J32ds8CUUT1wQMVSfbPeprBlGT/zpkhQq1l0Q0w/o+3uit/CJfvhJZqhSFGyat0IKU/hMQatLWQljadyCZplnuozipmzgws0Exbpz0YihjHwmO+KntWR/KPR1987JcJiAHIXVVDnVJLtyudfshND0xqRV59s0CP1HirPI0dOXKDbSBdDmZD7y0zWjyiQtI90wJbF0ITI7YXJKfWm/lJRDqj19RnaznAwqWNNSCX2fkIvr8EId/KCC+JEcA9Hb3mjnHOMxbacs93TAMqFwc1hZ53MbxUdw+etmNjlKz619ZiFHSzE7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toQbOdMZvOeCmavOo8zoznqd+PH/51Z9Wkn5Mj0MbTE=;
 b=SqlMo5qLnKxIM8w0da1Fl/3mYdr1SDRZ8bwaQcnirSwDqSNJ9q8W6RzhVKgbjRb2AF3/pv6o/Zpk+4kdy53nnuOfQX4VKyLm0frYB+1quWWGKlKOw+WJiduaoVc8OdZIxQ/YzI1fhqItk0iHhSLM8z6H8P7kygQsEfOvpIHM4UvneYJmumhPsAUiUs2w5GSc3aXl+lwe0/j/0arKejA+Fvw/hpBmSBSELHvmf0YrF2zXuJ4/UBFLennzx13Eg7h55tlFcOQsTdbD14DrVykURYsTVMhPx/e+6tGDpdPxob93wrVBQhppdwPJ0M6tkO3ZOTVpdjydEs/C9CZJnMTSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toQbOdMZvOeCmavOo8zoznqd+PH/51Z9Wkn5Mj0MbTE=;
 b=lSt5c5IbWGN+AEoUBNtLEtUHhpAT9lZ4zWIlTXzTc72NJZ6YXdbal3lDl3bBSt8oKC0R/5DUNGqBhA+QjLLrJ9TDTlPF0gqd6oqJwfkbPKidaXq85rOZAz0bENtcAthCUA6elsZg1td3a8xQ7hCsWbVvVBqwsFi+UUDEmYYkJhU=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 14:53:56 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 14:53:55 +0000
Message-ID: <590897b2-7b50-545b-1b5e-651bd0589df3@oracle.com>
Date: Tue, 20 Jun 2023 15:53:51 +0100
Subject: Re: [PATCH 2/2] iommu/amd: Handle PPR log overflow
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, joro@8bytes.org
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-3-vasant.hegde@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230609101746.6412-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ed314b-5f89-4f33-d99d-08db719e2bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LQHdee8IgGzt4z/tKb3MHH9kydHkzaJ5TbiNGUbO+F7ddfvU/xRqGy6Q6JpdOZxwe6mSfy4swf879u9ifpy2qU1PwChpCanBF0Iq2OcnrteNY4cZWXIjmhJqYMgVWAXfwNkapWpKGbFD5hC01WfzQz6DEXNfaCIfPhs2YPQGv0r4kGLIKli1lQu4JGFKuiernwQcVZEvd5VnP+g0ADzE8veNNWfnW/IF4Vu4DRI4BBeepygy2fnfA7kaeXx/JzktG3LyAShigzFtQ6wbjieKdLsUXtSdI7JqSnNuaTNJ3o85akba3HXxr9qYkjsrZ+ri3QbP8XSW1b0KVLdm1evT3ts/FW0FlxtpaBHLFPD30peoLKq+ykCoNSEO+Kf9sX7vcroXRmyRtaPiJ+AxA0VoPXkC0SPHZF1NilZl6oSzI0mrSgAZnmC1CDfuG/Wf7Ngm18a5F+qlPJcVWmrAqIV+5uDt9xwdUwUxl3SLAOP4eQQ76yMbtoI11HQLCWDdNDEtyh8VQoPzXBGsmst+St2qCSbV3aD1slu8QqIfhFkRS0t4Z4YlA7KQ2Cd7jY9rZN4xdBOS0cTjqw2uPPBEDx3u/lm1IeYtz2dz3ux7OL8sFeQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(2906002)(36756003)(86362001)(31696002)(26005)(6512007)(53546011)(6506007)(186003)(478600001)(6666004)(6486002)(966005)(66946007)(66556008)(6916009)(66476007)(4326008)(38100700002)(316002)(31686004)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2FmdEs4alF6ejllRWMrdVdaNys2UTI0VDdHZnNjVWQ4U3VnOUpmY2xNZ3Nt?=
 =?utf-8?B?ZzEyYnlQR1grVityTVNBUEs2R1RUZWxhUk9FbTR3Y2UvMXU2ZElNWjFjQllu?=
 =?utf-8?B?a1hwVm03MXZhRDJHSlYrWG9ncmNqd0ZzSXRvN2ZRUG5FUWlMVVJQN3BwM1Nv?=
 =?utf-8?B?VGFTOWxrMXZtRWRVTEVKdWF0cHo0bE1FVlJLUlFIcGZIWHpoanplclFSdzdK?=
 =?utf-8?B?dkRsMFRtL0FyT25iNHJkdHpoQm9sajBvaE90eURKU2d3ZGc5eUJXVkxGb2Zu?=
 =?utf-8?B?YS9pKzVKcGd6ejBQZE1aWnh5MzlSV3UxQ0hpNk8zdkNyUnp1RTg0cnQ1cTh0?=
 =?utf-8?B?NlhHbkQ0ejZhbGF3M3dOZk1BdGlpVit0N0JzTWRzZGFmVEM0M2l5WTRVOUlN?=
 =?utf-8?B?TmpzSWFsczdOMmIvRW1OUUVnbUNpeEcvTmhzZENBMU02Q0MzZExxNzZjd1dQ?=
 =?utf-8?B?UlNGQkNkRXpyNHM4enM1TzRtSGZGQmd6YkFLWkcvUWRxTHNsdnZaZ3pPcGla?=
 =?utf-8?B?ZFhyUG9FQis1OGlncEI5YUx4clV0QnBQUjBHS2EvVlhNVXFOTHZ2VzJ4UjNo?=
 =?utf-8?B?ZXU1OHhQc1U4SXRZZWZZSDNIcktUR2R3cldWd0lVWFUzSGlkeWg1QUZTWllV?=
 =?utf-8?B?SGtDaGdVaXMxNG1hTzI4WEZkbkN1V2MzZjRReGQwR1RYMGN6RVg1djZsUWpN?=
 =?utf-8?B?YTllUEpoOVlIczgya3FxVU0yNmRxcTJDYUNrL0hRWDlXdGxpL1NoN0UxQ2gv?=
 =?utf-8?B?L3ZYa2FqU2VpeTZ5S1d0K0ltdWtJcTNvR3BDSElwYUhEK1kxNXh1TkFpczJW?=
 =?utf-8?B?elFPRGs2TWhQenZOSnNDQk9ZMXZQK3BVU0F2Y1dUWll5SFh6N2gxREV3V0lt?=
 =?utf-8?B?RjE3Wm1EcmRyc2FyWnlwYmR3dlE0RzZkSllINDlGKzFFRjJ6NjlmaGpMZEZk?=
 =?utf-8?B?RTlGOGxWcEJqYm1qTzMzT1A2VHRFSXhjTTlqTFB6NHNZcCtNcmlEK0xLblRy?=
 =?utf-8?B?QVNmUmFVMUc0ZzFVeXZJanJkNHVhbWNVWEFNNk9QSmswUm9aU1dNbC80Q2w2?=
 =?utf-8?B?Y2gvNWtXVjUwT2s0ejRYbkJnVk9kUnE1OVVlWmQydVdGcmc0RXJoRkswOVBu?=
 =?utf-8?B?YUg2aG1SNGszazd4NElKbUVPQTNUald2TmhHWk1GamdVYUo3bWxTWktyd0Zi?=
 =?utf-8?B?blRuWHBYeHlEWnNKWHJxSHN4OC9FcWZ4cmc4ZFQyYTBscTZsZVRFdmh0NytH?=
 =?utf-8?B?Mkd2ZDBOSWVCTVdWditnQVV6ay9BZGcrNUtseGVPazFrWUZOd0Jhak10MTRR?=
 =?utf-8?B?ZXRNR2NhYjZ2RXdlSWJMR1E3bGJlajlIVUZNMTZYdmtXRVF5WVBvTThNRjRP?=
 =?utf-8?B?NHd3cnVxUVdwTXJmVU5VQU1KL0R5NVY4MW9QSGI1anhBUE1IcGdOdUhwZThi?=
 =?utf-8?B?Z3RXTDJQSVc5UmJtSkg0Q0UzYW9KazJxUW9mcVZKcndzZHROQ2xVZFozcVJn?=
 =?utf-8?B?WGxIK3RYdWtQT2lCTGtaUmZjQ0FWaUdOQTV2U1B2b1RHbnBRK1dRL21RVXNr?=
 =?utf-8?B?N3FNMXFMdjIwczQxcUpZaHZUQ3N5bUVlU1RjdmpvRFlXRnJka2Q5Uy9Hdmta?=
 =?utf-8?B?UG1QcUJIRWJIQmsvUFZ5Wk00MVZPdjBoakVtUnlTTUg4ZWNiV0sxUzdzM2FN?=
 =?utf-8?B?U1BXL2tDb0dFQ0txWWdGbUF4Y0tjRnYxdURXUlBibnUyVUFrZ0tyYWtzSXIx?=
 =?utf-8?B?SXB4SjFmZ1JSU0tRQXROYjN3eXdPOWhvOXdWVjZnKzlZRVhiRzU5eDZLUlZE?=
 =?utf-8?B?UERCWHRrMU9sNnpSMUhIdi8xT1lpTHd6b0diM1lxQ2tuNFJPSXlNL0RWeVln?=
 =?utf-8?B?aW5rT2dqeXlLYlVWblhxTUlUQmRKWWNTWXVTMFFEZVBtaW1yOEs2VXpWTXVm?=
 =?utf-8?B?a3B4SG02Y2N3a285aVFIRFVXR0RHaE1FcWR4WW9VUC9TdTdWS3V3Vm5ybzRK?=
 =?utf-8?B?RzRGdG1IV3RwLzZWWHp2TnMxRGUveHBhZlZUdTVVR01INjlqZWJ3NGtkblpx?=
 =?utf-8?B?WWV0cmdieEhGRmcyV0VSNWFDaDgraTdYOG00R3J3RlE0dXhZNlNCR0tsVHgr?=
 =?utf-8?B?QUdlajRCQ3NHZ2NNWDdROUQrQnpwREVRUXF0a3dIWEtUWmg1VndiTHRNR3dT?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8X4pg+Ac83PJBlTRP+t8PxXOc/UPQe3+rHyeaa+9LoTnfDLkLHLuhf1KSEzY0jqbrI18uYAvD8JAnsSZutV25W9nUeGmMVN1oDM2DM926OY/cwa6Rpe9rYWdCni3zZbMFZ8EG6dUqXRYwcXHMIL+1rgxPb0sjeMRRvyuQ1PBJ404+qj51X3whx3UrtFWeEiYR01D84xB45tZecPa7+3MRBjAy6+e0PLSoJXaAukKbK1t64nPiN9jfEssq6zErvdFzG+XHVpO2vPFWLPcFxyE2nln7KOuCyRfM58xQap/5x/Ck+GiqW7UZs5yL4Ok7SntfBDonn0h/agNdw2TSyUyEU6eibCbP8X0kycQK/8PQ62A2D5zxpirpzgezi69Gh47wTaQGrw34FLSle3kSkq0gYCUVXEA24h2ctOBmFPunpfiw/ylC9MlPYhFHATSeSyesZQlc9y2+qe3O2tQyRnF0RkW8OZUf8+erWJKrkv0wo7ZCJUOSZKm2CtF3tsvMfBQvePvW2TFQ8QJPPxM5KjdLHMAgScIUu4n8YK+MtVm05jOb1qoV4FJXfkukysvBYed2cVOe3yyqLbfip2Lgbg//N4tOmBBOpKo+7W7N+LW/zwBuwZMx4FoWHQVqq3ZlOfvyzD1aFGTi1FwPshOs29NvGUnMDkLeZIpypZ1DH95qIa0y8wqS1EITTRoVs27HndeUQJT7bafxu4G9628RLkWGEt5nmN5m6hUsIb4PEku3WiurYRYriWLhKOeV5nsQjSpGqgzxViHjxMKrvZ8FelgMJwhKJWxeTP0VKGl9X/+09duVoCY+enNgXy0f3Je+tBC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed314b-5f89-4f33-d99d-08db719e2bd8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:53:55.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dar7UpD0rlHWQlDsWlTXi0x8wIDNnGJDMxx4VL0qy/pOw/JOm+X9RfZveuK7I6+g4dEnMnBN2ZTMUjgMATV0KcreJzh6vUss++ih/UohRuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200134
X-Proofpoint-GUID: j5FA3KQql5hErhIPDOfBbL2xBJM-a7mz
X-Proofpoint-ORIG-GUID: j5FA3KQql5hErhIPDOfBbL2xBJM-a7mz

On 09/06/2023 11:17, Vasant Hegde wrote:
> Some ATS-capable peripherals can issue requests to the processor to service
> peripheral page requests using PCIe PRI (the Page Request Interface). IOMMU
> supports PRI using PPR log buffer. IOMMU writes PRI request to PPR log
> buffer and sends PPR interrupt to host. When there is no space in the
> PPR log buffer (PPR log overflow) it will set PprOverflow bit in 'MMIO
> Offset 2020h IOMMU Status Register'. When this happens PPR log needs to be
> restarted as specified in IOMMU spec [1] section 2.6.2.
> 
> When handling the event it just resumes the PPR log without resizing
> (similar to the way event and GA log overflow is handled).
> 
> Failing to handle PPR overflow means device may not work properly as
> IOMMU stops processing new PPR events from device.
> 
> [1] https://www.amd.com/system/files/TechDocs/48882_3.07_PUB.pdf
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  2 ++
>  drivers/iommu/amd/init.c            | 11 +++++++++++
>  drivers/iommu/amd/iommu.c           |  9 ++++++++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 317d5c26c614..156f57b4f78c 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -16,6 +16,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data);
>  void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
>  void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
> +void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
>  void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 318b84cf47f6..a993e1bdb70b 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -124,7 +124,9 @@
>  #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
>  #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
>  #define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
> +#define MMIO_STATUS_PPR_OVERFLOW_MASK		BIT(5)
>  #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
> +#define MMIO_STATUS_PPR_RUN_MASK		BIT(7)
>  #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
>  #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
>  #define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 3c21e9333899..9908cd4f1c31 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -795,6 +795,17 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
>  			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
>  }
>  
> +/*
> + * This function restarts ppr logging in case the IOMMU experienced
> + * PPR log overflow.
> + */
> +void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
> +{
> +	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
> +			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
> +			      MMIO_STATUS_PPR_OVERFLOW_MASK);
> +}
> +
>  /*
>   * This function resets the command buffer if the IOMMU stopped fetching
>   * commands from it.
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a29548d98b6a..3c179d548ecd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -844,6 +844,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #define AMD_IOMMU_INT_MASK	\
>  	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
>  	 MMIO_STATUS_EVT_INT_MASK | \
> +	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
>  	 MMIO_STATUS_PPR_INT_MASK | \
>  	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
>  	 MMIO_STATUS_GALOG_INT_MASK)
> @@ -863,11 +864,17 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  			iommu_poll_events(iommu);
>  		}
>  
> -		if (status & MMIO_STATUS_PPR_INT_MASK) {
> +		if (status & (MMIO_STATUS_PPR_INT_MASK |
> +			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
>  			pr_devel("Processing IOMMU PPR Log\n");
>  			iommu_poll_ppr_log(iommu);
>  		}
>  
> +		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
> +			pr_info_ratelimited("IOMMU PPR log overflow\n");
> +			amd_iommu_restart_ppr_log(iommu);
> +		}
> +
>  #ifdef CONFIG_IRQ_REMAP
>  		if (status & (MMIO_STATUS_GALOG_INT_MASK |
>  			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
