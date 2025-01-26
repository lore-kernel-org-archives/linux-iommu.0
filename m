Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F171362
	for <iommu@lists.linux.dev>; Sun, 26 Jan 2025 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737868254; cv=fail; b=DM8nmI1BmH6t1XQVWqSsdjxcGpEGhmqiZJEknr9YsAgXuEI5qa2OhvMl/xPQ+w29JHbzWEGvxonNTvfcN5hw1x9lOO9mIu79Don8nB/AKcmzvMYCAO/Al1lMDIN9U07S2mZcEXuoWQtryTFpU0jAeLe1Bc2T8r97ze7hIHJqhgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737868254; c=relaxed/simple;
	bh=2pGesDSJR9MVbpM9S0Pyu/5g50pTBAjObOxX6oz50rs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ilwY+IzvB44IXrvXQb1HiYExK24hG8yCyT4uw4TuxqNZMHgTIxa731WaW0A1/Y0cmm7jMF75YbB9HbVrEb8AIrBxrHajKn62VcrVNoa/9HkbTIylVD+1X/Rhgr74Lx8EyrqBXURbyMDyqOiSn8S934FudKqloN0TK9maq+uViXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PMKNxuam; arc=fail smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PMKNxuam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1466; q=dns/txt; s=iport;
  t=1737868252; x=1739077852;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=M8bfGcqWscNFJoW1gBGGNnctJLlGzDy0qXIEmctg//I=;
  b=PMKNxuampLN5LZtScrTl1MrlTLr1LVmSCQr2ddmcKltkvKYUsv4N09Uk
   ebQFiJ4G0WIoNEVwHwjCReR+rXZ/kuriqFgL1BbQogc0WM4/gmXF0DXLW
   QJRyBmtyMxIZ58x5weethqyUQx+bmaLDMz8rrKRLtlgebOxySrtZIH7q9
   I=;
X-CSE-ConnectionGUID: ynVFCCj0RZ2QKq5bDp4Qjg==
X-CSE-MsgGUID: qcS3VWPpT5miBiZyVYtbTQ==
X-IPAS-Result: =?us-ascii?q?A0BuAQBMw5Vnj4r/Ja1agQklgS6BclKCGUiIIQOFLYZTg?=
 =?us-ascii?q?iEDnhiBJQNWDwEBAQ0CRAQBAYUHAop0AiY0CQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BUmGCIZaAQMDEihRAQgRAwECHgFBH?=
 =?us-ascii?q?QkBBAESCBqCYIJlAwGqHgGBQAKKK3iBNIEB4CCBSIMOgXODTQGGBoRcJxuBS?=
 =?us-ascii?q?USBV4IwOD6ERYQTgi8Egi9LejCDP6BaUnscA1ksAVUTFwsHBSt+EDgDIAs2F?=
 =?us-ascii?q?RwCFA0QDwYQBG0FNUE6gg1pSTcCDQI1gh4kWIIrgiGCPYRFhFOCQ1SCRIIUe?=
 =?us-ascii?q?msDAxYRgyd7HoFNHUADC209NwYOGwUEgTUFnDA8hAEBWQE0RWfIBwqEG6F8F?=
 =?us-ascii?q?6pTmHwiqGECBAIEBQIPAQEGgWc6gVtwFYMiUhkPji0NCcsReDwCBwsBAQMJk?=
 =?us-ascii?q?WMBAQ?=
IronPort-PHdr: A9a23:Ui+w7hPMh2HEBEONNiYl6nc2WUAX0o4cdiYc7p4hzrVWfbvmpNLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:44MeBKxCYCvyjhuDMGV6t+c3xirEfRIJ4+MujC+fZmUNrF6WrkVWn
 WZKC2uAb/zZZmL8eIwjPomwoEIEvJLRn4BhQAtsqVhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IiaT/H3Ygf/hmYtaD9MsMpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJFAwA6Mz0eQvO1MUz
 N8BdTohdky6he3jldpXSsE07igiBNPgMIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bM3WjOX9PYH46tO6tj2PzeidVgFmUvqEwpWPUyWSd1ZCxaoKFJIfVG5U9ckCwv
 2n9pFrGOgkmadme4zu340ydmuXzpHauMG4VPOblrqEx2gL7KnYoIBwRUF6mif24kVKlHdZeL
 VEEvCYjs8APGFeDVNLxWVi85XWDpBNZA4MWGOwh4wbLwa3Ri+qEOoQaZi9HVvINn81ufw5w7
 3yQwtnFHWBWsrLAHBpx6YyohT+1PCEUK0oLaikFURYJ7rHfTGcb0EunojFLTvXdszHlJQwc1
 Qxmu8TXulnysSLp//jmlbwkq2vwznQscuLTzl6INo5CxlgpDLNJn6TytTDmAQ9ode51tGWps
 nkegNS55+sTF5yLnyHlaLxSR+75vafVb22N2AEH83wdG9KFpiPLkWd4vWAWGauVGp9aEdMUS
 BaJ4FoPuM870IWCN/4pM9PZ5zsWIVjITom9CauOMbKik7B6dRSM+2l1dFWM0mX22EkqmudXB
 HtoWZjEMJruMow+lGDeb75EidcDn3lurUuNHsqT50r8jtKjiIu9Fext3K2mMrthtPvsTcS82
 4o3CvZmPD0GAL2mO3mNr9RLRb3IRFBiba3LRwVsXrfrCiJtGXoqDLnaxrZJRmCvt/49ejvgl
 p1lZnJl9Q==
IronPort-HdrOrdr: A9a23:JPd2aqgwT4n4nRBP0JvFaWr5IXBQX4Z23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7SdS9qBPnmaKdkrNhQYtKOzOW8ldATbsSprcKrAeQYBEWmtQtsZ
 uIEJIOReEYb2IK9/oSiTPQe71Psbv3lZxA7t2uqUuFODsaE52ImD0JczpzfHcGIzVuNN4SLr
 bZzMxBoDarZHQQaeqGJlRtZYL+juyOvqjLJTodCTAayCTmt16VAbjBfCSw71M7aXdi0L0i+W
 /Kn0jS/aO4qcy2zRfayiv684lWsMGJ8KoNOOW8zuwubhn8gAehY4psH5eYuioune2p4FE21P
 HRvhYbOdhp4X+5RBD6nfKt4Xig7N8d0Q6g9baquwqgnSU/fkN+NyN1v/MYTvIe0TtlgDgz6t
 MN44vTjespMfqJplWC2zGPbWAnqqJxykBSyNL6SBdkIM0jQa4UoooF8ExPFpAcWCr89YA8Ce
 FrSNrR/fBMbDqhHgbkV0RUsaiRt04Ib2C7a1lHvtbQ3yldnXh/wUddzMsDnm0Y/JZ4T5Vf/e
 zLPqlhibkLF6YtHOpALfZERdHyBn3GQBrKPm7XKVP7FLsfM3aIr5Ls+r066OyjZZRNxpovn5
 bKVk9eqAcJCgvTINzL2IcO/gHGQW27UziowsZC54Jhsrm5X7bvOT3rciFaryJhmYRsPiT2YY
 fBBHsNOY6TEYLHI/c44zHD
X-Talos-CUID: 9a23:2GXXD2F7/fZHgxLTqmJ28nA6MesnKkfvlk7zOhKyJX41cb+aHAo=
X-Talos-MUID: 9a23:rgFSUQrNHxonmt9dkmwezyhpD5xW3Jy2NB0IkL8Hidi6BDB6Bw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Jan 2025 05:09:21 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 2FF0E18000295
	for <iommu@lists.linux.dev>; Sun, 26 Jan 2025 05:09:21 +0000 (GMT)
X-CSE-ConnectionGUID: aoug/27mTqOQxV6ItgAVCg==
X-CSE-MsgGUID: 9GYmslMGRVGpJYPzNwWINw==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,235,1732579200"; 
   d="scan'208";a="21089495"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Jan 2025 05:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dw4t+MhvS09rlG5ji8eLZVvN/Pu3mwfqFGRixoX33hVisYm6ELiAJrFB0VVCmP9MSCd6uU5/XT1i++TMA0Xk1j3hsWlvpy/jqz3Ei/kMZPrGO32To0LLC+1GTexU+jue4CIrMbNA2Hlt928/7HTpOkLN+aJaD9gq3XXVIhe3lIxW7/5B4CrDXimbOMFKoay/+E6crOiX/SIsHD1WpTwcGG6m9yhLm0q4mCFVIe+XrNrsNUwnA3bxYgjyOUNn0HrFT8/IESx7Ao+bb4uimgVQr1lJEFjRq42kPczkzO9gSKjyu7UdjmtHIjaRNKh0HND+qX+juNgMncYr8LiNtXAy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8bfGcqWscNFJoW1gBGGNnctJLlGzDy0qXIEmctg//I=;
 b=vCUXJYy4zpiubbQxygfpjZj1BOKKDu7Plfnc8EsApOz6+yHfGxU9x8qP3NlgBwJALpTpYthU1fj1/7LWYAOngDhNevvawQLVb90TUHaPnbQApNAb35h8F/af3zxCpIxr8HZqDAe6BSo66YTYsQ/DelQiRsv5MWsghuFDjGi0OK7maijkaZTEbyQ+krTnpC9vexm1QLiTN3aG1HzwVqYhtPNRzsrhLyqJuR06P88Cg82cOxogTVBPuuBeNZ7prFzh5dWtfQhC67est7xpoIm/xPh2/7oG81btveiKng2ec+03pzE08GXzzLkPFu24IfOstJXAkxF5RVIOLN4liadhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 05:09:19 +0000
Received: from SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ce10:662e:d436:61fc]) by SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ce10:662e:d436:61fc%6]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 05:09:17 +0000
From: "Adrian Mardare (amardare)" <amardare@cisco.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Make intel iommu disable swiotlb
Thread-Topic: RE: Make intel iommu disable swiotlb
Thread-Index: AdtvsD0ftWLNWRWAS6GH2Kfd6X3gwA==
Date: Sun, 26 Jan 2025 05:09:17 +0000
Message-ID:
 <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6687:EE_|LV8PR11MB8557:EE_
x-ms-office365-filtering-correlation-id: 6836eb7c-2e74-47d9-7ec5-08dd3dc795d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hjKJzhA17PEpkbLMhiVX5+R9xzwWKw65x76xEdq8pMc/Du9+jMOP3tXVKAbO?=
 =?us-ascii?Q?SSZkIm7zKOk5f6vYEUKT+aKHUczXQDsiLfZAL684o1GEy0FL1TNIgBMQAloH?=
 =?us-ascii?Q?s/+yr4BRcMEHFoyt7IHDRg0wY5HrVlTl0CtaKU9C+VFhbhyz3de0Dp5CT3jC?=
 =?us-ascii?Q?rSFnE5i5O0CF3nPkZQLKq6emGMoWB/3kHekds0OYR/WqnT5KHqV+oyAu6sTT?=
 =?us-ascii?Q?yLI3E1doi4TvRUIMNITFIpk5eAstcW4W7ewy4RMQbI2mqVLCVPxTUvrlTrS7?=
 =?us-ascii?Q?NTTN7DhuYEh+R8+c3MNdamL8ecbUPBoxbYze1CUVNIgC3irdrSrJm63rvL/9?=
 =?us-ascii?Q?AE0PbNdXh18GukVTXozbhkMeaw92RYmNXDdUkmredJm1KKn9Ml24fiVY7k6P?=
 =?us-ascii?Q?TrXOJzrASEzfXcIEi35ldadhXLybEKGu5pXH8ga7Gcn4F4MHTVTQ3J8rPzYF?=
 =?us-ascii?Q?33K3zPD6gDWpWgic+Hory6f2tG3/6K943guS5qFvc3bvoJPMGKGD6FY7dani?=
 =?us-ascii?Q?LyyF1Eo3ZkgbMRpImwyzxg5JoLnxRuVPniIhO8aqZ/TwrC/H88zPPWHhvZUU?=
 =?us-ascii?Q?RJH+CwWcBft/AmudvVuP4/vkACYTTTDdnvr8UVkZ29eodA3rzF2u6OOcK7/j?=
 =?us-ascii?Q?SPck58YoRJ1U+fuF0ZFbhmNXTbTSYl9avAumIZ+KITmqYyUZPO4XSWD6LDcz?=
 =?us-ascii?Q?o/aMTsqDM8xx4jqw3lcOz1aelKatrX/vXiJlWmQnrUNQoIE3FakKS50bXKUt?=
 =?us-ascii?Q?SX4rUovC/DdU30gxLmg0Jz342PX+f/3jsCSLrdVjfFwM7fHhh2ZuzfF2Lohi?=
 =?us-ascii?Q?hMp/vdiine4TPXZaLTqo8HNzdZksDts9vVBvkhyXbeNokLhkOsQ+3jBYbkH/?=
 =?us-ascii?Q?iAan7pAiiQYUJg0Dw5uuaRVq41pmpU4DNQvap72TRnI5/DQSG8rlYOcW9NZh?=
 =?us-ascii?Q?6CkQkqesvITgVrclgKYP/vMSGBpMWixVJcNKMIYdu7KZZ4e5+vTVOzdCvFtE?=
 =?us-ascii?Q?WMtdysleHAhNbFil2YHyVW38El1+jYp/eDCBKPLdg+pD3Dq+c0uWG7hKMKLO?=
 =?us-ascii?Q?vAZKskU7KZNuIb78hlRPt8+jdNmrLfFtrFcJYyZVBRodm75BmQSnWeI/7w3X?=
 =?us-ascii?Q?zz4zZm0xXogqMP40a1Y+jM39UeQWKj4mzKBX/hb9Fyl4bRLc14j/GHADugRL?=
 =?us-ascii?Q?CT/TMJcZbMyj4AK95c2JUEFg/53ZTOXQuHZJJsC8K4FU8e+EPd0ZjPWMgCNf?=
 =?us-ascii?Q?Vn9leioxGYnLTyItSUpZo9wa6OV+mZorPaRee9hpG9u94v4LKmsktaH3e8zY?=
 =?us-ascii?Q?rdwdLBh1LOmX6StAyCbBQSO/D0L4y7fv9vDdnSYXgTiTQljLdBwPBXkp+ERm?=
 =?us-ascii?Q?hNCzj81tr3SWGnc+H21I8l03RkTOfh65luRUpkuhJy3dAsu7Xr5QBdH2FRqt?=
 =?us-ascii?Q?wPotYDdd4wEDUVYi3XIg8MfpM7i37s0A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BpkQslIjflBGriFkmypCGVg6UhU6LzjOuDJ20qXSYdYXJi8Qx3Px2R8tXH+2?=
 =?us-ascii?Q?Nf325gEMeM2rhJTRvACgEMGvbdaOqjBqw7hPGjQa51ksT2SIhU7ixjLMGMQQ?=
 =?us-ascii?Q?gdQszhwyskRY5gMtVGawt0nIOlORUXkQ/UCla/kgplS8IkmYd48/nfHbM6ma?=
 =?us-ascii?Q?bLr4m9YrDxcefxz4b9pAyFQA34edd59NRHM6cKHruTKZAy6C2tc7kNL74bgC?=
 =?us-ascii?Q?ZzQOi9pJadFlBbLrtTozD+uXkmzSMeqZNwoE+PoaY5zWUe2eN8IJr9XTroS0?=
 =?us-ascii?Q?eulbiU4w6mnbT91j7vdaeeNinoWuEZlffmuObZOk/7lMtz0uCu52HBeG3Ga+?=
 =?us-ascii?Q?Uycsrj2RkZazex0KcIh+BNuwFmg3FnjKjypxt/M7U9siFNecD0Aj/9JUdm4E?=
 =?us-ascii?Q?1QrQHVFBi5sDCVU48HykYInArr1kG+ey25g3K3y0G1qhZ+wybLdkHXFNEp4x?=
 =?us-ascii?Q?lFzJx4wdjOTibBFkEXc1xhtdeLaPNuBmlrhYF4iaMhyizTTGVZcP+SJJ9S/9?=
 =?us-ascii?Q?YDLtoWzNj+LdFLg9mwn9waV/5T+GfP2O2MTERIu+MpgIUHVx79bPe6tm94uT?=
 =?us-ascii?Q?nJlM48+uOW+I0w+76oIF0xIGZmAoOn9OKzpsJcH4XjrDO6f0vOyTdS9tSPcL?=
 =?us-ascii?Q?r6UmYBJyq6UNuaQmM6ArmFhosf2+wE8rINRGiSZWbeVLW4+qtY13rHxJYw8T?=
 =?us-ascii?Q?CfuFvBnNd3gxmNHBCOI3RsKZ+QjqDsEqvVhavom/GAh0rxbSTOLvi+7MzVy+?=
 =?us-ascii?Q?WzBmk3PT2aCUu/TNv/QGnvInuTTx4HxRFOBl3CZVH2TUGOovpmDISzWvmVjj?=
 =?us-ascii?Q?yEsmrFOMHSc7EoyT+IOYaTU8mOu0sI5963eFOlFd7werbnyCBeiLTEphRSPg?=
 =?us-ascii?Q?TbsUB1kd/1wZCE1Diy62+s7bgmrH4Cd5O3Oc7a09xR1uS73Fh6Tf5Z6i6sL9?=
 =?us-ascii?Q?3sA0WVyRFyBo2Utq7sRJ49ERjjA07IPcLhufodfnSg7syhNGpz30U091rfBz?=
 =?us-ascii?Q?+7JlFdW95rODutGor0K2ZD0GAlFnOIRGYaBRPIr29fx58gNLi9Nc7vNqtoRx?=
 =?us-ascii?Q?tnjzTjqFn2s7jzvIZKViL78Eip0ifBGvDsFhbPkeL+uz92BtXjboDMM8xVA8?=
 =?us-ascii?Q?vhdJKIdsl4t0GSJVvrAuW2Dha4MYgj/rspa7Mn8SZU86SJNClpAO/WfdykzW?=
 =?us-ascii?Q?c0bWq4jplHXpc7UucjuQlM4vXhRyaRsS9gpBuCOxwvaRurfkCzohFZx+uv3+?=
 =?us-ascii?Q?ar33aprhnG0LrmVKQpujnHQn7fveWEoByPwhlFx0xqfy4XWRTicihQYB/YC5?=
 =?us-ascii?Q?CV/RV03oknzrCgfrrnM31gHT2d09723VBJlF+S0NEDz5n5vUAb2PkSOvj9EP?=
 =?us-ascii?Q?GoxQVbbrGSOAYl3WrsUgMeE/TVHzDjg0OydD4oFFutdFKHGC7/39ZtjMDpjg?=
 =?us-ascii?Q?8LI+PBmvkD8fvKoOMJZwkbmOZiIPGCTq1vFYRscdK4s1RK2CmELiVLz2zOTa?=
 =?us-ascii?Q?fscmNU1VRZpKG61+g/NKJN7AW9xz8alcStulQhrGvBrlI1muZ3ycifjMvPzj?=
 =?us-ascii?Q?3SO8LoF8ZuOQ/z6/N2R98YOkLzzpOXOFFzRqQ4pQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836eb7c-2e74-47d9-7ec5-08dd3dc795d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2025 05:09:17.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQsJIxby5+yk7rMCgj4sj9VySb+ZgJkDNSnms2rtW1Zfil8TeBEFuv3Jk+Rd9rYnTKB0zUcbwQACy1ozmtac4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

(resending as plain-text)
Hi...
I'd like to submit the below patch.
While investigating a difference in memory consumption between the kernel i=
n 5.4.x and in 6.6.x,
I noticed there is around ~80M less reported in MemTotal in 6.6.x versus 5.=
4.x.
This is because  in 6.6.x  the swiotlb is still enabled and consuming about=
 80M of kernel memory, even though
the intel iommu has been fully initialized.
This change will cause the swiotlb to be disabled /  memory to be released =
( via swiotlb_exit ).
Thanks,
Adrian


From 27e63e727f23189e9c98d81fb445141f998c0808 Mon Sep 17 00:00:00 2001
From: Adrian Mardare <amardare@cisco.com>
Date: Sat, 25 Jan 2025 23:41:31 -0500
Subject: [PATCH] Make intel iommu disable swiotlb

On boards where intel iommu has been successfully
initialized, we need to disable the swiotlb as there
is no reason for swiotlb to be active past that.

Signed-off-by: Adrian Mardare <amardare@cisco.com>
---
drivers/iommu/intel/iommu.c | 3 +++
1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..971023d33a70 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3166,6 +3166,9 @@ int __init intel_iommu_init(void)
               pr_info("Intel(R) Virtualization Technology for Directed I/O=
\n");

                intel_iommu_enabled =3D 1;
+#ifdef CONFIG_SWIOTLB
+             x86_swiotlb_enable =3D false;
+#endif

                return 0;

--=20
2.34.1
