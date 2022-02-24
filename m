Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A5C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 16:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07E858294A;
	Thu, 24 Feb 2022 16:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lI4suZDN0pGQ; Thu, 24 Feb 2022 16:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A988082ACA;
	Thu, 24 Feb 2022 16:19:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCB3C001A;
	Thu, 24 Feb 2022 16:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB37C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 16:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17B3582ACA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 16:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnHZvGp0RyGB for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 16:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE3868294A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 16:19:11 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFdutD027379; 
 Thu, 24 Feb 2022 16:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zr0WlNi9qNdnOP6Z90PTZonM8PHLStvdmbigYILztrg=;
 b=IiOtL9tL7pCuq0X97tZ4D8UCwwHM2gNeS4Q/70hudceMNrtcMQMsf9gTYgGs4M6P1JEM
 mitycnGr4w2I47jgEn8+mDw/nPJo+B8VuLRiiWRArY9PDVWJnSV8JOtDXtqe6P2aoHk7
 3bFlMPg/bcpp3dp3Y+i06jAnUm2d4jiwSBK7oO+BxWz6kVRAmTHYr5Hw+fJBxeLOG9NT
 fPB4fKauzpfQuFzVtGxw5gnPbMyCROx04578/aUbG3pC/3wbx1d7jPC2ig8+gpKo6Q3L
 sk/7RjeyisRjrVQ+wMunvlYHk9N1nWiqdhcWuxcSvDchncemdUHZ+i6l0a4HPTunekti iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar7f1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Feb 2022 16:18:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OG6urJ153066;
 Thu, 24 Feb 2022 16:18:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by userp3020.oracle.com with ESMTP id 3eat0r08r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Feb 2022 16:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXt4gPUkTZgD/tX8jtbO2kGJpp4QN/h6qFwQUt7y2BXVo2F4mCRpoq9QZ7wtidXUkzDizqdioM/DDC3Oa0OOJmP53fGT505WotQ7pnYVUmrSCsGt36qdrs7ttqcvEGkXD+yGS/sRB82ClYFJBDlcoOVch6Xztgn8etYRzsZqpu9mnDDrGI4SIh3J2GNiisuflyZ9iaTTvwqqmttzEgp2ctHQOX4XghaS+j/gmr2ZQtdYe7Rkr1mqHKJgStKVXVV8z69zKazCx2KPk/iRy3V5ukvb8g8pHUYqiimSE3KcabOmi9AX9I/dCs3hUcld6ShFrGAgj0jgobnMpwxYiPgXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr0WlNi9qNdnOP6Z90PTZonM8PHLStvdmbigYILztrg=;
 b=OevHCxib6wNeE6phQUVkD4tBf0gSBmIhuKJUEtzPETJTTcMBv/jQMj4A8BFDxaEfX+TDicI7/W/3l0caZhdq/4gCIGYO7lTZMoFLcBZVymuJs7z66SGuPpEvNhH0KP03lfcMlmzFiohrV8su+81SmC42v83Q+YFMFtAdnnPyUiWudvA1FcXTRjBwO2DqnpV57133SvfhPkGza0Bw5fhrLtx6M+X84elLHY8yMvYftW6NG9udHSGVyDCEknMsgQKNVto5QK4pVWa/ZiGj2bi0TsaDD9hmi+/AnwasYCwCc4209ZCHyMgvqqijiVKb+kAI4YX9Txhge/+MNdut8ya3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr0WlNi9qNdnOP6Z90PTZonM8PHLStvdmbigYILztrg=;
 b=xkEXlWnGxdIs+nlKnCcdgN4ik1Cfr38HYXvxd8j/zcobYGUywqNr1j5wEPbPj7y5FT2j3cqBPos7WYsxbJrEAdcvVSG4pfASTN3EMMrvyhALOAwu3Fzvk8mh5CfQOHYjqGCIT4odpMsGzbHC/7MRbqEFjlJrkpt6DCBrSQWWHUg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Thu, 24 Feb
 2022 16:18:47 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:18:47 +0000
Message-ID: <206ba6a3-770a-70ad-96bc-76c6380da988@oracle.com>
Date: Thu, 24 Feb 2022 11:18:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: cleanup swiotlb initialization
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220222153514.593231-1-hch@lst.de>
 <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com>
 <20220224155854.GA30938@lst.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220224155854.GA30938@lst.de>
X-ClientProxiedBy: SA9PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:806:6e::12) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7a2783-6c19-4d37-42f9-08d9f7b155ec
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5785:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5785404B16848580DDF957218A3D9@SJ0PR10MB5785.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/bEZu52wrvxS8Lc3qiHX/+2sgU55XexBsAFECyP9Cg332+w3K3WXm2xsdldFQKqqp/uv990BEgH49NNi1lGpBbWefva8/4yyx3Dwev0M9VNpOdy+drY3k6XR8wZohWcmepxH8bOimgp6cBv4wZtdFQIYydEJJZiqY9ZDqxd4LADpeEQMrXo7UpIjLT89R7HBOfmL8cH51Ftr9/ab3cIJGgxVLqb5WF1Uf95h2O3Hgx/p2+bEQLCugr6xtNGRbMHTgZlxGq0Mf6PLL4nibLBd2tYHz5tVppimWqVwBJyS6AKvktUYMMEDKodynyD4V7/DKs+fJcqkthiwRMs+ImCs8fDvn+NWTmoxmh38SKYRz8BhvWqGtHqoEobz4whThR0n8n0LUusBTaAqPsGwr747I2+we04//PhtmSNwhCC5JTmR607Ix7llgD8BBfILKyv07wmXV4+OdizOjryWZbae+lqG8mGpJ+PcheKMTAeHHYWgyjC1ufIK8gcRQJ1+9/xfH5YankCZBu/KaLab3Rri0wd/4AHwLqBFkdmsCoixOzZzwyxZM6qsQjeNWNnMzhINwiVFAIRbJb6z7DZ0sJDuBF3B/mUwceOJ1//uTv4203n0WtaQQKeU0wVggPufpvMCOfT7ys5GldA0LjhtBkbgzaS5NvmS5sg0A5vpHtXTz7lvVR2P54GWrEh4AWlIBMlDFkkF/cgn2TNLPj4eMqWckRMiS6rbrhp3wNZoDqtAfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(8676002)(66556008)(2616005)(83380400001)(4326008)(44832011)(7416002)(8936002)(5660300002)(54906003)(66476007)(7116003)(186003)(66946007)(26005)(36756003)(6916009)(316002)(6486002)(45080400002)(31686004)(31696002)(53546011)(86362001)(6666004)(38100700002)(2906002)(6512007)(6506007)(3480700007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktGSWRrUVJEc0NuUHhIOWtMMGlMeXNjL2VZaHJ4K3pFUC9GSzFsM1ZWRHhv?=
 =?utf-8?B?L0h6YzBvZFQ3OWVkNmFTYlFWQzNZVDRPNlJKUjJ4anBLWDBJSVJDTVEwaHpO?=
 =?utf-8?B?cUtWZjBGOVdrN21rSjFTbHBqU2ZsQ2dOOGVEdHkreGtuZitvTUJOdisrN3ZR?=
 =?utf-8?B?Q3lsMlBScXJIN1ZoREgxQWt2VXYzMlNCM3JIMUZQcGprdmtuWERwdFl6T1Nn?=
 =?utf-8?B?VGI4cVE4S294Yk50MDhwL1c1NERERnpVYWN2ci9vbGNDL0tiN1RRUFN2MTFQ?=
 =?utf-8?B?eWozWGNjU2tyaCsvajdONGRHbEdlaUl3ZjRRNXBPYXpiZWYxTkIyYlV3eWkr?=
 =?utf-8?B?U0xnT3FqQW1iejZmUzdXOEo2RlMvNmltU2tVbmlxblZ6RDZ0aDl1NUozVUp2?=
 =?utf-8?B?UzF6eDR2MCtXMDJjbElRTGlZQk54dEVEd21nR2dXZTJZVlMxek5FeWhGbFpn?=
 =?utf-8?B?L3U4OWJaVVNjRnhOOXhKR2hMb2VNdSs1dUpqaDRRNUlFT2xnT0JkRjZockVV?=
 =?utf-8?B?TElLZjdxcVBReUVEcVM2KzFEUGcxbmtrcU1HZzdWaHhqVWFsU3VDUUxIbFBR?=
 =?utf-8?B?WHp2UGJPR0JDV3VwN1JtNlNJSFl0MS81OFQ4N0VjR243c2RxTndOWmhYZWFq?=
 =?utf-8?B?cXpuZmszbkVlWHVVaU5ybG04VTZzNUpNWEdqYi90RE94UlBNait5M09XR3hT?=
 =?utf-8?B?SEV6UXRGZ2E5VTVLd1JMRWs4VDFTc2Z0bDRHQkxMTm8rL0xmYXdPTkRMclJK?=
 =?utf-8?B?NUJRS05EUVJDbFJON1Z5eDRKQTBWajFoRGU1VGlEaENMMU14YlgwZUFYZFRT?=
 =?utf-8?B?ZjJVc1JFL0h1M2Q4SEhKem5iVHg0ZklQYlg0UVBtdEd6dGxZWERCaG8raEYz?=
 =?utf-8?B?MEViaE54eWMzZlpoeW1DeVBiMTkwNmU5RVZxWGl1K252SDdqUHI3eG1MSHE1?=
 =?utf-8?B?bHBCbFg5RU9DTTVPcitXRzNEamErZ0ZsL1JERjNNbFRZdHI1S1FmN0dMdmRV?=
 =?utf-8?B?bisxc3ROWlhsSDE5UnFYLzBJNnpJbmx3am9Tc29FMThsWEpMWGtSeWpDb2FP?=
 =?utf-8?B?VzQwS0ZQajV4eVpBV1BhMEFlaWg3aDRBN2RKOHRZbzJUeWszcSs5WmIxUzM0?=
 =?utf-8?B?eTh2bHBaenNFaVlrME9iaVBpb000UzBmcW1JTzREMGZXYzc2MXNTdDFLUk9O?=
 =?utf-8?B?TnRHaFRkSjBURy9WaThYTHdHWUxVSHREd3ZsMjNadDFaQTRySjFFTWNyaHY2?=
 =?utf-8?B?aFYzZm1MaUZYQTNQNG5ocXU3NDN3S3J4V2hVK0toSDB3bThRYnJzbUNFWWRa?=
 =?utf-8?B?cTVBN255eS9QZ0VDMk1ORFFEQ3JqOWFkT29SMmdFUEFINWxXZmFGYVl0QjFy?=
 =?utf-8?B?RnlLWHN1aUMyZ1QzL1RQZFBaSUd0TzJaVlNkcGlyN2tZU1Z1Rk03R1JPZVR3?=
 =?utf-8?B?V2tSeFFWdXVhcW4yeEtoWnV3M1R4VnBsTm83bW1LOENERER6Z3QwVENEZ0xy?=
 =?utf-8?B?ZE5Sc3JReURNak5kTXFWTmRrM3J1YS9rYU9oajNPUGVteFZiWkNlek1VY0dJ?=
 =?utf-8?B?TUVRa1EvVDAySzlRNHI5Ync5TU8yeG5TWUVZdnZtYTh6UG1MeEgzZDlzRzVq?=
 =?utf-8?B?RVc0NFhhQUpkVkhYWEQ3akhLSE9TVkNnb3BzR0ZzTmtXVzdjU2xGZmdxOTRo?=
 =?utf-8?B?SFFsaURvaG8rOVV3UjZ1RjJxcVdOZU9Uc1A0dWR6b2VIOHduYXdkWGcwQ3c1?=
 =?utf-8?B?Tjk0dUxLS0Vtc2RhY25BVkE4SlNuN250Z0twVEdzTWtEOVl4YklZNEtqSXhH?=
 =?utf-8?B?Tnd0UHEzWU04VlBodC9weDB5RVFBKzF1RXVVaVkyS0V4QzVlaXoyaWs3cEQr?=
 =?utf-8?B?S0dzc3ZOVU9wNkw3ZnIzZFhJeWRhTjR5empPODVVQUhyVVUyUmF3L3Y3amNL?=
 =?utf-8?B?MEFqYzVLMkNIWFBNUFhvc2hWaUNtbSsvSFhNNGtRanUvRDJTeVRMUUlvQkwv?=
 =?utf-8?B?eGRwWHRoMW0yV2F5MDJSbmVGZ3BxWTQ2ZWU5ekZCajhJSWdCamRpanRGTDZ3?=
 =?utf-8?B?aWpjOGJZaWQzMnpjby9VMHd1S0xCSXFYaTlDYThPN1BlSXNiTVJFT2xuYzhR?=
 =?utf-8?B?MGt5ZUdnVjdLekF5bElwUEFWQ3dUb2p1V09YMUlpOXFCc05pM08zbENkME9S?=
 =?utf-8?B?dEd4MGwxRk13b21sZkNqeFhWcFB2aWxHTW1NWlQ2N0RISHZsRlAxaDRtOVd6?=
 =?utf-8?B?ZzArOVZ3RWNZUTA1NU9xK25Kc0RnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7a2783-6c19-4d37-42f9-08d9f7b155ec
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:18:47.4329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4wj66LLjTVIqRHUirgnySr+Yi5eVX6oo0+CbRSUavJYoZmsYLDf8zCt1AztG5nOfnW6NRwIfQRkai7q3LFjKdTcCrunBZ/fCaOe7H8QpM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268
 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=846 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240095
X-Proofpoint-GUID: 49gfwTdtFA3i5qMnUOXWR97xCIOKkMf0
X-Proofpoint-ORIG-GUID: 49gfwTdtFA3i5qMnUOXWR97xCIOKkMf0
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 x86@kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-riscv@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIDIvMjQvMjIgMTA6NTggQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFRoYW5rcy4K
Pgo+IFRoaXMgbG9va3MgcmVhbGx5IHN0cmFuZ2UgYXMgZWFybHlfYW1kX2lvbW11X2luaXQgc2hv
dWxkIG5vdCBpbnRlcmFjdCBtdWNoCj4gd2l0aCB0aGUgY2hhbmdlcy4gIEknbGwgc2VlIGlmIEkg
Y2FuIGZpbmQgYSBBTUQgc3lzdGVtIHRvIHRlc3Qgb24uCgoKSnVzdCB0byBiZSBjbGVhcjogdGhp
cyBjcmFzaGVzIG9ubHkgYXMgZG9tMC4gQm9vdHMgZmluZSBhcyBiYXJlbWV0YWwuCgoKLWJvcmlz
CgoKPgo+IE9uIFdlZCwgRmViIDIzLCAyMDIyIGF0IDA3OjU3OjQ5UE0gLTA1MDAsIEJvcmlzIE9z
dHJvdnNreSB3cm90ZToKPj4gW8KgwqAgMzcuMzc3MzEzXSBCVUc6IHVuYWJsZSB0byBoYW5kbGUg
cGFnZSBmYXVsdCBmb3IgYWRkcmVzczogZmZmZmM5MDA0Mjg4MDAxOAo+PiBbwqDCoCAzNy4zNzgy
MTldICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQo+PiBbwqDCoCAz
Ny4zNzgyMTldICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQo+PiBb
wqDCoCAzNy4zNzgyMTldIFBHRCA3YzJmMmVlMDY3IFA0RCA3YzJmMmVlMDY3IFBVRCA3YmYwMTli
MDY3IFBNRCAxMDVhMzAwNjcgUFRFIDAKPj4gW8KgwqAgMzcuMzc4MjE5XSBPb3BzOiAwMDAwIFsj
MV0gUFJFRU1QVCBTTVAgTk9QVEkKPj4gW8KgwqAgMzcuMzc4MjE5XSBDUFU6IDE0IFBJRDogMSBD
b21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4xNy4wLXJjNXN3aW90bGIgIzkKPj4gW8KgwqAg
MzcuMzc4MjE5XSBIYXJkd2FyZSBuYW1lOiBPcmFjbGUgQ29ycG9yYXRpb24gT1JBQ0xFIFNFUlZF
UiBFMS0yYy9BU1ksR2VuZXJpYyxTTSxFMS0yYywgQklPUyA0OTAwNDkwMCAxMi8yMy8yMDIwCj4+
IFvCoMKgIDM3LjM3ODIxOV0gUklQOiBlMDMwOmluaXRfaW9tbXVfb25lKzB4MjQ4LzB4MmYwCj4+
IFvCoMKgIDM3LjM3ODIxOV0gQ29kZTogNDggODkgNDMgNjggNDggODUgYzAgNzQgYzQgYmUgMDAg
MjAgMDAgMDAgNDggODkgZGYgZTggZWEgZWUgZmYgZmYgNDggODkgNDMgNzggNDggODUgYzAgNzQg
YWUgYzYgODMgOTggMDAgMDAgMDAgMDAgNDggOGIgNDMgMzggPDQ4PiA4YiA0MCAxOCBhOCAwMSA3
NCAwNyA4MyA4YiBhOCAwNCAwMCAwMCAwMSBmNiA4MyBhOCAwNCAwMCAwMCAwMQo+PiBbwqDCoCAz
Ny4zNzgyMTldIFJTUDogZTAyYjpmZmZmYzkwMDQwNDRiZDE4IEVGTEFHUzogMDAwMTAyODYKPj4g
W8KgwqAgMzcuMzc4MjE5XSBSQVg6IGZmZmZjOTAwNDI4ODAwMDAgUkJYOiBmZmZmODg4MTA3MjYw
ODAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqDCoCAzNy4zNzgyMTldIFJEWDogMDAwMDAw
MDA4MDAwMDAwMCBSU0k6IGZmZmZlYTAwMDQxY2FiODAgUkRJOiAwMDAwMDAwMGZmZmZmZmZmCj4+
IFvCoMKgIDM3LjM3ODIxOV0gUkJQOiBmZmZmYzkwMDQwNDRiZDM4IFIwODogMDAwMDAwMDAwMDAw
MDkwMSBSMDk6IGZmZmZlYTAwMDQxY2FiMDAKPj4gW8KgwqAgMzcuMzc4MjE5XSBSMTA6IDAwMDAw
MDAwMDAwMDAwMDIgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZmM5MDA0MDQzNTAwOAo+
PiBbwqDCoCAzNy4zNzgyMTldIFIxMzogMDAwMDAwMDAwMDA4MDAwMCBSMTQ6IDAwMDAwMDAwZWZh
MDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwCj4+IFvCoMKgIDM3LjM3ODIxOV0gRlM6wqAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODhmZWY0MTgwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKPj4gW8KgwqAgMzcuMzc4MjE5XSBDUzrCoCBlMDMwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+PiBbwqDCoCAzNy4zNzgyMTldIENSMjogZmZmZmM5
MDA0Mjg4MDAxOCBDUjM6IDAwMDAwMDAwMDI2MGEwMDAgQ1I0OiAwMDAwMDAwMDAwMDUwNjYwCj4+
IFvCoMKgIDM3LjM3ODIxOV0gQ2FsbCBUcmFjZToKPj4gW8KgwqAgMzcuMzc4MjE5XcKgIDxUQVNL
Pgo+PiBbwqDCoCAzNy4zNzgyMTldwqAgZWFybHlfYW1kX2lvbW11X2luaXQrMHgzYzUvMHg3MmQK
Pj4gW8KgwqAgMzcuMzc4MjE5XcKgID8gaW9tbXVfc2V0dXArMHgyODQvMHgyODQKPj4gW8KgwqAg
MzcuMzc4MjE5XcKgIHN0YXRlX25leHQrMHgxNTgvMHg2OGYKPj4gW8KgwqAgMzcuMzc4MjE5XcKg
ID8gaW9tbXVfc2V0dXArMHgyODQvMHgyODQKPj4gW8KgwqAgMzcuMzc4MjE5XcKgIGlvbW11X2dv
X3RvX3N0YXRlKzB4MjgvMHgyZAo+PiBbwqDCoCAzNy4zNzgyMTldwqAgYW1kX2lvbW11X2luaXQr
MHgxNS8weDRiCj4+IFvCoMKgIDM3LjM3ODIxOV3CoCA/IGlvbW11X3NldHVwKzB4Mjg0LzB4Mjg0
Cj4+IFvCoMKgIDM3LjM3ODIxOV3CoCBwY2lfaW9tbXVfaW5pdCsweDEyLzB4MzcKPj4gW8KgwqAg
MzcuMzc4MjE5XcKgIGRvX29uZV9pbml0Y2FsbCsweDQ4LzB4MjEwCj4+IFvCoMKgIDM3LjM3ODIx
OV3CoCBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDIyOS8weDI4Ywo+PiBbwqDCoCAzNy4zNzgyMTld
wqAgPyByZXN0X2luaXQrMHhlMC8weGUwCj4+IFvCoMKgIDM3Ljk2Mzk2Nl3CoCBrZXJuZWxfaW5p
dCsweDFhLzB4MTMwCj4+IFvCoMKgIDM3Ljk3OTQxNV3CoCByZXRfZnJvbV9mb3JrKzB4MjIvMHgz
MAo+PiBbwqDCoCAzNy45OTE0MzZdwqAgPC9UQVNLPgo+PiBbwqDCoCAzNy45OTk0NjVdIE1vZHVs
ZXMgbGlua2VkIGluOgo+PiBbwqDCoCAzOC4wMDc0MTNdIENSMjogZmZmZmM5MDA0Mjg4MDAxOAo+
PiBbwqDCoCAzOC4wMTk0MTZdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo+
PiBbwqDCoCAzOC4wMjM0MThdIFJJUDogZTAzMDppbml0X2lvbW11X29uZSsweDI0OC8weDJmMAo+
PiBbwqDCoCAzOC4wMjM0MThdIENvZGU6IDQ4IDg5IDQzIDY4IDQ4IDg1IGMwIDc0IGM0IGJlIDAw
IDIwIDAwIDAwIDQ4IDg5IGRmIGU4IGVhIGVlIGZmIGZmIDQ4IDg5IDQzIDc4IDQ4IDg1IGMwIDc0
IGFlIGM2IDgzIDk4IDAwIDAwIDAwIDAwIDQ4IDhiIDQzIDM4IDw0OD4gOGIgNDAgMTggYTggMDEg
NzQgMDcgODMgOGIgYTggMDQgMDAgMDAgMDEgZjYgODMgYTggMDQgMDAgMDAgMDEKPj4gW8KgwqAg
MzguMDIzNDE4XSBSU1A6IGUwMmI6ZmZmZmM5MDA0MDQ0YmQxOCBFRkxBR1M6IDAwMDEwMjg2Cj4+
IFvCoMKgIDM4LjAyMzQxOF0gUkFYOiBmZmZmYzkwMDQyODgwMDAwIFJCWDogZmZmZjg4ODEwNzI2
MDgwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKPj4gW8KgwqAgMzguMTU1NDEzXSBSRFg6IDAwMDAw
MDAwODAwMDAwMDAgUlNJOiBmZmZmZWEwMDA0MWNhYjgwIFJESTogMDAwMDAwMDBmZmZmZmZmZgo+
PiBbwqDCoCAzOC4xNzU5NjVdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNjI2NDBLCj4+IFvCoMKg
IDM4LjE1NTQxM10gUkJQOiBmZmZmYzkwMDQwNDRiZDM4IFIwODogMDAwMDAwMDAwMDAwMDkwMSBS
MDk6IGZmZmZlYTAwMDQxY2FiMDAKPj4gW8KgwqAgMzguMTU1NDEzXSBSMTA6IDAwMDAwMDAwMDAw
MDAwMDIgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZmM5MDA0MDQzNTAwOAo+PiBbwqDC
oCAzOC4xNTU0MTNdIFIxMzogMDAwMDAwMDAwMDA4MDAwMCBSMTQ6IDAwMDAwMDAwZWZhMDAwMDAg
UjE1OiAwMDAwMDAwMDAwMDAwMDAwCj4+IFvCoMKgIDM4LjE1NTQxM10gRlM6wqAgMDAwMDAwMDAw
MDAwMDAwMCgwMDAwKSBHUzpmZmZmODhmZWY0MTgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDAKPj4gW8KgwqAgMzguMjg3NDE0XSBDUzrCoCBlMDMwIERTOiAwMDAwIEVTOiAwMDAwIENS
MDogMDAwMDAwMDA4MDA1MDAzMwo+PiBbwqDCoCAzOC4zMDk1NTddIENSMjogZmZmZmM5MDA0Mjg4
MDAxOCBDUjM6IDAwMDAwMDAwMDI2MGEwMDAgQ1I0OiAwMDAwMDAwMDAwMDUwNjYwCj4+IFvCoMKg
IDM4LjMzMjQwM10gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEZhdGFsIGV4Y2VwdGlvbgo+
PiBbwqDCoCAzOC4zNTE0MTRdIFJlYm9vdGluZyBpbiAyMCBzZWNvbmRzLi4KPj4KPj4KPj4KPj4g
LWJvcmlzCj4gLS0tZW5kIHF1b3RlZCB0ZXh0LS0tCj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
