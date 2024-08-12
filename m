Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4D14EC53
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463850; cv=fail; b=tdocl28vbz1vZl/F7iFS9uZcDJ4H8qihtnyxXsxwJ8lqEPqLVdsWudhzKUCe0wMZdx/HEH6xHosJHM+I9q9w0XgNqfAcv4gAIB9MGk0+zVyO2ftx66fRVB0ckQrfIiw1Mm/HrLRf9vX0zSxRuvBIkLGZsR7REshXLBGJN2QoH+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463850; c=relaxed/simple;
	bh=0EL4pIvIi508/y4PQm3U0Vs7nBi7OBRZXS2V5VAFSIQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VyQ5G1u0lpFDC9DhkXLkxrZXoOIRO1GG4XU+8eOls2PCbSlgfwwXWFUr+Di4IqEC7I6PLnGZYZl5zmt2JjMFw4XQWgcgOcTLOyWutYIzSn4EAy7vvBmm76YMybxYV9Mfbym6nT9mAPNN4i7rGspsY0W9JQcqKxnjnyL0cvaOE0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SybUb6XV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SybUb6XV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723463848; x=1754999848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0EL4pIvIi508/y4PQm3U0Vs7nBi7OBRZXS2V5VAFSIQ=;
  b=SybUb6XVTYmam/vHU1WdyumTz9duqffkNbbBbQl46cT4GAefYCNu+PU5
   Vyghc+5XpWFwNtd1f3WAOVS6XHSNr2bo2B/O9H6FghZ8z7hUMJ5unWuhd
   eGQ6ecBxiWYIkdZjt+W0BNFGny+k2+/4TolXxeWQpJkQXmDhAf0f9URqP
   66h0QHqk4HL6jC8ndrfPPMBtX172yC0tBshdZYmj+8USnkLFf+dt/Y/mE
   u7QI+/MjhcKchy6ZXLrSxcPLGhMixGUd9QIxwD/Pfz3NpzNC8Q77Hny2+
   CLkRqufgmueLKAuazfvhdun0WuVlO7KYvNkbgjSMm//R2AHKusJiAoHne
   Q==;
X-CSE-ConnectionGUID: qMzDTDReSOylYpFwbhXZ7Q==
X-CSE-MsgGUID: 3eGoAj+mTrWl9r5VOJ6vdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21448328"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21448328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 04:57:27 -0700
X-CSE-ConnectionGUID: OQOEXNkXQ4+j2t/5jb8wew==
X-CSE-MsgGUID: 4r3DgTOBSUu83WcvdDHLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58951348"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 04:57:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 04:57:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 04:57:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 04:57:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 04:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPdPPK9U1vJbNa+//mu5k6V1HJlm19U4qzvzpf3suwzHvT94zcT0GyRDCdri92YKzkW6jpF//F8W3EZayxndzG7j7pUexDLcsVmx3vWErb6SEdV5AkNVyHwWs1Ifmqz8933swCqbTO0Jwn2tQVZoj2WTWpOJb01gTqHBBgbRk2RxtxUGR3g0FxmoM02biAaLdhdEjLPEZ6ozMy9cqU4rr1yGriECSTbYwg+mYwzEd5HnE6Op7yJeBcXAcT7eTByM78coYyBARoU6nj18pPYBoebTPI9z/o88uvvXYjaUvMD7WdEVe4y6cq2vRNvwei29YWKbA9zTWJ0Xbi9zgcjdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdRM3lIXVMpFfTOjBoGRZImdhgZzap9qt5k2MDerhKU=;
 b=GVFEIVNrpgz/pLu7/WnehbRtCih2gfceYtf3P0v8zNq1b//X2pvbPU3UxsCbZiLeD8ZNaLAq+1QCDYvFoUjTdVQktn13SWISRI8ArjXlB515VevSr7ugSx4VdK3n28ROLe2PmJeecRUOBpUmnw76FnTOCI7zgyCIOCM9plqek2Zx/UH1fwfP3eLyWD3P51Ryp4Cnp+5v5n0bDkdxbbDWKhITz/QBSXSqoBBjR/lO8/dZHgZAPnUMmEhDaa/0ged/+jGQa6qMt9xxJdW6qY6TKF+97fu8wabA8mthDYugvXRhny69xic1EaIPzJBf6CogSYUQ+b2gLGyciST4EwCDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 11:57:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Mon, 12 Aug 2024
 11:57:22 +0000
Message-ID: <5a6c2676-256a-4fa5-b9a0-e433d4e933c9@intel.com>
Date: Mon, 12 Aug 2024 20:01:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240807135915.GF8473@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 46540186-f5ed-41ff-941b-08dcbac5ecdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVBNL2hkMDZhRGRsR25KQTYzSUVyd2pja041bTAzUVlzdDljU0RQcndYR0Zh?=
 =?utf-8?B?V1lsaCt6UkdMa3Bsazk1UXdUWEJpRXRiU3J4d1hxY09pTjNuU09KazNhczJa?=
 =?utf-8?B?NzVrVWI0R0pOY1l4dHZMOVFJcXdyRFU2VWV4YjJhLzZKUUI4Ujkybmtnb0xH?=
 =?utf-8?B?bE80Z2MvelVMeGpkZmp1WEk5MVZid1dvUWdLM2QwYVpuVHlLYlBQWTJRTFZn?=
 =?utf-8?B?bThmenZCdW1hYy9hSm5xY0d0K0NzdUZtSE9abXFtdDVvVkpJZnJQb1JtT3BG?=
 =?utf-8?B?ZDhsLzJpaktvbkdqaHZPNTB4L0wzcmx4ZVRibVZzbWd3R2I0WUdPa1B6QXQ5?=
 =?utf-8?B?Skk4WGdYZStvYUtkY0d4cjRXck1nSGxsQ1VSSWtNb1hIOEVvQVlwTUVKbkVm?=
 =?utf-8?B?Wmt5WGp3R0hEcXhIRURJWmpPc3grQk5NRXN3WGw5TXVqZ2hKaURxeUNoeHdC?=
 =?utf-8?B?TlFabU5SNnFPdDRUSTRvczZONUV5ZnBQU2VuZkRDcGpDaGJGd1VueUZrbFpD?=
 =?utf-8?B?UGdOdVZVZ0VxcEZNQUZlOTE5eUdqakxlSml4M3JMTG5tbUtOSWl0WEUxb3pC?=
 =?utf-8?B?dGNZMEwrKzY1dDJ6TzIvWDRla3IveUxpdWt4MldES3lMb0ptSFJ3ZXkwVlJN?=
 =?utf-8?B?WE9DUGlhYmt5Ky9YTWo1L3FLV1NRNHlDbUFDTE5aOWtFK1YzUys5VHBKaDd4?=
 =?utf-8?B?d1F2YXZVeXphaDdvM096ZVBIdllJMERjK0NFcDhQem5JS0dPOWxIVWNGMFNj?=
 =?utf-8?B?c3BobjdKN3hzWUhPd2tndzVtNW5KUjgrbE9uTkkwSWl0TXBVTW9abWJOcS9H?=
 =?utf-8?B?Lzg1OXhKa2lENXRRbHRNWjJwcHY3UHRpRW1uL1VtUHI4WmJoQWo0aXg4U3Fu?=
 =?utf-8?B?U01NMS9zdm9oTHo1dXBHUU80NmUybjZsM1lUc1hLdVdSSWg4S1MvUXhQd1lu?=
 =?utf-8?B?YmxkRU5Za2E3dGtVRUZIUUZqRmoydHFhR3dESnFoblE0V1pRNGkyVzhqQXhO?=
 =?utf-8?B?WG1pK1B0T1JMeFhmUzFyZ29vNmF2Nk40bCs4bTNDWjgrQTg5WTJ1Q1RHWWpR?=
 =?utf-8?B?RlJxb3V1N2E4S2NWMEZnT0ZrNGZnU3krYlJTUDNzb2NJMVk4dytCZ0ZDQ29O?=
 =?utf-8?B?RmZyeFdOekxZeTdkajJBbTVSWG92YUpzeDlreUwxdUkvTDR1YVp1aVNKbHJY?=
 =?utf-8?B?SFNzLzlEVkxCM0JvekxDZEluOWY4MFQ1b0RyNjRNUjU0djFmSjB0NDRlcHNL?=
 =?utf-8?B?QzFjcHhSVEVtTnZtMm5oTXExTkNWakZiY0lmTmR1NnlRNjNyemVYaWFlalJ6?=
 =?utf-8?B?TXdtTERmU2lyTlBNT3Q1cXplYTNMTHhJUDV3QnRXV2Z4RjBPakRQRzJHT3l5?=
 =?utf-8?B?ZlVUUzhRUVdyZkpWWkN3cHJuWDR4eWhJRzViVDJwdWpRUW92MXcxY1hxNyt2?=
 =?utf-8?B?a0lLRm5Qb0VQTVVqUHN2dWx4QVVWTEc4MUR5SHNlK3FobEF0MFZlcVhtM2Ni?=
 =?utf-8?B?YlFhRUREYUFBMHRCWXQ1WGFDVU45WEFZNXhRNVhhemF3aEN5SjBzUUdtWkwv?=
 =?utf-8?B?a1BKMnhjMC9hclcvVklVZnBWeW9jNkdLSGhJc0ZtdU42dU56d3BXbi9HUlBV?=
 =?utf-8?B?dDUraE1oZEJJOVMzY2ZwV1cvZWlWL21EbXNqamhiYkVLZzhKOVRzOURMcmsy?=
 =?utf-8?B?eHEwRy9ONnBpT1llMk9tRHNMUlR2SDJ2REo1RUUxaDlnS1cycWdKZmp2Ui9v?=
 =?utf-8?B?SFByd1k0TFVhUU1MeU1UREtvL1oveldYeTN3WDlPLzVtNUhKY0ZaMjZKQi9Y?=
 =?utf-8?B?cmlUWnRTejdCVkJha3JPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVQS0ladTYxQmVyVVRTWUtNQ1BYM3RIZCtXSXllTUhIM1Z3UzNXK2NMNE1K?=
 =?utf-8?B?cGJGZlZJQUptaHNyYTJLUk1kbDV2ZDROYk5KYTJWRjJxbEJ4Ly81WXM1c3JC?=
 =?utf-8?B?ZndpOGttTjFlTWNzNUZlV1JZd2lsZDZOOVZWeXVIZ0NTWGlsVWl4SVZhVk10?=
 =?utf-8?B?UnlzV0lOQTNGSi9VajhjNlA5SWVGSnA3N2RjSWkwOVFjYzVEVVFzMldGeURN?=
 =?utf-8?B?NWdVRzExOTc0TXhUSVpGT0ZyemE1NnpvVmVDWWI3Qy83YldZWUlGR2VHWHkr?=
 =?utf-8?B?SjNkN3VuYmUxREtvRndwdlBmZUZWNGVVbi8wOUorM2RFTVV0NDlCVXNxQU90?=
 =?utf-8?B?UlhNZnlJWG1YRHJKTGozY3pJTUpkSmJURjZiMDRpSlpxVjhJVDJraVJjejN1?=
 =?utf-8?B?YVNuU2JrMHZRdGpEaWoweVhKSEtwS2JFLzJwSER0dnZQNDdlcWU4ak9LU2o5?=
 =?utf-8?B?a2srQmNBUitteUxSbmsyNytuMkdST2R6eitINHE4M1c3cnhodjlDWTZIRUhh?=
 =?utf-8?B?b0ZoLzlSRXNzcE02Sm5uYm5hWCtTOFQwdVBvRnVpU3RnRWVySTNNTGltdHVj?=
 =?utf-8?B?NUVxT0dOR1NIVVEvU2hQVFBLbjhJMmkzbGk4NVAxMXdoV1h6b1Vsa1ExTzVV?=
 =?utf-8?B?ak5uY0gyRmhCdmo4a3V4TGR2M3ZhVkw2dWpxM3lRTTNNUmF2WEVlaHZwWVI4?=
 =?utf-8?B?NGdvUzFmMWdFTi9va0gwaGVGbG9UMGNxT2xMbWtkN0FKSEdJUnNIT3hieU9L?=
 =?utf-8?B?anFVQ3R4TGo2SVdVellSRkhIWG9ZRHE0OGRGRmFEYlNEV2lGaktBWTFKSVNW?=
 =?utf-8?B?R01pcVNwMGRvVlpGK1hyUkZkYzY3d0xOY2k4eWFQSFYwZUt5OHlTTkJqU3JR?=
 =?utf-8?B?bjBVVDFrdVpjM0FodjJQRUIwQUltY1ByVitQLyt0M0JUb1VQU3dMMm13bEM3?=
 =?utf-8?B?cUU0NmorSWtRZzlMMGs0TUZ6N2JIVHM4ZmdnQkVucFI4SW92MDBvK25EMUZO?=
 =?utf-8?B?Q0xtNVloeCt3QUVNMWw0NnU1anRPWENmSnhQM3dmUWdSZjVrVzVlNGxUUTFX?=
 =?utf-8?B?UmZSZGdWaWxSbkdmdWxYUVJtazUxaWpOTXRpaGhNR3U3SUFjQURHQ2dIMEZv?=
 =?utf-8?B?N2hlWEF0NXhreFZFcXhwakRkVUNmU2FnQlpGVFRLRnptZGRGS2ZORStEUzU2?=
 =?utf-8?B?a0tlZ3pVSERtdU9aYUlaY3FFb0dSUVRnc1hNa01veVhRSlMvUDAreUFHSEVR?=
 =?utf-8?B?OHNNVGdmM2pITlovZy9US1ZtUVVLTGh4TTdkeVp0amMxbnJub0RzM0loYzZu?=
 =?utf-8?B?RmZCM0hLNE1FQ01OYXZEbk4xblM3ZUJ6b2xvZW42VkJ6TDlRSlVqR2JucVdo?=
 =?utf-8?B?WlNFLy96TXNZbkZFdzIwOWIvZFFldDFpQnNscTJJODJjQ3RleDcySERpV1FX?=
 =?utf-8?B?TE92VlNrYjFlV0dlTEJkQ3k2dS91TG01Zzg1WGVRTkV6clNPVXJYNEkvdHZJ?=
 =?utf-8?B?UVdHc1JLTDM4YjczZW9kdVR0andaNzNQNHR2cmZzMldwaUY2akhEWEZIb1Rh?=
 =?utf-8?B?V0FkMU0vSnlrd3o1aUMwek90WVZ2elcycEloNUlJL2VBeG5lL2dhc0t1Ynda?=
 =?utf-8?B?VTJoanRFWDd3bWlvY1BHb0xDTExGWTVYM200dDNkbFkzTm1XWElNajdUT240?=
 =?utf-8?B?MTVpS3E5ZWxFZldiVXN2ZXVzTmFpaUJMNjhuZk9wRDk2RWFaZlkzYlpjYVFG?=
 =?utf-8?B?SWhXYk1Kb2lYMzRLVUtjR1lObUJ1cVBIWWk5M0tTanFoOERLS2FtaGdvcnFN?=
 =?utf-8?B?ZTdiQmxCbDIyTWlzdTVvV0t5QVRMM1pKS3FVT2ZQNnRIN2NYTHJxWjFqdHpM?=
 =?utf-8?B?dUVLaUpJVCsvS241MXhPQXY5cFpvOGdwSTI5SHRSNUNrdG5tNEd0TWEvZ2xm?=
 =?utf-8?B?TTdxcHkwbTBPM1h0ZVk3cEVLUFlsaGREbDY2TWx1alVrMUo1R1RqZ3c3YkdL?=
 =?utf-8?B?c1pQQ3BZOE1NY29CY1RYUStKRVBxVWFOU2VzV0grdUlyRXRaVTZMSTdqU3NZ?=
 =?utf-8?B?anFscnJ3VXVHWFZ0dDB4Y0NhOW1QM3ZpYzJQbVNKdE8yaFBxbm4wVVpDOHI4?=
 =?utf-8?Q?0Bh737OnTDMCGJBouGghIXOhm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46540186-f5ed-41ff-941b-08dcbac5ecdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:57:22.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYz4B/Ge9lchLHkoLeZqoy1oFCDUOnKm/e5xbYi5UPurJPXEdHSB3bWBFLerlfD4+RMLacTI4vWdszLZ22cv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com

On 2024/8/7 21:59, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 03:00:50PM +0530, Vasant Hegde wrote:
>>
>> commit 312c2a99897937834f6a679b6f9956288e8c93de
>> Author: Vasant Hegde <vasant.hegde@amd.com>
>> Date:   Wed Aug 7 14:42:24 2024 +0530
>>
>>      vfio: User iommu_ops->domain_alloc_user() to allocate IOMMU domain
>>
>>      - Include uapi/linux/iommufd.h in vfio_iommu_type1.c so that we can use
>>        HWPT flags.
>>      - Move dev_iommu_ops() from iommu-priv.h to linux/iommu.h
>>
>>      Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Yeah, this seems like a good start
> 
>> @@ -2134,8 +2135,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu
>> *iommu,
>>   static int vfio_iommu_domain_alloc(struct device *dev, void *data)
>>   {
>>   	struct iommu_domain **domain = data;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	u32 flags = 0;
>> +
>> +	if (ops->domain_alloc_user)
>> +		*domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
>> +	else
>> +		*domain = iommu_paging_domain_alloc(dev);
> 
> I suggest to wrapper this in a EXPORT_SYMBOL rather than expose
> dev_iommu_ops ?
> 
>> @@ -359,11 +359,14 @@ struct iommu_vfio_ioas {
>>    *                                   enforced on device attachment
>>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>    *                             valid.
>> + * @IOMMU_HWPT_ALLOC_PASID : If set, allocate a HWPT that support PASID
>> + *
>>    */
> 
> Needs more words, maybe even two flags?
> 
>   @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
>   with no PASID, the device will support later attaching a PASID as
>   well. Some HW requires a specific domain format on the device to
>   allow PASID to work.
> 
>   @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
>   domain attached to the device must have also been allocated with
>   IOMMU_HWPT_ALLOC_DEV_PASID.
> 
> And then we'd want to enforce this rule in iommufd to force userspace
> to use the flags properly. Otherwise AMD will be permanently broken :\
> 
> I'm guessing that userspace will never want to share a PASID domain
> and a device domain, and current iommu HW will treat both flags as the
> same functionality (use the AMD v2 domain)
> 
> Yi will need to accomodate these flags in his series..

sure. This appears to be a part of the iommufd pasid series. :)


-- 
Regards,
Yi Liu
