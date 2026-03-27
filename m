Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2B3C73E0
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602785; cv=fail; b=bkSUKpQrjAxTM64JKF6W1yd855+f+6KWid9+ENNh0ZHIHE7B/9+WFeX4+NkdEhJxGaWomY+4ZR6RCjmKT2LF/XEVm1cXDhVp33AJ8vG8E8v87HK/mySanI/r1bKBk2HhQFdixk9+BHo/EfkKtGAc80iihFLPFj2kONThiGqlEhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602785; c=relaxed/simple;
	bh=A6L9VA7JoWbtD+CvGm5cDqeCsg7aZokPKgn53NzGRmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rA1+kGTL5WXZ/dwx8LVpj6iWOvPkuu5mJdsJcoCYPtus/PfJQcPeRyoVDefZTWpp2xloVfi/QV7Dad0hVNqs0ECO+BF8u0QpE3UHdwWYCm/zqYorQafXh70qxlpdpeuuHy7iTHd81XcwBhu3/0Z0MKlq7bpOmmllGXmr0e5oOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayqq/v8Q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayqq/v8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774602783; x=1806138783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A6L9VA7JoWbtD+CvGm5cDqeCsg7aZokPKgn53NzGRmg=;
  b=ayqq/v8Q0wRIP+iesU6Fko+DuF+Kxf+M3zrJC1xQSVyHyVk9zh1T9BlS
   o8O0yhz70R/zSFgmP4Vfwpj3ybjzGWf3ShF7fWz2ML/JJwfjC3RKnaaW1
   XtT2B4uVC/motnP/QG9XkWCIfgO692srT8mvF0cu/zkP6IwRBKFQlnlPw
   7bZDddoi3xJEc0Tj1VX7HYKu1Ka7qcQwGNTqnyRQGOBxKRwwp/WnH9466
   XZ0IF2l6FPAQpwL7qVrAeYhUTByyjPA3pRZm20HkKProx7rjgjcYvAhyP
   YfPTAy9a2gb4xbcifxZrs4ocELrETkcL3FxUuymDeEqihl2fshv4L2kCr
   Q==;
X-CSE-ConnectionGUID: dTYDHnkxQhuP3Fdvl9b8ww==
X-CSE-MsgGUID: KpxOjl1NRiaytanrC0M7oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79576718"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79576718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:13:02 -0700
X-CSE-ConnectionGUID: YdTrn7N6RYWxIAkLvRvrwA==
X-CSE-MsgGUID: qblUqJpjR5KdM363o6CX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230189834"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:13:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:13:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 02:13:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfcD3sXqpQwhWjQ7IdfTKSrMSZXWRsijmqSqSug9hzWb8qFsOZxOCtOb2oI1CT9jKkxE/rJbvCj9yFP3eBbXTpwncFy+QS2DSlGbcCBl4gdyApNd952u5MLUxdDJu91yru19JguoAVxquaQbWSdQf6GfEpFtAOMPaI25Z+NyCmqSCICs4MXwktJHpnGrcjtmnMietQuBn5CacckDoOtDltZ3ryOBBxdeN6kpGRYiXICqlVMJId5d4A2FIshhZd+izHlt6Qabez/94FaaWPHcX6mheFRQzQwjLViJ6oiQeepOH8YXYxsInqS7xtsgC4bhZX4goC7SQEvb9bNckP3pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6L9VA7JoWbtD+CvGm5cDqeCsg7aZokPKgn53NzGRmg=;
 b=SCsBKT8dmieTr6+K8u1G8rVcLcAYslEByhK6VVESZZGdbNsE/IQVr7fx+KXEpMPOTY4ykj6R6tNwK/mDlymi7sHT4DDL+iUADVnW7ejqUfR/13kMH7j9bqN+mgzi8FUPBw4kcVITHeeJa0n5rkixDSerx3I+g3dzgvcXAJnraXmgZ3GlZ+5ZjwZJSSQYrrtoVMVobngq3lF+CALQtwMIhp1eLsqaHugE4DxXcn3RONJZUqj8xC0zdXUnLr+SsJitfDwxleqJ0bMagXmTEZQY1WUZB1h0sAaQtdEH2zh+cFqo8oCzDQxbqUA0cePfkovUs1udo11WBpW6G+NfEXNvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA0PR11MB4638.namprd11.prod.outlook.com (2603:10b6:806:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 27 Mar
 2026 09:12:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 09:12:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: RE: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHclkf1+BcH0VI8sk60p1zRgtt1G7XCUAJQgAAW9HA=
Date: Fri, 27 Mar 2026 09:12:58 +0000
Message-ID: <IA3PR11MB913661CC6F6FC96403B7F5ED9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260205023405.41583-3-zhenzhong.duan@intel.com>
 <BN9PR11MB5276C8A77E8968F8E0C1E6E98C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276C8A77E8968F8E0C1E6E98C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA0PR11MB4638:EE_
x-ms-office365-filtering-correlation-id: 9684c24e-d0f9-41d0-69f5-08de8be10a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: f062c8k0kOkeqa8SZY4uYYXOplaU0AonTcchMnCBww0u1G+KnfgavqB0AIQhsnebSOWcvZIcRQgFcNPxkIGw/3fMPi2aZHOB4+ZQaUlST73a1Ufbn4yJLTzI6aM4KY1vpAANxv0NBRfGi+UpuULsNn/EXudi+e9Rns4xoa6WwlHa0UwZSpEeAA+B4/QDlvfCN1sQuExjy0ZTYgvbX52jN7qhwTfR2w7JC3FkJuwBPkYPwn7oi+qvsjWs/wrdpxWwXlbhvjePyWdfycBn5OG6tgUKl4b7LWXKllQwPD61ig1kurk1PcvHKcayAt9c7Q0hxI6XNxvHAplM5mOay7VvDNxNBF2jUE4W1R6wPlXcLF27JDnhhG9c9kf5V+AQXaty5ompnd5ltCy5GfUocdf97BePbsW+vjTmyjTKXtB755YjndMpedL+ahoC/cd+jMyLXK1WvIoiZQrU9vDbxKO47/CamCYG5UZlGQuAwAcJXCGx4Z5jnX+SjjXffg9pptg96jRPnySAiV0ll9KRXl8b2WGyv9oHhH45ckHfA+9ON4FLx+lFEhsN9k1MncM4LDfMusyaG+M+bLznNafoz+qPpOKJca5q2zYDxK9jCMz0NQD8iHaRm+SIXFVjS9ux3oJc3fXbFvEPeSFYK4wEqr0x+GsHIUmQC9Seu3E0vuWbCSAIoW5UJ5iJE7N6hk1Si6hfw9pOzC94woGgdRADCC4OyBU11x+h8TRI3mxX+gENy4z7Lbcj7ATaQ0yZ4CRyk8f1aS0OMGOorjglQW/YWPgs1Fo3DBTjtFwQmsSi3/TNaA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+z2svBMW7qLQ/DriUr4uv4nlsOEEMA030l/91JEfdReTrF/YIFJSa0vzvjnv?=
 =?us-ascii?Q?FYvaniEGSxS+P82GJh4xKdRXW/hbbGAszQIxBx1e8xsfrwhQ17giuySbvixS?=
 =?us-ascii?Q?BIJbaLG2rU0MEDZKbMxkkSxEvuyzEdaeF1M26m81ya1O7Q0xHEhxcSDBtDMp?=
 =?us-ascii?Q?OV+ZcOlDjpETKOreEp6NKOWawz/YvOg3RIz7K5qvCs3DTGzhi9PQKBJWcm4L?=
 =?us-ascii?Q?dbeMf+M5J7uXEbuRgyJV++1JICA8UM2KWtM2uP/ROPZZnfa1Wr2GMRWiwPcp?=
 =?us-ascii?Q?5+XFfacVqcjlKj8i9PqBn/xSQfjQda3X91P+iZBYUK6newMbyP1Eqr1lUKCn?=
 =?us-ascii?Q?lnMte1y1mI2TZT1aFqdAWSP/7HRs/gFJRe/Ko3AjSzk4e3rqd/TKs4gX4Xzn?=
 =?us-ascii?Q?jeCaQx2KWlAwk9hQqMJptUH1ZTq41ez7+0HQurYqFtubH6yQqp394nWwsKEN?=
 =?us-ascii?Q?1q7QrdqLw/6NE/V4dP62nZ8yvQF+puVeDrFL/nkymIKipKH0b1GehuHkKFj8?=
 =?us-ascii?Q?3ZPMaUQqQuBG+G3sPvE4iAWEE4tzC31xxIzGabOm0Xx7c0LbC8ig8DE7koap?=
 =?us-ascii?Q?Ubf1fogKrxoSX5Be7fX2QBFXYZo7zClCxQm6MBTLHbw9jzGmKc0gfv3HER93?=
 =?us-ascii?Q?ielo663KPWWZaeNsVpevA1bPNufxPYMZfkymrhlMmsv5qDaIM2Ad3glAUU9T?=
 =?us-ascii?Q?pQZa39JuqbXAnf2G10AOsnx3YSPHuy7kUAQzOJe9tty0oOCb3UOlGUAwSaTr?=
 =?us-ascii?Q?KUODnNYCDYcf7JWyluwtiYIcu2kXC8QP9KQqitV6/+0968NSaUSM2mOQ71PL?=
 =?us-ascii?Q?9rHXAu2OiHMafit1l35HFxWaczD5X2s38woRxWtHg6jOdltISx1OzWMO5bMA?=
 =?us-ascii?Q?dskI/PXpxdbF8Ey0UeHVVhdTZHi+Ftt4KlX/fBRSzKW6WQAHNbbcJX/uvH5K?=
 =?us-ascii?Q?f9wRxtuHeCjk/t0tofjO//d49r4ymCtJdPamvR1jC5wH8+eSQWOg08C5Cw/z?=
 =?us-ascii?Q?q+ht5t0y25AfpdgtnepvWVEtCaMbERHV9PDyuFtzUr3lHx5GNTwxbskvpoDO?=
 =?us-ascii?Q?pzKx7x+Gk+gvZ5+UHjvvg8ulItmf1W4+hAvsOeomCyhLn1vHb17tqBkS3SV6?=
 =?us-ascii?Q?fPlPY8J1NxkmHjbStZwvnk5VFcXg+X+RS6hvG2eMnUaOrXrsPjcAA0wI68+D?=
 =?us-ascii?Q?a615Y1JY/suSWawAOLBSOkJwrlaY5nVymrFfRlfaqBz239En7rSinlyTWvf8?=
 =?us-ascii?Q?Xyj1IAiOgd399ldzGFjWc9c0323+7HxFjo4kBdn5hQ5ZSTuoRfpMW1eXtAH+?=
 =?us-ascii?Q?dOVZTPG5kqtrzfmqVYA4APyvcr1xCoz7nb1v7MVMCm4kPABP9tPI1tdBMwLA?=
 =?us-ascii?Q?/0RxDOEoYSHoH7y/80J8cH6FVeHCKwzBkBoRaP5sRuiFSuZO0s74m1OWN5hQ?=
 =?us-ascii?Q?+oAZI+e76IAjdanex0B3mUAOvEFSo886AD+0oRsXCrxpqb64aqad5aqhVL48?=
 =?us-ascii?Q?1fujoxd2pDyc7jTFl4hgEy8hRWoJAmTfoNsFuRlmPrJk/cNwz5bG9s0w0sUZ?=
 =?us-ascii?Q?VAg6Grym+K0o5MQdsPki25977b3ChjaxjmJUNB7muIkzB2ViDil5ijiHq9y9?=
 =?us-ascii?Q?VIwjNH449otpTUOM8s6b9x1qUEkhaMeMpl2QWkGkTuhLafmtDhPyOWZHiJfZ?=
 =?us-ascii?Q?WEu6mfsvgIwFtesJwUmL1dNtUOfv/imSEIdUFrqcbyjvMTBu4G0pC7J6cTrq?=
 =?us-ascii?Q?GX2GBUGQ+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bjTFV4QkkUz0VESpzWPJFKRt/Cj5LTPaX8dBYAZroX/DyrWdTLKplNPsk0Fo5mIB01q24rHbKbtzgd4jPGmmXB42tRGFwF8use4wPoXBMc67lFIgxwDNvGJMh5kRjwBXTDWN5QziQr/9VIAbdeULgF9IfdQzspy6imLJSmxJm/PjrdCQC99XqK6B+AuXX4wlmy7qlGtF0BtdS66m6i2SheWuZNsBDLLwKw+Q32c6bR/b4fL6KUOsMgzAy07n066jKatcxTpuWyE6NsRvNpeqW6P6yJikwCBjVe9JCTNq0m20Pq6FW1r9MKT6t43FAFIcrDl+gPwpg7kvAasjGb1N+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9684c24e-d0f9-41d0-69f5-08de8be10a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 09:12:59.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxfRoeyZBb3iTWc9t+QjhN908ZtzlQ2fb95qcDEVrGvNxpF37zYi+0uq1cEF14pBqau1fVdMWOey9i4jYJdsyBEMbyvBNRahiy5xtSLq1y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4638
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Tian, Kevin <kevin.tian@intel.com>
>Subject: RE: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
>
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: Thursday, February 5, 2026 10:34 AM
>>
>> In order to support passthrough device with PASID capability in QEMU,
>> e.g., DSA device, kernel needs to support attaching PASID to a domain.
>>
>> But attaching is not allowed if the domain is a second stage domain with
>> dirty tracking, this is the use case when guest configures 'iommu=3Dpt'.
>>
>> The reason is kernel lacking support for dirty tracking on such domain
>> attached to PASID. Same for nested domain even though there is no such
>> checking.
>
>no check for nested domain is a bug. We should first add a check and
>backport it to stable kernel. Then have this series to allow it in new
>kernels.

Make sense, will send v2 with the bug fix as first patch.

Thanks
Zhenzhong
