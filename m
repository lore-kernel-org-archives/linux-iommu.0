Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5931E282D
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872050; cv=fail; b=bSMo258hlNlQ/XdXVVFPaE3KuLc1gZCH7gI4ShzlGvIpIfshEo5GBQ0KP09CNcPbBqsx0i5Rs/QwmWr1xgZuvGVKLHth5MyeSHufEXTANvM495Hph/3V/tLPl+d0nAEdS+hBrzv8XhOhg/+DBtWzjRTRJaefYJ4lg4OKlFuAXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872050; c=relaxed/simple;
	bh=Vap05G53NwkuaS9kt5yc9vfJBv4G9dDwFh05kHj3+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tRVAMiUZrbijbQm3pZol4Ni4jk91OGBgFO3hNkAI9lq+tg/GFoLqpcdqywbLwLb5shfgJc9ql12TUI1tXu9frDUoVdhbjyt7cXXvFeOG5dorGjTjzVoRc57Xto72fh4y6CjlwN0gZ6gKSVrJqwdjSPDw/CpnubTm9kRgWYIiZ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zpy0brrV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kxkRIEVn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zpy0brrV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kxkRIEVn"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKJObN008226;
	Mon, 28 Apr 2025 20:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=AQ2yVPUPDebCwTujMf
	cqBk34IoOPljr9Y2vNnGHKbAM=; b=Zpy0brrVJC/WOE4S0Z/gEAmzRzgplT58zF
	uVPwUSJNapBWjnphnNKFzTpt+HSS8Ov4Wt8Pgf4ElYo72duiaMg/zLXlK5rnaL+m
	ICzbViXWwPGaAfsDP8feslT7PN5Lo8w/ynCj40toRdfbXR22sNzXS8xwU1HiMg8r
	+WPjULEzh4vZA/RRvQKxs1MNeyycFKRbJ+c1ZEicmnbeN2bQa/9sJzRTtmUtmhnY
	1401p+ZDYyNI2XxDc8neNjDq/ed6wW152EBk1yOuNXdzaKzKrEqVw8oiT5aPP5dk
	ihSjjwP0LRU7xCEMjXCqFHQo/bl8g/6yzVf2gfBi0tieC53+MIVA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ag38r31n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:27:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKLw03033501;
	Mon, 28 Apr 2025 20:27:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011029.outbound.protection.outlook.com [40.93.13.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8xbbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiRoivaU7WW7seXxGMf+KQYA00L+efqzh3U/C2246eitVzuHDlPjw5IErCjvu6E5C8NsqmqpUzyajVkFrovYiTz8tlhzEnxxXKBeHRUShVReHvSg8mNWkG0D9jnDz5Y7XUCO80USfxpLhJKsOWVrsxX+JjLJ5x6x/7AaOlQ/wvAe51AOQttQOT1Sv00cLZ05XEYlZph/jDqyBBpHkhjnEoxkKcjIWK2Itk//7fdTL6lGTrGjuEC+b3Z+i7BS34gbwTbbfAXkK/cNj3k9tNZUOneqwsBjVON68wX7AWUj3rutZ8Kj9mXr6cv0r0jyRpC3IcmOWow/TLZfeoAADZ3Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ2yVPUPDebCwTujMfcqBk34IoOPljr9Y2vNnGHKbAM=;
 b=ulyV5X6rgus5QtAzV7CA5ZRIaYfYnjOIZ9bIJ9cQUo0FnpqIE5apg6/l5BKzw1CL+ttdfzVSkSit+q+c8g/xmjdT6kgTIvw+t4Al6LChEJhT4calKVd2mUjfarMvlL5/Qxhlnnqt07Vh29LxHLKEFH43/zUu8Jx2qBUcjju2eqi6u1W5xRhyEYLDRI5IwkwQX3j+UqPffIWpJrRnyqxDEKHkty7T7FZRHPZQXQPZtdbPN/OtpuLrMSzMHVDleT9sZISu/5aMzviLUYlCVHTneSZPCrd3m/dE78l+ZYHfZF3aNfQ1ERCS2PhpDCsJHTdCmPanrN1KlLwsMFjpnEwQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ2yVPUPDebCwTujMfcqBk34IoOPljr9Y2vNnGHKbAM=;
 b=kxkRIEVnOpUL5G+wKMnAp8xCx0K5lJlPm6xjN/G+bfQpiKQ95kP1VcHhRFq9m5OxtdavwbCx7Xs39aITWagX6j3fRTJAoYGamxvhVHyRds80IQMOTC6Dr8YqVTdpW4ZTTe91LHpfmgZdNh7X/oH61yURjmLldp3dbA5xOV5+9i0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFA3184E4F2.namprd10.prod.outlook.com (2603:10b6:518:1::7bb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 20:27:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 20:27:21 +0000
Date: Mon, 28 Apr 2025 16:27:04 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Li, Hua Qian" <HuaQian.Li@siemens.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Message-ID: <aA_kmHiB6cSgHgN3@char.us.oracle.com>
References: <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
 <20250422063719.121636-1-huaqian.li@siemens.com>
 <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
 <dc6f299b18f7870c7bffecca25cee9e436a32c7b.camel@siemens.com>
 <841c417b-c61a-4c3a-a9ed-236634d78331@arm.com>
 <824c8fa6acda7c840f856430b5d898c7fcd4702e.camel@siemens.com>
 <0ec4d1f3-feaf-4c48-9e0d-ac3f872bcccc@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec4d1f3-feaf-4c48-9e0d-ac3f872bcccc@arm.com>
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFA3184E4F2:EE_
X-MS-Office365-Filtering-Correlation-Id: ef152fb4-3d6f-4523-2c86-08dd869313d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIfXqDtdFI+UdyJjx0EO3Z6BSbZK7x648hNBORbI8rlnkbkB+pFEETmb9Xcr?=
 =?us-ascii?Q?2+zlUA5ihLN/DSuyvqAohsE1byw9VxCEJmuwufarnx7VzfGnaDOVzo0sb2XB?=
 =?us-ascii?Q?WJTIYtpq/ZpjS92ln5lbMy6QcVlC7tesYrnp1JF+wBibdwqFL5lTkOfiJTBV?=
 =?us-ascii?Q?vjeyWDual+jpvumIMrNyQ8DLLaFZpj+9ZeBjCExdv6TTyeFc+2bi1WMGYt4/?=
 =?us-ascii?Q?k8sMd2yC8aPupQQpdBlbCQBwIKBaqzZCnIKeAeRAGHm6dk9siBVejVixxjPH?=
 =?us-ascii?Q?xXH/rgcAeG41DalTwrr7tdWA84180ejSdyVzbqeZWsKZULnFMtgCmjHhsHgb?=
 =?us-ascii?Q?cKAzRQjIH9nSihTJky+xETMY6usiykg+0y8Ie3WkRysba1bnqadJB6LNhVxS?=
 =?us-ascii?Q?eiuM8vsw9KW/lMVzBTIfLJmdUFif+HhOnjnCJtA860p0wkFxvQ3ZsSU5usRS?=
 =?us-ascii?Q?bYM01NHpr7KtUahUGh9Xx/tK1yW4EH0KzSnnJFtk10GXB6srvBNTgMU560GF?=
 =?us-ascii?Q?aNLBNgoeBXYEpQIbe50LkU6ao1JMxMzqPHUkcAFrWO2K9+wsWLWOjvkf8wH0?=
 =?us-ascii?Q?kjRjpsb4l0bEoxFuL/niQXTHQ+dB0ZhRwLXLyfxnyfK02+4cfkdDRxmsUCGS?=
 =?us-ascii?Q?i+w/07jFNYojrKqbUQoKiymX84Tcbz7+m9taeibH5pspKxxqWpjBPgbfJNVA?=
 =?us-ascii?Q?4ixdvb2Ecp0tBkO5VhAJFAsbSX2WheiGn+u+FdiO3A/W9aXz/JEIjG2HBs0o?=
 =?us-ascii?Q?pnkx4VxakLR3P93lzXIOVzm5564AYlHLkYNjOmkGZSVKBGEp4IqNRmLrM4SL?=
 =?us-ascii?Q?re6XK76KhoQHjTOFPz6uNdbEMjLgA3hiQWbFmFY6VOviW+w7ltMJb3Jb6cGQ?=
 =?us-ascii?Q?XAg29RTAnsxHAjLIPNMQG5kHx02mL50W+rapev0VIB9lKvA+aV/0xUykHwbR?=
 =?us-ascii?Q?X0W+GTnmw4znS3BHMzMMMzceVIOInENSJK1/2st+0Puhc2qJk+RGlMiG60+l?=
 =?us-ascii?Q?I/Z4c0FCRoZ1ZyYHaZRDRIGKWC2HuQppikBD4IFu0rVfBlzF7A8R8e9wWSs6?=
 =?us-ascii?Q?YG8wCz8AbrCS9CtlrJyyMpWEWwzShK1NspPE1hJjiuSdY+8ModT0vuppaUI6?=
 =?us-ascii?Q?2y9kcy2ls+pyeUvo8F7rvmInTwLqPLzpcOOSV3K/PgGfhc7kuZvh3qR2M4CN?=
 =?us-ascii?Q?/5Pb9u96LA6sCuMPWrYnuxVJG81nYWM08NYBwUTKrF9jArpb6IWYpHCJL/eA?=
 =?us-ascii?Q?5XIm4+S5tikxWlRhAWbkGVs4zwsm/0MjzGLS/H4PQfnL4ItVGZJxRlOtH1IT?=
 =?us-ascii?Q?4SZCJUTJVsZxsNFLwIVKoXmoqlB4ly0gzfdnPMDIvzYTNiC6HpqxeSiYCwyr?=
 =?us-ascii?Q?BZ68ddon3Gabnpy/8OrdJwMmNUjq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHeXh9o0qoLJXA6QmqR6iUgAcBpEbcx07pEKLtnYS0O+b3xxLUOveOsNsBuH?=
 =?us-ascii?Q?PdNyddd+Xe3cHrrAxLSJohEi9zTUe4nzE7Y/9yXNASqCwearlndJECu20IFV?=
 =?us-ascii?Q?tb6dey/YsOUaNCCSkWf3j8m5TqO2F8qhFBYA+YWOeQmWS4KHTx6XfC24KQCr?=
 =?us-ascii?Q?9CDflrGQn+tdI9FdkZ5QK77112CuMfF6ZV4BzPhS0aWjhCZXpOxGlR4hloXC?=
 =?us-ascii?Q?SYRhj8TDgSHfiDfoejG0oMePbLU+U3bwqtMCRygzl5/dhKlAjORkfvJ8RnsB?=
 =?us-ascii?Q?TKu1ZJxsf+eIW9fiU1Uu9DLtrDfFYWO4ESMoJCZbvSANWh4n5UQMPAWn71wd?=
 =?us-ascii?Q?D7LULdtQB5Xg2NesL3iSOhOBonJYhOwZeugIJqwbvqun/S7hxSu9xQ2DbuRM?=
 =?us-ascii?Q?FV0ojzItsabWdPtMN84WSDw957V4od4chsRNZvTr3PE0MKexkLJZiyRWRI05?=
 =?us-ascii?Q?LBMqWmSbhCV4wDsRR8qk1Mf6szfUSZ04TZFvhmf/37b4JKJS2dUdHsRTIORi?=
 =?us-ascii?Q?3SOw8fle+jKZAVF8r2p/w9RR1avivTlbonFFMRA0/RU0Dyefh2AfviCYXHoF?=
 =?us-ascii?Q?ggSAOHhtUuHsfsZ2lH1+og+9tdfjhjIZMwRQ64inwJ4bsHNOVKRIIbi7hSad?=
 =?us-ascii?Q?IHXaGGsPS3QOiiO4O+Yvc7io0XdAof93LBbHsGgTpTbq4HNGcgrB6pjIxYxy?=
 =?us-ascii?Q?f3El1G/RvDo4LLfZhSb38Pdr2q5Do1GL9BdP6Pd3v6paMDuw3NQTM8DTV9fD?=
 =?us-ascii?Q?wr+xU/Ovs+j92oKBjH2p8KV1rG9dk0KxLUtLpwcjPGVSJItiZzRlCRinVYqv?=
 =?us-ascii?Q?D7+mHgfkzIK6i6ih0STV2e4qzfuXIlQzCBiE+KSjnbSZRq/ENp7l3dngJyCW?=
 =?us-ascii?Q?EdX4wvnW8j7255fEP6uXvtdHFKzqpZyed/43cLa/4POQDmmikmw4MacE1Z2w?=
 =?us-ascii?Q?oc+TMqR8CIh1JARS+GdIqWUJ4uwEyQQLyDV/xrCRwtsH88ixzoW8zmmCxCB/?=
 =?us-ascii?Q?8YXvThxVyvBfEh/4QK+L/92W8zXU3ab/kMO78kNgnHLua2dd5xU20YcTriLj?=
 =?us-ascii?Q?xSybgeW3WbchbScdh7PeA6/VreNhCE7PACnYFysMlG5Al3PXKBOh3YjjJ5SK?=
 =?us-ascii?Q?fVfTuOqtY/xJfqaid1nTL2dL1LThLVdb0TXNMMt85I7Z/fqOJ7rew6TsIMZ8?=
 =?us-ascii?Q?2ZWSWESAS0Rsg/irxDxteiElHQrk/ow4PZfrANO/IcHkb2Kxi5pooK4J18Si?=
 =?us-ascii?Q?Mpx9vtD6UZVhNVaYHGMmhef86HSG2oqM/S7ul48Uh/VoNJloBjDAFvsmLIkT?=
 =?us-ascii?Q?i7l0Y6RXYA5kMqFVLXUB0Z/bj2+Ny6Veez4TibDOS/fVu/K47hIoAyujzMJ+?=
 =?us-ascii?Q?Nhldd+i/pGxfPdPyEuriNkfDGBmvmDqTHZdTVU/kE21/gt5CpDYRw0/TI1vq?=
 =?us-ascii?Q?N2+uRGVWLq9b1bFKOfE7gNbFts/f6tABpX36k05TOBP6eeQdJz03tV5N0FRV?=
 =?us-ascii?Q?UejiFraM0NMVDd7INgjl9TPASNCkrwFHjfXGOKuf+b51D00g0J0jaIDOm6uA?=
 =?us-ascii?Q?rkoMBivP9dTx9T/EIrPA0ruxD+WvFBWxvfXPFYbEuLC7N8S6liBCsIsQidqN?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oSKDeFbRvGZ8RXig2Ne+yaIV7hYhueTHQjV9JBch6G5QrC7mE2QqRXoekLsTfqoK7IM32FIvamQScVVd9gNe9QsPoVchX6Yr8YL73RS4AMRiz1znmAF5qEnOIxHqv6megHhU3Arc6NQuJrfF0Pc1Frn1FTHHN+lWQAKwH1IPeniGBm9d2fLPafea0xxTzpSRboLTZbLiihyN53rcg1i840kX4XGMM26zYUe62da6DuFdC9VKXEAUUcmELiRSxidIUTeAp8vxeyaDffPS4gIcB9vesX0g5QvTGcD0NzIkl1iZRoCcg8alMmfIXOTULlHMaR14mWjrDcyB1GzlnPQlvTpFzCW/ctI3i05CA7VtkmOSmNOdN4qP2/7GKI+wn7csKTAEcW9BdgXJJMydTUtE/3h6sVYn1fDLosJP9+tVf5FalEWPFbiNOTaRicdJpd9ih5RsGqnHzs3OM1GGrj9SGWut3l14G/4RBIN54f7M+kKdruDOq5RBaO5Wrne8vgrU/ob+1OYjDCXZq/SDk+UObVC4JvhNpSbxn/nrU33M9KHW5+YKH5ou/STTtgKKdKetxc96U49rJ43110d18Hl8askpAwDSAdmBsItFIilethQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef152fb4-3d6f-4523-2c86-08dd869313d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 20:27:20.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6cNYNm+OW8p1mtAje8/A3jfEMgri8zN2qiVCJABPXIFhd+kaWz++GSxywXiO+X3quF++r0A7y4LCxVqXbMBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3184E4F2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE2NCBTYWx0ZWRfX1BS9BEGdr2eu bYwTsU7UplMq1aHJAy2CtVUWWEw8zXxUx8RT11pEC77VvlpQ/QvdJJOXX3slWhVXGKyV+xxKZ02 1l2JQfyIGbAdP+o8YqNwS9o2nnuJQN5yJo8UZrI8m0yxM0p8f/LKe+np8oGBw7wzctzpUUqIlnE
 zFNc5nc9uIJ/ZJLfgDHZOmsovJ8vmh64ykQoy//ax/XndWcQRYnxS6L9/J3cELwxzDC7HDZACXD Qjffs6nY9f753YPxewEUj7c+hpMMlQDetByfTdMQhr2H2hKHd/+ixjsloNJrJ5TJI+p+IhdFRvw F4TLgGkOK7g5N+FfhZVmpsn76As389h5q2ldmSNlIBUoJ8Vl7hlC50pO2wUQWwZMSgwxO8tDhGO 39TYXzNR
X-Proofpoint-ORIG-GUID: 5TQK5NNSJwLBSFo2K4HcoKAJwlGcoiS5
X-Proofpoint-GUID: 5TQK5NNSJwLBSFo2K4HcoKAJwlGcoiS5

On Fri, Apr 25, 2025 at 11:42:24AM +0100, Robin Murphy wrote:
> On 2025-04-25 6:32 am, Li, Hua Qian wrote:
> > On Thu, 2025-04-24 at 13:58 +0100, Robin Murphy wrote:
> > > On 24/04/2025 6:12 am, Li, Hua Qian wrote:
> > > > On Tue, 2025-04-22 at 15:36 +0200, Marek Szyprowski wrote:
> > > > > On 22.04.2025 08:37, huaqian.li@siemens.com wrote:
> > > > > > From: Li Hua Qian <huaqian.li@siemens.com>
> > > > > > 
> > > > > > This patchset introduces a change to make the IO_TLB_SEGSIZE
> > > > > > parameter
> > > > > > configurable via a new kernel configuration option
> > > > > > (CONFIG_SWIOTLB_SEGSIZE).
> > > > > > 
> > > > > > In certain applications, the default value of IO_TLB_SEGSIZE
> > > > > > (128)
> > > > > > may
> > > > > > not be sufficient for memory allocation, leading to runtime
> > > > > > errors.
> > > > > > By
> > > > > > making this parameter configurable, users can adjust the
> > > > > > segment
> > > > > > size to
> > > > > > better suit their specific use cases, improving flexibility and
> > > > > > system
> > > > > > stability.
> > > > > 
> > > > > Could You elaborate a bit more what are those certain
> > > > > applications
> > > > > that
> > > > > require increasing IO_TLB_SEGSIZE? I'm not against it, but such
> > > > > change
> > > > > should be well justified and described, while the above cover-
> > > > > letter
> > > > > doesn't provide anything more than is written in the patch
> > > > > description.
> > > > Thank you for your feedback, Marek.
> > > > 
> > > > To provide more context, one specific application that requires
> > > > increasing IO_TLB_SEGSIZE is the Hailo 8 PCIe AI card. This card
> > > > uses
> > > > dma_alloc_coherent to allocate descriptor lists, as seen in the
> > > > Hailo
> > > > driver implementation here:
> > > > https://github.com/hailo-ai/hailort-drivers/blob/7161f9ee5918029bd4497f590003c2f87ec32507/linux/vdma/memory.c#L322
> > > > The maximum size (nslots) for these allocations can reach 160,
> > > > which
> > > > exceeds the current default value of IO_TLB_SEGSIZE (128).
> > > > 
> > > > Since IO_TLB_SEGSIZE is defined as a constant in the kernel:
> > > > 
> > > > `#define IO_TLB_SEGSIZE 128`
> > > > 
> > > > 
> > > > this limitation causes swiotlb_search_pool_area,
> > > > https://github.com/torvalds/linux/blame/v6.15-rc2/kernel/dma/swiotlb.c#L1085
> > > > ,
> > > > (or swiotlb_do_find_slots in older kernels) to fail when attempting
> > > > to
> > > > allocate contiguous physical memory (CMA). This results in runtime
> > > > errors and prevents the Hailo 8 card from functioning correctly in
> > > > certain configurations.
> > > 
> > > Hmm, dma_alloc_coherent() should really not be trying to allocate
> > > from
> > > SWIOTLB in the first place - how is that happening?
> > > 
> > > If you're using restricted DMA for a device which wants significant
> > > coherent allocations, then it wants to have it's own shared-dma-pool
> > > for
> > > those *as well* as the restricted-dma-pool for bouncing streaming
> > > DMA.
> > > 
> > > Thanks,
> > > Robin.
> > 
> > Hi Robin,
> > 
> > Regarding the specific Hailo Card case, the issue arises due
> > to the capabilities of certain SoCs or CPUs. For example, many
> > K3 SoCs lack an IOMMU, which is typically used to isolate the
> > system against DMA-based attacks of external PCI devices.
> > 
> > Taking the TI AM65 as an example, it doesn't have an IOMMU, but
> > instead includes a Peripheral Virtualization Unit (PVU). The
> > PVU provides functionality similar to an IOMMU and is used to
> > isolate PCI devices from the Linux host, and the SWIOTLB is
> > used to manp all DMA buffers from a static memory carve-out.
> 
> And as I said, if you want to support general coherent allocations then you
> should use part of that carveout for a regular coherent DMA pool. The
> restricted pool is only intended for streaming DMA - swiotlb_alloc() is only
> meant as a convenience fallback for the kind of devices which mostly do
> streaming DMA but make one or two small coherent allocations from a suitable
> context. It does not work for *all* valid usage of dma_alloc_attrs(), and if
> you want to do this for arbitrary PCI devices then you almost certainly *do*
> need to be able to support drivers which make allocations in atomic context.

If they utilize dma_alloc_coherent and setup at boot-time those buffers
then that does exactly the same thing as the coherent DMA pool. Albeit
less flexible, but nonethless the same thing.

That seems like a valid use-case, no?
