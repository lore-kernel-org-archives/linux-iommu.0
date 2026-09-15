Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F323F4829
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514532; cv=none; b=ktKhlAu8XY1mxF8aIiFsxFYaAgvYJfoN8CIgFAkcLCzfi87hZDlyLPyrv4lK/RWqua+nCuX39USfrTBVHKgxaEebJ1dkw8PkT+KlgG2THDADFn+v7EvzoRtTLcYbGeuETVntZDsSU8cpmgMCHCANWH8pL1da+pLucqBqvfKhlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514532; c=relaxed/simple;
	bh=dTEsVObgRqUWdZPvIxWySL+6nkWC6Ia7ISiB0iANJgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABFUfSlFqFEeYQXiM/VP9DiL89St/ex+mic0CX/8ENc6nzCIiUYGP1LzYqucqvLXZJ4t4a27KDOf1T0lWZQzvShPoG3IAZiZXaRHRuKOaUr9H28ISfyZRP7mrgGZ/eJ2jAeibLs48MGxWncNzXsdwfXxBv/F2zqr/KE8ZMy3kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c1C0ls2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h2IoL+GX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1C0ls2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h2IoL+GX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ1lJ1152477
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=; b=c1C0ls2rJ6H7oNea
	dYoIXwjesL5h2aMoSihGD7oBDL3G+/FU4H0OjwUDFfMUkKJQK2HpJbexUb+QHrk6
	ZsmDdI6h8XLVUcYR0PDLCFFdh57RprE+LnqaxMjjUQm/QRfGBv1bLHVxasx/XYjY
	UobEYpxjy3G8HmwDazQnArrvtm26NFDYlmm9G27XtZ0DnioZcqaBus4sMWoM6TbU
	h8QyR5TOWAwWpi3/UH5DgSMgejaozBCzOXj54Y9hPFFUAfKAc7UPvMARkXcXZ+ca
	Poj4zo7G64BcOP6MnJQzZ3+rsQ1wBLfTTT6UtgGuxi7b8kXOEsRneyvLoHJkL+Mz
	6VgWxQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux4kar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:22:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb92868263so4121252a12.2
        for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514528; x=1790119328; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=;
        b=h2IoL+GX0yDQIgfla9RRhZw9x0IASTgSCpagwiYf2fxp+lQWA770feuJUOvlL+ezQy
         CxBVuEpJCnVQ7XdOSOEAU1+dTp85M0aPxVR998xLujwjsX7TxuFpVaRmWG5Wr1vqf+0Q
         SRrd+PZYU4QHtEafXG7+Cv1fQG0rqw3OfFxH0wpfF265wOBeSG0ZocmrKCGtJ0tXNWT5
         5l2U705typYJ+R9CpeG9cYFcj9mb3DIwFyDq7JLq8hP6KSAfO2RrqCgoFMneTCieukjY
         GF2OicUgdvMukc13WhWLVZ/9gjPSiluwCaoPHwJ1T9Q3/pXfug3Y3WngQSBs94DDcbiO
         Bpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514528; x=1790119328;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=;
        b=wJ3MTMIOMAOPbIZ1PIlOK3zjzWVzpEiwooLX9wHKgDoggjFRaweKgXwzdIY+lolycz
         Rd/4izxlHYnVURRhnolRHAvPIbcrjQ4o22jfVtFs7mBaQ+AHvDUraMmzmh/qJn1Xk28H
         oZHulvYIKJ7LtUAHIXF0zTqidAB32Q/X1rr86vm/3JzoIZuu6I2WAA+5/tjIN4nlwxFP
         nkSWdL3zMDOZbXU0LtLwHTpWlLzZc0dfuhv8h8ThO6T1Sd23rLyM25Ebm1hw09pKn0Qt
         +U0GAn74whRx95Htv6iXtvHggpwpUP2TNoyy0pCLMJaC+Zowb8SVj+jStjQkng/eUtN7
         BtQQ==
X-Forwarded-Encrypted: i=1; AKwUvBynSLwMbzBw6FSsfKtHBvLa96A4apyvTjHA0lXVf7yB5CwCXKr6lIWmv+5mvIk8YL7SGm76OQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lfC4Nz+m2wB5TqG4sITKPS4RdcuxDhFvMi4qs+P77qquUiSzam
	GfeFT0RgtaMpD/We5IXrNAf8Je26UsT+3Z+GVhxxYKL5D4URxHnAhN2uMSoQ+8fSqecmWdEbJJ4
	ogDSXS7DhvJCOb+4RtYAf60BXpHWwrX9Iqdhe+KQ2nMjcxqa/GDX0Krg+vw==
X-Gm-Gg: AYBFou1GJdzpgG7V+s7J6GtYvOumdc1KRYBncKL9KKnbirfkmWuMoyIbudl8uJTebES
	+08SKp2u/uJtSIHg0DKzC/MsB1kjYpp+5cRDWtcYwq1E4/i3rczPTuS4ENmKld+Fsra8VNLeX58
	tr2NesEU9oJ+ljJePNeiMGnremSdZfDo00ieDQLZM1dkdHJRIksCn0nVaXCF8NpyenzpqE5FS9j
	JjG1QMcv+7uqDc85Yd+H+91n9nLzIKprgCWDuFPGEPmw021m+zj1seMNsy/H0cUR5JIGuSjCKTW
	m4243zCK7kr4qdE6cR2j6oe1BL/NxlSGhmhAL+KiuEBuHo9WDQc8CuLNg/Pu4f6QIGa0ut99mvo
	8QBpuhMKmXsogkVr7Oh5Ljf+/gCQ=
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id adf61e73a8af0-3dd5f5d8672mr1167655637.17.1789514528279;
        Tue, 15 Sep 2026 16:22:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id adf61e73a8af0-3dd5f5d8672mr1167615637.17.1789514527903;
        Tue, 15 Sep 2026 16:22:07 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b0520asm2203060eec.27.2026.09.15.16.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:22:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:22:04 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260915162204.000054b9@oss.qualcomm.com>
In-Reply-To: <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX/H0BC0yRxwkZ
 dVwg6+cSYuk6tmXWgdJiuL9WARDUkNM0y/KrLkdYNndW5yFgNOOCFgBoiZibo9/9o979QdIcGPe
 fZiW5tvugHwt37uCJxxy0ILk93FG+3Bt/FNchn0njIKNSBMNT5KY/zrvgNv1dE+W3UgEwejNTnt
 FOCPQD4im9cctMWjB6qfoxqsXRd7ttN3kYHhRs50idrm+bkdDfRPnZldW4srDRbnTnm0Li39/Pp
 ufs04e9HRqlJD7g+dwrheMnnLY4QmqXZK/0BrPDXyp68U/vD2YNkqEsPOk+MzdBU7idV2d5NinA
 qZQQuFYsFldozL1CAQj0TDqZb9/h3xpbGoGonft6pXq9aQCwu9TmOUMZ1XqWEyjbD3TB1y6CmQm
 CPFjLiPBxNyhQ/w9+1cHgrM9ir89VAbiPARHJgk8ovO6JnkbGT7rlNzaw44l69vK0AVDpnX6txt
 0Q8+KlymzySHCc0GkEQ==
X-Proofpoint-ORIG-GUID: oz0Sigm4XaJDbi1ypkOWPY7qGGkD13P9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX0ZCf9eftMPUf
 LrGLmWr7jdrP/8QLz8jlI1HnhzxxUGdJ3wezud203c99qzR8DAvdzbe1lQ3sa16NIDYKY0jUeru
 PS1gUZm+aoPQplAPUVhquYck3x01G9U=
X-Proofpoint-GUID: oz0Sigm4XaJDbi1ypkOWPY7qGGkD13P9
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa9d321 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=h35TsNJSbmzmzvWWgmEA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:22 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
> report it through iommu_report_device_fault().
> 
> For an unknown StreamID or a master without PRI enabled, keep the existing
> LAST-page DENY path. Merge its two messages into one ratelimited line so a
> faulty device cannot flood the kernel log.
> 
> Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
> the DENY fallback both, because a Stop Marker does not expect a response.
> The IOPF infrastructure requires the driver to discard it, as per the doc
> at iommu_report_device_fault(). This also matches the intel-iommu code.
> 
> When SSV is clear, the same LRW encoding is a PRI Page Request that expects
> a response, so let it fall through.
> 
> Note that master->pri_enabled will only be set by a later change, once all
> the PRI paths are ready.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
