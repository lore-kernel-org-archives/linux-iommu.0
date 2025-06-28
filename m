Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1141AC88B
	for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751108865; cv=fail; b=KrJtkKYwjs6Ekaa2JpowyNCMzBDIbeLWNj491hWcCbknV0+1ND3VNmUZfkMafhp2lydf2js5xHYw/pvuqW2x6mWiUzUs9Obk+OVm842hb73t5xqa3rd9Ki/aUtlLLAU7+1W6bNEWfHk4NXbX0WMRQRCMg4ubIaMB07MeZx4AKTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751108865; c=relaxed/simple;
	bh=5jXOtUA/DAQrq8rju2Zg8BQ7K/9xBm7kdfFzom72ZIQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=fxDPqvqjHrlU5sRO78w0vl+sPcx/6IC0wr5CTnA0laCveyjjsUeXnHNkqQzJtlWq9AKLfPBrXi2H/xOWcykpSoRHSDre7bDZ43h/zP2Cl8H930A8RtJCNgbRluKc+SYcKuO4WcabCNZ3mBcAYt4qwhvWPrhFTiIex/CaRsKAaZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xn9hDuYV; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xn9hDuYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE5SqrHPhpjVu0uM3uIPvDpYaQTnFNhVSuInOgGHxBxsEgghYt41bxeJ1gXADOzRqsH+5JC8/NcbOYKrnVaZDqyx0zA4QfzlMxzfvHv7HcWRyk8+PsMa0vW3RsmtmO4mDUsNjTax6LBt+hsmIAt2GBy7C6q+OFODhWPX9u0vx8yMlOpIOLuZCtHS1l3hvZ4Gb8V/GmqpCwGApGB9ZtkbV9bwQRcXPf6ne44oSOqQpYYuJKRiREdCF7zl+ZKdLhXcthaXg3OBJ8+RRkaKNomtiGPys4zX7qcmuvu+QjxzESEamejgErhcL4nzQxbtCF75n2hT7x9U91TWGm+faBNe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkAZivoNTguVqyJDknfdQnDA7pkztmu7/2pJtlFXtcw=;
 b=LAvYSGYA27Z8WgSXOzNEd4rekb8VQnnlkqHMUoSHDuRDhMd/I+MwQTcb63hkehyTwTny4WwhbHcaKZnYqU714nFRWsCmfMXkFLOzquBoPqJ3xjKG31SOBNA1a0wJHD8uXlCRg3PFMx1+HjbGiZHE9C1/fNQLJDdopzgHf9RoglC7Dg63tA6z6gOnN8NHhpjIGntYzM8ZkUbGtbUSZkXM9FAUhFcb99rYwLq1Wc1ZGtB7rNLUQEhuxJkxwuA89HXWLanzu+gdRxjtCoHnzVvYNrv1wZWQIs/iOXMcyEu4fO2AZGkijS/TOQ+dTqbhZJlmd51hY/Kk/2pHeiZqZvQ14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkAZivoNTguVqyJDknfdQnDA7pkztmu7/2pJtlFXtcw=;
 b=Xn9hDuYVso8jLTXdT0hkTxoT6O6xa1e7vs8KN6fS1LSDKx9eZcEpHDNPyHY6jrgrl4HJYQZkiLxB/nYgxCvZ1tnkODCx4E5B3bSPDGV2DdKoNYzLDJvDUqWgOCmmt8A7QfW5csIHKm5SnHlEz7PnP8stxA8nrjzcyZrYW2p6QW/BOPR4u0jILAt7UBr2b3T0TQrAd3NFifOqPVpqzljMuxHWFeEcBCCW8hd2iveXklwqtywpUJTfgpQDA7hern1g6/TDYX1UQWnlyyteg+P4t+iyguMY4K+enExcgGOxd6kvvSbopx0DvlZYeAoh0IX5TDGlW2vE+q95BcS9ryA62g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Sat, 28 Jun
 2025 11:07:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 11:07:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 20:07:34 +0900
Message-Id: <DAY4A657OJJF.3GE3LBCFXU6SI@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Lyude Paul"
 <lyude@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
 <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
 <DAENGORNRVZH.2KIGKFV5C5G3L@nvidia.com>
 <f787046921fd608c385dc5c559883c5d70839507.camel@redhat.com>
 <DAP96FEJ0XWT.PWYMIE8IJAVQ@nvidia.com>
 <e2677c26-1c25-4a34-b666-9dcfa9642fd1@gmail.com>
In-Reply-To: <e2677c26-1c25-4a34-b666-9dcfa9642fd1@gmail.com>
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dd9949-0108-4571-9cac-08ddb633fd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkx0dFl4RHpPUVl3RlpCVnhxQkg1bFNqTHh2djVjcDNGc3NRakhEZ1U2SUx0?=
 =?utf-8?B?QlVVRnJDWklBbGFYdG1sOVo1bUxjRGFXa0FwOHZCSEhyR3RGYllSWWtGbGhp?=
 =?utf-8?B?LzU5TXBndG9VMXk4Q3lkMzlUZEk5SndKVmppTUVtVWZrT2lEQkl5NjJHOC82?=
 =?utf-8?B?bnV0eG9vUVhQK1M3VkFiK2lHR3ViWmxBNmE5b01xbTdrTk5PRFBBbFJ4bG5M?=
 =?utf-8?B?RmVPVXA1TUFuMjRHNDRaYTh3TXpVRGI5ODBnb3k1TExLaW1YVzlFQXNyQWkz?=
 =?utf-8?B?NTVrb2FrcXlTNXk4bC9LUGh2enQ2Um95ZDBBYlJsZ205QW04Tk02V3d6TXhu?=
 =?utf-8?B?eTBJdzFSNnpEU3ZZOVU3amc2K1dEaWZFNnZybGZhMERNTkVaT0pNWmFhMEFy?=
 =?utf-8?B?VW95K0trS01qK0JQYkRrWG1KYUpmYTByamVpNExubklHd2p3aDVpakdXUWxl?=
 =?utf-8?B?MVE3VG5ISTloVFhxTS9xa1VTaXRqOTh5QVBaRnNYNkVwMXVYeHpiMEZRSVlu?=
 =?utf-8?B?cE9jR3RtbUlIUVd1MHhlaFZqbE5ka3hKN1RBKzd0ek0ydjdwMlJEVitQRTB1?=
 =?utf-8?B?a3lCOFN0N0lKRXBjM2txVnJNd3c2Z0s4dkdLTDR3ZGlNbXB2SmRmeEM4dnQw?=
 =?utf-8?B?RWptdmNQbWRQci9pZWxicnQ0MnIvTUM3dFk2SkNDTzdRK2IzUmVQL2poYzdw?=
 =?utf-8?B?c3JDMmJmSlRJNGZRdTZlTnlMUGRNTHZNUlh0RzZaK1l6cWNBTUJHbDVxSTNk?=
 =?utf-8?B?ZE9IdjYvVit1VzRGU0owMDBNSHJMaWh2N2lLNmRia09uYktSNUZjQjNXOW5F?=
 =?utf-8?B?eStPZCtZU0h4OFRZVERoY3Q4c3FuL2JPT3lVU0JmM1VjUkdaMzBrTlY4S05Y?=
 =?utf-8?B?Tkt4UGl1TXFSeVI4UmhuUXZjYnQwbktnK2hVM2NyWkp3OUcrMnh4dmpud3V1?=
 =?utf-8?B?RDVvZjNOa2xDRlRLWWZ4UDd1WThHN3VqZlV4d1plbmJrQXFPUmF1cStqaUlx?=
 =?utf-8?B?U3gvOWc3TEcycEhBRFJVZ280eVNLcmcvUG5qYXdpVGlhT1lMblpXZ2kzSlI0?=
 =?utf-8?B?Y0h3aFFZZXVKSzgrL1V4RzJzd1VmZ3hDd0tvNDRSblk4ZnF3Rk1BV2t6M29G?=
 =?utf-8?B?d1dtUHNLOUJnNCtkSUpabDd4UlJ4OVdnNUgxM3NramE5UVNhaDhiZ1JqOEND?=
 =?utf-8?B?M0thR1ZTenNkMVVBbXR2L0NBS3NQcGhuc3p1c013Q3cyMzRPMEh3OUZDa0p2?=
 =?utf-8?B?Vi9FbEUzLzFSSWw3TTRjYUhnbVJSUXBYRWtYUjhFSGZhQ2E5Qm5TRi9kbkF3?=
 =?utf-8?B?VExBN2o0NDhmTlpyNnlITjVBMUI2UE9NcGR1WFdYd1Y4dWRITFQ4dmtZNEpY?=
 =?utf-8?B?Q2Naa0Zza2lXUmZHQWdEOTB4bW9XclBKMk92Q3JrdjVZL1BUcHd2akhSUFA2?=
 =?utf-8?B?VVdLRmVhU3ZTSTlNZlVCcHRsMG5veUVhbnFrYWFaMWJCT3dHcVdIM043V3cv?=
 =?utf-8?B?L3BNalR6ajlMUHkvSEZmWW5RT3I1bWpUUFB6cFRaRmIxc05wMVFMMXdzWjlC?=
 =?utf-8?B?Q1dEbTFNSmVqb0JMR0lsMTJEaTNnV2RNWjdRVUZVYkxTeWU3TWlYM0p0YWJo?=
 =?utf-8?B?VmhsQlpsWHNzVkNsL2R1SzAwckdBWkVFYmVUSzRveWF2WnlPWU9QWmZueVRB?=
 =?utf-8?B?YkZUQVRZZzM4ZjRLREFyS1E2Ukl6TW9LRnlZTUdJRzI1NElSeDVyekplYVAz?=
 =?utf-8?B?TkNiSmRjRzRnQVRuUlpuaVlTZzQrNGY3RFpBYVh6ZUdwSFVDOUlCcGxLaG9j?=
 =?utf-8?B?Zkd4cGh2T2pZWEo3cjg2bzRORWx6S0szcmdkbkVIU3JaMFJGbWkzdWVwbGlR?=
 =?utf-8?B?bERKU1FzODg4aXJyd2xyTUE2MldibDNZcG4yVEM0VUh1ZkZTR1Y1ellxQloy?=
 =?utf-8?Q?dJKoR436DGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUQ5QThBeDhJNE80VHloTmowekxEVlM5Q2dlWVM1enRyVkYyWVB4UkxlQUwv?=
 =?utf-8?B?SkRpTlh5a2tXbVZmNWIwdENUdzF6Ynl5SDJwZ2Q5Y053akE1enpnZXE0enZy?=
 =?utf-8?B?QjYya2ZuWHJxVUxRZzdydHB0ZG53ZG1Qd21JSG1GT2hhQzRXUEZ5L0lOMTFL?=
 =?utf-8?B?b0xsSjcxbnAxM1RLUzVORU52RVhya0R5UWlEZk9mOE1kTkFmK1cxMU96TnQz?=
 =?utf-8?B?UEh3S01qRDRrbVBmUTdxYzgvU1JoV1IzZjcwMjZpSTBoM245YWl6aDlrZ0NZ?=
 =?utf-8?B?YUxvTFl6eWE4dGIrSHdiSy8yd0toS0xpKzAzeVVhWHVRQjVmVVE1SGt5cTE2?=
 =?utf-8?B?Zlp6ZFp0QXN3NCs5VmU4MTAxZ2t1THZoK3oxRTJ6b3dVQ3Z5cFVNVFFuSWoy?=
 =?utf-8?B?UmhpRzVNUG5TcWNlRWtiMmFDb0Q3ME81c29YeU96K0NwQTU3aHFBaEFYRWd3?=
 =?utf-8?B?ZlV6MU9IalgzelU2cUVwOFBTNGM1bys3cWtQVUdidHdISGliVDAvZ2cvNDJ2?=
 =?utf-8?B?RHFndnVHZHpQOEVZelNzZGtTbW51NmhrNk5hSWNzNlJSVndtMDVzOHU4akJa?=
 =?utf-8?B?cElVM3RVVUdIZitGYXF2bXZaS2pDQkt4Z2hQdmh1RldMaExJckdiN1NJOVpw?=
 =?utf-8?B?bnA1Vng5VDFaVHp4RFlDdmVXYVVYUndNcTRLSVZ1eEFIWENYYmVtTEZnRlVH?=
 =?utf-8?B?WThRcVhHZnQ5M2llZzhVSzFFYkNud2xYYkRnL3dDMnJHTjUwYXpQTUZXOGow?=
 =?utf-8?B?ZHQyVmJkV1FSZWxxU3ZKanBMdXBYdEdRME1aU1gyYjU2czNHSmFUNEJ2VFB1?=
 =?utf-8?B?Ti9VUmpWd09kZjRReHFVS0ZXaEorR3lGOW1TL29qUndsTHkzYjBtdjVwaHdC?=
 =?utf-8?B?T3kyOWtpTjhBd0VFTVB5RFpRRmdqd2hONHdyNGlFamtaYU1LcU44WWc0VHRW?=
 =?utf-8?B?WEQyKzBSajRxT1k2QnU0RStjcWUrbDZwdHpEMjhwSW82dVdjYkk2eldxS09h?=
 =?utf-8?B?SkZTTWIrcUwxSkpacWNHem5RRU9rOFBsRVN3QmR0NXRNQzUySm9tektHNUg5?=
 =?utf-8?B?UTA1bjBucVZ0SmgySHB1TnNEclBHZjFMMGlOZm0zdmhEY1RWcUo2RDZSQ0pi?=
 =?utf-8?B?OWUzaUJndDM4cm1MdDF1ZnpSMjZoZEo5OUN4Mmt0MzVoSkp6Y3JkQXBuRXc0?=
 =?utf-8?B?YnJKejViMmYwSnh1SWlramRZa0hyQ0I5RHhmUWZ6Tk53QjNuQjIyNlJEQlJy?=
 =?utf-8?B?MEZLRmlwNm1Uam9vRnFKemUzR1BqcFNLZ1dqYWVXQmJVRzNBMmpvcGovMVFQ?=
 =?utf-8?B?TlFxcDBUeG5ySmFEbGhvRDlISlV5U295ZWZQTVVTK3A2N0RraU53WjRQVjdM?=
 =?utf-8?B?OVpWb3B1a1d1UlR6ZFhoRnVqSnF3SDU4MXYwR21Id1g4YVlqMFluMzNGZURY?=
 =?utf-8?B?SGtNZUJ6bnkwVGdGZisrcFNBR29pZEc3cmxreUFQdUYxTEhtNWVmMFNXdTcw?=
 =?utf-8?B?T3dNMmcvODUxVnNCRnlEb21iTVFFREdaenBISWo1NjNKbWlCMnRQTTNUTEIv?=
 =?utf-8?B?QVhnSW9xYXY1SlJXQXh0SE9uYlJ2b1hvR2NBS1VjTVVjR3pERGdIRnQ0b0lM?=
 =?utf-8?B?T3B1UlZSN2MydDFscEtodnE3UU5rVjVCSng5clEyMythQ0tkOXRQZWJhWDFt?=
 =?utf-8?B?NHcyZnJPU2xuL3ZKQ2pqM3Z4UkE2cUEyVS84bGxoRnlaS1NFR0lFTVQyY1Q1?=
 =?utf-8?B?QlFrSXB3L3d2ZUFnc0VYNjd6WkVJKzZHYVdUYURvWElWTXFhc0dMQnRObkxZ?=
 =?utf-8?B?Z25tbGdVcC8zSE1SZG5YclNSL1dtSWtWam5FSG9kVXRBQ0JKTGNMWW9Xd2s0?=
 =?utf-8?B?azhWNkJhakJGQ2lQQlg1MFdqR3NieDRSMHZqQytrQm9EdGFYTkZRZkdyN0xm?=
 =?utf-8?B?b1V3clJKTEE2NzByWmtPVTRscEprajArZk9mQ21yaWQ5V2tUVHY0bEpESVkv?=
 =?utf-8?B?NitRaUxOd2lhVjRER3pteStLeHJsc0xYOFJaL1ZwaFdqNTNRMW9Fa3lSbHNB?=
 =?utf-8?B?L3g4SHhObWxQaUppdVh6TjZsV2tDaEgrb1BVZ0FYR3BPaFB4bkRiblh3UHhZ?=
 =?utf-8?B?Z25HMmRseE5jL0ZuaVFESFNpamF2YmZ6alQrcEdTcTcwL1dFakE2dmhGeEFG?=
 =?utf-8?Q?BLhhQ7b9Xu5UNHGUom+1mhP8LkOdzGBxJc0mV7C0yRgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd9949-0108-4571-9cac-08ddb633fd84
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 11:07:37.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK5wL+6xHd3i4qfulHwXUocHStiwk+nfX3p1CX9us6QFy/wNhZZt7dfATGl8eoHmDPscJnBd0SIEVhOW4s2bZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

On Fri Jun 27, 2025 at 5:31 AM JST, Abdiel Janulgue wrote:
>
>
> On 18/06/2025 04:03, Alexandre Courbot wrote:
>> Hi Lyude, sorry for taking so long to come back to this!
>>=20
>> On Tue Jun 10, 2025 at 2:44 AM JST, Lyude Paul wrote:
>>> On Thu, 2025-06-05 at 22:56 +0900, Alexandre Courbot wrote:
>>>> On Thu Jun 5, 2025 at 10:30 PM JST, Abdiel Janulgue wrote:
>>>>>
>>>>>
>>>>> On 05/06/2025 08:51, Alexandre Courbot wrote:
>>>>>> Maybe I need more context to understand your problem, but the point =
of
>>>>>> this design is precisely that it doesn't make any assumption about t=
he
>>>>>> memory layout - all `P` needs to do is provide the pages describing =
the
>>>>>> memory backing.
>>>>>>
>>>>>> Assuming that `_owner` here is the owner of the memory, couldn't you
>>>>>> flip your data layout and pass `_owner` (or rather a newtype wrappin=
g
>>>>>> it) to `SGTable`, thus removing the need for a custom type?
>>>>>
>>>>> I think what Lyude has in mind here (Lyude, correct me if I'm wrong) =
is
>>>>> for cases where we need to have a rust SGTable instances for those
>>>>> struct sg_table that we didn't allocate ourselves for instance in the
>>>>> gem shmem bindings. So memory layout needs to match for
>>>>> #[repr(transparent)] to work
>>>>
>>>> Thanks, I think I am starting to understand and this is a problem
>>>> indeed. I should probably take a look at the DRM code to get my answer=
s,
>>>> but IIUC in `OwnedSGTable`, `sg_table` is already provided by the C si=
de
>>>> and is backed by `_owner`?
>>>
>>> Correct. You generally create a gem shmem object, and then you can call=
 a
>>> function to ask gem to create an sg_table and hand it back to you. I sh=
ould
>>> note my priorities have shifted a bit from trying to get shmem bindings
>>> upstream, but currently it's still the best example I have of this usec=
ase.
>>>
>>> So, for gem shmem this means we can operate with an SGTable in two ways=
:
>>>
>>>   * gem_shmem_object.sg_table() -> Result<&kernel::scatterlist::SGTable=
>
>>>   * gem_shmem_object.owned_sg_table() ->
>>>     Result<kernel::drm::gem::shmem::OwnedSGTable<T: DriverObject>
>>>
>>> I'm going to call the first return type SGTable and the second one
>>> OwnedSGTable, just so I can type a bit less.
>>>
>>> The first, sg_table(), quite literally just calls drm_gem_shmem_get_pag=
es_sgt
>>> which attempts to allocate the table and return a pointer to it on succ=
ess. We
>>> then cast that to &SGTable and return it to the user. This can be good =
for
>>=20
>> Mmm but if you cast the returned C pointer into a `&SGTable`, then who
>> owns (and is responsible for freeing) the `SGTable` it refers to? If the
>> pointer is just turned into a reference then this might leak the `struct
>> sg_table`.
>>=20
>
> Just commenting on this bit. From what I've seen, we don't actually leak=
=20
> anything. The cast only creates a reference to the original C `struct=20
> sg_table` object which was allocated and owned by whichever kernel=20
> subsystem called sg_alloc_table(). Rust doesn't even allow us to take=20
> ownership or to dereference the value, so this one is safe. Destructors=20
> are not called on those "casted" objects.

Looks like I was confused about how `sg_table()` worked. This
method is introduced in [1] and calls `drm_gem_shmem_get_pages_sgt`. I
assumed that it did a `sg_alloc_table*` somewhere and returned the
result, leaving the caller responsible for releasing it - which would
indeed introduce a leak if we just converted that pointer into a
reference.

But instead it appears that the SG table is allocated once, mapped and
stored into `shmem->sgt`, and that's the pointer that is returned. Thus
`shmem` is the owner of the table and the semantics are indeed safe.
Thanks for the clarification.

[1] https://lore.kernel.org/rust-for-linux/20250521204654.1610607-8-lyude@r=
edhat.com/
