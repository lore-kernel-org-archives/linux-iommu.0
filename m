Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57DEAE7
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859636; cv=fail; b=n9Z+7mrPUGv97uJvIjtfCMQLJXQE9UkkS8iX0a6tFJB7R5rm9wkVhdHk1YRGHNFcNRASZdF874cM2wNnaUN7ztI0D36VhDK+2VYkjRmS7TB1Fq/i5VE2zDEmqyWZjKVG5DAZOUO1javRa61u6Xcx1AdwCmFQ35Fd80MUYGCkAsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859636; c=relaxed/simple;
	bh=VVl6/wrAKJesOUI5GF6GhFO/WVfpc4PbTtcePyAR+Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mP2Mf+tPiEGT5Rzr05Ssg807eIVFAxByHqrP5JhDyjaaKwxSjlbqChaqPO+PUzulnedB5vdJwunnrmv10bspmDofoRut8NVN4jXUXm7UVVCTCsXQlDIKoX+zNvb3FCdlvdjrXWkkUW10B2mGrLKPyNy7B3sOwmKDCypqumeZevQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFEjGGMe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFEjGGMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744859633; x=1776395633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VVl6/wrAKJesOUI5GF6GhFO/WVfpc4PbTtcePyAR+Fk=;
  b=ZFEjGGMe/7vhhZQ4UxzB/qbbB0WGppaIJ9mOsmZS20DI9rb541vfrhRx
   /aJwTXxwIK65nFUjl2rEPZZVmNb/3RG9tNs/mtb4fadm2buGdACwUDvvC
   Wx8pJYfl0pIuZYWjSCLPGFRE+NQBygMshYARyi3KEHmhkBkJ+2gjtVXpV
   iQ2+aWAJk40c8kzkAEz72wTqA4oB+Sa6f73etxge4N7mYIJdIYtBZULCe
   9BUxdQyMoe5EO5onpiQKlmyWXbtYEuRbYsvWeJgQrfPmoUJyUnT52dPoX
   1bUyAAXP4tH9G7qqNT5C7HnkRfl4Zjg3hp7ZlG6X8mJKh8eRHGB0g0hxl
   A==;
X-CSE-ConnectionGUID: JZw5YQrpSlKqPudkRJJA+Q==
X-CSE-MsgGUID: xHrzCoZBSMCu9E4FjYfQxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="71818444"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="71818444"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 20:13:52 -0700
X-CSE-ConnectionGUID: RsL3yfsCT5qcJSRPCR1mKg==
X-CSE-MsgGUID: gPiaPcvqRJWpeZNdJqWoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130629240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 20:13:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 20:13:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 20:13:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 20:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcaIsqra0yLyrispdlTTrXMA35iQ24WsWNK2ZxlvH8guSyU6087PIXL4K5LrvLtZh10AOWdhbpXPLUZ003JFFEDYsbkdNEcEqond1ieat/6z8XciUGFIyICVOHtxrRerQQ4CPyLnO2g7Y1P+XGNvjB7RcxyniNs16rmnE8OgmFKzAAQR0kC4vviKb8KWtjXWIBcg2aOhDhtCim0wIU2ySiJO9ASdeUZpuFz5ZCeXT1gcqGtLTHcVEuhpU9aiTIAaix/KB+13qoKVaIGUvEgVFOvGpt6I97ucms4JIx7kKTBAMdL8c191MjW0o1lXvTdh2JItxiEkAdBJhuIh8KaRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVl6/wrAKJesOUI5GF6GhFO/WVfpc4PbTtcePyAR+Fk=;
 b=WOzB3yDwnZbgOFtrErJt5FbtFzMm/uoVMGkm8tELEBNrQZsWNPnE2iby6K0wIU/TBwlOSRUOI6q8kg0P/IF0+q8uFsYOEDwbCVC4kzp9Dp8qEjJlQ35WoqZ1LrvUb8Oiwu/wEckN+VWRb1s92K3NBkXoWIPdYfTw66saUGlI8iTVBEeRr7cwScc5TtJ/b0p18e8vfDJvXUdzrgYCj1GVa3VPTnvyjTki2xkzU69pYZJDY366GxkxhPrw2ACmc28uulw52VgD8MD7hb1vD7TDFKRE/7J1alvz0ipgPGzKUIyC4mSmXnSaYqUalURiO8LrapOW6PJgUWWGnxnZpS2z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 03:13:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 03:13:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
Thread-Topic: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
Thread-Index: AQHbrqIqNscoM1vBpEO04jBH0/T8ZLOnIV8wgAAHMgCAAAdJUA==
Date: Thu, 17 Apr 2025 03:13:43 +0000
Message-ID: <BN9PR11MB527633EBB159880EE64696868CBC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F6889D36DD7238E3BBB28CBC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ee1d26c2-4e14-42f2-8dc0-d57a49490c9e@linux.intel.com>
In-Reply-To: <ee1d26c2-4e14-42f2-8dc0-d57a49490c9e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7556:EE_
x-ms-office365-filtering-correlation-id: adcf0273-d61c-4b6c-b085-08dd7d5ddbf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b1Nxc3NMUzNMZi91aVZwdFNqa1VNUVVyNENkQlhtRUttdmZNSitiODV6ajdC?=
 =?utf-8?B?RmdFbHFmdGh6ek1wb01mdHVNWEZ6NWZ6TzI2OWhuQ1p1RkV4U21OczBCU0hG?=
 =?utf-8?B?ZEJLUXhQbHoxOUp2NlEybkp2bzJQbzFQQnhEUVJ3RVMwVWlqdmJFazJDMUsv?=
 =?utf-8?B?YjJORlZPRTNKN0JjU0dCeUMzK0V5K3pUa3NpTTBwWjdnVTkyTnIvZ3gycFda?=
 =?utf-8?B?TTNCYkRjL0thd2FLZ3hXUWZGc3JFUDBaZE5SRDhja2tCcHRuc0ExbUJtckEv?=
 =?utf-8?B?MkNKdHEvVE5rcWQ3OE9sNlJUNnNQMUpOWVpLSFVFZVhxTCs3Z0dtNUhhTGVj?=
 =?utf-8?B?UzVEWDFEM1dURWxQNTJwbWFCTDloRGM4cVkweUJMQ0pUaDlQaWNYZWZLSzRa?=
 =?utf-8?B?VUliMnZ2TmtjeVJWQ2t4SFNzUldJMGw4dWdXNWpUWHpkRGxkU2thUHNPaVRZ?=
 =?utf-8?B?MUtybDVuRmlhampSTWZhMHlBdjlSeGtERk9GK1dWZmhRblBZc3lueW15N1Z4?=
 =?utf-8?B?WXM1SkhZek41RlhNVENUZmRRT3gxQmpZczRvKzZKVlVTNVMzUUVzeHV2a281?=
 =?utf-8?B?c3hudTI2YXpwWEdobytuK1ZMQlUvajBzNENZT1Z0VEQ4ejl2SUwyY0czTmZu?=
 =?utf-8?B?bnBpalN2OGhuUS9LNnJVOEZCUjgwanVISFJrOVkzWFNzcndMSHEwbWdyZW1F?=
 =?utf-8?B?MVZQdmdLK3dUdlNqcTRtazI4WmFhaHMxWjllNzZhS2tEV2F3bzVtUXEvRlpn?=
 =?utf-8?B?WE5vOFlDUEVVNUQxN1BOUkliVkJxMFI3YS8yUUN1ellpMjlISGRxd3NFY2tW?=
 =?utf-8?B?UFNPSHhtc2xGTXNrMkFTdGkxc2RtWDdGR0VSekVRbGxoZDl5NFg0dXA2dGln?=
 =?utf-8?B?Zkt4UDgrSHVyaUdJK1BmVGdTL2ROK2tiN3R5Y1BETnFkbFhTemZ1NWZaOGw5?=
 =?utf-8?B?OFlqNW0vNWF6M0VWRjdxVklMWmRJRzdaeEYwaGU3WU9YczN5UnNyK01JaUo1?=
 =?utf-8?B?UmZjcnVjSm84bEkrM1c5OXQvWUZSMmFJSEVzSmlBem9IMnNkcmtPTHV4TVZT?=
 =?utf-8?B?THpxVm8xeWhGd2p6T0dUSy9HSnF2L0xyYzVvblNONkU5cW1JRWFYd3ZnT1J6?=
 =?utf-8?B?MzJyOVJDdWNuVHptbWRvaUNHdkFtcDlYNWtaTDhnSUFQRjBJQTN1RnRxVkZW?=
 =?utf-8?B?cHc3OFp5WUVadHEvdURqYi9vRzBENmQrZXlTaTJoK3NSYmQ0UWRGQXFWVW1Q?=
 =?utf-8?B?bEFFeUVEMzRadlUyVUFDMDhKUmlPbnFCQ0IxR2V4dG1mNCtFZmNBcGpscHg4?=
 =?utf-8?B?UHZFVE5BY3poTVhGVUVza210YnN1MlcwTTM5N0thZk5UOE1Qd2NSZm9xdjAy?=
 =?utf-8?B?NWw4UU5RTU83ZHhqN0lOZ3FtdTFyQ2lQVDJqaWxNZ0t5TW1jbFI4ZTFhTm9W?=
 =?utf-8?B?MktmM0RlM0ZmVlRnSFEwanhXalM1U3RLdW91UmVBeGU2NFFqbFRmQ3NJMTEy?=
 =?utf-8?B?UHpUR0xQZURObWlqdFRmR25BdGFqSDZWNE1UYkJ6UzdCMjF4RnVPT1ZkWXlK?=
 =?utf-8?B?dC9tSkZ4cmVxTS81anMzbDBGRCs4TzNyaU1vcmZ2MXNWeVEwZFk5NzhlbjJH?=
 =?utf-8?B?QVBrbk5wYXdwSU5xV2RIMWdYMGZRVGFKQWNlbG9KM1BKYjRyRFlHUmlwOFFE?=
 =?utf-8?B?SFMzVWRySVlNR0lZcEM0UXZ5bUtzd3B1d1ZqdnRMQ25GZlpLTFFxcUdaTkxL?=
 =?utf-8?B?YUdDcEw4K1NPS1dFSWkrQWd1WkRmMUxDTnp6TTcveS83VUZQWEZ0azJ2RXVU?=
 =?utf-8?B?UEpMQjU5OW9wQ1FoYURaNzlCd01qMFZ1eWVWZTBxem52VW1oR2s5N2JTSWk0?=
 =?utf-8?B?VWhtdElrSFkydXpuQ0E5MjBKeVdvd1pxcHJrMXZkSUhJK3VGZTUyeU10Z1Q1?=
 =?utf-8?B?R3B5KzMrdFVHekxjTEMzR1VWSi9vN01NVFRNTitwZlhHVjU1MTh2ZHcrellp?=
 =?utf-8?B?WnZSRjdUVE5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUdIcEl2TUhra0xPYm9iR0xSWUJDbGYxYjZ3S3hrR2I3d2tWbVY4WGFLd1RW?=
 =?utf-8?B?TGVidU9DV3FRd0dIa3VnbGx1R1o2WEpGZ25qOVZ5bzZ2RDFqWld4ZVVzMzVz?=
 =?utf-8?B?WHhNUXdZejBsVjNLcUxma0Jsb3RmZWErWUJveHpkdjhKSHY2Zmh3cEttbmdV?=
 =?utf-8?B?UnMydXJTWlNHMzNJaGRLQUpLakNPQ1BkaGVLR09LQklCOWhoYTNCek5Ubm90?=
 =?utf-8?B?cEx5WTFwNU5oNks2R3pVNlFQeVBTTzM1TWNzd2ppM0MzOXZ5V1pBak9XeGhM?=
 =?utf-8?B?ckpQb0IxU2xyaE83UndVSC9udnNkSWxBZmcyZE9La1puZG5nbVBDN29JQ1JU?=
 =?utf-8?B?KzF6cnFRazlqRjdFeURpMVVaUkFsdGhweDFRMXNEc09YVXl3cUw2WmhldnNi?=
 =?utf-8?B?bG5rbldVaG4ydFJ1OGx6Si9zTmhNZFlmQUJDRng0ancxb2pBMWVBT1ZvRWhx?=
 =?utf-8?B?RkpNdWFqT09sbWVWMzlySzhtRS9oNGNmVk1FVmJzRUxhMTN4YkVvNmdPYll2?=
 =?utf-8?B?eEg1c2wzck9sR0xIY3R5TFlrQjArQVpOSWhKWmExL2RrOGNqMU5sNVhJQmFE?=
 =?utf-8?B?Smk0cW9WTldFdUpIbWN2QldKVUpXcTNFRi9UMnVlT09BUDRyeHZhbHJHZjli?=
 =?utf-8?B?Zk84UEJuQzhIMDVkbjJWaTlEbWFEWFFtS3Z2ckVRUWk5aEE4cms4RTZ4NnU5?=
 =?utf-8?B?Y3RQVTFSQ1dYcWJMRFFST2VnVFZNdUEzQ2RjSzkvZEZqM0lDMUQ1NDF5Zldk?=
 =?utf-8?B?dkVyR05VWWZSQmtJUWJmb2NoRVBmUWNzemJkYlBVTi85dEFpdUk4QW0xUDNC?=
 =?utf-8?B?VSt4SXlhbE5uS0hNR3l3b1lMbGJBM2dhRmhkSzJNZENCRUU2LzRvZm5Ed2NT?=
 =?utf-8?B?RG5IVVRGUTU0L1REK0VIWnVoRnhnMnY5dG9tVXRYNEhBQTh3VW5DOWRZQW9S?=
 =?utf-8?B?a0VRd0JkbEhsWmZxN3hYQllNZjYweW9IVlhmOGhQcUZrQ1R2MjhlSWkyd1Bw?=
 =?utf-8?B?QlhoS0UwbVZxem5PV0JpeDVJdHdqYWIycUdqcFJUNnlXRUxvK1NZYy9pYmgw?=
 =?utf-8?B?RVAvUnFoVzlBSDE1TFg4Ymg3Y2pYeUFwS1QzdWxCeFhZQmNid2VFSG9hRnN4?=
 =?utf-8?B?Mk5JU3FTdWdYUzRta2pGbWFITnZKZVpmL3ZrME9xMDJzZHFpYUZzQVBjSkVP?=
 =?utf-8?B?U1NjSU1SQlF5TUFIcE1oVU5zMitlaWl2NFljZGN5NXd0VXRiQ2xpTE5Bdkcz?=
 =?utf-8?B?TXVSTEtSQzFiam1oZHVjZFd4aXpTOG9wR1YxMFgvMk1EUDRyZHFHd1h3bXJU?=
 =?utf-8?B?ZCtZQ0tkaFZLZmozNytRVnhtenNaUnZRc1JmNkVYSnFMZkEwTFU5MkRyTW90?=
 =?utf-8?B?a1lmWXg4Z0x0dFpVYVNlZWlib0Iyd3B4NC9Udkw4WjdFc3dXcDZXdHpQUHZH?=
 =?utf-8?B?Y2pBSlVuNUk2RTdWNW5jbi80SFI5ZEdoMFZVWnB4SUpoNGNLUUZZUUJqdmps?=
 =?utf-8?B?dnJzZ1IwMnpQRGcxbG13ZDNhQ2IrLzFIN0ZscHJWNHZPSmI0WEJKcjZZZXc2?=
 =?utf-8?B?YUh6TWhUL2puMkNSTnhUQ2FYRktsY215MEpoN0V1eEpWZmoydWd2YWh4c0sr?=
 =?utf-8?B?cXozcHliVm05VUk2ejdnNnRCMWxaSEVqWXYrY2xOSHRvL0hneU9OcnBKamRx?=
 =?utf-8?B?ZUxJSDc0TzlYYzlrYlY3YmRybFFZY3J3K1pZZFRmMUhYSkRyWDlBYko4Qlpi?=
 =?utf-8?B?WXYyZkljNDlzeGlGTkFac05IMUFPTHMyZDI0bXlxYVYrekVjN1Qwc0s2S05C?=
 =?utf-8?B?ZXRDempoejB3T2NoelljaUVHbmpPUitObXdaS0tjTFlsUC9iUjRwckNEelNu?=
 =?utf-8?B?U21Yc0hXMmh2eUpxR1VSU0hZUlpLejJoZGY4VWxwN3RMRHB3WER5YmVkb0ov?=
 =?utf-8?B?SUdzdlpHTHZ1SXlKeGJLcG83N1NzeHhOQlVpTEhmZTB1bnVmVWhXdGJIcnBU?=
 =?utf-8?B?U0RzSVV2QXJpTlRVdEVyMFlpVy9rU2RuaFRRN0FCVS9vKzFIS1F4T2pPdG5a?=
 =?utf-8?B?ZmVLOEVobFNwZFBCaThndnFESE1ldGJ6VDFNTTJZaEl6TnIvRjIwVlBUY1NT?=
 =?utf-8?Q?g2pKMWDF1uIHdrhnkJFd/UZ7E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcf0273-d61c-4b6c-b085-08dd7d5ddbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 03:13:43.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEnPVYRX1nyafAOYa/shtmUFWeKEHj7u0bVdbzeewQ9I7zao7MzL5d86eDi7VsVCbWUINFxAiHD6kPoYLgabhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMTcsIDIwMjUgMTA6NDYgQU0NCj4gDQo+IE9uIDQvMTcvMjUgMTA6MjMsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDM6MzYgUE0NCj4g
Pj4NCj4gPj4gQ29tbWl0IDw1NTE4ZjIzOWFmZjE+ICgiaW9tbXUvdnQtZDogTW92ZSBzY2FsYWJs
ZSBtb2RlIEFUUw0KPiBlbmFibGVtZW50DQo+ID4+IHRvDQo+ID4+IHByb2JlIHBhdGgiKSBjaGFu
Z2VkIHRoZSBQQ0kgQVRTIGVuYWJsZW1lbnQgbG9naWMgdG8gcnVuIGVhcmxpZXIsDQo+ID4+IHNw
ZWNpZmljYWxseSBiZWZvcmUgdGhlIGRlZmF1bHQgZG9tYWluIGF0dGFjaG1lbnQuDQo+ID4+DQo+
ID4+IE9uIHNvbWUgY2xpZW50IHBsYXRmb3JtcywgdGhpcyBjaGFuZ2UgcmVzdWx0ZWQgaW4gYm9v
dCBmYWlsdXJlcywgY2F1c2luZw0KPiA+PiB0aGUga2VybmVsIHRvIHBhbmljIHdpdGggdGhlIGZv
bGxvd2luZyBtZXNzYWdlIGFuZCBjYWxsIHRyYWNlOg0KPiA+Pg0KPiA+PiAgIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBETUFSIGhhcmR3YXJlIGlzIG1hbGZ1bmN0aW9uaW5nDQo+ID4+ICAg
Q1BVOiAwIFVJRDogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDYuMTQuMC1y
YzMrICMxNzUNCj4gPj4gICBDYWxsIFRyYWNlOg0KPiA+PiAgICA8VEFTSz4NCj4gPj4gICAgZHVt
cF9zdGFja19sdmwrMHg2Zi8weGIwDQo+ID4+ICAgIGR1bXBfc3RhY2srMHgxMC8weDE2DQo+ID4+
ICAgIHBhbmljKzB4MTBhLzB4MmI3DQo+ID4+ICAgIGlvbW11X2VuYWJsZV90cmFuc2xhdGlvbi5j
b2xkKzB4Yy8weGMNCj4gPj4gICAgaW50ZWxfaW9tbXVfaW5pdCsweGUzOS8weGVjMA0KPiA+PiAg
ICA/IHRyYWNlX2hhcmRpcnFzX29uKzB4MWUvMHhkMA0KPiA+PiAgICA/IF9fcGZ4X3BjaV9pb21t
dV9pbml0KzB4MTAvMHgxMA0KPiA+PiAgICBwY2lfaW9tbXVfaW5pdCsweGQvMHg0MA0KPiA+PiAg
ICBkb19vbmVfaW5pdGNhbGwrMHg1Yi8weDM5MA0KPiA+PiAgICBrZXJuZWxfaW5pdF9mcmVlYWJs
ZSsweDI2ZC8weDJiMA0KPiA+PiAgICA/IF9fcGZ4X2tlcm5lbF9pbml0KzB4MTAvMHgxMA0KPiA+
PiAgICBrZXJuZWxfaW5pdCsweDE1LzB4MTIwDQo+ID4+ICAgIHJldF9mcm9tX2ZvcmsrMHgzNS8w
eDYwDQo+ID4+ICAgID8gX19wZnhfa2VybmVsX2luaXQrMHgxMC8weDEwDQo+ID4+ICAgIHJldF9m
cm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiA+PiAgIFJJUDogMWYwZjoweDANCj4gPj4gICBDb2Rl
OiBVbmFibGUgdG8gYWNjZXNzIG9wY29kZSBieXRlcyBhdCAweGZmZmZmZmZmZmZmZmZmZDYuDQo+
ID4+ICAgUlNQOiAwMDAwOjAwMDAwMDAwMDAwMDAwMDAgRUZMQUdTOiA4NDFmMGYyZTY2IE9SSUdf
UkFYOg0KPiA+PiAgICAgICAgMWYwZjJlNjYwMDAwMDAwMA0KPiA+PiAgIFJBWDogMDAwMDAwMDAw
MDAwMDAwMCBSQlg6IDFmMGYyZTY2MDAwMDAwMDAgUkNYOg0KPiA+PiAgICAgICAgMmU2NjAwMDAw
MDAwMDA4NA0KPiA+PiAgIFJEWDogMDAwMDAwMDAwMDg0MWYwZiBSU0k6IDAwMDAwMDg0MWYwZjJl
NjYgUkRJOg0KPiA+PiAgICAgICAgMDA4NDFmMGYyZTY2MDAwMA0KPiA+PiAgIFJCUDogMDA4NDFm
MGYyZTY2MDAwMCBSMDg6IDAwODQxZjBmMmU2NjAwMDAgUjA5Og0KPiA+PiAgICAgICAgMDAwMDAw
ODQxZjBmMmU2Ng0KPiA+PiAgIFIxMDogMDAwMDAwMDAwMDg0MWYwZiBSMTE6IDJlNjYwMDAwMDAw
MDAwODQgUjEyOg0KPiA+PiAgICAgICAgMDAwMDAwODQxZjBmMmU2Ng0KPiA+PiAgIFIxMzogMDAw
MDAwMDAwMDg0MWYwZiBSMTQ6IDJlNjYwMDAwMDAwMDAwODQgUjE1Og0KPiA+PiAgICAgICAgMWYw
ZjJlNjYwMDAwMDAwMA0KPiA+PiAgICA8L1RBU0s+DQo+ID4+ICAgLS0tWyBlbmQgS2VybmVsIHBh
bmljIC0gbm90IHN5bmNpbmc6IERNQVIgaGFyZHdhcmUgaXMgbWFsZnVuY3Rpb25pbmcgXS0tLQ0K
PiA+Pg0KPiA+PiBGaXggdGhpcyBieSByZXZlcnRpbmcgdGhlIHRpbWluZyBjaGFuZ2UgZm9yIEFU
UyBlbmFibGVtZW50IGludHJvZHVjZWQgYnkNCj4gPj4gdGhlIG9mZmVuZGluZyBjb21taXQgYW5k
IHJlc3RvcmluZyB0aGUgcHJldmlvdXMgYmVoYXZpb3IuDQo+ID4+DQo+ID4NCj4gPiBpdCdzIHVu
Y2xlYXIgaG93IHRoaXMgdGltaW5nIGlzIHJlbGF0ZWQgdG8gdGhlIGR1bXBlZCBzdGFjay4gSXMg
dGhlcmUNCj4gPiBtb3JlIGRldGFpbCBob3cgdGhleSBhcmUgcmVsYXRlZD8NCj4gPg0KPiANCj4g
SSdtIG5vdCBzdXJlLCBidXQgSSdtIHRyeWluZyB0byBmaW5kIGEgbWFjaGluZSBhbmQgZ2V0IG1v
cmUgaW5mb3JtYXRpb24uDQo+IEFueXdheSwgbGV0J3MgcmV2ZXJ0IHRoZSBjaGFuZ2UgYW5kIHJl
bW92ZSB0aGUgYm9vdCByZWdyZXNzaW9uIGZpcnN0Lg0KPiANCg0KSSdtIGZpbmUgd2l0aCB0aGlz
IGZpeCBmb3IgcmVncmVzc2lvbiBidXQgbGV0J3MgZG8gaW52ZXN0aWdhdGUgbW9yZS4NCg0KUmV2
aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
