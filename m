Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3732B114
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071168; cv=fail; b=E3ytfOaouNvsKcrGSWmQPk0OVo0U/dZMK58pAw+EjHFVzPNYQJ5wudlWGhMT8PjTemitKrehunEkXnIQIFg6nux1tzHXQBf+cPfi93wxlmUDlkqZwVi8gLY1T0BIe0Yx1wDXz+IF5+nUX9LddJhJd0+bahBj8PIPUouJdZjc6AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071168; c=relaxed/simple;
	bh=90mz1qrsmdG4ctCsrItepfMSGxdBkh1Hb0ApSpTY0Bo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogftIt6cui92lzG5reHxqlNUVP2vfcYya2TRhxDkUR9cYWgbVyc2YTf5PMSwMhN8BzJwacrM85jg9W3hxj467KnWMGfgNjVwlHIBljKZnAW9nteR7+LkU4pelTWJp74QwesGEYKCyhJdDuH2cJSv++nBuVtTlbqBArVrs3uBlHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miOIzRe/; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miOIzRe/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/qLpy7GBMUcGhI6bSYZ9S20HHFVaJcIKz0uhkd4zFLxmdBEo6xMRRJj9oJZ7DvxY0Vh5XiRCtJqt+zmF3gJBmrLdvSGOTO9eV9UYAlFqrv7dpIvCSKzbddW/mNnlS4jXpCJgj46wiPTtve4O1d5J5dZC6t+m/oMLsOJqkaDq4J9deAEDFyomtsJJ7gDk1Jhed89N3stoXGLr8LKwOL9W3lLO9M+Gc9sPyKmAmt4jTa7G8M0YxgLuy5a87dbpdg32g86zjF2CF/Rxr8CtYBXa+LQ/0ZrBzQP+njatOEwSjKORw+CqMZo97HfjJgea4L+iQHDpQt9vO+V6wlzgmmfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4QOSUXEXkkbuEETHONAYf8ldVIUNmlawAFy+gl9rcU=;
 b=i365MJCfdHhpTqD2bOHYaprmyXkU3/ZLNY8Qtn7D6PU57ms21ZeMXEA36HQj4ZzgsTTDaWK05F0KpjkHUypeSNoZvq0OEPGZ4UIGze72rSChmmc+666c7GM15v2/0Aaik3gTmiAUeGsLivYCAz2TlHD5/c28R++uexGHqFN/BRRWavBoOqjup7UitItzPIM/S6riZnDz06EOgalsc7X2ThcAh5Qv+dhans0qmCDGwV9CgVCilAjSyqBK021POWn26Xh9ITylt+L/yFBt/MAPBt67T1eUojtkWJEOrdf2eD0PwC/UNhfJKPppWDCZlPK4rRSSdngdIfZdMx24D7VEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4QOSUXEXkkbuEETHONAYf8ldVIUNmlawAFy+gl9rcU=;
 b=miOIzRe/ySCSq4M2y08azhySU1TpGZlYuZwqB/ldNtwOjhKYAYZZisg/ymdybw4q8NhEJoj1OLu16vazhh74tyTOXyA675oNbVsEDczaVNLVzKetNgL13h3p3KpuyEi5FthxCZBVyDZ4Z0aJ+1TeXFAzUaRWNQHhsxO6mI6ILSE=
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 29 May
 2026 16:12:41 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9a) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 16:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 29 May 2026 16:12:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 11:12:38 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 11:12:31 -0500
Date: Fri, 29 May 2026 16:12:20 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: Pranjal Shrivastava <praan@google.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, Parav
 Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, David Matlack
	<dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Li
	<chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, YiFei Zhu
	<zhuyifei@google.com>
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <qlvj2ljrlj6vlbto6dyqkdofrklhb7erjex7xg7ei5jils5mx5@7hqisoqevqfi>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
 <agr6yoyYYq2QFxjL@google.com>
 <agth8vZh96TfEYl_@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agth8vZh96TfEYl_@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: cd344fae-9bbf-49ca-9907-08debd9d1acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|6133799003|11063799006|5023799004|4143699003|13003099007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w2NEyKVyauZKOFH4F11r6mb9gzAMMYNxfIVb/WZyTzlnVt+eXNWG8cypkDsrfAZKRrBGhE+NhT3d5fKd5ITYzYlB2LS4QYKO4s1HWv/aoiLFCacdaMA8cSNlvEEB1x/jK+mkX0SHEqKUeNyjtvrbWq684bzOfJmwRTon9M1eXmBFGOXYuRI3WFOcxFeKtq9k2BiwvNDDcilJbRbQgClaurHu6BTSVEIghFgJr9/L1/UnzfFaRJrUj/SQExbkwFv76deVCcNuP0d5ZeFOzSpK2PEHD6fgvVM5kMFUyEkrPgAiAle5bAY2swe5QDzB2urpUur9383Fiy6JcFHX//AHcdh8LUFBxe0d6iVSAf1v8lhlEUS1soRpSYcZyaV0s6jwJp84CUvtjBYp3EbxW8MVZKfcKJdnLzagGyx0YjKLawC+3anWM9FcUDHyHdgbPvNFGo5QAasAV93Gsk3avfpipl6lrf6ZGyX+50OnGC/0/7OfGHWlBl4k+w7fQy9QKmR8Zo/uV5tod9qea4Vm3Qxmt3neJJ/Uwyazgy0+9xYJBemIP3qPFbS4TeBePqq3JtEjFc/SjE07eTXzQ2YL96IoYhiUne3KMVbl5tFUVp4PyPI/cSNdw/yC7QR7KMnVuLrNZFtxQuEtFHkjgJGGZiZQ5eVtYq0/noAblU0i3tp2DhaUxC0ifZQR1JTQcHlMzyKQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(6133799003)(11063799006)(5023799004)(4143699003)(13003099007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	buOK+IumbNhmaaoiXMWzuOQeLeto+GPWacJoS8ltRVDYaz1rTWZN3mty6OTbLEa/jEorWVPp4zpHvRv5eQ+CtYa3CJC+m8HJLGwscJfH5F7HdYGkKO8QWknDSAKo30qd8te4nvoYq3quJfzCP2XiwFcafFh5aEjiKB7N6M2v3kjhAAKTyCOqA+b7kSlRrntQWnxETWSxSr1FZtHBTqDMb7eZt1xs8DC/ekxHjKLk4fC/6SVHru1/UHfKcQDzR/4sJaNIJeQycS3VK0n++6bGcwOH7+oThd7YQ1D+xM36lAEzFjAymgTGb64QvCkMDA6BEukdXE93FIPXMY9zIJ+kdlZMZyRh/0Gfy3BarBpuTkB3S+3O7aiykz87WvinSOKtQtKVt715Aln4oQfi/r8hAxSbZ59ffIOmq43CVbvUetBocGEvtnQ/577yP+6tSi22
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 16:12:38.9627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd344fae-9bbf-49ca-9907-08debd9d1acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

On Mon, May 18, 2026 at 07:08:01PM +0000, Samiullah Khawaja wrote:
> On Mon, May 18, 2026 at 11:40:58AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
> > > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > 
> > > The core liveupdate mechanism allows userspace to preserve file
> > > descriptors. However, kernel subsystems often manage struct file
> > > objects directly and need to participate in the preservation process
> > > programmatically without relying solely on userspace interaction.
> > > 
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > 

[..]

> > > + *
> > > + * Context: It must be called with session mutex acquired of a restored session.
> > > + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> > > + *         found, or any other negative errno on failure.
> > > + */
> > > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> > > +				 struct file **filep)
> > > +{
> > > +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> > > +				 token, filep);
> > > +}
> > 
> > Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
> > Since, these new APIs are intended for kernel subsystems to participate
> > programmatically, there could be IOMMU drivers (or others) that can be
> > compiled as loadable modules. Thus we should export these APIs via
> > EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module
> > attempting to use them will compile successfully (due to the header), but
> > will fail to load at runtime with an Unknown symbol error.
> > 
> > IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
> > inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
> > during modprobe).
> 
> Agreed. Will Update this.
> 
> I think there are other LUO APIs that are not exported and can be used
> by modules. Let me check those also.

Hi,
+1 to Pranjal's EXPORT_SYMBOL_GPL nit, and I'd like to extend it.
With CONFIG_IOMMUFD=m && CONFIG_IOMMU_LIVEUPDATE=y
the series fails at modpost, not at modprobe — kernel won't even build:

  ERROR: modpost: "memfd_get_seals" [iommufd.ko] undefined!
  ERROR: modpost: "iommu_preserve_device" [iommufd.ko] undefined!
  ERROR: modpost: "iommu_unpreserve_device" [iommufd.ko] undefined!
  ERROR: modpost: "liveupdate_register_file_handler" [iommufd.ko] undefined!
  ERROR: modpost: "liveupdate_get_token_outgoing" [iommufd.ko] undefined!
  ERROR: modpost: "iommufd_liveupdate_register" [iommufd.ko] undefined!
  ERROR: modpost: "iommufd_liveupdate_unregister" [iommufd.ko] undefined!
  ERROR: modpost: "iommufd_hwpt_liveupdate_mark_preserve" [iommufd.ko] undefined!

Two issues:
1) drivers/iommu/iommufd/Makefile (patch 12) builds liveupdate.o into vmlinux
   instead of iommufd.ko — needs to be a composite member, not a top-level obj:
     -obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
     +iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o

   This fixes the iommufd_liveupdate_{register,unregister} and
   iommufd_hwpt_liveupdate_mark_preserve errors above.


2) Beyond the two LUO functions Pranjal mentioned, four more vmlinux symbols
   need EXPORT_SYMBOL_GPL.

Thanks,
Ankit

> > 
> > Thanks,
> > Praan
> > 
> > [1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560
> > 
