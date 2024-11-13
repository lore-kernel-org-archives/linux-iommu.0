Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B86189F47
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485636; cv=fail; b=aj4BopZJsSkiDuKOKbQUKyCWoQdAG/WNV1mFLgxmie8tlqoLgStV3iU7fq0Br7Z4SB+JuKkG318lxTHYtlsUg7cRZle0ZJY1vnO8gq2CgCzffycKgwTdus+UeOBSguuIMbU4gbjF4zr4f5i5hAicmsN/aaL2ziISbIOrvPralso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485636; c=relaxed/simple;
	bh=Wb0T7T//uxCox+00iH7lR0DX4TTPHsJBFLs2RjWkrk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih2Sfz0WYlHmqYBGWJy8nBlA/HscCUd0JyHs/a0o4hI4hPmFK2W43p3KiscTiqerDoGn37CCKzEA4d/BQ+Hv+8On0O/L2bGoVmThf0EbArX+qNm7BhKY1B92bGSsbulEe1t/tqJovroMY6DzeifWex2VWlc991ID8vWDbtWzZd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gegeanRD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gegeanRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731485635; x=1763021635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wb0T7T//uxCox+00iH7lR0DX4TTPHsJBFLs2RjWkrk0=;
  b=gegeanRD/wo+zW7o5VuPL+1oSC977v35uilFyLbvr4Ut5K/I9hzy07AT
   xrm61SGv+dMnVFNNLjflfVskkhopEQ8bGHxzT8qg9K9yxc1HrQfnLKuOS
   1YaRUFUVDfneShqEgJUn6mI1ZrHUGd0SeEPVcWZBSbN5YhPIZkryWQuJx
   oJMXCPLHjC8wiOAE6NoWIyv4VXLOIoUnvELaJoSP0FcBgqD6933NTgmMi
   5K3gOvRWhQapNLHL4pjt1ENxjBPG8xOT1WVL73ax2C5UuJmzAWtFfBNvY
   rZ9cQLMxujJaxknMWG+TQtbBm7h0o+/lVfKyr+u41+gMzGMpsplP3222j
   g==;
X-CSE-ConnectionGUID: Uhec0wvSTEivo5BbFevoTw==
X-CSE-MsgGUID: eS30PhBUS6O2j4Uxv7ejyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18973873"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="18973873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 00:13:46 -0800
X-CSE-ConnectionGUID: a9POUT8fQXKGLcPojbWZYQ==
X-CSE-MsgGUID: p0kyzeFzQRCjSCyDXy5z9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87368612"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 00:12:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 00:12:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 00:12:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 00:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWvoVCzyd9bS06HqbED/D1rXsB3TYj2b2H0t3qo7ObyePa4I0tMPhY5SHKaHx4hL2sXKpSfH93itM0W1XnVtU0A5PI6Sgal16tugLgJt86yIfLJQVJhiteAjqWOSOLxAaXGIOGKnxo6CFELbYOeyZ+aPEndQGW++4lHarqrgWHSCr/zsiIF5jdus0CQmbVLnc0imh63mKploTjfjzfoKyGk3RM6Ilr9HvDPrzvUGOkt9kf+51r5DFvZNdATS4IA7/UBqWVnAtt3hTeuH/+X8p0d1zB89Kd4kni5NhsIzHa44JjkvIAE1fOZsUPCcToEDFygK8Ha6MCrRzBteYqfXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb0T7T//uxCox+00iH7lR0DX4TTPHsJBFLs2RjWkrk0=;
 b=PAeF7vU4Pr68URNq7hO3QotnMNMUCRowbYbC2PDO+O+IC8Wevz7u+s0TBxLJhHJs+daF5OF2Md7hTsredOnQtkkp+rsFpfbPc77VUEyiYHE40TRIB/C2jvspKifxPB5B9fDnF3h/X5JWQ6PHYZhLn7z7K0sNygt18+42mp+lswzKIO5u3kQA0FAPe8PCyS5gbCo9fN827fJ6OoW5vKBlcIaEJDvSUoa47S1BlX9i13g30pax5WLu5gW8SYdKhUKlPAdnV5UyEh5NrtqXmNJ0fLqjzK5Gvk/qPJxuptxdXx9QddZKJKra9cTinG5sO6xk//K9RKxU3G+cp2teYHyJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:12:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 08:12:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: RE: [PATCH V4 2/4] iommufd: Lock all objects
Thread-Topic: [PATCH V4 2/4] iommufd: Lock all objects
Thread-Index: AQHbMV6eMi8CexY/v027wCheiycqOLK04ZBg
Date: Wed, 13 Nov 2024 08:12:24 +0000
Message-ID: <BN9PR11MB52769F0D42E15E55F3306C7A8C5A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
 <1731016017-430373-3-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1731016017-430373-3-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6185:EE_
x-ms-office365-filtering-correlation-id: dba7eb0e-84a1-4026-1771-08dd03bae7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ubhLrSNLyDSYUEZGZX4ODvtiX3PLSacshWP6yJulVTVdN6TR38bTUHuAsDRv?=
 =?us-ascii?Q?xbfZQO7oQz+0fzFRvOU/BuGcd3X7Kk5J06EgNRX25tgqCvWXp9Mjvd9eEi1q?=
 =?us-ascii?Q?vOXdr84d9/E4RABVR5JIVfOU210WP+9rYQZYzG2kxoRBcEcsnceX7KdDQLuw?=
 =?us-ascii?Q?scr2gjFLb9vDNNlk/iMB7ttfpiiyIl62eY4fEe63kiAKmH0i1TVuNTFSD8Vo?=
 =?us-ascii?Q?3VNwCl3LK/Oi2W1NkYSVjCyWuccJf3MXTOZ7oCuxhMeqnP0H7LYe1/trxCvO?=
 =?us-ascii?Q?y5U82u2Ba2MxMnMsiyRPaKDOmQO881IjH+VCBjPHBmSmQWaIWaCgMvU+iyjh?=
 =?us-ascii?Q?7K+fSV+yViiT8vyae/+VTk0n2SkBRvR8tf0qmBwCKyIWAzNzH7C/gRTJzwGW?=
 =?us-ascii?Q?mvU6tvFGG6OFDr4hdv91AAfqLGznQmXRq8wIfoH4NzpMoJ2fhTiMxvR86exw?=
 =?us-ascii?Q?WkLt0l1vyawr+6wmJHeOWutHFg1IJ6LNKlKCdaDI3GQROPJq+V6SM90/Srxx?=
 =?us-ascii?Q?PlHHVLHe3hPbQ4cWpMHfc2Z4ITwLi54K6UXwCFoHQNZcazwwoqN9Vz4AWOgs?=
 =?us-ascii?Q?8FaEZVZOBxrA5K57/NUuuHjj8WpTPscu4w9XxX30q3h1noiVQWtqnMSgbZaX?=
 =?us-ascii?Q?0uVTg/EUD8FOriMWNTvUQVP13LanSLGg+ROvlnYoYoKSF1tGW9BC3au9dT/v?=
 =?us-ascii?Q?fYWaXJEu8Kh2ofDSxY3Aly0C8hPSALnhjoMxGTqXQ0E7gYZ550RBIg+Y3Viw?=
 =?us-ascii?Q?+LDv2CgoWS3OXg/OwJyj6dR0mL9eT9cvaGRRzs5ljtbkCh4pvUjC+hKI447n?=
 =?us-ascii?Q?2vKD/b3pcqKKgpw01EcHmqwXEvKYLWggBhUBuC1G/iWmTdZx3cNi6ZCdlUGg?=
 =?us-ascii?Q?t2Q5/TRkMQfqrxnddT51B8zxUOC0ZCTS7a/R3rfc/D6Z3NTXBAIUV7O+iBH8?=
 =?us-ascii?Q?puxVO5Q7/xGbqMiJarB8fa8EuZCtMC34DDf4G5lIEUh/nUmtD6EuHSZK16au?=
 =?us-ascii?Q?nw3n2tzB19Jz7AAge2l2ewBUZe6Vu458hk22lezRRG0AikHOcgNho+OKiiq/?=
 =?us-ascii?Q?KNeOLOVi+3+r9aFQWXGttBY1IbwSEqJe/fJ20oWYn6IWmXG7WcTzYihIBjG4?=
 =?us-ascii?Q?xMSJJFZLJ88itjlNPIFdQWAh2/7i7Emup+0vePLG648SZb1MRzAU8dpqSkSh?=
 =?us-ascii?Q?eZqOHc99jtLU0JINRTXSAE78zi5WsD7DAHlHkke+IDDPheiITy6u0EXRkjFg?=
 =?us-ascii?Q?KFo88B9R/4kVKS+J16VEUslOcGLdh8tE5HZ8cpJHVX2vhX49SRQm/zteCI7I?=
 =?us-ascii?Q?lIDsTdACYjKheWWC5niy7WEAXUia/SLzkDvJKKO5+zu4QA/GrUJruGi9onCf?=
 =?us-ascii?Q?1gne1OM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2w8q7DzcTUohj/MOgvdBcMZGYO3AETFaGjAPC0IhNG/c6GvLr98cPkpLd3S9?=
 =?us-ascii?Q?RMicZyQmfyJjilU2qTp3/RFETKcI5Sx0Hs6sXIVlRTb9dEjiW+d1zbdrxK4z?=
 =?us-ascii?Q?u6FLh3N30siwuJDGjB+pEpRLJNqEigpVZLxfb4KB2cjU8Lbe3WUUcsn9TLSK?=
 =?us-ascii?Q?70EXvSWAoLWa4vqZRjn2PQ1bwskYbJYAsSLF40AtTGdwK5F/dpFWdoDfDa6s?=
 =?us-ascii?Q?JaXWA8JNU+frHriIibLop5+gHWEeMPrjj+HngRkgE+Uj7JwCCdfrzMNpd3t4?=
 =?us-ascii?Q?Hbe0FV5KpzhSiTFuHk61QH80KmgUGEoFWDFq4+u7g/binoml+8XbWxwJ+JDI?=
 =?us-ascii?Q?AEvKbXEWBwkIac+D7YDeX5CVw21nPM7VQtHxbT92ud7neTQb56OnT2zoiudq?=
 =?us-ascii?Q?8UNPWHs0SaUFQkOFiuohWjCIfD63Fa1YHMZNLns5cc60sOyAWJiQ1qPbReUP?=
 =?us-ascii?Q?yruaQ7j5ADWebubeF1irvRfK85vYg3Ewfd73hwXo9t2mF0jxOkkjfCSMkR8V?=
 =?us-ascii?Q?i/TZ3yzW0vylnNpYPFI7q/5Jda94vD+j3zWhpWYs7YkuarRdmrQb22NCy1CA?=
 =?us-ascii?Q?hXAz/A3RY9GHvnBYBbHTZlvEQAyUhpet5W4bsqvtQgQ9Gp2Y809sB0SGgfS6?=
 =?us-ascii?Q?2PuZjcdwQSqWL26d0Xn3Bk6tOPRLIf0WSabz6MOtmN/GCiLqE8xuglI9g5sD?=
 =?us-ascii?Q?yvsQIxoai9R2LATJVzF3VXJmR6VWIDPY/L986V39D7BRfF6gdmzdI5WmxsNC?=
 =?us-ascii?Q?rrhm5YzzgHDzA7JPq97QGeZd6agW0Iy1XJed43/I6QMmt+Y9D57gdxDwZFqs?=
 =?us-ascii?Q?VFhdx+pWwSIyS771KEfn9ldA5CtVX59uWlfyUv4mgZj4++8sl8SoAmcSDrAB?=
 =?us-ascii?Q?LzDuzEIuzY5zqo2SF1xXuel9RgXCHANjNgEARRuFo4Q3OUgHOBRtjBZiBui2?=
 =?us-ascii?Q?Raq0BAfEVdbz4oMvmFjjViiY7lPQtYh7QpQIyPMRretufRaHSQFxw4yNfvpS?=
 =?us-ascii?Q?v4UDA+eRFzVvW28n1T17GRwPau1kq6FgVNu5S00da6bKQkuBR+2xryZe+Kfv?=
 =?us-ascii?Q?9oWhNMg8rzdHtiWFDT8WhZhH+FZrM4n73dtIL+4HcOHyRPpPOWUyom8lSExc?=
 =?us-ascii?Q?2Du71W5ASeF+XxkOgxCDNhbeMX4VCzIBDqNFga3d0up9ujOlqDLkP0G03+g3?=
 =?us-ascii?Q?aFvcbxIX/xrQQV34NNqf20RnKrjlQ82IaxDOa81SSFmK/rbBU+l+J3BwP5uo?=
 =?us-ascii?Q?M+U5tPVIBKS1gcUKZZ+g7ORTH6yQQjG4XCTH9M9XGDEegjsNNkawN3Ftppl8?=
 =?us-ascii?Q?c3RfdSphb4JUT7Q/wBDSrVvhjYWaG+ZDnXG9iammAeWbaQZINsEmIw8BU70L?=
 =?us-ascii?Q?01tC2uNAFVtxuNp6sI2bXMdwt+NX9TodrzCmYaA8ve807BtuPYdypADko/Bn?=
 =?us-ascii?Q?HE9deaGL3ZOdgxs0d5fpOZOTIlbWMV4+rYWv8fgPJc3TfQk1TQSaYSvYR1fh?=
 =?us-ascii?Q?JWBVj9Cd7dpDlylEUPGlXRlt0cZoo7s9MlwUWlzuGu40W4xa+Jev/Rzh/kCf?=
 =?us-ascii?Q?Oru0Xeepdrospcv+4BOiqzhCQ0xwMu+oP3KbBA7+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba7eb0e-84a1-4026-1771-08dd03bae7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:12:24.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5qvnbKw09MwoJj96Wy+zpACBUG9gLkiiwqA2MVaNRKLfJiOUYtjS/3MTk9EH1XDBZ2CDBIEoAjLiWX2guu3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Friday, November 8, 2024 5:47 AM
>=20
> Define helpers to lock and unlock all iommufd_ctx objects.
> This will allow DMA mappings to be updated atomically during live update.
> This code is substantially the same as an initial version provided by
> Jason, plus fixes.

the subject and above words talk about 'all iommufd_ctx objects'
but this patch actually tries to lock 'all IOAS objects'

>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
