Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A11E521
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842163; cv=fail; b=uDLKoujGAoadn16RfnyA5VQDfQ9NIQz9vCiHqcki7IOoTeLDF5jzj/CVSoin8oM2/xN0hoSUV0zcU9xK07oU+ySSLBUBTVSpz1STAvVuURDYoRIZE0c0Z28O4k9XRxeBkGoxpDo0H1zPv4E8QCecRV6d2mgNb1amhbDhzeK6nK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842163; c=relaxed/simple;
	bh=CnodF5AOhNsotkj1VJVmsD3DD1+hhmUl3TRE6JSHGJo=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=ABHiStZqrBM4QiHP4hkv4PJF6x9VDI7KK4Gfyvg2YpQ6HCG2YkwuRLpsJRX01FmH/wHhtiDWV7/nUy9HQ48KcX9JDwcbrZkrbgPXFA1Q7CqjIhoH9hjc3UaN51sBS1mavqjNuWk9/pJujmtuB2ijBMnRcSM0vZqQ6ApomtIz+Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbU6O7WV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qP3A1Lw1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbU6O7WV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qP3A1Lw1"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBfDwp026701
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 14:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=S
	plNKOecj8QBQcK7C4EIIYiwyJchNAb085LpXmwJ4Rc=; b=VbU6O7WV7/tBNnV9/
	tN5mL64GlwkfcE7QYFsefcDU8b1K4Ba+mNEA5Wy5Ssg0QvjJ37D9q7EVx0PEYR9b
	QP9Twqjt9ZRqZHJKAt+tNRMqwjuFgvCwb8msVYowqUFIxvQjzxwVMD9IZk8iwUWa
	0L0SOvXzmNRxHoMrn8FIZ2013+amoTaX7UzDCiiokhosIgt1r6xV9xaJ5241r11S
	yfwMWIKq2kX7dk/BYc5CR2ZgW0/twzbuBPtKIg9YQvfvYCPTVRGfjmPOhZvsN1X/
	jOaJNMC84eew3BgL/HpeXfiop37JWjjq3naXyaHEh284QnTm3Wc131bpt+kJf2ac
	d7cyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nspyeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 14:22:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KE4EaL015047
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 14:22:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg7gjg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 14:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=porvJFSj2xj59Mqt/meg8Kt6akg8A5cnR/AXrxPiJwnqEbsVq4B3lGZzZMNo4KjpnwyuWOPsVOXTv+ZKA7y+j8m572s2EsysGv3O1hMOwJaz2ugPSTFIJkHyoBpRcvkWv9b/S7mWP3LRrPmaxGdlxLgSf5EJsDOw/7IlKwM/0mb1Okvq34iN26Q4LA0p2itkd2gXoxqcacWDEgrNtZvOoMRtJvXp3PPFNpawBZDfFrIHkatDy/Cxugb4c8cBOmp7RGvmPKWeDtB14qD9NLoTfYMsI4nKUEUOQBMgRCCJuLbI7Xiu3yhuIay2HE0Axj7W8NTtZtE/88un5R9HD3cLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SplNKOecj8QBQcK7C4EIIYiwyJchNAb085LpXmwJ4Rc=;
 b=WtIt0Ts/QJVBGboYnyxyz0dGi+LRHB9oCk2Imrg7R2T5UNQw06jAEi/rc9cWEI8S8AULt2rcXGfyh3B/zdE9njvOXro+Be52O9P/cs+7x1KUx1ePyW1iyvpfpz9LzTW900qJLu1gGwn3oTvSBf2fAPMEgASWdIh09rty4LhfqZymWqLnnm1dzpjVlbw4TM2YMqwmxBxxovuen7pTo65P698peSgG9W4o2u4DPpy3215ALvoCh1bgwTO7RsL0iIXD20jQPf7VnnUacLUHxkshs/dmahhst++8nPTIhBEBTHtC3mlDQMjWWn40DL0GDLczro3csmG8GiFGP2xTqV4/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SplNKOecj8QBQcK7C4EIIYiwyJchNAb085LpXmwJ4Rc=;
 b=qP3A1Lw1OUe/zsAMlgOLQOLVOIO02+CaROU6vKtdB2aS/gYlKIBOjpVX9iwsttdORf/Woxcs3MuMMG9u362wXW1DXfN6E8XZlbVGdKbweuuqjztC41guraSNi0CmXFtLN0UR7Po6uc0V3e38+jB3TOj6n8dKxepWrM4NiNPLHZg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO6PR10MB5571.namprd10.prod.outlook.com (2603:10b6:303:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Fri, 20 Sep
 2024 14:22:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 14:22:31 +0000
Message-ID: <d4475e43-0d6b-4f22-bd26-37f62ccaa1d8@oracle.com>
Date: Fri, 20 Sep 2024 10:22:29 -0400
User-Agent: Mozilla Thunderbird
To: iommu@lists.linux.dev
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Subject: running iommufd self tests
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0891.namprd03.prod.outlook.com
 (2603:10b6:408:13c::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO6PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 590d375f-dd6c-4d98-0df9-08dcd97fa986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDZjcDFvKzRkR2p2N2svNUpkL3pmS3VCdjV6VWxpZFd3U1Eyd0Q1TzdvZVRD?=
 =?utf-8?B?MitLWWtFclNCQjR4TkNXNlhtZHpxUzBLeENCeEVOYlZ0WWVzYmd2N0JZQTMv?=
 =?utf-8?B?OEtNajBzNU5oSzVQOUl0UjhadjBmSTM0VWtKcVJGKzdXOFRGZFp5aHgrcXZI?=
 =?utf-8?B?L1VQWlpCRjZVMXBpbFJhbHMrdEFocEt5N3BuRytWdHlFWHJXR1FlbWRkU1E1?=
 =?utf-8?B?Q3FjbTF0aStyTUFEUWxJSUFTRlkyaGxGS3JhNmxwalZxdnV4Q0U5czNjdWNm?=
 =?utf-8?B?R29PWGJPZVp5L0txQUNncERCZmlpN3dveGc0RUl0ZmZ2bzEzcVpoSDBsS1NU?=
 =?utf-8?B?VEJ0elNLa1lLUXg5b0dEVmtKZHc2eG1ITU11a0JZbGlwand0WE1MMU1sR21M?=
 =?utf-8?B?dHQ4bFFYOC9BWi9JVmlWZW9aTUpCejMyM3JoWDJzSXdiamJJbStrME41bXpT?=
 =?utf-8?B?Qi9nVU0yQk5lS0cwa1VGaER5R2VBdEpmSGhYUmE5VHhuNlhIZUxCbjkzcm5t?=
 =?utf-8?B?Nlp5NE1OSzZwT1Jqdy9oVHFMd3B1MEtXZ0M3VFZibDJveGRZSDZib2QwUXk5?=
 =?utf-8?B?eFFPLzJLMk5SaXM4QTlHRnFlYjcraCtoSzN4Y2dmZjBEcURWZldWcXhQekxD?=
 =?utf-8?B?ZUVqdU1BMXN1Rnp1a2lNY1VFUkFTVXJPQlM1RW50Qng5M0Z5U04zUFhHQmR3?=
 =?utf-8?B?TEh2Wm03b1RFRzF2ekhjSHo5cnIwVmVKYk5BeCtHM2JWYnVIbUtPT3ZOUU1u?=
 =?utf-8?B?NGpFeWc0ekJIVUVhY0VXOFJNcnM0MlJGSnpSYkc4NVQ0Qnc2NE9leWcrZ3J6?=
 =?utf-8?B?emVyVUhaU1ZaSDM1My9UQXJ0MHpPN2gvTkwwRlhSYjBIVFZwREJqZ25zNmJC?=
 =?utf-8?B?UkU1WmplclNNcmd4aW5OMG84R0lCY2RjaFdEVExvL2F1Z1VySGpUWXJSMXIz?=
 =?utf-8?B?Y1lBZjhXTFFUVjlLdkJPeHdBby9TazN1ZkZ5UGoyRDVjVURzYnBvU2xHV3li?=
 =?utf-8?B?cXAzOVoycmIvL3FkbnVHeXBkWDNRNy9aZGFkczRDckg3YlRXMXpUU3NaTWw3?=
 =?utf-8?B?cGExNmE5MGN4RGlVaTN4SnpVS003dXNmMmN3MUlHRjJsaUtIR2wvUVNzR0xB?=
 =?utf-8?B?NXJKSWpXa3RrRlRoOVNyTTcraWl5aG42Nmt1Z2d0MTNwZFRtYjNXV1hqS0gx?=
 =?utf-8?B?L0M2b0ZibXdEcFlTZUtGZElUMkdSZ2R6TlJGNlVDYS9zM1QwODNWaGN3NWk1?=
 =?utf-8?B?UEdJR1RtYjRIMllRVVN3K1MxRklrK3pQUkRlSVNhTGpuWStlSlpueDIrU2h1?=
 =?utf-8?B?aXNRZ1VWK1ExejBIRmdpMTk1SGxhVHJTRGtuWVNDN25VYjRhNXNadzFQbFg4?=
 =?utf-8?B?VTJHWllNNitwNDYzNlBRZ3lyRVZBMm5pS05RRS9PaDNOdmJmNjlMZ005SWI5?=
 =?utf-8?B?QmJEV0sxWVRicWxMelVsazZWWWREUWVZN21zQ3kyNkw3eXJpeFk5VU5QMlUx?=
 =?utf-8?B?K1hlM2c5TUVHenhHUStxRGFESWZ0Q3Vzb1UxSTdQcnVSTEFreUc3WHFjQkFY?=
 =?utf-8?B?d0I5bFIxQ3dvU2l3akpGRmQreVhGZVdUdmptYTNCcEtPLzJCQzNxS1hsMGdK?=
 =?utf-8?B?ZytWSUJVWGtqWDdvNmFtWDUxY3dadHIrTXNYUitjb05sOXprajdKMlc0cU15?=
 =?utf-8?B?bmM0VmxvV1k4eTA5OTNxVnRxQVFETTFLVFFJanoxcVdXYk5jUTcxSjVaYzBp?=
 =?utf-8?B?SThFRCtsSEV3YW5FWDRYRUVDZ0MwQmhmUXhrWlZzTHdXZWNoa0Nvby9BMFpS?=
 =?utf-8?B?Z2dzaDNPS09Gb1hsQTUzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdFS3FpT3hCNUpHTU9kRGI0WUdZT2txRjZmclVUc3l6VW9zM3pOQWRkY1Jy?=
 =?utf-8?B?WWJ4YTFLT0lNOUFWKzZicnpBRXdwL2VJQ3VlZDcyVzU1ZFNIRm1jNFJoQmJm?=
 =?utf-8?B?QXRXZFpwNjdjZWlkNlB2eEtLOE9KNlpFM2pKbERsQkdkbFUvNXNCVVY5dXhY?=
 =?utf-8?B?VTh4L1IybVI4ZmRHM1ljN1U0MEZnZEtRV2ZyYXBMUVJHS0IzMEY0TG1Xa1Rp?=
 =?utf-8?B?dDdCZXFqWjYzZmVaTWc2SzB6SE5hZXM1ZEkyemlwWm0rdHlXQVZETEdxVG1M?=
 =?utf-8?B?ZEpZYVMrYmVHamtwZXZuRXBoakNML0hyZlM4blI0YmxobUc4Q1JFZzYzdVdS?=
 =?utf-8?B?YUQzM0NjZ0RmQnhhY0o5OGovOWZUT0FZbmJGOUk0a01YbHRUeEppNC9FVDJr?=
 =?utf-8?B?UFM2M1lZeUVkbWtOd2hrTi8zNXFZQWtmSkNRYWhNU1h0MU5RWUtLaEFCVUZY?=
 =?utf-8?B?V2drMXZ1YXpBaEJsVUxRT3hIVzlablhVSWhxbXNFbVJLblpad1dQZGl3WmRJ?=
 =?utf-8?B?UEZ0TFR1NzZodXBvNlhvNGlYbXJBbEdYdk50anlONWZiOCsrdXQ1SDdnZmsx?=
 =?utf-8?B?TzRWZlRHWCtrWUNlNkxEOU0vdE9qVkpuVzdQQm5wMzlqZVVUK2xqdUxKVTRB?=
 =?utf-8?B?UTZKWXl1NG96L1A3anJCRFZqV29wcnZmWHMvT0hqSVNKSXBRcGs4UktvTWlr?=
 =?utf-8?B?bEdqcGJ4SzRGZEQrSit6MDRaTklHZDdzeUZCazZudXRrZmJlRGdsazVNQlJB?=
 =?utf-8?B?YmhXWGx6cm5RTytSMWFWeEM1NGRFcFFMWGFRbXN5eEIyS2pVMXpFaitCclV6?=
 =?utf-8?B?M1NWbzc3eXNGM2VKQURmczdYUWdSN09wemhpc3I4NWpleW1QT2kwb2xPajlp?=
 =?utf-8?B?QXBGc1VUMmd1SmduaDJZeXViTytIUFhSQVlpTWRQS20ydWVqYzMrUElTMnRn?=
 =?utf-8?B?RytsS1JzS0xTdVVUMmNzMStBWG5tSTFZTUdKcVd4ZkxEdVJKZTM0aEYxQmc3?=
 =?utf-8?B?TlkycWU3VnZJVXpMVHdvM1pFY05abGcxSFZWclFlSnVBQ1AzTzNBUkNqYUtO?=
 =?utf-8?B?K2tGa0xEbEhwSzFzYVpBVmFDYmhUQzQ4dlBaT0t1U1FUdlVkM1dIQXQrRXRY?=
 =?utf-8?B?WUNUTUkxUEdQelZLdUpEUzBkUWdMeUNwVzVSS1M1UURyNTROMWs2R2FldEhi?=
 =?utf-8?B?RDhOMmQ5TVg5WGl3N2hSZmE1QU5QUy84SmpEN2JmMkgzOHFFdGoxMi82Zmhv?=
 =?utf-8?B?TjVIVFZGYnB6Q2xtcUpJSG92Z1UyNzZuTVpDZHB6L0x1NXZvZGlhWG15d3Z3?=
 =?utf-8?B?d2VNcXhhdGNxNGhiWDdsK2VMVytUOVRMSzlrd0YrSzFXNnh6SGdFL0FIYlhx?=
 =?utf-8?B?cDhUMml0cWlzMTM0eHNZakpLVzdKWTNWcjRLQmZEMjd4dFZJSWZwakxDYnFt?=
 =?utf-8?B?cFBueG1lRVJNZGMrMXhLbDc1RTdNYVRuenFWcnZkSE9KK2xGK1F2MVRGSm5S?=
 =?utf-8?B?T0c4RENBMnJOaWdScUhPM3RjVWZXaXNvSm13RjVBenF4b1dlQXRHak5Oa3JW?=
 =?utf-8?B?R3VGOEFsRVVuaE9YQUJjOXU3TzdGVVFXbHgxR0VVTmZzQmovbHFvTjczZGhp?=
 =?utf-8?B?UWQ0MGJHcENLNS9BR2FaZ1N2ZHF4SXNia1g1RllDeS9EWjUzclhMOTNnSStX?=
 =?utf-8?B?cU50M0hRY2NuSGc1bHhqNloxS0RKTGlLSmIwSnIxTHlJMHNDR1JsenI0YWwx?=
 =?utf-8?B?MnZCWExWcWMvZ0NrUFoyMDRsTllYQW55SVVlLzFMc0pvcnRZQ1c2OFVPLzE0?=
 =?utf-8?B?Y2ZRcFpka3VMTWFtcElyVTMvTjlKSG00SEUrOHZ1a2EvYUJTcnBjTXI1aHZs?=
 =?utf-8?B?ZHZZd0VaN1VXTWJpb0locEZBKzluVmRyZTM4WC9ZcDdMVUFjTVVHK0dDVnN3?=
 =?utf-8?B?ck1qVTQxSHJ2MWN5Q2tPZWlwdXY1Y1U3UVYzbTNzeGlsNnIzVGwyRUdBTlFV?=
 =?utf-8?B?YWNlSFY3WVZSWWEwY1hENERHcmFWVk81d3VDc1Y1c2ZjQVpuZUQzWUxWV0g0?=
 =?utf-8?B?b1N3Q29uUEovQmxNRExXRDBpZHBjS3lxMWNUMTVqZi9icFltUWtybHV0NlpQ?=
 =?utf-8?B?NWhmU1pIL2o1QjBGN0NLRkRhckEwMmEzNnJxeGVZMmZOZVZOUm9TMUdBU1k0?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4xfFg5UlWsTrB0mCmbCHwdo6fSbg0GkCFiNcu0+z+0YXXCuamL11Xe6krwftvOLPC/PpAqySjPsTABcUrR0SSLfFxINIyvd/JQ+6iAUveVmMe98Z956iKxMxWgOM37PiDR3k1x3pIjfPxcbjFoShHkyc9flee2UB6bFgqD72VBlqyNjkOgPnX6KlQyMcnabHq6hPceYYhsSIHtK0v7KeORW5MmID9IwYbQJkOhBSx6JRu+jjiTlWS632wzCaP33N3leRYx9CrQTP1OD10GcsDZnuVhBPKmFUVGPTYyaDvD3V0YkguyFRmIaQn1nS29a5BGwXumj/eqw0dHEd6AA8eojtnVLZma7KU9eZH5C9qu3sb96Pb+rSAAudEQnQZDdryKo/IyGc04t9r++zlvXXdjrQ22l3xfq25JFrL0FLFYo8l0MpgIEyVMF5xZ8RhtAAbZuQrthxkhwckYtNxFEU+3uk7j+dgHBMIi2mJ4mwUIBb3mqUXjNhxyQapxSPICPaDhaSvzNeyPU7mER3G5PGbXJ2wcClCsotgE3OGFeofkHqJ4y2kyaQ1N27ItZEt89qe+NqvGEEMde8k7OAnF/eX9i6du6+1DingEF7NqXDhDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d375f-dd6c-4d98-0df9-08dcd97fa986
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 14:22:31.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZeMjxFD9PtYU0qWKaMGjz0SVRobhhZjYG1Pgz1yAw+Ymf1AFVBXZx526XEUC40BMIQJn3L2JBUzQHL9c3I2Yt3iMWHW0N6tzje6n2/Ogto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_06,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200104
X-Proofpoint-GUID: pM6EPofnkuTHZdZ17ZUFxwKB6wiCzoCh
X-Proofpoint-ORIG-GUID: pM6EPofnkuTHZdZ17ZUFxwKB6wiCzoCh

What userland setup steps are necessary to run the iommufd tests?

I build a 6.11.0 kernel with:
   CONFIG_IOMMUFD=m
   CONFIG_IOMMUFD_TEST=y
   CONFIG_DEBUG_KERNEL=y
   CONFIG_FAULT_INJECTION=y
   CONFIG_RUNTIME_TESTING_MENU=y

and make the tool:
   make TARGETS=iommu -C tools/testing/selftests

and try one test:
   modprobe iommufd
   iommufd -r iommufd_mock_domain.one_domain.basic
   FAIL

It fails in ioctl(IOMMU_TEST_CMD) creating the mock domain:

   iommufd_test_mock_domain()
     iommufd_object_alloc()
     mock_dev_create()
       device_initialize()
       dev_set_name()
       device_add()
     iommufd_device_bind()
       device_iommu_capable()
         dev_has_iommu()  <-- false because dev->iommu == NULL , so fails

I suspect I am missing some configuration steps related to the
iommufd_selftest_iommu device, but I cannot find any documentation.

- Steve
