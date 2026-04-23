Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D83630A3
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931317; cv=fail; b=IUWP9TP0/1/UuGYqOSg7HuF14OE+mBcQ8csl+/+GwJYEyjmzv7VAjKQBKG8YCrX8Se1QYQP7T4P+qe7VTHWuYtVugiDm6SEU/YUYStt8wXNpRjuxV6TZHvt1fNK52GlPym6GC2+uUMILbPeapFJyDT7a6u4iMjvbqCinl0fTotU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931317; c=relaxed/simple;
	bh=mI8UwAD7OHI7ISiSB9HEpm60Fqupw13CdiWlOlqt3DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOTyNePBYfcZF+3iHuA1pQBg+qkerezaNMSRBu42aCAa0I5RphTGMr72K6tVcEGpQwpCI/lMuj3VcIwKUlzuhMJsdjAFEmspG2iDTxMbHESSmqTZl9yMGUOpNvKyhzlbC+sK1yhOSOupNor0QT+Sj5V+F0hM811CQ/PhQh5z55o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc/SiT7+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc/SiT7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776931316; x=1808467316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mI8UwAD7OHI7ISiSB9HEpm60Fqupw13CdiWlOlqt3DM=;
  b=Bc/SiT7+3wLdK9cRnxL7smgfxon5727Rt1Cf/t9QktAAXbqUNsrb7UvE
   hsJpd/C/de/TWc1/CCJAcyXqA2lZv3JQAFirWS0a5A7LZoVGN20yL7j29
   5f3aqmkg4m6b6zlYaA7x1uTdo7R9LWYHjjjWJVieBMExcYCPLxgnNIuF6
   XoRwm0iQLErX06qoTUnJOBDSfBv2p1sliqxF2IIa4MOhebGZlDJ9lEJ5c
   n0wn672F8+9OFI6nM7xDpbha9NT96L+cr1FEdRj5XyVpuduqOk+TT8F6+
   +Nttan/b2viUV6iCYM2oRllaxMZgZcKTO8Mknjm/Y1wTNyCoLYYvQYbkF
   A==;
X-CSE-ConnectionGUID: bp54JsbWRNuaRBpXaYLo7w==
X-CSE-MsgGUID: qhxjCOxQQn6g/stoi45UWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95307888"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="95307888"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:01:55 -0700
X-CSE-ConnectionGUID: 7faCaAwcTiWhieb4LcXYzg==
X-CSE-MsgGUID: r5IeB5O3QAigGExXzVswuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="232501565"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:01:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 01:01:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 01:01:53 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 01:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkLgOjstDWEMofQogmzbHn+LPiBHYeaYyRN8VYmP6Ffyh0hf1SuOsQLijgZ2EaoBYoqYNCe89RDWxEKuvwPbVm+2YKzAbE1pFEINjormZYn1x7vZEVdgK23sZ8NuNRb4A7r84CZCqj5xUPjHQCjzJGftmhZ3PvbOE20HhRPeDwF1Mnj4IUEk9dnUcl7bjhw690V2SCZtlKtqCl+8cgOSSf1yIwicfHSa5B/hYJUdX359tp1ns3KW9xnl0e20JDNpXvAryND6TmelIq0ts3rlzNyeLlwZrwCBgq0pWL8Yk15d/GMrWAsbwJd1MOBTiJE2C0jKHvQX9aAsDkVb/7miMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI8UwAD7OHI7ISiSB9HEpm60Fqupw13CdiWlOlqt3DM=;
 b=IAttDLV/6be2ZgoCY8jmS23lzxT3d1A002gmrU1jZyOUkssKbSMiUq5+LVJtApdg65RaChpC0wtevi8LVuqiffD5GhDAnKgwRgwv4/IL8OR6uqnytiw4zGm5zn5JSxBOgHnGU8BPVUnvs3iN7QfjYlustmHgiXj8pKpOfzMayz0puGZmsxJ3SplXI6q2cuOXUpF6gDV/oVK4m80ul9Os5xuqD/2AkxEtlBHI4Ws43RJvoQ4H1fn9dIoNl/jFsfc4vXV9ddBNvlCDDiPh50GqGmoMQosBKrEwJ61IRqP7x/6znUxI4cPy3vDI/98p+dfrSMcxn7muMngVvENzkHj6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7699.namprd11.prod.outlook.com (2603:10b6:806:338::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 08:01:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 08:01:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Teddy Astie <teddy.astie@vates.tech>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Xen-devel <xen-devel@lists.xenproject.org>
Subject: RE: How to express "externally managed" IOMMU domains for
 VFIO/IOMMUFD ?
Thread-Topic: How to express "externally managed" IOMMU domains for
 VFIO/IOMMUFD ?
Thread-Index: AQHc0nD/HbUzotrTgkKZyZa10hSZGrXsSRwA
Date: Thu, 23 Apr 2026 08:01:50 +0000
Message-ID: <BN9PR11MB5276B3A829AD624A7E1AB4408C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1776873531.8631fc262581453bbf619ec5b2062170.19db5ea67ab000f373@vates.tech>
In-Reply-To: <1776873531.8631fc262581453bbf619ec5b2062170.19db5ea67ab000f373@vates.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7699:EE_
x-ms-office365-filtering-correlation-id: 0fddad7f-59d3-41ab-4944-08dea10e933d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: PLJf+pqvR3n8CJr9o7OLcLrYpPQrCCVfNHYt2peujULl86EDJAKPwRIxmX7Lort+gn/GCY6FtePlq5SDNa04SgjemFPEmie7BWU8yy600fsWAhAoXcVKhwI2fIZ3TPlRLNJFwGV3WoH0CmHFcb4ckwW6+H8EvEi8b3fFUD2XDvc/OYBelf7kuFJ4/0u5TNNyAMWPa9Kdpj3w3K9fs1oPEfy/75J0V+hOwVJ3Dy8Pf6H49yFwTja3yxoMHCykZP1wYCwp946rTdIZJ41isd6BYy6XEtuL5wj+V5RE5iCTpiQQ5WycuUQlhDGn5LRvmxUqpofd08PR8jKyS3DlJYOeICRlmMOlZYMjlZ+AcTI0HwUcJa16lr2O1yxJ79xbZ8PhHv+015vnegbthSJqJ1D2KCNrm+Y9rCsbMWVM4XuKo+jwegWpxVK9iXa6IEm7kX4+UQyZY3NPkcuFSK+BNkARjnyWiJeSqJltvhmXfdsW3Qr1ntAYDFoc//0CmVsZTz6dtmhZuE5quZhAMn0yMDFtzQAQmtfFT4JWgaDTcYdLK18UiZvhW2Efj1upq/0/S+C0xVQiHmnW1Acp1v1UqtsdRnBpDKX3qd8O16/gp8qJ52P2C7zlkE75rPS0deF1Wue6vioRKajLdeHAXcW1/UcKXxpSEA+tC2V/YWLTk6Q1YZuB752q9zds3X8BU39QhvfRe8ZoZlNP4cWnyYLpkNwo8IcuOXAA3pIK130HZwBjmRn6dWWsm27+LqC+CdJE42YT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hsRzhDUUN0T2dMSzVDMHlQKy9BR3Zya01WcGl3Y0dFSlpncTVKdWFmMHdN?=
 =?utf-8?B?Q1hjQ1pZUGZpckpxNUcwMjJocGFnVlFZMTQ0QS9CVE1QWkw4Q25hb08wUC8y?=
 =?utf-8?B?WEY5d1NVZWh1cW1SQ2dBSnhpdVJCYytZUlN3YWFrWTczRkdGbDJNNWpLa1RF?=
 =?utf-8?B?NGNMRnpHYmtVYmkvSGVVMnllbmsvaWQ5WWs3SFkxM1FwMXlTSGNrOWRXK1h3?=
 =?utf-8?B?ZDUyS00rMWRaeXYyNytmZmFOa0EzWUd4cUpFVi9IazJicjF5VGNPVXA3UFll?=
 =?utf-8?B?dW5YbnpaaUFYbUFzcVcxZWZjNURob1E5aW9qcGpKTTZ3NjlLTXRKTWswamFT?=
 =?utf-8?B?VE9rSFdoRWxBcGkvV05CN2ZDKzNWWE5PekI0VUtvQzRGeWF2eHdmbkZ2Z3Fr?=
 =?utf-8?B?ck9ZZXdSdjczakNUYStGWjRNd3BDeGhpcGpiUGU2dzQzekRjWWVPcDlOR2s5?=
 =?utf-8?B?Mk5INnAvNTZDVE4rZG1SdEx0Z2pnRHNOY3FnYzZCUVE1Kzc0TTlnUWsydFVs?=
 =?utf-8?B?UFVPZEl5b21CQUUrdTVacmtyeGRCdTIxc2tnMGRvalZvTVhmR2FsamV4WlNR?=
 =?utf-8?B?Y0RTWWtTdEU2MHZjMUMrWmFBbWdEUUF6NzRacGMySGJ0Qmg0N0J0V2phS3ha?=
 =?utf-8?B?UzdLdUwvZlA4MWJkT212UDdxeXN5Y0xYUmNJeFRWQXJqdUZSTXdpOHpSYnR4?=
 =?utf-8?B?YWJMa2hIQjRsczMvWmw4YkxycGo3M3MxN282ZWF6UTZyYkN6dE9KejcyM3dz?=
 =?utf-8?B?MXN4MlZJNSt2dnJvUDFYMDFEQkxZVlpIQitzQUdwQUZ5VDBHdmJQemVseVdo?=
 =?utf-8?B?TmlmV3Vaa2todndnSGFOdmxHeGlrTDZjTjdGZmwzcVkzUVUzbnBIbkFpNVVl?=
 =?utf-8?B?WXVReS9sdGg5bmUybzRibG1nNU5Kd0JIaFYyOE4weFhBMkVxMG5iQjFNMTZj?=
 =?utf-8?B?S3FQOTdYWWoxWDJYdFBQUlQxRmk4cWVDT2luZnducWNZVFd4N3BXN1c1M1FQ?=
 =?utf-8?B?dW16YUV0SEp3MTc3eFdIdTEvYnNlODJ0dVd6eHlYbnFDdjlWcGtSS1VuZis4?=
 =?utf-8?B?RFJpTXRKZlVjUmhQWVNuQ3d0blFZMnBvWCtvSjB5QVYxbm5FZmZ1dS81cVVj?=
 =?utf-8?B?a0RTTHFzMWJiMW9rRlhDdkM0Z3QzUkRMdGFGeGd5MG9MQnBENkhOb1ZlSHVJ?=
 =?utf-8?B?RDFnQXlVNW0yYk5KbURzWTRqY3Q2TGxNTmRDMXZ0bW5CblhhRjVLei9vUkkv?=
 =?utf-8?B?VEt2dWgrVDVGNkNyaW1TMWpKUEh4aXoxblNCTmFiam5RTmJ4Y2R0ZE9GckRI?=
 =?utf-8?B?UEsyOUg1a2poOThYL2ZTYlV0VWZKSjBsUFBFY28xV1NyaFdlR09weHhYYWl2?=
 =?utf-8?B?ejlQdzlWZmZub000MHZGcVgySWlsOWhkR3JJcXZ4Vmkwd050MlZkU2RDV3Ex?=
 =?utf-8?B?RW1RODhEMUExdnhXZ2Q1RkFDSVNBYWpEYzVkcXNVVzZQZGpJdm9YV3BXTkFt?=
 =?utf-8?B?Y2dZN0FJY3g5WHFKbjRrNlBwSlFwMmMzc0JkR0x6V3ZTMG5WMWJmNkY2L0V1?=
 =?utf-8?B?amdCWm50QU5PM09LcWdoV09mdmJDQmo1NWZrVFlqWXk3a1g1czRmQW9yamxi?=
 =?utf-8?B?ZFBXVlkwcktKemFWcFBtRE1OOTlGaCtJYkpZY3MyYVNVQjU4bVBGV3ljcnNR?=
 =?utf-8?B?cVpTYVRIemgrMjZQT2JHTlFHLzdNbWx4MnA5bG52TW5WdENTL0YwZ013RTBJ?=
 =?utf-8?B?STlUcVVWU2hhdGJYUjdqNDNxMVVJTnJzVGFFTjdoaGxzVzNVSFNQSXNBN0ha?=
 =?utf-8?B?UStndURuTTZ5ZGdQeHBnVzhxMFRXZm1JY1FlZ0QvRVN0UGRlNXUwT0FVMnNC?=
 =?utf-8?B?T1lZenVyUFFmTjV6OHBmaFdNTWhDVWwyaVA0dFQ5RFM1c3Y2RjJPbW95aWRD?=
 =?utf-8?B?UXRyOVl1dUpKUFA0bzB0d3ZIdUEwUkdKbitZQmVVTFZBUlBOOWQ2a01pWTFq?=
 =?utf-8?B?bm9ic3Z5RzBzRk1WUU5tMkpGazc2VHF6VGhCeS9iM01VZ2pNdGVqWHptbWlF?=
 =?utf-8?B?SHB0UXRhcEp6cjBwNXNjOUNaNkNFT1UrN3Z3c2hlS2lEQWM4YlhlSVRvV0Zn?=
 =?utf-8?B?alNWcGFZMUdVVkhobmhBWWM1ZldwUjhRNFBTaVVIQXd1cjQrUnpEZWZYc3Zt?=
 =?utf-8?B?VzlETTRoNmg1YVVBTGpqc0g5TkZWUlA0WHlncE5kSEtRT3E2cldPbUoxZ0pV?=
 =?utf-8?B?YjdXYmdDWE1BQXNPMzVvcFBYci9USU5Yd215UExOU1dKeFVsTEZReFBhbVhC?=
 =?utf-8?Q?jjoj7vGvKxNhPHKHhi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mEu9NuZgGkNiNOnu4T2PwKIPHzdNZKGhStAmDtKAtgf2tS4KjfmuQDWwKl98UMpELN11WyvGKQtAz+J3uYyoPeRKZhyCw7O8HblP7FjeCE4b9MpDABeyykWc9Zq/BDMCMZq8s7hBcwWzX/HdCmggR+nolR3ipd+zd1DtqShwxcs8g4iST4TJZl6gv0GYkCH5DmISMRBFMc63tyKxWF8u/4gQ+TUgyC88Tx3LJpnrTpyVDRG7AR9QbUjTOt7cMyy2OR09pVXKVU+EOO+sPE0QdHYdnhUe2M/FgIR7NK42GDkoIDEw/Zz2BzXwIi55IbJM9KEu8bZN0fvcQtsV/+oQ7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fddad7f-59d3-41ab-4944-08dea10e933d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 08:01:50.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGchrOip4a1nXxVeqiN6TpeWoETqqyBe3J28Ft+SWIDDY8wxdwkfMLWK8TgDigkrmoglDPF6mL4+gA/IdilkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7699
X-OriginatorOrg: intel.com

PiBGcm9tOiBUZWRkeSBBc3RpZQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIyLCAyMDI2IDEx
OjU5IFBNDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFhlbiwgZm9yIFBWLUlPTU1VIFsxXSwgd2Ug
aGF2ZSBJT01NVSBzdXBwb3J0IGluIERvbTAsIHdoaWNoIGluDQo+IHBhcnRpY3VsYXIgYWxsb3dz
IHVzaW5nIFZGSU8gYW5kIElPTU1VRkQgZnJvbSBEb20wLg0KPiANCj4gSG93ZXZlciwgaXRzIGlu
dGVyYWN0aW9ucyB3aXRoIFBDSSBQYXNzdGhyb3VnaCBhcmUgdW5jbGVhciwgYW5kIGl0IHdvdWxk
DQoNClZGSU8gbWFuYWdlcyBQQ0kgcGFzc3Rocm91Z2guIHNpbmNlIGl0J3MgYWxyZWFkeSBhbGxv
d2VkIHdoaWNoIHBhcnQgb2YNCmludGVyYWN0aW9uIGlzIHVuY2xlYXI/DQoNCj4gYmUgcHJlZmVy
YWJsZSB0byBsZXQgdGhlIGtlcm5lbCBoYW5kbGUgc29tZSBvZiB0aGlzIGxvZ2ljLiBUaGF0IHdv
dWxkDQo+IGZvciBpbnN0YW5jZSBhdm9pZCBzaXR1YXRpb25zIHdoZXJlIHRvb2xzdGFjayBjYXVz
ZXMgWGVuIGFuZCBMaW51eCB0byBnbw0KPiBvdXQgb2Ygc3luYyBvbiB3aGVyZSBkZXZpY2VzIGJl
bG9uZy4NCg0Kd2hhdCBpcyAnc29tZSBvZiB0aGlzIGxvZ2ljJyBhbmQgd2hhdCBpcyB0aGUgZXhh
Y3Qgb3V0LW9mLXN5bmMgc2NlbmFyaW8/DQoNCj4gDQo+IE9uIFhlbiwgd2UgaGF2ZSBhIGRlZGlj
YXRlZCBoeXBlcmNhbGxzIGZvciBtb3ZpbmcgYSBkZXZpY2UgaW50byBhbm90aGVyDQo+IGd1ZXN0
IChzbyBpdCBubyBsb25nZXIgYmVsb25ncyBpbiBEb20wLCBhdCBmYXIgYXMgRE1BIGlzIGNvbmNl
cm5lZCkuDQo+IA0KPiBCdXQgaXQgbG9va3MgbGlrZSB0aGVyZSBhcmUgbm8gd2F5IHRvIGRlc2Ny
aWJlIHRoYXQgaWRlYSBvZiAiYXR0YWNoIHRoYXQNCj4gZGV2aWNlIHRvIHRoaXMgVk0iIG5vciAi
dGhlIGRldmljZSBpcyBpbiBhIFZNIjsgd2hpY2ggbWFrZXMgdGhhdA0KPiBpbXByYWN0aWNhYmxl
Lg0KPiANCj4gVGhlcmUgbWF5IGJlIHRoaW5ncyB0aGF0IGNvdWxkIGJlIGRvbmUgd2l0aCB0aGUg
dklPTU1VIG9iamVjdHMsIGJ1dA0KPiB0aGVyZSB3b3VsZCBiZSBubyAicGFyZW50IGRvbWFpbiIg
aW4gc3VjaCBjYXNlLCBhcyBzYWlkIGVhcmxpZXIgaXQNCj4gZG9lc24ndCBleGlzdCBpbiB0aGUg
SU9NTVUgc3Vic3lzdGVtLg0KPiANCj4gV2hhdCBpcyBleHBlY3RlZCB0byBiZSBkb25lIGluc3Rl
YWQgPw0KPiANCj4gVGVkZHkNCj4gDQo+IFsxXSBodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRj
aD92PXBMTUdSZ0VKLUVnDQo+IA0KDQpJdCdkIGJlIG11Y2ggZWFzaWVyIHRvIGNvbGxlY3QgY29t
bWVudHMgaWYgeW91IGNhbiBwdXQgcGxhaW4gd29yZHMNCnRvIGV4cGxhaW4gdGhlIHByb2JsZW0g
cmF0aGVyIHRoYW4gZXhwZWN0aW5nIG90aGVyIGZvbGtzIHRvIHdhdGNoDQp0aGUgdmlkZW8gZmly
c3QuLi4NCg==
