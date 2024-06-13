Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86E1494AB
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294743; cv=none; b=ftKk056sFG2V/RvncDtB+mbxiVrbsN0A/tKbslfQKkjML8fKgPvoywV0lYteLZIeQIoqNKQsKWgX76UqUgHIvlLA/iRIR69aG0L4a/cLZlOwnlU2yegyKEt/wNFWrKj9JWmzSeLa/DCuGqF5WzMxbkUGmbH3FGAeOgQynpgz6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294743; c=relaxed/simple;
	bh=SfT29zs6QBEa6BaWfdeJbjpWoEzVmZYFdVB9FaAXock=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UutztC1oSeDvsD9PlyBrvwWUZQXFYQ3f6Q+3rCqH5c7s1z+LV9zyIY+WqIu2NyqGvFPFLS/gvlFlJX7lUtpEHWaibQby0wzW7TukvktJLkmZ9rgBAcqjoizjACp2FgKnotPSx+bTYvmwlQrkxnGI4qAd3phMF/g7l1BiK9XpgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jclkYUpX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jclkYUpX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBApcJ004228;
	Thu, 13 Jun 2024 16:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9+Um0UJ0L8UoKhMe9mg6uGa4NqV4z2eHQnV8zTqRVIU=; b=jclkYUpXAoo348mO
	bKfRBVAvfqlnM4GFFUNjTtHyhKs1w3tOsBXEJO6/EZpX1PWzFFr1lJ6fAZXOCtdf
	hEW6P3AlKbDFWyhWG0p4N2Dk0yXEJtBmnZ69Xb9q0ykb2Jt/wsniGWGE2LWNdxQl
	/JPQaiPBidH931BrVi6JEtk2GpsSDyXoutl++VpIf/FX4MHLVvUfDsINaqZ+aWYN
	vg3Fm2PTdr0T4Ya3EYBE2DpEeBVf1c9j8MeyGJTlRDXvqCUO6aS84suwfLNBbQZF
	y+5dI5n/h0irIXRW8xSdAy8mgZRwbNzkH4Swwbg5jlODDxsT1zSrYTM501i5XUDe
	lWe5aw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqqn323sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:05:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DG5Tkn017149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:05:29 GMT
Received: from [10.110.63.8] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 09:05:25 -0700
Message-ID: <cc180d94-6890-4e92-8080-ffd6c1269e6e@quicinc.com>
Date: Thu, 13 Jun 2024 09:05:18 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: <robh@kernel.org>, <saravanak@google.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kernel@quicinc.com>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
 <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: huaQBIoVpoNOypTOqQiswvhesb47MLDD
X-Proofpoint-ORIG-GUID: huaQBIoVpoNOypTOqQiswvhesb47MLDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130114


On 6/10/2024 2:47 PM, Mark Brown wrote:
> On Mon, Jun 10, 2024 at 02:34:03PM -0700, Nathan Chancellor wrote:
>> On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:
>>> fdt_init_reserved_mem() is also now called from within the
>>> unflatten_device_tree() function so that this step happens after the
>>> page tables have been setup.
>>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
>> bisected to this change in -next as commit a46cccb0ee2d ("of:
>> reserved_mem: Restruture how the reserved memory regions are
>> processed").
> I'm also seeing issues in -next which I bisected to this commit, on the
> original Raspberry Pi the cpufreq driver fails to come up and I see
> (potentially separate?) backtraces:
>
> [    0.100390] ------------[ cut here ]------------
> [    0.100476] WARNING: CPU: 0 PID: 1 at mm/memory.c:2835 __apply_to_page_range+0xd4/0x2c8
> [    0.100637] Modules linked in:
> [    0.100665] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc2-next-20240607 #1
> [    0.100692] Hardware name: BCM2835
> [    0.100705] Call trace: 
> [    0.100727]  unwind_backtrace from show_stack+0x18/0x1c
> [    0.100790]  show_stack from dump_stack_lvl+0x38/0x48
> [    0.100833]  dump_stack_lvl from __warn+0x8c/0xf4
> [    0.100888]  __warn from warn_slowpath_fmt+0x80/0xbc
> [    0.100933]  warn_slowpath_fmt from __apply_to_page_range+0xd4/0x2c8
> [    0.100983]  __apply_to_page_range from apply_to_page_range+0x20/0x28
> [    0.101027]  apply_to_page_range from __dma_remap+0x58/0x88
> [    0.101071]  __dma_remap from __alloc_from_contiguous+0x6c/0xa8
> [    0.101106]  __alloc_from_contiguous from atomic_pool_init+0x9c/0x1c4
> [    0.101169]  atomic_pool_init from do_one_initcall+0x68/0x158
> [    0.101223]  do_one_initcall from kernel_init_freeable+0x1ac/0x1f0
> [    0.101267]  kernel_init_freeable from kernel_init+0x1c/0x140
> [    0.101309]  kernel_init from ret_from_fork+0x14/0x28
> [    0.101344] Exception stack(0xdc80dfb0 to 0xdc80dff8)
> [    0.101369] dfa0:                                     00000000 00000000 00000000 00000000
> [    0.101393] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.101414] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.101428] ---[ end trace 0000000000000000 ]---
>
> Full boot log at:
>
>    https://lava.sirena.org.uk/scheduler/job/374962
>
> You can see the report of cpufreq not being loaded in the log.
>
> NFS boots also fail, apparently due to slowness bringing up a Debian
> userspace which may well be due to cpufreq isues:
Hi Mark & Nathan,

Taking a look at this now and will provide a fix soon if
needed.

At first glance, it looks like there are a couple of WARN_ON*
function calls in __apply_to_page_range(). Please could
you run faddr2line and tell me which of the WARN_ON*
cases we are hitting?

Thank you!

Oreoluwa

