Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F13793A5
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367651; cv=fail; b=Svsbd1kZqJoxl/2s47p13tA/Pxkvv7enrhV5GRm3gtRgYLcCzldripOL/PHunq5HE0BFvWBX49dcflpYSb6BAJ+lpZQzE/AWbXxSqiRGUVrEW2kOHO6YtzjgA747GXzW/6SqzLQuFEWLJr8AEFAUCjPAsgu+QPkcLyRil+Oqm5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367651; c=relaxed/simple;
	bh=WiZ+pIRwqm4dbSnv+lsMVSFhp0sNaesZaMU6QW/5M1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ukmSCl10KnGRrVp7+tmN6F9r+zIqEJZRKMdRAEdlyN4g5XXo3lNLpEx3uFnGvoYwUwS2/KiBvU/ueVf5j8PVks8qmMg9Mp8XT+D49wn3PPtzPaJlsPTmnvb+cUwOqE3LTaM9m+kXZcvuiFewmqNivfWeGawk/IJ3NNKI0ThIbLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxLhqGUn; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxLhqGUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWEcSQUkMii/dc0AnUn+LsRxSSMZCNWPXWoROrHA42qrmWJDdods3TE0GyD+bVL0lDx0MuGHkRSORUY8KfFUuh+moSNaDAyod0etySIwdLnki4H8fawQhhPE7P7kV7NzrnKUCbvLg43d/YOmolfpGhlEnNBmYaa6bjhGS1cTtze1eycpRJKNWC3cmRauLwcKb/zvo2XoQeYer+Wizfzv6WNnxFxo3baEtPsO0Ctee+ySURNKyjHZEDuziaUw8QdzQNrNab00xdtT9PwJj6aV2xEvF5wDs2+5KaU48UqHEoANtAMqn74jt1GS6L4h8A6dfC8wLgv6ZNXjYkiJeL4IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pL31vXVqWI2DwMC4qjTsiILjBUbu88Rd/E8BjbHAKc=;
 b=wX6HP2AsWMAtwD8mslcfpQ0ATG2A47FIpbhct+yXx5rQLOzcDMzMYlMNPVpZX2JPMrGaZQQzGtGathnqvqhxqDeCqS5/2eM/ZC0lXFlB6CK5iTtjCErxwqITo1/al8/2q3dErQSGQkrJgVPLHqY34km5gbJPfezzFOoJE8JBlYFonEFmH8yCLsLsO0JP0OT5g3U+f13R6PgEhUpgmqUg6EFNei/HG8szd+ZZWc4zFlxyuy5XwMbzdQ8XTPBrQsWPN7J1q5H4W4kcxHQ3u14Je6vdTpNHZwg1j/QTstGK50LK/o+oF9oNabJwFu5X44CwTGx6B6X6RWLhjq/gnLkpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pL31vXVqWI2DwMC4qjTsiILjBUbu88Rd/E8BjbHAKc=;
 b=lxLhqGUn+FwTxsVGGDUctIQwaHdij8YWnjkjg1g+JmjTu7jl+02gfDwbCFfne0mtpCU3ig+teByHw9DYb/p94hPzvPVxaEX9S6vuGZO6p6FkfjO4I6Szcimf9YvTX/Qr5j3upG0jUXOrVV06hVi7sxTF+Yy3fBrRNxxN9XUKQO8dQPhc/ccH7nUvidCIZ09u2QnahiTHJ4FJpU8frqfqz3OZLCuBC7ehDVFQabitcER452AD8wLHirgPNqq4Adu1v1mQ2211ru8a+J9xy6/3b/lypoxc/khjaSKyXeHuviUStCJ0/uqCcsrO41u4cnIsn2MmriKlIJ46zo9gktdIWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 19:54:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 19:54:04 +0000
Date: Mon, 6 Jul 2026 16:54:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 0/6] iommufd: Enable noiommu mode for cdev
Message-ID: <20260706195403.GE118313@nvidia.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a226be8-c672-4f24-55dd-08dedb98555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zPkw1R6KUPFrDa8o0ISDLPp+5UivAkCyvbihT9OwQQWfcjFyFNgYZ6BF7qLa94PvxjSn/vUJUadP4qOgAujD7NoGKUwjfCPRfyisiClfGNjJnxulTLqyrD9tKrEtgR5UFIksjBBZVnJvTo7GHcYylBcukB033pyQ54u5aFrZamB4YS3hT5t4cgXbvMt0pl6/Bgw+/MyFlHtuWxi5zvpsinSWHxw7wlcxgbaJgPRaO78LBVnnjTNOpFIbVF0serVCDPrDZGdMSDCExOB+uDNTYWC9OMlLA/DGuuWK2z7jCqrweHSE8E25i9beUxnuW8kXpyRmAa5dLgIFruHE8mwcQEDEYYI0B4Hh282i+pMjjSCl0D8jaclLg4sotUjJl12WQJHKw2DEJDEWSvmf1exUdBZhHnLaqxGEFP3Wpe1g4Upp2eNzw1hZ8ULvGglzl3Z6o3kudCPWwbuvmnTlHSvmQ9B0wHAClpAdVNjBj2cmnZp954fqicqfEuHBAT2S36PDMAkUOHI/2OaM27OqbHtFd8b6N5Au9EjImZ5Ua19MI0PfW69uF8unaMvwIMZE7LBQmhHsDLLTNQc3nm89XnteYpowCvPbf9q5kpFu0iUIK8IILbioFkAjsH2svseA21LCtiHnkx775OxIDqiuIMxkGL8oiZ3KexWQMBatpdpLu5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22VgmrTHIz1QKKaCsds3KAvnJKp9U/1Kj7LShvPM5p3dvY/Dt+Y7h2uGqFOU?=
 =?us-ascii?Q?/on76R73pDUlIvTAM4cJ7UprvQlfjT54574f7KbKszEUaYTn50O6SeE9Vw8/?=
 =?us-ascii?Q?VYJJN71IjJHEUhv4g/EJwS8yDw7iLb1D11rIkp2fxxJBfEZOY2asyC5iIwHF?=
 =?us-ascii?Q?egdyesDmNtqSXGlW0QhhlgzmZIlaJvFFWk6p4bj4Wz6k09KSOJBSmyuwFoIb?=
 =?us-ascii?Q?qkQtc9H2bmldVVo8AR5eyYr10ftOTunGDqWdqL6Z/1R/zSx4WWowM6x35qdw?=
 =?us-ascii?Q?23s2CAYgNf635PHOs/pOzyA6VmCg3nfvmLtuxM+LE97zQkijXWkD1+hUnX0J?=
 =?us-ascii?Q?2kVBIlQ+0L4oDAI1P3fcC31XdQ8i60UFLEHIZSirMWRr3UDulToWxauHJosT?=
 =?us-ascii?Q?H1EdYHJ0wJLoUIbDf/mht9OlRn/neff2/3ukL93oCi+GrjHP11upbUnI3WoK?=
 =?us-ascii?Q?KntIliTlZwUwDXJhlHpqO2QycTV0p+7wQ7X5fpefmzxdKJZ0xn10Lnpn3YJT?=
 =?us-ascii?Q?onrX97FnecCxHjrvCJpIJrxIcSQxCO/jYMswgPKEN81wjvn+4AWZtsJEPnN4?=
 =?us-ascii?Q?Yb2GsCwa/2wcQ+M+ZJo4p/cxVOjFDllSesmcqtkNwzQMbbGrq3LyryyBBiME?=
 =?us-ascii?Q?j9eT0Mt3VvU7hMFqA0yi8upJMSNajdpw4jFxD+hTJtL/IHSpgLS6+Sm1pG/v?=
 =?us-ascii?Q?9JDwMijxRqHD/X1g6ARth4a8TQR68XIxVSJlg2Unt+ObLjOzrGt51LbZfTyp?=
 =?us-ascii?Q?KHcpSV3AIP9bJOYSbwOzWAqaqvQ16PcPk0MFrK8ewC+yU97kaMUPcmzW5NfG?=
 =?us-ascii?Q?5PV841mXrUJEPl8vVs7JjbE3rqEiF1K2caCcjRhQxyZYfg6eGCUSzw8e/5ks?=
 =?us-ascii?Q?JmSeBH0N0IG6s9dOLxl0QSGNpLiLvy4pBvvUoUwc9aQSBiLLAFtUnlMIFcBy?=
 =?us-ascii?Q?X+Urm//ERAPBchCXT+ga27S8Sh6LI/UmipFOhKAnd/29DzRdD88vuHfS/hQ6?=
 =?us-ascii?Q?cl/lq6j/iELhoXOms7Zf+/rL/kLlm5KPgmzJ6Z4FOAN7p5ip1v5WekXcJ+N6?=
 =?us-ascii?Q?d9lmGLYC9GUWhk9nkrnEazBFrXsWX47mGSimpaO0rPHuWRYzDEyFlWHIX2Of?=
 =?us-ascii?Q?G40UURnBSUODas2wuE6Ufzge68qFNFCKpSMoIYukpsPmLp0Li8hfQ8PeABgt?=
 =?us-ascii?Q?5uEId+SRGf/M0TlSLxV2YaTzlSXfAlDITD7WsWbL1ZslpOnq+4ktFtPBtOZI?=
 =?us-ascii?Q?MXxrdhtRGbsoyM9vZ7hlmIfQMTORiNtNLyZFKtzFP0qh3YaNCgYf0IOS2FMn?=
 =?us-ascii?Q?oez+6J3Y8LVLuuCiqGwt4ri7cY9rnsBc9biqf9uu19WAig7Qv3MzkdLGlFzi?=
 =?us-ascii?Q?5nBZg1Odjxgvge6UV1PIYR8fH1HIjpFJ8AZ66PrqAZuA2DN7axzlztWiy0P0?=
 =?us-ascii?Q?A0+cPFtfPuIRqN4NGx/1VIYdWxLxdmyFJvESmx5oWPJzOB8AHbvM/YhArlBL?=
 =?us-ascii?Q?fTbWDBejbcD7vTto55aMeAiTc+ag6OFpFo5fnvWruu9dNnmGYpkRjvWQ/pcg?=
 =?us-ascii?Q?ERxWD/tbVtGHhB4kNsq7qfNaZlqtWKPT7gEk2SzlLNSsFiMczqFieh4yw0zH?=
 =?us-ascii?Q?2Tiv1cFVwgmaaaSns/bbO5BN+C2HJjmIfkvX6RiG8IspJjjpRjddKfuFsdOf?=
 =?us-ascii?Q?RGa2KBkcxMyePy8LCoxfzajepCSvb7yYzLOm/cJHOEw0ypHH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a226be8-c672-4f24-55dd-08dedb98555b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:54:04.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNsNXzzwvM6Aotwdbf9eWq7kLn0hJ8RiWQjQsb8t6AGYip3DMArHQqRlrCsRKotY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

On Mon, Jul 06, 2026 at 11:48:28AM -0700, Jacob Pan wrote:
> VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group-based devices under vfio_compat mode.
> However, IOMMUFD's native character device (cdev) does not yet support
> No-IOMMU mode, which is the purpose of this patch.
> 
> In summary, we have:
> 
> |-------------------------+------+---------------|
> | Device access mode      | VFIO | IOMMUFD       |
> |-------------------------+------+---------------|
> | group /dev/vfio/$GROUP  | Yes  | Yes           |
> |-------------------------+------+---------------|
> | cdev /dev/vfio/devices/ | No   | This patch    |
> |-------------------------+------+---------------|
> 
> Beyond enabling cdev for IOMMUFD, this patch also addresses the following
> deficiencies in the current No-IOMMU mode suggested by Jason[1]:
> - Devices operating under No-IOMMU mode are limited to device-level UAPI
>   access, without container or IOAS-level capabilities. Consequently,
>   user-space drivers lack structured mechanisms for page pinning and often
>   resort to mlock(), which is less robust than pin_user_pages() used for
>   devices backed by a physical IOMMU. For example, mlock() does not prevent
>   page migration.
> - There is no architectural mechanism for obtaining physical addresses for
>   DMA. As a workaround, user-space drivers frequently rely on /proc/pagemap
>   tricks or hardcoded values.
> 
> By allowing noiommu device access to IOMMUFD IOAS and HWPT objects, this
> patch brings No-IOMMU mode closer to full citizenship within the IOMMU
> subsystem. In addition to addressing the two deficiencies mentioned above,
> the expectation is that it will also enable No-IOMMU devices to seamlessly
> participate in live update sessions via KHO [2].
> 
> Furthermore, these devices will use the IOMMUFD-based ownership checking model for
> VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access object
> as required in a previous attempt [3].
> 
> ChangeLog:
> v10:
>   - Rebased to v7.2-rc2, no intended code change

My impression is we are good on this now, right? I would like to pick
it up?

Jason
