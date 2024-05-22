Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAF1420A9
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397900; cv=fail; b=lL3anmPTjhdyNKLUTBb/WKUEzTiW1ee9eqhRTZ8VTZOfX6bvL7qfFfO64EtgwZmbTm99Osf2Ekm8+EXkKowwJnq55UgFaiy1PcfEUcKlK8DSNk/cOJwwQ/WUvb4EBU/pZUKs8E/jnWOKRw3D3HWHgkWfCgWmRK/mM0hNxEa89KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397900; c=relaxed/simple;
	bh=ySUhJ5yTnTutN5gXTqrouEuJa+A+dPM0rZ7IXEMTclA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oJEePyERVJ8zbgGMgpNwQLyjep+XsJfkyF4BdxHWyy4DhO7rEonYJDbVnYncMdXMifKhr40AXlLv7M2mfD1CZw0CSZtqqMm1yEbUpdL9pvvGn9HNYeQlE2mw37ARdifRXjsDZfFocR+AeP6kfz1Xu9+g+UJ/P/oFz4NtHTO4peU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hF1yOq/A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PUo8+7tz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hF1yOq/A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PUo8+7tz"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEnugF008045;
	Wed, 22 May 2024 17:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=owlBWRmXHtR5KBqqyHoK7dFIh0DInc2tlsi8J67nNow=;
 b=hF1yOq/Acw25IX0TaMOnt81zg6GLVYuuNW7jud6euRhVY3n6VnV1pKTE7lfJs5SKR1id
 kOmbrAspYoiUxJP2Ny0JQGHeqmQg2rg1FOpNQgOjzNMuC0PoCaxCQJEwc74RaGvhx6pM
 IxlBe9d4m9V9O8Tddx7ucHIu6ZFf4J79j1tUE0BPDn/xxOT9gcGCEGFJeJMCkpGWx1sR
 MEZBkrxIANw5A1c9qJwNl8zxStPXUJea8yU7gAQyq5dEaHxx5diPmpTsT7UBQOEvkZYH
 a/AjJxU+X+h1gBUcrzlIjiXU7FFQ9XdgY1vn2j4y3JocrANT0DfhqnyWDJCdJYc0zq/x dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv8c4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 17:11:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MGCeXu002694;
	Wed, 22 May 2024 17:11:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9fqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 17:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6ITNdiL5H2HtvlZXmA/xtPswhMrCqQ1RtfTs/HFpsaIsioZmGilnFllmktKeB3Df17fGGZGyAZPvMd093/vATnOC1rOcnuqKxTDnTyP7O5LOCosINudMxiu6AILyfRELfQ1/OMQS3cX2ezutJiKUnBRpcSwx89PrrPux/EHMEceGtmL5PbXdgCAxAtCXf1TjxSBpsPPBljEk9C67StDfzt2WKxN3GKFGsXMDcAQf1ZH2EZBALO7OeAtMWEwKvlEw427r7mgkIMeHYAZYQUMHhKeYpu5HAxiHRJvzvVKGEJa0/dpUCd6I09I76WwMxhwZPf2riVi9WJyx6D8pI5CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owlBWRmXHtR5KBqqyHoK7dFIh0DInc2tlsi8J67nNow=;
 b=AdjGlOhZlMlQ6AGuEzo9ex5PESMY7gDGtlqDu04jRuYGtFDZb9kXSSAh72/jPvOMeLu3B0bJ6AGOJpIBukbeo+DXoSPjp5xom2vpaJzo8Ii/S8q381xVLsV0qDPJnKfzmDtBucECKwC2dutzLMUHTiMxWFGmysEUUVrCsgtMTyqGeMAYgzNckxGRp3tem1gxDSIlNQ14HyW10zrI8v2nXNJt1zzyV37SoDIliD72S1gLQJuX9uvKrVl2dcWfHmG8LK6xzMS/b+cNLpUeqgfVKreozby9XCnlGNh+Ueb38zI2DaSAO9lnYrdCRJ/g7EabW8IXx8KK/q44SfR+n81vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owlBWRmXHtR5KBqqyHoK7dFIh0DInc2tlsi8J67nNow=;
 b=PUo8+7tzx75O8MTBccFwMQfKx6JAxFwYlxw5Zd2IQKbSG+g8e66Y9Fab/5OogGS3Y6ITiqX9FfPD6pPcaBjY9UQvq/aKcudWIkPt61404Vitxl7Ferxojsx/D+8/VxXLnatzEHrdHKCwbSI706k4MA2gNknOYMRME0BUbhzcqCc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Wed, 22 May
 2024 17:11:07 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 17:11:07 +0000
Message-ID: <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
Date: Wed, 22 May 2024 18:10:59 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "mshavit@google.com" <mshavit@google.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240522165640.GD20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ead4e42-2ad7-4e79-bd0d-08dc7a822b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WU9QSGRIelZ5Vk1iS09kcFJGNC9WYUVDdGhsMEpBWDFVVmRROW5FbDVncUhO?=
 =?utf-8?B?THhaenhST29wQWZLa2ErajVZQ2VsTEFFcGtjeUlPUGJjUU0wZFZXRlpXdG01?=
 =?utf-8?B?SWxadTk4Qm9jWHpEb1FMRGpwdTVnWVd6K0paVVlrd2pwSTRyQStSRnpmU29F?=
 =?utf-8?B?U0JhWUhlSTA1cm9QY0tNeU5WNTZncDlxZUJZYjNDYlViWjRKNjhEMlgwdW85?=
 =?utf-8?B?bW5zRXFvVWNUTENsSm5rZVlncThtMXNXUFFoWG03N1B3OVRxM3F3eDFtNEZw?=
 =?utf-8?B?bnNoNEFmMTYxK0V4QmlMdkdXM09Obm9UV0hkZUxMRlJaQUU0MGg2MTZHWkFU?=
 =?utf-8?B?elBjRE05OTJzcVU0b2NiVjhSZGg2ZTBJNlJPSm16cXFtY1Bua2NlYW9XU2cw?=
 =?utf-8?B?S2pKNlpBQWRPREZrVDlDOHY3bElRR3ZvYjlUeGdNZ3lqUkFUWm5wb1ZPaGNa?=
 =?utf-8?B?Z1JnZGp0aUJMcWFEblFtOUhrY2Y4eWNPR21oVG9qQzkyN1k3UnM1NmEzQ3hX?=
 =?utf-8?B?VlFhRkpDQllIMkMwZXcyQlM5bDhBc2FmWm41ZXo5QUlWQ05EeHBtZlZzMkMw?=
 =?utf-8?B?MTR3NzJGYUN3by8yVHdJUVdzOGF2Q0RkOU1pTkU4d2hwYTBvSXNsQzZWNUZL?=
 =?utf-8?B?enZvNkh5elp1UzRLNytDVm15VjZyZlFYNzgyRXlDUGdCMUJRM2xCWjhkSnVr?=
 =?utf-8?B?WjdIOVdvUEI1a290eE9SOTN3S2FkM3E4UUc1bGVmNU9ka2pONlRGSUFiTlZU?=
 =?utf-8?B?VTV4QUZ0TWNNaUJncW1pbHd4WlpQN1VjcDJYMmt2Yi9CWElNdUkzOTRIMVRU?=
 =?utf-8?B?SkQzK05hNE5UMFFqczNOT2RQNG1mbHlubmo2TGdadHd2ajN3T1F4dndoNXVp?=
 =?utf-8?B?T2J4OU9RdlJYM0RxNXhhSVZXYzRqRy8vL0hkNVZmQkdJZVhiVEhxTDFHeE9m?=
 =?utf-8?B?ZVlSeDhFUWp4c0NhNU1aV2Y1K1hkRDZkUnQvQ2ROYmtaMzZ0eUFCWTZBTmdF?=
 =?utf-8?B?SXlzNDF3NjFqOWU3TmoydmIwWEpHT1U2Yk5udGRoWEFiUVJWU3E5VU9yVjNO?=
 =?utf-8?B?RHNkUkI3WDNGZEZKVHJhK1FYMzRKVEwrak1BUVdpN1VJay84UndHQnlEakRx?=
 =?utf-8?B?WGsraktGUEtsQ1VlZXltOVUxQzkzWGV0V29rajdLTjV2Q1BYSmVrb2RoUWEv?=
 =?utf-8?B?ZGNuNzlsQ1FLS0xXdENPWlFsTXp6YjJEZXVBaGtNYVR3R0JKa2xiSko5a2lK?=
 =?utf-8?B?dVdsdzR5eXlLRFJNRmZwWk5pL1REOVNNZTkyMFQ5dXNxNFljRWg3andvVksv?=
 =?utf-8?B?OUFoMlNWMDVmYVR6QkF5UzhVemU2eHFzUzkxMVlicFJVTGhZRkZYMTZ4S3NZ?=
 =?utf-8?B?eHZ2S3I2Qnpva0FRSk8wVFpZTWxleTc1cUZjU2RXK29wV1djM3RJKzQ4WEpT?=
 =?utf-8?B?N2FFcjI1NVkxUjB1MGt6bjBuOTFPYkFiWWpmOStRdlhZd2lqWU1GWit2ZEE5?=
 =?utf-8?B?MTd3TWJQWHJNN1UwK0R2elVhRGo0RkJ5cWdMd1ZmbDBGYlBSQ3JyajQzZk5N?=
 =?utf-8?B?NnIyVWhQanFmUGI0RVZQdDB2MXcrVVR3bHFGRVVOeGk1MFNvMmZVTVkyOW9k?=
 =?utf-8?B?UFNjODFyc0Y3YldRWUduTW9QQXYzbVZHNGFQMkUyT0VXdnFlb0NhZVNNa00r?=
 =?utf-8?B?SVNyQkpxM0FhOHhKL1pxYzJXM2c2ZEYxK0JYK21oZU9uaysxemQ4ZTJBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UCtZUkVsYjNTQ3ZpWmxrZ095ZVpycVlnb3FoSDRXNVg3czg4eExRdGIwRnpy?=
 =?utf-8?B?ckU0K2N3NExzWCtoYjYvSWNZSm9WKzdnM3RJT1M4NzF1R1FNNEVqRE5ES0Fk?=
 =?utf-8?B?c2hNWURYSEhkWmhqbFBiN3k0TGhWZ3Z3RU5vbkZwZWpSQWdKWmROVFEzWVht?=
 =?utf-8?B?WW1IY2RLM3Z2bE02RUxmTGVxQnFxc3NtVnB3dEJjVWliLzZTMTcxTXV0cmJy?=
 =?utf-8?B?bWdFTGFtZnJLaG5tN3JGT2x0bGlGM1VSTnc1RFJMSWdaRkdGS3lxaThxSjJF?=
 =?utf-8?B?ZU9yYjZoM2pPUUo2ckxYbE9IcnNLQzBDVHhDQzU2VXVac0ZlTWt1Rm44Q2pk?=
 =?utf-8?B?Q2U5QjVodkVjT2JVbTQzRlBhN3FwejlyRXh6OXJTdVYvbVlFRk8yVWlSZXlj?=
 =?utf-8?B?TzRLUlNtNkVLOWNyMEtNUE5hcXVYSElRSFVSbHFQTlpwQm1ITGFUOUZrd0Fj?=
 =?utf-8?B?YkR0c2drOHpLQXh1bEdzY2cxK29CWlpveHR3d29NRjgwVC9Ec042WklWditD?=
 =?utf-8?B?cnJlZFIyd3RnY3FVTjF2OHBIM09MUUNvalRVRzZQSVNnZjM1NWF3K2RsdjZL?=
 =?utf-8?B?UjFYaW9FVGgrL1dMb2UvK3dVUTFyTFZScEQxV0kyb1VRZXBBSEFQZFhsVWky?=
 =?utf-8?B?bkNWNFprRzVkTThGSTVlMUtob2tDeWsrRFFPd1IvNzdrMStDRjQ4cmJMZEl1?=
 =?utf-8?B?R0Mrc0tHNmxQSG1vZUx1QnhsenFVeVg5UEJrTlEyTE9aRUgyK29jaFVWb0dl?=
 =?utf-8?B?MW11Z1NhMFdJU0hmRWRGdTRQb3AyNjVINi9sdlB3dVhLKzlRallXcFdtL0hJ?=
 =?utf-8?B?WWllRzhYWUFLTWNadnRNQjNLL3BXSUNlak43eUp3VFluSUV1UUlZVVc1dXpi?=
 =?utf-8?B?cDVNYlVrNk1kbXE1WEtHM0FTb2p6eGtvL3BnMndmeHpITk5Lakp0VjRlKzJU?=
 =?utf-8?B?RnNKdlNxZ2hTNy9QcVFGM2VZb2w3eGk2eTZLODI1UG54N1lRUHFKT3dHLytM?=
 =?utf-8?B?K2pjbExLd0I1a01WUDBYTjBnV0pWZ2s0MkcyYU9GNm9hLzJud1NHZ2pJd0Rq?=
 =?utf-8?B?dk40UlMzOXY2eUNuUy9sVlQreUxVUHBobklsNllPTlVEZGlXdXBzTlFWZm1U?=
 =?utf-8?B?dmpIUy9aaFprMXZOQmNkanhDNjBiMG9OUFpMdThVQ0pvTHZPMlhWdUpJSkNw?=
 =?utf-8?B?OHJVNHpDaUcySUFSTVF0WUJRUVZNVVlFMTIramhHRlcyNnQraXQra0dLZ0tn?=
 =?utf-8?B?Nm1WcXhlVjVmakRubFFaYy9zTWpnWnlENHdzUDBoS2NWSUVYM0YzcWpFS3E2?=
 =?utf-8?B?RVZtT3FiSDhoQnRBWElvVWoxNVJ1Nk9xMjkwWk5MdnNZK0paamFhK00xK29r?=
 =?utf-8?B?b3A5VHhsdUpQdFhkZ3dpd01jNmxGMEhyUzI2NTd3OWkyZDJucThNcS9QSU12?=
 =?utf-8?B?M0RycHVWdDZSb2Fpb3NkeC90a2tSL1hJbzc4SVhtc2FsOHk2MGM3QnZtNTF3?=
 =?utf-8?B?dkZobnp0UzFuYVdHOHhESHlTbFQ1Uy9kdnFoUU14b3RvZTM0UHNUZ21tczVC?=
 =?utf-8?B?S2g3WWRtRnNyeWNPZWNLSldwdm1mOTJ0SzJ4bTBackFZUlkyTmtLMWwva2Q2?=
 =?utf-8?B?R0RJVXBzMEdOOGM4ZWNEemVYeFYyNVYvQUUwM1JYcjBZc0gwbWVkQUhyQ1ZF?=
 =?utf-8?B?OTliYnJ1VDRGRkQ0OGprQ0FEeXRob29mcTFxUlpkWlpnT1prRkFLVzV4ZXRF?=
 =?utf-8?B?MnYwcmRVTUNoYmZKSndlajU5a3d5b3AyNXc3NTJ1S3hsSGNTY1Jna3JWaWxF?=
 =?utf-8?B?VzJUNHYyWlJaQUNXUE9SanIrMmp0VHV5SWZFS0dnaE9DbUNta3BMaWZSVW9o?=
 =?utf-8?B?bm1SMmJpVUJ6VWFvT01xMkF2dDhTSStpbi96NndSUkoyUWV3Q3J1OUJXVUE5?=
 =?utf-8?B?U1ZoZDM3QjZUODQ3R1pzcVE1djVPMHRoWTM2TmM3WFVoVWFtbHZIVjdFdnFk?=
 =?utf-8?B?SG9Bc0Z5NWN4eDh0UkVUbW1wOG9xcTVvMVc5dHA5RkMwMW85aEJuRWlHK09M?=
 =?utf-8?B?a1RaVkcwV0o3U1RjbDBQOE9iWElCVHI4R3hIL2I2VnFoNGhkMHRnV295aTU1?=
 =?utf-8?B?cGttRDEyRTIyT0ZwR2ZlTXp2Q0VuU0FmUWFIMVBTK1lnTG05LzJEQ3V0YUxj?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	imGJ9tsKFEfr+vm7q0j+OqbwgGavE3TJZzhu/TVkBjzPfrFBrsk5YyFg4zXs2IwQiAM0jd/SBZCNKzH1Jmcajqd/6fxT1dInLDMR2dPKA/k8U8zRfOvHmbNgzyPh7I7t+x3WI018L+18ECe7sR3MLhE66R4TCCHS7rGN5ERB5xoCMzsZjYeC1fgh2QlvGrmUvqr/FR7REbEI09x1H3r7Kp1LfsIN9E6XGyA/g40btwuZ3r17xI5K69Sr4MG8SmRr5Kkl9fbqCvST4B+nu2kD9NmOlDKZRD1rHrzkxMdEjHLY65EJGvMXdyqXn4qMS7dmW47ltZ1wKofhAN7O23XLUm57gPoqEhoY3MoQFXvEXsrA9yX8RFWRSySrjMBAd0c5y756tzd07ev+e8mC9ZcqfIQtOPzmAqeExPaA1IGt5gtk6WHPvfocOUJnzct437HLUuaPVrrMrZJbFLQAQgK911EwortUNRPvo9tiJm3MlUXTXNhKzSdXFzif7C+s7dKFFFKYjWa4v10LhY/ddVufsxUE3gePrXdaF7QGIfDTQZY7+NgBRk0sELytObnXzsU+CePSTJSaMTMHLAgVWZSkd1BPOHUxMupp9i4u5p8xRGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ead4e42-2ad7-4e79-bd0d-08dc7a822b34
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:11:07.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3scE4KYhgRsmv5qVDvdbXuBk7WYiLaLrSrABvB8IxeGxJqP/FiefgtZQmK6rBeUOfbqoAOjtQpAf1NcV1IObpB5cxMOwvqnpfkVeEeMgaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_09,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220117
X-Proofpoint-GUID: FKqGV1ucydgWZiqNXS4LsAUl_KpKvTQc
X-Proofpoint-ORIG-GUID: FKqGV1ucydgWZiqNXS4LsAUl_KpKvTQc

On 22/05/2024 17:56, Jason Gunthorpe wrote:
> On Wed, May 22, 2024 at 03:37:57PM +0100, Joao Martins wrote:
>  
>> This is just to catch the case where IOMMUFD can call into read_and_clear()
>> without dirty tracking enabled and without a bitmap structure to clear dirty
>> bits -- in order to ensure a clean PTE data snapshot after start(). 
> 
> Is that broken then?
> 

It's not: The check errors out the caller ends up calling read-and-clear with a
bitmap but without having started dirty tracking. the iopt_clear_dirty_data()
passes a null bitmap, it goes through and it walks and clears the IOPTEs
*without* recording them in the bitmap.

> iopt_clear_dirty_data() sets the NULL:
> 
> 	iommu_dirty_bitmap_init(&dirty, NULL, &gather);
> 		ret = ops->read_and_clear_dirty(domain, iopt_area_iova(area),
> 						iopt_area_length(area), 0,
> 						&dirty);
> 
Right

> But AMD, for instance, does nothing:
> 
> 	spin_lock_irqsave(&pdomain->lock, lflags);
> 	if (!pdomain->dirty_tracking && dirty->bitmap) {
> 		spin_unlock_irqrestore(&pdomain->lock, lflags);
> 		return -EINVAL;
> 	}
> 	spin_unlock_irqrestore(&pdomain->lock, lflags);
> 
> 	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
> 
Same for Intel (except it has a comment explaining the why).

But it's on purpose.

> It certainly didn't clear the IOPTEs.
>
But notice that this gets called *without* dirty::bitmap set so it goes through
and walk the page tables and clear the dirty bits. It just doesn't record in the
bitmap.

> AFAIK the NULL should be ignored here:
> 
> static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
> 					     unsigned long iova,
> 					     unsigned long length)
> {
> 	if (dirty->bitmap)
> 		iova_bitmap_set(dirty->bitmap, iova, length);
>

Right, yes. As intended. When we pass NULL bitmap we mean that we don't care
about dirty info. But you are still clearing the IOPTEs in the driver.

> Not above. That looks like a bug. Yes?
> 
It's not a bug.

It might be too subtle or maybe strange -- I recall raising this as not being
too obvious IIRC.

All this doing was to allow read_and_clear iommu driver to clear the bits
without recording bitmap info -- which is what it is doing.

In any case I am happy to clean this up if there's something more elegant in
people's mind.
