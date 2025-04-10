Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCF26B97B
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279063; cv=fail; b=NZoUF207+FR9SHVmsA80OkBKD9xO4YTIy5GOyn6Pt8D6XfultPOT2cuVeqrnCLBS951fspoX1tSliOqt8+7s8jFHQgWE17QY5T7SxMuT41+Oa/uyd9J2Xr7tZ+88435hE3OSKTDNG4Th7Oe9YO155HGvbHSIw+Os2uak7rLCeUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279063; c=relaxed/simple;
	bh=RC4fKvg0wqzr0ElNGRJpeHRykIGkejswTSvAToC2Kg4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KEAziFX1RmEk8+F9fz72S6xHsWXu9LsTO6nrI2XPhKthaNX9vnfLfrvtq9BQ/bFe3FRoiFQYcGaPiKXG3GMsqWneN6rJM6xU4yOAn3oWIbmMWfKvQFGPsmnVlFSwW2G/NL5W5oHqa6a0XSwKeSKYVXsHmiqr4L4SdDzbUuDuzWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HmnEeKGQ; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmnEeKGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtUSbMFDFqf6hWNSjycfwSiFG4BXKPdlFw2Q0bmb/pUwm//6lhrLj54voUR2Wj1RtL6CUFYcWMmBf62CcgZSJUie0LSMfQSWfa5aFToZg2Ddvw9H6UUM5r5LeCVbwplLAwUY5LnGKlbFEDNLIWEi/6CaYuYflA546+wyAruFKTw8GBWBYJjQ1k1EsHiEKY7Mm0hrExrssfFjsoxPx2V9xoDwB4mBZglJ7U+aOxxGpQjEZ/Rqyf1XaPvdtVkQ7W4/9Bgklzw+dvFYXkQmMQjtMHXqQmJGFcI0DR747OxMa8Hw9n8OeE3rhz4h6xxIruCAP0jVVFBBNiDq4r1Jtg53tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbFcv/QaDqVoy3tDTncfTvJXBaEAXQPjAxTEzSI62/4=;
 b=e3B1I+2gDLMP22IoJotmTu4hW/R7UwbCTZPElfQxty3eoMn6DyzKVysjf0xTtoCJV6rpyhN+DyibyIIPqIAw1SokTWnYKn/zh7GRxEJ8bM6dhiC1Um7nNB07GOrKVVoUdWtyKNhW6xI4vBzLY7xDlgYu/x0qEkF2HVhRnAvw/VFsfo7UqQZyzzAAV5rSl7WqufmfhPF0SUw9k8ZKgIrr7C0361/85jvGz8U3Y+xJnpVVkrM07vN4sB5voRXDFdwJW4NOjyEwWRAaaLr2Et51M6QogiHzxaaKE8qLefseFcal9dhrMSuRaA3AuaaYEKd8HospH2Y7iC8Jo6c7Mgojzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbFcv/QaDqVoy3tDTncfTvJXBaEAXQPjAxTEzSI62/4=;
 b=HmnEeKGQSn2Uuev3yxGp20Pp3j6WeQInmtqEModFTCDfID2M3fjdnT0Gv0tv9vf8riAXDMRcjMMO+hSi7qhx0jVpSfZSfCVAfsORWkrOw2YBbMm7uL9GR3TjdNSzHdveBkLutsu5lFUoywCA3NFZC8b85/lvKouxDHV+fkZ1KOworx36MCgM2JBCGzukAZoRb2KpVgbNPZmNs2Hc8XHQ2Xg8YFhkHyYksWDQ3esSN+0aa4MprrPbFXqdTGRhEYFQUlm73WBWGA/vuo3SxVrz0mVhF/XxDDBpJ0Vq1+67M+/R+hcQ/xLv/uYnKhEr6TV0/mHj6jbUYayqO3W8k4H+NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 09:57:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:57:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 18:57:35 +0900
Message-Id: <D92VBJWRTE2N.1O4IA5X7I1YFS@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Valentin
 Obst" <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <airlied@redhat.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <a.hindborg@kernel.org>,
 <benno.lossin@proton.me>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
 <20250410085916.546511-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250410085916.546511-4-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: de4226c0-c57b-4439-2c77-08dd78162088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bStKU1h5QTVvdHNRQjNzU0ZJNWNSYnRGbzdiUmtPK0k5VEVkNk1ycVZLTmRs?=
 =?utf-8?B?akJPeTExcWVjREdQNCszYmhlMjF1TEZnTHI4Skk5MFNWZnoxWWYwWU1KSElj?=
 =?utf-8?B?b2xpVXRvQnR5Z25BWmVZcXI1ZVJ4eWhORXNyVXZZSWR5dFpZNWMxckJzbE5o?=
 =?utf-8?B?bTluQk0ycW1COGhvKzJqVmRlRFpKQlVaZ2xSQkt4c0o1cHNjT3BMbytPRWVv?=
 =?utf-8?B?aDdOcjQ1czhrTS9zdlpaTFJtd2FnenkyNm9DYU5BU1M5MDgwVEk5bG9rcjN3?=
 =?utf-8?B?TGNRR3czWFQrYzVvc1RWN0lqOEd0Y2R6L25YTFRGOWQ2RVZEKzgzUVA2eVpT?=
 =?utf-8?B?YVkzSUpsb1BXQ2JhOW1KalQ5N2hTNCtsUll0bzlDU3k5b3NScDhmQUd0allY?=
 =?utf-8?B?ejVWa2ZTdGx6SXhmdjM2VXJOVVB5K3RLRzNQNWVnT1laS3RJUjBVRTMxSGM4?=
 =?utf-8?B?WnJIenNYblk3SVVFUkRvSWU3eWVWWHh6QkIvY1dlQWlNWnlUVHF0ek1DeEFQ?=
 =?utf-8?B?bUhhUHM4UExmVTgyRDljdHE2OXN2T2o5cWljdWFUdWRtV3QvRTdzUmJITG1C?=
 =?utf-8?B?VmI3blB6TXhseW0rZWVTVzRqTE85L05LeXYzb001dVZ2QnFnNEQyYU5XYTg1?=
 =?utf-8?B?Y0cyeUlMeS9kRWVUcTYydk82NnZQQWxYYXdTWnluamhCa1I5N1N0aTFIMnZP?=
 =?utf-8?B?WlJNcFc1STd2OEo0NldlNTlVNnRXdTBBRkNwSjYycThWM2tueWVmT1ZOcnVI?=
 =?utf-8?B?NEEwYmI4MkVZeTBheFhabVdtMmZBOG9GYmF2Sm04UGpPKzZhd29mbk1ETWpH?=
 =?utf-8?B?RHgwOVZHS056VXBzNHVFUHUyYWoxYkhTRlRlMDhPSEw5RlUvMzhDOTdjcE00?=
 =?utf-8?B?YnZLQ0NNSTlMZUh0ZFo0dUNoSFpKKzFSVERxVzV2UjY5d09SdGFQNitzMkJC?=
 =?utf-8?B?RURiYnNXSHY1aDZER0QrbzNNZWtZNkdmT2wzTmtsZUNjajJQMldpWHBMc1Z0?=
 =?utf-8?B?angvWXNKeTJvUEFlODBCenhxL2NnVUZKWDNUWC96cGVscW12Q3E1RW1vOU9D?=
 =?utf-8?B?bFBnb3NoQ1ZaeGtTcFpyRzVHYWJtK2RvMU5XNU9YUjZoakx2UUo3cE9RMU95?=
 =?utf-8?B?em5rOERva28xSGMzT0pXL3F5aGVmcGMya21PVFBXamlnTkxITjBvQklVcGl1?=
 =?utf-8?B?UDFOY3BmMGNycUFMMURRSWtSQWJZRDVHYzBaVHB5RTFxdHNXdm1OZE9zcGlE?=
 =?utf-8?B?YW9ONVJPNzV2Rzh4aHBrSmxJTUtNaUJFRVF0bGM2TGJEc3lyTUg0WGg4S1lt?=
 =?utf-8?B?UnNxbFhvZnM2bnRIVFNweGY3dVp4TVo5cDF3b0lCdkI2OTIzNGd5ZGVZVGdK?=
 =?utf-8?B?WVlZVUdMZWUzWXF2OENSaHI3cjB3TUREeUdSRWtMejFUSXZFaDdRQ2FyN2JP?=
 =?utf-8?B?L0wwMnY1bURBNlVZSmc1bDI5dGlrZ05DNEtGTmJUZU5Ya0c1cy9PUkZQVGdP?=
 =?utf-8?B?aXl2dTZwUVorM2FmVU1rbWdtanVoT2kxaFN6RVhpK1g3QTNjZ3hjM3A1VWli?=
 =?utf-8?B?bUVnTWNzWXpqRnRmZ3l2QmYvVjhFMlVydE5yK3lHbWF3eGlIb2FBcTJWc3lX?=
 =?utf-8?B?VkFZWUx4SXUvQVBZWXNEZUJxM0FWTjdJRVN4NjNLejZXVnlMakdqZ2U2a3d1?=
 =?utf-8?B?SmlqTHNjWFFYMHRIcWNMSUxSSW1zNVNBS1BmL2l4NkxBRFJmbVpUc2FhdDIz?=
 =?utf-8?B?KzFodVFoYlpRb0tna1doSmp1R3BpRlZjTkMwRzB1UVlQSExHRlFuRzdoY2Zz?=
 =?utf-8?B?Qzc1WmdJd2JHZk96azF4M1htM1gwWFZNYy9lNGUzL0pkSkppcEpTbzRyemE5?=
 =?utf-8?Q?qIfCoEoqwi8fW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZHb2ltaGNUQ1JzTy9WS1Q0TXFBSWdUVi9HQmZ3dVpKaER6K0o2MW1VSnR6?=
 =?utf-8?B?b1I1L0Q0cTRlOW94OWFNd3pwMEJ3RU4wMElYMzR5amY4b0ROWVA3QlRUeWlR?=
 =?utf-8?B?SmppbGNZcHVGd2g1V1grbFV0TVRXeHI0Ri9iVk5hOUtTWC9XN0lYQ3JFMm1G?=
 =?utf-8?B?TFBKL21nVTNCdWFmTkxIWVpFbWNISU45MU5scStrMHlKbGxUcWZibElucUFO?=
 =?utf-8?B?azI3ZVVVY1IvbEJ4MVN6QnpmQitHNHNNNm9Kalpjd09lcmpuVkNMbS8rZEk4?=
 =?utf-8?B?VTVmTTR5VHF2d04reXZzL1REdS9MV2w5Z1F4SnlIVmJ0SHJ4MGpiSW9SMXlS?=
 =?utf-8?B?eWNNMnhXYktjQmNkOHhuSjVzU2JBYlZwYlcrME5iNHZpY1pNMFhhVGpIaEQ4?=
 =?utf-8?B?UHd2bUlSdEo5OEhVbm1RcjNNcWErQm1Xc1lwczNiVmhaUVNvaWFGVC9rdmxB?=
 =?utf-8?B?dVV2ZkFMNHh2NEhaRk53eE9iby8rVHZDUFpRdUxvVDNWeXVianZBV0ZSTzk2?=
 =?utf-8?B?dExUcDJucHhNcWdjVk5VL3ZsYi82RitxY0R1UExwaWpmcFZKa2podEdtVFpB?=
 =?utf-8?B?WnA0ZW9TejkyaE9hYlR3UlpBOEpUNFZScitTRWFiYmR0Wkx5eXFGaHNiZUZZ?=
 =?utf-8?B?SXVnUGtGbFpienZRbndMWGd3UkhseERheGdTWnh3cDN1ZktUeFJXZnlsNU5K?=
 =?utf-8?B?UmhKdTVHRzhzdVY2QTlNZFg4QmJUZ1dmZndGWXNTbnl4SWNia2ZiUGs4Q1FP?=
 =?utf-8?B?K1NZS2tPaVNJVmdqT05rNHU4aXRlc25mekhjdE5va2Nrd1VFUldXMTR5UXNw?=
 =?utf-8?B?SmtMZklzMnVhN1VFT3NnNnpXeVBrdFpkZnljMXhuOUs5Q2llRTkyZ05rc201?=
 =?utf-8?B?TnJpajVlVGlhRFJ0RGoxV1ZTSmhxZWZYV25yS0VNQnh2b0srUks3cVNnUUZN?=
 =?utf-8?B?dTliU0t6L1FJekhmR1lWdDZMSFBHaVl5SUNuRDQyY3R3aVB2akdMaSsrTjVh?=
 =?utf-8?B?c3N2bDB1eHRnWEdTTHc2M0lmTStsR0Ewam4rOVU3dXBlMUpVZUF1dkd0TnRu?=
 =?utf-8?B?NlNxdG9XaE1qeEd3SXdiK0EyZmVxNTZCbzlVVVRUaGdUMisrSmVuY3JTNWsy?=
 =?utf-8?B?VXgwNFRyOEtTaW9PcUc4M2VlQUhWUDNzV1pDanNmZzZyMUZZUWdlNUFVRWpS?=
 =?utf-8?B?dTFXYnpBUXozUEVLM3JYWjFQSTFwOXgxWnp2NFBGZko1ek9ZNitHMGJFSlRT?=
 =?utf-8?B?ak1xNkNTdi9kSVA3ZFBVQVFNcVNmTjBqVFFtQmw3RzBJd29Vck45aHhKdUNx?=
 =?utf-8?B?K0h6bkxid21FbUJmaFo1Zjg4c2x6bVR2c0NZU2J3SXdySUlIOUFFcUJPZUJo?=
 =?utf-8?B?QmVObFkrUmROTlBXU3h2bW96VGRGeWc5UDM5cUQzbCtkRXEyTFZaOWtxeTJP?=
 =?utf-8?B?Um9odnloRk5ZOFhXZGxXNVZIbnVWWDNRVm9UYTZ2cldnRUs3VjgvRmg2bFdW?=
 =?utf-8?B?RHVSVitlZG9BWkZuNkM3YWpWblZueUtRT0RXZjluRGsyM2hsVkpFelJ4VTVm?=
 =?utf-8?B?dk1LVWZVSFBvd2hxaE90Y3JkbG9pV01xODdQMUEvVmE2UGdSOWgxV293Z294?=
 =?utf-8?B?b21xNGRLNXZNSHZWc2h3M2ltaXRDN0hLSnFkNlE4K2JBekpPK0FQbHU5cEFn?=
 =?utf-8?B?RTBTVFRiczBFcXkwNStYdC96NHJvV2pRciszdC9teDJHMk8rd0VuNTNOM08v?=
 =?utf-8?B?SG9SYXlMb1VyY0x5TS9WMDQ4RktoNVdnWE1JSWhDcnZYMEZZMTVTaERGL0pG?=
 =?utf-8?B?OUVDWUcybFhtN3FmSHpBS3k3QUk5YllLNEQxa0RSSlNwUU51ODlhTFBNUEpC?=
 =?utf-8?B?RDJldUYwcEJnWjhSUWsrYlFEZC92SlVYUTJNTklhTFo3YUtHUWVvMXNaVk01?=
 =?utf-8?B?Z2tLZnBTMlhBUTU5aUVWeFN1QzhNNGViakMxbUQ3UDVLMVpXOGVQOGhkajNG?=
 =?utf-8?B?VHlwbzhzNlZCa2N1VURMWmpGQzdWMWxmdi9SV3RQNEVLTnZjdFNUb29qdjQr?=
 =?utf-8?B?NnlCNitrYktLTHRUVFJkOXlKSUpCdHVRRkxGMEhGK1ZtM08zUTFRT2l0NTdH?=
 =?utf-8?B?MDdRVjRrZk1YTWNuWHNpWHg0OTcrc1Z3Nk9RdlRQbTZxZHVJdWVhVGVvM1cv?=
 =?utf-8?Q?Dw9MqtFNbIO1zttbem1v2fNh7jtzUnaeeHEb0P43I3m7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4226c0-c57b-4439-2c77-08dd78162088
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:57:39.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ7V/flySZ8+9SXREqF+vOgwSt6zjT2iMPsutIcQ6Sku71Kk6quT7fiPmD2GCOwX9ab+Rp0ZPmRkzqx2erFTfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534

Hi Abdiel,

On Thu Apr 10, 2025 at 5:58 PM JST, Abdiel Janulgue wrote:
> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index a61da5eeb017..880f6f04ba86 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -218,6 +218,91 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>          self.dma_handle
>      }
> =20
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// For ringbuffer type of r/w access or use-cases where the pointer=
 to the live data is needed,
> +    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start=
_ptr_mut`] could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }

Not sure if you have overlooked my comment on the previous iteration or
if I completely missed the mark, but my understanding if that the bound
check should be `if end > self.count`. Also applies to the other methods
of this patch.

