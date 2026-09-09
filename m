Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710637F313
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976473; cv=none; b=Z1BZ3JbSqUO36L98ra+R/mirqy+PKu+ExeQUN3dNE3UqZs6ASpSZvya8e5qmWa2RmvR+HRr/ENqiUeSUSBqx9G1sVw4gIvkb7wkKilYSUr8zDdzusAvfma8KBH4yPfHSX58qRcZscYnjwmWXlETDoMzf1wBkxNgK67bSIeNcYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976473; c=relaxed/simple;
	bh=p0zIvrq3rWWMpsFUIdxK1JTUvUraW8LebMqJXUniMZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FebSNsUBDe8cIzpyUeSePSKiZeZboWXG26zb+fV413jsjiBTDiTmSng7T9LWYMzS81Dn8rXjNXi/encpW+UDuG5kSdlbfNEjmZHh0B6+/5pxOKN9F+pIqTeb9+TZ6jyGXUP3i3rpYXPN8+alqIrpaq/YtBCxWeIJhoTUSN5OoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cfSmyUPW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0FH6Iza; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfSmyUPW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0FH6Iza"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7U872771694
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 17:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=; b=cfSmyUPWCvHVtyLu
	rz3IstZAvuTT/9o3NMA2V7wpZlhnhTyDMkensAM702lydzjPUNY/5MnMyBn+m+lU
	4do4aN1R7NvndsOueLhOgi7L9Jqun10CqXzzuVfslinBDtV+HM19c+g/CM5jHlNi
	oz4ZgsYrj3fkko46TF43drgpkXBXLE3MQCE/9H3Ared3JU+EgiveZOx6fOcSEzCt
	tE9Zd1gwdEV7s48UWJ3h34zi4OjNH9HsSn0Dmdd5cf8t9lsPyyDFtfsu/dcTTtsJ
	LfUuBFznsJ86c39+lHrRtGVMtUqpU8E7FgBoIALMcsi4QRbjVbL/Gk73ElfjxzZo
	hv410Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62x9wu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 17:54:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso8704544a12.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976468; x=1789581268; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=;
        b=f0FH6IzaIrHriydjGRo+6qZCjisYLJhdDu5ib+VhQE/ouDuEEb6KvMZL0QzJDrzKVx
         0dvQwI3Q0Pf/dKCtefPHiALFwUZQyk4noNCX/P5JP/OjIq+TkzqJslNPuj0YoEdnJZZK
         jAoQA/qnOxrEvk09IW+1KHu9bLQdvWPW5rPFqzf+g9K1M85Os3pcfjgM+rVEQYpr1qeh
         uSJRWjKG/dDXIPhXF5ckvcTPrIZb9wCLPQqRHAb5V4eXr8xtcCtKO5LzSZWl3XXPN19e
         x5R8KcfQTb03MeuAYgM2BgZfMJv/0fAYoG18fEdBf7oZLG6oTcfnckekua46J2ubpnL9
         B/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976468; x=1789581268;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=;
        b=RUWz2xb2rpl9FBuN0FGvmsIMpUE5HFMF4lHKPJKcmiTjekTYW2xmcZRQuslXkmklKU
         SZGH1ejYKyhGJTi+PiNrOtPJYNMev7NZ1BGMsBG3Oct6ffj6FeblaQDAepto0beOA4tv
         8zq32Duz0eRrglDMtptHOctnki8hVrrmtqUGiNIcA2N3EcWFFgzCBgtGrEBBaAYa+vrD
         4xClkEbpDltA8Ee+EUT4HOvKLBnxWLKOjCa3MS1JubdZe3/VnwRYGj+G+ji9U7xM2b+v
         CwmMnOSlkM9Txp2S/zeV0xD9dmqLTwCm3oFb2b9KVv+O1uk4PPcNbikFkcKOUTgvam6O
         M2Yw==
X-Forwarded-Encrypted: i=1; AKwUvByc1SldspyAqadWjZicNjumqCSrjFcbcNU8Hg1Oakoxm46EPPYnV842T+rzeAK5HE3mKVwjrg==@lists.linux.dev
X-Gm-Message-State: AFuF++mVX8HaHlWCIedoaopakrRhKRDW5Bbs73pl2iGflE9wRovPa9sR
	MSFhrXMa7RWnGYOKxbiorxNJ9FlrwZ1duFCHwjLs7l4DLxn+2DhJzXD0LRrMLH3e2vCINmDPIWF
	yYuwQj4NrhevAaDAa7fYKkwXLsmXdUdz98netKmBJnOJ3ryW4csrrKAKxxg==
X-Gm-Gg: AYBFou14BnHwnfdGM4IuiPrniyn1A5+1mYSzG6N4XdLjF+0V14Rh8G27fgZtNum7COn
	Ty0PLPGXaWS+4tSSdLNnax21VWOlUrls6RMhMaV7J08ENGyvTparQVxybkAZ4xiYXVIffI0UwzV
	fuWaxSDN0gykRE+4o64eVlaIyih4yjeQzYih1+KBsbeZb8C+7B6C6VP4oWOerVosWXk1Dhi4suW
	pw5T3Nr7euhUqO432cc3dNBiYDcwc8fLBRJuimxw2IRTgAGxo4foMZd9MrLzWVUlx63/TXJpHBJ
	laqXZuMBVJN6GTVk2kmqr2zNkIvH5nBMfdBDnEhKnXw0tAc+eWdyDw1GPLER+OlM+/Y18zjrN+d
	mrtd8nJR3N4tiGLB1PujFVQqomHY=
X-Received: by 2002:a05:6a20:2d2c:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3dabb270ed0mr12635094637.21.1788976467480;
        Wed, 09 Sep 2026 10:54:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d2c:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3dabb270ed0mr12635021637.21.1788976466966;
        Wed, 09 Sep 2026 10:54:26 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm72009935eec.15.2026.09.09.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:54:26 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:54:20 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <skaestle@nvidia.com>,
        <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>, <bbiber@nvidia.com>,
        <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Message-ID: <20260909105420.00000abe@oss.qualcomm.com>
In-Reply-To: <apttObDR6jf0rvt+@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
	<178846311317.1308030.4335813024474016483.b4-review@b4>
	<apttObDR6jf0rvt+@nvidia.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5OSBTYWx0ZWRfX5tKrgEzaMstl
 ZtDwzREXiuvWFAMPrQDwjDpYWGDcNLpfCrPUwk+ghdty76SldHzIVTPUM83l1gHnvxU5+4ZnJKa
 bW/QMycNJGX1OifJbHz6mToBdAepsBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5OSBTYWx0ZWRfX80N5VLwG+rYr
 HiU69r6YMXkm4bHUogx5rDAzpTk1PeJRX5LBLrgoe5iImPJr74nZsu9b5j9ZrlcbluhXIOgQrR/
 8mevK2aw13qVXDjJ5/e6wqx/eBg/azHEuXxwmkemIfFG7EQvWCoY5qE0afCur0pBN1Zdqaq8SL0
 2CAqIwyzVoZHk7i+BKbDablKLawLps3DED68JkkCLcLv3+AXlFoTIHNdsz+KspsLBhPl8I/GMhC
 gr+UI+0DrZBntTgIOBUM41qitOELHWuTxiazaXGu4qPcZolfpwP7WqbZQQzj0g62hEBwKpOE/dN
 J+5fNYrk6OohSh+mh5XOp7Ofv5n0EyDhyB4pJAnRXeLCpnE/nTziMjWOlCENFxal2R2lirwzXZ4
 VPiBa3Il7cM0aTgPpLYy29RIYpX5m5vpDbylHi+2JoUy34Q2n5iUh1rcXraFm52dDq+ngE9dE4b
 XNp1HzwtLg1GOzWahww==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa19d54 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ikd4Dj_1AAAA:8 a=9koHXFDKl-DiS4GoSb4A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: H3cKT8bZ0vNfpr9v7Dl6IT-Hkz3FHLrF
X-Proofpoint-GUID: H3cKT8bZ0vNfpr9v7Dl6IT-Hkz3FHLrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090199

On Fri, 4 Sep 2026 18:15:37 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> > > must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> > > 
> > > A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> > > IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. SMMUv3 forbids
> > > the Stall model on PCIe streams (PCIe must use Terminate), and PRI is only  
> > 
> > There are those systems that annoy some because they smell like PCIe
> > (present PCIe software interfaces) but aren't and use stall mode. However, it
> > is nonsense to use PRI with stall mode. So, instead I'd just argue that for
> > stall the fault handling is done synchronously from a device point of
> > view so a PRI request makes no sense rather htan associating this with
> > PCIe as such.  
> 
> I changed the paragraph to:
> 
> A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. Yet, both two
> models are alternatives: a stalling master resolves a fault synchronously,
> holding the transaction until a CMDQ_OP_RESUME, so it has no reason to also
> issue a page request. A later change refuses PRI on a stall_enabled master,
> so the two will never co-occur. arm_smmu_page_response() can therefore key
> on the master state: CMDQ_OP_RESUME for stall_enabled, CMDQ_OP_PRI_RESP for
> pri_enabled, mapping IOMMU_PAGE_RESP_* to the PRI response codes.
> 
Nice.


