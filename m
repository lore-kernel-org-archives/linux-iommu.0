Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAB33B97D
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.197.217.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464734; cv=fail; b=mOZNKgQnWDf3599iC/unz783OPkKwbJCJj0RRWlqSFOVZzhUgsSkzrIGWpS/LgFGH957zsoqCwm/rwVRdrVzW4Rw4MGPAkKGzo/dUj+bpU+0Oy8FDHjjyfd5xd5Di+MkBS7OzdP4tLqdvFowFl5QMXHp+lzmcCh7/rkrx5jpRP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464734; c=relaxed/simple;
	bh=NTYXoj4XfpCl90i9e6ntG8WxcChtX78BuhQXYk8m428=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaH4ARjh4QV1nXx/L3bGpeDZxjnVDTvoTOz3n5dvogtKP7BUvyJDvnvsTPvFc6UH5xK7BUSIpgmRpdUmNr2pjP+jVxa2p0C53eCUvweFYFe8G00hljBFt6+atlpwHEvGIBxxiOfEVfSPaqyI7+yL7ggThhPjg17H85kldPn/C5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=FYDwkjLZ; arc=fail smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="FYDwkjLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779464728; x=1811000728;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=NTYXoj4XfpCl90i9e6ntG8WxcChtX78BuhQXYk8m428=;
  b=FYDwkjLZNT1knNeuDcBmBsMm5niYCKiiJ8vVweL1KcDnDKQ11czPU0uO
   lRCnDJaw+PDookmqwlLQtneD21Pnfoc/MZ/f+ZrbkXXQTZFWDcZxuc+wU
   kDkAJYyQbQkMe9cY7J2sZCd7zqpXrqpPG1nTqZQvcq/BGpY01or6lHY8U
   WUAQ0L7nSMBz/rG+PUtRZNIkm7CLH6voCNco6YRCTPL64ptfmFjWyW06K
   LnAJ1GZRlzzakQMQc46HEY/FX1hhFlbsT/gbkbh4pp8u7DK4kRKdYUQqz
   31Ej82x/irnCEARt0FNzNAFMnXWF6WQGiRUFC1CXVG6xxwWgDoq8EGQgp
   w==;
X-CSE-ConnectionGUID: ZE2WCKO7T7CLlX4ctdedJw==
X-CSE-MsgGUID: NZnuohDCQwKdHk/IiPaZyg==
X-IronPort-AV: E=Sophos;i="6.24,162,1774310400"; 
   d="scan'208";a="14249344"
Subject: Re: [PATCH 2/3] iommu/vt-d: Add PCI segment and vendor:device ID to DMAR
 fault logs
Thread-Topic: [PATCH 2/3] iommu/vt-d: Add PCI segment and vendor:device ID to DMAR fault
 logs
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 15:45:23 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:6368]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.223:2525] with esmtp (Farcaster)
 id 5ae3f02e-f7a0-44d1-857c-8f86e779a0e3; Fri, 22 May 2026 15:45:22 +0000 (UTC)
X-Farcaster-Flow-ID: 5ae3f02e-f7a0-44d1-857c-8f86e779a0e3
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 22 May 2026 15:45:22 +0000
Received: from EX19EXOEUA001.ant.amazon.com (10.252.50.110) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 22 May 2026 15:45:22 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUA001.ant.amazon.com (10.252.50.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Fri, 22 May 2026 15:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJpLItY7ih6WGGVWiPb8HOF2Ben24GI3MQyEmPwQkzPw5fqAuv9q8MeANlp++D/069EMmj7SxLUmq2KxWjLbUvbcFtKyOx0iABjMksbzEKE2svsdwb21yXoGLBN+OuCvwcew+6Of9/0JvA68GZ40d2pDTl3KPcyBuJ4d/NIlGal8ENI+B8WwRJ3zqnoI8vkDMEMlyeNPksogwNNw7LsbihDetYZIK0MeFxxyAR3wGOStieJ4AuXjeR1SYHiqIi1Qa3CEDu+ECj2WIaXkGHuk/DxwfNrZ9nRKy61XQlh1uufG70yaUtem9Lf9WttuSZZjW/4aq6Ej79FdfKgf6G9AEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7QOccWQghb3dPnp2tCeamb4hj8SzUQIe2J7hyWKfr0=;
 b=e5tGG4EK7S+4iyqL2PWrkNZiJbUjIDpAKoFrAP3LEFBrKV/Fho+72HrviESmUAKX8yfQPJzjCmekcQByZG/JGP/dKRbUoCccYKpnPHKlBS0bO8EWXPtDcgX7Kcy4FlmcilZHLzK9y232+Mzez1viyRPSqWu3Ma6NgA4WFOaeQPKaXCjpcsmFz4ZVaKU++/mrEZFNQETNOqZK3ERlZeZIlfn4cYB6TGHf/s1sk8s3/MjVwTEeHvNAiyAIzc0pCj7PdyCPxIWAhtaR8RlpTq/z1bAsNO9eJscpggXHRxla6AQMzReECjzNgiAw51rwUy7cUfMmjaCgVeQdIHuH0pEReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c6::18)
 by FR0P281MB1721.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 15:45:18 +0000
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027]) by FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 15:45:18 +0000
From: "Oguz, Yigit" <yigitogu@amazon.de>
To: Pranjal Shrivastava <praan@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Janpoladyan, Lilit" <lilitj@amazon.de>,
	Yigit Oguz <yigit.oguz2000@gmail.com>, "Saenz Julienne, Nicolas"
	<nsaenz@amazon.es>
Thread-Index: AQHc3WoA4iWnNVkKCU2rpPhthy+hjrYC8qCAgBd4DQA=
Date: Fri, 22 May 2026 15:45:18 +0000
Message-ID: <C0E7D57F-B7AF-42EC-BF22-C5DC43DBB022@amazon.de>
References: <20260506150541.60467-1-yigitogu@amazon.de>
 <20260506150541.60467-3-yigitogu@amazon.de> <afzmQ6FieJ2YIt9Y@google.com>
In-Reply-To: <afzmQ6FieJ2YIt9Y@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-22T15:37:33Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=d810c684-a4e9-48c1-b24e-709f6a81b72f;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB5782:EE_|FR0P281MB1721:EE_
x-ms-office365-filtering-correlation-id: 11f81ff2-d708-4943-8935-08deb8192023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003|6133799003|11063799006|3023799007|4143699003|13003099007;
x-microsoft-antispam-message-info: YEIFRvsuFyunZYx6HjppHOSxP7fRqM+UAHoqSf/EgJsArC7akG0xKeHKTUAHMvYLC7bTHmRl0rVyUcVNNwzHHkPtxRkBWCJvxD79FGYdgytIfIInafIpifPRl4vSMsmUGNfcn/gZWdtQf2TGUOM+IKYriUOgupJVklNNabQNrdB7biBcsZfWbK8/9PW38A/oXkKiYDkRgUTMGCuyjjeeX8e9NkUQJMT9eBXwYCE7Q7iByKDnoneYHctI4SFkOVmYszXrqp5CL4YHhEPHrQPrbUCzKocF5UXBU9kKk+CLVezfSRayGzBjdSVQO/s0OWD5UbAWjTJ7nMJ/zp3OqdYNZHi7JR1Ao/dP7Bybb2Nmb9UhJW0LToBoq4XDn/5y1YKedfixeiiCWu25lrQdMr8Rl4gS45yXeUyQdGgcPcPnyDJlDKftDrSIY1ThhNK+ZiWkXXNadKKePh5t3U6HkKDYG+RW9HAopMtrx92jDCpVqw3Ww0jMC2sfKaAqhx9ozz6kubLT0iZ9FxRuydrR4qeXSiessJShFsd0absSNNwoHjaTy9keEFYEhOej6OGPskZrUs3rvUJ1OHfJvyXhwr9bMnluk3tCNwYInW4GCWR6DQfS0xxOZ/OglYR6T4g8/buFD25OaLOWHdO293OzLB9ydVtD6E5SxsZdzf3V4P2NSn9rJ4oLvyVGg+cQiW2x+jp51AI4PvanCX/4PLz7STmxDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(6133799003)(11063799006)(3023799007)(4143699003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklMNXpyRGN5V0UyY0NWNk93TVhCZzlJRUlpd1YzZkw2MnRSSVgzVTd5d2lJ?=
 =?utf-8?B?UVc4ckcyTjZrckMwWHA1c1FuOVVWeitmWjJ3UXY4Z1JINFBOMm5TTlU2QXNN?=
 =?utf-8?B?MCtGbU9nVjZPdXV2MGJCTkswMWVIU2RIU2d4VFhvOHRDRjRHSFNsZmZaM3Zz?=
 =?utf-8?B?T2ZyVE5ScXUxRWZ2cXRIRTk3dmIxUzhpMVkxQmNZVWdCUkZ6Q3pUdVdSQStK?=
 =?utf-8?B?TWNuWmFKWUJXbWt5dzVKQTZiV3VqeldmblhsYi93am5DVVBzM3NQa0FjeWFD?=
 =?utf-8?B?SFdKODh2YmsvMEt6aVJKZCtFRUs1MDlIN1pRUzcyZDlENlE0ZkVXajRNc0hS?=
 =?utf-8?B?cllUTFNDSXNRSTYvQWphZUp0QVMrTVRkT0pSaW1QSzdJK08vbjMrdDNScDhU?=
 =?utf-8?B?RnBWU3hqSkwrYlhhTWJVL25HcmNtWW5hcStVcjJiQXpIenpGeHJLZmhTR2NP?=
 =?utf-8?B?eTdvYktKQnRobFlvelFRa21lRmxSbjQ4V0ZzbFZodkdhaktvb2RMN3lOd2Vu?=
 =?utf-8?B?OGFMVk1DVzRHeVdMUjFMNWVjTzJjVitqZE9udEdJVjBaMUVoWjY2aXFBUXRU?=
 =?utf-8?B?eDdMT01Qc0g0VGRYRGlwYkt5d0IyTDBXbnRrSEUvc2lQbXVRTkk1TFBRbFpC?=
 =?utf-8?B?RGxTbkk2WUVzZmsxVUNXWGtmVGdrRzZJWURJa0hGOFRuNkF5c2g0RHJON2JT?=
 =?utf-8?B?YXd4bDZIVyszK09RYmlFTUxaTHJzb2ZZeWZpRFVJdk91U2ZhSHQ3WFFzZDJB?=
 =?utf-8?B?SmhQNXFKaWtiZHk0UFhvaDl1ZnpTblBVSWlwNmNPOWg2U2RDcmlmVXpUb1FZ?=
 =?utf-8?B?Ym90M0lGUTR0SXJ0dDFGNTFJTnFxT0FWblJQajR4NGpyZGZnci94Z3J0NzVB?=
 =?utf-8?B?SWpRbit4WlUyNHQ1YXZLY1Rvc3JEbTAwYkFzckI1L1JWVUtRT2ozaFE3bXFI?=
 =?utf-8?B?bFlDRW13NVJWRW52R0JUejFQMjh0K2h5dEFWbEtTRHZHY1dVTnc3QThUckYv?=
 =?utf-8?B?Vkk4UDdLZmFGVTdKZTJ3bDVrWmUrVnJ2VCtsakRzenZnSXNLUmFIOE9lSzVX?=
 =?utf-8?B?Ky9ad1BUdDBtZFJkN1dhTVBaQms0WkMveml2TTc0M1lpTjRaRGdXU3FBVjFY?=
 =?utf-8?B?MFJWTWVKbzdhbWFqSEpyeXdhbWtlWEVvM0pMblNHVGk5T3JRUjZYVTJlUWVY?=
 =?utf-8?B?bFJRK0hqMDVYbHZLNGNhcFlZT1U4blZBZExDbUpFM0t0QW42eUQwRXA3VGFR?=
 =?utf-8?B?dWtOK1RBUEtBUm1UZ0tZNC9PTE9XcHdPc2VHeEVEd2wrTmZRQkk4V3l1ZU5S?=
 =?utf-8?B?dWhBcWlQNnNlQUo0Z1VyS2dhZW5nbVYwQ3owb1M2dlpBTU1LMExISXFDUm80?=
 =?utf-8?B?WWNJOVkwR3pCM0lpaWt2Mk5MbVhYNk8yUHk4OVB5U1htK1FXNFkzZ1FmMnpI?=
 =?utf-8?B?d2twUGpPZ2w0U1EzUGNEVEFlYjE0Sk9WdjlqdlBRTEhhS1pXTThBenpGY2Vo?=
 =?utf-8?B?VGx6MkdVTVB6Yng1ODEwWW1aRS9TSExLcitPNkJYeTRlbzlKY2FYOW5yWXdo?=
 =?utf-8?B?WWZ2MTdwbVZseUlGQ2xSUXJlWkFURjJEdERBN0p5QkF5SS9FYkJXU21yNCtD?=
 =?utf-8?B?cWQzTEg1TzZzSkJNQWF0NHVDdnNxQ2pjRDUrNFVZVi9FUWl3REVZTWF2dUhZ?=
 =?utf-8?B?bXJIMkVFWkdzeWVGSENyVEVweXNNdHpSRlU4Vng0U0xpZlV2eWt1MS91U3hu?=
 =?utf-8?B?MnV4Y2JkTGo4SU53K2tiU29IREpHZnludkowQmMyTnl0ekJrdUNHK2Y4YXZ4?=
 =?utf-8?B?WWxTMDFNUlU1OHM2eFgvRDJQY0tRUkt6M3lzZnJ2OEtwaU53Uktsd1VVdkRM?=
 =?utf-8?B?a0kzTlhYU2x6WW9VWERkRGtFMTNicjRUT24vQVdqSXFTSTdycWNtTzhIVDMr?=
 =?utf-8?B?VWRRckRYT1Blekg0bHh6akZPVVFKVkxUZWtscG1JS1FZc3VoaFVUQ2lRb3c2?=
 =?utf-8?B?dWVGUDYySFpMNWFQbkp4RVI3U2RzTk1ja2ViQ2MxckZIT3BNUldXc054T0pS?=
 =?utf-8?B?UkR1Y2IrL0hBcUFIT0pSQi9OTXRpUzViRFRRNkFGZWs2cWlaU1l5b3ZUdTl4?=
 =?utf-8?B?Q0N4VzdKbW40NEFRMEV3RTBMdDVWbFBmM2dhOHRwR1gxNEZqOVlDWDk0SHpo?=
 =?utf-8?B?QXNXMVcrQ29hRHo5TDdOOTFXV2ZRdzJUT0FicjMwdkZRY0lVVlZVRE1kWjM5?=
 =?utf-8?B?QWdKc0x5ZG1CbGRzZGVtWlk1WlZOVm5QMitxWUdkVzdiUFNwTjJ3SjRISnpM?=
 =?utf-8?B?SmJWWW5MTFpGZVlvZFEwOHlNa2VIVUVESG1FcnQrOSsvc1lQVmZVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85D1FB26B5E53E47AEE5DC1DEF2B7CA8@DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N6H6WSHiGiZr9oce+3xkkdfRZ7FimIY7/0tX4zxhw3VbcSMrjMi593As2UZrMoLuTH/12+dEdLW9vKSAsFUvUTOVT2ZFCeeSxGh7uDZkovRvSJJr6VPra1ry4d3++C6aT3QkE+/OQb3/r5q5Rb6rp0sDTA9vTY+wrUMGkA7zRN5WxlvOXt/BfrM9hk+QoCfRMddI/+5jZASps1lPr8b988kEZklboYkQ2ztwC26yQJB5bL8f5CycVNwhTscACksK7QvIf793gjUpF3ThHvqVtjnwORTYu0RXfocfdc56XxBpv2yRox0P6uYMCuX3D4p8Rq9w+hmsHmR0fV1v0eztTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f81ff2-d708-4943-8935-08deb8192023
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 15:45:18.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK0nJOpfC/EY06K/8esj0rK9OxUe2FX9hjPXSf0RJEiylEiJlcRzpnDXLkSBNOlMUSh1Zkr2bB1zW9jeJ+ewOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1721
X-OriginatorOrg: amazon.de
Content-Transfer-Encoding: base64

PiBOb3QgYW4gSW50ZWwgaW9tbXUgZXhwZXJ0LCBidXQgSSBoYXZlIGNvbmNlcm5zIGFib3V0IHVz
aW5nDQo+IHBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpIGluIHRoaXMgcGF0aC4NCj4NCj4g
QUZBSUNULCBkbWFyX2ZhdWx0X2RvX29uZSgpIGlzIHJ1bm5pbmcgaW4gYSBJUlEgY29udGV4dCAm
IHRoZSBwY2lfZ2V0XyoNCj4gZmFtaWx5IG9mIGZ1bmN0aW9ucyBpdGVyYXRlcyB0aGUgZ2xvYmFs
IFBDSSBrbGlzdC4gSXQgZXZlbnR1YWxseSBjYWxscw0KPiBidXNfdG9fc3Vic3lzKCksIHdoaWNo
IHRha2VzIGEgcGxhaW4gc3Bpbl9sb2NrKCZidXNfa3NldC0+bGlzdF9sb2NrKSBbMV0NCj4gd2hp
Y2ggaXNuJ3QgSVJRLXNhZmUuIFNhbWUgdGhpbmcgd2l0aCBrbGlzdF9wdXQgWzJdIGNhbGxlZCBp
biBrbGlzdF9pdGVyX2V4aXQNCg0KWWVzLCBjb25maXJtZWQuIGJ1c190b19zdWJzeXMoKSB0YWtl
cyBhIG5vbi1JUlEtc2FmZSBzcGlubG9jaywgc28gdGhpcw0KaXMgaW5kZWVkIGJyb2tlbiBpbiBo
YXJkIElSUSBjb250ZXh0LiANCg0KPiBTYW1lIGhlcmUsIHBjaV9kZXZfcHV0IGNhbGwgcHV0X2Rl
dmljZSB3aGljaCBtaWdodCBzbGVlcCBbM10gYW5kIGhlbmNlDQo+IHNob3VsZG4ndCBiZSBjYWxs
ZWQgaW4gaGFyZCBJUlEgY29udGV4dC4NCg0KQWdyZWVkLg0KICANCkkgbG9va2VkIGF0IGNvbnZl
cnRpbmcgdGhpcyB0byByZXF1ZXN0X3RocmVhZGVkX2lycSgpIHNvIHRoZSBoYW5kbGVyDQpydW5z
IGluIHByb2Nlc3MgY29udGV4dCwgYnV0IHRoZSBETUFSIGZhdWx0IGludGVycnVwdCBpcyByZWdp
c3RlcmVkDQplYXJseSBpbiBib290IGJlZm9yZSBrdGhyZWFkcyBleGlzdC4gUmVhcnJhbmdpbmcg
dGhlIGJvb3Qgc2VxdWVuY2UganVzdA0KdG8gZW5yaWNoIGEgbG9nIG1lc3NhZ2UgaXNuJ3QgZmVh
c2libGUuDQoNCkkgYWxzbyBjb25zaWRlcmVkIGEgbWFudWFsIGxpbmVhciBzZWFyY2gsIHdhbGsg
dGhlIFBDSSBidXMgYW5kIGRldmljZQ0KbGlzdHMgdG8gZmluZCB0aGUgbWF0Y2hpbmcgQkRGLiBC
dXQgb24gc3lzdGVtcyB3aXRoIGh1bmRyZWRzIG9mIGRldmljZXMNCnJlZ2lzdGVyZWQsIHRoYXQn
cyB0b28gbXVjaCB0aW1lIHNwZW50IGluIGhhcmQgSVJRIGNvbnRleHQuDQoNCkRvIHlvdSAob3Ig
YW55b25lIG9uIHRoZSBsaXN0KSBoYXZlIGlkZWFzIGZvciBhIGNsZWFuIHdheSB0byBnZXQNCnZl
bmRvcjpkZXZpY2UgaWQgaW4gdGhpcyBjb250ZXh0PyANCg0KVGhhbmtzLA0KWWlnaXQNCg0KT24g
V2VkLCBNYXkgMDYsIDIwMjYgYXQgMDM6MDU6MzhQTSArMDAwMCwgWWlnaXQgT2d1eiB3cm90ZToN
Cj4gSW5jbHVkZSB0aGUgZnVsbCBTU1NTOkJCOkRELkYgYWRkcmVzcyB3aXRoIFBDSSBzZWdtZW50
IGFuZA0KPiB2ZW5kb3I6ZGV2aWNlIElEIChWVlZWOkREREQpIGluIERNQVIgZmF1bHQgbWVzc2Fn
ZXMuIFVzZXMNCj4gaW9tbXUtPnNlZ21lbnQgZm9yIHRoZSBQQ0kgZG9tYWluIGFuZCBwY2lfZ2V0
X2RvbWFpbl9idXNfYW5kX3Nsb3QNCj4gdG8gbG9vayB1cCB0aGUgcGNpX2Rldi4gRmFsbHMgYmFj
ayB0byBzZWdtZW50OkJERiB3aXRob3V0DQo+IHZlbmRvcjpkZXZpY2UgaWYgdGhlIGRldmljZSBp
cyBub3QgZm91bmQuDQo+DQo+IFRoaXMgYnJpbmdzIEludGVsIElPTU1VIGZhdWx0IGxvZ2dpbmcg
aW4gbGluZSB3aXRoIHRoZSBBUk0gU01NVXYzDQo+IGV2ZW50IGRlY29kaW5nLCBtYWtpbmcgaXQg
ZWFzaWVyIHRvIGlkZW50aWZ5IGZhdWx0aW5nIGRldmljZXMNCj4gKGUuZy4gYWZ0ZXIgRkxSKSB3
aXRob3V0IGNyb3NzLXJlZmVyZW5jaW5nIGxzcGNpLg0KPg0KPiBCZWZvcmU6DQo+IERNQVI6IFtE
TUEgV3JpdGUgTk9fUEFTSURdIFJlcXVlc3QgZGV2aWNlIFs4NjowMC4wXSBmYXVsdCBhZGRyIDB4
ZTAwMDAwMDANCj4gW2ZhdWx0IHJlYXNvbiAweDA1XSBQVEUgV3JpdGUgYWNjZXNzIGlzIG5vdCBz
ZXQNCj4NCj4gQWZ0ZXI6DQo+IERNQVI6IFtETUEgV3JpdGUgTk9fUEFTSURdIFJlcXVlc3QgZGV2
aWNlIFswMDAwOjg2OjAwLjAgODA4NjoxNTMzXSBmYXVsdCBhZGRyIDB4ZTAwMDAwMDANCj4gW2Zh
dWx0IHJlYXNvbiAweDA1XSBQVEUgV3JpdGUgYWNjZXNzIGlzIG5vdCBzZXQNCj4NCj4gU2lnbmVk
LW9mZi1ieTogWWlnaXQgT2d1eiA8eWlnaXRvZ3VAYW1hem9uLmRlIDxtYWlsdG86eWlnaXRvZ3VA
YW1hem9uLmRlPj4NCj4gU2lnbmVkLW9mZi1ieTogTGlsaXQgSmFucG9sYWR5YW4gPGxpbGl0akBh
bWF6b24uY29tIDxtYWlsdG86bGlsaXRqQGFtYXpvbi5jb20+Pg0KPiBBc3Npc3RlZC1ieTogQ2xh
dWRlOmNsYXVkZS00LjYtb3B1cw0KPiAtLS0NCj4gZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMg
fCAzMyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pbnRlbC9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiBp
bmRleCBkMzNjMTE5YTkzNWUuLjIyNWZhNDk4ZDcxNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
b21tdS9pbnRlbC9kbWFyLmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4g
QEAgLTE4OTAsMzAgKzE4OTAsMzkgQEAgc3RhdGljIGludCBkbWFyX2ZhdWx0X2RvX29uZShzdHJ1
Y3QgaW50ZWxfaW9tbXUgKmlvbW11LCBpbnQgdHlwZSwNCj4gew0KPiBjb25zdCBjaGFyICpyZWFz
b247DQo+IGludCBmYXVsdF90eXBlOw0KPiArIHU4IGJ1cyA9IHNvdXJjZV9pZCA+PiA4Ow0KPiAr
IHU4IGRldmZuID0gc291cmNlX2lkICYgMHhGRjsNCj4gKyBzdHJ1Y3QgcGNpX2RldiAqcGRldjsN
Cj4gKyBjaGFyIGRldmlkWzQ4XTsNCg0KDQpXaHkgbm90IGhhdmUgYSAjZGVmaW5lIGZvciB0aGlz
IGxpa2UgeW91IGhhdmUgZm9yIEFNRCBhbmQgQXJtPw0KDQoNCj4NCj4gcmVhc29uID0gZG1hcl9n
ZXRfZmF1bHRfcmVhc29uKGZhdWx0X3JlYXNvbiwgJmZhdWx0X3R5cGUpOw0KPg0KPiArIHBkZXYg
PSBwY2lfZ2V0X2RvbWFpbl9idXNfYW5kX3Nsb3QoaW9tbXUtPnNlZ21lbnQsIGJ1cywgZGV2Zm4p
Ow0KDQoNCk5vdCBhbiBJbnRlbCBpb21tdSBleHBlcnQsIGJ1dCBJIGhhdmUgY29uY2VybnMgYWJv
dXQgdXNpbmcNCnBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpIGluIHRoaXMgcGF0aC4NCg0K
DQpBRkFJQ1QsIGRtYXJfZmF1bHRfZG9fb25lKCkgaXMgcnVubmluZyBpbiBhIElSUSBjb250ZXh0
ICYgdGhlIHBjaV9nZXRfKg0KZmFtaWx5IG9mIGZ1bmN0aW9ucyBpdGVyYXRlcyB0aGUgZ2xvYmFs
IFBDSSBrbGlzdC4gSXQgZXZlbnR1YWxseSBjYWxscw0KYnVzX3RvX3N1YnN5cygpLCB3aGljaCB0
YWtlcyBhIHBsYWluIHNwaW5fbG9jaygmYnVzX2tzZXQtPmxpc3RfbG9jaykgWzFdDQp3aGljaCBp
c24ndCBJUlEtc2FmZS4gU2FtZSB0aGluZyB3aXRoIGtsaXN0X3B1dCBbMl0gY2FsbGVkIGluIGts
aXN0X2l0ZXJfZXhpdA0KDQoNCj4gKyBpZiAocGRldikgew0KPiArIHNucHJpbnRmKGRldmlkLCBz
aXplb2YoZGV2aWQpLCAiJTA0eDolMDJ4OiUwMnguJWQgJTA0eDolMDR4IiwNCj4gKyBpb21tdS0+
c2VnbWVudCwgYnVzLCBQQ0lfU0xPVChkZXZmbiksIFBDSV9GVU5DKGRldmZuKSwNCj4gKyBwZGV2
LT52ZW5kb3IsIHBkZXYtPmRldmljZSk7DQo+ICsgcGNpX2Rldl9wdXQocGRldik7DQoNCg0KU2Ft
ZSBoZXJlLCBwY2lfZGV2X3B1dCBjYWxsIHB1dF9kZXZpY2Ugd2hpY2ggbWlnaHQgc2xlZXAgWzNd
IGFuZCBoZW5jZQ0Kc2hvdWxkbid0IGJlIGNhbGxlZCBpbiBoYXJkIElSUSBjb250ZXh0Lg0KDQoN
Cj4gKyB9IGVsc2Ugew0KPiArIHNucHJpbnRmKGRldmlkLCBzaXplb2YoZGV2aWQpLCAiJTA0eDol
MDJ4OiUwMnguJWQiLA0KPiArIGlvbW11LT5zZWdtZW50LCBidXMsIFBDSV9TTE9UKGRldmZuKSwg
UENJX0ZVTkMoZGV2Zm4pKTsNCj4gKyB9DQo+ICsNCj4gaWYgKGZhdWx0X3R5cGUgPT0gSU5UUl9S
RU1BUCkgew0KPiAtIHByX2VycigiW0lOVFItUkVNQVBdIFJlcXVlc3QgZGV2aWNlIFslMDJ4OiUw
MnguJWRdIGZhdWx0IGluZGV4IDB4JWxseCBbZmF1bHQgcmVhc29uIDB4JTAyeF0gJXNcbiIsDQo+
IC0gc291cmNlX2lkID4+IDgsIFBDSV9TTE9UKHNvdXJjZV9pZCAmIDB4RkYpLA0KPiAtIFBDSV9G
VU5DKHNvdXJjZV9pZCAmIDB4RkYpLCBhZGRyID4+IDQ4LA0KPiAtIGZhdWx0X3JlYXNvbiwgcmVh
c29uKTsNCj4gKyBwcl9lcnIoIltJTlRSLVJFTUFQXSBSZXF1ZXN0IGRldmljZSBbJXNdIGZhdWx0
IGluZGV4IDB4JWxseCBbZmF1bHQgcmVhc29uIDB4JTAyeF0gJXNcbiIsDQo+ICsgZGV2aWQsIGFk
ZHIgPj4gNDgsIGZhdWx0X3JlYXNvbiwgcmVhc29uKTsNCj4NCj4gcmV0dXJuIDA7DQo+IH0NCj4N
Cg0KDQpbLS0tLS0tLS0tLS0tLS0gPjggLS0tLS0tLS0tLS0tLS0tLS0tLV0NCg0KDQpUaGFua3Ms
DQpQcmFhbg0KDQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4wLjEv
c291cmNlL2RyaXZlcnMvYmFzZS9idXMuYyNMNjAgPGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y3LjAuMS9zb3VyY2UvZHJpdmVycy9iYXNlL2J1cy5jI0w2MD4NClsyXSBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4wLjEvc291cmNlL2xpYi9rbGlzdC5jI0wyMDkg
PGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjAuMS9zb3VyY2UvbGliL2tsaXN0
LmMjTDIwOT4NClszXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4wLjEvc291
cmNlL2RyaXZlcnMvYmFzZS9jb3JlLmMjTDM3OTQgPGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y3LjAuMS9zb3VyY2UvZHJpdmVycy9iYXNlL2NvcmUuYyNMMzc5ND4NCg0KDQoNCg0K
DQoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgK
VGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJp
c3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERF
IDM2NSA1MzggNTk3Cg==

