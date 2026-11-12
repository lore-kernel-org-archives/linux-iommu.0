Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515813;
	b=z/ZsUXDHoW77POLJ1rexkhXnwQPyeHldJVLk7tMxTveoH0uDmQyyHM3B3NXtIAvB2ZZd
	 7BP8FNv1rCbGkV6BdilrCz92//rXBl7PrcQ0auNnS4YoPNFuxx4RTQy7e6IdUJdbCbQNE
	 uu/ltoCjXUFfuzM4mHkspc49QyvF3e4Z99RepbIwSTsH8DxSAxqBE/3eImIOi9QdGeRuz
	 bwGlerrn+LqYDplRT237c03Tr8/gLc0nbg+5Ph3Lt/Uqd+tabUVaPbW43T//55Wbwngw1
	 SHf1sU4ZzwB8rl8gDoEq5qemYCKYhAEi+ZAo2+u+VTXBijYNmgODbwSmRaaGh4WqVpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515813;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=yS4jNiYhRfGb5QojFYxrTDAoccyphd8P5VhC9esgLP8=;
	b=hbsGjKHf1Hu64gmkwERqthwlNYTbLGhIVnW1yXK5u5MeXhdbuBd1EM73uj4+F53pmD7B
	 rozr0kd5JxEMIeBMrBtG+d1mNa7sGysqYoGA6CrOgKgk9NXIAyJyhbFhdPORrhWHS4GAU
	 fePbBYoJ41FWGwC5OOjdTzRbrJDt/GLEJP7bzz1xC2X46bzt9renLpoeDC9tVsYtzzPXv
	 m7hGSICHB/+x/tUte2txwGMNoH+Prw7OskxZhEufO+DdkZLgwBP59b5hgOfDtpappHnOG
	 mwzEjE+bCCJWSFKwtD/BYvdJGjVEBAgQuB/tTSc9QroiRL0JkK8roO7EXbJ0lfWHdqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PMJdQsUZ;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB9606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 20:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PMJdQsUZ
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJcaXd3548768;
	Thu, 12 Nov 2026 12:35:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=yS4jNiYhRfG
	b5QojFYxrTDAoccyphd8P5VhC9esgLP8=; b=PMJdQsUZ9wFmcb1iynmoB69a2S9
	/l6vcpkudJukcwnCYNVACZN0krn+ykO5/TIt8+EpvIbWXk/Thx5k4vZ5cgmq7W4p
	YSdoLkzwG6uHSIzCdV+IylJorKuexJKBqUwpNz3SZ4B9WPoALoDExWQnCKXWDPRb
	Z5/DS8vaRFuKSuzPHSYrcPHcAb99myPDRsf03Szq3cieanayPemOCovBQW9GdIeV
	9RbFNayyQojAeuUGrtEiXtaos06zx2p1BuqvueNs74kFdqg74AT6KnsJC9/MrARK
	c41Qbapm0737503MSI6RRWeUhYCOy69L1IbLs7qa5UjksU0IawyoORjMH9A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5h7ms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Nov 2026 12:35:41 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 12 Nov 2026 20:35:37 +0000
Date: Thu, 12 Nov 2026 12:35:33 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe
	<jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>,
        Kevin Tian
	<kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>,
        Logan Gunthorpe
	<logang@deltatee.com>, Matt Evans <mattev@meta.com>,
        Matt Evans
	<matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>,
        Samiullah Khawaja
	<skhawaja@google.com>,
        Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Proofpoint-ORIG-GUID: gTZbwHAPJUHvcNcTQXZoaWTbiDqc3U-y
X-Proofpoint-GUID: gTZbwHAPJUHvcNcTQXZoaWTbiDqc3U-y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX8+QGQcJzlVZg
 k4Zo3bVBz7pmfN3Sfd/laKYuJjmFQTltox9bHgb+vFKdRZxfPn2n0Byt7bGXetEoyIWHw2/XxUZ
 RUghY+S0CRIP/9z9WKscp43wNcr8TSs=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af6231d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8
 a=3j4BkbkPAAAA:8 a=qjNXR0RCjIH4vnWDDyQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX2wWt7WUyZDf5
 D7DqzOxzzAGKashRIAA/XPJs2s1+E5sQcsUHgQu8DNi/oAjPAVl+TFoYcfJpmKo1T+SifLgmnGv
 xX0gaGGyBdj3zBqzNmmH3Fd2JXAsfCEBPaGKMBfVskS8la626Xp/5xsN8j14N+BhVitHcuQFAnY
 /j/Hlo5VFXrSGrLA77e8dj3bzmtM7o9GzgI7nxcQFOvkHBp5VB2jhDeyzOtxhG7DsNjj8S9xSJV
 MQ4mjkW2fHOlYI05MAevUaRZ040NaOb9hNIRBhKLWfydQKtRmj56asgGGtHpbJU1G8GkZR5UxQW
 bQY9UIQoU9xJOkxyJhU0roi0DoxJZwWPF6pauZPOYebzxrW256aN69ysBxfjbUieqTqqTSS6C8z
 XUMjB16+VToOfr8zogSJU1k1HQxxg5xUIVI3PTQqSWHTIJIPK5qkJp79XjeEwbm0r/sW+xVS/9w
 FzxCuMNv0O5AhSkJmzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01

Hey David,

On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
 
>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>     target device also bracket the reset with
>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>     VFIO_DEVICE_RESET returns.

There was some discussion about this in the thread below. My understanding of
Jason's point is that the current behavior, and differences between what
revoking and move-capable importers see in regards to vfio-exported dma-buf is
somewhat incidental and not necessarily desirable.

https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/

>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>     currently only matches QEMU's pci-testdev, and
>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>     verify that P2P traffic can flow between two physical endpoints.
> 
>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>     checking P2P reachability from userspace are welcome.

FWIW, you can also exercise the "P2P" path with just a single device if you
IOMMU map a device's BAR into it's own IOAS, and have the device DMA itself. For
eventually validating aspects of Live Update, maybe you don't necessarily care
if an actual peer device is being DMA'd?

Alex 
