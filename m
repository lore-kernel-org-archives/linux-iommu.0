Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417D18B48C
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178445; cv=fail; b=nnNjQE+N2oUM0Ix2drIgAkfCtiovjGoZS4z5wcJ7UdHAo2P1vgXEKguSmpQF4uHJu2F9thOD7MtXxaJZkLY4qAEwK1L+FcQjve8wcIXkRwixyAih3gWilW+yVWvYNfVkakJNKhwzAgBgQpp+iFdpIffKcU3rhNl6QJ/ELM1jtl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178445; c=relaxed/simple;
	bh=1leWa8BocwKmKEbMIzG9nxRezPTu/QvzEuAchmbZQK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jzGdViXBYkBUmLQoP/wk2zT2iYBPqGEPUJXICwFa+tXAcxH8GD4TtK7AImilvshUbn6MsVDg9xozFGNar+OAxNn012zt4E5azQ2UfgkT4jtOsMyhwHdpUNLL+f/RkaCTnwu2xwFQ8kJtIKAxCM7vLZ6H6JDIAJgqGV+LTn84Iog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGoYhCen; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGoYhCen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730178443; x=1761714443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1leWa8BocwKmKEbMIzG9nxRezPTu/QvzEuAchmbZQK8=;
  b=gGoYhCenE1yRKQlk+dToZEit4miN6XgLOOgh/1k7y+BhJDzHKqWxthPP
   atBMQcUb2Wi66FnYAvbZi+4/5GwNoFXreamSEv0TXq/Q+xOHLLTk7Qlfy
   NE3Q4wvpyTVq7h8PI/3gJJ8ySwAGn642Fmxom8oddPD9mF0YZyu02xBch
   fhGiPLcMe3LiLcd3e5+rMsC26OHs6IkBX6ZpdjLrQc4xzKhciM7r34KNq
   yszbaAexUJ+Lyb7ta1/JT3S63YRfNPQSwt+4B1PuX7bJT0dnZzruqnzoo
   yUZhTUEerksOvhMIv0mxjX2Jc8Pof1qXjt/MFNYX2ngqdbMJkKs4qccch
   Q==;
X-CSE-ConnectionGUID: lkepkTxfSiOPS0pkUdGy4w==
X-CSE-MsgGUID: J0bn/CkTTQa9FkSE8vNArQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33497976"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33497976"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 22:07:23 -0700
X-CSE-ConnectionGUID: +rgcwHaGSQ+5US4Y4Cealw==
X-CSE-MsgGUID: fpizqTE8RgutujQFZ3ZMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81992320"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 22:07:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 22:07:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 22:07:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 22:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suA+XOOHwnSPLef25+ZJMz/aC4uIj7KW/k53Fd47S2TqjAgIJcg3h6cPQvgoPXQgsN0lbCl+qfcNF7c5tnWxBlRf4qvMDNKoc1GdCKOfHrAiPUp7q82aJw4G3vmQnfD6co83hmuj/F/DvlaaIzaFAFlspiPYAaSx62757KC1rFkbXiiXyP4tnEh8nCVv1N2QCdlCclOdNGIARTMG79ne6R1BfzgZwxT2imur4d0/H8celNkZQgw6GilcOAyJg2gmgQS+3xLDPmn0xu6YPnhJc0kJlC/c+XVNHYF3C/WcVzXZskjuqgiKc8Zr/XLYZvOs4voTmceoTQhEt6QbtFpjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/W6WjLLSMEXJy78t0WYK445a/I0eVirnGfZLzKu6iA=;
 b=jtLAZAtPrnIFztGc8kPtKksDfdAAnQyXwZ64iEod2avYsYAcp+XE/tajRMaUIzPIXCyKS9QbM6DkqQ3koIVAMOCAMoV3E1XEByMJsAJZcq5H3y5wTgB4lC1QUbpIVLBX8EtsB9QNULCeBJPcSsynpBkdJ3mY5JwDs+wabpG7t/p23fwv++IY/1oKTI5KCvKCSPD0vkeIMpyYCmFZPVVUG5GafR46VQC4M5KfLz447A+CULxMCL0SGfjExwijr7VT5qTt0u6Hv7pKQGrJ+tpy+XF+TMY/UX1P2TeZlQLIRKqmB7Z0OcphE7nQjfSRJlcdzMNOq0LNhWfx4neXLLf+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 05:07:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 05:07:17 +0000
Message-ID: <68ecfa4b-e1a8-4569-932a-cd450391ccfa@intel.com>
Date: Tue, 29 Oct 2024 13:11:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Baolu Lu <baolu.lu@linux.intel.com>, Joel Granados
	<joel.granados@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <d53752e6-b9aa-4d42-af08-d2210f1eba7f@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <d53752e6-b9aa-4d42-af08-d2210f1eba7f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7092f26d-bfac-46dc-6b20-08dcf7d78f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHNSTHUxeTh2NlFiaDM3T1JZWjltanVSVzFJaUw3TFQ5ZkZyazA2czF3TE1T?=
 =?utf-8?B?bmxQMXo2eUtzTE5EYzRoS0dvUVI2T252QytVeDB1MitWd1pjS1MyN2wyT0dZ?=
 =?utf-8?B?V0FEcEVVclZqazk1YU5VeHVzTkRsUEhrdnFuTE51K1FFcmI4eGQ4M2RHU1ZS?=
 =?utf-8?B?Z1Y4NnM2aHVSL3pJSWlaekIxN3FuZERocldGZFYyaGZRcTM4Mk4vNk9JKzNT?=
 =?utf-8?B?ejVETHBQZnY5bHpaMlFsY3JmV0pMNlp6R2IyU3k2L0R2VmZDR0xncW5CUVpu?=
 =?utf-8?B?ZTRZWmhEN2FHUm5jOFU0T01oZExoS0dpVUp5YzI0Q0oxankzWE9OWFh1bURC?=
 =?utf-8?B?czBKUFlsd2daVnNNYUd6bkw5dXl0bnhIdGNjdXZWcU5rY1haNklKb3dYMk5P?=
 =?utf-8?B?Z1lIN1lyZCsyOXIvbU9GenZPYmhhc1NINm43NEIrcjZKL3drM2hDQi90M3B2?=
 =?utf-8?B?cERQdUdiWEhaTTlIZDJGcFJjZ1poS1g4TkoveElwRW9LQXBaNG5XOUQ5M096?=
 =?utf-8?B?VllrSXVHRittZnpPZTZ0d2h0d0ZJSUFUME1KNjRyNzdteWQ0QnJyakNjc3hy?=
 =?utf-8?B?cFAxakRSTGpsVGRWWHhualRvMm4wOTFNdUdaZ0tjZS9IM0tjQTFhMlBPcU1S?=
 =?utf-8?B?a0dRVUhxLzVSMCtzRXpPUkN3K2hXN0xHSFh0eXdORkl5WXdhMk1JRjIvQzVa?=
 =?utf-8?B?VGNxdURpNG1MSVRKbGVwY25ranlqYzdBaExCdlpxcS9md0NIQ2s1WElaZ1Zw?=
 =?utf-8?B?VGZiWm9vQXVyQW0xcW9vTkhzVTRuSm9xZmd1bXdjTEFUYUdDYXdyMGViSTla?=
 =?utf-8?B?ZjRxTlBzV0JYVm9JeW5pZ1JJMkwwS0NaaThuSFRoWVc2QnpDZXkrbzVQZkdV?=
 =?utf-8?B?Ukx3WUJCc2c5T2J1M2M1ZjhiRXBzU0FwUTB3WUduQk9MVmxqa3o3L2c4cGlM?=
 =?utf-8?B?QW9TSm9mZU1FTVp6am5neGxJTEVhbWpEQUZyTi96RXdaYk53SXBqTTBMVXp3?=
 =?utf-8?B?aEx0NkpzSVh1aWE1Zk5EZCtnbnh1RDhaRm9UbjA1cTVMYk1HTjJIaVFJUUE1?=
 =?utf-8?B?SWtweXlLdGszV1RhNU13UElDTGJseFJJNkxOb0UwYUY3bkRpVHV6eEhQMFFO?=
 =?utf-8?B?YWNTWjhmR1hmQ3JCOG5OUVFmQW1KQWJFU3R6ek9VbHI4SzVkNmZHa0dwOW1E?=
 =?utf-8?B?VmREcytxZ0hkTG8ybi96SGZmYnI5YTBBMk5hbytUMVd3Tm1hWEdLOERIVVBa?=
 =?utf-8?B?UFc1RGwydWRZaEdZTXc5c0lyTnlrTHY4bUpnd0ZPSnh0LzlIbWJDMlo2alRz?=
 =?utf-8?B?dnBML3k5ZWlMU3dpbmMzbmFwbmFjbU1CdkordGpIdFhkaTZEWW55M1NoRVhv?=
 =?utf-8?B?UFFZQnhkMkZyYlV1R2xnUS9MR3B5NDloeG5tSnVQQnlaWW5oMW9ZVVVjaWUv?=
 =?utf-8?B?T3VObjRrMzd4czhnOXpMQ2pEbXRqQm1CK1hybyt5clErU1lRZmNTL1l1d3VN?=
 =?utf-8?B?d1VaZHVQa2FzQUp0Y1VYTGJQTnJPNWFoZVVKN3V2QVM5Rm9OcVFyckpGbGdT?=
 =?utf-8?B?RS9sZGkzd2JwSFF1WEtxUkNmN2g4UHVjK0U5V3JvV3lEREcwcUxnbEpiTVAx?=
 =?utf-8?B?TDI1cWIzWXJRNFd3a21nRmE4UzkrNTFWWEJCaGFZbEt2SjNGS205NVg4SWhB?=
 =?utf-8?B?WGJZVkREQkcxcGVwREh2Y0NGL0dkWlJpeWhVWkxVS1AvcEJ4TUJ0eDFRUFo5?=
 =?utf-8?Q?2vRb9oozMKpcdyd8sJ5zhlE+keZqRE/oesNEoWF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVSd29ESlorSXhaN28rY3J3WjBHd24yUy9XMVV1TDRkb09mSUhuR2Y3ZzJD?=
 =?utf-8?B?N3RoNS9mWStDZGNSOU94dFBhZnk1ZlVnUTkzZTV1d2hibUE2M0doN2VST2Rn?=
 =?utf-8?B?MEFWYlNKR1l1aFNPTkF6aXFNQlAxRW5TZ09FOEtoOHVSdzdycjl5Wko1bk1u?=
 =?utf-8?B?MHQvVVYxVHhsWmtCdmk0ditpakZPRG0rTWxJYkg1Z0ZlNDRCNE0xVE5xR0hp?=
 =?utf-8?B?WVJqWjVhcDFGMmRXc3g4OFhGenJCdjZHZmE3bk1Jb1dTYlYySGdNcitTVS83?=
 =?utf-8?B?TittR3Q1ZnZ1Q2VjcXQ5eHZnb1Z0bkgrRGNUOENzNVJKVVZpcUZzMU9qWGhh?=
 =?utf-8?B?eC9XMkc2UGIyVzBSV1pzZjBQSXFuQ2FzWjc0WUZqd2ozU21LUkZWL251UHdP?=
 =?utf-8?B?enFTMTRsRkJ6RmNwbkZLODIrRjdZOThPMUVta3BqYkRqdWs1TUk3bzd4NU9q?=
 =?utf-8?B?My82VE9aSWdaVjJiN25JZC9qdkdNT2kvQzMrNHp5T2VZL3ZHQTlYZHI4dStB?=
 =?utf-8?B?VlBsZlZsN2pZWXR0SjJwTXRxNzBFdWZkZnBwWWFJT3lMVjFPUUtQbEpaN1k3?=
 =?utf-8?B?YUJPY2V0dlRlaXhxTHpVL2Jhck9WTGQ3bGpQTTNDQVN1WnhqVUo4Qmh2Zjgy?=
 =?utf-8?B?SS82U1FsWGVhenppR0M0c3NvSDhzSUhDSWFvNTVrUUNvdlFKQTR1QmkweXRN?=
 =?utf-8?B?Nk9QbmdETG4ydnpxUnF0RXd4VjRIeExsMkJoK1RnMzZ1NlFJTUoybFc4NnZ6?=
 =?utf-8?B?MENHTXBqNXFxb3JUQysxeFBEZGFRVnkzeGtvOFhWUXU0NThyNjkzVkxqam5h?=
 =?utf-8?B?MFo5Q01iZm1Qbk1LdVdyd050M2I1cHJoMmxBVWoxTWRPV2diODFzZ0lkNjBn?=
 =?utf-8?B?ZUw0TllabENuTVkyT1lpYms4QjErV2pWeDdvWVNMWE00UzJVYit0eDNNQlJ1?=
 =?utf-8?B?YXZnVDh2VWE5VzdRcmRLeVlNWHdsam1tTW85ZkhlU0tyR1QrczBzRzBxOE9B?=
 =?utf-8?B?VzJpTnBCOFVWbDVjbmoxRWwrenVwMnJIOTZGVDVXSlZqR3ZzS2pWdHNtWlRY?=
 =?utf-8?B?RmJlNHJWWnNOdXBzMWJCUHVYTUM3MWc3c2Y3ZTlrVFFTaTM4SFFWRzM5MEty?=
 =?utf-8?B?YWZxS0R6MFZIb2h3bUt4UmpaTlJIdlZQVXNJdXJQcFRxRmlpS3NDL1FrR1cv?=
 =?utf-8?B?dmZMdlpIS1lDbGhMREtzZGpWMkoxZTBCbE9WSjRZeENjVTJseGdnSUE0Wmpk?=
 =?utf-8?B?TGRnclBqUmxMNXl1K29NK201VXh0cWVnaURUTWN4V3c5Y3JMclhZMlhNdy9B?=
 =?utf-8?B?MS91YzRzMnczOFEyM1hWWFVrMlhIeTdLeDQzNjBpT01HcU5VQjByUmZBMUhQ?=
 =?utf-8?B?K2NJMllWRFhjak5IeWRRY09sdllpcUgyaVlIbDU1dU9YYWpHWlNOd2tXanlS?=
 =?utf-8?B?aGxlM2R4QTFmU21IWUF4ckdNbDBFWDVIeTZqS0psL0VtU0Q5OG84bC9ldUNw?=
 =?utf-8?B?UmtHQ0NvajRqSWExbWUzY1MwbkZ4M0RJTTlUenR1alRxNzFDTCtSb0lDcGdo?=
 =?utf-8?B?V2E1UTBnZnM1dXh4T1dwQ2JxWnlCS0Q4Q0pndisvVW9JVXBTVURmdW0yT1Vu?=
 =?utf-8?B?TU92aEQvb0QvaW9PWmlWeGswZi9QSmlxL2xwVXlyWkJObXE5ZXVOZDBSalhB?=
 =?utf-8?B?Mks2MmlOQ25xOFBwVnBjR091Zm1QVXo3dU1pK3BrU3ZRa2NEM1RYTzkwNnQ2?=
 =?utf-8?B?ajVTRzEzSS96cFhSZ3owbjlNMUZockFNSFlxRUk4TDNObVFwWFBMdlRMTjdY?=
 =?utf-8?B?ZGthTkdzc0ZyWVNwZUZ3N05kQkJaTkRVWVI3UjNNUHJlbmFOOU1vMlZPNFl3?=
 =?utf-8?B?TzYweU9ERVJ3ZE1xaFBpUnp2OGlESVpuZGZnRTNqV0tWTlVIeTdxYm5tUjVG?=
 =?utf-8?B?eHhFK2pQeVNNWU5nNXY1d1V5OXV4alFsNU9FWGZqRXZLY0twTllzT242Z3Q2?=
 =?utf-8?B?ZlJHZjNpUjV0Rk5rbmFnYU4xN0IzREZQRjE2R0paZ2dvQ3JMdnhKSEltbWZB?=
 =?utf-8?B?VEF1VUVGdnY2MUdVRkxac1ArWHhlQmR0aUJTYWI3Z1ZqME5JT3lQTm5FTXhJ?=
 =?utf-8?Q?wI64Q0OLDYz5aGCvusOICfvfA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7092f26d-bfac-46dc-6b20-08dcf7d78f58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 05:07:17.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6TF7AQIjTo8VmIpWfEciJIMwz6Kz3Of5lNL9kVoM9dBqpyzLzi0CgmFYeQz4bogqXAFfMxqDWix+XCDsuiZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

On 2024/10/28 16:23, Baolu Lu wrote:
> On 2024/10/28 15:50, Yi Liu wrote:
>> On 2024/10/16 05:08, Joel Granados wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> PASID is not strictly needed when handling a PRQ event; remove the check
>>> for the pasid present bit in the request. This change was not included
>>> in the creation of prq.c to emphasize the change in capability checks
>>> when handing PRQ events.
>>>
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Joel Granados <joel.granados@kernel.org>
>>
>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>> entry is destroyed, it might need to add helper similar to the
>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
> 
> Perhaps we can move intel_drain_pasid_prq() into
> intel_pasid_tear_down_entry(), indicating that once a translation is
> removed from the pasid and PRI is enabled on the device, the page
> requests for the pasid should be flushed.
> 

yes, something like the below patch but no flag to opt-out the PRQ drain.

https://lore.kernel.org/linux-iommu/20241018055402.23277-3-yi.l.liu@intel.com/

-- 
Regards,
Yi Liu
