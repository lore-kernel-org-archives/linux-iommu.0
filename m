Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05831A7FB
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338783; cv=fail; b=cHVr49q4jSevOV0kjofi5wSSMD95QY1sMtx0/vMFi+nc7bIgZ4vwDRFYk13leUU1IKG1RaJalNlA/Q0b7wCr0Lrs9YDXl+Z59YyOtUCxBdpEB/jVMzdsMnQk1TrEzPYfLG5ILwHuIUct0fhfUmfPsTb6sgI6v7DQ302wM3U8Rz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338783; c=relaxed/simple;
	bh=rLQIuySEgUUuMHi8OU/M1rlQVYTIC/kYYjBGuu9ccsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcA6kz/Z7gOdL87MazTpv0iKHIq1Pvfua6CVy9b89QVE5kIDJcBnLhkczcq0qLvhjYoxa/Gio62X2WBtJSFZh2CvO/U94Qey/um4rBlUQU5wOzTb7vHrz++5ppE2MXJoDVl9mge8KsfVQiAcye8KKzVajRI3F4YedPZRwOPY09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+OhB5cX; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+OhB5cX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7TpKE/IFJHODNyC1XRWxycDRhehracUUC/5JEnvVMRHQR/jby/0egx6Faz4ortDd8cmWEaJP0lq1RlC0KulhCJAgwnRXEj+em4hEk1ZD85GQ/FbmXOjHF8QC8LdvPtt6UUEDMFDlzHFouz2LXgeJwybwrcWHXGz6BSGw5fJIQAzEQWLvBToBCz8Yblt3a/X5DXUQMkp5mVP5SL00Zx6dzG1KKlM+NfIY+4Oa0GO7GNdXsGelVvh9f+Jvin9rGFoQKdsMGGkpBGPb0c65dWXlrtoTwuGGuzPFEm+oEfC9e0PG4J24OG4gNA88+jz3XlaS6E/Pbvr4c7EaVQSzyVztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzDbLRNWaj3hGeKX5IhOc9HCrzr7kwhk968DL8tLzRc=;
 b=MvwLi43+yfRwEUza1d0T3K82nRtS8sNvjvBkYAVTP4raoUWrJrjbm3RUXpR+qMgfqEKhgNA5gYhIgYOSDPTzzhWF8gsFagwYraFp35BGaf+nmJyKl2vCzOmKk2zATqqIA0yERz7kdARZEHtDVQ1IBfgAB9WO6QEx2gRfyzsO9sL0ZX4FL+/fUm/2/rDz3cIk/Ov/alW8ElNis+/NrVfUeaX3Eie+qjpuIptbqRO83vAvr4IARNJ2nhpYm6XNd3hV4Z/qVWOelgeJWWWwQ5D6jD2EAki/uSBDeVZ/msWl3deD159AqOCBwkCYswoHwXktFTMqHDVp1vdmjTOBTwY9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzDbLRNWaj3hGeKX5IhOc9HCrzr7kwhk968DL8tLzRc=;
 b=Z+OhB5cXd+XefoBSrGhXenV1gWhIsKm8T6Pk705vJQ4rrxMQfp4CJhjEpE7GKRxresMhXj6HpjevLuLP3kGwBPK2lluBVYe1G2v5Nc8bjCvuNIYOzO3Xm16zyxNKWjtUnu/ak0DNzdAHxTfadQSuR2IlmMEGLznuTkb+IfuWUGXd1gALSr8OUdEHrVqj/ocAg0t4LMQUqm3w2qxmDBWXoS2qOG7XElm1UzuYKdPE+oXwJgO31zWPGD3X6oNSgjOytJGOqfursnvEoobc9V6V0JA9leSlUsri0uZdbHzJbCPgiFZ+ZM0kv+voufZ9zTc5pe6Lk21xkhC6nzkHoNCo/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 21:12:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 21:12:59 +0000
Date: Tue, 13 Jan 2026 17:12:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chunyu Hu <chuhu@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Question: AMD IOMMU v1 contiguous PTE OA encoding triggers
 FIELD_PREP overflow
Message-ID: <20260113211258.GA955618@nvidia.com>
References: <aUn9uGPCooqB-RIF@gmail.com>
 <20260108005244.GA537065@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108005244.GA537065@ziepe.ca>
X-ClientProxiedBy: BL1PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d6affa-f7b6-4ff8-4552-08de52e88778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnJTKzRCS0JsL3JrbE5rZHA0QnE2N0xSTmh1SkxKaTJKbG9GNDJ5UGZFRGdp?=
 =?utf-8?B?SGUyY2RCRGdNdDlxZVdDWUxCTDcwanNBOEdUSGdDUk5MYWhRU2xGRWNNUlAw?=
 =?utf-8?B?MGxMSm1wQk1SQ0l2bWFuTGNYaVl6aTE5clBMeVFDbUhuMTdBRG9KYUthUkVZ?=
 =?utf-8?B?UzdhWEgzRGl5YndGN1BSN21ZbUZYS202MU1oTitOSTVqU1RqOW1pdEdMMDgz?=
 =?utf-8?B?VkRIc3IyekNVMUV0eTRXVU82THRBVS85dXNaSlFZSW9Zb1gxcmZKUTRjT0ZU?=
 =?utf-8?B?SkU2bVJRdzEzUnZDUG5jamJBa3NWb2IyOFF1aUxaQkkvRXdrVjh1T29rbmNy?=
 =?utf-8?B?RWIxWTNoZ05jWmxtVnZzUkNxa2VpWU0wd0RMM1hicU40N2plZ0NmVnIwWnY1?=
 =?utf-8?B?RmpVYktGeWw1MVRNM2dCVXNSc0JkYzhLeGNDc3FxSTNZNE5Od1FZM1pDRGNQ?=
 =?utf-8?B?Y2crVnhZMTV0bGFna3VFbldLUXZJN2dkYjgybCtnSVljc20zT01PMzRZemlM?=
 =?utf-8?B?alpEM3A5T1V2Q2VuNHpLMXgvMU5ieURSb0h4WllkT0hmaEZteE5OYkNtbU1G?=
 =?utf-8?B?akVvQmJzaXZGSVplZDNDcFNJK0NDSmplamt2YVo2RmNmMy9JYXFCbEhvVzBJ?=
 =?utf-8?B?azMrb0pHU2gyV1lJOHI3UmFnc1dISlFCQ1Azd3hDQzY1ZUo1cGtzZnFWRU5N?=
 =?utf-8?B?NUU3bENIcWtZTno1UXVBZ2dMVTJwNkhhOS9JTGhxeWZic0lidjJVaGdCUWdM?=
 =?utf-8?B?L3BDbC8yYk5lWjNhRjBwWktYYm1hQmptaStCR3VhY25uZXpvVVdXeW4rRGlp?=
 =?utf-8?B?MVBYRXpPdlVBRTNlalJpeXFoZmtHdWJ2cWVqdUc3NDA2NUhGMGRRMTRrT0dj?=
 =?utf-8?B?Y09lcWgzbDltcXRUa1ZPNUNOdmF0ZDdaaFFnREp3S0wwNFFoblpLQ2hscDNB?=
 =?utf-8?B?REg1M1pPWmpaa3JtVTJxbElrNXBJV1U3NFNWYlVUQnpYbXNUdkhUZkM1LzJ5?=
 =?utf-8?B?VmFqTXpDc3ZtRVUzVCtsZ0NzUGFMYmx0LzBBejc3WUEzWkRrbUIzVW5zMXc3?=
 =?utf-8?B?U3kxY1Z4S1k5bWJHV1oyUlcralpwdzBHZmVwUFFaaDNpWHdTYms1N0R0dUZB?=
 =?utf-8?B?MVJLWm53ZjYyU0dFajB3S3lodWVUYW5CNUdjY0hCVm9EUW5maU8ydjBOWVdz?=
 =?utf-8?B?OFdZRjlKNVJNMDU3Rm1UV2V0dE9aNGl3TGI1NnN6d2xHZmczY2Z1eHFLYnNm?=
 =?utf-8?B?S1gzU3VVS3BoTDlrSmZONW8rT0FwdVpCNGdiRk5OeUo5Q1JPd0hGMEFYVkVq?=
 =?utf-8?B?M2ZOcWc0NjJxcFNFc0FpeG9BNDgxaGRGTnNRMHdsSmtnVlh5Nk5xTW5BL2dy?=
 =?utf-8?B?SDlvaENpa1dJSWQ3aXZmTlk5VW9zNldaQkJqMEJwY0MyUDJNZHFiRHhPUnVI?=
 =?utf-8?B?aGtrSnRBemdKTzVzOEF5aUM3Ym1lZ2I2QVNVM0VhM0Nuc2RnZDloc2JSWFZO?=
 =?utf-8?B?V0FsS2ltRWNnU0gybS9kL21LRHI2YVkxUzVpeW41VHhJSFNGMDNDc01rcjNS?=
 =?utf-8?B?QW4xWXFFVy94UE9JVUJ2N3g5YnNia0ZOUFNhdmptUldzWG10MTVkZDFQZTJ0?=
 =?utf-8?B?ZEFIWWJOQXRTeW5NNVhjWllqYkZ3V3ZMTmdqd21ueXZqdHdSVm82M0tQZnZB?=
 =?utf-8?B?S1UrTnV2TXRvQzFVZktRdWtVZnl2R05vVGRoWi9iTTJTUFlPdHpsaU1EaFB5?=
 =?utf-8?B?NmVWdGI3L3ZpZEt2bERIQlRZRThsejkrS1hkLzMrZFB0QkVpRjhZcXFCVTFz?=
 =?utf-8?B?QTVFVnBRd2NJeG12eHk0Zy9mNkdQTDhnYWpFeld4dlJFRkNTYzczL08ralFT?=
 =?utf-8?B?aXBwZXcvdDdMMUMzTGhFTHg3SStJdWhwUjdZaGZuVDY5TDB5enNhWGlkRXVM?=
 =?utf-8?Q?HqCXZhx5AW/9dhhQ2EP2a0nGR0A4GG8L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHdZVENWQUxTL2hPMU5UK08rcndDRG82NytZblNlMUxNdENaMGhSNGI4dGR2?=
 =?utf-8?B?aWVWNU41MjllRVFqQkdwMWs2dndkRW4vSWhqSTZuL0FpMnJNN2dwcmRpNVpD?=
 =?utf-8?B?cTM5bEFhRE1ldFdCZnN4VUJpdFZhVXhLQitvL3BNemFvalV1RzVJUU54VTF5?=
 =?utf-8?B?LzB0elJtRW13ZGVlelBiVDFZd1RvbnZabWswYy9NRlh3N2gxQUhjaG1TTU56?=
 =?utf-8?B?WGdNeVFtdkdjSVpoanJXRDBJb0ZCZHI5Yms1NW5qME56NEUzblRXWVYvTEFy?=
 =?utf-8?B?R1RYT0dUTHl0VGtENHNxbUdxNDFqUTA3WUUwNTVLZU42V2U4TFJSYlI4NUpi?=
 =?utf-8?B?WDBHQmpXcklxNVZoTXJYUHAyWVpEQW1yVjZnUFE1Y21aSHUwV2p3ZGVOYk9D?=
 =?utf-8?B?VytNbFp4ZXFIbWVHVCs4Rys1OUZISUQ4cmFvaUlJblJDazJ5NmpjbDI2TXhP?=
 =?utf-8?B?ZDV5UlNqcjJpbktaV1JVT1lxcGxkWHR4TDM2bUEyMzdiRWMrb044MlgwYjk4?=
 =?utf-8?B?RlI4eFk2OWlkRHM2Z2xjWGZWN2FUSmlSa1dqd3hKYWpuUll1WFJSR0JFUUt1?=
 =?utf-8?B?cWJjR0hpQTNUVmFXV2JmYWZid3RQMG4rMlA0STl0djdZRGd5dkw0WWNPVTY1?=
 =?utf-8?B?bkhMcW9xRFZXMzNjYnpNeS9pRzNrU1NBM3huQ0JFTEo2N0VjUmJSNVcxN3J6?=
 =?utf-8?B?SGZhZG1NUmRKWVM3U08waDYwRXFUMENMTWh5cFFZajEzaTdKY01ScEZ0d0xB?=
 =?utf-8?B?bFJVcVNTT3M0OWZlc25odzQ0L1Jtd1hDUlRRbUhtUm9JYjZDYmhGc3BodUdE?=
 =?utf-8?B?UWZGVEtkTnFMUFRPM1A1VSt2V3dyaytKc0VwV3pxeU5oT3ZtUFRhbW9aOGt3?=
 =?utf-8?B?a0tiQWJrU1k1UnljSFMzTWtaWENlREdYbzBVenVBQWRVamJWMmVNWGUrS3k5?=
 =?utf-8?B?aTN3Z2RuVWh3cG1HakpyS1dHWUlZRFBpYnRoTGowVlJxLzBlOTlESDVUdGp1?=
 =?utf-8?B?RDc2VkFqNVN2RGIxMGJKYWJ1cFZ0WmlETFN1eU40VDBLZ1c1dzRSbWE4TFo3?=
 =?utf-8?B?QVM1eXlqaXdUNHN4R1hVN1AvRFg4RXQ3MFZzWkorSTlRRTZQem4rM3ZRVjVU?=
 =?utf-8?B?R0RyMktnM01CeFAzSWtzMXRwelU5NVZEazVuSmNiTHpaS04zTUNWeGdJUjVp?=
 =?utf-8?B?Ky9tRG9YK2ZzWWFsbzF2Y1RvRnd1TWNZVXBkY25xeFFNTGFteXdkc3ZWL2k3?=
 =?utf-8?B?eFpDTkJpdVd5L3ZUSUkybGN5UkJWWFJrZnhqYjYzdTZYOVZtbnhvcmgxVTNy?=
 =?utf-8?B?WE1ESFNyUUZuYVhhSGYvc0hPWStBRjgzRjdNRERWQXhFSGdKeEQzUDNWQmcr?=
 =?utf-8?B?SC9hZE91UmhnZXdUVklkQ2JkVGo4Vm4rMmtYOUZVYm5tZ0hxRmFzYnVwNCtE?=
 =?utf-8?B?ZmpxQ2c4S0Q0WFZRbXZRVU1ySHlwcWd5blhLNnhCYjlDUytFSjZ6UkJrL3Bu?=
 =?utf-8?B?V2FWeldEZEhxa3oxeW9JcVNhcVJXNHFVdk9wRWVHWTR2YnJwTWQxTnJGYkpt?=
 =?utf-8?B?L3JCWS9DbmZoMzZwaU95STRrbnd1NVU4M1RaL2lIK2phbVluekdPc20xS0hD?=
 =?utf-8?B?WmtNeEgxNkhiN0t1RmUvVUpMK1lkdnRNbWZvWHA1M0tGd0trL3JoZStPLzEz?=
 =?utf-8?B?aHVCLzBiSENNc1ZKVHArUzBjR1pzUjNNdi9Qd0dwSWd6WnZBZ2JqUjA0RStU?=
 =?utf-8?B?a0ZQa3ZxalluMzhabG9xQjdpSmNHZEVLMlBzK1UyZjlyOXJEczQ5dVRzOHN5?=
 =?utf-8?B?azZ4NWFNalRraTBaOWRLLzRIamRycWc3eTFMWG1PaGRZK0lFOUhPZFpyMVU4?=
 =?utf-8?B?YkNHUWdzWXVEQ3gvaTJ5Z2tRSVFubFRYbmhPYmsrYWVjVVAwOWgwMk5MZFQv?=
 =?utf-8?B?K3J2cytzVTRPOHNCWVlRZkU3My8xdFd2MUdzZVNqTWViWncxdEkwMXBqa3BB?=
 =?utf-8?B?OE84K2U1WFovanE1VUFkRm9Pb09MRFduczJXTXJxRVBqZmZIWE1pUVZ3Qjdu?=
 =?utf-8?B?ckhNalhGVWVobDg4SDQzOVZrNXFad2lzVnJUMy91aW8yRWRkb0J5NEIwZVZX?=
 =?utf-8?B?VklXQmZHRDNOS3NtQlVzRTRMN0VyU1pMRDlxVEZ6Y1ZUVmRiQmJkMW1NVGdo?=
 =?utf-8?B?eEtQR3Zsb0tqdk9waDV4YjIyWU9YWG5Dek5NUmwxenFydEx1MmFVRUJpS1h5?=
 =?utf-8?B?N0hTZ0lsanpmSUdjRk93eGNXNUFzdU1QTjFGZDlCWGxJQm1BNS9rLzI3RE8x?=
 =?utf-8?B?Y3Bjdy91T3ZlUjJSQ25BWEwzZml3QUw3b0VVVlpTaTFEbG1FcVRkQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6affa-f7b6-4ff8-4552-08de52e88778
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 21:12:59.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG15sZXG4wSguxXAt1AFTm5SaKZdJpsTBFDs2YAx0oVzT/dM8YdKuHuIt9oNi3Lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

On Wed, Jan 07, 2026 at 08:52:44PM -0400, Jason Gunthorpe wrote:
> > In file included from <command-line>:
> > In function ‘amdv1pt_install_leaf_entry’,
> >     inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:651:3,
> >     inlined from ‘__map_single_page0’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1,
> >     inlined from ‘pt_descend’ at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
> >     inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:658:10,
> >     inlined from ‘__map_single_page1.constprop’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1:

Does this work for you? clang 18 hit the same issue and it fixed it there:

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 14a73d3b291b42..a46f1dadefd521 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -691,7 +691,7 @@ static __always_inline int __do_map_single_page(struct pt_range *range,
 	struct pt_iommu_map_args *map = arg;
 
 	pts.type = pt_load_single_entry(&pts);
-	if (level == 0) {
+	if (pts.level == 0) {
 		if (pts.type != PT_ENTRY_EMPTY)
 			return -EADDRINUSE;
 		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
