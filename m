Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C334DB46
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541792; cv=fail; b=o8Gu9sKGal3S9vkD7ExhLetpgw+mXPuI3Jp8+SMCMd+MrKl8ERslICzG8ZxgtgZ2hhaQRTYhMpwY+K8lqsXzF+1oLgakbIg7rvpf5BHB3meBMIjIJxKwQ/ZqvQLO+TAkMwoH7ZwbkJZGGFmXaMSPIEL+1FZ3CVJZoYbCCz79PPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541792; c=relaxed/simple;
	bh=pCodvG6Wz12A13NVRhhPJebRAA5/RTiJYfAF1KSdVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KOa09dpXNYhuqJQu7vierArvueHAG15CXBZAdn3iWpi+/JLV4RdlcIvhiy827NX0WBMBtL5IgZ7+uQjwvnIIyyY92QYpLZQq1gzY8v8LZh8CTeb2TB8e9FpzxNA0L38bsn6yRW4LOq0uOI4IOD8vUtI5q+qQru+3AoV+CLiBQRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUJ0gsUK; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUJ0gsUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMTuKIwNI5lBiJkWoibYWYlhas0ClYGMcXIF9kH5Hmv5Tfbr4l/PVySYkDt0FRVx1OrW/bxDjNdgeaDdZG+q4IYbrTjvzKqvmuVfoVJteaI+SnnNKvLfqPuvRAI8OLmbFA0Vfav5WlPW2JYfMDeWq58Qh7LsQRa/Cnvgm+DLm+2iVL+tT+KN7phXknNK1a5UeAmlOQr2pJQCwsaA4Y0ki84NzY9/aJdorYpeu/O4NghSkCBY0Vg7LeoiUuyAjA3otGwWdciHOfpwKPBuWhl+EBxjcyCIOiHILaIMol2SBU7tqq1rb0z2f9BL7pQkow2wHZOLdmeceypa8GCtbuxkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5iFR4fsyGrgG+n9F+f2Xti5Hjq4mMnaXvEfbkaEOvQ=;
 b=hwuyOfgQwfXkLjjq1e7wac1s6P9pUfvvj+jxpMB7WZw9ybNHlGOqQu4kYG53ZlrzcbCdQs2H4p+dGTIX/hFTXMleezl36vt2xPY0uvQ611O4DTpGXdPa8iLPa64kOQPU2ewKwS0+WhekCuXwj2kpc82V26/HNREviYOASCbQVX200SG5f/+uKj3bwnBPIuexm9XFGhXymeyU9cQ/jEIID1BmItlzyyqJ1N30sdCNGWr+M3ePUFkofm0QBICwqsZgY/JASDEyeayk4fh1piqtQeYA+xchpISVoGACS0oP8OLZKvA47q/EQ80hOma513SeWsCO9MT4o7OiP4+tzCRhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5iFR4fsyGrgG+n9F+f2Xti5Hjq4mMnaXvEfbkaEOvQ=;
 b=kUJ0gsUK9WvzakDYopWR/xRzXI7lQeneHkaljdVhsik0s2jJzIW0hvgiQJX15xuyYmMlxsLWGFmdglBIrjOnx5mxBRDzjpu0L37Y1x28dKtZPKhFFXhrRc9X90Wl7oU3njDxv0qgX6n+npgsZsT2bRTCf6yMC11lrjlXcmfj9uMBK4KkQ2MyPuo9YV6WxsKIlLoTxc0vYhEzfrjhaC/l088ykWeq2XiA3RI1xGlJ8PzV9FDqvLUjudztMdCw6GuxKs/qWgrlu6qbTA7kZnGw7oYLvGH+cp65e6Mc1aDuXq5gk54oJstNngfTYZTD8cIujMdA/7d1yhTjDSvO/mBWnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 12:43:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:43:08 +0000
Date: Tue, 3 Mar 2026 08:43:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@amd.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
Message-ID: <20260303124306.GA1002356@nvidia.com>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-5-aik@amd.com>
 <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
 <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
 <20260228002808.GO44359@ziepe.ca>
 <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>
 <20260303001911.GA964116@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303001911.GA964116@ziepe.ca>
X-ClientProxiedBy: MN0P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: d08467d2-aeaa-43cf-aea2-08de79226b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	S8UDisIGYNTZ153bqOv/a8q1fmyVCreXgR0iemvrljTlFrbOOVLHii8+xB1aLx61Z2/oFJCSrugg95rxt5orvQcy7bVwOgco0mdVkwuAewMMUiNIihO0mgq9oK027uxSr6rwTUonPS+aBDlOaB8t9o0TkdpQU3f0jHPnnHn5J3GxMO9X+50KX0snbplM/jk2PznaHUE85u3nZ7cz3vF6up28GPEmMhk5qsa60DYHwxb0f+PsrZETAOqefwKpjXA9DA2e+2OhM7Tja2z8A7wa8IP8Aaqi2Ofch1orN7JoFZIXDoCy98eayJNGfrULYOuQk7Y0RY0t0NMUjQ37NV0XQTOMGZCQ4NFPhzwqtYYuLWmljfcK6x1Mi2Te2WKlVYYPaUhwk9kQV+oCX/b1ndawNCxkFzLnNnSs+OMf5Pjh0DBIsETg4YwIzhVQE+SULxcExv8sjnOqGHIAX9Y33d04PzfmEC870vGS4BaSOmP3UGeeuKPhTquMrwcvhQ5W0QU8UmwtcUr8toBNYfZQ5+7th2rBOPLu3QJS63lfvYxKV6B1trY15PqJWfjh2guRXfEvEyiBSsEkhtF5gmZGLe0Q3sy8MPf17ZN/ESGovmd/66+VCDxyo5qfc54TCIhpfRJpg+1DhqeFQiJaFIyaU+rQzpCjlTh9T2Nh2b9g4vWEKm3f0XB/HvOjo4VHEI229HN/v6ltqESJD/1zpFLD+zt1dw7oWAlGIzvND90lJKQyoYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?heGDnDUWSq3jbI2l52x2C1KRaGVK0rLGbRtNesDDg0NV/mu1KP2vUkUNY3uZ?=
 =?us-ascii?Q?NV9+0eVdEonb5Uu6yIMv/2bCy+kUNYittCwouhEM1yqZHJCqxoSa8qzeGcId?=
 =?us-ascii?Q?t3pMJsuXF4WxA9IiaGzFfVHxtp9gIKVAc07iq+xJOTtb86yN6x2eWW2k9EUO?=
 =?us-ascii?Q?k4B9w057v1hMTWDwyC8TSKWG6y6a4MhtNCfj5cVGZ8TcZrlqZSdrXb3K740O?=
 =?us-ascii?Q?IRiZi/IZpM4cetvXNUxCndxDTubpTxgUHPacNNMTV2pLz1v5SZku/9TDVs86?=
 =?us-ascii?Q?GIQEXRKfjfriiRQFx6/ThFNKP5KoKzjxTNJeF1g1I2ppem1XIKCDfKbdTkZM?=
 =?us-ascii?Q?yC/9Fg+E5T7D2onrWl1/OYvIBn3Hrhs8f5VCNr+dPqRnsGaTK+hG1U/G3IT1?=
 =?us-ascii?Q?MTkWGBdgdl51bO22LQpabhgrpx9Nq06ydhjD0WN/LJ/vSDjv15JGvnK8bG4Z?=
 =?us-ascii?Q?KdkiEZ3ffLLqxq2q9ORCUWaSkxzVxVnFx9W8cplxJjtca6K5bTcyvZCf1cRE?=
 =?us-ascii?Q?q5p6s0GMSUIFto6ZaAPulGNPkJObTTes63inf29UgrJWm7OTZmyPcQLYuBTM?=
 =?us-ascii?Q?Y7IXSAOHdJ3kthtSmteZLt2nqsoDnwzLln3QgzC/9vzVJlXzHqUq2v9paHjf?=
 =?us-ascii?Q?uAyBh97/L6j9WfY/L90+bcaTQ0X4wTTgeZgFk6e4p/dA/3irPqSHQcEGpyVT?=
 =?us-ascii?Q?N6Mlrgw4EmLiui3boKwTiCD8m5RnC8Kk1GoyI98EqGVIq0gIHRElGShnOgpS?=
 =?us-ascii?Q?Zjn0WJosaRpaKNXLSty2411mHu4Z8GCjbqGFei8yjR7/CWlO4zOqeRwO+hVM?=
 =?us-ascii?Q?9vMLO+IIOXeqIvWBpuOpoDTqaiCxYvT/tOVW6PFQC1nQQ6YPBtTcXz+Z+WcL?=
 =?us-ascii?Q?EW03Tv39Fp3VwzsN5PzTNlv+uYtXBpnBW7oS1uO7Y4I1ZpyxgM57bj31DaiI?=
 =?us-ascii?Q?dorUxYJ9eoB7HLGS+uTSJSdx4aD3da6Hh4yVz1QhVh+NAv27kVtptQo1p7JE?=
 =?us-ascii?Q?WkkJJe1eP/tKjR66ynSl/TF7zDBbA4wPeQY/PJ3jNP3bFZSz+u0Cr3NBZo7Z?=
 =?us-ascii?Q?Cu9qg9dQq/yq6BIkwgzL4LWObswQ6wuIEySWQsJsJ60zPdD1VsMC8MjNGEI+?=
 =?us-ascii?Q?bNpd2GFUiA5Ycz0fZalS45YWbUBkV/9xsjExh0eN3dW4/GZypz2kueALff21?=
 =?us-ascii?Q?DD3b/AzJYJ58umPurcSSsx/yQXLGW+fN3CDCmu0bdGcIwsO3LuAR8XwI0UWY?=
 =?us-ascii?Q?5Hinl8fsO0Qw+pnQtDWtK65hiXHViVjdHCkCXb4dMuyyz0EoiBCQuqEjcMYP?=
 =?us-ascii?Q?5EsBdYE/lDj7p1j+M/EI6dsxfSeS8xXtLhuBsojNNZxpuJExgMe9gzdO+Hl8?=
 =?us-ascii?Q?q69hhcCjcN60TZ/6qEbWjuB63aNE7nEZmcEgOvAuVOUk15iuZHjWGXYmD6yS?=
 =?us-ascii?Q?ddFHdttfj3EukmSrMCcHjklik9ZMfT4bJUEGJnjHcXlVCxh3UqcW4E5lv7fv?=
 =?us-ascii?Q?NXlrnnhP214jELDMlva3WIt+drJMOQW7t+n2vxJNc6bSS7pJUPNyRn14vkR/?=
 =?us-ascii?Q?g/0TYZwA5TnArrVuyhC0ifOh7WpcVPz9TLdB1uk60XbmnW/ToLnQ4S4Dl5Pb?=
 =?us-ascii?Q?jK0OH+M5dxIxElg4vxfw80OJxpKCPpquqSdvkX9UJi4oO/2t9LgdYp81S791?=
 =?us-ascii?Q?F4gwblnwDTIKr5r9sFXKIMkevHxu6mPFwYJLCNTknmcJ1f6zsSezWdTh8L4b?=
 =?us-ascii?Q?XC2uSsXw6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08467d2-aeaa-43cf-aea2-08de79226b6d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:43:07.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8GYPKtF+T2T2CmiluHz7+bjCvT/75pRhD0SMzD1Sr4MeXy0tJ1ebOJuw128084j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

On Mon, Mar 02, 2026 at 08:19:11PM -0400, Jason Gunthorpe wrote:
> > Oh, I thought SEV-TIO had trouble with this, if this is indeed the case,
> > great, ignore my first comment.
> 
> Alexey?
> 
> I think it is really important that shared mappings continue to be
> reachable by TDISP device.

I think Alexey has clarified this in the other thread, and probably
AMD has some work to do here.

The issue is AMD does not have seperate address spaces for
shared/private like ARM does, instead it relies on a C bit in the *PTE*
to determine shared/private.

The S2 IOMMU page table *does* have the full mapping of all shared &
private pages but the HW requires a matching C bit to permit access.

If there is a S1 IOMMU then the IOPTEs of the VM can provide the C
bit, so no problem.

If there is no S1 then the sDTE of the hypervisor controls the C bit,
and it sounds like currently AMD sets this globally which effectively
locks TDISP RUN devices to *only* access private memory.

I suspect AMD needs to use their vTOM feature to allow shared memory
to remain available to TDISP RUN with a high/low address split.

Alexey, did I capture this properly?

Jason
