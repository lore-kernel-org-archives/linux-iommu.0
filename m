Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0D26E6E8
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768610; cv=fail; b=aExQZl0jqZjddNydoWACGAS+ynJj8QVWrOHudyOsoziq57RbIziLvUfePKKgLmIpCrUVcfb/jis9UJN/YSVu5wheUwxbizsjFWXQONJRmRwU5qTb7Gc6WuxJi7J7yGK7RZ1zHz4z+WrVkkjR/7qoCvXCTkNI/mcRAjp4zSQU9hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768610; c=relaxed/simple;
	bh=CZ7GMFibJUeAeHLmtYyGzoCvDPx0oL8qRne9/1J92rI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1lFMtt38g86cE8Kec6RtqtLrsEBu43P6APPY8ZqNrp7EPeAG5w7TQTsW0qNBWOgNuWOkSzfwu0aJUfdlMn+D/5+yY+VBzfygY2vbKCYBLtI4uhvY+PRjfZqAcYnwnCvDZOWdj0uB5z84mG7kWGRa6Y+OY/Lf1L45nQVbYZkVxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VIsggUXa; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIsggUXa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRlshBAXVVl0NtCMIk2VaZXdbB66Vv2M6zA3FhiPbHgW0QiXaMBiy/uOtULfGswz2SSccLx6oTagDIv0CAXH5CUH+DxfiD+taslUsHVSBz+YFVOXdB0wNHqeTH7GPucj9asnKFG3LMxaNgaNLYjSn1XPctYgVfiOCt6zhUcYUR+1jJi2Prvwh2fadOlyutSwH4KUkB3oiZ+8xDSX6Ph3nTFN5vMedrzAb58jjn96INE3lqvBW/8kn0qAIOze3BGGq0occbeUBIAve9/DfI4kCfpNEApV/ojwMYtTIINzGEc6vEKMtz0BgIt3I7825q7r02DVFUF2G66HoOsSZYyorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyqtuc0HjUDKq7uTSSSZpIfPB8iHrL4aVpIF+Lzyq5I=;
 b=KiHAdUU4AtrmrTDpMz270I8TPF7t0oC0hSCXC/5vHeexOhDMvij1vXIoGWizdk2K7NomCuZdw/nP002pYNUcxXGTX83JN7Fw0C8JRq6I1A8IFD4F+JUUDJ95/nwdBc59sGK+VsbEI3LAz+OWRf3AG80RJq1tFCqu5CsQcrD8rp20pBnErwxV3oJwfuO4rtMW5GhxkVY8F44LP1pu2noNl4lwuEwOq5S9EV7wd6so/B0F8LgN+x/6XU7pzsyz3QIjkazkD9fkgbCM9AFSVdBQNwyyiAPbpEhQr2WYE69iXCvG9MzSBFXQ69LQjWA0Qx6makSfz8soGGKkXelG3wPShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyqtuc0HjUDKq7uTSSSZpIfPB8iHrL4aVpIF+Lzyq5I=;
 b=VIsggUXa+GQvv4HpK8Ho7VuuDLh2H3dliKGlve86xVh/0nAmvJlniAawkE7ZoUZHhzAHbGB2wgEtU2pLDoAsbM5PfSXcwBceR6z5fdpD+VqJlD58v1pj2P8jJKzTtRLQFbQwH8PWyegI8TL0jsoEI81iLsrI1ZtCHimtXXq0ESYFwJ+yImtlPDBaXv8klzALNBUzlxgGCZWbP01ov4yfsUmEUlaNd3OLNRr57+irQV71WDAVwmxX8yQgEisJ2sFnm7H3pp5bwd5Dx8X7jIpDWwm7ujSBNwsYg5sAH/zfx0pyGPORk7egOKZ+hL97lZJnsge18cznHx+TiizTW0JfUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 06:50:05 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 06:50:05 +0000
Message-ID: <9c13e838-6fe5-433c-b361-7d19d1b2ce1e@nvidia.com>
Date: Wed, 7 Jan 2026 12:19:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
From: Ashish Mhetre <amhetre@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-4-amhetre@nvidia.com>
 <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
 <38364cfe-8fc9-4ed7-9034-4e67584ee965@nvidia.com>
Content-Language: en-US
In-Reply-To: <38364cfe-8fc9-4ed7-9034-4e67584ee965@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::9) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 567fadaa-92dd-4870-46ef-08de4db8fd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtieHF4VVpUV1NpNUFHL1RiMFUreDVYbkJ6OFlFcXFwMGJxMmhmaHJ3V0JP?=
 =?utf-8?B?SHNjV0lNL3BnZWRMbjVFa0tsUUJhMWpEaldPTFA4WWdPR3lJemMzWFZlTWxW?=
 =?utf-8?B?czdrQ1JaMlBTekIyUnVZWGhMVW9NZFM5L29XTUtFYmZpTi9EYnFCcEVqamx1?=
 =?utf-8?B?K1dDZnBpa0FJeENmYm83eitqbXJpQWRleG9oVUNNaDU0eUdsN2ppUFZTRCti?=
 =?utf-8?B?ajZWUUlOcjQ0ZVZENVNEbVUvY2N1cnd4UUhtNWNXQTJ3ZGMyaG9KVVBWT21j?=
 =?utf-8?B?MGthR2cxcUdNSXl5bE9qL2wzMHdsd1NyTVJkUGxDRVVuTnhMT1F2YnR4Ynhl?=
 =?utf-8?B?bTN0U3ErUWUzV2JxRDE5QVBYOGZVelJhTlhqRkhZOWZoUWtHYnlwL291TVIx?=
 =?utf-8?B?Q0lkRGxVT0pyL2FOaUdndGZyMUN1QmhWTFRTWXdnMVRsYTlwZjZSOGh5M0RX?=
 =?utf-8?B?bnlBbUM2dXFyM3FhZ3FxZy9zd1VDWk9lRVhWdkNSSmJXWUxzZTNaVy9rd29y?=
 =?utf-8?B?WnBRNmdWaUFnQ2xFWkJBS1BOV0QyUDdObWduQS9Cemk4MjBWeHZJdDE0UUdn?=
 =?utf-8?B?OHFtZ2xNb2tSS0ZPa1JRYndQQzBNWmdkOG9peTExMDNXelBDRWdTY0M1Zndr?=
 =?utf-8?B?OXFHQXhLUzlRck01WFg1aWNEZ0N5QUwxRFNyV3FiUmJ1WGlGUVloMmxpczhv?=
 =?utf-8?B?VDcwTlBJUUxsVWVha1hXZm1UOStUNE9DSFNtNEl4R0dZUGFOTnhMU2V1ZG8x?=
 =?utf-8?B?SENUUkJCdG4wODFVNEhhM1FQek1QcnhsNVVnc1pzMFhLVm9KNExDNmhkOGNo?=
 =?utf-8?B?d3RYZ0V2RlJXTFBoQm1kdHJWYVF4eVFsY2ZyeGtZWUJCNkpsbXdLV2wrRDNP?=
 =?utf-8?B?SGxBNDEzNTNjblZPYmhiTXlKejZxSFlFUEt2Skw2WEtVdkNHYmRKbG5JVU5Q?=
 =?utf-8?B?TzAxa3laZGRvcnhlSm9ITEVWaXBPWEhDRTFxK25VMDhZaWlWbm9IeUdjUERx?=
 =?utf-8?B?dFFnaFEvNWNWdk1UVldlOFFMeHo0cGllOVp1VE9Ja010THdYSEhsOU4wS3JV?=
 =?utf-8?B?d1l4LzM5UFA1akt6RC9ZT1JoTGIvSU05UDRVaVVKQzdvNnNaRkZtdjBxYm5y?=
 =?utf-8?B?dWVtRTczcTRyVFBsbEFmcEV6Z3N4bk1OQi9OVytWTWczYlF2TTBjWnZmRWhl?=
 =?utf-8?B?cUVjK2MyU21qMzNBTlV2UEcxc0NxWWVUdWkxVDY4RUF1RVNGY2FCWi9lRmlH?=
 =?utf-8?B?eDF2ZUZuMnFHclM1K0U2SFZIWlRWY3VpOVFjVWRtQXMxUDRQdklpOEFXMUU1?=
 =?utf-8?B?eVVabVVrZFpTVlZTWkl0MnNNamIrR2JYRkQ0YUxua1ptcjMxUVRPdUttRUth?=
 =?utf-8?B?Wi9YaENlRGJzaXkvRzFQWUdqOWxnUlZLSS9IMGRBbG0zd0RHMlZHWlpXNnQ5?=
 =?utf-8?B?THJpVVFoTkFQeGdTZHlhUXk4VFZjVVNyU0F5Rm8wWElncVlSajVqYytMaFVs?=
 =?utf-8?B?RU5IWUNMQ3ozWmM5ZXhVMUE5OEllV3VtRVM3OEdWMmhtV0hnZUVodURGYWtM?=
 =?utf-8?B?OGpQU21XZVZtN3hyRHVzenFLK3VWd2twUGVKSS91OEE3bnlJQ05CLzk3WDVW?=
 =?utf-8?B?dWZwd0hUT3NkY3k1OGt1OG1Db2NJK2w2QkM4TUczZjdsNjVwUFFQTmo4S2NK?=
 =?utf-8?B?blBNK1lWLzcvU05PSU5MVXp1V24xS0V1bFZhRm43OW5XMkMrSk5aVVJkK3ZF?=
 =?utf-8?B?VlI5SzZXaVdjQkZpZ3BHTy92Sm1MV1dvMkNlRkRMblJnQW42UHg2K3YwL3Vx?=
 =?utf-8?B?bzJiRGdhT1Z2L3Q0QitieUsrUXNpNkwzc2NnQnBsN3pyakd2SnlJTXZuMWtG?=
 =?utf-8?B?dU96MWlEbjlKV1ZlSlVxQ1NmcEtUMTJIcGJZRWNJeW82eFVEWmozT0tXRGx5?=
 =?utf-8?Q?4PvDg8nnX2rntonow22NHM4/johiRY7N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDEzWGEvaEg2akQ5elBuVTZwNXE1WFZJOHA1VFJYRG9HeUpHa3E5NVBGaEwr?=
 =?utf-8?B?NTRFTG5LbGRHd2tVOUdpdFVheDduc2grZzlNdGpJbTczdkRwYk52N2RrZE1J?=
 =?utf-8?B?cUpoYXhsTDNUejlDUFFJazFHT3NleTlzYmxFeE4zR21sRHRQaWRJY094WWxP?=
 =?utf-8?B?bjAwRnZIa1Z2YUJQbTdtRThFT1VqL3Rrd0YxSEw2MCt1ekJrSEdlQTBXWVla?=
 =?utf-8?B?U3pISHg0bUppMjFVZVJza3NJTEk3MWhuNStkcVhOM3dKYXJDNVJIamZOVlNQ?=
 =?utf-8?B?SFBEK1hKcWY0dFZVN1RnMG1PM0kxWlpvdkNPUmZUVnVjWWtKd2kvMXFSaXhD?=
 =?utf-8?B?YVRDS2UzWWpJa2pqYzk4TWlxTkMycFR6RDlvcEc0UlhVR3RsMHdUNFBNNmJ6?=
 =?utf-8?B?OC94VDh4M2J5SGdGL2crTUQ5M05hb1RCQWQyV1VyZ0E3cW1PbkluaXJDL1Zw?=
 =?utf-8?B?UTRIMmFKekdwQk8vTDlkakM5eVN1WTNYLzBTaDRoc1hXT3o1Y216cFVtaldZ?=
 =?utf-8?B?YTJ5bENOeGtReFZraVFZSFZiTXFvMi96WndCcnVRZGk3eGdrRzhuYlpPZXdS?=
 =?utf-8?B?aC9LSkE1SFM2WDlVbjU3b0MrNzFSMHFLaDhTbnhESmxsMFhuNWdUa3l3YWVw?=
 =?utf-8?B?SElXYi9oTHRXaU5uekMrcFdhTjFhVjVJNEgrS0xvUGlPNzN0a1h6b3hEbVZp?=
 =?utf-8?B?Y0Fud1FGZUtEQ0RnVnZGOWtaMzJTMVhob2pVWTNHcmlFNVlkdFZvVExLSzg5?=
 =?utf-8?B?Y2RhYzBFOEE4WjRKWWNiRmRCelduMjc5a0xBeVBkZTVNS0cwdk12KzRHVmlq?=
 =?utf-8?B?UE11cTRzNitCaENIQk8vUVdEU1BtdjJqSlJSMkdaTWpJWVR0VjlDOGowekZ3?=
 =?utf-8?B?Tkd5bWlZb25hOVNSZFRSQm1TYU54VDJVOVMyUmRBc0FZVUtBT2hFcnJPZlhY?=
 =?utf-8?B?ZnRIeWxUTjl2eC9GZXFEMllibzhLT2hOVFlZbWJJSEUwanFXOU80YTVLRTRn?=
 =?utf-8?B?ZW1MNTIwdDZvZ3hOU1k4TGtSU2E1Vm1LYTlUMFBFTitzalc0MHJkYUJIb1cw?=
 =?utf-8?B?K3hMVUNRTVFRQlZsbW04QXc0VWJZVGxIY2hzTHVod3I5MThMQmdlaTRNeXJy?=
 =?utf-8?B?aGk2Y0VBUlcyODAySzhYajZrenJMMXRTZ1k5Y1BmS0l0MDgxNmdBVERmNXpr?=
 =?utf-8?B?eFI5cTVyNXoyT0dObFN2eTB0VElxa2dwUlZKNHdwWnlRZGZhWG14OVRLUWFN?=
 =?utf-8?B?eGZHa0ZLdHpNUU1pVnJ2OTUrVXY1ODJDR0N5czlhRHp3OXNidmV6cDYvc1Vp?=
 =?utf-8?B?Mk1qQzBZdTkvNU16eGZaL0pwRlVqQ0xoWWRkQ0NacHNqZGpyN2Z1Y0Q1TG9K?=
 =?utf-8?B?dmRreUJxQU4zd2czd3JkM2s0TGVQbkZScVdPRnVvbWpJcEZGRDNJOThwNmlP?=
 =?utf-8?B?OVphRmpna2tNblRtdjZpbEl5Z0U3UkJSazg4dm1HTkFKZEFLdDhnOGtJNU9M?=
 =?utf-8?B?K2M4RSsvaTh0R2JSQ0lMd2lZdHVNZVNpTFlsSU42bnYzTk1WRmMvdGdYalFW?=
 =?utf-8?B?VmY0QlhvaWlLYjZqQ2ZpSzRkd2NoNkRrRVZzd0pGaE9nbXd2ai9paDJYckVU?=
 =?utf-8?B?K1VvY25PVmk0R25OMk55T0pTVjd4ckJQREhGbS91ZzN6NkxaTjFlVmptRVg1?=
 =?utf-8?B?aG9kaUV4ZEZFa3I1UmUzWWs0TlBVbjdkMVFLS0VtcFpmV2NveDNIZGtMNTRp?=
 =?utf-8?B?L3M4Vldvd1hjVXM0dTVudktzeVRwRVorRXhtMTVHRDBjek0wSW8rZEhIZ3E1?=
 =?utf-8?B?RkJUNUl1RXNJamxmOHVoSEZyZUtBVlRiZG1tV3VDVkxkSm5QV0hpK3VvWEFC?=
 =?utf-8?B?RDE3VGdUcmpsUm1rdTlpUTBVZXozdmt2TEZwVEt5TzdKYUdrVVA4bkNZakE4?=
 =?utf-8?B?RERqai84Z1Jna0U1ZWJMV2pUSmlQaWdNTmhtYU0yaEtnTy9ZaHpnVlZJWTc5?=
 =?utf-8?B?ZVVqeHpjbXppd2Z3SUhLc2ZESElwbGlwNCtOdXg4d1pBa1UzUTYrRlM3ci9x?=
 =?utf-8?B?eXlkM0lqeDJ4cXIxQnBBUGtmRHlIR0FTWUhOemg4SWNoVXB4QThtK29UTzNT?=
 =?utf-8?B?bFJKalY2emhXeE5DWENuMXFDOVRINkQ5N2hqZ2hUQnBVMTg0bG9QSGdFdGJj?=
 =?utf-8?B?QXNwNDZFRVYrdlc1V0FpRVFzdkdSTnFLRVcxQUl0Qm5vMlU0dkEwQ0paMzVI?=
 =?utf-8?B?akZJajFEMzg4d1EwSlQ3VC9ZTnBJQko4dlQ0ZzNLdTBQL0J2NFpERUlOakFo?=
 =?utf-8?B?TFdYTW40cFU5MDFmZC80TnZJR2VWZFVxbzNzN3ZlNFhzYllSNUFpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567fadaa-92dd-4870-46ef-08de4db8fd1c
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 06:50:05.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uQcpuqugkPPPxA2IySTcGHgzjnU6PEFVGe3YZo9O9X7ZLsmxZybEyzOJA7EFepJ1Qb150fBn6sOnONmUoqF7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410



On 12/18/2025 12:33 PM, Ashish Mhetre wrote:
> External email: Use caution opening links or attachments
>
>
> On 12/18/2025 2:01 AM, Jon Hunter wrote:
>>
>>
>> On 15/12/2025 06:48, Ashish Mhetre wrote:
>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>> virtualizing the command queue for the SMMU.
>>>
>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>
>>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>>> property. This property is a phandle to the CMDQV device node, allowing
>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>> Restrict this property usage to Nvidia Tegra264 only.
>>>
>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 
>>> +++++++++++++++++++
>>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> index 75fcf4cb52d9..1c03482e4c61 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> @@ -20,7 +20,12 @@ properties:
>>>     $nodename:
>>>       pattern: "^iommu@[0-9a-f]*"
>>>     compatible:
>>> -    const: arm,smmu-v3
>>> +    oneOf:
>>> +      - const: arm,smmu-v3
>>> +      - items:
>>> +          - enum:
>>> +              - nvidia,tegra264-smmu
>>> +          - const: arm,smmu-v3
>>>       reg:
>>>       maxItems: 1
>>> @@ -58,6 +63,15 @@ properties:
>>>       msi-parent: true
>>>   +  nvidia,cmdqv:
>>> +    description: |
>>> +      A phandle to its pairing CMDQV extension for an implementation
>>> on NVIDIA
>>> +      Tegra SoC.
>>> +
>>> +      If this property is absent, CMDQ-Virtualization won't be used
>>> and SMMU
>>> +      will only use its own CMDQ.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>>     hisilicon,broken-prefetch-cmd:
>>>       type: boolean
>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>> @@ -69,6 +83,17 @@ properties:
>>>         register access with page 0 offsets. Set for Cavium ThunderX2
>>> silicon that
>>>         doesn't support SMMU page1 register space.
>>>   +allOf:
>>> +  - if:
>>> +      not:
>>> +        properties:
>>> +          compatible:
>>> +            contains:
>>> +              const: nvidia,tegra264-smmu
>>> +    then:
>>> +      properties:
>>> +        nvidia,cmdqv: false
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>> @@ -82,7 +107,7 @@ examples:
>>>       #include <dt-bindings/interrupt-controller/irq.h>
>>>         iommu@2b400000 {
>>> -            compatible = "arm,smmu-v3";
>>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>>               reg = <0x2b400000 0x20000>;
>>>               interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>>                            <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>>> @@ -92,4 +117,5 @@ examples:
>>>               dma-coherent;
>>>               #iommu-cells = <1>;
>>>               msi-parent = <&its 0xff0000>;
>>> +            nvidia,cmdqv = <&cmdqv>;
>>
>> So I believe that this is a generic example for arm,smmu-v3, and so I
>> am not sure we want to be adding all these NVIDIA specific bits here.
>> What would be more appropriate is to add another example under the
>> existing example specifically for Tegra264.
>>
>> Jon
>>
>
> Yeah, makes sense. However, I checked arm-smmu.yaml (v2) binding docs
> and we had separate Nvidia specific compatible and property
> (nvidia,memory-controller) there as well. But we didn't have a separate
> example for showing this compatible and property. So, I wonder if we
> even need to update the generic smmuv3 example for cmdqv property or
> add a new example?
> Can you all please share your inputs on this?
> If required, I'll update the patch will the change below:
>
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 1c03482e4c61..6b07ca9928a7 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -107,7 +107,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>
>      iommu@2b400000 {
> -            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
> +            compatible = "arm,smmu-v3";
>              reg = <0x2b400000 0x20000>;
>              interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>                           <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
> @@ -117,5 +117,26 @@ examples:
>              dma-coherent;
>              #iommu-cells = <1>;
>              msi-parent = <&its 0xff0000>;
> +    };
> +
> +  - |+
> +    /* Example for NVIDIA Tegra264 with CMDQV extension */
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu@5000000 {
> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
> +            reg = <0x5000000 0x200000>;
> +            interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "eventq", "gerror";
> +            dma-coherent;
> +            #iommu-cells = <1>;
>              nvidia,cmdqv = <&cmdqv>;
>      };
> +
> +    cmdqv: cmdqv@5200000 {
> +            compatible = "nvidia,tegra264-cmdqv";
> +            reg = <0x5200000 0x830000>;
> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +    };
>
> Thanks,
> Ashish Mhetre
>

Hi All,

Can you please share your inputs on this?

Thanks,
Ashish Mhetre
