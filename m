Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.56
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673437;
	b=oYp3FG8ns5Z8+i9v+FK/678RbyhzHbkGD6P/akLWB7+2B122G8Pvt2jYqWlWOuqIyT42
	 ROul9jIpobdghv8lg2nXTPQ8udQvOsscIY6TLx1yS2igtm1jk1fE28pvHWKviAusQlbf9
	 gyO6LTiEo+BrF//xlK2mfjSqIJ10YO5zZC086NxG4JsQV0Xn8kck6b2HigWZZKm4XkoqC
	 liTHKm94u2x5tDEBMcOiXv/4FZ4zZxdZjSiEt96a7Z9iwG8rCO5eXq6C7OmYO7ybtoARp
	 qw/JCEKZMa2QwZT8YLGHnhumU3/FvDWgBDNgGs+DJQSQs3pYn85FcLNOqx7OFRTiR6Q==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673437;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZeV09RcbZ5kICauzzsb/mRJ4Sty/g29cQKuS/ioyrqc=;
	b=EdmiTKnq89BZC9MeMJQazNn3NHrvENcQ/XSZPm0nmZZBsXWnehGGIEOY39+G0AVrg40H
	 tHTqQcVgqgzmCGzw4QeQR1D1NXkjnOOKHyq+sK1JIb3AAOfQhFprPNp/zD6hod7uaTKec
	 K80oy/38iKS3Theb4WyBCsr/2hNK6IbzeIJwQ3CQXgky1x22Zxq3ku37jDx6HbaDyie4+
	 ZAs2wI/0wRZvRfxL+Fk5zs2VJ3iNkpJZrtTS6RNZ5aSPwcTco9XmYRkDT4n27rOQf97Wm
	 wZ9aU7w2x+01hLLN72R78xCp7gVGGahZoxp8/vFVr5hzfVojr3XlEikbA7sJKGem9MQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sFJLzCLW;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sFJLzCLW;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.56
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB4606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFB4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sFJLzCLW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sFJLzCLW
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c1KjkUqEFPT5zvQIEkgN7nNWpkGNQJ4lhYBvbRaf5SKvVism5Np95OQcLyDd1Yq+fAQ5hYgR0uKpifGyIrfapi8HTj4lKmIB+J8ThtFZZgHB9Js4d/q0TVGoqC0G1OzlY0SE07EeElfH/aktFFPyCjhxAp68/ncvQmnyJ9c12N6TllbA7q3sy6cFQcPRjYAaQBWIXQvRLemCYnvLtyuPRORzsokeGAcb03k/7/k3jMyrf3h9EnO0xYBzdGCb6dG16tJoc728HE1Pnve6VgRmZRfHniUjKYqhqNkyhCEw4KGYysRYRnRgzsItWYr5LWhNxUawuXbjbCjfFbfKwvT2Vw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeV09RcbZ5kICauzzsb/mRJ4Sty/g29cQKuS/ioyrqc=;
 b=eLLRCIa8AFYLGzIf/lS339Dm22B0Mpq3donAjGS0hdGGx876Z+84InH4pKZzPQ5GCrx+dJFvXq5lKfQ8fuvDZ94+y+0T5CCzqa7H659Q/PIUqCZ86OJ9oTuMjgyL77curPXEu22Kk7B57W03BHzCCXd0NCjwVbN2B8bBesWlYnQfYTvEDoSlw5lg8qO3Tcdrm3X95Gwi7h7NWJB7GX+tIRf51IvnOiKuCPi2nqYCXsMjSuqNLL7Yc6cwaQgwk2qfyVBUKPThDIe8PMXDlmEhX/O28uQm7v3OEgLUm9AoS/SpjdTjlGsb8V/JMswXho0OYbAlLBhRSK3D7fo7UkQS5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeV09RcbZ5kICauzzsb/mRJ4Sty/g29cQKuS/ioyrqc=;
 b=sFJLzCLWPbnrOjLY18LlQSmw5CPNp8iB8m5+jpq6LHqdTB2L8GVvCypuue2XaYUbUjPCmCYkERV33tr7pXB608Pr7z6opsOc719WQ/n8XDlZHORmq+ksbPcTWAxQIlxX2FzFO6G7vG+OtIrkgnSL5fjDlthbDUKimZasI5jak3E=
Received: from AS9PR05CA0094.eurprd05.prod.outlook.com (2603:10a6:20b:498::9)
 by MI7PR08MB123078.eurprd08.prod.outlook.com (2603:10a6:290:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:50:32 +0000
Received: from CPH1EPF00000529.eurprd05.prod.outlook.com
 (2603:10a6:20b:498:cafe::50) by AS9PR05CA0094.outlook.office365.com
 (2603:10a6:20b:498::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 12:50:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000529.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 12:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiU+SAwMH1RUI1ZnJKNBSCMFn9NzvRDftigyGSn0rH0SD1KNqXwdgnnZDlCnQbEw8LTG8lydQztf8vz5qLsBl7mX8jzt+mfylbAq5tAadZs+KHH6gJFjT9pMYIDcM4b704ufYfMocF/yMKH19yFRGjIppA2+39UlBGkYaz4ug42j5GPNXbrbcgIoujYF4MbYQ0P+mpIkzj9BlOPGDHANW1gtrFUvDI3JcyTL69BUtUmwNbqet4pwZ77t+EteMP+oe74q2Ta9CXHkO5eSl1dtMCtKJtQLp8jZk6WcS5SPL83hlIncJAOpBXyOXVkYWscXVGQ4K7XwSSkahgNuCqesaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeV09RcbZ5kICauzzsb/mRJ4Sty/g29cQKuS/ioyrqc=;
 b=LWF0uevTJhIqDIfqUxJmWrFxL6kREOy3ojXu5nlFRAxYKKFSlciKDz0quSM6heEAxrk+t3mI+NolGESR24OLeBtSv3n64mEjAslZXxaOorf2vjtKUVXj/FraKYoxksYacFNgnVXIealCUJBxPfAFgXqGJaJzjX2UH0jY3O10NelFNW6ulQeXtNrDtPisyck9NMAjuWgmRhlfI5F6VvY4ScAY8t0UskxOayQnbHwqLL/7TfIhURcBOIzcE9flbIu4k+gmN5GTO9aKA39q+Mv44QIU9ZR9U16DSiQgaeEoOMAj7tAqsnTMz2fzqc5FWITOT6yt2D9RXxzbI9Sil2TKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeV09RcbZ5kICauzzsb/mRJ4Sty/g29cQKuS/ioyrqc=;
 b=sFJLzCLWPbnrOjLY18LlQSmw5CPNp8iB8m5+jpq6LHqdTB2L8GVvCypuue2XaYUbUjPCmCYkERV33tr7pXB608Pr7z6opsOc719WQ/n8XDlZHORmq+ksbPcTWAxQIlxX2FzFO6G7vG+OtIrkgnSL5fjDlthbDUKimZasI5jak3E=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by AM9PR08MB6068.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:50:00 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:49:57 +0000
Message-ID: <315919c0-909e-442b-afd6-cb9f10664e42@arm.com>
Date: Thu, 22 Oct 2026 13:49:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT
 for kdump kernel
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <9f500b81-792f-47b9-a8a9-1415ff11b699@arm.com> <atj7XTdjC0CIVDQY@nvidia.com>
 <ab304d36-c655-4a3b-b1ab-e4b7292bfd24@arm.com>
 <20261022122254.GB3008132@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <20261022122254.GB3008132@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10691:EE_|AM9PR08MB6068:EE_|CPH1EPF00000529:EE_|MI7PR08MB123078:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d66548-eb12-4967-64ab-08df303b0f24
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 scC8SuL3oUf56wfa7zBZ5B6hSNSp2+jTrO2d9Gs722ymKZsfywRV8Vx8m7sik5+LacV7h+Q/pgWEPsouS3OJz+fR5ct5iEtS5P2sqiS1f24sbO+oPvhH15LkKoPSfUWr/0+rs3eGwt7JRJOQmyuRE8SHEkEbJpXRB5roYsmWS9KI0fjy72H+zAjP9FWfhNg3pbNQ8T9yEIdT8PT3XD1QHbllV71YW+B5+9V1qhC8kZiGa+i2N5hEQi0FMpFUDdXhfF+DRWtFMJVdaTpcl1Ygjk2DyzmO42wZ3F4+SFH16azkGRmlK+0tKmcERmO/BwM0IMjs3O5XS3874wudsfJnXaj8baJko0dz7EkYZUdjjzSn7BcEqgRIdQKTqpDycIssXtd4MemlF7akRjMWCr7UEvOllb8iJCe/VMQNpPYf/2VpVSJXgOaOYQX5cc1rESK66BN9XUXxqCQseewjwPr9m0kN/d/3gn28WlQXM9aRW9Bws9foDFLt2Pa4bphY5vTqu++EphPSot1JUpqiP6tb9o/TNyOzh/RDt32aaBi8I26T69vIPnBthgQCyJc8iyprSHRfUndCJrPUNsufULSrAcA3apcOXtfIxeJxaIbAV7ffm/tAZsb/10f4W7pTGtyitV1c4RQK52ykb1VpXa8vPw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 rkEiWnE2UD1kmVaTXKxZXVFIaLsckaBA0aim+jKGrZ9xFwO1cBKkpoTKkK8dxPR6MCH7KBdteLOfJ6mtsbKJE5we43IR5YHDh5lvh8+eW7InWLw9uXfRbJ4QUhCGPHIROOqkcYlrp+H5C0nruSKxtFAtJOALWvjRNm32KitC0msJT5vabonbLplERTS7E92HMru9oed2Jo+FebBbbFGusSRNlLnG1uVy7J5HeJkU4yd3xiG4dUxtZBWm2UMVRnDZMY8DkxgR5MibxABb954//HxEWgcGAuc2X1V+yF22AexzRIlwTtlCkgcZDTAb6krRZEd9aZiPknsfEqeKBbJWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6068
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	87423eed-4c3a-4613-ffd3-08df303af9e2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|23010399003|82310400026|36860700016|1800799024|35042699022|7416014|22082099003|10067099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dOdgBkPP1lnXdo6g0A3MD4MuKmCG/N4CCnK3HvRPiliQknisoXRObr9se6JbryDrflkAHGapE85FMy48VcKg+OCeZzgpMMN68gbTuLLqfRvm/svGgB5XtOfWjokL2jmhvfvZUsZfjNLzodbjZy7uKQf9jRQltOoeljfA/yKwr88rVQvui7HKBihEV9kFdLH+lDu2vRjflb0Pmztk0GQKns1eTDqDCa8Tea7MA/Whp1RyHFVxb9MmComFPxi9VFTu6a2FOByiXIk4R21mpPRNt9yd+rOFghnoNfePfs8+3b4KfyjuPa47okusr2eJLIICMqNQ5zJINkUh2n1svjglHi7cMbgubc985XqzEF63BBypt3kGrqXNqt+gPUjVUmGfisL2eXEhyWgUpDCRVd2BOgfUxoukJVLHd9x+sm4/xUkBn567IV4y4lko/zSOCcoQBa6i4CY0tO6C4LWcxB/3NCO5qzFeism9WLMDoV3CB4LcfvVTY8AtER72nmUjIzyz9Ld5+pzTwwq7LWuMXnhLoaEKtoP35lCWIPq/kwr3oaOHn9HXDSKUy+7S7cBX4qtwtYTpXJ7M9wEEhc4EgWelwtqihNqBqaJg6tjkjTkzj2/JzCdRI4R/wulUpW1XnZPZIW8l2WsM7YrvcGF8UOtLffqeMfo52FRbVizPLbSomnqlw2P/j2CvLLIXriXD58JX
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(23010399003)(82310400026)(36860700016)(1800799024)(35042699022)(7416014)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gfDLV+fG3iMVgV/tc45E+Jnbndaz8PiJ7hA9rxbWosiYHuBrXMAgRli6tEluUzNUEPKfPRRxqcqc85pTVTIPHaBCbAz+aEcJK1ZbwTyMrr7nYcrpDvRY/E4KWmrRmQuPoy461dH19YMCfKwYRXQklxwSY2Qa/lAZC3QDONScVd4ESHvNY+Oi/qdewyj5Jt1OwQt5M/kiNdtER0KJSLmcV12mHGI98PQlLyoN0TPJHLhadEBFh1x9wsROA7RPJniN3kmlbRz9fUSQVzKCDd8Oc13GF/jqAxevggOILToQjbGMsVIUzWEEOFPCh/321cVLvIES38xF0iscVbQaNizR0Q4CNYiWcTOUFLnVk8fqpWf13+f/Bl2uEQMwalzWcECCXXrAqpZH2AafKqW9U6msSgL3ywgwxQRY/ZNO0+LK85oqecTqJz1Q5txSxOO/Z2eE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:50:32.3783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d66548-eb12-4967-64ab-08df303b0f24
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR08MB123078

On 10/22/26 13:22, Jason Gunthorpe wrote:
> On Thu, Oct 22, 2026 at 09:41:18AM +0100, John Garry wrote:
> 
>> No, that's the point. Currently you first try the adopt mechanism; if a
>> problem is found there, you fall back to the normal full reset. My idea is
>> that if a problem is found with the adopt mechanism, you just re-probe with
>> the normal full reset method, so that you don't need to undo some adopt work
>> during the probe.
> It is hard to convay information across a re-prode to tell the
> second probe to act differently.

For sure, maybe a special code to be checked could be stashed somewhere. 
But, again, if this is not going to make the driver probe much cleaner, 
then not worth it.
